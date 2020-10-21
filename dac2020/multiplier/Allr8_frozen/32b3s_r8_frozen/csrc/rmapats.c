#include <stdio.h>
#include <stdlib.h>
#include "rmapats.h"

typedef unsigned char UB;
typedef unsigned char scalar;
typedef unsigned short US;
#ifndef __DO_RMAHDR_
typedef unsigned int U;
#endif
#if defined(__sparcv9) || defined(__LP64__) || defined(_LP64) || defined(__ia64)
typedef unsigned long UP;
typedef unsigned long RP;
#else
typedef unsigned int UP;
typedef unsigned int RP;
#endif
typedef void (*FP)(void* pcode, scalar val);
typedef void (*FPV)(void* pcode, void* pval);
typedef void (*FP1)(void *);
typedef void (*FPLSEL)(void *, scalar, U);
typedef void (*FPLSELV)(void *, void*, U, U);

#ifdef __cplusplus
  extern "C" {
#endif

#if (_MSC_VER >= 900)
#define RMA_UL unsigned __int64
#else
#define RMA_UL long long unsigned
#endif
typedef union {
    double dummy;
#if defined(__GNUC__) || defined(__STDC__) || defined(__alpha) ||  \
    defined(_AIX) || (_MSC_VER >= 900) || defined(__sony_news) || defined(__cplusplus)
    RMA_UL clockL;
#endif
    unsigned int  clock_hl[2];
} rma_clock_struct;

typedef struct {
        RP pnext;
}RmaDbsLoad;

#define RmaTcCoreCommon   \
                RP pts;   \
                RP pdata; \
                U limit:30, \
                  floaded:1, \
                  fskew:1 

typedef struct {
        RP pnext;
        RmaTcCoreCommon;
}RmaTcCoreSimple;

typedef struct {
        RP pnext;
        RmaTcCoreCommon;
        RP ptscond;
}RmaTcCoreConditional;

typedef struct {
        RmaTcCoreCommon;
}RmaTcCoreSimpleNoList;

typedef struct { 
        RmaTcCoreCommon;
        RP ptscond;
}RmaTcCoreConditionalNoList;

#define RmaTSLoadCommon \
        RP pcondval; \
        U tscond;    \
        scalar condval

typedef struct {
        RmaTSLoadCommon;
}RmaConditionalTSLoadNoList;

typedef struct {
        RP pnext;
        RmaTSLoadCommon;
}RmaConditionalTSLoad;

typedef struct { 
        void* daiCbkList;
        void* aliasIp;
        U     aliasQsymId;
 } RmaDaiCg;

typedef struct { 
        void* vecCbkList;
 } RmaRootCbkCg;

typedef struct { 
        U vrpId;
 } RmaRootVcdCg;

typedef struct { 
        RP forceCbkList;
 } RmaRootForceCbkCg;

typedef struct { 
        EBLK eblk;
        RP pval;
        vec32 sv32;
 } RmaAnySchedVCg;

typedef struct { 
        EBLK eblk;
        RP pval;
        vec32 sv[1];
 } RmaAnySchedWCg;

typedef struct { 
        EBLK eblk;
        RP pval;
        scalar sascalar[1];
 } RmaAnySchedECg;

extern scalar Xunion[], Xwor[], Xwand[], Xvalchg[];
extern scalar X3val[], X4val[], XcvtstrTR[], Xbuf[], Xbitnot[],Xwor[], Xwand[];
extern void *memcpy(void* s1, void* s2, unsigned n);
extern void *mempcpy(void* s1, void* s2, unsigned n);
extern int memcmp(void* s1, void* s2, unsigned n);
extern scalar globalTable1Input[];
extern RP rmaSchedFunctionArr[];
extern unsigned long long vcs_clocks;
extern UB gHsimDumpScalVal;
extern UB gHsimPliScalVal;
extern U fCallbackHsimNode;
extern U fVcdDumpHsimNode;
extern U fVpdDumpHsimNode;
extern U fRTFrcRelCbk;
extern UB* rmaEvalDelays(UB* pcode, scalar val);
extern void rmaPopTransEvent(UB* pcode);
extern void (*txpFnPtr)(UB* pcode, U);
extern void (*propForceCbkSPostSchedCgFnPtr)(void* ip);
extern void (*propForceCbkMemoptSPostSchedCgFnPtr)(void* ip);
extern void rmaSetupFuncArray(UP* ra);
extern void SinitHsimPats(void);
extern void VVrpDaicb(void* ip, U nIndex);
extern int SDaicb(void *ip, U nIndex);
extern void SDaicbForHsimNoFlagScalar(void* pDaiCb, unsigned char value);
extern void SDaicbForHsimNoFlagStrengthScalar(void* pDaiCb, unsigned char value);
extern void SDaicbForHsimNoFlag(void* pRmaDaiCg, unsigned char value);
extern void SDaicbForHsimNoFlag2(void* pRmaDaiCg, unsigned char value);
extern void SDaicbForHsimWithFlag(void* pRmaDaiCg, unsigned char value);
extern void SDaicbForHsimNoFlagFrcRel(void* pRmaDaiCg, unsigned char reason, int msb, int lsb, int ndx);
extern void SDaicbForHsimNoFlagFrcRel2(void* pRmaDaiCg, unsigned char reason, int msb, int lsb, int ndx);
extern void VcsHsimValueChangeCB(void* pRmaDaiCg, void* pValue, unsigned int valueFormat);
extern U isNonDesignNodeCallbackList(void* pRmaDaiCg);
extern void SDaicbForHsimCbkMemOptNoFlagScalar(void* pDaiCb, unsigned char value, unsigned char isStrength);
extern void SDaicbForHsimCbkMemOptWithFlagScalar(void* pDaiCb, unsigned char value, unsigned char isStrength);
extern void SDaicbForHsimCbkMemOptNoFlagScalar(void* pDaiCb, unsigned char value, unsigned char isStrength);
extern void SDaicbForHsimCbkMemOptWithFlagScalar(void* pDaiCb, unsigned char value, unsigned char isStrength);
extern void VVrpNonEventNonRegdScalarForHsimOptCbkMemopt(void* ip, U nIndex);
extern void SDaicbForHsimCbkMemOptNoFlagDynElabScalar(U* mem, unsigned char value, unsigned char isStrength);
extern void SDaicbForHsimCbkMemOptWithFlagDynElabScalar(U* mem, unsigned char value, unsigned char isStrength);
extern void SDaicbForHsimCbkMemOptNoFlagDynElabFrcRel(U* mem, unsigned char reason, int msb, int lsb, int ndx);
extern void SDaicbForHsimCbkMemOptNoFlagFrcRel(void* pDaiCb, unsigned char reason, int msb, int lsb, int ndx);
extern void hsimDispatchCbkMemOptForVcd(RP p, U val);
extern void* hsimGetCbkMemOptCallback(RP p);
extern void hsimDispatchCbkMemOptNoDynElabS(RP p, U val, U isStrength);
extern void* hsimGetCbkPtrNoDynElab(RP p);
extern void hsimDispatchCbkMemOptDynElabS(U** pvcdarr, U** pcbkarr, U val, U isStrength);
extern void hsimDispatchCbkMemOptNoDynElabVector(RP /*RmaDaiOptCg* */p, void* pval, U /*RmaValueType*/ vt, U cbits);
extern void copyAndPropRootCbkCgS(RmaRootCbkCg* pRootCbk, scalar val);
extern void copyAndPropRootCbkCgV(RmaRootCbkCg* rootCbk, vec32* pval);
extern void copyAndPropRootCbkCgW(RmaRootCbkCg* rootCbk, vec32* pval);
extern void copyAndPropRootCbkCgE(RmaRootCbkCg* rootCbk, scalar* pval);
extern void dumpRootVcdCg(RmaRootVcdCg* pRootVcd, scalar val);
extern void checkAndConvertVec32To2State(vec32* value, vec32* svalue, U cbits, U* pforcedBits);
extern void (*rmaPostAnySchedFnPtr)(EBLK* peblk);
extern void (*rmaPostAnySchedVFnPtr)(RmaAnySchedVCg* psched);
extern void (*rmaPostAnySchedWFnPtr)(RmaAnySchedWCg* psched);
extern void (*rmaPostAnySchedEFnPtr)(RmaAnySchedECg* psched);
extern void (*rmaPostSchedUpdateClockStatusFnPtr)(EBLK* peblk);
extern unsigned int fGblDataOrTime0Prop;
extern void SchedSemiLerMP1(UB* pmps, U partId);
extern void hsUpdateModpathTimeStamp(UB* pmps);
extern void doMpd32One(UB* pmps);
extern void SchedSemiLerMP(UB* ppulse, U partId);
extern void scheduleuna(UB *e, U t);
extern void scheduleuna_mp(EBLK *e, unsigned t);
extern void schedule(UB *e, U t);
extern void sched_hsopt(struct dummyq_struct * pQ, EBLK *e, U t);
extern void sched_millenium(struct dummyq_struct * pQ, EBLK *e, U thigh, U t);
extern void schedule_1(EBLK *e);
extern void sched0(UB *e);
extern void sched0lq(UB *e);
extern void sched0una(UB *e);
extern void sched0una_th(struct dummyq_struct *pq, UB *e);
extern void scheduleuna_mp_th(struct dummyq_struct *pq, EBLK *e, unsigned t);
extern void schedal(UB *e);
extern void sched0_th(struct dummyq_struct * pQ, UB *e);
extern void sched0_hsim_front_th(struct dummyq_struct * pQ, UB *e);
extern void sched0_hsim_frontlq_th(struct dummyq_struct * pQ, UB *e);
extern void sched0lq_th(struct dummyq_struct * pQ, UB *e);
extern void schedal_th(struct dummyq_struct * pQ, UB *e);
extern void scheduleuna_th(struct dummyq_struct * pQ, UB *e, U t);
extern void schedule_th(struct dummyq_struct * pQ, UB *e, U t);
extern void schedule_1_th(struct dummyq_struct * pQ, EBLK *peblk);
extern void SetupLER_th(struct dummyq_struct * pQ, UB *e);
extern void SchedSemiLer_th(struct dummyq_struct * pQ, EBLK *e);
extern U getVcdFlags(UB *ip);
extern void VVrpNonEventNonRegdScalarForHsimOpt(void* ip, U nIndex);
extern void VVrpNonEventNonRegdScalarForHsimOpt2(void* ip, U nIndex);
extern void SchedSemiLerTBReactiveRegion(struct eblk* peblk);
extern void SchedSemiLerTBReactiveRegion_th(struct eblk* peblk, U partId);
extern void SchedSemiLerTr(UB* peblk, U partId);
extern void appendNtcEvent(UB* phdr, scalar s, U schedDelta);
extern void hsimRegisterEdge(void* sm,  scalar s);
extern U pvcsGetPartId();
extern void HsimPVCSPartIdCheck(U instNo);
extern void debug_func(U partId, struct dummyq_struct* pQ, EBLK* EblkLastEventx); 
extern struct dummyq_struct* pvcsGetQ(U thid);
extern EBLK* pvcsGetLastEventEblk(U thid);
extern void insertTransEvent(RmaTransEventHdr* phdr, scalar s, scalar pv,	scalar resval, U schedDelta, int re, UB* predd, U fpdd);
extern void insertNtcEventRF(RmaTransEventHdr* phdr, scalar s, scalar pv, scalar resval, U schedDelta, U* delays);
extern U doTimingViolation(U ts,RP* pdata, U fskew, U limit, U floaded);
extern int getCurSchedRegion();
extern FP getRoutPtr(RP, U);
extern U rmaChangeCheckAndUpdateE(scalar* pvalDst, scalar* pvalSrc, U cbits);
extern void rmaUpdateE(scalar* pvalDst, scalar* pvalSrc, U cbits);
extern U rmaChangeCheckAndUpdateEFromW(scalar* pvalDst, vec32* pvalSrc, U cbits);
extern void rmaLhsPartSelUpdateE(scalar* pvalDst, scalar* pvalSrc, U index, U width);
extern void rmaUpdateWithForceSelectorE(scalar* pvalDst, scalar* pvalSrc, U cbits, U* pforceSelector);
extern void rmaUpdateWFromE(vec32* pvalDst, scalar* pvalSrc, U cbits);
extern U rmaLhsPartSelWithChangeCheckE(scalar* pvalDst, scalar* pvalSrc, U index, U width);
extern void rmaLhsPartSelWFromE(vec32* pvalDst, scalar* pvalSrc, U index,U width);
extern U rmaChangeCheckAndUpdateW(vec32* pvalDst, vec32* pvalSrc, U cbits);
extern void rmaUpdateW(vec32* pvalDst, vec32* pvalSrc, U cbits);
extern void rmaUpdateEFromW(scalar* pvalDst, vec32* pvalSrc, U cbits);
extern U rmaLhsPartSelWithChangeCheckW(vec32* pvalDst, vec32* pvalSrc, U index,U width);
extern void rmaLhsPartSelEFromW(scalar* pvalDst, vec32* pvalSrc, U index,U width);
extern void rmaLhsPartSelUpdateW(vec32* pvalDst, vec32* pvalSrc, U index, U width);
extern void rmaEvalWunionW(vec32* dst, vec32* src, U cbits, U count);
extern void rmaEvalWorW(vec32* dst, vec32* src, U cbits, U count);
extern void rmaEvalWandW(vec32* dst, vec32* src, U cbits, U count);
extern void rmaEvalUnionE(scalar* dst, scalar* src, U cbits, U count, RP ptable);
extern RmaIbfPcode* rmaEvalPartSelectsW(vec32* pvec32, U startIndex, U onWidth, U offWidth, U count, RmaIbfPcode* pibfPcode);
extern RmaIbfPcode* rmaEvalPartSelectsEToE(scalar* pv, U startIndex, U onWidth, U offWidth, U count, RmaIbfPcode* pibfPcode);
extern RmaIbfPcode* rmaEvalPartSelectsEToW(scalar* pv, U startIndex, U onWidth, U offWidth, U count, RmaIbfPcode* pibfPcode);
extern U VcsForceVecVCg(UB* pcode, UB* pval, UB* pvDst, UB* pvCur, U fullcbits, U ibeginSrc, U ibeginDst, U width, U/*RmaValueConvType*/ convtype, U/*RmaForceType*/ frcType, UB* prhs, UB* prhsDst, U frhs, U* pforcedbits, U fisRoot);
extern U VcsReleaseVecVCg(UB* pcode, UB* pvDst, U fullcbits, U ibeginDst, U width, UB* prhsDst, U frhs, U* pforcedbits, U fisRoot);
extern U VcsDriveBitsAndDoChangeCheckV(vec32* pvSel, vec32* pvCur, U fullcbits, U forcedbits, U isRoot);
extern void cgvecDebug_Eblk(UB* pcode);
#ifdef __cplusplus
  }
