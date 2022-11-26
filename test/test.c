#include <stdio.h>

void print(double n)
{
    printf("%f\n", n);
}


int main()
{
    double a = -1;
    double b = 2;
    double c = -1;
    print(a * b / c);
    return 0;
}