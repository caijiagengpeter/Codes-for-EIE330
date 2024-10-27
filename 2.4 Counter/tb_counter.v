`timescale  1ns/1ns
module  tb_counter();

wire    led1;

reg     sys_clk;
reg     sys_rst_n;

initial begin
    sys_clk    = 1'b1;
    sys_rst_n <= 1'b0;
    #20
    sys_rst_n <= 1'b1;
end

always #10 sys_clk = ~sys_clk;


counter
#(
    .CNT_MAX    (25'd24)   
)
counter_inst
(
    .sys_clk    (sys_clk),  
    .sys_rst_n  (sys_rst_n),  

    .led1   	 (led1)   
);

endmodule
