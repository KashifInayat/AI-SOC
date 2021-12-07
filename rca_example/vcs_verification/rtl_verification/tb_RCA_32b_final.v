`timescale 1ns/ 1ps;
module testbench_rca_32b_final();
 reg [31:0] A;
 reg [31:0] B;
  reg cin_t,clk_t,reset_t,pwr_sig_t;
 wire [32:0] S;
 //Verilog code for the RCA32b adder 
 RCA_32b_final DUT(
    .clk(clk_t),
    .pwr_sig(pwr_sig_t),
    .reset(reset_t),
    .cin(cin_t),
    .a(A),
    .b(B),
    .s(S)
   );

integer seed=1;
initial
begin
clk_t={$random}%2;
reset_t=1'b0;
cin_t=1'b0;
pwr_sig_t=1'b0;
A={$random};
B={$random};
#2000 

$finish;

end
always #5 clk_t=~clk_t;
always #200 pwr_sig_t=~pwr_sig_t;
always #500 reset_t=~reset_t;
always #100 A=~A;
always #200 B=~B;
//display output if there is a change in the input event
//always @(*)
  //    $monitor("At TIME(in ns)=%t, clk_t=%d reset_t=%d Cin = %d S = %d Cout = %d", $time, clk_t, reset_t, A, B, Cin, S, Cout);
      
endmodule 