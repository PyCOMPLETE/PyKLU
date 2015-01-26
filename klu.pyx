cimport klu
import numpy as np
cimport numpy as np

cpdef hellopython(Acsc, np.ndarray b, np.ndarray x):
	cdef int m, n, nnz
	 
	Acsc.tocsc()#just to be sure
	m, n = Acsc.shape
	nnz = Acsc.nnz
	
	# I extract the c data from Acsc
	
	#a is Asp.data
	#Asp.indptr is xa
	#Asp.indices is asub
	
	
	cdef np.ndarray Acsc_data
	cdef double* Acsc_data_ptr
	Acsc_data = Acsc.data
	Acsc_data_ptr = <double*>Acsc_data.data

	cdef np.ndarray Acsc_indptr
	cdef int* Acsc_indptr_ptr
	Acsc_indptr = Acsc.indptr
	Acsc_indptr_ptr = <int*>Acsc_indptr.data
	
	cdef np.ndarray Acsc_indices
	cdef int* Acsc_indices_ptr
	Acsc_indices = Acsc.indices
	Acsc_indices_ptr = <int*>Acsc_indices.data
	
	cdef lu_state* lus 
	lus = construct_superlu(m, n, nnz, Acsc_data_ptr, 
		 Acsc_indices_ptr, Acsc_indptr_ptr)
	
	cdef double* b_data 
	cdef double* x_data
	
	b_data = <double*>b.data
	x_data = <double*>x.data
	lusolve(lus, b_data, x_data)
	
cdef class Klu(object):
	
	cdef lu_state* lus
	
	def __init__(self,Acsc):
		Acsc = Acsc.tocsc()#just to be sure
		m, n = Acsc.shape
		nnz = Acsc.nnz
		
		cdef np.ndarray Acsc_data
		cdef double* Acsc_data_ptr
		Acsc_data = Acsc.data
		Acsc_data_ptr = <double*>Acsc_data.data

		cdef np.ndarray Acsc_indptr
		cdef int* Acsc_indptr_ptr
		Acsc_indptr = Acsc.indptr
		Acsc_indptr_ptr = <int*>Acsc_indptr.data
		
		cdef np.ndarray Acsc_indices
		cdef int* Acsc_indices_ptr
		Acsc_indices = Acsc.indices
		Acsc_indices_ptr = <int*>Acsc_indices.data
		
		 
		self.lus = construct_superlu(m, n, nnz, Acsc_data_ptr, 
			 Acsc_indices_ptr, Acsc_indptr_ptr)
			 
	cpdef solve(self, np.ndarray b):
		cdef double* b_data 
		cdef double* x_data
		cdef np.ndarray x
		x = 0.*b
		
		b_data = <double*>b.data
		x_data = <double*>x.data
		lusolve(self.lus, b_data, x_data)
		
		return x
		
	def __dealloc__(self):
		lu_destroy(self.lus)
		
