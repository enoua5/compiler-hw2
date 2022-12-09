
program: program.o
	gcc program.o -o program

program.o: program.nasm
	nasm -o program.o -felf64 program.nasm

program.nasm: main.py src/* files/accept-5000-2.txt
	python3 main.py -o program.nasm files/accept-5000-2.txt

bad: main.py src/* files/reject.txt
	python3 main.py -o bad.nasm files/reject.txt

clean:
	rm program.nasm
	rm program.o
	rm program
