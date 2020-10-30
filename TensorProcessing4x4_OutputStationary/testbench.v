`timescale 1ns / 1ps
module testbench();

parameter WIDTH = 8;
parameter ht=1;
  reg CLK;
  reg  [7:0]  mesh_io_in_a_0_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  reg  [7:0]  mesh_io_in_a_1_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  reg  [7:0]  mesh_io_in_a_2_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  reg  [7:0]  mesh_io_in_a_3_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  
  reg  [7:0]  mesh_io_in_d_0_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  reg  [7:0]  mesh_io_in_d_1_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  reg  [7:0]  mesh_io_in_d_2_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  reg  [7:0]  mesh_io_in_d_3_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  
  reg  [15:0] mesh_io_in_b_0_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  reg  [15:0] mesh_io_in_b_1_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  reg  [15:0] mesh_io_in_b_2_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  reg  [15:0] mesh_io_in_b_3_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  
  reg         mesh_io_in_control_0_0_propagate; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  reg         mesh_io_in_control_1_0_propagate; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  reg         mesh_io_in_control_2_0_propagate; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  reg         mesh_io_in_control_3_0_propagate; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4] 

 
  wire [15:0] mesh_io_out_c_0_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  wire [15:0] mesh_io_out_c_1_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  wire [15:0] mesh_io_out_c_2_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]
  wire [15:0] mesh_io_out_c_3_0; // @[:example.TestHarness.GemminiSocTest1RocketConfig.fir@177054.4]


 Mesh mesh ( 
    .clock(CLK),
    .io_in_a_0_0(mesh_io_in_a_0_0),
    .io_in_a_1_0(mesh_io_in_a_1_0),
    .io_in_a_2_0(mesh_io_in_a_2_0),
    .io_in_a_3_0(mesh_io_in_a_3_0),
    
    .io_in_d_0_0(mesh_io_in_d_0_0),
    .io_in_d_1_0(mesh_io_in_d_1_0),
    .io_in_d_2_0(mesh_io_in_d_2_0),
    .io_in_d_3_0(mesh_io_in_d_3_0),
    
    .io_in_b_0_0(mesh_io_in_b_0_0),
    .io_in_b_1_0(mesh_io_in_b_1_0),
    .io_in_b_2_0(mesh_io_in_b_2_0),
    .io_in_b_3_0(mesh_io_in_b_3_0),
    
    .io_in_control_0_0_propagate(mesh_io_in_control_0_0_propagate),
    .io_in_control_1_0_propagate(mesh_io_in_control_1_0_propagate),
	.io_in_control_2_0_propagate(mesh_io_in_control_2_0_propagate),
    .io_in_control_3_0_propagate(mesh_io_in_control_3_0_propagate),
    
    .io_out_c_0_0(mesh_io_out_c_0_0),
    .io_out_c_1_0(mesh_io_out_c_1_0),
    .io_out_c_2_0(mesh_io_out_c_2_0),
    .io_out_c_3_0(mesh_io_out_c_3_0)

  );


initial begin

CLK=1'b0;
mesh_io_in_a_0_0 = 0;
mesh_io_in_a_1_0 = 0;
mesh_io_in_a_2_0 = 0;
mesh_io_in_a_3_0 = 0;
mesh_io_in_d_0_0 = 0;
mesh_io_in_d_1_0 = 0;
mesh_io_in_d_2_0 = 0;
mesh_io_in_d_3_0 = 0;

mesh_io_in_b_0_0 = 0;
mesh_io_in_b_1_0 = 0;
mesh_io_in_b_2_0 = 0;
mesh_io_in_b_3_0 = 0;

mesh_io_in_control_0_0_propagate= 0;
mesh_io_in_control_1_0_propagate= 0;
mesh_io_in_control_2_0_propagate= 0;
mesh_io_in_control_3_0_propagate= 0;
#10;
mesh_io_in_control_0_0_propagate= 1;
mesh_io_in_control_1_0_propagate= 1;
mesh_io_in_control_2_0_propagate= 1;
mesh_io_in_control_3_0_propagate= 1;
#10;
mesh_io_in_control_0_0_propagate= 0;
mesh_io_in_control_1_0_propagate= 0;
mesh_io_in_control_2_0_propagate= 0;
mesh_io_in_control_3_0_propagate= 0;
end

initial begin
/*Note:
Mesh input B connected PE input D. Therefore, in mesh B is 16 bits.
Mesh input D connected PE input B. Therefore, in mesh D is 8 bits.
So will give inputs to A and D, B will be zero as there is no PE's above first row of PE's.
*/
#20;
//Input of two Matrix multiplication
@(posedge CLK)
/* A0 */mesh_io_in_a_0_0 =2;/* B0 */ mesh_io_in_d_0_0 =3;
/* A1 */mesh_io_in_a_1_0 =0;/* B1 */ mesh_io_in_d_1_0 =0;
/* A2 */mesh_io_in_a_2_0 =0;/* B2 */ mesh_io_in_d_2_0 =0;
/* A3 */mesh_io_in_a_3_0 =0;/* B3 */ mesh_io_in_d_3_0 =0;
@(posedge CLK)
/* A0 */mesh_io_in_a_0_0 =3;/* B0 */mesh_io_in_d_0_0 =2;
/* A1 */mesh_io_in_a_1_0 =1;/* B1 */mesh_io_in_d_1_0 =0;
/* A2 */mesh_io_in_a_2_0 =0;/* B2 */mesh_io_in_d_2_0 =0;
/* A3 */mesh_io_in_a_3_0 =0;/* B3 */mesh_io_in_d_3_0 =0;
@(posedge CLK)
/* A0 */mesh_io_in_a_0_0 =4;/* B0 */mesh_io_in_d_0_0 =1;
/* A1 */mesh_io_in_a_1_0 =3;/* B1 */mesh_io_in_d_1_0 =3;
/* A2 */mesh_io_in_a_2_0 =2;/* B2 */mesh_io_in_d_2_0 =2;
/* A3 */mesh_io_in_a_3_0 =0;/* B3 */mesh_io_in_d_3_0 =0;
@(posedge CLK)
/* A0 */mesh_io_in_a_0_0 =1;/* B0 */mesh_io_in_d_0_0 =4;
/* A1 */mesh_io_in_a_1_0 =0;/* B1 */mesh_io_in_d_1_0 =0;
/* A2 */mesh_io_in_a_2_0 =4;/* B2 */mesh_io_in_d_2_0 =4;
/* A3 */mesh_io_in_a_3_0 =3;/* B3 */mesh_io_in_d_3_0 =3;
@(posedge CLK)
//Frist Column completed the computation for resultant matrix, so CTL_PROP0=1, to take ouput
//Moreover, we will start giving Second matrix from here 
mesh_io_in_control_0_0_propagate= 1;
/* A0 */mesh_io_in_a_0_0 =5;/* B0 */mesh_io_in_d_0_0 =3;
/* A1 */mesh_io_in_a_1_0 =2;/* B1 */mesh_io_in_d_1_0 =2;
/* A2 */mesh_io_in_a_2_0 =3;/* B2 */mesh_io_in_d_2_0 =3;
/* A3 */mesh_io_in_a_3_0 =1;/* B3 */mesh_io_in_d_3_0 =1;
//Second Column completed the computation for resultant matrix, so CTL_PROP1=1, to take ouput
@(posedge CLK)
mesh_io_in_control_1_0_propagate= 1;
/* A0 */mesh_io_in_a_0_0 =4;/* B0 */mesh_io_in_d_0_0 =2;
/* A1 */mesh_io_in_a_1_0 =3;/* B1 */mesh_io_in_d_1_0 =2;
/* A2 */mesh_io_in_a_2_0 =1;/* B2 */mesh_io_in_d_2_0 =1;
/* A3 */mesh_io_in_a_3_0 =2;/* B3 */mesh_io_in_d_3_0 =2;
//Third Column completed the computation for resultant matrix, so CTL_PROP2=1, to take ouput
@(posedge CLK)
mesh_io_in_control_2_0_propagate= 1;
/* A0 */mesh_io_in_a_0_0 =4;/* B0 */mesh_io_in_d_0_0 =2;
/* A1 */mesh_io_in_a_1_0 =3;/* B1 */mesh_io_in_d_1_0 =3;
/* A2 */mesh_io_in_a_2_0 =4;/* B2 */mesh_io_in_d_2_0 =5;
/* A3 */mesh_io_in_a_3_0 =4;/* B3 */mesh_io_in_d_3_0 =0;
//Fourth Column completed the computation for resultant matrix, so CTL_PROP3=1, to take ouput
@(posedge CLK)
mesh_io_in_control_3_0_propagate= 1;
/* A0 */mesh_io_in_a_0_0 =3;/* B0 */mesh_io_in_d_0_0 =3;
/* A1 */mesh_io_in_a_1_0 =4;/* B1 */mesh_io_in_d_1_0 =4;
/* A2 */mesh_io_in_a_2_0 =6;/* B2 */mesh_io_in_d_2_0 =6;
/* A3 */mesh_io_in_a_3_0 =1;/* B3 */mesh_io_in_d_3_0 =4;
@(posedge CLK)
mesh_io_in_control_0_0_propagate= 0;
/* A0 */mesh_io_in_a_0_0 =0;/* B0 */mesh_io_in_d_0_0 =0;
/* A1 */mesh_io_in_a_1_0 =1;/* B1 */mesh_io_in_d_1_0 =1;
/* A2 */mesh_io_in_a_2_0 =6;/* B2 */mesh_io_in_d_2_0 =7;
/* A3 */mesh_io_in_a_3_0 =2;/* B3 */mesh_io_in_d_3_0 =2;
@(posedge CLK)
mesh_io_in_control_1_0_propagate= 0;
/* A0 */mesh_io_in_a_0_0 =0;/* B0 */mesh_io_in_d_0_0 =0;
/* A1 */mesh_io_in_a_1_0 =0;/* B1 */mesh_io_in_d_1_0 =0;
/* A2 */mesh_io_in_a_2_0 =3;/* B2 */mesh_io_in_d_2_0 =2;
/* A3 */mesh_io_in_a_3_0 =5;/* B3 */mesh_io_in_d_3_0 =8;
@(posedge CLK)
mesh_io_in_control_2_0_propagate= 0;
/* A0 */mesh_io_in_a_0_0 =0;/* B0 */mesh_io_in_d_0_0 =0;
/* A1 */mesh_io_in_a_1_0 =0;/* B1 */mesh_io_in_d_1_0 =0;
/* A2 */mesh_io_in_a_2_0 =0;/* B2 */mesh_io_in_d_2_0 =0;
/* A3 */mesh_io_in_a_3_0 =4;/* B3 */mesh_io_in_d_3_0 =9;
@(posedge CLK)
mesh_io_in_control_3_0_propagate= 0;
/* A0 */mesh_io_in_a_0_0 =0;/* B0 */mesh_io_in_d_0_0 =0;
/* A1 */mesh_io_in_a_1_0 =0;/* B1 */mesh_io_in_d_1_0 =0;
/* A2 */mesh_io_in_a_2_0 =0;/* B2 */mesh_io_in_d_2_0 =0;
/* A3 */mesh_io_in_a_3_0 =0;/* B3 */mesh_io_in_d_3_0 =0;
//Just repeated clock for 50 cycles
repeat (50)@(posedge CLK);
end
    
 
 
always @(CLK)
#(ht) CLK<=~CLK;
 
endmodule
