# Toy TPU Processor

### Overview

This project is a simplified version of a **Tensor Processing Unit (TPU)**, inspired by Google's TPU architecture. It uses a **2x2 systolic array** to perform matrix multiplication.

In this design, two matrices are multiplied: **Matrix A** (the weight matrix) and **Matrix B** (the data matrix). Data from Matrix A moves horizontally across the PEs, while data from Matrix B moves vertically. Each PE performs a **multiply-accumulate (MAC)** operation.

### Architectural Inspiration from Google’s TPU

Google’s TPU uses systolic arrays for matrix multiplication. My design takes the same idea, but on a smaller scale. Data flows locally between PEs, allowing for efficient processing with minimal control overhead.

### Key Components

1. **Processing Element (PE):** Each PE performs a MAC operation and passes data to neighboring PEs. It accumulates partial results until all data has been processed.
2. **Systolic Array:** The 2x2 array consists of interconnected PEs. Matrix A shifts across the rows, and Matrix B shifts down the columns. The design is scalable by adjusting a parameter.
3. **Data Flow:** Data enters the array over several clock cycles. Elements from Matrix A and Matrix B move through the PEs in stages—Matrix A shifts rightward, and Matrix B shifts downward—creating a wave-like pattern of computation as each PE processes and passes data along.

### Thought Process for the Architecture

The systolic array was chosen because it simplifies matrix multiplication by distributing the computation across parallel elements. Each PE only interacts with its neighboring PEs, making the design more efficient and easier to scale.

### What I Learned About Verilog

While working on this project, I learned how to handle **synchronous design** and how to use the clock signal to keep all the PEs in sync. This was important to make sure data moved through the systolic array correctly. I also had to figure out the difference between **blocking** (`=`) and **non-blocking assignments** (`<=`). Understanding when to use each one was key to avoiding bugs, especially in handling sequential logic across multiple clock cycles.

I also got a better understanding of **modularity** and **parameterization** in Verilog. By writing the PE as a reusable module and making the array size configurable, I was able to easily scale the design without rewriting everything. Finally, writing the **testbench** helped me learn how to simulate the array, feed it inputs, and verify the results.

### Running the Simulation

The testbench simulates the systolic array by feeding in two 2x2 matrices over several clock cycles and checking the output. You can adjust the size of the array by modifying the `N` parameter in the systolic array module to handle larger matrices.

To run the simulation, simply execute the following command:

```bash
make
```

This will compile the necessary files and run the testbench to simulate the TPU processor.
