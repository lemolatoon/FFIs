FORTRAN_LIB=-lgfortran -lquadmath

src/asm.so: src/asm.S
	cd src && \
	gcc asm.S -shared -o asm.so

src/fortran.so: src/fortran.f90
	cd src && \
	gfortran fortran.f90 -shared -o fortran.so

src/lib.so: src/asm.so src/fortran.so
	cd src && \
	ld asm.so fortran.so -shared -o lib.so

run: src/lib.so src/python.py
	cd src && \
	LD_LIBRARY_PATH=. python3 python.py
