/* MDH WCET BENCHMARK SUITE. File version $Id: ud.c,v 1.4 2005/11/11 10:32:53 ael01 Exp $ */


/*************************************************************************/
/*                                                                       */
/*   SNU-RT Benchmark Suite for Worst Case Timing Analysis               */
/*   =====================================================               */
/*                              Collected and Modified by S.-S. Lim      */
/*                                           sslim@archi.snu.ac.kr       */
/*                                         Real-Time Research Group      */
/*                                        Seoul National University      */
/*                                                                       */
/*                                                                       */
/*        < Features > - restrictions for our experimental environment   */
/*                                                                       */
/*          1. Completely structured.                                    */
/*               - There are no unconditional jumps.                     */
/*               - There are no exit from loop bodies.                   */
/*                 (There are no 'break' or 'return' in loop bodies)     */
/*          2. No 'switch' statements.                                   */
/*          3. No 'do..while' statements.                                */
/*          4. Expressions are restricted.                               */
/*               - There are no multiple expressions joined by 'or',     */
/*                'and' operations.                                      */
/*          5. No library calls.                                         */
/*               - All the functions needed are implemented in the       */
/*                 source file.                                          */
/*                                                                       */
/*                                                                       */
/*************************************************************************/
/*                                                                       */
/*  FILE: ludcmp.c                                                       */
/*  SOURCE : Turbo C Programming for Engineering                         */
/*                                                                       */
/*  DESCRIPTION :                                                        */
/*                                                                       */
/*     Simultaneous linear equations by LU decomposition.                */
/*     The arrays a[][] and b[] are input and the array x[] is output    */
/*     row vector.                                                       */
/*     The variable n is the number of equations.                        */
/*     The input arrays are initialized in function main.                */
/*                                                                       */
/*                                                                       */
/*  REMARK :                                                             */
/*                                                                       */
/*  EXECUTION TIME :                                                     */
/*                                                                       */
/*                                                                       */
/*************************************************************************/

/*************************************************************************
 *  This file:
 *
 *  - Name changed to "ud.c"
 *  - Modified for use with Uppsala/Paderborn tool
 *    : doubles changed to int
 *    : some tests removed
 *  - Program is much more linear, all loops will run to end
 *  - Purpose: test the effect of conditional flows
 *
 *************************************************************************/






/*
** Benchmark Suite for Real-Time Applications, by Sung-Soo Lim
**
**    III-4. ludcmp.c : Simultaneous Linear Equations by LU Decomposition
**                 (from the book C Programming for EEs by Hyun Soon Ahn)
*/
long int a[500][500], b[500], x[500];

int ludcmp(int nmax, int n);

void main()
{

  int i, j, nmax = 500, n = 100, chkerr;
  
  long int w;

  // Init loop with larger dimensions
  for(i = 0; i <= n; i++)
  {
    w = 0.0;
    for(j = 0; j <= n; j++)
    {
      a[i][j] = (i + 1) + (j + 1);
      if(i == j)
        a[i][j] *= 2.0;
      w += a[i][j];
    }
    b[i] = w;
  }
  
  chkerr = ludcmp(nmax, n);
}

int ludcmp(int nmax, int n)
{
  int i, j, k;
  long w, y[500];

  for(i = 0; i < n; i++)
  {
    for(j = i+1; j <= n; j++)
    {
      w = a[j][i];
      if(i != 0)
        for(k = 0; k < i; k++)
          w -= a[j][k] * a[k][i];
      a[j][i] = w / a[i][i];
    }
    
    for(j = i+1; j <= n; j++)
    {
      w = a[i+1][j];
      for(k = 0; k <= i; k++)
        w -= a[i+1][k] * a[k][j];
      a[i+1][j] = w;
    }
  }

  y[0] = b[0];
  
  for(i = 1; i <= n; i++)
  {
    w = b[i];
    for(j = 0; j < i; j++)
      w -= a[i][j] * y[j];
    y[i] = w;
  }
  
  x[n] = y[n] / a[n][n];
  
  for(i = n-1; i >= 0; i--)
  {
    w = y[i];
    for(j = i+1; j <= n; j++)
      w -= a[i][j] * x[j];
    x[i] = w / a[i][i];
  }
  
  return(0);
}
