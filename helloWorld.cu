#include<stdio.h>
#include "cuda_runtime.h"
// kernel
__global__ void meuKernel(){
    
    printf("Hello World da GPU!\n");

    
}

//codigo de CPU

int main(){
    printf("Hello World!\n");
    meuKernel <<<1,2>>>();
    return 0;
}
