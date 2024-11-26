`timescale 1ns/1ns

reg clk;            
reg rst_n;          
reg key_in;         
wire key_out;       

Key CaiJiaGeng (
    .clk(clk),
    .rst_n(rst_n),
    .key_in(key_in),
    .key_out(key_out)
);


initial begin
    clk = 0;
    forever #10 clk = ~clk;  
end

initial begin
    rst_n = 0;
    key_in = 0;

    #100;
    rst_n = 1;
    
    #200000; key_in = 1;  
    #100000; key_in = 0;  
    #100000; key_in = 1;  
    #100000; key_in = 0;  
    
    #200000;

end

endmodule
