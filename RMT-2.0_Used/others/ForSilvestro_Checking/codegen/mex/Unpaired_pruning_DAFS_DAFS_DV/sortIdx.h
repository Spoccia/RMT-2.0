/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sortIdx.h
 *
 * Code generation for function 'sortIdx'
 *
 */

#ifndef __SORTIDX_H__
#define __SORTIDX_H__

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
extern void b_merge(const emlrtStack *sp, int32_T idx[4], real_T x[4], int32_T
                    offset, int32_T np, int32_T nq, int32_T iwork[4], real_T
                    xwork[4]);
extern void merge_block(const emlrtStack *sp, emxArray_int32_T *idx,
  emxArray_real_T *x, int32_T offset, int32_T n, int32_T preSortLevel,
  emxArray_int32_T *iwork, emxArray_real_T *xwork);

#endif

/* End of code generation (sortIdx.h) */
