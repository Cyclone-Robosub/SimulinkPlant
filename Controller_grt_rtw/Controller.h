/*
 * Controller.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "Controller".
 *
 * Model version              : 1.63
 * Simulink Coder version : 24.2 (R2024b) 21-Jun-2024
 * C source code generated on : Sun Apr  6 12:26:30 2025
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objective: Debugging
 * Validation result: Not run
 */

#ifndef Controller_h_
#define Controller_h_
#ifndef Controller_COMMON_INCLUDES_
#define Controller_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "rt_logging.h"
#include "rt_nonfinite.h"
#include "math.h"
#endif                                 /* Controller_COMMON_INCLUDES_ */

#include "Controller_types.h"
#include "rtGetNaN.h"
#include <float.h>
#include <string.h>
#include <stddef.h>

/* Macros for accessing real-time model data structure */
#ifndef rtmGetContStateDisabled
#define rtmGetContStateDisabled(rtm)   ((rtm)->contStateDisabled)
#endif

#ifndef rtmSetContStateDisabled
#define rtmSetContStateDisabled(rtm, val) ((rtm)->contStateDisabled = (val))
#endif

#ifndef rtmGetContStates
#define rtmGetContStates(rtm)          ((rtm)->contStates)
#endif

#ifndef rtmSetContStates
#define rtmSetContStates(rtm, val)     ((rtm)->contStates = (val))
#endif

#ifndef rtmGetContTimeOutputInconsistentWithStateAtMajorStepFlag
#define rtmGetContTimeOutputInconsistentWithStateAtMajorStepFlag(rtm) ((rtm)->CTOutputIncnstWithState)
#endif

#ifndef rtmSetContTimeOutputInconsistentWithStateAtMajorStepFlag
#define rtmSetContTimeOutputInconsistentWithStateAtMajorStepFlag(rtm, val) ((rtm)->CTOutputIncnstWithState = (val))
#endif

#ifndef rtmGetDerivCacheNeedsReset
#define rtmGetDerivCacheNeedsReset(rtm) ((rtm)->derivCacheNeedsReset)
#endif

#ifndef rtmSetDerivCacheNeedsReset
#define rtmSetDerivCacheNeedsReset(rtm, val) ((rtm)->derivCacheNeedsReset = (val))
#endif

#ifndef rtmGetFinalTime
#define rtmGetFinalTime(rtm)           ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetIntgData
#define rtmGetIntgData(rtm)            ((rtm)->intgData)
#endif

#ifndef rtmSetIntgData
#define rtmSetIntgData(rtm, val)       ((rtm)->intgData = (val))
#endif

#ifndef rtmGetOdeF
#define rtmGetOdeF(rtm)                ((rtm)->odeF)
#endif

#ifndef rtmSetOdeF
#define rtmSetOdeF(rtm, val)           ((rtm)->odeF = (val))
#endif

#ifndef rtmGetOdeY
#define rtmGetOdeY(rtm)                ((rtm)->odeY)
#endif

#ifndef rtmSetOdeY
#define rtmSetOdeY(rtm, val)           ((rtm)->odeY = (val))
#endif

#ifndef rtmGetPeriodicContStateIndices
#define rtmGetPeriodicContStateIndices(rtm) ((rtm)->periodicContStateIndices)
#endif

#ifndef rtmSetPeriodicContStateIndices
#define rtmSetPeriodicContStateIndices(rtm, val) ((rtm)->periodicContStateIndices = (val))
#endif

#ifndef rtmGetPeriodicContStateRanges
#define rtmGetPeriodicContStateRanges(rtm) ((rtm)->periodicContStateRanges)
#endif

#ifndef rtmSetPeriodicContStateRanges
#define rtmSetPeriodicContStateRanges(rtm, val) ((rtm)->periodicContStateRanges = (val))
#endif

#ifndef rtmGetRTWLogInfo
#define rtmGetRTWLogInfo(rtm)          ((rtm)->rtwLogInfo)
#endif

#ifndef rtmGetZCCacheNeedsReset
#define rtmGetZCCacheNeedsReset(rtm)   ((rtm)->zCCacheNeedsReset)
#endif

#ifndef rtmSetZCCacheNeedsReset
#define rtmSetZCCacheNeedsReset(rtm, val) ((rtm)->zCCacheNeedsReset = (val))
#endif

#ifndef rtmGetdX
#define rtmGetdX(rtm)                  ((rtm)->derivs)
#endif

#ifndef rtmSetdX
#define rtmSetdX(rtm, val)             ((rtm)->derivs = (val))
#endif

#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
#define rtmGetStopRequested(rtm)       ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
#define rtmSetStopRequested(rtm, val)  ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
#define rtmGetStopRequestedPtr(rtm)    (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
#define rtmGetT(rtm)                   (rtmGetTPtr((rtm))[0])
#endif

#ifndef rtmGetTFinal
#define rtmGetTFinal(rtm)              ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
#define rtmGetTPtr(rtm)                ((rtm)->Timing.t)
#endif

#ifndef rtmGetTStart
#define rtmGetTStart(rtm)              ((rtm)->Timing.tStart)
#endif

