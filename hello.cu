/*
hello.cu is a cuda file
.cu for cuda
*/

#include <iostream>
#include <vector>

__global__ void hello(){
    printf("I am so cool! I can code GPU! \n");
}


int main(){
    hello<<<1,1>>>();
    cudaDeviceSynchronize();
    return 0;
}