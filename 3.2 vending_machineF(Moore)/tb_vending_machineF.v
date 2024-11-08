`timescale  1ns/1ns
module  tb_vending_machineF();
reg         sys_clk;
reg         sys_rst_n;
reg         pOne;
reg         pHalf;
reg         random_data_gen;
wire        PCola;
wire        PMoney;
initial begin
    sys_clk    = 1'b1;
    sys_rst_n <= 1'b0;
    #20
    sys_rst_n <= 1'b1;
end
always  #10 sys_clk = ~sys_clk;
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        random_data_gen <= 1'b0;
    else
        random_data_gen <= {$random} % 2;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pOne <= 1'b0;
    else
        pOne <= random_data_gen;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pHalf <= 1'b0;
    else
        pHalf <= ~random_data_gen;
		  
wire    [4:0]   state    = caijiageng.state;
wire    [1:0]   pi_money = caijiageng.pi_money;

vending_machineF caijiageng(
    .sys_clk         (sys_clk),  
    .sys_rst_n       (sys_rst_n),  
    .pOne   			(pOne   ),  
    .pHalf  			(pHalf  ),     
    .PCola        	(PCola), 
    .PMoney       	(PMoney) 
);  

endmodule