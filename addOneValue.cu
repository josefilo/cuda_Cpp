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
    cudaError_t cudaStatus;
    cudaDeviceReset();
    
    int a, b, c;
    int *device_a, *device_b, *device_c;
    int size = sizeof(int);

    cudaStatus = cudaMalloc((void**)&device_a, size);
    if(cudaStatus != cudaSuccess){
        cout << "cudaMalloc device_a failed!";
        return 1;
    }

    cudaStatus = cudaMalloc((void**)&device_b, size);
    if(cudaStatus != cudaSuccess){
        cout << "cudaMalloc device_b failed!";
        return 1;
    }
    
    cudaStatus =  cudaMalloc((void**)&device_c, size);
    if(cudaStatus != cudaSuccess){
        cout << "cudaMalloc device_c failed!";
        return 1;
    }

    a = 10;
    b = 40;

    cudaStatus = cudaMemcpy(device_a, &a, size, cudaMemcpyHostToDevice);
    if(cudaStatus != cudaSuccess){
        cout << "cudaMemcpy device_a to a failed!";
        return 1;
    }

    cudaStatus = cudaMemcpy(device_b, &b, size, cudaMemcpyHostToDevice);
    if(cudaStatus != cudaSuccess){
        cout << "cudaMemcpy device_b to b failed!";
        return 1;
    }

    add<<<1,1>>>(device_a, device_b, device_c);

    cudaStatus = cudaMemcpy(&c, device_c, size, cudaMemcpyDeviceToHost);
    if(cudaStatus != cudaSuccess){
        cout << "cudaMemcpy device_c to c failed!";
        return 1;
    }
    cout << "a + b = " << c << "\n";
    
    cudaFree(device_a);
    cudaFree(device_b);
    cudaFree(device_c);
    
    return 0;
}