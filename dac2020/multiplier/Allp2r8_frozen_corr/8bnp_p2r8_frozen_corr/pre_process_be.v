module pre_process_be #(parameter WIDTH = 8)(mx, s, d, t, q, n);
    
parameter group_cnt=(WIDTH>>2)+1;

input [WIDTH-1:0] mx;

output wire [group_cnt - 1:0]s;
output wire [group_cnt - 1:0]d;
output wire [group_cnt - 1:0]t;
output wire [group_cnt - 1:0]q;
output wire [group_cnt - 1:0]n;




			booth_encoder b_e0(.x({mx[2], mx[1], mx[0], 1'b0}), .single(s[0]), .double(d[0]), .triple(t[0]), .quad(q[0]), .neg(n[0]));
			booth_encoder b_e1(.x({mx[5],mx[4], mx[3], mx[2]}), .single(s[1]), .double(d[1]), .triple(t[1]), .quad(q[1]), .neg(n[1]));
			booth_encoder b_e2(.x({1'b0, mx[WIDTH - 1:WIDTH-3]}), .single(s[2]), .double(d[2]), .triple(t[2]), .quad(q[2]), .neg(n[2]));
			

endmodule

/******************** Booth Encoder ********************/
module booth_encoder (x, single, double, triple, quad, neg);

input [3:0]x;

output single;

output  double;

output triple;

output  quad;

output neg;

wire w0;

wire w1;

wire w2;

wire w3;

wire w4;

wire w5;

assign neg=x[3];

assign w0=x[0]^x[1];

assign w1=x[1]^x[2];

assign w2=x[2]^x[3];

assign single=~((~w0)|w2);

assign double=~((~w1)|w0);

assign triple=~((~w2)|(~w0));

assign quad=~((~w2)|(w0|w1));

endmodule
