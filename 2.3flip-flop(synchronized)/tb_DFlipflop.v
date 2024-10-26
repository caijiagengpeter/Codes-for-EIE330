`timescale 1ns/1ns

module tb_DFlipflop();

reg sys_clk;
reg sys_rst;
reg key;

wire led1;

initial 
	begin
		sys_clk = 1'b1;
		sys_rst <= 1'b0;
		key <= 1'b0;// reset
		#20
		sys_rst <= 1'b1;//set
		#210
		sys_rst <= 1'b0;//reset
		#40
		sys_rst <= 1'b1;//set
		
	end
	
	always #10 sys_clk = ~sys_clk;
	
	always #20 key <= {$random} %2;
	
	DFlipflop caijiageng
	(
	 .sys_clk  	(sys_clk),
	 .sys_rst	(sys_rst),
	 .key			(key),
	
	 .led1		(led1)

);
	
endmodule
	