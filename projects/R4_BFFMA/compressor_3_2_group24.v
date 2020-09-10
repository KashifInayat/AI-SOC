module compressor_3_2_group24 (in1, in2, in3, s, c);
  `include "parameters.v" 
  input [GRP_WIDTH-1:0] in1, in2, in3;
  output [GRP_WIDTH-1:0] s, c;
  

  genvar i;
generate
for (i=0;i<GRP_WIDTH; i=i+1) begin: CSAs_loop
  compressor_3_2 compress(in1[i], in2[i],in3[i], s[i], c[i]);
end
endgenerate
  //Test wire
  //wire [GRP_WIDTH-1:0] sum_in = s + c;
endmodule


