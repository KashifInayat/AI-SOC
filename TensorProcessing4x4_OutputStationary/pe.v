module PE_16( 
  input         clock, 
  input  [7:0]  io_in_a, 
  input  [7:0] io_in_b, 
  input  [15:0] io_in_d, 
  output [7:0]  io_out_a,
  output [7:0] io_out_b, 
  output [15:0] io_out_c,
  input         io_in_control_propagate, 
  output        io_out_control_propagate 

);
 
  wire [7:0] _T_36;    
  wire [7:0] _T_37;    
  wire [15:0] _T_38;   
  wire [15:0] _T_39;   
  wire [15:0] _GEN_20; 
  wire [15:0] _T_40; 
  wire [15:0] _T_41; 
  wire [15:0] _T_78; 
  wire [15:0] _T_79; 
  wire [15:0] _GEN_1; 
  wire [15:0] _GEN_13; 
  wire  _T_99; 
  wire [18:0] _GEN_25; 
    
  assign _T_36 = io_in_b;  
  assign _T_37 = $signed(_T_36);
  assign _T_38 = $signed(_T_37) * $signed(io_in_a); 
  assign _GEN_20 = _T_38; 
  assign _T_40 = $signed(_GEN_20) + $signed(_T_39); 
  assign _T_41 = $signed(_T_40); 
  
  assign io_out_a = io_in_a; 											
  assign io_out_b = io_in_b; 											
 									
  assign io_out_control_propagate = io_in_control_propagate;			
									

double_buffer uutDB(.clock(clock),.io_in_control_propagate(io_in_control_propagate),.io_in_d(io_in_d),.io_in_c(_T_41),.c_fb(_T_39),.c_out(io_out_c)
    );



endmodule


module double_buffer(
input clock,
input io_in_control_propagate,//CTL_PROP
input [15:0]io_in_d,//D
input [15:0]io_in_c,//C
output [15:0] c_fb, //C_FB
output [15:0] c_out//C_OUT
    );
reg [15:0] c1_s; 
reg [15:0] _RAND_00;
reg [15:0] c2_s;
reg [15:0] _RAND_10;

//Initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_00 = {1{`RANDOM}};
  c1_s = _RAND_00[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_01 = {1{`RANDOM}};
   c2_s = _RAND_01[15:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end


always @(posedge clock) 
begin
 if (io_in_control_propagate)
	  begin
        c1_s <= io_in_d;
      end 
 else 
      begin
        c1_s <= io_in_c;
      end
if (!io_in_control_propagate) 
	  begin
        c2_s <= io_in_d;
      end 
 else 
	  begin
        c2_s <= io_in_c;
	  end
end

assign c_fb =io_in_control_propagate?c2_s:c1_s;
assign c_out=!io_in_control_propagate?c2_s:c1_s;
endmodule
