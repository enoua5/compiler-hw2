import argparse
import sys

def getArgs():
    parser = argparse.ArgumentParser(description="Compiler the CS6820 programming language.")
    parser.add_argument('file', help="File to compile.")
    parser.add_argument('-o', dest="out_file", action='store', default='out.nasm', help="File to output to")
    return parser.parse_args()


from src.compile import compile

if __name__ == '__main__':
    args = getArgs()

    try:
        asm = compile(args.file)
    except FileNotFoundError:
        print("File could not be opened.")
        sys.exit(1)

    if asm is None:
        print("Failed to compile")
        sys.exit(1)
    else:
        try:
            f = open(args.out_file, 'w')
            f.write(asm)
            f.close()
        except FileNotFoundError:
            print("Output file could not be opened.")
            sys.exit(1)
