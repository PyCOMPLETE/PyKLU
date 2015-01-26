#include "klu_interf.h"


void hello()
{
	printf("Hello!\n");
}




lu_state* construct_superlu(int m, int n, int nnz, double* Acsc_data_ptr, 
		int* Acsc_indices_ptr, int* Acsc_indptr_ptr)
{
	lu_state* lus = (lu_state*)malloc(sizeof(lu_state));
	
	
	//int n,              /* A is n-by-n */
    //int *Ap,            /* size n+1, column pointers */
    //int *Ai,            /* size nz = Ap [n], row indices */
    //double *Ax,         /* size nz, numerical values */
    
   
	//klu_common Common;
	
	lus->m = m;
	klu_defaults(&(lus->Common));
	
	(lus->Symbolic) = klu_analyze (m, Acsc_indptr_ptr, Acsc_indices_ptr, &(lus->Common)) ;
	lus->Numeric = klu_factor (Acsc_indptr_ptr, Acsc_indices_ptr, Acsc_data_ptr, lus->Symbolic,
								&(lus->Common));	   
	
	printf("Done factorization!\n");
	   
	return lus;
}

void lusolve(lu_state* lus, double* b, double* x)
{
	
	int ii;
	for (ii=0;ii<lus->m;ii++) x[ii]=b[ii];
	klu_solve (lus->Symbolic, lus->Numeric, lus->m, 1, x, &(lus->Common)) ;
	//printf("Over with construct Klu\n");
	   
        
}

void lu_destroy(lu_state* lus)
{
	
	printf("Destroying C klu objects...\n");
	klu_free_symbolic (&(lus->Symbolic), &(lus->Common));
    klu_free_numeric (&(lus->Numeric), &(lus->Common));
    free(lus);
    	
    printf("Done.\n");
    	
}
