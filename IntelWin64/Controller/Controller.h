//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// File: Controller.h
//
// Code generated for Simulink model 'Controller'.
//
// Model version                  : 1.64
// Simulink Coder version         : 24.2 (R2024b) 21-Jun-2024
// C/C++ source code generated on : Sat Apr 19 19:10:07 2025
//
// Target selection: ert.tlc
// Embedded hardware selection: Intel->x86-64 (Windows64)
// Code generation objectives:
//    1. Debugging
//    2. Execution efficiency
//    3. Traceability
// Validation result: Not run
//
#ifndef Controller_h_
#define Controller_h_
#include <cmath>
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include <cstring>
#ifndef ODE3_INTG
#define ODE3_INTG

// ODE3 Integration Data
struct ODE3_IntgData {
  real_T *y;                           // output
  real_T *f[3];                        // derivatives
};

#endif

extern "C"
{
  static real_T rtGetNaN(void);
  static real32_T rtGetNaNF(void);
}                                      // extern "C"

extern "C"
{
  extern real_T rtInf;
  extern real_T rtMinusInf;
  extern real_T rtNaN;
  extern real32_T rtInfF;
  extern real32_T rtMinusInfF;
  extern real32_T rtNaNF;
  static boolean_T rtIsInf(real_T value);
  static boolean_T rtIsInfF(real32_T value);
  static boolean_T rtIsNaN(real_T value);
  static boolean_T rtIsNaNF(real32_T value);
}                                      // extern "C"

// Class declaration for model Controller
class Controller final
{
  // public data and function members
 public:
  // Block signals and states (default storage) for system '<Root>'
  struct DW {
    real_T FilterCoefficient;          // '<S46>/Filter Coefficient'
    real_T FilterCoefficient_d;        // '<S98>/Filter Coefficient'
    real_T FilterCoefficient_g;        // '<S150>/Filter Coefficient'
    real_T FilterCoefficient_p;        // '<S202>/Filter Coefficient'
    real_T FilterCoefficient_m;        // '<S254>/Filter Coefficient'
    real_T FilterCoefficient_j;        // '<S306>/Filter Coefficient'
  };

  // Continuous states (default storage)
  struct X {
    real_T Integrator_CSTATE;          // '<S43>/Integrator'
    real_T Filter_CSTATE;              // '<S38>/Filter'
    real_T Integrator_CSTATE_m;        // '<S95>/Integrator'
    real_T Filter_CSTATE_i;            // '<S90>/Filter'
    real_T Integrator_CSTATE_j;        // '<S147>/Integrator'
    real_T Filter_CSTATE_e;            // '<S142>/Filter'
    real_T Integrator_CSTATE_k;        // '<S199>/Integrator'
    real_T Filter_CSTATE_j;            // '<S194>/Filter'
    real_T Integrator_CSTATE_p;        // '<S251>/Integrator'
    real_T Filter_CSTATE_o;            // '<S246>/Filter'
    real_T Integrator_CSTATE_h;        // '<S303>/Integrator'
    real_T Filter_CSTATE_a;            // '<S298>/Filter'
  };

  // State derivatives (default storage)
  struct XDot {
    real_T Integrator_CSTATE;          // '<S43>/Integrator'
    real_T Filter_CSTATE;              // '<S38>/Filter'
    real_T Integrator_CSTATE_m;        // '<S95>/Integrator'
    real_T Filter_CSTATE_i;            // '<S90>/Filter'
    real_T Integrator_CSTATE_j;        // '<S147>/Integrator'
    real_T Filter_CSTATE_e;            // '<S142>/Filter'
    real_T Integrator_CSTATE_k;        // '<S199>/Integrator'
    real_T Filter_CSTATE_j;            // '<S194>/Filter'
    real_T Integrator_CSTATE_p;        // '<S251>/Integrator'
    real_T Filter_CSTATE_o;            // '<S246>/Filter'
    real_T Integrator_CSTATE_h;        // '<S303>/Integrator'
    real_T Filter_CSTATE_a;            // '<S298>/Filter'
  };

  // State disabled
  struct XDis {
    boolean_T Integrator_CSTATE;       // '<S43>/Integrator'
    boolean_T Filter_CSTATE;           // '<S38>/Filter'
    boolean_T Integrator_CSTATE_m;     // '<S95>/Integrator'
    boolean_T Filter_CSTATE_i;         // '<S90>/Filter'
    boolean_T Integrator_CSTATE_j;     // '<S147>/Integrator'
    boolean_T Filter_CSTATE_e;         // '<S142>/Filter'
    boolean_T Integrator_CSTATE_k;     // '<S199>/Integrator'
    boolean_T Filter_CSTATE_j;         // '<S194>/Filter'
    boolean_T Integrator_CSTATE_p;     // '<S251>/Integrator'
    boolean_T Filter_CSTATE_o;         // '<S246>/Filter'
    boolean_T Integrator_CSTATE_h;     // '<S303>/Integrator'
    boolean_T Filter_CSTATE_a;         // '<S298>/Filter'
  };

  // Constant parameters (default storage)
  struct ConstP {
    // Expression: wrench
    //  Referenced by: '<S1>/MATLAB Function'

    real_T MATLABFunction_wrench[48];
  };

  // External inputs (root inport signals with default storage)
  struct ExtU {
    real_T Error[6];                   // '<Root>/Error'
  };

  // External outputs (root outports fed by signals with default storage)
  struct ExtY {
    real_T PWM[8];                     // '<Root>/PWM'
  };

