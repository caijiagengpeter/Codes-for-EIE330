module  vending_machineNF
(
    input   wire    sys_clk,   
    input   wire    sysRstN,   
    input   wire    piOne,   
    input   wire    piHalf,   
                   
    output  reg     OCola,
	 output  reg    change1
);


parameter   IDLE     = 4'b0001;
parameter   HALF     = 4'b0010;
parameter   ONE      = 4'b0100;
parameter   ONE_HALF = 4'b1000;

reg     [4:0]   state;
wire    [1:0]   piMoney;

assign piMoney = {piOne, piHalf};


always@(posedge sys_clk or negedge sysRstN)
    if(sysRstN == 1'b0)
        state <= IDLE;  
    else	case(state)
                IDLE    : if(piMoney == 2'b01)   
                              state <= HALF;
                          else    if(piMoney == 2'b10)
                              state <= ONE;
                          else
                              state <= IDLE;
    
                HALF    : if(piMoney == 2'b01)
                              state <= ONE;
                          else    if(piMoney == 2'b10)
                              state <= ONE_HALF;
                          else
                              state <= HALF;
    
                ONE     : if(piMoney == 2'b01)
                              state <= ONE_HALF;
                          else    if(piMoney == 2'b10)
                              state <= IDLE;
                          else
                              state <= ONE;
    
                ONE_HALF: if(piMoney == 2'b01)
                              state <= IDLE;
                          else    if(piMoney == 2'b10)
                              state <= IDLE;
                          else
                              state <= ONE_HALF;
    
        
                default :       state <= IDLE;
            endcase

always@(posedge sys_clk)

 if(state == ONE && piMoney == 2'b10) begin
		  OCola <= 1'b1;
		  change1 <= 1'b0;
		end

else if(state == ONE_HALF && piMoney == 2'b10) begin
		  OCola <= 1'b1;
		  change1 <= 1'b1;
		end
		  
	else if(state == ONE_HALF && piMoney == 2'b01) begin
		  OCola <= 1'b1;
		  change1 <= 1'b0;
		  end

    else begin
        OCola <= 1'b0;
		  change1 <= 1'b0;

		 end
endmodule