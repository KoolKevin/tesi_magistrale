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

  // bello il supporto per scalable vectors (vector<[16]xi32> == 16 x vscale
  // interi con vscale uguale ad una costante hardware (pensa a RVV))
  llvm::Type *resultTy =
      llvm::VectorType::get(llvm::Type::getInt32Ty(ctx), 16, false);
  llvm::Type *ptrTy = llvm::PointerType::get(ctx, 4);
  llvm::FunctionType *funcTy =
      llvm::FunctionType::get(resultTy, {ptrTy}, false);
  // NB: getOrInsertFunction aggiunge la dichiarazione della funzione nel
  // modulo se non esiste già
  llvm::FunctionCallee callee =
      module->getOrInsertFunction("llvm.arc.vvld.w.v512", funcTy);
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

static LogicalResult
convertVecMpyLowAcc(VecMpyLowAccOp &vecMpy, llvm::IRBuilderBase &builder,
                    LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Module *module = builder.GetInsertBlock()->getModule();
  llvm::LLVMContext &ctx = module->getContext();

  // Creiamo una chiamata alla funzione intrinseca:
  // %0 = tail call <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(
  //    <16 x i32> %1, <16x i32> %2)

  llvm::Type *vectorTy =
      llvm::VectorType::get(llvm::Type::getInt32Ty(ctx), 16, false);
  llvm::FunctionType *funcTy =
      llvm::FunctionType::get(vectorTy, {vectorTy, vectorTy}, false);
  llvm::FunctionCallee callee =
      module->getOrInsertFunction("llvm.arc.vvcmpy.lo.acc.w.v512", funcTy);

  llvm::Value *arg1 = moduleTranslation.lookupValue(vecMpy.getArg1());
  llvm::Value *arg2 = moduleTranslation.lookupValue(vecMpy.getArg2());
  llvm::CallInst *call = builder.CreateCall(callee, {arg1, arg2});

  moduleTranslation.mapValue(vecMpy.getRes(), call);

  return success();
}

static LogicalResult
convertVecAddInitAcc(VecAddInitAccOp &vecAddInit, llvm::IRBuilderBase &builder,
                     LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Module *module = builder.GetInsertBlock()->getModule();
  llvm::LLVMContext &ctx = module->getContext();

  // Creiamo una chiamata alla funzione intrinseca:
  // %0 = tail call <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(
  //    <16 x i32> %1, <16x i32> %2)

  llvm::Type *vectorTy =
      llvm::VectorType::get(llvm::Type::getInt32Ty(ctx), 16, false);
  llvm::FunctionType *funcTy =
      llvm::FunctionType::get(vectorTy, {vectorTy, vectorTy}, false);
  llvm::FunctionCallee callee =
      module->getOrInsertFunction("llvm.arc.vvcadd.init.acc.w.v512", funcTy);

  llvm::Value *arg1 = moduleTranslation.lookupValue(vecAddInit.getArg1());
  llvm::Value *arg2 = moduleTranslation.lookupValue(vecAddInit.getArg2());
  llvm::CallInst *call = builder.CreateCall(callee, {arg1, arg2});

  moduleTranslation.mapValue(vecAddInit.getRes(), call);

  return success();
}

static LogicalResult
convertVecMACLow(VecMACLowOp &vecMAC, llvm::IRBuilderBase &builder,
                 LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Module *module = builder.GetInsertBlock()->getModule();
  llvm::LLVMContext &ctx = module->getContext();

  // Creiamo una chiamata alla funzione intrinseca:
  // %35 = tail call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(
  //    <16 x i32> %acc, <16 x i32> %33, <16 x i32> %34)

  llvm::Type *vectorTy =
      llvm::VectorType::get(llvm::Type::getInt32Ty(ctx), 16, false);
  llvm::FunctionType *funcTy =
      llvm::FunctionType::get(vectorTy, {vectorTy, vectorTy, vectorTy}, false);
  llvm::FunctionCallee callee =
      module->getOrInsertFunction("llvm.arc.vvcmac.lo.acc.w.v512", funcTy);

  llvm::Value *acc = moduleTranslation.lookupValue(vecMAC.getAcc());
  llvm::Value *arg1 = moduleTranslation.lookupValue(vecMAC.getArg1());
  llvm::Value *arg2 = moduleTranslation.lookupValue(vecMAC.getArg2());
  llvm::CallInst *call = builder.CreateCall(callee, {acc, arg1, arg2});

  moduleTranslation.mapValue(vecMAC.getRes(), call);

  return success();
}

