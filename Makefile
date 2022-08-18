src/asm.o: src/asm.S
	cd src && \
	gcc asm.S -c -o asm.o

src/asm.bin: src/asm.o
	cd src && \
	ld asm.o -e start -o asm.bin

src/lib.so: src/asm.o
	cd src && \
	ld asm.o -shared -o lib.so

run: src/lib.so src/python.py
	cd src && \
	LD_LIBRARY_PATH=. python3 python.py
