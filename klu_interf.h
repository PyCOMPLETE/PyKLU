#ifndef __KLUINTERF
#define __KLUINTERF

#include <stdio.h>
#include "klu.h"

void hello();

typedef struct{
	int m;
	klu_common Common;
	klu_symbolic *Symbolic ;
    klu_numeric *Numeric ;
} lu_state;

lu_state* construct_superlu(int m, int n, int nnz, double* Acsc_data_ptr, 
		int* Acsc_indices_ptr, int* Acsc_indptr_ptr);

void lusolve(lu_state* lus, double* b, double* x);

void lu_destroy(lu_state* lus);

#endif
