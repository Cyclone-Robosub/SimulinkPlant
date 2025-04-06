/*
 * Controller.c
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

#include "Controller.h"
#include "rtwtypes.h"
#include <math.h>
#include "rt_nonfinite.h"
#include <emmintrin.h>
#include "Controller_private.h"
#include <string.h>

/* Block signals (default storage) */
B_Controller_T Controller_B;

/* Continuous states */
X_Controller_T Controller_X;

/* Disabled State Vector */
XDis_Controller_T Controller_XDis;

/* External inputs (root inport signals with default storage) */
ExtU_Controller_T Controller_U;

/* External outputs (root outports fed by signals with default storage) */
ExtY_Controller_T Controller_Y;

/* Real-time model */
static RT_MODEL_Controller_T Controller_M_;
RT_MODEL_Controller_T *const Controller_M = &Controller_M_;

/* Forward declaration for local functions */
static real_T Controller_xzlangeM(const real_T x[48]);
static void Controller_xzlascl(real_T cfrom, real_T cto, real_T A[48]);
static real_T Controller_xnrm2(int32_T n, const real_T x[48], int32_T ix0);
static real_T Controller_xdotc(int32_T n, const real_T x[48], int32_T ix0, const
  real_T y[48], int32_T iy0);
static void Controller_xaxpy(int32_T n, real_T a, int32_T ix0, real_T y[48],
  int32_T iy0);
static real_T Controller_xnrm2_g(int32_T n, const real_T x[6], int32_T ix0);
static void Controller_xaxpy_i(int32_T n, real_T a, const real_T x[48], int32_T
  ix0, real_T y[8], int32_T iy0);
static void Controller_xaxpy_iv(int32_T n, real_T a, const real_T x[8], int32_T
  ix0, real_T y[48], int32_T iy0);
static real_T Controller_xdotc_l(int32_T n, const real_T x[36], int32_T ix0,
  const real_T y[36], int32_T iy0);
static void Controller_xaxpy_ivt(int32_T n, real_T a, int32_T ix0, real_T y[36],
  int32_T iy0);
static void Controller_xzlascl_h(real_T cfrom, real_T cto, real_T A[6]);
static void Controller_xswap(real_T x[36], int32_T ix0, int32_T iy0);
static void Controller_xswap_j(real_T x[48], int32_T ix0, int32_T iy0);
static void Controller_xrotg(real_T *a, real_T *b, real_T *c, real_T *s);
static void Controller_xrot(real_T x[36], int32_T ix0, int32_T iy0, real_T c,
  real_T s);
static void Controller_xrot_c(real_T x[48], int32_T ix0, int32_T iy0, real_T c,
  real_T s);
static void Controller_svd(const real_T A[48], real_T U[48], real_T s[6], real_T
  V[36]);

