# Pipelined-Ripple-Carry-Adders
Created the below components for a 24-bit Ripple Carry Adder :
RCA_2B,  RCA_ 4B, RCA _6B, and RCA _8B
Using only the full adder logic equations:

Designed two parametrized registers: RCA_REG_BLOCK and RCA_REG_LASTBLOCK. Inserted the registers between the components to create the following pipelined Ripple Carry Adders

Architecture #1: RCA_2B:
Inserted the registers to create a 12-stage pipelined core

Architecture #2: RCA_4B
Inserted the registers to create a 6-stage pipelined core

Architecture #3: RCA_6B
Inserted the registers to create a 4-stage pipelined core

Architecture #4: RCA_8B
Inserted the registers to create a 3-stage pipelined core

 
Use Matlab to create input/output test vector files for all designs.
Created a testbench, and test your design using your Matlab test-vector files.
Created  .DO files for the simulation, properly sorting signals.
Created a schematic for each configuration using the DataFlow feature in ModelSim

 

Used Xilinx Design Suite V 14.7 and synthesize using a Virtex 4, LX100, Package FF1148, Speed Grade -12.
Tabulated the max operating frequency, Slice, LUTs, Flip Flops, %logic and % route of: 
Your original combinational Adder
Your 2-stage pipelined Adder
Your 4-stage pipelined Adder
Your 6-stage pipelined Adder
Your 12-stage pipelined Adder

RTL and technology schematics for each design provided
