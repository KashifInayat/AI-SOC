module powercontrol_final(clk, reset, pwr_sig, pse, iso, ret, pse1, iso1, ret1);
  input clk;
  input reset;
  input pwr_sig;
  output reg pse;
  output reg iso;
  output reg ret;
  output reg pse1;
  output reg iso1;
  output reg ret1;
  //reg count_delay;

  always @(posedge clk)
begin 
      iso1 <= 1'b0;
      ret1 <= 1'b0;
      pse1 <= 1'b1;

   if (reset) begin
      iso <= 1'b0;
      ret <= 1'b0;
      pse <= 1'b1;      
     end else if (!reset) begin
	if (pwr_sig == 1) begin
	iso <= 1'b1;
        ret <= iso;
        pse <= !ret;
        end
        if (pwr_sig == 0) begin
       	pse <= 1'b1;
        ret <= !pse;
        iso <= ret;
        end
    end
end

endmodule


