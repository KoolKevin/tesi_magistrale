// imitato da:
// - .../lib/target/LLVMIR/Dialect/LLVMIR/LLVMToLLVMIRTranslation.cpp

#include "ppu/PPUToLLVMIRTranslation.h"
#include "ppu/PPUDialect.h"
#include "ppu/PPUOps.h"

#include "mlir/IR/Operation.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Target/LLVMIR/ModuleTranslation.h"

#include "llvm/IR/IRBuilder.h"

using namespace mlir;
using namespace mlir::ppu;

static LogicalResult
convertPPUOperation(Operation &op, llvm::IRBuilderBase &builder,
                    LLVM::ModuleTranslation &moduleTranslation) {

  if (auto vecLoad = dyn_cast<VecLoadOp>(op)) {
    llvm::Module *module = builder.GetInsertBlock()->getModule();
    llvm::LLVMContext &ctx = module->getContext();

    // Creiamo una chiamata alla funzione intrinseca:
    //  -> %13 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %12)

    // TODO: guarda meglio che cos'è uno scalable vector
    llvm::Type *resultTy =
        llvm::VectorType::get(llvm::Type::getInt32Ty(ctx), 16, false);

    // TODO: i puntatori utilizzati dai ppu intrinsics dovrebbero fare
    // riferimento all'address space 4 (vccm). Per adesso creo un puntatore
    // normale dato che non ho voglia di modificare la mia ir di test.
    // Dovrei farlo e aggiungere anche un assert che controlla questo attributo
    // quando faccio lookupValue(vecLoad.getSrc())
    // llvm::Type *ptrTy = llvm::PointerType::get(ctx, 4);
    llvm::Type *ptrTy = llvm::PointerType::get(ctx, 0);

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
      return op.emitError("l'argomento di ppu.vec_load deve essere lowerato a "
                          "llvm.ptr prima della traduzione");
    }
    // NB: quando arriviamo a tradurre ppu.vec_load, il suo operando %src è già
    // stato tradotto dalla visita di qualche op precedente e il suo
    // llvm::Value* corrispondente è già in mappa pronto ad essere recuperato
    // tramite lookupValue() per la costruzione della chiamata
    llvm::Value *ptr = moduleTranslation.lookupValue(vecLoad.getSrc());
    llvm::CallInst *call = builder.CreateCall(callee, {ptr});

    moduleTranslation.mapValue(vecLoad.getResult(), call);
    return success();
  }

  // se arrivi qui, l'op non è gestita -> traduzione fallit
  return failure();
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
    return convertPPUOperation(*op, builder, moduleTranslation);
  }

  // NB: amendOperation non sembra che serva
  // TODO: capisci meglio il ruolo di amendOperation
};

} // namespace

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
