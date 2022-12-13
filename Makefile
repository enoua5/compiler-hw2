
program: program.o
	gcc program.o -o program

program.o: program.nasm
	nasm -o program.o -felf64 program.nasm

program.nasm: main.py src/* files/accept-6000-2.txt
	python3 main.py -o program.nasm files/accept-6000-2.txt

test_exe: test.o
	gcc test.o -o test_exe

test.o: test.nasm
	nasm -o test.o -felf64 test.nasm

test.nasm: main.py src/* files/test.txt
	python3 main.py -o test.nasm files/test.txt

bad: main.py src/* files/reject.txt
	python3 main.py -o bad.nasm files/reject.txt

clean:
	rm -f program.nasm
	rm -f program.o
	rm -f program
	rm -f test.nasm
	rm -f test.o
	rm -f test
