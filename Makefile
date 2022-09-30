no_gpu:
	g++ add_main.cpp -o no_gpu

gpu:
	nvcc add.cu -o vector_add
