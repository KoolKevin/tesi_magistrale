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

namespace {

LogicalResult convertVecLoad(VecLoadOp &vecLoad, llvm::IRBuilderBase &builder,
                             LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Module *module = builder.GetInsertBlock()->getModule();
  llvm::LLVMContext &ctx = module->getContext();

  // bello il supporto per scalable vectors (vector<[16]xi32> == 16 x vscale
  // interi con vscale uguale ad una costante hardware (pensa a RVV))
  llvm::Type *vecTy =
      llvm::VectorType::get(llvm::Type::getInt32Ty(ctx), 16, false);
  llvm::Type *ptrTy = llvm::PointerType::get(ctx, 4);

  // NB: quando arriviamo a tradurre ppu.vec_load, il suo operando %src è già
  // stato tradotto dalla visita di qualche op precedente e il suo
  // llvm::Value* corrispondente è già in mappa pronto ad essere recuperato
  // tramite lookupValue() per la costruzione della chiamata
  llvm::Value *ptr = moduleTranslation.lookupValue(vecLoad.getSrc());
  if (ptrTy != ptr->getType())
    return vecLoad.emitError("i puntatori usati dalle ppu op devono avere "
                             "come attributo addrspace = 4");

  llvm::Value *load = builder.CreateLoad(vecTy, ptr);

  // aggiungiamo anche il mapping per la chiamata appena creata
  moduleTranslation.mapValue(vecLoad.getRes(), load);

  return success();
}

LogicalResult convertVecStore(VecStoreOp &vecStore,
                              llvm::IRBuilderBase &builder,
                              LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Module *module = builder.GetInsertBlock()->getModule();
  llvm::LLVMContext &ctx = module->getContext();

  llvm::Type *ptrTy = llvm::PointerType::get(ctx, 4);

  llvm::Value *vec = moduleTranslation.lookupValue(vecStore.getVecToStore());
  llvm::Value *ptr = moduleTranslation.lookupValue(vecStore.getDest());
  if (ptrTy != ptr->getType())
    return vecStore.emitError("i puntatori usati dalle ppu op devono avere "
                              "come attributo addrspace = 4");

  builder.CreateStore(vec, ptr);

  return success();
}

LogicalResult convertVecAdd(VecAddOp &vecAdd, llvm::IRBuilderBase &builder,
                            LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Value *arg1 = moduleTranslation.lookupValue(vecAdd.getArg1());
  llvm::Value *arg2 = moduleTranslation.lookupValue(vecAdd.getArg2());

  llvm::Value *add = builder.CreateAdd(arg1, arg2);

  moduleTranslation.mapValue(vecAdd.getRes(), add);

  return success();
}

LogicalResult convertVecMpyLowAcc(VecMpyLowAccOp &vecMpy,
                                  llvm::IRBuilderBase &builder,
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

LogicalResult convertVecAddInitAcc(VecAddInitAccOp &vecAddInit,
                                   llvm::IRBuilderBase &builder,
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

LogicalResult convertVecMACLow(VecMACLowOp &vecMAC,
                               llvm::IRBuilderBase &builder,
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

LogicalResult convertVecReduceAdd(VecReduceAddOp &vecReduceAdd,
                                  llvm::IRBuilderBase &builder,
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

LogicalResult convertAccToVec(AccToVecOp &accToVec,
                              llvm::IRBuilderBase &builder,
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

LogicalResult
convertVecConstantIndex(VecConstantIndexOp &constantIndex,
                        llvm::IRBuilderBase &builder,
                        LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Module *module = builder.GetInsertBlock()->getModule();
  llvm::LLVMContext &ctx = module->getContext();

  // Creiamo una chiamata alla funzione intrinseca:
  // %0 = tail call <16 x i32> @llvm.arc.vvci.w.v512()

  llvm::Type *vectorTy =
      llvm::VectorType::get(llvm::Type::getInt32Ty(ctx), 16, false);
  llvm::FunctionType *funcTy = llvm::FunctionType::get(vectorTy, {}, false);
  llvm::FunctionCallee callee =
      module->getOrInsertFunction("llvm.arc.vvci.w.v512", funcTy);
  llvm::CallInst *call = builder.CreateCall(callee, {});

  moduleTranslation.mapValue(constantIndex.getRes(), call);

  return success();
}

LogicalResult convertVecScatter(VecScatterOp &vecScatter,
                                llvm::IRBuilderBase &builder,
                                LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Module *module = builder.GetInsertBlock()->getModule();
  llvm::LLVMContext &ctx = module->getContext();

  // Creiamo una chiamata alla funzione intrinseca:
  //  -> tail call void @llvm.arc.vscatter.int.v512(
  //        ptr addrspace(4) %basePtr, <16 x i32> %offsets, <16 x i32> %values)

  llvm::Type *voidTy = llvm::Type::getVoidTy(ctx);
  llvm::Type *vectorTy =
      llvm::VectorType::get(llvm::Type::getInt32Ty(ctx), 16, false);
  llvm::Type *ptrTy = llvm::PointerType::get(ctx, 4);
  llvm::FunctionType *funcTy =
      llvm::FunctionType::get(voidTy, {ptrTy, vectorTy, vectorTy}, false);
  llvm::FunctionCallee callee =
      module->getOrInsertFunction("llvm.arc.vscatter.int.v512", funcTy);

  llvm::Value *ptr = moduleTranslation.lookupValue(vecScatter.getDest());
  llvm::Value *offsets = moduleTranslation.lookupValue(vecScatter.getOffsets());
  llvm::Value *values = moduleTranslation.lookupValue(vecScatter.getValues());
  if (ptrTy != ptr->getType())
    return vecScatter.emitError("i puntatori usati dalle ppu op devono avere "
                                "come attributo addrspace = 4");

  builder.CreateCall(callee, {ptr, offsets, values});

  return success();
}

LogicalResult convertVecGather(VecGatherOp &vecGather,
                               llvm::IRBuilderBase &builder,
                               LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Module *module = builder.GetInsertBlock()->getModule();
  llvm::LLVMContext &ctx = module->getContext();

  // Creiamo una chiamata alla funzione intrinseca:
  //  -> %4 = call <16 x i32> @llvm.arc.vgather.int.v512(
  //          ptr addrspace(4) %basePtr, <16 x i32> %offsets)

  llvm::Type *vecTy =
      llvm::VectorType::get(llvm::Type::getInt32Ty(ctx), 16, false);
  llvm::Type *ptrTy = llvm::PointerType::get(ctx, 4);
  llvm::FunctionType *funcTy =
      llvm::FunctionType::get(vecTy, {ptrTy, vecTy}, false);
  llvm::FunctionCallee callee =
      module->getOrInsertFunction("llvm.arc.vgather.int.v512", funcTy);

  llvm::Value *ptr = moduleTranslation.lookupValue(vecGather.getSrc());
  if (ptrTy != ptr->getType())
    return vecGather.emitError("i puntatori usati dalle ppu op devono avere "
                               "come attributo addrspace = 4");
  llvm::Value *offsets = moduleTranslation.lookupValue(vecGather.getOffsets());

  llvm::CallInst *call = builder.CreateCall(callee, {ptr, offsets});
  moduleTranslation.mapValue(vecGather.getRes(), call);

  return success();
}

LogicalResult convertVecMax(VecMaxOp &vecMax, llvm::IRBuilderBase &builder,
                            LLVM::ModuleTranslation &moduleTranslation) {

  llvm::Module *module = builder.GetInsertBlock()->getModule();
  llvm::LLVMContext &ctx = module->getContext();

  // Creiamo una chiamata alla funzione intrinseca:
  // %5 = tail call <16 x i32> @llvm.arc.vvcmax.acc.w.v512(
  //    <16 x i32> %max_acc, <16 x i32> %4)

  llvm::Type *vectorTy =
      llvm::VectorType::get(llvm::Type::getInt32Ty(ctx), 16, false);
  llvm::FunctionType *funcTy =
      llvm::FunctionType::get(vectorTy, {vectorTy, vectorTy}, false);
  llvm::FunctionCallee callee =
      module->getOrInsertFunction("llvm.arc.vvcmax.acc.w.v512", funcTy);

  llvm::Value *arg1 = moduleTranslation.lookupValue(vecMax.getArg1());
  llvm::Value *arg2 = moduleTranslation.lookupValue(vecMax.getArg2());
  llvm::CallInst *call = builder.CreateCall(callee, {arg1, arg2});

  moduleTranslation.mapValue(vecMax.getRes(), call);

  return success();
}

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
        .Case<VecConstantIndexOp>([&](VecConstantIndexOp constantIndex) {
          return convertVecConstantIndex(constantIndex, builder,
                                         moduleTranslation);
        })
        .Case<VecScatterOp>([&](VecScatterOp scatterOp) {
          return convertVecScatter(scatterOp, builder, moduleTranslation);
        })
        .Case<VecGatherOp>([&](VecGatherOp gatherOp) {
          return convertVecGather(gatherOp, builder, moduleTranslation);
        })
        .Case<VecMaxOp>([&](VecMaxOp maxOp) {
          return convertVecMax(maxOp, builder, moduleTranslation);
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
// a l'interfaccia che specifica come tradurre il dialetto in llvm-ir quando
// quest'ultimo viene caricato nel contesto(/registry?).
//
// "This interface is what 'translateModuleToLLVMIR' queries when it walks the
// (ppu) ops and needs to know how to convert them to LLVM IR".
//
// NB: nel toy tutorial ho visto che le interfacce si aggiungono così ai
// dialetti:
//
// void ToyDialect::initialize() {
//   addInterfaces<ToyInlinerInterface>();
// }
//
// Qua però è stato utilizzato il meccanismo delle dialectExtension: "quando il
// dialetto passato come argomento viene caricato nel contesto, esegui questa
// lambda"
//
// La differenza è marginale ma interessante; con il meccanismo delle estensioni
// la registrazione dell'interfaccia è esterna alla definizione del dialetto.
//
// This is useful when:
// - you don't own the dialect / you don't want or can't modify the dialect's
// source;
// - the interface belongs to an optional integration (come la traduzione ad
// llvm-ir);
// - you want to keep a dependency out of the core dialect.
//
// For example, LLVM-IR translation is a very natural use case. Non è detto che
// chi utilizza un dialetto voglia necessariamente tradurre verso LLVM-IR,
// magari gli interessa solo SPIR-V. In questo caso aggiungerebbe solamente
// l'estensione per SPIR-V eliminando la dipendenza dall'interfaccia per la
// traduzione verso LLVM-IR
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
