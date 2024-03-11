`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  LI;
   logic  RI;
   logic  reset;
   
   logic  [5:0] y;
   
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   FSM dut (clk, reset, LI, RI, y);   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("fsm.out");
	// Tells when to finish simulation
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#5 $fdisplay(desc3, "%b %b %b|| %b", 
		     reset, LI, RI, y);
     end   
   
   initial 
     begin      
	#0   reset = 1'b1;
	#1  reset = 1'b0;	

	#20   LI = 1'b0;
     #0   RI = 1'b0;

	#20  LI = 1'b1;
	#0  RI = 1'b0;

	#20  LI = 1'b0;
     #0  RI = 1'b1;

	#20  LI = 1'b1;
     #0  RI = 1'b1;
     end

endmodule // FSM_tb

