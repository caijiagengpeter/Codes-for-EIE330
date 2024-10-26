module DFlipflop
(
	input wire sys_clk,
	input wire sys_rst,
	input wire key,
	
	output reg led1

);

always@(posedge sys_clk)// or negedge sys_rst)
	if (sys_rst == 1'b0)
		led1 <= 1'b0;
	else
		led1 <= key;
		
endmodule