  // Real-time Model Data Structure
  using odeFSubArray = real_T[12];
  struct RT_MODEL {
    const char_T *errorStatus;
    RTWSolverInfo solverInfo;
    X *contStates;
    int_T *periodicContStateIndices;
    real_T *periodicContStateRanges;
    real_T *derivs;
    XDis *contStateDisabled;
    boolean_T zCCacheNeedsReset;
    boolean_T derivCacheNeedsReset;
    boolean_T CTOutputIncnstWithState;
    real_T odeY[12];
    real_T odeF[3][12];
    ODE3_IntgData intgData;

    //
    //  Sizes:
    //  The following substructure contains sizes information
    //  for many of the model attributes such as inputs, outputs,
    //  dwork, sample times, etc.

    struct {
      int_T numContStates;
      int_T numPeriodicContStates;
      int_T numSampTimes;
    } Sizes;

    //
    //  Timing:
    //  The following substructure contains information regarding
    //  the timing information for the model.

    struct {
      uint32_T clockTick0;
      time_T stepSize0;
      uint32_T clockTick1;
      time_T tStart;
      SimTimeStep simTimeStep;
      boolean_T stopRequestedFlag;
      time_T *t;
      time_T tArray[2];
    } Timing;

    time_T** getTPtrPtr();
    boolean_T getStopRequested() const;
    void setStopRequested(boolean_T aStopRequested);
    const char_T* getErrorStatus() const;
    void setErrorStatus(const char_T* const aErrorStatus);
    time_T* getTPtr() const;
    void setTPtr(time_T* aTPtr);
    boolean_T* getStopRequestedPtr();
    const char_T** getErrorStatusPtr();
    boolean_T isMajorTimeStep() const;
    boolean_T isMinorTimeStep() const;
    time_T getTStart() const;
  };

  // Copy Constructor
  Controller(Controller const&) = delete;

  // Assignment Operator
  Controller& operator= (Controller const&) & = delete;

  // Move Constructor
  Controller(Controller &&) = delete;

  // Move Assignment Operator
  Controller& operator= (Controller &&) = delete;

  // Real-Time Model get method
  Controller::RT_MODEL * getRTM();

  // External inputs
  ExtU rtU;

  // External outputs
  ExtY rtY;

  // model initialize function
  void initialize();

  // model step function
  void step();

  // Constructor
  Controller();

  // Destructor
  ~Controller();

  // private data and function members
 private:
  // Block states
  DW rtDW;

  // Block continuous states
  X rtX;

  // Block Continuous state disabled vector
  XDis rtXDis;

  // private member function(s) for subsystem '<Root>'
  real_T xzlangeM(const real_T x[48]);
  void xzlascl(real_T cfrom, real_T cto, int32_T m, int32_T n, real_T A[48],
               int32_T iA0, int32_T lda);
  real_T xnrm2(int32_T n, const real_T x[48], int32_T ix0);
  real_T xdotc(int32_T n, const real_T x[48], int32_T ix0, const real_T y[48],
               int32_T iy0);
  void xaxpy(int32_T n, real_T a, int32_T ix0, real_T y[48], int32_T iy0);
  real_T xnrm2_g(int32_T n, const real_T x[6], int32_T ix0);
  void xaxpy_i(int32_T n, real_T a, const real_T x[48], int32_T ix0, real_T y[8],
               int32_T iy0);
  void xaxpy_iv(int32_T n, real_T a, const real_T x[8], int32_T ix0, real_T y[48],
                int32_T iy0);
  real_T xdotc_l(int32_T n, const real_T x[36], int32_T ix0, const real_T y[36],
                 int32_T iy0);
  void xaxpy_ivt(int32_T n, real_T a, int32_T ix0, real_T y[36], int32_T iy0);
  void xzlascl_h(real_T cfrom, real_T cto, int32_T m, int32_T n, real_T A[6],
                 int32_T iA0, int32_T lda);
  void xswap(real_T x[36], int32_T ix0, int32_T iy0);
  void xswap_j(real_T x[48], int32_T ix0, int32_T iy0);
  void xrotg(real_T *a, real_T *b, real_T *c, real_T *s);
  void xrot(real_T x[36], int32_T ix0, int32_T iy0, real_T c, real_T s);
  void xrot_c(real_T x[48], int32_T ix0, int32_T iy0, real_T c, real_T s);
  void svd(const real_T A[48], real_T U[48], real_T s[6], real_T V[36]);

  // Global mass matrix

  // Continuous states update member function
  void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si );

  // Derivatives member function
  void Controller_derivatives();

  // Real-Time Model
  RT_MODEL rtM;
};

// Constant parameters (default storage)
extern const Controller::ConstP rtConstP;

//-
//  These blocks were eliminated from the model due to optimizations:
//
//  Block '<S40>/Integral Gain' : Eliminated nontunable gain of 1
//  Block '<S92>/Integral Gain' : Eliminated nontunable gain of 1
//  Block '<S144>/Integral Gain' : Eliminated nontunable gain of 1
//  Block '<S196>/Integral Gain' : Eliminated nontunable gain of 1
//  Block '<S248>/Integral Gain' : Eliminated nontunable gain of 1
//  Block '<S300>/Integral Gain' : Eliminated nontunable gain of 1


