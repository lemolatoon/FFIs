src/asm.so: src/asm.S
	cd src && \
	gcc -O3 asm.S -shared -o asm.so

src/fortran.so: src/fortran.f90
	cd src && \
	gfortran -O3 fortran.f90 -shared -o fortran.so

src/librust.so: FORCE
	cd src/rust && \
	cargo build --release && \
	cp target/release/librust.so ../librust.so

src/c.so: src/c.c
	cd src && \
	gcc -fPIC -O3 c.c -shared -o c.so

src/lib.so: src/asm.so src/fortran.so src/librust.so src/c.so
	cd src && \
	ld asm.so fortran.so librust.so c.so -shared -o lib.so

run: src/lib.so src/python.py
	cd src && \
	LD_LIBRARY_PATH=. python3 python.py

.PHONY: FORCE run