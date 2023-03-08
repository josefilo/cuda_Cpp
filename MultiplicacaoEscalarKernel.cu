#include "cuda_runtime.h"
#include "cuda.h"
#include <iostream>

using namespace std;

__global__ void MultiplicaPorEscalar(int *a, int *b, int n)
{
    int i = threadIdx.x;
    b[i] = a[i]*n;    
}

int main()
{
    cudaError_t CudaStatus;
    int *host_a, *host_b;
    int *device_a, *device_b;

    int arraySize = 256;

    int size = arraySize*sizeof(int);

    host_a = (int*)malloc(size);
    host_b = (int*)malloc(size);

    for(int i=0; i<arraySize; i++)
    {
        host_a[i] = i;
    }

    CudaStatus = cudaMalloc((void**)&device_a, size);
    if(CudaStatus != cudaSuccess)
    {
        cout << "cudaMalloc failed" << "\n";
        return 1;
    }

    CudaStatus = cudaMalloc((void**)&device_b, size);
    if(CudaStatus != cudaSuccess)
    {
        cout << "cudaMalloc failed" << "\n";
        return 1;
    }

    CudaStatus = cudaMemcpy(device_a, host_a, size, cudaMemcpyHostToDevice);
    if(CudaStatus != cudaSuccess)
    {
        cout << "cudaMalloc failed" << "\n";
        return 1;
    }

    MultiplicaPorEscalar<<<1, arraySize>>>(device_a, device_b, 3);
    cudaDeviceSynchronize();

    CudaStatus = cudaMemcpy(host_b, device_b, size, cudaMemcpyDeviceToHost);
    if(CudaStatus != cudaSuccess)
    {
        cout << "cudaMalloc failed" << "\n";
        return 1;
    }

    for(int i=0; i<arraySize; i++)
    {
        cout << host_b[i]<< " ";
    }
    cout << "\n";


}
