from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize
import numpy

setup(
    ext_modules = cythonize([Extension("klu", ["klu.pyx", 'klu_interf.c'], include_dirs=[numpy.get_include()],
								libraries=[	'klu', 
											'btf', 
											'amd', 
											'colamd',
											'suitesparseconfig',
											'rt'])])
								#libraries=["superlu_4.3", 'blas'])])
)
