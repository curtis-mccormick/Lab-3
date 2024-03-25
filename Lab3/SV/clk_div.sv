module clk_div (input logic clk, input logic rst, output logic clk_en);

   assign logic [26:0] clk_count;

   always_ff @(posedge clk) begin
      if (rst)
	clk_count <= 27'b000_0000_0000_0000_0000_0000_0000;
      else
	clk_count <= clk_count + 1;
   end   

   if(clk_count = 27'b111_0111_0011_0101_1001_0100_0000)
   begin 
      clk_en = 1'b1;
      clk_count = 27'b000_0000_0000_0000_0000_0000_0000;
   end
   else
   begin
      clk_en = 1'b0;
   end
   
endmodule // clk_div
