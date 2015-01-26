cdef extern from "klu_interf.h":
	
	ctypedef struct lu_state:
		pass
	
	cdef void hello()
	cdef lu_state* construct_superlu(int m, int n, int nnz, double* Acsc_data_ptr, 
		int* Acsc_indices_ptr, int* Acsc_indptr_ptr)
	cdef void lusolve(lu_state* lus, double* b, double* x)
	cdef void lu_destroy(lu_state* lus)