#endif
scalar dummyScalar;
scalar fScalarIsForced=0;
scalar fScalarIsReleased=0;
scalar fScalarHasChanged=0;
extern int curSchedRegion;
extern RP* iparr;
extern int fNotimingchecks;
typedef struct red_t {
	U reject;
	U error;
	U delay;
} RED;
typedef struct predd {
	U type;
	RED delays[1];
} PREDD;
#define HASH_BIT 0xfff
#define TransStE 255

#ifdef __cplusplus
extern "C" {
#endif
void  rmaPropagate41(UB  * pcode, scalar  val);
void  rmaPropagate43(UB  * pcode, scalar  val);
void  rmaPropagate43f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate43r(UB  * pcode);
void  rmaPropagate44(UB  * pcode, scalar  val);
void  rmaPropagate44f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate44r(UB  * pcode);
void  rmaPropagate45(UB  * pcode, scalar  val);
void  rmaPropagate45f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate45r(UB  * pcode);
void  rmaPropagate46(UB  * pcode, scalar  val);
void  rmaPropagate46f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate46r(UB  * pcode);
void  rmaPropagate47(UB  * pcode, scalar  val);
void  rmaPropagate47f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate47r(UB  * pcode);
void  rmaPropagate48(UB  * pcode, scalar  val);
void  rmaPropagate48f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate48r(UB  * pcode);
void  rmaPropagate49(UB  * pcode, scalar  val);
void  rmaPropagate50(UB  * pcode, scalar  val);
void  rmaPropagate50f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate50r(UB  * pcode);
void  rmaPropagate51(UB  * pcode, scalar  val);
void  rmaPropagate51f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate51r(UB  * pcode);
void  rmaPropagate59(UB  * pcode, scalar  val);
void  rmaPropagate59f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate59r(UB  * pcode);
void  rmaPropagate60(UB  * pcode, scalar  val);
void  rmaPropagate60f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate60r(UB  * pcode);
void  rmaPropagate61(UB  * pcode, scalar  val);
void  rmaPropagate61f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate61r(UB  * pcode);
void  rmaPropagate62(UB  * pcode, scalar  val);
void  rmaPropagate62f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate62r(UB  * pcode);
void  rmaPropagate63(UB  * pcode, scalar  val);
void  rmaPropagate63f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate63r(UB  * pcode);
void  rmaPropagate64(UB  * pcode, scalar  val);
void  rmaPropagate64f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate64r(UB  * pcode);
void  rmaPropagate65(UB  * pcode, scalar  val);
void  rmaPropagate65f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate65r(UB  * pcode);
void  rmaPropagate66(UB  * pcode, scalar  val);
void  rmaPropagate66f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate66r(UB  * pcode);
void  rmaPropagate67(UB  * pcode, scalar  val);
void  rmaPropagate67f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate67r(UB  * pcode);
void  rmaPropagate68(UB  * pcode, scalar  val);
void  rmaPropagate68f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate68r(UB  * pcode);
void  rmaPropagate69(UB  * pcode, scalar  val);
void  rmaPropagate69f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate69r(UB  * pcode);
void  rmaPropagate70(UB  * pcode, scalar  val);
void  rmaPropagate70f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate70r(UB  * pcode);
void  rmaPropagate71(UB  * pcode, scalar  val);
void  rmaPropagate71f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate71r(UB  * pcode);
void  rmaPropagate72(UB  * pcode, scalar  val);
void  rmaPropagate72f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate72r(UB  * pcode);
void  rmaPropagate73(UB  * pcode, scalar  val);
void  rmaPropagate73f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate73r(UB  * pcode);
void  rmaPropagate74(UB  * pcode, scalar  val);
void  rmaPropagate74f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate74r(UB  * pcode);
void  rmaPropagate75(UB  * pcode, scalar  val);
void  rmaPropagate75f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate75r(UB  * pcode);
void  rmaPropagate76(UB  * pcode, scalar  val);
void  rmaPropagate76f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate76r(UB  * pcode);
void  rmaPropagate77(UB  * pcode, scalar  val);
void  rmaPropagate77f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate77r(UB  * pcode);
void  rmaPropagate78(UB  * pcode, scalar  val);
void  rmaPropagate78f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate78r(UB  * pcode);
void  rmaPropagate79(UB  * pcode, scalar  val);
void  rmaPropagate79f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate79r(UB  * pcode);
void  rmaPropagate80(UB  * pcode, scalar  val);
void  rmaPropagate80f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate80r(UB  * pcode);
void  rmaPropagate81(UB  * pcode, scalar  val);
void  rmaPropagate81f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate81r(UB  * pcode);
void  rmaPropagate82(UB  * pcode, scalar  val);
void  rmaPropagate82f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate82r(UB  * pcode);
void  rmaPropagate83(UB  * pcode, scalar  val);
void  rmaPropagate83f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate83r(UB  * pcode);
void  rmaPropagate84(UB  * pcode, scalar  val);
void  rmaPropagate84f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate84r(UB  * pcode);
void  rmaPropagate85(UB  * pcode, scalar  val);
void  rmaPropagate85f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate85r(UB  * pcode);
void  rmaPropagate86(UB  * pcode, scalar  val);
void  rmaPropagate86f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate86r(UB  * pcode);
void  rmaPropagate87(UB  * pcode, scalar  val);
void  rmaPropagate87f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate87r(UB  * pcode);
void  rmaPropagate88(UB  * pcode, scalar  val);
void  rmaPropagate88f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate88r(UB  * pcode);
void  rmaPropagate89(UB  * pcode, scalar  val);
void  rmaPropagate89f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate89r(UB  * pcode);
void  rmaPropagate90(UB  * pcode, scalar  val);
void  rmaPropagate90f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate90r(UB  * pcode);
void  rmaPropagate91(UB  * pcode, scalar  val);
void  rmaPropagate91f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate91r(UB  * pcode);
void  rmaPropagate92(UB  * pcode, scalar  val);
void  rmaPropagate92f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate92r(UB  * pcode);
void  rmaPropagate93(UB  * pcode, scalar  val);
void  rmaPropagate93f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate93r(UB  * pcode);
void  rmaPropagate94(UB  * pcode, scalar  val);
void  rmaPropagate94f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate94r(UB  * pcode);
void  rmaPropagate95(UB  * pcode, scalar  val);
void  rmaPropagate95f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate95r(UB  * pcode);
void  rmaPropagate96(UB  * pcode, scalar  val);
void  rmaPropagate96f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate96r(UB  * pcode);
void  rmaPropagate97(UB  * pcode, scalar  val);
void  rmaPropagate97f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate97r(UB  * pcode);
void  rmaPropagate98(UB  * pcode, scalar  val);
void  rmaPropagate98f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate98r(UB  * pcode);
void  rmaPropagate99(UB  * pcode, scalar  val);
void  rmaPropagate99f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate99r(UB  * pcode);
void  rmaPropagate100(UB  * pcode, scalar  val);
void  rmaPropagate100f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate100r(UB  * pcode);
void  rmaPropagate101(UB  * pcode, scalar  val);
void  rmaPropagate101f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate101r(UB  * pcode);
void  rmaPropagate102(UB  * pcode, scalar  val);
void  rmaPropagate102f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate102r(UB  * pcode);
void  rmaPropagate103(UB  * pcode, scalar  val);
void  rmaPropagate103f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate103r(UB  * pcode);
void  rmaPropagate104(UB  * pcode, scalar  val);
void  rmaPropagate104f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate104r(UB  * pcode);
void  rmaPropagate105(UB  * pcode, scalar  val);
void  rmaPropagate105f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate105r(UB  * pcode);
void  rmaPropagate105t0(UB  * pcode, UB  val);
void  rmaPropagate106(UB  * pcode, scalar  val);
void  rmaPropagate106f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate106r(UB  * pcode);
void  rmaPropagate107(UB  * pcode, scalar  val);
void  rmaPropagate107f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate107r(UB  * pcode);
void  rmaPropagate108(UB  * pcode, scalar  val);
void  rmaPropagate108f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate108r(UB  * pcode);
void  rmaPropagate109(UB  * pcode, scalar  val);
void  rmaPropagate109f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate109r(UB  * pcode);
void  rmaPropagate110(UB  * pcode, scalar  val);
void  rmaPropagate110f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate110r(UB  * pcode);
void  rmaPropagate111(UB  * pcode, scalar  val);
void  rmaPropagate111f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate111r(UB  * pcode);
void  rmaPropagate112(UB  * pcode, scalar  val);
void  rmaPropagate112f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate112r(UB  * pcode);
void  rmaPropagate113(UB  * pcode, scalar  val);
void  rmaPropagate113f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate113r(UB  * pcode);
void  rmaPropagate114(UB  * pcode, scalar  val);
void  rmaPropagate114f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate114r(UB  * pcode);
void  rmaPropagate115(UB  * pcode, scalar  val);
void  rmaPropagate115f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate115r(UB  * pcode);
void  rmaPropagate116(UB  * pcode, scalar  val);
void  rmaPropagate116f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate116r(UB  * pcode);
void  rmaPropagate117(UB  * pcode, scalar  val);
void  rmaPropagate117f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate117r(UB  * pcode);
void  rmaPropagate118(UB  * pcode, scalar  val);
void  rmaPropagate118f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate118r(UB  * pcode);
void  rmaPropagate119(UB  * pcode, scalar  val);
void  rmaPropagate119f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate119r(UB  * pcode);
void  rmaPropagate120(UB  * pcode, scalar  val);
void  rmaPropagate120f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate120r(UB  * pcode);
void  rmaPropagate121(UB  * pcode, scalar  val);
void  rmaPropagate121f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate121r(UB  * pcode);
void  rmaPropagate122(UB  * pcode, scalar  val);
void  rmaPropagate122f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate122r(UB  * pcode);
void  rmaPropagate123(UB  * pcode, scalar  val);
void  rmaPropagate123f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate123r(UB  * pcode);
void  rmaPropagate124(UB  * pcode, scalar  val);
void  rmaPropagate124f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate124r(UB  * pcode);
void  rmaPropagate125(UB  * pcode, scalar  val);
void  rmaPropagate125f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate125r(UB  * pcode);
void  rmaPropagate126(UB  * pcode, scalar  val);
void  rmaPropagate126f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate126r(UB  * pcode);
void  rmaPropagate127(UB  * pcode, scalar  val);
void  rmaPropagate127f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate127r(UB  * pcode);
void  rmaPropagate128(UB  * pcode, scalar  val);
void  rmaPropagate128f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate128r(UB  * pcode);
void  rmaPropagate129(UB  * pcode, scalar  val);
void  rmaPropagate129f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate129r(UB  * pcode);
void  rmaPropagate130(UB  * pcode, scalar  val);
void  rmaPropagate130f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate130r(UB  * pcode);
void  rmaPropagate131(UB  * pcode, scalar  val);
void  rmaPropagate131f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate131r(UB  * pcode);
void  rmaPropagate132(UB  * pcode, scalar  val);
void  rmaPropagate132f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate132r(UB  * pcode);
void  rmaPropagate133(UB  * pcode, scalar  val);
void  rmaPropagate133f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate133r(UB  * pcode);
void  rmaPropagate134(UB  * pcode, scalar  val);
void  rmaPropagate134f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate134r(UB  * pcode);
void  rmaPropagate135(UB  * pcode, scalar  val);
void  rmaPropagate135f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate135r(UB  * pcode);
void  rmaPropagate136(UB  * pcode, scalar  val);
void  rmaPropagate136f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate136r(UB  * pcode);
void  rmaPropagate137(UB  * pcode, scalar  val);
void  rmaPropagate137f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate137r(UB  * pcode);
void  rmaPropagate138(UB  * pcode, scalar  val);
void  rmaPropagate138f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate138r(UB  * pcode);
void  rmaPropagate139(UB  * pcode, scalar  val);
void  rmaPropagate139f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate139r(UB  * pcode);
void  rmaPropagate140(UB  * pcode, scalar  val);
void  rmaPropagate140f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate140r(UB  * pcode);
void  rmaPropagate141(UB  * pcode, scalar  val);
void  rmaPropagate141f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate141r(UB  * pcode);
void  rmaPropagate142(UB  * pcode, scalar  val);
void  rmaPropagate142f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate142r(UB  * pcode);
void  rmaPropagate143(UB  * pcode, scalar  val);
void  rmaPropagate143f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate143r(UB  * pcode);
void  rmaPropagate144(UB  * pcode, scalar  val);
void  rmaPropagate144f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate144r(UB  * pcode);
void  rmaPropagate145(UB  * pcode, scalar  val);
void  rmaPropagate145f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate145r(UB  * pcode);
void  rmaPropagate146(UB  * pcode, scalar  val);
void  rmaPropagate146f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate146r(UB  * pcode);
void  rmaPropagate147(UB  * pcode, scalar  val);
void  rmaPropagate147f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate147r(UB  * pcode);
void  rmaPropagate148(UB  * pcode, scalar  val);
void  rmaPropagate148f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate148r(UB  * pcode);
void  rmaPropagate149(UB  * pcode, scalar  val);
void  rmaPropagate149f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate149r(UB  * pcode);
void  rmaPropagate149t0(UB  * pcode, UB  val);
void  rmaPropagate150(UB  * pcode, scalar  val);
void  rmaPropagate150f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate150r(UB  * pcode);
void  rmaPropagate150t0(UB  * pcode, UB  val);
void  rmaPropagate151(UB  * pcode, scalar  val);
void  rmaPropagate151f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate151r(UB  * pcode);
void  rmaPropagate151t0(UB  * pcode, UB  val);
void  rmaPropagate152(UB  * pcode, scalar  val);
void  rmaPropagate152f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate152r(UB  * pcode);
void  rmaPropagate152t0(UB  * pcode, UB  val);
void  rmaPropagate153(UB  * pcode, scalar  val);
void  rmaPropagate153f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate153r(UB  * pcode);
void  rmaPropagate153t0(UB  * pcode, UB  val);
void  rmaPropagate154(UB  * pcode, scalar  val);
void  rmaPropagate154f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate154r(UB  * pcode);
void  rmaPropagate154t0(UB  * pcode, UB  val);
void  rmaPropagate155(UB  * pcode, scalar  val);
void  rmaPropagate155f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate155r(UB  * pcode);
void  rmaPropagate155t0(UB  * pcode, UB  val);
void  rmaPropagate156(UB  * pcode, scalar  val);
void  rmaPropagate156f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate156r(UB  * pcode);
void  rmaPropagate157(UB  * pcode, scalar  val);
void  rmaPropagate157f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate157r(UB  * pcode);
void  rmaPropagate157t0(UB  * pcode, UB  val);
void  rmaPropagate158(UB  * pcode, scalar  val);
void  rmaPropagate158f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate158r(UB  * pcode);
void  rmaPropagate158t0(UB  * pcode, UB  val);
void  rmaPropagate159(UB  * pcode, scalar  val);
void  rmaPropagate159f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate159r(UB  * pcode);
void  rmaPropagate160(UB  * pcode, scalar  val);
void  rmaPropagate160f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate160r(UB  * pcode);
void  rmaPropagate160t0(UB  * pcode, UB  val);
void  rmaPropagate161(UB  * pcode, scalar  val);
void  rmaPropagate161f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate161r(UB  * pcode);
void  rmaPropagate162(UB  * pcode, scalar  val);
void  rmaPropagate162f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate162r(UB  * pcode);
void  rmaPropagate162t0(UB  * pcode, UB  val);
void  rmaPropagate163(UB  * pcode, scalar  val);
void  rmaPropagate163f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate163r(UB  * pcode);
void  rmaPropagate163t0(UB  * pcode, UB  val);
void  rmaPropagate164(UB  * pcode, scalar  val);
void  rmaPropagate164f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate164r(UB  * pcode);
void  rmaPropagate164t0(UB  * pcode, UB  val);
void  rmaPropagate165(UB  * pcode, scalar  val);
void  rmaPropagate165f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate165r(UB  * pcode);
void  rmaPropagate165t0(UB  * pcode, UB  val);
void  rmaPropagate166(UB  * pcode, scalar  val);
void  rmaPropagate166f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate166r(UB  * pcode);
void  rmaPropagate167(UB  * pcode, scalar  val);
void  rmaPropagate167f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate167r(UB  * pcode);
void  rmaPropagate167t0(UB  * pcode, UB  val);
void  rmaPropagate168(UB  * pcode, scalar  val);
void  rmaPropagate168f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate168r(UB  * pcode);
void  rmaPropagate168t0(UB  * pcode, UB  val);
void  rmaPropagate169(UB  * pcode, scalar  val);
void  rmaPropagate169f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate169r(UB  * pcode);
void  rmaPropagate170(UB  * pcode, scalar  val);
void  rmaPropagate170f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate170r(UB  * pcode);
void  rmaPropagate170t0(UB  * pcode, UB  val);
void  rmaPropagate171(UB  * pcode, scalar  val);
void  rmaPropagate171f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate171r(UB  * pcode);
void  rmaPropagate171t0(UB  * pcode, UB  val);
void  rmaPropagate172(UB  * pcode, scalar  val);
void  rmaPropagate172f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate172r(UB  * pcode);
void  rmaPropagate173(UB  * pcode, scalar  val);
void  rmaPropagate173t0(UB  * pcode, UB  val);
void  rmaPropagate174(UB  * pcode, scalar  val);
void  rmaPropagate174f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate174r(UB  * pcode);
void  rmaPropagate174t0(UB  * pcode, UB  val);
void  rmaPropagate175(UB  * pcode, scalar  val);
void  rmaPropagate175f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate175r(UB  * pcode);
void  rmaPropagate176(UB  * pcode, scalar  val);
void  rmaPropagate176f(UB  * pcode, scalar  val, U  frhs, scalar  * prhs);
void  rmaPropagate176r(UB  * pcode);
void  rmaPropagate176t0(UB  * pcode, UB  val);
void  schedNewEvent(struct dummyq_struct * pQ, EBLK  * peblk, U  delay);
#ifdef __cplusplus
}
#endif
void  schedNewEvent(struct dummyq_struct * pQ, EBLK  * peblk, U  delay);
void  schedNewEvent(struct dummyq_struct * pQ, EBLK  * peblk, U  delay)
{
    U  abs_t;
    U  thigh_abs;
    U  hash_index;
    struct futq * pfutq;
    abs_t = ((U )vcs_clocks) + delay;
    hash_index = abs_t & 0xfff;
    peblk->peblkFlink = (EBLK  *)(-1);
    peblk->t = abs_t;
    if (abs_t < (U )vcs_clocks) {
        thigh_abs = ((U  *)&vcs_clocks)[1];
        sched_millenium(pQ, peblk, thigh_abs + 1, abs_t);
    }
    else if ((pfutq = pQ->hashtab[hash_index].tfutq)) {
        peblk->peblkPrv = pfutq->peblkTail;
        pfutq->peblkTail->peblkFlink = peblk;
        pfutq->peblkTail = peblk;
    }
    else {
        sched_hsopt(pQ, peblk, abs_t);
    }
}
#ifdef __cplusplus
extern "C" {
#endif
void SinitHsimPats(void);
#ifdef __cplusplus
}
#endif
