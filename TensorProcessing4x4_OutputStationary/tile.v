module Tile( 
  input         clock, 
  input  [7:0]  io_in_a_0, 
  input  [7:0] io_in_b_0, 
  input  [15:0] io_in_d_0, 
  input         io_in_control_0_propagate, 
  output [7:0]  io_out_a_0, 
  output [15:0] io_out_c_0, 
  output [7:0] io_out_b_0, 
  output        io_out_control_0_propagate
);
  wire  tile_0_0_clock; 
  wire [7:0] tile_0_0_io_in_a; 
  wire [7:0] tile_0_0_io_in_b;
  wire [15:0] tile_0_0_io_in_d;
  wire [7:0] tile_0_0_io_out_a;
  wire [7:0] tile_0_0_io_out_b; 
  wire [15:0] tile_0_0_io_out_c; 
  wire  tile_0_0_io_in_control_propagate; 
  wire  tile_0_0_io_out_control_propagate;

  PE_16 tile_0_0 ( 
    .clock(tile_0_0_clock),
    .io_in_a(tile_0_0_io_in_a),
    .io_in_b(tile_0_0_io_in_b),
    .io_in_d(tile_0_0_io_in_d),
    .io_out_a(tile_0_0_io_out_a),
    .io_out_b(tile_0_0_io_out_b),
    .io_out_c(tile_0_0_io_out_c),
    .io_in_control_propagate(tile_0_0_io_in_control_propagate),
    .io_out_control_propagate(tile_0_0_io_out_control_propagate)
  );
  
  assign io_out_a_0 = tile_0_0_io_out_a; 
  assign io_out_c_0 = tile_0_0_io_out_c; 
  assign io_out_b_0 = tile_0_0_io_out_b; 
  assign io_out_control_0_propagate = tile_0_0_io_out_control_propagate;
  assign tile_0_0_clock = clock;
  assign tile_0_0_io_in_a = io_in_a_0; 
  assign tile_0_0_io_in_b = io_in_b_0; 
  assign tile_0_0_io_in_d = io_in_d_0; 
  assign tile_0_0_io_in_control_propagate = io_in_control_0_propagate; 
 endmodule