#cython: boundscheck=False
#cython: wraparound=False
#cython: initializedcheck=False
#cython: cdivision=True

import os

from PostProcessing_combine3d_py import combine3d

cdef class PostProcessing:

    def __init__(self,namelist) :
        self.out_path = ''
        self.fields_path = ''
        self.gridsize = [0,0,0]
        self.initialize(namelist)

    cpdef initialize(self, namelist):
        uuid = str(namelist['meta']['uuid'])
        out_path = str(os.path.join(namelist['output']['output_root'] + 'Output.' + namelist['meta']['simname'] + '.' + uuid[-5:])) 
        self.out_path = out_path
        self.fields_path = str(os.path.join(out_path, namelist['fields_io']['fields_dir'])) # see NetCDFIO.pyx
        self.gridsize = [namelist["grid"]["nx"], namelist["grid"]["ny"], namelist["grid"]["nz"]]

    cpdef combine3d(self):
        combine3d(self.fields_dir, self.out_dir)
