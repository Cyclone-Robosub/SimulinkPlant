/*
 * Controller_data.c
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

#include "Controller.h"

/* Block parameters (default storage) */
P_Controller_T Controller_P = {
  /* Variable: pwm_stop
   * Referenced by: '<S1>/PWM Stop'
   */
  1500.0,

  /* Variable: wrench
   * Referenced by: '<S1>/MATLAB Function'
   */
  { 0.0, 0.0, 0.0, 0.0, -0.7071, -0.7071, -0.7071, -0.7071, 0.0, 0.0, 0.0, 0.0,
    -0.7071, 0.7071, 0.7071, -0.7071, -1.0, -1.0, -1.0, -1.0, 0.0, 0.0, 0.0, 0.0,
    -0.2035, 0.2035, -0.2035, 0.2035, -0.0346, 0.0346, 0.0346, -0.0346, -0.2535,
    -0.2535, 0.2545, 0.2545, 0.0346, 0.0346, 0.0346, 0.0346, 0.0, 0.0, 0.0, 0.0,
    0.2153, -0.2153, 0.222, -0.222 },

  /* Mask Parameter: PID1_D
   * Referenced by: '<S36>/Derivative Gain'
   */
  80.0,

  /* Mask Parameter: PID2_D
   * Referenced by: '<S88>/Derivative Gain'
   */
  20.0,

  /* Mask Parameter: PID3_D
   * Referenced by: '<S140>/Derivative Gain'
   */
  40.0,

  /* Mask Parameter: PID4_D
   * Referenced by: '<S192>/Derivative Gain'
   */
  20.0,

  /* Mask Parameter: PID5_D
   * Referenced by: '<S244>/Derivative Gain'
   */
  50.0,

  /* Mask Parameter: PID6_D
   * Referenced by: '<S296>/Derivative Gain'
   */
  5.0,

  /* Mask Parameter: PID1_I
   * Referenced by: '<S40>/Integral Gain'
   */
  1.0,

  /* Mask Parameter: PID2_I
   * Referenced by: '<S92>/Integral Gain'
   */
  1.0,

  /* Mask Parameter: PID3_I
   * Referenced by: '<S144>/Integral Gain'
   */
  1.0,

  /* Mask Parameter: PID4_I
   * Referenced by: '<S196>/Integral Gain'
   */
  1.0,

  /* Mask Parameter: PID5_I
   * Referenced by: '<S248>/Integral Gain'
   */
  1.0,

  /* Mask Parameter: PID6_I
   * Referenced by: '<S300>/Integral Gain'
   */
  1.0,

  /* Mask Parameter: PID1_InitialConditionForFilter
   * Referenced by: '<S38>/Filter'
   */
  0.0,

  /* Mask Parameter: PID2_InitialConditionForFilter
   * Referenced by: '<S90>/Filter'
   */
  0.0,

  /* Mask Parameter: PID3_InitialConditionForFilter
   * Referenced by: '<S142>/Filter'
   */
  0.0,

  /* Mask Parameter: PID4_InitialConditionForFilter
   * Referenced by: '<S194>/Filter'
   */
  0.0,

  /* Mask Parameter: PID5_InitialConditionForFilter
   * Referenced by: '<S246>/Filter'
   */
  0.0,

  /* Mask Parameter: PID6_InitialConditionForFilter
   * Referenced by: '<S298>/Filter'
   */
  0.0,

  /* Mask Parameter: PID1_InitialConditionForIntegra
   * Referenced by: '<S43>/Integrator'
   */
  0.0,

  /* Mask Parameter: PID2_InitialConditionForIntegra
   * Referenced by: '<S95>/Integrator'
   */
  0.0,

  /* Mask Parameter: PID3_InitialConditionForIntegra
   * Referenced by: '<S147>/Integrator'
   */
  0.0,

  /* Mask Parameter: PID4_InitialConditionForIntegra
   * Referenced by: '<S199>/Integrator'
   */
  0.0,

  /* Mask Parameter: PID5_InitialConditionForIntegra
   * Referenced by: '<S251>/Integrator'
   */
  0.0,

  /* Mask Parameter: PID6_InitialConditionForIntegra
   * Referenced by: '<S303>/Integrator'
   */
  0.0,

  /* Mask Parameter: PID1_N
   * Referenced by: '<S46>/Filter Coefficient'
   */
  100.0,

  /* Mask Parameter: PID2_N
   * Referenced by: '<S98>/Filter Coefficient'
   */
  100.0,

  /* Mask Parameter: PID3_N
   * Referenced by: '<S150>/Filter Coefficient'
   */
  100.0,

  /* Mask Parameter: PID4_N
   * Referenced by: '<S202>/Filter Coefficient'
   */
  100.0,

  /* Mask Parameter: PID5_N
   * Referenced by: '<S254>/Filter Coefficient'
   */
  100.0,

  /* Mask Parameter: PID6_N
   * Referenced by: '<S306>/Filter Coefficient'
   */
  100.0,

  /* Mask Parameter: PID1_P
   * Referenced by: '<S48>/Proportional Gain'
   */
  50.0,

  /* Mask Parameter: PID2_P
   * Referenced by: '<S100>/Proportional Gain'
   */
  20.0,

  /* Mask Parameter: PID3_P
   * Referenced by: '<S152>/Proportional Gain'
   */
  40.0,

  /* Mask Parameter: PID4_P
   * Referenced by: '<S204>/Proportional Gain'
   */
  20.0,

  /* Mask Parameter: PID5_P
   * Referenced by: '<S256>/Proportional Gain'
   */
  20.0,

  /* Mask Parameter: PID6_P
   * Referenced by: '<S308>/Proportional Gain'
   */
  5.0,

  /* Expression: 10
   * Referenced by: '<S1>/Gain'
   */
  10.0,

  /* Expression: 1900
   * Referenced by: '<S1>/Saturation'
   */
  1900.0,

  /* Expression: 1100
   * Referenced by: '<S1>/Saturation'
   */
  1100.0
};
