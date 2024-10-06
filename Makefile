all: simulate

simulate:
	iverilog -g2012 -o tpu_sim src/processing_element.v src/systolic_array.v src/tpu_testbench.v
	vvp tpu_sim