/* Block signals (default storage) */
typedef struct {
  real_T ProportionalGain;             /* '<S48>/Proportional Gain' */
  real_T Integrator;                   /* '<S43>/Integrator' */
  real_T DerivativeGain;               /* '<S36>/Derivative Gain' */
  real_T Filter;                       /* '<S38>/Filter' */
  real_T SumD;                         /* '<S38>/SumD' */
  real_T FilterCoefficient;            /* '<S46>/Filter Coefficient' */
  real_T Sum;                          /* '<S52>/Sum' */
  real_T ProportionalGain_c;           /* '<S100>/Proportional Gain' */
  real_T Integrator_f;                 /* '<S95>/Integrator' */
  real_T DerivativeGain_j;             /* '<S88>/Derivative Gain' */
  real_T Filter_e;                     /* '<S90>/Filter' */
  real_T SumD_f;                       /* '<S90>/SumD' */
  real_T FilterCoefficient_d;          /* '<S98>/Filter Coefficient' */
  real_T Sum_d;                        /* '<S104>/Sum' */
  real_T ProportionalGain_h;           /* '<S152>/Proportional Gain' */
  real_T Integrator_c;                 /* '<S147>/Integrator' */
  real_T DerivativeGain_d;             /* '<S140>/Derivative Gain' */
  real_T Filter_m;                     /* '<S142>/Filter' */
  real_T SumD_i;                       /* '<S142>/SumD' */
  real_T FilterCoefficient_g;          /* '<S150>/Filter Coefficient' */
  real_T Sum_a;                        /* '<S156>/Sum' */
  real_T ProportionalGain_b;           /* '<S204>/Proportional Gain' */
  real_T Integrator_h;                 /* '<S199>/Integrator' */
  real_T DerivativeGain_p;             /* '<S192>/Derivative Gain' */
  real_T Filter_l;                     /* '<S194>/Filter' */
  real_T SumD_m;                       /* '<S194>/SumD' */
  real_T FilterCoefficient_p;          /* '<S202>/Filter Coefficient' */
  real_T Sum_b;                        /* '<S208>/Sum' */
  real_T ProportionalGain_f;           /* '<S256>/Proportional Gain' */
  real_T Integrator_e;                 /* '<S251>/Integrator' */
  real_T DerivativeGain_i;             /* '<S244>/Derivative Gain' */
  real_T Filter_d;                     /* '<S246>/Filter' */
  real_T SumD_g;                       /* '<S246>/SumD' */
  real_T FilterCoefficient_m;          /* '<S254>/Filter Coefficient' */
  real_T Sum_p;                        /* '<S260>/Sum' */
  real_T ProportionalGain_d;           /* '<S308>/Proportional Gain' */
  real_T Integrator_hu;                /* '<S303>/Integrator' */
  real_T DerivativeGain_m;             /* '<S296>/Derivative Gain' */
  real_T Filter_d2;                    /* '<S298>/Filter' */
  real_T SumD_n;                       /* '<S298>/SumD' */
  real_T FilterCoefficient_j;          /* '<S306>/Filter Coefficient' */
  real_T Sum_c;                        /* '<S312>/Sum' */
  real_T Gain[8];                      /* '<S1>/Gain' */
  real_T Sum1[8];                      /* '<S1>/Sum1' */
  real_T Saturation[8];                /* '<S1>/Saturation' */
  real_T Transpose[8];                 /* '<S1>/Transpose' */
  real_T IntegralGain;                 /* '<S40>/Integral Gain' */
  real_T IntegralGain_k;               /* '<S92>/Integral Gain' */
  real_T IntegralGain_g;               /* '<S144>/Integral Gain' */
  real_T IntegralGain_ku;              /* '<S196>/Integral Gain' */
  real_T IntegralGain_a;               /* '<S248>/Integral Gain' */
  real_T IntegralGain_l;               /* '<S300>/Integral Gain' */
  real_T TmpSignalConversionAtSFunctionI[6];/* '<S1>/MATLAB Function' */
  real_T u[8];                         /* '<S1>/MATLAB Function' */
} B_Controller_T;

/* Continuous states (default storage) */
typedef struct {
  real_T Integrator_CSTATE;            /* '<S43>/Integrator' */
  real_T Filter_CSTATE;                /* '<S38>/Filter' */
  real_T Integrator_CSTATE_m;          /* '<S95>/Integrator' */
  real_T Filter_CSTATE_i;              /* '<S90>/Filter' */
  real_T Integrator_CSTATE_j;          /* '<S147>/Integrator' */
  real_T Filter_CSTATE_e;              /* '<S142>/Filter' */
  real_T Integrator_CSTATE_k;          /* '<S199>/Integrator' */
  real_T Filter_CSTATE_j;              /* '<S194>/Filter' */
  real_T Integrator_CSTATE_p;          /* '<S251>/Integrator' */
  real_T Filter_CSTATE_o;              /* '<S246>/Filter' */
  real_T Integrator_CSTATE_h;          /* '<S303>/Integrator' */
  real_T Filter_CSTATE_a;              /* '<S298>/Filter' */
} X_Controller_T;

/* State derivatives (default storage) */
typedef struct {
  real_T Integrator_CSTATE;            /* '<S43>/Integrator' */
  real_T Filter_CSTATE;                /* '<S38>/Filter' */
  real_T Integrator_CSTATE_m;          /* '<S95>/Integrator' */
  real_T Filter_CSTATE_i;              /* '<S90>/Filter' */
  real_T Integrator_CSTATE_j;          /* '<S147>/Integrator' */
  real_T Filter_CSTATE_e;              /* '<S142>/Filter' */
  real_T Integrator_CSTATE_k;          /* '<S199>/Integrator' */
  real_T Filter_CSTATE_j;              /* '<S194>/Filter' */
  real_T Integrator_CSTATE_p;          /* '<S251>/Integrator' */
  real_T Filter_CSTATE_o;              /* '<S246>/Filter' */
  real_T Integrator_CSTATE_h;          /* '<S303>/Integrator' */
  real_T Filter_CSTATE_a;              /* '<S298>/Filter' */
} XDot_Controller_T;

/* State disabled  */
typedef struct {
  boolean_T Integrator_CSTATE;         /* '<S43>/Integrator' */
  boolean_T Filter_CSTATE;             /* '<S38>/Filter' */
  boolean_T Integrator_CSTATE_m;       /* '<S95>/Integrator' */
  boolean_T Filter_CSTATE_i;           /* '<S90>/Filter' */
  boolean_T Integrator_CSTATE_j;       /* '<S147>/Integrator' */
  boolean_T Filter_CSTATE_e;           /* '<S142>/Filter' */
  boolean_T Integrator_CSTATE_k;       /* '<S199>/Integrator' */
  boolean_T Filter_CSTATE_j;           /* '<S194>/Filter' */
  boolean_T Integrator_CSTATE_p;       /* '<S251>/Integrator' */
  boolean_T Filter_CSTATE_o;           /* '<S246>/Filter' */
  boolean_T Integrator_CSTATE_h;       /* '<S303>/Integrator' */
  boolean_T Filter_CSTATE_a;           /* '<S298>/Filter' */
} XDis_Controller_T;

#ifndef ODE3_INTG
#define ODE3_INTG

/* ODE3 Integration Data */
typedef struct {
  real_T *y;                           /* output */
  real_T *f[3];                        /* derivatives */
} ODE3_IntgData;

#endif

/* External inputs (root inport signals with default storage) */
typedef struct {
  real_T Error[6];                     /* '<Root>/Error' */
} ExtU_Controller_T;

/* External outputs (root outports fed by signals with default storage) */
typedef struct {
  real_T PWM[8];                       /* '<Root>/PWM' */
} ExtY_Controller_T;

