#include <iostream>

#define N 10000

__global__ void vector_add(float *out, float *a, float *b, int n) {
    for(int i = 0; i < n; i++){
        out[i] = a[i] + b[i];
    }
}

int main(){
    float *a, *b, *out;
    float *d_a, *d_b, *d_out; 

    // Allocate memory on host
    a   = (float*)malloc(sizeof(float) * N);
    b   = (float*)malloc(sizeof(float) * N);
    out = (float*)malloc(sizeof(float) * N);

    // Initialize array on host
    for(int i = 0; i < N; i++){
        a[i] = 1.0f; b[i] = 2.0f;
    }
    

    //allocate device memory
    cudaMalloc((void**)&d_a, sizeof(float)*N);
    cudaMalloc((void**)&d_b, sizeof(float)*N);
    cudaMalloc((void**)&d_out, sizeof(float)*N);

    //transfer arrays a and b from host to device
    cudaMemcpy(d_a, a, sizeof(float)*N, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, sizeof(float)*N, cudaMemcpyHostToDevice);

    // Main function
    vector_add<<<1,1>>>(d_out, d_a, d_b, N);
    
    //transfer out data from device to host
    cudaMemcpy(out, d_out, sizeof(float)*N, cudaMemcpyDeviceToHost);

    for (int i = 0; i < N; i++){
        printf("here's out[i]: %f \n", (out[i]));
    }

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_out);

    free(a);
    free(b);
    free(out);
}