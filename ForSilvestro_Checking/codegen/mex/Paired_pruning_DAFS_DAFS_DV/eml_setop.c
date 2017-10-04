/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * eml_setop.c
 *
 * Code generation for function 'eml_setop'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "Paired_pruning_DAFS_DAFS_DV.h"
#include "eml_setop.h"

/* Function Definitions */
void do_vectors(real_T a, real_T b, real_T c_data[], int32_T c_size[2], int32_T
                ia_data[], int32_T ia_size[1], int32_T ib_data[], int32_T
                ib_size[1])
{
  int32_T ialast;
  int32_T nc;
  int32_T iafirst;
  int32_T ibfirst;
  int32_T iblast;
  real_T absxk;
  int32_T exponent;
  boolean_T p;
  int32_T b_ia_data[1];
  for (ialast = 0; ialast < 2; ialast++) {
    c_size[ialast] = 1;
  }

  nc = 0;
  iafirst = 1;
  ialast = 1;
  ibfirst = 1;
  iblast = 1;
  while ((ialast <= 1) && (iblast <= 1)) {
    absxk = muDoubleScalarAbs(b / 2.0);
    if ((!muDoubleScalarIsInf(absxk)) && (!muDoubleScalarIsNaN(absxk))) {
      if (absxk <= 2.2250738585072014E-308) {
        absxk = 4.94065645841247E-324;
      } else {
        frexp(absxk, &exponent);
        absxk = ldexp(1.0, exponent - 53);
      }
    } else {
      absxk = rtNaN;
    }

    if ((muDoubleScalarAbs(b - a) < absxk) || (muDoubleScalarIsInf(a) &&
         muDoubleScalarIsInf(b) && ((a > 0.0) == (b > 0.0)))) {
      p = true;
    } else {
      p = false;
    }

    if (p) {
      nc++;
      c_data[0] = a;
      ia_data[0] = iafirst;
      ib_data[0] = ibfirst;
      ialast = 2;
      iafirst = 2;
      iblast = 2;
      ibfirst = 2;
    } else {
      if ((a < b) || muDoubleScalarIsNaN(b)) {
        p = true;
      } else {
        p = false;
      }

      if (p) {
        ialast = 2;
        iafirst = 2;
      } else {
        iblast = 2;
        ibfirst = 2;
      }
    }
  }

  if (1 > nc) {
    iafirst = -1;
  } else {
    iafirst = 0;
  }

  for (ialast = 0; ialast <= iafirst; ialast++) {
    b_ia_data[ialast] = ia_data[ialast];
  }

  ia_size[0] = iafirst + 1;
  iafirst++;
  for (ialast = 0; ialast < iafirst; ialast++) {
    ia_data[ialast] = b_ia_data[ialast];
  }

  if (1 > nc) {
    iafirst = -1;
  } else {
    iafirst = 0;
  }

  for (ialast = 0; ialast <= iafirst; ialast++) {
    b_ia_data[ialast] = ib_data[ialast];
  }

  ib_size[0] = iafirst + 1;
  iafirst++;
  for (ialast = 0; ialast < iafirst; ialast++) {
    ib_data[ialast] = b_ia_data[ialast];
  }

  c_size[1] = !(1 > nc);
}

/* End of code generation (eml_setop.c) */
