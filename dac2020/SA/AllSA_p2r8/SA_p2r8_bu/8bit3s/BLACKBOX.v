module PE_OS_16_R8( s, d, t, q, n, Y, TMY, CLK, RST, S_OUT, D_OUT, T_OUT, Q_OUT, N_OUT, Y_OUT, TMY_OUT, MAC_OUT );

parameter WIDTH=8;
`define GC (WIDTH>>2)+1
parameter group_cnt=(WIDTH>>2)+1; 

input [group_cnt - 1:0] s, d, t, q, n;
input   [WIDTH-1:0]  Y;
input   [WIDTH+1:0]  TMY;
input           CLK;
input           RST;
output [group_cnt - 1:0]S_OUT, D_OUT, T_OUT, Q_OUT, N_OUT;
output  [WIDTH-1:0]  Y_OUT;
output  [WIDTH+1:0]  TMY_OUT;
output [2*WIDTH-1:0]  MAC_OUT;

endmodule
