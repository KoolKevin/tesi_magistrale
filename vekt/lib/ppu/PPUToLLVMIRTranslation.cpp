// imitato da:
// - .../lib/target/LLVMIR/Dialect/LLVMIR/LLVMToLLVMIRTranslation.cpp

#include "ppu/PPUToLLVMIRTranslation.h"
#include "ppu/PPUDialect.h"
#include "ppu/PPUOps.h"

#include "mlir/IR/Operation.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Target/LLVMIR/ModuleTranslation.h"
#include "llvm/ADT/TypeSwitch.h"

#include "llvm/IR/IRBuilder.h"

using namespace mlir;
using namespace mlir::ppu;

static LogicalResult
convertVecLoad(VecLoadOp &vecLoad, llvm::IRBuilderBase &builder,
               LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Module *module = builder.GetInsertBlock()->getModule();
  llvm::LLVMContext &ctx = module->getContext();

  // Creiamo una chiamata alla funzione intrinseca:
  //  -> %13 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %12)

  // TODO: guarda meglio che cos'è uno scalable vector
  llvm::Type *resultTy =
      llvm::VectorType::get(llvm::Type::getInt32Ty(ctx), 16, false);
  llvm::Type *ptrTy = llvm::PointerType::get(ctx, 4);
  llvm::FunctionType *funcTy =
      llvm::FunctionType::get(resultTy, {ptrTy}, false);
  // NB: getOrInsertFunction aggiunge la dichiarazione della funzione nel
  // modulo se non esiste già
  llvm::FunctionCallee callee =
      module->getOrInsertFunction("llvm.arc.vvld.w.v512", funcTy);
  // ppu.vec_load può accettare sia una memref che un llvm.ptr.  Una memref
  // dovrebbe essere già stata lowerata prima di arrivare qua dato che non è
  // traducibile direttamente.
  if (isa<MemRefType>(vecLoad.getSrc().getType())) {
    return vecLoad.emitError(
        "l'argomento di ppu.vec_load deve essere lowerato a "
        "llvm.ptr prima della traduzione");
  }
  // NB: quando arriviamo a tradurre ppu.vec_load, il suo operando %src è già
  // stato tradotto dalla visita di qualche op precedente e il suo
  // llvm::Value* corrispondente è già in mappa pronto ad essere recuperato
  // tramite lookupValue() per la costruzione della chiamata
  llvm::Value *ptr = moduleTranslation.lookupValue(vecLoad.getSrc());
  if (ptrTy != ptr->getType())
    return vecLoad.emitError("i puntatori usati dalle ppu op devono avere "
                             "come attributo addrspace = 4");

  llvm::CallInst *call = builder.CreateCall(callee, {ptr});
  // aggiungiamo anche il mapping per la chiamata appena creata
  moduleTranslation.mapValue(vecLoad.getRes(), call);
  return success();
}

static LogicalResult
convertVecStore(VecStoreOp &vecStore, llvm::IRBuilderBase &builder,
                LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Module *module = builder.GetInsertBlock()->getModule();
  llvm::LLVMContext &ctx = module->getContext();

  // Creiamo una chiamata alla funzione intrinseca:
  //  -> call void @llvm.arc.vvst.w.v512(<16 x i32> %23, ptr addrspace(4) %24)

  llvm::Type *voidTy = llvm::Type::getVoidTy(ctx);
  llvm::Type *vectorTy =
      llvm::VectorType::get(llvm::Type::getInt32Ty(ctx), 16, false);
  llvm::Type *ptrTy = llvm::PointerType::get(ctx, 4);
  llvm::FunctionType *funcTy =
      llvm::FunctionType::get(voidTy, {vectorTy, ptrTy}, false);
  llvm::FunctionCallee callee =
      module->getOrInsertFunction("llvm.arc.vvst.w.v512", funcTy);
  if (isa<MemRefType>(vecStore.getDest().getType()))
    return vecStore.emitError(
        "l'argomento dest di ppu.vec_store deve essere lowerato a "
        "llvm.ptr prima della traduzione");

  llvm::Value *vec = moduleTranslation.lookupValue(vecStore.getVecToStore());
  llvm::Value *ptr = moduleTranslation.lookupValue(vecStore.getDest());
  if (ptrTy != ptr->getType())
    return vecStore.emitError("i puntatori usati dalle ppu op devono avere "
                              "come attributo addrspace = 4");

  builder.CreateCall(callee, {vec, ptr});

  return success();
}

