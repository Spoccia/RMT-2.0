/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Paired_pruning_DAFS_DAFS_DV.h
 *
 * Code generation for function 'Paired_pruning_DAFS_DAFS_DV'
 *
 */

#ifndef __PAIRED_PRUNING_DAFS_DAFS_DV_H__
#define __PAIRED_PRUNING_DAFS_DAFS_DV_H__

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "blas.h"
#include "rtwtypes.h"
#include "Paired_pruning_DAFS_DAFS_DV_types.h"

/* Function Declarations */
extern void Paired_pruning_DAFS_DAFS_DV(const emlrtStack *sp, const
  emxArray_real_T *feature1, const emxArray_real_T *depdScale1, const
  emxArray_real_T *matches, const emxArray_real_T *combineScore, const
  emxArray_real_T *feature2, const emxArray_real_T *depdScale2, real_T doctave,
  real_T toctave, emxArray_real_T *remainQOctave, real_T *Dist);

#endif

/* End of code generation (Paired_pruning_DAFS_DAFS_DV.h) */
