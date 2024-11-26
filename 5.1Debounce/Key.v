module Key (
    input clk,     
    input rst_n,   
    input key_in,  
    output reg key_out  
);

reg [19:0] counter;  
reg key_in_reg;  

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter <= 0;
        key_out <= 0;
        key_in_reg <= 0;
    end else begin
        key_in_reg <= key_in;  
        if (key_in_reg != key_in) begin
            counter <= 0;  
        end else if (counter == 1000000) begin  // 20ms，clk = 50MHz
            key_out <= key_in; 
        end else begin
            counter <= counter + 1;  
        end
    end
end

endmodule