static LogicalResult convertVecAdd(VecAddOp &vecAdd,
                                   llvm::IRBuilderBase &builder,
                                   LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Module *module = builder.GetInsertBlock()->getModule();
  llvm::LLVMContext &ctx = module->getContext();

  // Creiamo una chiamata alla funzione intrinseca:
  // %18 = call <16xi32> @llvm.arc.vvadd.w.v512(<16xi32> %16, <16xi32> %17)

  llvm::Type *vectorTy =
      llvm::VectorType::get(llvm::Type::getInt32Ty(ctx), 16, false);
  llvm::FunctionType *funcTy =
      llvm::FunctionType::get(vectorTy, {vectorTy, vectorTy}, false);
  llvm::FunctionCallee callee =
      module->getOrInsertFunction("llvm.arc.vvadd.w.v512", funcTy);

  llvm::Value *arg1 = moduleTranslation.lookupValue(vecAdd.getArg1());
  llvm::Value *arg2 = moduleTranslation.lookupValue(vecAdd.getArg2());
  llvm::CallInst *call = builder.CreateCall(callee, {arg1, arg2});

  moduleTranslation.mapValue(vecAdd.getRes(), call);

  return success();
}

namespace {

class PPUDialectLLVMIRTranslationInterface
    : public LLVMTranslationDialectInterface {
public:
  using LLVMTranslationDialectInterface::LLVMTranslationDialectInterface;

  // L'argomento ModuleTranslation mantiene una mappa bidirezionale tra
  // valori/BB/funzioni MLIR e LLVM-IR, costruita mano a mano che la
  // traduzione procede. Quando 'translateModuleToLLVMIR' (la funzione chiamata
  // in vekt-translate.cpp per esportare llvm dialect in llvm-ir) visita le op,
  // ogni op tradotta registra i suoi risultati nella mappa. Questa mappa è
  // utile, ad esempio, per recuperare la versione tradotta degli argomenti
  // della op da tradurre correntemente
  LogicalResult
  convertOperation(Operation *op, llvm::IRBuilderBase &builder,
                   LLVM::ModuleTranslation &moduleTranslation) const final {

    return TypeSwitch<Operation *, LogicalResult>(op)
        .Case<VecLoadOp>([&](VecLoadOp vecLoad) {
          // ... la tua implementazione attuale
          return convertVecLoad(vecLoad, builder, moduleTranslation);
        })
        .Case<VecStoreOp>([&](VecStoreOp vecStore) {
          // ...
          return convertVecStore(vecStore, builder, moduleTranslation);
        })
        .Case<VecAddOp>([&](VecAddOp vecAdd) {
          // ...
          return convertVecAdd(vecAdd, builder, moduleTranslation);
        })
        .Default([](Operation *op) {
          return op->emitError(
              "op PPU non supportata nella traduzione LLVM IR");
        });
  }

  // NB: amendOperation non sembra che serva
  // TODO: capisci meglio il ruolo di amendOperation
};

} // namespace

// Questo metodo registra una callback che viene eseguita quando il dialetto
// specificato viene caricato nel contesto della traduzione. La callback
// aggiunge A RUNTIME (strano) l'interfaccia che specifica come tradurre il
// dialetto in llvm-ir.
// "This interface is what 'translateModuleToLLVMIR' queries when it walks the
// ops and needs to know how to convert them to LLVM IR".
void mlir::registerPPUDialectTranslation(DialectRegistry &registry) {
  registry.addExtension(+[](MLIRContext *ctx, PPUDialect *dialect) {
    dialect->addInterfaces<PPUDialectLLVMIRTranslationInterface>();
  });
}

void mlir::registerPPUDialectTranslation(MLIRContext &context) {
  DialectRegistry registry;
  registerPPUDialectTranslation(registry);
  context.appendDialectRegistry(registry);
}
