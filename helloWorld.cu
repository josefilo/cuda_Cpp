#include<stdio.h>
#include "cuda_runtime.h"
// kernel
__global__ void meuKernel(){
    
    printf("Hello World da GPU!\n");

    
}

//codigo de CPU

int main(){
    printf("Hello World!\n");
    meuKernel <<<2,2>>>();
    /*É preciso colocar para que a CPU espere a GPU terminar,
    se eu não colocar o programa terminar sem dar tempo da GPU Imprimir os dados*/
    cudaDeviceSynchronize();
    return 0;
}