//-
//  The generated code includes comments that allow you to trace directly
//  back to the appropriate location in the model.  The basic format
//  is <system>/block_name, where system is the system number (uniquely
//  assigned by Simulink) and block_name is the name of the block.
//
//  Note that this particular code originates from a subsystem build,
//  and has its own system numbers different from the parent model.
//  Refer to the system hierarchy for this subsystem below, and use the
//  MATLAB hilite_system command to trace the generated code back
//  to the parent model.  For example,
//
//  hilite_system('PID_LOOP/Controller')    - opens subsystem PID_LOOP/Controller
//  hilite_system('PID_LOOP/Controller/Kp') - opens and selects block Kp
//
//  Here is the system hierarchy for this model
//
//  '<Root>' : 'PID_LOOP'
//  '<S1>'   : 'PID_LOOP/Controller'
//  '<S2>'   : 'PID_LOOP/Controller/MATLAB Function'
//  '<S3>'   : 'PID_LOOP/Controller/PID 1'
//  '<S4>'   : 'PID_LOOP/Controller/PID 2'
//  '<S5>'   : 'PID_LOOP/Controller/PID 3'
//  '<S6>'   : 'PID_LOOP/Controller/PID 4'
//  '<S7>'   : 'PID_LOOP/Controller/PID 5'
//  '<S8>'   : 'PID_LOOP/Controller/PID 6'
//  '<S9>'   : 'PID_LOOP/Controller/PID 1/Anti-windup'
//  '<S10>'  : 'PID_LOOP/Controller/PID 1/D Gain'
//  '<S11>'  : 'PID_LOOP/Controller/PID 1/External Derivative'
//  '<S12>'  : 'PID_LOOP/Controller/PID 1/Filter'
//  '<S13>'  : 'PID_LOOP/Controller/PID 1/Filter ICs'
//  '<S14>'  : 'PID_LOOP/Controller/PID 1/I Gain'
//  '<S15>'  : 'PID_LOOP/Controller/PID 1/Ideal P Gain'
//  '<S16>'  : 'PID_LOOP/Controller/PID 1/Ideal P Gain Fdbk'
//  '<S17>'  : 'PID_LOOP/Controller/PID 1/Integrator'
//  '<S18>'  : 'PID_LOOP/Controller/PID 1/Integrator ICs'
//  '<S19>'  : 'PID_LOOP/Controller/PID 1/N Copy'
//  '<S20>'  : 'PID_LOOP/Controller/PID 1/N Gain'
//  '<S21>'  : 'PID_LOOP/Controller/PID 1/P Copy'
//  '<S22>'  : 'PID_LOOP/Controller/PID 1/Parallel P Gain'
//  '<S23>'  : 'PID_LOOP/Controller/PID 1/Reset Signal'
//  '<S24>'  : 'PID_LOOP/Controller/PID 1/Saturation'
//  '<S25>'  : 'PID_LOOP/Controller/PID 1/Saturation Fdbk'
//  '<S26>'  : 'PID_LOOP/Controller/PID 1/Sum'
//  '<S27>'  : 'PID_LOOP/Controller/PID 1/Sum Fdbk'
//  '<S28>'  : 'PID_LOOP/Controller/PID 1/Tracking Mode'
//  '<S29>'  : 'PID_LOOP/Controller/PID 1/Tracking Mode Sum'
//  '<S30>'  : 'PID_LOOP/Controller/PID 1/Tsamp - Integral'
//  '<S31>'  : 'PID_LOOP/Controller/PID 1/Tsamp - Ngain'
//  '<S32>'  : 'PID_LOOP/Controller/PID 1/postSat Signal'
//  '<S33>'  : 'PID_LOOP/Controller/PID 1/preInt Signal'
//  '<S34>'  : 'PID_LOOP/Controller/PID 1/preSat Signal'
//  '<S35>'  : 'PID_LOOP/Controller/PID 1/Anti-windup/Passthrough'
//  '<S36>'  : 'PID_LOOP/Controller/PID 1/D Gain/Internal Parameters'
//  '<S37>'  : 'PID_LOOP/Controller/PID 1/External Derivative/Error'
//  '<S38>'  : 'PID_LOOP/Controller/PID 1/Filter/Cont. Filter'
//  '<S39>'  : 'PID_LOOP/Controller/PID 1/Filter ICs/Internal IC - Filter'
//  '<S40>'  : 'PID_LOOP/Controller/PID 1/I Gain/Internal Parameters'
//  '<S41>'  : 'PID_LOOP/Controller/PID 1/Ideal P Gain/Passthrough'
//  '<S42>'  : 'PID_LOOP/Controller/PID 1/Ideal P Gain Fdbk/Disabled'
//  '<S43>'  : 'PID_LOOP/Controller/PID 1/Integrator/Continuous'
//  '<S44>'  : 'PID_LOOP/Controller/PID 1/Integrator ICs/Internal IC'
//  '<S45>'  : 'PID_LOOP/Controller/PID 1/N Copy/Disabled'
//  '<S46>'  : 'PID_LOOP/Controller/PID 1/N Gain/Internal Parameters'
//  '<S47>'  : 'PID_LOOP/Controller/PID 1/P Copy/Disabled'
//  '<S48>'  : 'PID_LOOP/Controller/PID 1/Parallel P Gain/Internal Parameters'
//  '<S49>'  : 'PID_LOOP/Controller/PID 1/Reset Signal/Disabled'
//  '<S50>'  : 'PID_LOOP/Controller/PID 1/Saturation/Passthrough'
//  '<S51>'  : 'PID_LOOP/Controller/PID 1/Saturation Fdbk/Disabled'
//  '<S52>'  : 'PID_LOOP/Controller/PID 1/Sum/Sum_PID'
//  '<S53>'  : 'PID_LOOP/Controller/PID 1/Sum Fdbk/Disabled'
//  '<S54>'  : 'PID_LOOP/Controller/PID 1/Tracking Mode/Disabled'
//  '<S55>'  : 'PID_LOOP/Controller/PID 1/Tracking Mode Sum/Passthrough'
//  '<S56>'  : 'PID_LOOP/Controller/PID 1/Tsamp - Integral/TsSignalSpecification'
//  '<S57>'  : 'PID_LOOP/Controller/PID 1/Tsamp - Ngain/Passthrough'
//  '<S58>'  : 'PID_LOOP/Controller/PID 1/postSat Signal/Forward_Path'
//  '<S59>'  : 'PID_LOOP/Controller/PID 1/preInt Signal/Internal PreInt'
//  '<S60>'  : 'PID_LOOP/Controller/PID 1/preSat Signal/Forward_Path'
//  '<S61>'  : 'PID_LOOP/Controller/PID 2/Anti-windup'
//  '<S62>'  : 'PID_LOOP/Controller/PID 2/D Gain'
//  '<S63>'  : 'PID_LOOP/Controller/PID 2/External Derivative'
//  '<S64>'  : 'PID_LOOP/Controller/PID 2/Filter'
//  '<S65>'  : 'PID_LOOP/Controller/PID 2/Filter ICs'
//  '<S66>'  : 'PID_LOOP/Controller/PID 2/I Gain'
//  '<S67>'  : 'PID_LOOP/Controller/PID 2/Ideal P Gain'
//  '<S68>'  : 'PID_LOOP/Controller/PID 2/Ideal P Gain Fdbk'
//  '<S69>'  : 'PID_LOOP/Controller/PID 2/Integrator'
//  '<S70>'  : 'PID_LOOP/Controller/PID 2/Integrator ICs'
//  '<S71>'  : 'PID_LOOP/Controller/PID 2/N Copy'
//  '<S72>'  : 'PID_LOOP/Controller/PID 2/N Gain'
//  '<S73>'  : 'PID_LOOP/Controller/PID 2/P Copy'
//  '<S74>'  : 'PID_LOOP/Controller/PID 2/Parallel P Gain'
//  '<S75>'  : 'PID_LOOP/Controller/PID 2/Reset Signal'
//  '<S76>'  : 'PID_LOOP/Controller/PID 2/Saturation'
//  '<S77>'  : 'PID_LOOP/Controller/PID 2/Saturation Fdbk'
//  '<S78>'  : 'PID_LOOP/Controller/PID 2/Sum'
//  '<S79>'  : 'PID_LOOP/Controller/PID 2/Sum Fdbk'
//  '<S80>'  : 'PID_LOOP/Controller/PID 2/Tracking Mode'
//  '<S81>'  : 'PID_LOOP/Controller/PID 2/Tracking Mode Sum'
//  '<S82>'  : 'PID_LOOP/Controller/PID 2/Tsamp - Integral'
//  '<S83>'  : 'PID_LOOP/Controller/PID 2/Tsamp - Ngain'
//  '<S84>'  : 'PID_LOOP/Controller/PID 2/postSat Signal'
//  '<S85>'  : 'PID_LOOP/Controller/PID 2/preInt Signal'
//  '<S86>'  : 'PID_LOOP/Controller/PID 2/preSat Signal'
//  '<S87>'  : 'PID_LOOP/Controller/PID 2/Anti-windup/Passthrough'
//  '<S88>'  : 'PID_LOOP/Controller/PID 2/D Gain/Internal Parameters'
//  '<S89>'  : 'PID_LOOP/Controller/PID 2/External Derivative/Error'
//  '<S90>'  : 'PID_LOOP/Controller/PID 2/Filter/Cont. Filter'
//  '<S91>'  : 'PID_LOOP/Controller/PID 2/Filter ICs/Internal IC - Filter'
//  '<S92>'  : 'PID_LOOP/Controller/PID 2/I Gain/Internal Parameters'
//  '<S93>'  : 'PID_LOOP/Controller/PID 2/Ideal P Gain/Passthrough'
//  '<S94>'  : 'PID_LOOP/Controller/PID 2/Ideal P Gain Fdbk/Disabled'
//  '<S95>'  : 'PID_LOOP/Controller/PID 2/Integrator/Continuous'
//  '<S96>'  : 'PID_LOOP/Controller/PID 2/Integrator ICs/Internal IC'
//  '<S97>'  : 'PID_LOOP/Controller/PID 2/N Copy/Disabled'
//  '<S98>'  : 'PID_LOOP/Controller/PID 2/N Gain/Internal Parameters'
//  '<S99>'  : 'PID_LOOP/Controller/PID 2/P Copy/Disabled'
//  '<S100>' : 'PID_LOOP/Controller/PID 2/Parallel P Gain/Internal Parameters'
//  '<S101>' : 'PID_LOOP/Controller/PID 2/Reset Signal/Disabled'
//  '<S102>' : 'PID_LOOP/Controller/PID 2/Saturation/Passthrough'
//  '<S103>' : 'PID_LOOP/Controller/PID 2/Saturation Fdbk/Disabled'
//  '<S104>' : 'PID_LOOP/Controller/PID 2/Sum/Sum_PID'
//  '<S105>' : 'PID_LOOP/Controller/PID 2/Sum Fdbk/Disabled'
//  '<S106>' : 'PID_LOOP/Controller/PID 2/Tracking Mode/Disabled'
//  '<S107>' : 'PID_LOOP/Controller/PID 2/Tracking Mode Sum/Passthrough'
//  '<S108>' : 'PID_LOOP/Controller/PID 2/Tsamp - Integral/TsSignalSpecification'
//  '<S109>' : 'PID_LOOP/Controller/PID 2/Tsamp - Ngain/Passthrough'
//  '<S110>' : 'PID_LOOP/Controller/PID 2/postSat Signal/Forward_Path'
//  '<S111>' : 'PID_LOOP/Controller/PID 2/preInt Signal/Internal PreInt'
//  '<S112>' : 'PID_LOOP/Controller/PID 2/preSat Signal/Forward_Path'
//  '<S113>' : 'PID_LOOP/Controller/PID 3/Anti-windup'
//  '<S114>' : 'PID_LOOP/Controller/PID 3/D Gain'
//  '<S115>' : 'PID_LOOP/Controller/PID 3/External Derivative'
//  '<S116>' : 'PID_LOOP/Controller/PID 3/Filter'
//  '<S117>' : 'PID_LOOP/Controller/PID 3/Filter ICs'
//  '<S118>' : 'PID_LOOP/Controller/PID 3/I Gain'
//  '<S119>' : 'PID_LOOP/Controller/PID 3/Ideal P Gain'
//  '<S120>' : 'PID_LOOP/Controller/PID 3/Ideal P Gain Fdbk'
//  '<S121>' : 'PID_LOOP/Controller/PID 3/Integrator'
//  '<S122>' : 'PID_LOOP/Controller/PID 3/Integrator ICs'
//  '<S123>' : 'PID_LOOP/Controller/PID 3/N Copy'
//  '<S124>' : 'PID_LOOP/Controller/PID 3/N Gain'
//  '<S125>' : 'PID_LOOP/Controller/PID 3/P Copy'
//  '<S126>' : 'PID_LOOP/Controller/PID 3/Parallel P Gain'
//  '<S127>' : 'PID_LOOP/Controller/PID 3/Reset Signal'
//  '<S128>' : 'PID_LOOP/Controller/PID 3/Saturation'
//  '<S129>' : 'PID_LOOP/Controller/PID 3/Saturation Fdbk'
//  '<S130>' : 'PID_LOOP/Controller/PID 3/Sum'
//  '<S131>' : 'PID_LOOP/Controller/PID 3/Sum Fdbk'
//  '<S132>' : 'PID_LOOP/Controller/PID 3/Tracking Mode'
//  '<S133>' : 'PID_LOOP/Controller/PID 3/Tracking Mode Sum'
//  '<S134>' : 'PID_LOOP/Controller/PID 3/Tsamp - Integral'
//  '<S135>' : 'PID_LOOP/Controller/PID 3/Tsamp - Ngain'
//  '<S136>' : 'PID_LOOP/Controller/PID 3/postSat Signal'
//  '<S137>' : 'PID_LOOP/Controller/PID 3/preInt Signal'
//  '<S138>' : 'PID_LOOP/Controller/PID 3/preSat Signal'
//  '<S139>' : 'PID_LOOP/Controller/PID 3/Anti-windup/Passthrough'
//  '<S140>' : 'PID_LOOP/Controller/PID 3/D Gain/Internal Parameters'
//  '<S141>' : 'PID_LOOP/Controller/PID 3/External Derivative/Error'
//  '<S142>' : 'PID_LOOP/Controller/PID 3/Filter/Cont. Filter'
//  '<S143>' : 'PID_LOOP/Controller/PID 3/Filter ICs/Internal IC - Filter'
//  '<S144>' : 'PID_LOOP/Controller/PID 3/I Gain/Internal Parameters'
//  '<S145>' : 'PID_LOOP/Controller/PID 3/Ideal P Gain/Passthrough'
//  '<S146>' : 'PID_LOOP/Controller/PID 3/Ideal P Gain Fdbk/Disabled'
//  '<S147>' : 'PID_LOOP/Controller/PID 3/Integrator/Continuous'
//  '<S148>' : 'PID_LOOP/Controller/PID 3/Integrator ICs/Internal IC'
//  '<S149>' : 'PID_LOOP/Controller/PID 3/N Copy/Disabled'
//  '<S150>' : 'PID_LOOP/Controller/PID 3/N Gain/Internal Parameters'
//  '<S151>' : 'PID_LOOP/Controller/PID 3/P Copy/Disabled'
//  '<S152>' : 'PID_LOOP/Controller/PID 3/Parallel P Gain/Internal Parameters'
//  '<S153>' : 'PID_LOOP/Controller/PID 3/Reset Signal/Disabled'
//  '<S154>' : 'PID_LOOP/Controller/PID 3/Saturation/Passthrough'
//  '<S155>' : 'PID_LOOP/Controller/PID 3/Saturation Fdbk/Disabled'
//  '<S156>' : 'PID_LOOP/Controller/PID 3/Sum/Sum_PID'
//  '<S157>' : 'PID_LOOP/Controller/PID 3/Sum Fdbk/Disabled'
//  '<S158>' : 'PID_LOOP/Controller/PID 3/Tracking Mode/Disabled'
//  '<S159>' : 'PID_LOOP/Controller/PID 3/Tracking Mode Sum/Passthrough'
//  '<S160>' : 'PID_LOOP/Controller/PID 3/Tsamp - Integral/TsSignalSpecification'
//  '<S161>' : 'PID_LOOP/Controller/PID 3/Tsamp - Ngain/Passthrough'
//  '<S162>' : 'PID_LOOP/Controller/PID 3/postSat Signal/Forward_Path'
//  '<S163>' : 'PID_LOOP/Controller/PID 3/preInt Signal/Internal PreInt'
//  '<S164>' : 'PID_LOOP/Controller/PID 3/preSat Signal/Forward_Path'
//  '<S165>' : 'PID_LOOP/Controller/PID 4/Anti-windup'
//  '<S166>' : 'PID_LOOP/Controller/PID 4/D Gain'
//  '<S167>' : 'PID_LOOP/Controller/PID 4/External Derivative'
//  '<S168>' : 'PID_LOOP/Controller/PID 4/Filter'
//  '<S169>' : 'PID_LOOP/Controller/PID 4/Filter ICs'
//  '<S170>' : 'PID_LOOP/Controller/PID 4/I Gain'
//  '<S171>' : 'PID_LOOP/Controller/PID 4/Ideal P Gain'
//  '<S172>' : 'PID_LOOP/Controller/PID 4/Ideal P Gain Fdbk'
//  '<S173>' : 'PID_LOOP/Controller/PID 4/Integrator'
//  '<S174>' : 'PID_LOOP/Controller/PID 4/Integrator ICs'
//  '<S175>' : 'PID_LOOP/Controller/PID 4/N Copy'
//  '<S176>' : 'PID_LOOP/Controller/PID 4/N Gain'
//  '<S177>' : 'PID_LOOP/Controller/PID 4/P Copy'
//  '<S178>' : 'PID_LOOP/Controller/PID 4/Parallel P Gain'
//  '<S179>' : 'PID_LOOP/Controller/PID 4/Reset Signal'
//  '<S180>' : 'PID_LOOP/Controller/PID 4/Saturation'
//  '<S181>' : 'PID_LOOP/Controller/PID 4/Saturation Fdbk'
//  '<S182>' : 'PID_LOOP/Controller/PID 4/Sum'
//  '<S183>' : 'PID_LOOP/Controller/PID 4/Sum Fdbk'
//  '<S184>' : 'PID_LOOP/Controller/PID 4/Tracking Mode'
//  '<S185>' : 'PID_LOOP/Controller/PID 4/Tracking Mode Sum'
//  '<S186>' : 'PID_LOOP/Controller/PID 4/Tsamp - Integral'
//  '<S187>' : 'PID_LOOP/Controller/PID 4/Tsamp - Ngain'
//  '<S188>' : 'PID_LOOP/Controller/PID 4/postSat Signal'
//  '<S189>' : 'PID_LOOP/Controller/PID 4/preInt Signal'
//  '<S190>' : 'PID_LOOP/Controller/PID 4/preSat Signal'
//  '<S191>' : 'PID_LOOP/Controller/PID 4/Anti-windup/Passthrough'
//  '<S192>' : 'PID_LOOP/Controller/PID 4/D Gain/Internal Parameters'
//  '<S193>' : 'PID_LOOP/Controller/PID 4/External Derivative/Error'
//  '<S194>' : 'PID_LOOP/Controller/PID 4/Filter/Cont. Filter'
//  '<S195>' : 'PID_LOOP/Controller/PID 4/Filter ICs/Internal IC - Filter'
//  '<S196>' : 'PID_LOOP/Controller/PID 4/I Gain/Internal Parameters'
//  '<S197>' : 'PID_LOOP/Controller/PID 4/Ideal P Gain/Passthrough'
//  '<S198>' : 'PID_LOOP/Controller/PID 4/Ideal P Gain Fdbk/Disabled'
//  '<S199>' : 'PID_LOOP/Controller/PID 4/Integrator/Continuous'
//  '<S200>' : 'PID_LOOP/Controller/PID 4/Integrator ICs/Internal IC'
//  '<S201>' : 'PID_LOOP/Controller/PID 4/N Copy/Disabled'
//  '<S202>' : 'PID_LOOP/Controller/PID 4/N Gain/Internal Parameters'
//  '<S203>' : 'PID_LOOP/Controller/PID 4/P Copy/Disabled'
//  '<S204>' : 'PID_LOOP/Controller/PID 4/Parallel P Gain/Internal Parameters'
//  '<S205>' : 'PID_LOOP/Controller/PID 4/Reset Signal/Disabled'
//  '<S206>' : 'PID_LOOP/Controller/PID 4/Saturation/Passthrough'
//  '<S207>' : 'PID_LOOP/Controller/PID 4/Saturation Fdbk/Disabled'
//  '<S208>' : 'PID_LOOP/Controller/PID 4/Sum/Sum_PID'
//  '<S209>' : 'PID_LOOP/Controller/PID 4/Sum Fdbk/Disabled'
//  '<S210>' : 'PID_LOOP/Controller/PID 4/Tracking Mode/Disabled'
//  '<S211>' : 'PID_LOOP/Controller/PID 4/Tracking Mode Sum/Passthrough'
//  '<S212>' : 'PID_LOOP/Controller/PID 4/Tsamp - Integral/TsSignalSpecification'
//  '<S213>' : 'PID_LOOP/Controller/PID 4/Tsamp - Ngain/Passthrough'
//  '<S214>' : 'PID_LOOP/Controller/PID 4/postSat Signal/Forward_Path'
//  '<S215>' : 'PID_LOOP/Controller/PID 4/preInt Signal/Internal PreInt'
//  '<S216>' : 'PID_LOOP/Controller/PID 4/preSat Signal/Forward_Path'
//  '<S217>' : 'PID_LOOP/Controller/PID 5/Anti-windup'
//  '<S218>' : 'PID_LOOP/Controller/PID 5/D Gain'
//  '<S219>' : 'PID_LOOP/Controller/PID 5/External Derivative'
//  '<S220>' : 'PID_LOOP/Controller/PID 5/Filter'
//  '<S221>' : 'PID_LOOP/Controller/PID 5/Filter ICs'
//  '<S222>' : 'PID_LOOP/Controller/PID 5/I Gain'
//  '<S223>' : 'PID_LOOP/Controller/PID 5/Ideal P Gain'
//  '<S224>' : 'PID_LOOP/Controller/PID 5/Ideal P Gain Fdbk'
//  '<S225>' : 'PID_LOOP/Controller/PID 5/Integrator'
//  '<S226>' : 'PID_LOOP/Controller/PID 5/Integrator ICs'
//  '<S227>' : 'PID_LOOP/Controller/PID 5/N Copy'
//  '<S228>' : 'PID_LOOP/Controller/PID 5/N Gain'
//  '<S229>' : 'PID_LOOP/Controller/PID 5/P Copy'
//  '<S230>' : 'PID_LOOP/Controller/PID 5/Parallel P Gain'
//  '<S231>' : 'PID_LOOP/Controller/PID 5/Reset Signal'
//  '<S232>' : 'PID_LOOP/Controller/PID 5/Saturation'
//  '<S233>' : 'PID_LOOP/Controller/PID 5/Saturation Fdbk'
//  '<S234>' : 'PID_LOOP/Controller/PID 5/Sum'
//  '<S235>' : 'PID_LOOP/Controller/PID 5/Sum Fdbk'
//  '<S236>' : 'PID_LOOP/Controller/PID 5/Tracking Mode'
//  '<S237>' : 'PID_LOOP/Controller/PID 5/Tracking Mode Sum'
//  '<S238>' : 'PID_LOOP/Controller/PID 5/Tsamp - Integral'
//  '<S239>' : 'PID_LOOP/Controller/PID 5/Tsamp - Ngain'
//  '<S240>' : 'PID_LOOP/Controller/PID 5/postSat Signal'
//  '<S241>' : 'PID_LOOP/Controller/PID 5/preInt Signal'
//  '<S242>' : 'PID_LOOP/Controller/PID 5/preSat Signal'
//  '<S243>' : 'PID_LOOP/Controller/PID 5/Anti-windup/Passthrough'
//  '<S244>' : 'PID_LOOP/Controller/PID 5/D Gain/Internal Parameters'
//  '<S245>' : 'PID_LOOP/Controller/PID 5/External Derivative/Error'
//  '<S246>' : 'PID_LOOP/Controller/PID 5/Filter/Cont. Filter'
//  '<S247>' : 'PID_LOOP/Controller/PID 5/Filter ICs/Internal IC - Filter'
//  '<S248>' : 'PID_LOOP/Controller/PID 5/I Gain/Internal Parameters'
//  '<S249>' : 'PID_LOOP/Controller/PID 5/Ideal P Gain/Passthrough'
//  '<S250>' : 'PID_LOOP/Controller/PID 5/Ideal P Gain Fdbk/Disabled'
//  '<S251>' : 'PID_LOOP/Controller/PID 5/Integrator/Continuous'
//  '<S252>' : 'PID_LOOP/Controller/PID 5/Integrator ICs/Internal IC'
//  '<S253>' : 'PID_LOOP/Controller/PID 5/N Copy/Disabled'
//  '<S254>' : 'PID_LOOP/Controller/PID 5/N Gain/Internal Parameters'
//  '<S255>' : 'PID_LOOP/Controller/PID 5/P Copy/Disabled'
//  '<S256>' : 'PID_LOOP/Controller/PID 5/Parallel P Gain/Internal Parameters'
//  '<S257>' : 'PID_LOOP/Controller/PID 5/Reset Signal/Disabled'
//  '<S258>' : 'PID_LOOP/Controller/PID 5/Saturation/Passthrough'
//  '<S259>' : 'PID_LOOP/Controller/PID 5/Saturation Fdbk/Disabled'
//  '<S260>' : 'PID_LOOP/Controller/PID 5/Sum/Sum_PID'
//  '<S261>' : 'PID_LOOP/Controller/PID 5/Sum Fdbk/Disabled'
//  '<S262>' : 'PID_LOOP/Controller/PID 5/Tracking Mode/Disabled'
//  '<S263>' : 'PID_LOOP/Controller/PID 5/Tracking Mode Sum/Passthrough'
//  '<S264>' : 'PID_LOOP/Controller/PID 5/Tsamp - Integral/TsSignalSpecification'
//  '<S265>' : 'PID_LOOP/Controller/PID 5/Tsamp - Ngain/Passthrough'
//  '<S266>' : 'PID_LOOP/Controller/PID 5/postSat Signal/Forward_Path'
//  '<S267>' : 'PID_LOOP/Controller/PID 5/preInt Signal/Internal PreInt'
//  '<S268>' : 'PID_LOOP/Controller/PID 5/preSat Signal/Forward_Path'
//  '<S269>' : 'PID_LOOP/Controller/PID 6/Anti-windup'
//  '<S270>' : 'PID_LOOP/Controller/PID 6/D Gain'
//  '<S271>' : 'PID_LOOP/Controller/PID 6/External Derivative'
//  '<S272>' : 'PID_LOOP/Controller/PID 6/Filter'
//  '<S273>' : 'PID_LOOP/Controller/PID 6/Filter ICs'
//  '<S274>' : 'PID_LOOP/Controller/PID 6/I Gain'
//  '<S275>' : 'PID_LOOP/Controller/PID 6/Ideal P Gain'
//  '<S276>' : 'PID_LOOP/Controller/PID 6/Ideal P Gain Fdbk'
//  '<S277>' : 'PID_LOOP/Controller/PID 6/Integrator'
//  '<S278>' : 'PID_LOOP/Controller/PID 6/Integrator ICs'
//  '<S279>' : 'PID_LOOP/Controller/PID 6/N Copy'
//  '<S280>' : 'PID_LOOP/Controller/PID 6/N Gain'
//  '<S281>' : 'PID_LOOP/Controller/PID 6/P Copy'
//  '<S282>' : 'PID_LOOP/Controller/PID 6/Parallel P Gain'
//  '<S283>' : 'PID_LOOP/Controller/PID 6/Reset Signal'
//  '<S284>' : 'PID_LOOP/Controller/PID 6/Saturation'
//  '<S285>' : 'PID_LOOP/Controller/PID 6/Saturation Fdbk'
//  '<S286>' : 'PID_LOOP/Controller/PID 6/Sum'
//  '<S287>' : 'PID_LOOP/Controller/PID 6/Sum Fdbk'
//  '<S288>' : 'PID_LOOP/Controller/PID 6/Tracking Mode'
//  '<S289>' : 'PID_LOOP/Controller/PID 6/Tracking Mode Sum'
//  '<S290>' : 'PID_LOOP/Controller/PID 6/Tsamp - Integral'
//  '<S291>' : 'PID_LOOP/Controller/PID 6/Tsamp - Ngain'
//  '<S292>' : 'PID_LOOP/Controller/PID 6/postSat Signal'
//  '<S293>' : 'PID_LOOP/Controller/PID 6/preInt Signal'
//  '<S294>' : 'PID_LOOP/Controller/PID 6/preSat Signal'
//  '<S295>' : 'PID_LOOP/Controller/PID 6/Anti-windup/Passthrough'
//  '<S296>' : 'PID_LOOP/Controller/PID 6/D Gain/Internal Parameters'
//  '<S297>' : 'PID_LOOP/Controller/PID 6/External Derivative/Error'
//  '<S298>' : 'PID_LOOP/Controller/PID 6/Filter/Cont. Filter'
//  '<S299>' : 'PID_LOOP/Controller/PID 6/Filter ICs/Internal IC - Filter'
//  '<S300>' : 'PID_LOOP/Controller/PID 6/I Gain/Internal Parameters'
//  '<S301>' : 'PID_LOOP/Controller/PID 6/Ideal P Gain/Passthrough'
//  '<S302>' : 'PID_LOOP/Controller/PID 6/Ideal P Gain Fdbk/Disabled'
//  '<S303>' : 'PID_LOOP/Controller/PID 6/Integrator/Continuous'
//  '<S304>' : 'PID_LOOP/Controller/PID 6/Integrator ICs/Internal IC'
//  '<S305>' : 'PID_LOOP/Controller/PID 6/N Copy/Disabled'
//  '<S306>' : 'PID_LOOP/Controller/PID 6/N Gain/Internal Parameters'
//  '<S307>' : 'PID_LOOP/Controller/PID 6/P Copy/Disabled'
//  '<S308>' : 'PID_LOOP/Controller/PID 6/Parallel P Gain/Internal Parameters'
//  '<S309>' : 'PID_LOOP/Controller/PID 6/Reset Signal/Disabled'
//  '<S310>' : 'PID_LOOP/Controller/PID 6/Saturation/Passthrough'
//  '<S311>' : 'PID_LOOP/Controller/PID 6/Saturation Fdbk/Disabled'
//  '<S312>' : 'PID_LOOP/Controller/PID 6/Sum/Sum_PID'
//  '<S313>' : 'PID_LOOP/Controller/PID 6/Sum Fdbk/Disabled'
//  '<S314>' : 'PID_LOOP/Controller/PID 6/Tracking Mode/Disabled'
//  '<S315>' : 'PID_LOOP/Controller/PID 6/Tracking Mode Sum/Passthrough'
//  '<S316>' : 'PID_LOOP/Controller/PID 6/Tsamp - Integral/TsSignalSpecification'
//  '<S317>' : 'PID_LOOP/Controller/PID 6/Tsamp - Ngain/Passthrough'
//  '<S318>' : 'PID_LOOP/Controller/PID 6/postSat Signal/Forward_Path'
//  '<S319>' : 'PID_LOOP/Controller/PID 6/preInt Signal/Internal PreInt'
//  '<S320>' : 'PID_LOOP/Controller/PID 6/preSat Signal/Forward_Path'


//-
//  Requirements for '<Root>': Controller


#endif                                 // Controller_h_

//
// File trailer for generated code.
//
// [EOF]
//
