#include "cuda_runtime.h"
#include <iostream>


using namespace std;

//kernel function
__global__ void add(int *a, int *b, int *c)
{

    *c = *a + *b;
    
}

// code to run on the CPU
int main(){

    cudaDeviceReset();
    
    int a, b, c;
    int *device_a, *device_b, *device_c;
    int size = sizeof(int);

    cudaMalloc((void**)&device_a, size);
    cudaMalloc((void**)&device_b, size);
    cudaMalloc((void**)&device_c, size);

    a = 10;
    b = 40;

    cudaMemcpy(device_a, &a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(device_b, &b, size, cudaMemcpyHostToDevice);

    add<<<1,1>>>(device_a, device_b, device_c);

    cudaMemcpy(&c, device_c, size, cudaMemcpyDeviceToHost);
    cout << "a + b = " << c << "\n";
    cudaFree(device_a);
    cudaFree(device_b);
    cudaFree(device_c);
    
    return 0;
}