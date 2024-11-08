`timescale  1ns/1ns
module  tb_vending_machineNF();

reg         sys_clk;
reg         sysRstN;
reg         piOne;
reg         piHalf;
reg         random_data_gen;

wire        OCola;

initial begin
    sys_clk    = 1'b1;
    sysRstN <= 1'b0;
    #20
    sysRstN <= 1'b1;
end

always  #10 sys_clk = ~sys_clk;

always@(posedge sys_clk or negedge sysRstN)
    if(sysRstN == 1'b0)
        random_data_gen <= 1'b0;
    else
        random_data_gen <= {$random} % 2;

always@(posedge sys_clk or negedge sysRstN)
    if(sysRstN == 1'b0)
        piOne <= 1'b0;
    else
        piHalf <= random_data_gen;

always@(posedge sys_clk or negedge sysRstN)
    if(sysRstN == 1'b0)
        piHalf <= 1'b0;
    else
        piHalf <= ~random_data_gen;


wire    [3:0]   state    = caijiageng.state;

vending_machineNF caijiageng(
    .sys_clk        (sys_clk ),  
    .sysRstN      (sysRstN),  
    .piOne   (piOne), 
    .piHalf  (piHalf),  
                    
    .OCola        (OCola)
);  

endmodule