/* Parameters (default storage) */
struct P_Controller_T_ {
  real_T pwm_stop;                     /* Variable: pwm_stop
                                        * Referenced by: '<S1>/PWM Stop'
                                        */
  real_T wrench[48];                   /* Variable: wrench
                                        * Referenced by: '<S1>/MATLAB Function'
                                        */
  real_T PID1_D;                       /* Mask Parameter: PID1_D
                                        * Referenced by: '<S36>/Derivative Gain'
                                        */
  real_T PID2_D;                       /* Mask Parameter: PID2_D
                                        * Referenced by: '<S88>/Derivative Gain'
                                        */
  real_T PID3_D;                       /* Mask Parameter: PID3_D
                                        * Referenced by: '<S140>/Derivative Gain'
                                        */
  real_T PID4_D;                       /* Mask Parameter: PID4_D
                                        * Referenced by: '<S192>/Derivative Gain'
                                        */
  real_T PID5_D;                       /* Mask Parameter: PID5_D
                                        * Referenced by: '<S244>/Derivative Gain'
                                        */
  real_T PID6_D;                       /* Mask Parameter: PID6_D
                                        * Referenced by: '<S296>/Derivative Gain'
                                        */
  real_T PID1_I;                       /* Mask Parameter: PID1_I
                                        * Referenced by: '<S40>/Integral Gain'
                                        */
  real_T PID2_I;                       /* Mask Parameter: PID2_I
                                        * Referenced by: '<S92>/Integral Gain'
                                        */
  real_T PID3_I;                       /* Mask Parameter: PID3_I
                                        * Referenced by: '<S144>/Integral Gain'
                                        */
  real_T PID4_I;                       /* Mask Parameter: PID4_I
                                        * Referenced by: '<S196>/Integral Gain'
                                        */
  real_T PID5_I;                       /* Mask Parameter: PID5_I
                                        * Referenced by: '<S248>/Integral Gain'
                                        */
  real_T PID6_I;                       /* Mask Parameter: PID6_I
                                        * Referenced by: '<S300>/Integral Gain'
                                        */
  real_T PID1_InitialConditionForFilter;
                               /* Mask Parameter: PID1_InitialConditionForFilter
                                * Referenced by: '<S38>/Filter'
                                */
  real_T PID2_InitialConditionForFilter;
                               /* Mask Parameter: PID2_InitialConditionForFilter
                                * Referenced by: '<S90>/Filter'
                                */
  real_T PID3_InitialConditionForFilter;
                               /* Mask Parameter: PID3_InitialConditionForFilter
                                * Referenced by: '<S142>/Filter'
                                */
  real_T PID4_InitialConditionForFilter;
                               /* Mask Parameter: PID4_InitialConditionForFilter
                                * Referenced by: '<S194>/Filter'
                                */
  real_T PID5_InitialConditionForFilter;
                               /* Mask Parameter: PID5_InitialConditionForFilter
                                * Referenced by: '<S246>/Filter'
                                */
  real_T PID6_InitialConditionForFilter;
                               /* Mask Parameter: PID6_InitialConditionForFilter
                                * Referenced by: '<S298>/Filter'
                                */
  real_T PID1_InitialConditionForIntegra;
                              /* Mask Parameter: PID1_InitialConditionForIntegra
                               * Referenced by: '<S43>/Integrator'
                               */
  real_T PID2_InitialConditionForIntegra;
                              /* Mask Parameter: PID2_InitialConditionForIntegra
                               * Referenced by: '<S95>/Integrator'
                               */
  real_T PID3_InitialConditionForIntegra;
                              /* Mask Parameter: PID3_InitialConditionForIntegra
                               * Referenced by: '<S147>/Integrator'
                               */
  real_T PID4_InitialConditionForIntegra;
                              /* Mask Parameter: PID4_InitialConditionForIntegra
                               * Referenced by: '<S199>/Integrator'
                               */
  real_T PID5_InitialConditionForIntegra;
                              /* Mask Parameter: PID5_InitialConditionForIntegra
                               * Referenced by: '<S251>/Integrator'
                               */
  real_T PID6_InitialConditionForIntegra;
                              /* Mask Parameter: PID6_InitialConditionForIntegra
                               * Referenced by: '<S303>/Integrator'
                               */
  real_T PID1_N;                       /* Mask Parameter: PID1_N
                                        * Referenced by: '<S46>/Filter Coefficient'
                                        */
  real_T PID2_N;                       /* Mask Parameter: PID2_N
                                        * Referenced by: '<S98>/Filter Coefficient'
                                        */
  real_T PID3_N;                       /* Mask Parameter: PID3_N
                                        * Referenced by: '<S150>/Filter Coefficient'
                                        */
  real_T PID4_N;                       /* Mask Parameter: PID4_N
                                        * Referenced by: '<S202>/Filter Coefficient'
                                        */
  real_T PID5_N;                       /* Mask Parameter: PID5_N
                                        * Referenced by: '<S254>/Filter Coefficient'
                                        */
  real_T PID6_N;                       /* Mask Parameter: PID6_N
                                        * Referenced by: '<S306>/Filter Coefficient'
                                        */
  real_T PID1_P;                       /* Mask Parameter: PID1_P
                                        * Referenced by: '<S48>/Proportional Gain'
                                        */
  real_T PID2_P;                       /* Mask Parameter: PID2_P
                                        * Referenced by: '<S100>/Proportional Gain'
                                        */
  real_T PID3_P;                       /* Mask Parameter: PID3_P
                                        * Referenced by: '<S152>/Proportional Gain'
                                        */
  real_T PID4_P;                       /* Mask Parameter: PID4_P
                                        * Referenced by: '<S204>/Proportional Gain'
                                        */
  real_T PID5_P;                       /* Mask Parameter: PID5_P
                                        * Referenced by: '<S256>/Proportional Gain'
                                        */
  real_T PID6_P;                       /* Mask Parameter: PID6_P
                                        * Referenced by: '<S308>/Proportional Gain'
                                        */
  real_T Gain_Gain;                    /* Expression: 10
                                        * Referenced by: '<S1>/Gain'
                                        */
  real_T Saturation_UpperSat;          /* Expression: 1900
                                        * Referenced by: '<S1>/Saturation'
                                        */
  real_T Saturation_LowerSat;          /* Expression: 1100
                                        * Referenced by: '<S1>/Saturation'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_Controller_T {
  const char_T *errorStatus;
  RTWLogInfo *rtwLogInfo;
  RTWSolverInfo solverInfo;
  X_Controller_T *contStates;
  int_T *periodicContStateIndices;
  real_T *periodicContStateRanges;
  real_T *derivs;
  XDis_Controller_T *contStateDisabled;
  boolean_T zCCacheNeedsReset;
  boolean_T derivCacheNeedsReset;
  boolean_T CTOutputIncnstWithState;
  real_T odeY[12];
  real_T odeF[3][12];
  ODE3_IntgData intgData;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    int_T numContStates;
    int_T numPeriodicContStates;
    int_T numSampTimes;
  } Sizes;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    uint32_T clockTick1;
    uint32_T clockTickH1;
    time_T tStart;
    time_T tFinal;
    SimTimeStep simTimeStep;
    boolean_T stopRequestedFlag;
    time_T *t;
    time_T tArray[2];
  } Timing;
};

/* Block parameters (default storage) */
extern P_Controller_T Controller_P;

/* Block signals (default storage) */
extern B_Controller_T Controller_B;

/* Continuous states (default storage) */
extern X_Controller_T Controller_X;

/* Disabled states (default storage) */
extern XDis_Controller_T Controller_XDis;

/* External inputs (root inport signals with default storage) */
extern ExtU_Controller_T Controller_U;

/* External outputs (root outports fed by signals with default storage) */
extern ExtY_Controller_T Controller_Y;

/* Model entry point functions */
extern void Controller_initialize(void);
extern void Controller_step(void);
extern void Controller_terminate(void);

/* Real-time Model object */
extern RT_MODEL_Controller_T *const Controller_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Note that this particular code originates from a subsystem build,
 * and has its own system numbers different from the parent model.
 * Refer to the system hierarchy for this subsystem below, and use the
 * MATLAB hilite_system command to trace the generated code back
 * to the parent model.  For example,
 *
 * hilite_system('PID_LOOP/Controller')    - opens subsystem PID_LOOP/Controller
 * hilite_system('PID_LOOP/Controller/Kp') - opens and selects block Kp
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'PID_LOOP'
 * '<S1>'   : 'PID_LOOP/Controller'
 * '<S2>'   : 'PID_LOOP/Controller/MATLAB Function'
 * '<S3>'   : 'PID_LOOP/Controller/PID 1'
 * '<S4>'   : 'PID_LOOP/Controller/PID 2'
 * '<S5>'   : 'PID_LOOP/Controller/PID 3'
 * '<S6>'   : 'PID_LOOP/Controller/PID 4'
 * '<S7>'   : 'PID_LOOP/Controller/PID 5'
 * '<S8>'   : 'PID_LOOP/Controller/PID 6'
 * '<S9>'   : 'PID_LOOP/Controller/PID 1/Anti-windup'
 * '<S10>'  : 'PID_LOOP/Controller/PID 1/D Gain'
 * '<S11>'  : 'PID_LOOP/Controller/PID 1/External Derivative'
 * '<S12>'  : 'PID_LOOP/Controller/PID 1/Filter'
 * '<S13>'  : 'PID_LOOP/Controller/PID 1/Filter ICs'
 * '<S14>'  : 'PID_LOOP/Controller/PID 1/I Gain'
 * '<S15>'  : 'PID_LOOP/Controller/PID 1/Ideal P Gain'
 * '<S16>'  : 'PID_LOOP/Controller/PID 1/Ideal P Gain Fdbk'
 * '<S17>'  : 'PID_LOOP/Controller/PID 1/Integrator'
 * '<S18>'  : 'PID_LOOP/Controller/PID 1/Integrator ICs'
 * '<S19>'  : 'PID_LOOP/Controller/PID 1/N Copy'
 * '<S20>'  : 'PID_LOOP/Controller/PID 1/N Gain'
 * '<S21>'  : 'PID_LOOP/Controller/PID 1/P Copy'
 * '<S22>'  : 'PID_LOOP/Controller/PID 1/Parallel P Gain'
 * '<S23>'  : 'PID_LOOP/Controller/PID 1/Reset Signal'
 * '<S24>'  : 'PID_LOOP/Controller/PID 1/Saturation'
 * '<S25>'  : 'PID_LOOP/Controller/PID 1/Saturation Fdbk'
 * '<S26>'  : 'PID_LOOP/Controller/PID 1/Sum'
 * '<S27>'  : 'PID_LOOP/Controller/PID 1/Sum Fdbk'
 * '<S28>'  : 'PID_LOOP/Controller/PID 1/Tracking Mode'
 * '<S29>'  : 'PID_LOOP/Controller/PID 1/Tracking Mode Sum'
 * '<S30>'  : 'PID_LOOP/Controller/PID 1/Tsamp - Integral'
 * '<S31>'  : 'PID_LOOP/Controller/PID 1/Tsamp - Ngain'
 * '<S32>'  : 'PID_LOOP/Controller/PID 1/postSat Signal'
 * '<S33>'  : 'PID_LOOP/Controller/PID 1/preInt Signal'
 * '<S34>'  : 'PID_LOOP/Controller/PID 1/preSat Signal'
 * '<S35>'  : 'PID_LOOP/Controller/PID 1/Anti-windup/Passthrough'
 * '<S36>'  : 'PID_LOOP/Controller/PID 1/D Gain/Internal Parameters'
 * '<S37>'  : 'PID_LOOP/Controller/PID 1/External Derivative/Error'
 * '<S38>'  : 'PID_LOOP/Controller/PID 1/Filter/Cont. Filter'
 * '<S39>'  : 'PID_LOOP/Controller/PID 1/Filter ICs/Internal IC - Filter'
 * '<S40>'  : 'PID_LOOP/Controller/PID 1/I Gain/Internal Parameters'
 * '<S41>'  : 'PID_LOOP/Controller/PID 1/Ideal P Gain/Passthrough'
 * '<S42>'  : 'PID_LOOP/Controller/PID 1/Ideal P Gain Fdbk/Disabled'
 * '<S43>'  : 'PID_LOOP/Controller/PID 1/Integrator/Continuous'
 * '<S44>'  : 'PID_LOOP/Controller/PID 1/Integrator ICs/Internal IC'
 * '<S45>'  : 'PID_LOOP/Controller/PID 1/N Copy/Disabled'
 * '<S46>'  : 'PID_LOOP/Controller/PID 1/N Gain/Internal Parameters'
 * '<S47>'  : 'PID_LOOP/Controller/PID 1/P Copy/Disabled'
 * '<S48>'  : 'PID_LOOP/Controller/PID 1/Parallel P Gain/Internal Parameters'
 * '<S49>'  : 'PID_LOOP/Controller/PID 1/Reset Signal/Disabled'
 * '<S50>'  : 'PID_LOOP/Controller/PID 1/Saturation/Passthrough'
 * '<S51>'  : 'PID_LOOP/Controller/PID 1/Saturation Fdbk/Disabled'
 * '<S52>'  : 'PID_LOOP/Controller/PID 1/Sum/Sum_PID'
 * '<S53>'  : 'PID_LOOP/Controller/PID 1/Sum Fdbk/Disabled'
 * '<S54>'  : 'PID_LOOP/Controller/PID 1/Tracking Mode/Disabled'
 * '<S55>'  : 'PID_LOOP/Controller/PID 1/Tracking Mode Sum/Passthrough'
 * '<S56>'  : 'PID_LOOP/Controller/PID 1/Tsamp - Integral/TsSignalSpecification'
 * '<S57>'  : 'PID_LOOP/Controller/PID 1/Tsamp - Ngain/Passthrough'
 * '<S58>'  : 'PID_LOOP/Controller/PID 1/postSat Signal/Forward_Path'
 * '<S59>'  : 'PID_LOOP/Controller/PID 1/preInt Signal/Internal PreInt'
 * '<S60>'  : 'PID_LOOP/Controller/PID 1/preSat Signal/Forward_Path'
 * '<S61>'  : 'PID_LOOP/Controller/PID 2/Anti-windup'
 * '<S62>'  : 'PID_LOOP/Controller/PID 2/D Gain'
 * '<S63>'  : 'PID_LOOP/Controller/PID 2/External Derivative'
 * '<S64>'  : 'PID_LOOP/Controller/PID 2/Filter'
 * '<S65>'  : 'PID_LOOP/Controller/PID 2/Filter ICs'
 * '<S66>'  : 'PID_LOOP/Controller/PID 2/I Gain'
 * '<S67>'  : 'PID_LOOP/Controller/PID 2/Ideal P Gain'
 * '<S68>'  : 'PID_LOOP/Controller/PID 2/Ideal P Gain Fdbk'
 * '<S69>'  : 'PID_LOOP/Controller/PID 2/Integrator'
 * '<S70>'  : 'PID_LOOP/Controller/PID 2/Integrator ICs'
 * '<S71>'  : 'PID_LOOP/Controller/PID 2/N Copy'
 * '<S72>'  : 'PID_LOOP/Controller/PID 2/N Gain'
 * '<S73>'  : 'PID_LOOP/Controller/PID 2/P Copy'
 * '<S74>'  : 'PID_LOOP/Controller/PID 2/Parallel P Gain'
 * '<S75>'  : 'PID_LOOP/Controller/PID 2/Reset Signal'
 * '<S76>'  : 'PID_LOOP/Controller/PID 2/Saturation'
 * '<S77>'  : 'PID_LOOP/Controller/PID 2/Saturation Fdbk'
 * '<S78>'  : 'PID_LOOP/Controller/PID 2/Sum'
 * '<S79>'  : 'PID_LOOP/Controller/PID 2/Sum Fdbk'
 * '<S80>'  : 'PID_LOOP/Controller/PID 2/Tracking Mode'
 * '<S81>'  : 'PID_LOOP/Controller/PID 2/Tracking Mode Sum'
 * '<S82>'  : 'PID_LOOP/Controller/PID 2/Tsamp - Integral'
 * '<S83>'  : 'PID_LOOP/Controller/PID 2/Tsamp - Ngain'
 * '<S84>'  : 'PID_LOOP/Controller/PID 2/postSat Signal'
 * '<S85>'  : 'PID_LOOP/Controller/PID 2/preInt Signal'
 * '<S86>'  : 'PID_LOOP/Controller/PID 2/preSat Signal'
 * '<S87>'  : 'PID_LOOP/Controller/PID 2/Anti-windup/Passthrough'
 * '<S88>'  : 'PID_LOOP/Controller/PID 2/D Gain/Internal Parameters'
 * '<S89>'  : 'PID_LOOP/Controller/PID 2/External Derivative/Error'
 * '<S90>'  : 'PID_LOOP/Controller/PID 2/Filter/Cont. Filter'
 * '<S91>'  : 'PID_LOOP/Controller/PID 2/Filter ICs/Internal IC - Filter'
 * '<S92>'  : 'PID_LOOP/Controller/PID 2/I Gain/Internal Parameters'
 * '<S93>'  : 'PID_LOOP/Controller/PID 2/Ideal P Gain/Passthrough'
 * '<S94>'  : 'PID_LOOP/Controller/PID 2/Ideal P Gain Fdbk/Disabled'
 * '<S95>'  : 'PID_LOOP/Controller/PID 2/Integrator/Continuous'
 * '<S96>'  : 'PID_LOOP/Controller/PID 2/Integrator ICs/Internal IC'
 * '<S97>'  : 'PID_LOOP/Controller/PID 2/N Copy/Disabled'
 * '<S98>'  : 'PID_LOOP/Controller/PID 2/N Gain/Internal Parameters'
 * '<S99>'  : 'PID_LOOP/Controller/PID 2/P Copy/Disabled'
 * '<S100>' : 'PID_LOOP/Controller/PID 2/Parallel P Gain/Internal Parameters'
 * '<S101>' : 'PID_LOOP/Controller/PID 2/Reset Signal/Disabled'
 * '<S102>' : 'PID_LOOP/Controller/PID 2/Saturation/Passthrough'
 * '<S103>' : 'PID_LOOP/Controller/PID 2/Saturation Fdbk/Disabled'
 * '<S104>' : 'PID_LOOP/Controller/PID 2/Sum/Sum_PID'
 * '<S105>' : 'PID_LOOP/Controller/PID 2/Sum Fdbk/Disabled'
 * '<S106>' : 'PID_LOOP/Controller/PID 2/Tracking Mode/Disabled'
 * '<S107>' : 'PID_LOOP/Controller/PID 2/Tracking Mode Sum/Passthrough'
 * '<S108>' : 'PID_LOOP/Controller/PID 2/Tsamp - Integral/TsSignalSpecification'
 * '<S109>' : 'PID_LOOP/Controller/PID 2/Tsamp - Ngain/Passthrough'
 * '<S110>' : 'PID_LOOP/Controller/PID 2/postSat Signal/Forward_Path'
 * '<S111>' : 'PID_LOOP/Controller/PID 2/preInt Signal/Internal PreInt'
 * '<S112>' : 'PID_LOOP/Controller/PID 2/preSat Signal/Forward_Path'
 * '<S113>' : 'PID_LOOP/Controller/PID 3/Anti-windup'
 * '<S114>' : 'PID_LOOP/Controller/PID 3/D Gain'
 * '<S115>' : 'PID_LOOP/Controller/PID 3/External Derivative'
 * '<S116>' : 'PID_LOOP/Controller/PID 3/Filter'
 * '<S117>' : 'PID_LOOP/Controller/PID 3/Filter ICs'
 * '<S118>' : 'PID_LOOP/Controller/PID 3/I Gain'
 * '<S119>' : 'PID_LOOP/Controller/PID 3/Ideal P Gain'
 * '<S120>' : 'PID_LOOP/Controller/PID 3/Ideal P Gain Fdbk'
 * '<S121>' : 'PID_LOOP/Controller/PID 3/Integrator'
 * '<S122>' : 'PID_LOOP/Controller/PID 3/Integrator ICs'
 * '<S123>' : 'PID_LOOP/Controller/PID 3/N Copy'
 * '<S124>' : 'PID_LOOP/Controller/PID 3/N Gain'
 * '<S125>' : 'PID_LOOP/Controller/PID 3/P Copy'
 * '<S126>' : 'PID_LOOP/Controller/PID 3/Parallel P Gain'
 * '<S127>' : 'PID_LOOP/Controller/PID 3/Reset Signal'
 * '<S128>' : 'PID_LOOP/Controller/PID 3/Saturation'
 * '<S129>' : 'PID_LOOP/Controller/PID 3/Saturation Fdbk'
 * '<S130>' : 'PID_LOOP/Controller/PID 3/Sum'
 * '<S131>' : 'PID_LOOP/Controller/PID 3/Sum Fdbk'
 * '<S132>' : 'PID_LOOP/Controller/PID 3/Tracking Mode'
 * '<S133>' : 'PID_LOOP/Controller/PID 3/Tracking Mode Sum'
 * '<S134>' : 'PID_LOOP/Controller/PID 3/Tsamp - Integral'
 * '<S135>' : 'PID_LOOP/Controller/PID 3/Tsamp - Ngain'
 * '<S136>' : 'PID_LOOP/Controller/PID 3/postSat Signal'
 * '<S137>' : 'PID_LOOP/Controller/PID 3/preInt Signal'
 * '<S138>' : 'PID_LOOP/Controller/PID 3/preSat Signal'
 * '<S139>' : 'PID_LOOP/Controller/PID 3/Anti-windup/Passthrough'
 * '<S140>' : 'PID_LOOP/Controller/PID 3/D Gain/Internal Parameters'
 * '<S141>' : 'PID_LOOP/Controller/PID 3/External Derivative/Error'
 * '<S142>' : 'PID_LOOP/Controller/PID 3/Filter/Cont. Filter'
 * '<S143>' : 'PID_LOOP/Controller/PID 3/Filter ICs/Internal IC - Filter'
 * '<S144>' : 'PID_LOOP/Controller/PID 3/I Gain/Internal Parameters'
 * '<S145>' : 'PID_LOOP/Controller/PID 3/Ideal P Gain/Passthrough'
 * '<S146>' : 'PID_LOOP/Controller/PID 3/Ideal P Gain Fdbk/Disabled'
 * '<S147>' : 'PID_LOOP/Controller/PID 3/Integrator/Continuous'
 * '<S148>' : 'PID_LOOP/Controller/PID 3/Integrator ICs/Internal IC'
 * '<S149>' : 'PID_LOOP/Controller/PID 3/N Copy/Disabled'
 * '<S150>' : 'PID_LOOP/Controller/PID 3/N Gain/Internal Parameters'
 * '<S151>' : 'PID_LOOP/Controller/PID 3/P Copy/Disabled'
 * '<S152>' : 'PID_LOOP/Controller/PID 3/Parallel P Gain/Internal Parameters'
 * '<S153>' : 'PID_LOOP/Controller/PID 3/Reset Signal/Disabled'
 * '<S154>' : 'PID_LOOP/Controller/PID 3/Saturation/Passthrough'
 * '<S155>' : 'PID_LOOP/Controller/PID 3/Saturation Fdbk/Disabled'
 * '<S156>' : 'PID_LOOP/Controller/PID 3/Sum/Sum_PID'
 * '<S157>' : 'PID_LOOP/Controller/PID 3/Sum Fdbk/Disabled'
 * '<S158>' : 'PID_LOOP/Controller/PID 3/Tracking Mode/Disabled'
 * '<S159>' : 'PID_LOOP/Controller/PID 3/Tracking Mode Sum/Passthrough'
 * '<S160>' : 'PID_LOOP/Controller/PID 3/Tsamp - Integral/TsSignalSpecification'
 * '<S161>' : 'PID_LOOP/Controller/PID 3/Tsamp - Ngain/Passthrough'
 * '<S162>' : 'PID_LOOP/Controller/PID 3/postSat Signal/Forward_Path'
 * '<S163>' : 'PID_LOOP/Controller/PID 3/preInt Signal/Internal PreInt'
 * '<S164>' : 'PID_LOOP/Controller/PID 3/preSat Signal/Forward_Path'
 * '<S165>' : 'PID_LOOP/Controller/PID 4/Anti-windup'
 * '<S166>' : 'PID_LOOP/Controller/PID 4/D Gain'
 * '<S167>' : 'PID_LOOP/Controller/PID 4/External Derivative'
 * '<S168>' : 'PID_LOOP/Controller/PID 4/Filter'
 * '<S169>' : 'PID_LOOP/Controller/PID 4/Filter ICs'
 * '<S170>' : 'PID_LOOP/Controller/PID 4/I Gain'
 * '<S171>' : 'PID_LOOP/Controller/PID 4/Ideal P Gain'
 * '<S172>' : 'PID_LOOP/Controller/PID 4/Ideal P Gain Fdbk'
 * '<S173>' : 'PID_LOOP/Controller/PID 4/Integrator'
 * '<S174>' : 'PID_LOOP/Controller/PID 4/Integrator ICs'
 * '<S175>' : 'PID_LOOP/Controller/PID 4/N Copy'
 * '<S176>' : 'PID_LOOP/Controller/PID 4/N Gain'
 * '<S177>' : 'PID_LOOP/Controller/PID 4/P Copy'
 * '<S178>' : 'PID_LOOP/Controller/PID 4/Parallel P Gain'
 * '<S179>' : 'PID_LOOP/Controller/PID 4/Reset Signal'
 * '<S180>' : 'PID_LOOP/Controller/PID 4/Saturation'
 * '<S181>' : 'PID_LOOP/Controller/PID 4/Saturation Fdbk'
 * '<S182>' : 'PID_LOOP/Controller/PID 4/Sum'
 * '<S183>' : 'PID_LOOP/Controller/PID 4/Sum Fdbk'
 * '<S184>' : 'PID_LOOP/Controller/PID 4/Tracking Mode'
 * '<S185>' : 'PID_LOOP/Controller/PID 4/Tracking Mode Sum'
 * '<S186>' : 'PID_LOOP/Controller/PID 4/Tsamp - Integral'
 * '<S187>' : 'PID_LOOP/Controller/PID 4/Tsamp - Ngain'
 * '<S188>' : 'PID_LOOP/Controller/PID 4/postSat Signal'
 * '<S189>' : 'PID_LOOP/Controller/PID 4/preInt Signal'
 * '<S190>' : 'PID_LOOP/Controller/PID 4/preSat Signal'
 * '<S191>' : 'PID_LOOP/Controller/PID 4/Anti-windup/Passthrough'
 * '<S192>' : 'PID_LOOP/Controller/PID 4/D Gain/Internal Parameters'
 * '<S193>' : 'PID_LOOP/Controller/PID 4/External Derivative/Error'
 * '<S194>' : 'PID_LOOP/Controller/PID 4/Filter/Cont. Filter'
 * '<S195>' : 'PID_LOOP/Controller/PID 4/Filter ICs/Internal IC - Filter'
 * '<S196>' : 'PID_LOOP/Controller/PID 4/I Gain/Internal Parameters'
 * '<S197>' : 'PID_LOOP/Controller/PID 4/Ideal P Gain/Passthrough'
 * '<S198>' : 'PID_LOOP/Controller/PID 4/Ideal P Gain Fdbk/Disabled'
 * '<S199>' : 'PID_LOOP/Controller/PID 4/Integrator/Continuous'
 * '<S200>' : 'PID_LOOP/Controller/PID 4/Integrator ICs/Internal IC'
 * '<S201>' : 'PID_LOOP/Controller/PID 4/N Copy/Disabled'
 * '<S202>' : 'PID_LOOP/Controller/PID 4/N Gain/Internal Parameters'
 * '<S203>' : 'PID_LOOP/Controller/PID 4/P Copy/Disabled'
 * '<S204>' : 'PID_LOOP/Controller/PID 4/Parallel P Gain/Internal Parameters'
 * '<S205>' : 'PID_LOOP/Controller/PID 4/Reset Signal/Disabled'
 * '<S206>' : 'PID_LOOP/Controller/PID 4/Saturation/Passthrough'
 * '<S207>' : 'PID_LOOP/Controller/PID 4/Saturation Fdbk/Disabled'
 * '<S208>' : 'PID_LOOP/Controller/PID 4/Sum/Sum_PID'
 * '<S209>' : 'PID_LOOP/Controller/PID 4/Sum Fdbk/Disabled'
 * '<S210>' : 'PID_LOOP/Controller/PID 4/Tracking Mode/Disabled'
 * '<S211>' : 'PID_LOOP/Controller/PID 4/Tracking Mode Sum/Passthrough'
 * '<S212>' : 'PID_LOOP/Controller/PID 4/Tsamp - Integral/TsSignalSpecification'
 * '<S213>' : 'PID_LOOP/Controller/PID 4/Tsamp - Ngain/Passthrough'
 * '<S214>' : 'PID_LOOP/Controller/PID 4/postSat Signal/Forward_Path'
 * '<S215>' : 'PID_LOOP/Controller/PID 4/preInt Signal/Internal PreInt'
 * '<S216>' : 'PID_LOOP/Controller/PID 4/preSat Signal/Forward_Path'
 * '<S217>' : 'PID_LOOP/Controller/PID 5/Anti-windup'
 * '<S218>' : 'PID_LOOP/Controller/PID 5/D Gain'
 * '<S219>' : 'PID_LOOP/Controller/PID 5/External Derivative'
 * '<S220>' : 'PID_LOOP/Controller/PID 5/Filter'
 * '<S221>' : 'PID_LOOP/Controller/PID 5/Filter ICs'
 * '<S222>' : 'PID_LOOP/Controller/PID 5/I Gain'
 * '<S223>' : 'PID_LOOP/Controller/PID 5/Ideal P Gain'
 * '<S224>' : 'PID_LOOP/Controller/PID 5/Ideal P Gain Fdbk'
 * '<S225>' : 'PID_LOOP/Controller/PID 5/Integrator'
 * '<S226>' : 'PID_LOOP/Controller/PID 5/Integrator ICs'
 * '<S227>' : 'PID_LOOP/Controller/PID 5/N Copy'
 * '<S228>' : 'PID_LOOP/Controller/PID 5/N Gain'
 * '<S229>' : 'PID_LOOP/Controller/PID 5/P Copy'
 * '<S230>' : 'PID_LOOP/Controller/PID 5/Parallel P Gain'
 * '<S231>' : 'PID_LOOP/Controller/PID 5/Reset Signal'
 * '<S232>' : 'PID_LOOP/Controller/PID 5/Saturation'
 * '<S233>' : 'PID_LOOP/Controller/PID 5/Saturation Fdbk'
 * '<S234>' : 'PID_LOOP/Controller/PID 5/Sum'
 * '<S235>' : 'PID_LOOP/Controller/PID 5/Sum Fdbk'
 * '<S236>' : 'PID_LOOP/Controller/PID 5/Tracking Mode'
 * '<S237>' : 'PID_LOOP/Controller/PID 5/Tracking Mode Sum'
 * '<S238>' : 'PID_LOOP/Controller/PID 5/Tsamp - Integral'
 * '<S239>' : 'PID_LOOP/Controller/PID 5/Tsamp - Ngain'
 * '<S240>' : 'PID_LOOP/Controller/PID 5/postSat Signal'
 * '<S241>' : 'PID_LOOP/Controller/PID 5/preInt Signal'
 * '<S242>' : 'PID_LOOP/Controller/PID 5/preSat Signal'
 * '<S243>' : 'PID_LOOP/Controller/PID 5/Anti-windup/Passthrough'
 * '<S244>' : 'PID_LOOP/Controller/PID 5/D Gain/Internal Parameters'
 * '<S245>' : 'PID_LOOP/Controller/PID 5/External Derivative/Error'
 * '<S246>' : 'PID_LOOP/Controller/PID 5/Filter/Cont. Filter'
 * '<S247>' : 'PID_LOOP/Controller/PID 5/Filter ICs/Internal IC - Filter'
 * '<S248>' : 'PID_LOOP/Controller/PID 5/I Gain/Internal Parameters'
 * '<S249>' : 'PID_LOOP/Controller/PID 5/Ideal P Gain/Passthrough'
 * '<S250>' : 'PID_LOOP/Controller/PID 5/Ideal P Gain Fdbk/Disabled'
 * '<S251>' : 'PID_LOOP/Controller/PID 5/Integrator/Continuous'
 * '<S252>' : 'PID_LOOP/Controller/PID 5/Integrator ICs/Internal IC'
 * '<S253>' : 'PID_LOOP/Controller/PID 5/N Copy/Disabled'
 * '<S254>' : 'PID_LOOP/Controller/PID 5/N Gain/Internal Parameters'
 * '<S255>' : 'PID_LOOP/Controller/PID 5/P Copy/Disabled'
 * '<S256>' : 'PID_LOOP/Controller/PID 5/Parallel P Gain/Internal Parameters'
 * '<S257>' : 'PID_LOOP/Controller/PID 5/Reset Signal/Disabled'
 * '<S258>' : 'PID_LOOP/Controller/PID 5/Saturation/Passthrough'
 * '<S259>' : 'PID_LOOP/Controller/PID 5/Saturation Fdbk/Disabled'
 * '<S260>' : 'PID_LOOP/Controller/PID 5/Sum/Sum_PID'
 * '<S261>' : 'PID_LOOP/Controller/PID 5/Sum Fdbk/Disabled'
 * '<S262>' : 'PID_LOOP/Controller/PID 5/Tracking Mode/Disabled'
 * '<S263>' : 'PID_LOOP/Controller/PID 5/Tracking Mode Sum/Passthrough'
 * '<S264>' : 'PID_LOOP/Controller/PID 5/Tsamp - Integral/TsSignalSpecification'
 * '<S265>' : 'PID_LOOP/Controller/PID 5/Tsamp - Ngain/Passthrough'
 * '<S266>' : 'PID_LOOP/Controller/PID 5/postSat Signal/Forward_Path'
 * '<S267>' : 'PID_LOOP/Controller/PID 5/preInt Signal/Internal PreInt'
 * '<S268>' : 'PID_LOOP/Controller/PID 5/preSat Signal/Forward_Path'
 * '<S269>' : 'PID_LOOP/Controller/PID 6/Anti-windup'
 * '<S270>' : 'PID_LOOP/Controller/PID 6/D Gain'
 * '<S271>' : 'PID_LOOP/Controller/PID 6/External Derivative'
 * '<S272>' : 'PID_LOOP/Controller/PID 6/Filter'
 * '<S273>' : 'PID_LOOP/Controller/PID 6/Filter ICs'
 * '<S274>' : 'PID_LOOP/Controller/PID 6/I Gain'
 * '<S275>' : 'PID_LOOP/Controller/PID 6/Ideal P Gain'
 * '<S276>' : 'PID_LOOP/Controller/PID 6/Ideal P Gain Fdbk'
 * '<S277>' : 'PID_LOOP/Controller/PID 6/Integrator'
 * '<S278>' : 'PID_LOOP/Controller/PID 6/Integrator ICs'
 * '<S279>' : 'PID_LOOP/Controller/PID 6/N Copy'
 * '<S280>' : 'PID_LOOP/Controller/PID 6/N Gain'
 * '<S281>' : 'PID_LOOP/Controller/PID 6/P Copy'
 * '<S282>' : 'PID_LOOP/Controller/PID 6/Parallel P Gain'
 * '<S283>' : 'PID_LOOP/Controller/PID 6/Reset Signal'
 * '<S284>' : 'PID_LOOP/Controller/PID 6/Saturation'
 * '<S285>' : 'PID_LOOP/Controller/PID 6/Saturation Fdbk'
 * '<S286>' : 'PID_LOOP/Controller/PID 6/Sum'
 * '<S287>' : 'PID_LOOP/Controller/PID 6/Sum Fdbk'
 * '<S288>' : 'PID_LOOP/Controller/PID 6/Tracking Mode'
 * '<S289>' : 'PID_LOOP/Controller/PID 6/Tracking Mode Sum'
 * '<S290>' : 'PID_LOOP/Controller/PID 6/Tsamp - Integral'
 * '<S291>' : 'PID_LOOP/Controller/PID 6/Tsamp - Ngain'
 * '<S292>' : 'PID_LOOP/Controller/PID 6/postSat Signal'
 * '<S293>' : 'PID_LOOP/Controller/PID 6/preInt Signal'
 * '<S294>' : 'PID_LOOP/Controller/PID 6/preSat Signal'
 * '<S295>' : 'PID_LOOP/Controller/PID 6/Anti-windup/Passthrough'
 * '<S296>' : 'PID_LOOP/Controller/PID 6/D Gain/Internal Parameters'
 * '<S297>' : 'PID_LOOP/Controller/PID 6/External Derivative/Error'
 * '<S298>' : 'PID_LOOP/Controller/PID 6/Filter/Cont. Filter'
 * '<S299>' : 'PID_LOOP/Controller/PID 6/Filter ICs/Internal IC - Filter'
 * '<S300>' : 'PID_LOOP/Controller/PID 6/I Gain/Internal Parameters'
 * '<S301>' : 'PID_LOOP/Controller/PID 6/Ideal P Gain/Passthrough'
 * '<S302>' : 'PID_LOOP/Controller/PID 6/Ideal P Gain Fdbk/Disabled'
 * '<S303>' : 'PID_LOOP/Controller/PID 6/Integrator/Continuous'
 * '<S304>' : 'PID_LOOP/Controller/PID 6/Integrator ICs/Internal IC'
 * '<S305>' : 'PID_LOOP/Controller/PID 6/N Copy/Disabled'
 * '<S306>' : 'PID_LOOP/Controller/PID 6/N Gain/Internal Parameters'
 * '<S307>' : 'PID_LOOP/Controller/PID 6/P Copy/Disabled'
 * '<S308>' : 'PID_LOOP/Controller/PID 6/Parallel P Gain/Internal Parameters'
 * '<S309>' : 'PID_LOOP/Controller/PID 6/Reset Signal/Disabled'
 * '<S310>' : 'PID_LOOP/Controller/PID 6/Saturation/Passthrough'
 * '<S311>' : 'PID_LOOP/Controller/PID 6/Saturation Fdbk/Disabled'
 * '<S312>' : 'PID_LOOP/Controller/PID 6/Sum/Sum_PID'
 * '<S313>' : 'PID_LOOP/Controller/PID 6/Sum Fdbk/Disabled'
 * '<S314>' : 'PID_LOOP/Controller/PID 6/Tracking Mode/Disabled'
 * '<S315>' : 'PID_LOOP/Controller/PID 6/Tracking Mode Sum/Passthrough'
 * '<S316>' : 'PID_LOOP/Controller/PID 6/Tsamp - Integral/TsSignalSpecification'
 * '<S317>' : 'PID_LOOP/Controller/PID 6/Tsamp - Ngain/Passthrough'
 * '<S318>' : 'PID_LOOP/Controller/PID 6/postSat Signal/Forward_Path'
 * '<S319>' : 'PID_LOOP/Controller/PID 6/preInt Signal/Internal PreInt'
 * '<S320>' : 'PID_LOOP/Controller/PID 6/preSat Signal/Forward_Path'
 */
#endif                                 /* Controller_h_ */
