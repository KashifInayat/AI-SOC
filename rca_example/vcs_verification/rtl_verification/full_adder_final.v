module full_adder_final(clk, reset, a, b, cin, s, cout);
  input clk;
  input reset;
  input a;
  input b;
  input cin;
  output reg s;
  output reg cout;

  always @(posedge clk)
begin 
   if (reset)
	begin 
	s <= 1'b0;
	cout <= 1'b0; 
        end      
    else begin
	cout <= (a & b) | (a & cin) | (b & cin);
	s <= a ^ b ^ cin;
    	 end
  end
endmodule


