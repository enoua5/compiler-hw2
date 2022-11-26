
program:
	python3 main.py
	nasm -o program.o -felf64 out.nasm
	gcc program.o -o program