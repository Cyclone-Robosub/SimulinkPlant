/*
 * builtin_typeid_types.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "Controller".
 *
 * Model version              : 1.63
 * Simulink Coder version : 24.2 (R2024b) 21-Jun-2024
 * C source code generated on : Sun Apr  6 12:02:03 2025
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objective: Debugging
 * Validation result: Not run
 */

#ifndef BUILTIN_TYPEID_TYPES_H
#define BUILTIN_TYPEID_TYPES_H
#ifndef BUILTIN_TYPEID_TYPES
#define BUILTIN_TYPEID_TYPES

/* Enumeration of built-in data types */
typedef enum {
  SS_DOUBLE = 0,
  SS_SINGLE = 1,
  SS_INT8 = 2,
  SS_UINT8 = 3,
  SS_INT16 = 4,
  SS_UINT16 = 5,
  SS_INT32 = 6,
  SS_UINT32 = 7,
  SS_BOOLEAN = 8
} BuiltInDTypeId;

#define SS_NUM_BUILT_IN_DTYPE          ((int)SS_BOOLEAN+1)

/* Enumeration for MAT-file logging code */
typedef int DTypeId;

/* Enumeration of pre-defined data types */
typedef enum {
  SS_FCN_CALL = 9,
  SS_INTEGER = 10,
  SS_POINTER = 11,
  SS_INTERNAL_DTYPE2 = 12,
  SS_TIMER_UINT32_PAIR = 13,
  SS_CONNECTION_TYPE = 14
} PreDefinedDTypeId;

#endif                                 /* BUILTIN_TYPEID_TYPES */
#endif                                 /* BUILTIN_TYPEID_TYPES_H */
