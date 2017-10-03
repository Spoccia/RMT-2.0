/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * eml_setop.h
 *
 * Code generation for function 'eml_setop'
 *
 */

#ifndef __EML_SETOP_H__
#define __EML_SETOP_H__

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
#include "pruning_DAFS_DAFS_1_types.h"

/* Function Declarations */
extern void do_vectors(real_T a, real_T b, real_T c_data[], int32_T c_size[2],
  int32_T ia_data[], int32_T ia_size[1], int32_T ib_data[], int32_T ib_size[1]);

#endif

/* End of code generation (eml_setop.h) */
