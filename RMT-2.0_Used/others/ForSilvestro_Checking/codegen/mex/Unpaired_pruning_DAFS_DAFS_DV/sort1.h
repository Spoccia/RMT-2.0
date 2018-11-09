/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sort1.h
 *
 * Code generation for function 'sort1'
 *
 */

#ifndef __SORT1_H__
#define __SORT1_H__

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
#include "Unpaired_pruning_DAFS_DAFS_DV_types.h"

/* Function Declarations */
extern void b_sort(const emlrtStack *sp, real_T x[4], int32_T idx[4]);
extern void sort(const emlrtStack *sp, emxArray_real_T *x, emxArray_int32_T *idx);

#endif

/* End of code generation (sort1.h) */
