#include "cuda_runtime.h"
#include <cuda.h>
#include <iostream>


using namespace std;

__global__ void SomaDeVetores(int *a, int *b, int *c) {
    int i = threadIdx.x;
    c[i] = a[i] + b[i];
}

int main(){
    cudaDeviceReset();
    cudaError_t cudaStatus;


    int *device_a, *device_b, *device_c;
    int *host_a, *host_b, *host_c;

    int tamanhoDoVetor = 1024;
    int size = tamanhoDoVetor * sizeof(int);

    host_a = (int *)malloc(size);
    host_b = (int *)malloc(size);
    host_c = (int *)malloc(size);

    for(int i = 0; i< tamanhoDoVetor ; i++){
        host_a[i] = i;
        host_b[i] = i;
    }

    cudaStatus = cudaMalloc((void **)&device_a, size);
    if(cudaStatus != cudaSuccess){
        cout << "cudaMalloc failed!" << "\n";
        return 1;
    }
    cudaStatus = cudaMalloc((void **)&device_b, size);
    if(cudaStatus != cudaSuccess){
        cout << "cudaMalloc failed!" << "\n";
        return 1;
    }
    cudaStatus = cudaMalloc((void **)&device_c, size);
    if(cudaStatus != cudaSuccess){
        cout << "cudaMalloc failed!" << "\n";
        return 1;
    }

    cudaStatus = cudaMemcpy(device_a, host_a, size, cudaMemcpyHostToDevice);
    if(cudaStatus != cudaSuccess){
        cout << "cudaMemcpy failed!" << "\n";
        return 1;
    }
    cudaStatus = cudaMemcpy(device_b, host_b, size, cudaMemcpyHostToDevice);
    if(cudaStatus != cudaSuccess){
        cout << "cudaMemcpy failed!" << "\n";
        return 1;
    }

    SomaDeVetores<<<1,tamanhoDoVetor>>>(device_a, device_b, device_c);
    cudaDeviceSynchronize();

    cudaStatus = cudaMemcpy(host_c, device_c, size, cudaMemcpyDeviceToHost);
    if(cudaStatus != cudaSuccess){
        cout << "cudaMemcpy failed!" << "\n";
        return 1;
    }

    for(int i = 0; i< tamanhoDoVetor ; i++){
        cout << host_c[i]   << " ";
    }
    cout << "\n";





}