static LogicalResult
convertVecReduceAdd(VecReduceAddOp &vecReduceAdd, llvm::IRBuilderBase &builder,
                    LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Module *module = builder.GetInsertBlock()->getModule();
  llvm::LLVMContext &ctx = module->getContext();

  // Creiamo una chiamata alla funzione intrinseca:
  // %25 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %rdx73)

  llvm::Type *intTy = llvm::Type::getInt32Ty(ctx);
  llvm::Type *vectorTy = llvm::VectorType::get(intTy, 16, false);
  llvm::FunctionType *funcTy =
      llvm::FunctionType::get(intTy, {vectorTy}, false);
  // NB: qua sto chiamando un intrinseco LLVM e non della ppu; qust'ultimo viene
  // legalizzato in una tree reduction usando istruzioni per la ppu. Non ho
  // trovato un intrinseco singolo che me lo faccia in un colpo solo e quindi
  // faccio così (anche l'autovettorizzatore fa così)
  llvm::FunctionCallee callee =
      module->getOrInsertFunction("llvm.vector.reduce.add.v16i32", funcTy);

  llvm::Value *arg1 = moduleTranslation.lookupValue(vecReduceAdd.getArg1());
  llvm::CallInst *call = builder.CreateCall(callee, {arg1});

  moduleTranslation.mapValue(vecReduceAdd.getRes(), call);

  return success();
}

static LogicalResult
convertAccToVec(AccToVecOp &accToVec, llvm::IRBuilderBase &builder,
                LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Module *module = builder.GetInsertBlock()->getModule();
  llvm::LLVMContext &ctx = module->getContext();

  // Creiamo una chiamata alla funzione intrinseca:
  // %5 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %4)

  llvm::Type *vectorTy =
      llvm::VectorType::get(llvm::Type::getInt32Ty(ctx), 16, false);
  llvm::FunctionType *funcTy =
      llvm::FunctionType::get(vectorTy, {vectorTy}, false);
  llvm::FunctionCallee callee =
      module->getOrInsertFunction("llvm.arc.acc.to.vec.w.v512", funcTy);

  llvm::Value *acc = moduleTranslation.lookupValue(accToVec.getAcc());
  llvm::CallInst *call = builder.CreateCall(callee, {acc});

  moduleTranslation.mapValue(accToVec.getRes(), call);

  return success();
}

namespace {

class PPUDialectLLVMIRTranslationInterface
    : public LLVMTranslationDialectInterface {
public:
  using LLVMTranslationDialectInterface::LLVMTranslationDialectInterface;

  // L'argomento ModuleTranslation mantiene una mappa bidirezionale tra
  // valori/BB/funzioni MLIR e LLVM-IR; viene costruita mano a mano che la
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
          return convertVecLoad(vecLoad, builder, moduleTranslation);
        })
        .Case<VecStoreOp>([&](VecStoreOp vecStore) {
          return convertVecStore(vecStore, builder, moduleTranslation);
        })
        .Case<VecAddOp>([&](VecAddOp vecAdd) {
          return convertVecAdd(vecAdd, builder, moduleTranslation);
        })
        .Case<VecMpyLowAccOp>([&](VecMpyLowAccOp vecMpy) {
          return convertVecMpyLowAcc(vecMpy, builder, moduleTranslation);
        })
        .Case<VecAddInitAccOp>([&](VecAddInitAccOp vecAccInit) {
          return convertVecAddInitAcc(vecAccInit, builder, moduleTranslation);
        })
        .Case<VecMACLowOp>([&](VecMACLowOp vecMAC) {
          return convertVecMACLow(vecMAC, builder, moduleTranslation);
        })
        .Case<VecReduceAddOp>([&](VecReduceAddOp vecReduceAdd) {
          return convertVecReduceAdd(vecReduceAdd, builder, moduleTranslation);
        })
        .Case<AccToVecOp>([&](AccToVecOp accToVec) {
          return convertAccToVec(accToVec, builder, moduleTranslation);
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

// Questo metodo registra una callback che viene eseguita dall'oggetto
// 'TranslateFromMLIRRegistration' in vekt-translate.cpp. La callback aggiunge
// a runtime l'interfaccia che specifica come tradurre il dialetto in llvm-ir.
//
// "This interface is what 'translateModuleToLLVMIR' queries when it walks the
// (ppu) ops and needs to know how to convert them to LLVM IR".
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