/*
 * This function updates continuous states using the ODE3 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  /* Solver Matrices */
  static const real_T rt_ODE3_A[3] = {
    1.0/2.0, 3.0/4.0, 1.0
  };

  static const real_T rt_ODE3_B[3][3] = {
    { 1.0/2.0, 0.0, 0.0 },

    { 0.0, 3.0/4.0, 0.0 },

    { 2.0/9.0, 1.0/3.0, 4.0/9.0 }
  };

  time_T t = rtsiGetT(si);
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE3_IntgData *id = (ODE3_IntgData *)rtsiGetSolverData(si);
  real_T *y = id->y;
  real_T *f0 = id->f[0];
  real_T *f1 = id->f[1];
  real_T *f2 = id->f[2];
  real_T hB[3];
  int_T i;
  int_T nXc = 12;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  Controller_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE3_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[0]);
  rtsiSetdX(si, f1);
  Controller_step();
  Controller_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE3_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[1]);
  rtsiSetdX(si, f2);
  Controller_step();
  Controller_derivatives();

  /* tnew = t + hA(3);
     ynew = y + f*hB(:,3); */
  for (i = 0; i <= 2; i++) {
    hB[i] = h * rt_ODE3_B[2][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2]);
  }

  rtsiSetT(si, tnew);
  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static real_T Controller_xzlangeM(const real_T x[48])
{
  real_T y;
  int32_T k;
  boolean_T exitg1;
  y = 0.0;
  k = 0;
  exitg1 = false;
  while ((!exitg1) && (k < 48)) {
    real_T absxk;
    absxk = fabs(x[k]);
    if (rtIsNaN(absxk)) {
      y = (rtNaN);
      exitg1 = true;
    } else {
      if (absxk > y) {
        y = absxk;
      }

      k++;
    }
  }

  return y;
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static void Controller_xzlascl(real_T cfrom, real_T cto, real_T A[48])
{
  real_T cfromc;
  real_T ctoc;
  int32_T i;
  boolean_T notdone;
  cfromc = cfrom;
  ctoc = cto;
  notdone = true;
  while (notdone) {
    real_T cfrom1;
    real_T cto1;
    real_T mul;
    cfrom1 = cfromc * 2.0041683600089728E-292;
    cto1 = ctoc / 4.9896007738368E+291;
    if ((fabs(cfrom1) > fabs(ctoc)) && (ctoc != 0.0)) {
      mul = 2.0041683600089728E-292;
      cfromc = cfrom1;
    } else if (fabs(cto1) > fabs(cfromc)) {
      mul = 4.9896007738368E+291;
      ctoc = cto1;
    } else {
      mul = ctoc / cfromc;
      notdone = false;
    }

    for (i = 0; i <= 46; i += 2) {
      __m128d tmp;
      tmp = _mm_loadu_pd(&A[i]);
      tmp = _mm_mul_pd(tmp, _mm_set1_pd(mul));
      _mm_storeu_pd(&A[i], tmp);
    }
  }
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static real_T Controller_xnrm2(int32_T n, const real_T x[48], int32_T ix0)
{
  real_T scale;
  real_T y;
  int32_T k;
  int32_T kend;
  y = 0.0;
  scale = 3.3121686421112381E-170;
  kend = ix0 + n;
  for (k = ix0; k < kend; k++) {
    real_T absxk;
    absxk = fabs(x[k - 1]);
    if (absxk > scale) {
      real_T t;
      t = scale / absxk;
      y = y * t * t + 1.0;
      scale = absxk;
    } else {
      real_T t;
      t = absxk / scale;
      y += t * t;
    }
  }

  return scale * sqrt(y);
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static real_T Controller_xdotc(int32_T n, const real_T x[48], int32_T ix0, const
  real_T y[48], int32_T iy0)
{
  real_T d;
  int32_T b;
  int32_T ix;
  int32_T iy;
  int32_T k;
  ix = ix0 - 1;
  iy = iy0 - 1;
  d = 0.0;
  b = (uint8_T)n;
  for (k = 0; k < b; k++) {
    d += x[ix + k] * y[iy + k];
  }

  return d;
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static void Controller_xaxpy(int32_T n, real_T a, int32_T ix0, real_T y[48],
  int32_T iy0)
{
  int32_T k;
  if (!(a == 0.0)) {
    int32_T iy;
    iy = iy0 - 1;
    for (k = 0; k < n; k++) {
      int32_T tmp;
      tmp = iy + k;
      y[tmp] += y[(ix0 + k) - 1] * a;
    }
  }
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static real_T Controller_xnrm2_g(int32_T n, const real_T x[6], int32_T ix0)
{
  real_T scale;
  real_T y;
  int32_T k;
  int32_T kend;
  y = 0.0;
  scale = 3.3121686421112381E-170;
  kend = ix0 + n;
  for (k = ix0; k < kend; k++) {
    real_T absxk;
    absxk = fabs(x[k - 1]);
    if (absxk > scale) {
      real_T t;
      t = scale / absxk;
      y = y * t * t + 1.0;
      scale = absxk;
    } else {
      real_T t;
      t = absxk / scale;
      y += t * t;
    }
  }

  return scale * sqrt(y);
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static void Controller_xaxpy_i(int32_T n, real_T a, const real_T x[48], int32_T
  ix0, real_T y[8], int32_T iy0)
{
  int32_T k;
  if (!(a == 0.0)) {
    int32_T iy;
    int32_T scalarLB;
    int32_T tmp_1;
    int32_T vectorUB;
    iy = iy0 - 1;
    scalarLB = (n / 2) << 1;
    vectorUB = scalarLB - 2;
    for (k = 0; k <= vectorUB; k += 2) {
      __m128d tmp;
      __m128d tmp_0;
      tmp = _mm_loadu_pd(&x[(ix0 + k) - 1]);
      tmp = _mm_mul_pd(tmp, _mm_set1_pd(a));
      tmp_1 = iy + k;
      tmp_0 = _mm_loadu_pd(&y[tmp_1]);
      tmp = _mm_add_pd(tmp, tmp_0);
      _mm_storeu_pd(&y[tmp_1], tmp);
    }

    for (k = scalarLB; k < n; k++) {
      tmp_1 = iy + k;
      y[tmp_1] += x[(ix0 + k) - 1] * a;
    }
  }
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static void Controller_xaxpy_iv(int32_T n, real_T a, const real_T x[8], int32_T
  ix0, real_T y[48], int32_T iy0)
{
  int32_T k;
  if (!(a == 0.0)) {
    int32_T iy;
    int32_T scalarLB;
    int32_T tmp_1;
    int32_T vectorUB;
    iy = iy0 - 1;
    scalarLB = (n / 2) << 1;
    vectorUB = scalarLB - 2;
    for (k = 0; k <= vectorUB; k += 2) {
      __m128d tmp;
      __m128d tmp_0;
      tmp = _mm_loadu_pd(&x[(ix0 + k) - 1]);
      tmp = _mm_mul_pd(tmp, _mm_set1_pd(a));
      tmp_1 = iy + k;
      tmp_0 = _mm_loadu_pd(&y[tmp_1]);
      tmp = _mm_add_pd(tmp, tmp_0);
      _mm_storeu_pd(&y[tmp_1], tmp);
    }

    for (k = scalarLB; k < n; k++) {
      tmp_1 = iy + k;
      y[tmp_1] += x[(ix0 + k) - 1] * a;
    }
  }
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static real_T Controller_xdotc_l(int32_T n, const real_T x[36], int32_T ix0,
  const real_T y[36], int32_T iy0)
{
  real_T d;
  int32_T b;
  int32_T ix;
  int32_T iy;
  int32_T k;
  ix = ix0 - 1;
  iy = iy0 - 1;
  d = 0.0;
  b = (uint8_T)n;
  for (k = 0; k < b; k++) {
    d += x[ix + k] * y[iy + k];
  }

  return d;
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static void Controller_xaxpy_ivt(int32_T n, real_T a, int32_T ix0, real_T y[36],
  int32_T iy0)
{
  int32_T k;
  if (!(a == 0.0)) {
    int32_T iy;
    iy = iy0 - 1;
    for (k = 0; k < n; k++) {
      int32_T tmp;
      tmp = iy + k;
      y[tmp] += y[(ix0 + k) - 1] * a;
    }
  }
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static void Controller_xzlascl_h(real_T cfrom, real_T cto, real_T A[6])
{
  real_T cfromc;
  real_T ctoc;
  int32_T i;
  boolean_T notdone;
  cfromc = cfrom;
  ctoc = cto;
  notdone = true;
  while (notdone) {
    real_T cfrom1;
    real_T cto1;
    real_T mul;
    cfrom1 = cfromc * 2.0041683600089728E-292;
    cto1 = ctoc / 4.9896007738368E+291;
    if ((fabs(cfrom1) > fabs(ctoc)) && (ctoc != 0.0)) {
      mul = 2.0041683600089728E-292;
      cfromc = cfrom1;
    } else if (fabs(cto1) > fabs(cfromc)) {
      mul = 4.9896007738368E+291;
      ctoc = cto1;
    } else {
      mul = ctoc / cfromc;
      notdone = false;
    }

    for (i = 0; i <= 4; i += 2) {
      __m128d tmp;
      tmp = _mm_loadu_pd(&A[i]);
      tmp = _mm_mul_pd(tmp, _mm_set1_pd(mul));
      _mm_storeu_pd(&A[i], tmp);
    }
  }
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static void Controller_xswap(real_T x[36], int32_T ix0, int32_T iy0)
{
  int32_T ix;
  int32_T iy;
  int32_T k;
  ix = ix0 - 1;
  iy = iy0 - 1;
  for (k = 0; k < 6; k++) {
    real_T temp;
    int32_T temp_tmp;
    int32_T tmp;
    temp_tmp = ix + k;
    temp = x[temp_tmp];
    tmp = iy + k;
    x[temp_tmp] = x[tmp];
    x[tmp] = temp;
  }
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static void Controller_xswap_j(real_T x[48], int32_T ix0, int32_T iy0)
{
  int32_T ix;
  int32_T iy;
  int32_T k;
  ix = ix0 - 1;
  iy = iy0 - 1;
  for (k = 0; k < 8; k++) {
    real_T temp;
    int32_T temp_tmp;
    int32_T tmp;
    temp_tmp = ix + k;
    temp = x[temp_tmp];
    tmp = iy + k;
    x[temp_tmp] = x[tmp];
    x[tmp] = temp;
  }
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static void Controller_xrotg(real_T *a, real_T *b, real_T *c, real_T *s)
{
  real_T absa;
  real_T absb;
  real_T roe;
  real_T scale;
  roe = *b;
  absa = fabs(*a);
  absb = fabs(*b);
  if (absa > absb) {
    roe = *a;
  }

  scale = absa + absb;
  if (scale == 0.0) {
    *s = 0.0;
    *c = 1.0;
    *a = 0.0;
    *b = 0.0;
  } else {
    real_T ads;
    real_T bds;
    ads = absa / scale;
    bds = absb / scale;
    scale *= sqrt(ads * ads + bds * bds);
    if (roe < 0.0) {
      scale = -scale;
    }

    *c = *a / scale;
    *s = *b / scale;
    if (absa > absb) {
      *b = *s;
    } else if (*c != 0.0) {
      *b = 1.0 / *c;
    } else {
      *b = 1.0;
    }

    *a = scale;
  }
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static void Controller_xrot(real_T x[36], int32_T ix0, int32_T iy0, real_T c,
  real_T s)
{
  int32_T ix;
  int32_T iy;
  int32_T k;
  ix = ix0 - 1;
  iy = iy0 - 1;
  for (k = 0; k < 6; k++) {
    real_T temp;
    real_T temp_tmp;
    real_T temp_tmp_0;
    int32_T temp_tmp_tmp;
    int32_T temp_tmp_tmp_0;
    temp_tmp_tmp = iy + k;
    temp_tmp = x[temp_tmp_tmp];
    temp_tmp_tmp_0 = ix + k;
    temp_tmp_0 = x[temp_tmp_tmp_0];
    temp = temp_tmp_0 * c + temp_tmp * s;
    x[temp_tmp_tmp] = temp_tmp * c - temp_tmp_0 * s;
    x[temp_tmp_tmp_0] = temp;
  }
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static void Controller_xrot_c(real_T x[48], int32_T ix0, int32_T iy0, real_T c,
  real_T s)
{
  int32_T ix;
  int32_T iy;
  int32_T k;
  ix = ix0 - 1;
  iy = iy0 - 1;
  for (k = 0; k < 8; k++) {
    real_T temp;
    real_T temp_tmp;
    real_T temp_tmp_0;
    int32_T temp_tmp_tmp;
    int32_T temp_tmp_tmp_0;
    temp_tmp_tmp = iy + k;
    temp_tmp = x[temp_tmp_tmp];
    temp_tmp_tmp_0 = ix + k;
    temp_tmp_0 = x[temp_tmp_tmp_0];
    temp = temp_tmp_0 * c + temp_tmp * s;
    x[temp_tmp_tmp] = temp_tmp * c - temp_tmp_0 * s;
    x[temp_tmp_tmp_0] = temp;
  }
}

/* Function for MATLAB Function: '<S1>/MATLAB Function' */
static void Controller_svd(const real_T A[48], real_T U[48], real_T s[6], real_T
  V[36])
{
  __m128d tmp;
  __m128d tmp_0;
  real_T b_A[48];
  real_T work[8];
  real_T b_s_tmp[6];
  real_T e[6];
  real_T tmp_1[2];
  real_T anrm;
  real_T cscale;
  real_T emm1;
  real_T nrm;
  real_T rt;
  real_T shift;
  real_T smm1;
  real_T sqds;
  real_T ztest;
  int32_T exitg1;
  int32_T i;
  int32_T qjj;
  int32_T qp1;
  int32_T qp1jj;
  int32_T qq;
  int32_T qq_tmp;
  int32_T qq_tmp_tmp;
  int32_T scalarLB;
  int32_T vectorUB;
  boolean_T apply_transform;
  boolean_T doscale;
  boolean_T exitg2;
  memcpy(&b_A[0], &A[0], 48U * sizeof(real_T));
  for (i = 0; i < 6; i++) {
    b_s_tmp[i] = 0.0;
    e[i] = 0.0;
  }

  memset(&work[0], 0, sizeof(real_T) << 3U);
  memset(&U[0], 0, 48U * sizeof(real_T));
  memset(&V[0], 0, 36U * sizeof(real_T));
  doscale = false;
  anrm = Controller_xzlangeM(A);
  cscale = anrm;
  if ((anrm > 0.0) && (anrm < 6.7178761075670888E-139)) {
    doscale = true;
    cscale = 6.7178761075670888E-139;
    Controller_xzlascl(anrm, cscale, b_A);
  } else if (anrm > 1.4885657073574029E+138) {
    doscale = true;
    cscale = 1.4885657073574029E+138;
    Controller_xzlascl(anrm, cscale, b_A);
  }

  for (i = 0; i < 6; i++) {
    qp1 = i + 2;
    qq_tmp_tmp = i << 3;
    qq_tmp = qq_tmp_tmp + i;
    qq = qq_tmp + 1;
    apply_transform = false;
    nrm = Controller_xnrm2(8 - i, b_A, qq);
    if (nrm > 0.0) {
      apply_transform = true;
      if (b_A[qq - 1] < 0.0) {
        nrm = -nrm;
      }

      b_s_tmp[i] = nrm;
      if (fabs(nrm) >= 1.0020841800044864E-292) {
        nrm = 1.0 / nrm;
        qjj = (qq - i) + 7;
        scalarLB = ((((qjj - qq) + 1) / 2) << 1) + qq;
        vectorUB = scalarLB - 2;
        for (qp1jj = qq; qp1jj <= vectorUB; qp1jj += 2) {
          tmp = _mm_loadu_pd(&b_A[qp1jj - 1]);
          tmp = _mm_mul_pd(tmp, _mm_set1_pd(nrm));
          _mm_storeu_pd(&b_A[qp1jj - 1], tmp);
        }

        for (qp1jj = scalarLB; qp1jj <= qjj; qp1jj++) {
          b_A[qp1jj - 1] *= nrm;
        }
      } else {
        qjj = (qq - i) + 7;
        scalarLB = ((((qjj - qq) + 1) / 2) << 1) + qq;
        vectorUB = scalarLB - 2;
        for (qp1jj = qq; qp1jj <= vectorUB; qp1jj += 2) {
          tmp = _mm_loadu_pd(&b_A[qp1jj - 1]);
          tmp = _mm_div_pd(tmp, _mm_set1_pd(b_s_tmp[i]));
          _mm_storeu_pd(&b_A[qp1jj - 1], tmp);
        }

        for (qp1jj = scalarLB; qp1jj <= qjj; qp1jj++) {
          b_A[qp1jj - 1] /= b_s_tmp[i];
        }
      }

      b_A[qq - 1]++;
      b_s_tmp[i] = -b_s_tmp[i];
    } else {
      b_s_tmp[i] = 0.0;
    }

    for (qp1jj = qp1; qp1jj < 7; qp1jj++) {
      qjj = ((qp1jj - 1) << 3) + i;
      if (apply_transform) {
        Controller_xaxpy(8 - i, -(Controller_xdotc(8 - i, b_A, qq, b_A, qjj + 1)
          / b_A[qq_tmp]), qq, b_A, qjj + 1);
      }

      e[qp1jj - 1] = b_A[qjj];
    }

    for (qq = i + 1; qq < 9; qq++) {
      qp1jj = (qq_tmp_tmp + qq) - 1;
      U[qp1jj] = b_A[qp1jj];
    }

    if (i + 1 <= 4) {
      nrm = Controller_xnrm2_g(5 - i, e, i + 2);
      if (nrm == 0.0) {
        e[i] = 0.0;
      } else {
        if (e[i + 1] < 0.0) {
          e[i] = -nrm;
        } else {
          e[i] = nrm;
        }

        nrm = e[i];
        if (fabs(e[i]) >= 1.0020841800044864E-292) {
          nrm = 1.0 / e[i];
          scalarLB = (((7 - qp1) / 2) << 1) + qp1;
          vectorUB = scalarLB - 2;
          for (qjj = qp1; qjj <= vectorUB; qjj += 2) {
            tmp = _mm_loadu_pd(&e[qjj - 1]);
            tmp = _mm_mul_pd(tmp, _mm_set1_pd(nrm));
            _mm_storeu_pd(&e[qjj - 1], tmp);
          }

          for (qjj = scalarLB; qjj < 7; qjj++) {
            e[qjj - 1] *= nrm;
          }
        } else {
          scalarLB = (((7 - qp1) / 2) << 1) + qp1;
          vectorUB = scalarLB - 2;
          for (qjj = qp1; qjj <= vectorUB; qjj += 2) {
            tmp = _mm_loadu_pd(&e[qjj - 1]);
            tmp = _mm_div_pd(tmp, _mm_set1_pd(nrm));
            _mm_storeu_pd(&e[qjj - 1], tmp);
          }

          for (qjj = scalarLB; qjj < 7; qjj++) {
            e[qjj - 1] /= nrm;
          }
        }

        e[i + 1]++;
        e[i] = -e[i];
        for (qq = qp1; qq < 9; qq++) {
          work[qq - 1] = 0.0;
        }

        for (qq = qp1; qq < 7; qq++) {
          Controller_xaxpy_i(7 - i, e[qq - 1], b_A, (i + ((qq - 1) << 3)) + 2,
                             work, i + 2);
        }

        for (qq = qp1; qq < 7; qq++) {
          Controller_xaxpy_iv(7 - i, -e[qq - 1] / e[i + 1], work, i + 2, b_A, (i
            + ((qq - 1) << 3)) + 2);
        }
      }

      for (qq = qp1; qq < 7; qq++) {
        V[(qq + 6 * i) - 1] = e[qq - 1];
      }
    }
  }

  i = 4;
  e[4] = b_A[44];
  e[5] = 0.0;
  for (qp1 = 5; qp1 >= 0; qp1--) {
    qq_tmp = qp1 << 3;
    qq = qq_tmp + qp1;
    if (b_s_tmp[qp1] != 0.0) {
      for (qp1jj = qp1 + 2; qp1jj < 7; qp1jj++) {
        qjj = (((qp1jj - 1) << 3) + qp1) + 1;
        Controller_xaxpy(8 - qp1, -(Controller_xdotc(8 - qp1, U, qq + 1, U, qjj)
          / U[qq]), qq + 1, U, qjj);
      }

      for (qjj = qp1 + 1; qjj < 9; qjj++) {
        qp1jj = (qq_tmp + qjj) - 1;
        U[qp1jj] = -U[qp1jj];
      }

      U[qq]++;
      for (qq = 0; qq < qp1; qq++) {
        U[qq + qq_tmp] = 0.0;
      }
    } else {
      memset(&U[qq_tmp], 0, sizeof(real_T) << 3U);
      U[qq] = 1.0;
    }
  }

  for (qp1 = 5; qp1 >= 0; qp1--) {
    if ((qp1 + 1 <= 4) && (e[qp1] != 0.0)) {
      qq = (6 * qp1 + qp1) + 2;
      for (qjj = qp1 + 2; qjj < 7; qjj++) {
        qp1jj = ((qjj - 1) * 6 + qp1) + 2;
        Controller_xaxpy_ivt(5 - qp1, -(Controller_xdotc_l(5 - qp1, V, qq, V,
          qp1jj) / V[qq - 1]), qq, V, qp1jj);
      }
    }

    for (qq = 0; qq < 6; qq++) {
      V[qq + 6 * qp1] = 0.0;
    }

    V[qp1 + 6 * qp1] = 1.0;
  }

  for (qp1 = 0; qp1 < 6; qp1++) {
    sqds = b_s_tmp[qp1];
    if (sqds != 0.0) {
      rt = fabs(sqds);
      nrm = sqds / rt;
      sqds = rt;
      b_s_tmp[qp1] = sqds;
      if (qp1 + 1 < 6) {
        e[qp1] /= nrm;
      }

      qq = (qp1 << 3) + 1;
      scalarLB = 8 + qq;
      vectorUB = scalarLB - 2;
      for (qjj = qq; qjj <= vectorUB; qjj += 2) {
        tmp = _mm_loadu_pd(&U[qjj - 1]);
        tmp = _mm_mul_pd(tmp, _mm_set1_pd(nrm));
        _mm_storeu_pd(&U[qjj - 1], tmp);
      }

      for (qjj = scalarLB; qjj <= qq + 7; qjj++) {
        U[qjj - 1] *= nrm;
      }
    }

    if (qp1 + 1 < 6) {
      smm1 = e[qp1];
      if (smm1 != 0.0) {
        rt = fabs(smm1);
        nrm = rt / smm1;
        smm1 = rt;
        e[qp1] = smm1;
        b_s_tmp[qp1 + 1] *= nrm;
        qq = (qp1 + 1) * 6 + 1;
        scalarLB = 6 + qq;
        vectorUB = scalarLB - 2;
        for (qjj = qq; qjj <= vectorUB; qjj += 2) {
          tmp = _mm_loadu_pd(&V[qjj - 1]);
          tmp = _mm_mul_pd(tmp, _mm_set1_pd(nrm));
          _mm_storeu_pd(&V[qjj - 1], tmp);
        }

        for (qjj = scalarLB; qjj <= qq + 5; qjj++) {
          V[qjj - 1] *= nrm;
        }
      }
    }
  }

  qp1 = 0;
  nrm = 0.0;
  for (qq = 0; qq < 6; qq++) {
    nrm = fmax(nrm, fmax(fabs(b_s_tmp[qq]), fabs(e[qq])));
  }

  while ((i + 2 > 0) && (qp1 < 75)) {
    qp1jj = i + 1;
    do {
      exitg1 = 0;
      qq = qp1jj;
      if (qp1jj == 0) {
        exitg1 = 1;
      } else {
        rt = fabs(e[qp1jj - 1]);
        if ((rt <= (fabs(b_s_tmp[qp1jj - 1]) + fabs(b_s_tmp[qp1jj])) *
             2.2204460492503131E-16) || ((rt <= 1.0020841800044864E-292) ||
             ((qp1 > 20) && (rt <= 2.2204460492503131E-16 * nrm)))) {
          e[qp1jj - 1] = 0.0;
          exitg1 = 1;
        } else {
          qp1jj--;
        }
      }
    } while (exitg1 == 0);

    if (i + 1 == qp1jj) {
      qp1jj = 4;
    } else {
      qjj = i + 2;
      qq_tmp_tmp = i + 2;
      exitg2 = false;
      while ((!exitg2) && (qq_tmp_tmp >= qp1jj)) {
        qjj = qq_tmp_tmp;
        if (qq_tmp_tmp == qp1jj) {
          exitg2 = true;
        } else {
          rt = 0.0;
          if (qq_tmp_tmp < i + 2) {
            rt = fabs(e[qq_tmp_tmp - 1]);
          }

          if (qq_tmp_tmp > qp1jj + 1) {
            rt += fabs(e[qq_tmp_tmp - 2]);
          }

          ztest = fabs(b_s_tmp[qq_tmp_tmp - 1]);
          if ((ztest <= 2.2204460492503131E-16 * rt) || (ztest <=
               1.0020841800044864E-292)) {
            b_s_tmp[qq_tmp_tmp - 1] = 0.0;
            exitg2 = true;
          } else {
            qq_tmp_tmp--;
          }
        }
      }

      if (qjj == qp1jj) {
        qp1jj = 3;
      } else if (i + 2 == qjj) {
        qp1jj = 1;
      } else {
        qp1jj = 2;
        qq = qjj;
      }
    }

    switch (qp1jj) {
     case 1:
      rt = e[i];
      e[i] = 0.0;
      for (qjj = i + 1; qjj >= qq + 1; qjj--) {
        Controller_xrotg(&b_s_tmp[qjj - 1], &rt, &ztest, &sqds);
        if (qjj > qq + 1) {
          smm1 = e[qjj - 2];
          rt = -sqds * smm1;
          smm1 *= ztest;
          e[qjj - 2] = smm1;
        }

        Controller_xrot(V, 6 * (qjj - 1) + 1, 6 * (i + 1) + 1, ztest, sqds);
      }
      break;

     case 2:
      rt = e[qq - 1];
      e[qq - 1] = 0.0;
      for (qjj = qq + 1; qjj <= i + 2; qjj++) {
        Controller_xrotg(&b_s_tmp[qjj - 1], &rt, &ztest, &sqds);
        smm1 = e[qjj - 1];
        rt = -sqds * smm1;
        smm1 *= ztest;
        e[qjj - 1] = smm1;
        Controller_xrot_c(U, ((qjj - 1) << 3) + 1, ((qq - 1) << 3) + 1, ztest,
                          sqds);
      }
      break;

     case 3:
      rt = b_s_tmp[i + 1];
      ztest = fmax(fmax(fmax(fmax(fabs(rt), fabs(b_s_tmp[i])), fabs(e[i])), fabs
                        (b_s_tmp[qq])), fabs(e[qq]));
      tmp = _mm_set1_pd(ztest);
      tmp_0 = _mm_div_pd(_mm_set_pd(b_s_tmp[i], rt), tmp);
      _mm_storeu_pd(&tmp_1[0], tmp_0);
      rt = tmp_1[0];
      smm1 = tmp_1[1];
      tmp = _mm_div_pd(_mm_set_pd(b_s_tmp[qq], e[i]), tmp);
      _mm_storeu_pd(&tmp_1[0], tmp);
      emm1 = tmp_1[0];
      sqds = tmp_1[1];
      smm1 = ((smm1 + rt) * (smm1 - rt) + emm1 * emm1) / 2.0;
      emm1 *= rt;
      emm1 *= emm1;
      if ((smm1 != 0.0) || (emm1 != 0.0)) {
        shift = sqrt(smm1 * smm1 + emm1);
        if (smm1 < 0.0) {
          shift = -shift;
        }

        shift = emm1 / (smm1 + shift);
      } else {
        shift = 0.0;
      }

      rt = (sqds + rt) * (sqds - rt) + shift;
      ztest = e[qq] / ztest * sqds;
      for (qjj = qq + 1; qjj <= i + 1; qjj++) {
        Controller_xrotg(&rt, &ztest, &sqds, &smm1);
        if (qjj > qq + 1) {
          e[qjj - 2] = rt;
        }

        ztest = e[qjj - 1];
        emm1 = b_s_tmp[qjj - 1];
        rt = emm1 * sqds + ztest * smm1;
        e[qjj - 1] = ztest * sqds - emm1 * smm1;
        ztest = smm1 * b_s_tmp[qjj];
        b_s_tmp[qjj] *= sqds;
        Controller_xrot(V, 6 * (qjj - 1) + 1, 6 * qjj + 1, sqds, smm1);
        b_s_tmp[qjj - 1] = rt;
        Controller_xrotg(&b_s_tmp[qjj - 1], &ztest, &sqds, &smm1);
        ztest = e[qjj - 1];
        rt = ztest * sqds + smm1 * b_s_tmp[qjj];
        b_s_tmp[qjj] = ztest * -smm1 + sqds * b_s_tmp[qjj];
        ztest = smm1 * e[qjj];
        e[qjj] *= sqds;
        Controller_xrot_c(U, ((qjj - 1) << 3) + 1, (qjj << 3) + 1, sqds, smm1);
      }

      e[i] = rt;
      qp1++;
      break;

     default:
      if (b_s_tmp[qq] < 0.0) {
        b_s_tmp[qq] = -b_s_tmp[qq];
        qp1 = 6 * qq + 1;
        scalarLB = 6 + qp1;
        vectorUB = scalarLB - 2;
        for (qjj = qp1; qjj <= vectorUB; qjj += 2) {
          tmp = _mm_loadu_pd(&V[qjj - 1]);
          tmp = _mm_mul_pd(tmp, _mm_set1_pd(-1.0));
          _mm_storeu_pd(&V[qjj - 1], tmp);
        }

        for (qjj = scalarLB; qjj <= qp1 + 5; qjj++) {
          V[qjj - 1] = -V[qjj - 1];
        }
      }

      qp1 = qq + 1;
      while ((qq + 1 < 6) && (b_s_tmp[qq] < b_s_tmp[qp1])) {
        rt = b_s_tmp[qq];
        b_s_tmp[qq] = b_s_tmp[qp1];
        b_s_tmp[qp1] = rt;
        Controller_xswap(V, 6 * qq + 1, 6 * (qq + 1) + 1);
        Controller_xswap_j(U, (qq << 3) + 1, ((qq + 1) << 3) + 1);
        qq = qp1;
        qp1++;
      }

      qp1 = 0;
      i--;
      break;
    }
  }

  for (i = 0; i < 6; i++) {
    s[i] = b_s_tmp[i];
  }

  if (doscale) {
    Controller_xzlascl_h(cscale, anrm, s);
  }
}

/* Model step function */
void Controller_step(void)
{
  __m128d tmp;
  __m128d tmp_0;
  real_T U[48];
  real_T inv_wrench[48];
  real_T V[36];
  real_T s[6];
  real_T tmp_1[2];
  real_T absx;
  int32_T ar;
  int32_T b;
  int32_T b_ic;
  int32_T ib;
  int32_T j;
  int32_T r;
  int32_T scalarLB;
  int32_T vcol;
  int32_T vectorUB;
  boolean_T exitg1;
  boolean_T p;
  if (rtmIsMajorTimeStep(Controller_M)) {
    /* set solver stop time */
    if (!(Controller_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&Controller_M->solverInfo,
                            ((Controller_M->Timing.clockTickH0 + 1) *
        Controller_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&Controller_M->solverInfo,
                            ((Controller_M->Timing.clockTick0 + 1) *
        Controller_M->Timing.stepSize0 + Controller_M->Timing.clockTickH0 *
        Controller_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(Controller_M)) {
    Controller_M->Timing.t[0] = rtsiGetT(&Controller_M->solverInfo);
  }

  /* Gain: '<S48>/Proportional Gain' incorporates:
   *  Inport: '<Root>/Error'
   */
  Controller_B.ProportionalGain = Controller_P.PID1_P * Controller_U.Error[0];

  /* Integrator: '<S43>/Integrator' */
  Controller_B.Integrator = Controller_X.Integrator_CSTATE;

  /* Gain: '<S36>/Derivative Gain' incorporates:
   *  Inport: '<Root>/Error'
   */
  Controller_B.DerivativeGain = Controller_P.PID1_D * Controller_U.Error[0];

  /* Integrator: '<S38>/Filter' */
  Controller_B.Filter = Controller_X.Filter_CSTATE;

  /* Sum: '<S38>/SumD' */
  Controller_B.SumD = Controller_B.DerivativeGain - Controller_B.Filter;

  /* Gain: '<S46>/Filter Coefficient' */
  Controller_B.FilterCoefficient = Controller_P.PID1_N * Controller_B.SumD;

  /* Sum: '<S52>/Sum' */
  Controller_B.Sum = (Controller_B.ProportionalGain + Controller_B.Integrator) +
    Controller_B.FilterCoefficient;

  /* Gain: '<S100>/Proportional Gain' incorporates:
   *  Inport: '<Root>/Error'
   */
  Controller_B.ProportionalGain_c = Controller_P.PID2_P * Controller_U.Error[1];

  /* Integrator: '<S95>/Integrator' */
  Controller_B.Integrator_f = Controller_X.Integrator_CSTATE_m;

  /* Gain: '<S88>/Derivative Gain' incorporates:
   *  Inport: '<Root>/Error'
   */
  Controller_B.DerivativeGain_j = Controller_P.PID2_D * Controller_U.Error[1];

  /* Integrator: '<S90>/Filter' */
  Controller_B.Filter_e = Controller_X.Filter_CSTATE_i;

  /* Sum: '<S90>/SumD' */
  Controller_B.SumD_f = Controller_B.DerivativeGain_j - Controller_B.Filter_e;

  /* Gain: '<S98>/Filter Coefficient' */
  Controller_B.FilterCoefficient_d = Controller_P.PID2_N * Controller_B.SumD_f;

  /* Sum: '<S104>/Sum' */
  Controller_B.Sum_d = (Controller_B.ProportionalGain_c +
                        Controller_B.Integrator_f) +
    Controller_B.FilterCoefficient_d;

  /* Gain: '<S152>/Proportional Gain' incorporates:
   *  Inport: '<Root>/Error'
   */
  Controller_B.ProportionalGain_h = Controller_P.PID3_P * Controller_U.Error[2];

  /* Integrator: '<S147>/Integrator' */
  Controller_B.Integrator_c = Controller_X.Integrator_CSTATE_j;

  /* Gain: '<S140>/Derivative Gain' incorporates:
   *  Inport: '<Root>/Error'
   */
  Controller_B.DerivativeGain_d = Controller_P.PID3_D * Controller_U.Error[2];

  /* Integrator: '<S142>/Filter' */
  Controller_B.Filter_m = Controller_X.Filter_CSTATE_e;

  /* Sum: '<S142>/SumD' */
  Controller_B.SumD_i = Controller_B.DerivativeGain_d - Controller_B.Filter_m;

  /* Gain: '<S150>/Filter Coefficient' */
  Controller_B.FilterCoefficient_g = Controller_P.PID3_N * Controller_B.SumD_i;

  /* Sum: '<S156>/Sum' */
  Controller_B.Sum_a = (Controller_B.ProportionalGain_h +
                        Controller_B.Integrator_c) +
    Controller_B.FilterCoefficient_g;

  /* Gain: '<S204>/Proportional Gain' incorporates:
   *  Inport: '<Root>/Error'
   */
  Controller_B.ProportionalGain_b = Controller_P.PID4_P * Controller_U.Error[3];

  /* Integrator: '<S199>/Integrator' */
  Controller_B.Integrator_h = Controller_X.Integrator_CSTATE_k;

  /* Gain: '<S192>/Derivative Gain' incorporates:
   *  Inport: '<Root>/Error'
   */
  Controller_B.DerivativeGain_p = Controller_P.PID4_D * Controller_U.Error[3];

  /* Integrator: '<S194>/Filter' */
  Controller_B.Filter_l = Controller_X.Filter_CSTATE_j;

  /* Sum: '<S194>/SumD' */
  Controller_B.SumD_m = Controller_B.DerivativeGain_p - Controller_B.Filter_l;

  /* Gain: '<S202>/Filter Coefficient' */
  Controller_B.FilterCoefficient_p = Controller_P.PID4_N * Controller_B.SumD_m;

  /* Sum: '<S208>/Sum' */
  Controller_B.Sum_b = (Controller_B.ProportionalGain_b +
                        Controller_B.Integrator_h) +
    Controller_B.FilterCoefficient_p;

  /* Gain: '<S256>/Proportional Gain' incorporates:
   *  Inport: '<Root>/Error'
   */
  Controller_B.ProportionalGain_f = Controller_P.PID5_P * Controller_U.Error[4];

  /* Integrator: '<S251>/Integrator' */
  Controller_B.Integrator_e = Controller_X.Integrator_CSTATE_p;

  /* Gain: '<S244>/Derivative Gain' incorporates:
   *  Inport: '<Root>/Error'
   */
  Controller_B.DerivativeGain_i = Controller_P.PID5_D * Controller_U.Error[4];

  /* Integrator: '<S246>/Filter' */
  Controller_B.Filter_d = Controller_X.Filter_CSTATE_o;

  /* Sum: '<S246>/SumD' */
  Controller_B.SumD_g = Controller_B.DerivativeGain_i - Controller_B.Filter_d;

  /* Gain: '<S254>/Filter Coefficient' */
  Controller_B.FilterCoefficient_m = Controller_P.PID5_N * Controller_B.SumD_g;

  /* Sum: '<S260>/Sum' */
  Controller_B.Sum_p = (Controller_B.ProportionalGain_f +
                        Controller_B.Integrator_e) +
    Controller_B.FilterCoefficient_m;

  /* Gain: '<S308>/Proportional Gain' incorporates:
   *  Inport: '<Root>/Error'
   */
  Controller_B.ProportionalGain_d = Controller_P.PID6_P * Controller_U.Error[5];

  /* Integrator: '<S303>/Integrator' */
  Controller_B.Integrator_hu = Controller_X.Integrator_CSTATE_h;

  /* Gain: '<S296>/Derivative Gain' incorporates:
   *  Inport: '<Root>/Error'
   */
  Controller_B.DerivativeGain_m = Controller_P.PID6_D * Controller_U.Error[5];

  /* Integrator: '<S298>/Filter' */
  Controller_B.Filter_d2 = Controller_X.Filter_CSTATE_a;

  /* Sum: '<S298>/SumD' */
  Controller_B.SumD_n = Controller_B.DerivativeGain_m - Controller_B.Filter_d2;

  /* Gain: '<S306>/Filter Coefficient' */
  Controller_B.FilterCoefficient_j = Controller_P.PID6_N * Controller_B.SumD_n;

  /* Sum: '<S312>/Sum' */
  Controller_B.Sum_c = (Controller_B.ProportionalGain_d +
                        Controller_B.Integrator_hu) +
    Controller_B.FilterCoefficient_j;

  /* SignalConversion generated from: '<S2>/ SFunction ' incorporates:
   *  MATLAB Function: '<S1>/MATLAB Function'
   */
  Controller_B.TmpSignalConversionAtSFunctionI[0] = Controller_B.Sum;
  Controller_B.TmpSignalConversionAtSFunctionI[1] = Controller_B.Sum_d;
  Controller_B.TmpSignalConversionAtSFunctionI[2] = Controller_B.Sum_a;
  Controller_B.TmpSignalConversionAtSFunctionI[3] = Controller_B.Sum_b;
  Controller_B.TmpSignalConversionAtSFunctionI[4] = Controller_B.Sum_p;
  Controller_B.TmpSignalConversionAtSFunctionI[5] = Controller_B.Sum_c;

  /* MATLAB Function: '<S1>/MATLAB Function' */
  /* :  inv_wrench = pinv(wrench); */
  p = true;
  for (r = 0; r < 48; r++) {
    inv_wrench[r] = 0.0;
    if (p && ((!rtIsInf(Controller_P.wrench[r])) && (!rtIsNaN
          (Controller_P.wrench[r])))) {
    } else {
      p = false;
    }
  }

  if (!p) {
    for (r = 0; r < 48; r++) {
      inv_wrench[r] = (rtNaN);
    }
  } else {
    Controller_svd(Controller_P.wrench, U, s, V);
    absx = fabs(s[0]);
    if (rtIsInf(absx) || rtIsNaN(absx)) {
      absx = (rtNaN);
    } else if (absx < 4.4501477170144028E-308) {
      absx = 4.94065645841247E-324;
    } else {
      frexp(absx, &vcol);
      absx = ldexp(1.0, vcol - 53);
    }

    absx *= 8.0;
    r = 0;
    exitg1 = false;
    while ((!exitg1) && (r < 6)) {
      if (rtIsInf(s[r]) || rtIsNaN(s[r])) {
        absx = 1.7976931348623157E+308;
        exitg1 = true;
      } else {
        r++;
      }
    }

    r = -1;
    vcol = 0;
    while ((vcol < 6) && (s[vcol] > absx)) {
      r++;
      vcol++;
    }

    if (r + 1 > 0) {
      vcol = 1;
      for (j = 0; j <= r; j++) {
        absx = 1.0 / s[j];
        scalarLB = 6 + vcol;
        vectorUB = scalarLB - 2;
        for (ar = vcol; ar <= vectorUB; ar += 2) {
          tmp_0 = _mm_loadu_pd(&V[ar - 1]);
          tmp_0 = _mm_mul_pd(tmp_0, _mm_set1_pd(absx));
          _mm_storeu_pd(&V[ar - 1], tmp_0);
        }

        for (ar = scalarLB; ar <= vcol + 5; ar++) {
          V[ar - 1] *= absx;
        }

        vcol += 6;
      }

      for (vcol = 0; vcol <= 42; vcol += 6) {
        for (j = vcol + 1; j <= vcol + 6; j++) {
          inv_wrench[j - 1] = 0.0;
        }
      }

      vcol = 0;
      for (j = 0; j <= 42; j += 6) {
        ar = -1;
        vcol++;
        b = (r << 3) + vcol;
        for (ib = vcol; ib <= b; ib += 8) {
          scalarLB = j + 7;
          vectorUB = scalarLB - 2;
          for (b_ic = j + 1; b_ic <= vectorUB; b_ic += 2) {
            tmp_0 = _mm_loadu_pd(&V[(ar + b_ic) - j]);
            tmp_0 = _mm_mul_pd(tmp_0, _mm_set1_pd(U[ib - 1]));
            tmp = _mm_loadu_pd(&inv_wrench[b_ic - 1]);
            tmp_0 = _mm_add_pd(tmp_0, tmp);
            _mm_storeu_pd(&inv_wrench[b_ic - 1], tmp_0);
          }

          for (b_ic = scalarLB; b_ic <= j + 6; b_ic++) {
            inv_wrench[b_ic - 1] += V[(ar + b_ic) - j] * U[ib - 1];
          }

          ar += 6;
        }
      }
    }
  }

  /* :  u = inv_wrench' * e; */
  for (vcol = 0; vcol < 8; vcol++) {
    absx = 0.0;
    for (r = 0; r < 6; r++) {
      absx += inv_wrench[6 * vcol + r] *
        Controller_B.TmpSignalConversionAtSFunctionI[r];
    }

    Controller_B.u[vcol] = absx;

    /* Gain: '<S1>/Gain' */
    absx *= Controller_P.Gain_Gain;
    Controller_B.Gain[vcol] = absx;

    /* Sum: '<S1>/Sum1' incorporates:
     *  Constant: '<S1>/PWM Stop'
     */
    absx += Controller_P.pwm_stop;
    Controller_B.Sum1[vcol] = absx;

    /* Saturate: '<S1>/Saturation' */
    if (absx > Controller_P.Saturation_UpperSat) {
      /* Saturate: '<S1>/Saturation' */
      absx = Controller_P.Saturation_UpperSat;
    } else if (absx < Controller_P.Saturation_LowerSat) {
      /* Saturate: '<S1>/Saturation' */
      absx = Controller_P.Saturation_LowerSat;
    }

    /* End of Saturate: '<S1>/Saturation' */

    /* Saturate: '<S1>/Saturation' */
    Controller_B.Saturation[vcol] = absx;

    /* Math: '<S1>/Transpose' */
    Controller_B.Transpose[vcol] = absx;

    /* Outport: '<Root>/PWM' incorporates:
     *  Math: '<S1>/Transpose'
     */
    Controller_Y.PWM[vcol] = absx;
  }

  /* Gain: '<S92>/Integral Gain' incorporates:
   *  Gain: '<S40>/Integral Gain'
   *  Inport: '<Root>/Error'
   */
  tmp_0 = _mm_mul_pd(_mm_set_pd(Controller_P.PID2_I, Controller_P.PID1_I),
                     _mm_loadu_pd(&Controller_U.Error[0]));
  _mm_storeu_pd(&tmp_1[0], tmp_0);

  /* Gain: '<S40>/Integral Gain' */
  Controller_B.IntegralGain = tmp_1[0];

  /* Gain: '<S92>/Integral Gain' */
  Controller_B.IntegralGain_k = tmp_1[1];

  /* Gain: '<S196>/Integral Gain' incorporates:
   *  Gain: '<S144>/Integral Gain'
   *  Inport: '<Root>/Error'
   */
  tmp_0 = _mm_mul_pd(_mm_set_pd(Controller_P.PID4_I, Controller_P.PID3_I),
                     _mm_loadu_pd(&Controller_U.Error[2]));
  _mm_storeu_pd(&tmp_1[0], tmp_0);

  /* Gain: '<S144>/Integral Gain' */
  Controller_B.IntegralGain_g = tmp_1[0];

  /* Gain: '<S196>/Integral Gain' */
  Controller_B.IntegralGain_ku = tmp_1[1];

  /* Gain: '<S300>/Integral Gain' incorporates:
   *  Gain: '<S248>/Integral Gain'
   *  Inport: '<Root>/Error'
   */
  tmp_0 = _mm_mul_pd(_mm_set_pd(Controller_P.PID6_I, Controller_P.PID5_I),
                     _mm_loadu_pd(&Controller_U.Error[4]));
  _mm_storeu_pd(&tmp_1[0], tmp_0);

  /* Gain: '<S248>/Integral Gain' */
  Controller_B.IntegralGain_a = tmp_1[0];

  /* Gain: '<S300>/Integral Gain' */
  Controller_B.IntegralGain_l = tmp_1[1];
  if (rtmIsMajorTimeStep(Controller_M)) {
    /* Matfile logging */
    rt_UpdateTXYLogVars(Controller_M->rtwLogInfo, (Controller_M->Timing.t));
  }                                    /* end MajorTimeStep */

  if (rtmIsMajorTimeStep(Controller_M)) {
    /* signal main to stop simulation */
    {                                  /* Sample time: [0.0s, 0.0s] */
      if ((rtmGetTFinal(Controller_M)!=-1) &&
          !((rtmGetTFinal(Controller_M)-(((Controller_M->Timing.clockTick1+
               Controller_M->Timing.clockTickH1* 4294967296.0)) * 1.2)) >
            (((Controller_M->Timing.clockTick1+Controller_M->Timing.clockTickH1*
               4294967296.0)) * 1.2) * (DBL_EPSILON))) {
        rtmSetErrorStatus(Controller_M, "Simulation finished");
      }
    }

    rt_ertODEUpdateContinuousStates(&Controller_M->solverInfo);

    /* Update absolute time for base rate */
    /* The "clockTick0" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick0"
     * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick0 and the high bits
     * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++Controller_M->Timing.clockTick0)) {
      ++Controller_M->Timing.clockTickH0;
    }

    Controller_M->Timing.t[0] = rtsiGetSolverStopTime(&Controller_M->solverInfo);

    {
      /* Update absolute timer for sample time: [1.2s, 0.0s] */
      /* The "clockTick1" counts the number of times the code of this task has
       * been executed. The resolution of this integer timer is 1.2, which is the step size
       * of the task. Size of "clockTick1" ensures timer will not overflow during the
       * application lifespan selected.
       * Timer of this task consists of two 32 bit unsigned integers.
       * The two integers represent the low bits Timing.clockTick1 and the high bits
       * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
       */
      Controller_M->Timing.clockTick1++;
      if (!Controller_M->Timing.clockTick1) {
        Controller_M->Timing.clockTickH1++;
      }
    }
  }                                    /* end MajorTimeStep */
}

/* Derivatives for root system: '<Root>' */
void Controller_derivatives(void)
{
  XDot_Controller_T *_rtXdot;
  _rtXdot = ((XDot_Controller_T *) Controller_M->derivs);

  /* Derivatives for Integrator: '<S43>/Integrator' */
  _rtXdot->Integrator_CSTATE = Controller_B.IntegralGain;

  /* Derivatives for Integrator: '<S38>/Filter' */
  _rtXdot->Filter_CSTATE = Controller_B.FilterCoefficient;

  /* Derivatives for Integrator: '<S95>/Integrator' */
  _rtXdot->Integrator_CSTATE_m = Controller_B.IntegralGain_k;

  /* Derivatives for Integrator: '<S90>/Filter' */
  _rtXdot->Filter_CSTATE_i = Controller_B.FilterCoefficient_d;

  /* Derivatives for Integrator: '<S147>/Integrator' */
  _rtXdot->Integrator_CSTATE_j = Controller_B.IntegralGain_g;

  /* Derivatives for Integrator: '<S142>/Filter' */
  _rtXdot->Filter_CSTATE_e = Controller_B.FilterCoefficient_g;

  /* Derivatives for Integrator: '<S199>/Integrator' */
  _rtXdot->Integrator_CSTATE_k = Controller_B.IntegralGain_ku;

  /* Derivatives for Integrator: '<S194>/Filter' */
  _rtXdot->Filter_CSTATE_j = Controller_B.FilterCoefficient_p;

  /* Derivatives for Integrator: '<S251>/Integrator' */
  _rtXdot->Integrator_CSTATE_p = Controller_B.IntegralGain_a;

  /* Derivatives for Integrator: '<S246>/Filter' */
  _rtXdot->Filter_CSTATE_o = Controller_B.FilterCoefficient_m;

  /* Derivatives for Integrator: '<S303>/Integrator' */
  _rtXdot->Integrator_CSTATE_h = Controller_B.IntegralGain_l;

  /* Derivatives for Integrator: '<S298>/Filter' */
  _rtXdot->Filter_CSTATE_a = Controller_B.FilterCoefficient_j;
}

/* Model initialize function */
void Controller_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)Controller_M, 0,
                sizeof(RT_MODEL_Controller_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&Controller_M->solverInfo,
                          &Controller_M->Timing.simTimeStep);
    rtsiSetTPtr(&Controller_M->solverInfo, &rtmGetTPtr(Controller_M));
    rtsiSetStepSizePtr(&Controller_M->solverInfo,
                       &Controller_M->Timing.stepSize0);
    rtsiSetdXPtr(&Controller_M->solverInfo, &Controller_M->derivs);
    rtsiSetContStatesPtr(&Controller_M->solverInfo, (real_T **)
                         &Controller_M->contStates);
    rtsiSetNumContStatesPtr(&Controller_M->solverInfo,
      &Controller_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&Controller_M->solverInfo,
      &Controller_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&Controller_M->solverInfo,
      &Controller_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&Controller_M->solverInfo,
      &Controller_M->periodicContStateRanges);
    rtsiSetContStateDisabledPtr(&Controller_M->solverInfo, (boolean_T**)
      &Controller_M->contStateDisabled);
    rtsiSetErrorStatusPtr(&Controller_M->solverInfo, (&rtmGetErrorStatus
      (Controller_M)));
    rtsiSetRTModelPtr(&Controller_M->solverInfo, Controller_M);
  }

  rtsiSetSimTimeStep(&Controller_M->solverInfo, MAJOR_TIME_STEP);
  rtsiSetIsMinorTimeStepWithModeChange(&Controller_M->solverInfo, false);
  rtsiSetIsContModeFrozen(&Controller_M->solverInfo, false);
  Controller_M->intgData.y = Controller_M->odeY;
  Controller_M->intgData.f[0] = Controller_M->odeF[0];
  Controller_M->intgData.f[1] = Controller_M->odeF[1];
  Controller_M->intgData.f[2] = Controller_M->odeF[2];
  Controller_M->contStates = ((X_Controller_T *) &Controller_X);
  Controller_M->contStateDisabled = ((XDis_Controller_T *) &Controller_XDis);
  Controller_M->Timing.tStart = (0.0);
  rtsiSetSolverData(&Controller_M->solverInfo, (void *)&Controller_M->intgData);
  rtsiSetSolverName(&Controller_M->solverInfo,"ode3");
  rtmSetTPtr(Controller_M, &Controller_M->Timing.tArray[0]);
  rtmSetTFinal(Controller_M, 60.0);
  Controller_M->Timing.stepSize0 = 1.2;

  /* Setup for data logging */
  {
    static RTWLogInfo rt_DataLoggingInfo;
    rt_DataLoggingInfo.loggingInterval = (NULL);
    Controller_M->rtwLogInfo = &rt_DataLoggingInfo;
  }

  /* Setup for data logging */
  {
    rtliSetLogXSignalInfo(Controller_M->rtwLogInfo, (NULL));
    rtliSetLogXSignalPtrs(Controller_M->rtwLogInfo, (NULL));
    rtliSetLogT(Controller_M->rtwLogInfo, "tout");
    rtliSetLogX(Controller_M->rtwLogInfo, "");
    rtliSetLogXFinal(Controller_M->rtwLogInfo, "");
    rtliSetLogVarNameModifier(Controller_M->rtwLogInfo, "rt_");
    rtliSetLogFormat(Controller_M->rtwLogInfo, 4);
    rtliSetLogMaxRows(Controller_M->rtwLogInfo, 0);
    rtliSetLogDecimation(Controller_M->rtwLogInfo, 1);
    rtliSetLogY(Controller_M->rtwLogInfo, "");
    rtliSetLogYSignalInfo(Controller_M->rtwLogInfo, (NULL));
    rtliSetLogYSignalPtrs(Controller_M->rtwLogInfo, (NULL));
  }

  /* block I/O */
  (void) memset(((void *) &Controller_B), 0,
                sizeof(B_Controller_T));

  /* states (continuous) */
  {
    (void) memset((void *)&Controller_X, 0,
                  sizeof(X_Controller_T));
  }

  /* disabled states */
  {
    (void) memset((void *)&Controller_XDis, 0,
                  sizeof(XDis_Controller_T));
  }

  /* external inputs */
  (void)memset(&Controller_U, 0, sizeof(ExtU_Controller_T));

  /* external outputs */
  (void)memset(&Controller_Y, 0, sizeof(ExtY_Controller_T));

  /* Matfile logging */
  rt_StartDataLoggingWithStartTime(Controller_M->rtwLogInfo, 0.0, rtmGetTFinal
    (Controller_M), Controller_M->Timing.stepSize0, (&rtmGetErrorStatus
    (Controller_M)));

  /* InitializeConditions for Integrator: '<S43>/Integrator' */
  Controller_X.Integrator_CSTATE = Controller_P.PID1_InitialConditionForIntegra;

  /* InitializeConditions for Integrator: '<S38>/Filter' */
  Controller_X.Filter_CSTATE = Controller_P.PID1_InitialConditionForFilter;

  /* InitializeConditions for Integrator: '<S95>/Integrator' */
  Controller_X.Integrator_CSTATE_m =
    Controller_P.PID2_InitialConditionForIntegra;

  /* InitializeConditions for Integrator: '<S90>/Filter' */
  Controller_X.Filter_CSTATE_i = Controller_P.PID2_InitialConditionForFilter;

  /* InitializeConditions for Integrator: '<S147>/Integrator' */
  Controller_X.Integrator_CSTATE_j =
    Controller_P.PID3_InitialConditionForIntegra;

  /* InitializeConditions for Integrator: '<S142>/Filter' */
  Controller_X.Filter_CSTATE_e = Controller_P.PID3_InitialConditionForFilter;

  /* InitializeConditions for Integrator: '<S199>/Integrator' */
  Controller_X.Integrator_CSTATE_k =
    Controller_P.PID4_InitialConditionForIntegra;

  /* InitializeConditions for Integrator: '<S194>/Filter' */
  Controller_X.Filter_CSTATE_j = Controller_P.PID4_InitialConditionForFilter;

  /* InitializeConditions for Integrator: '<S251>/Integrator' */
  Controller_X.Integrator_CSTATE_p =
    Controller_P.PID5_InitialConditionForIntegra;

  /* InitializeConditions for Integrator: '<S246>/Filter' */
  Controller_X.Filter_CSTATE_o = Controller_P.PID5_InitialConditionForFilter;

  /* InitializeConditions for Integrator: '<S303>/Integrator' */
  Controller_X.Integrator_CSTATE_h =
    Controller_P.PID6_InitialConditionForIntegra;

  /* InitializeConditions for Integrator: '<S298>/Filter' */
  Controller_X.Filter_CSTATE_a = Controller_P.PID6_InitialConditionForFilter;
}

/* Model terminate function */
void Controller_terminate(void)
{
  /* (no terminate code required) */
}
