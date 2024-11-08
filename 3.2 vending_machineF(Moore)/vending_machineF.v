module  vending_machineF
(
    input   wire    sys_clk,   
    input   wire    sys_rst_n,   
    input   wire    pOne,   
    input   wire    pHalf,   
                    
    output  reg [3:0]    PMoney,   
    output  reg     change1,                      
    output  reg     PCola         
                                        
);


parameter   IDLE     = 5'b00001;
parameter   HALF     = 5'b00010;
parameter   ONE      = 5'b00100;
parameter   ONE_HALF = 5'b01000;
parameter   TWO	   = 5'b10000;

reg     [4:0]   state;

wire    [1:0]   pi_money;


assign pi_money = {pOne, pHalf};


always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        state <= IDLE;  //任何情况下只要按复位就回到初始状态
    else	case(state)
                IDLE    : if(pi_money == 2'b01)   //判断一种输入情况
                              state <= HALF;
                          else    if(pi_money == 2'b10)//判断另一种输入情况
                              state <= ONE;
                          else
                              state <= IDLE;
    
                HALF    : if(pi_money == 2'b01)
                              state <= ONE;
                          else    if(pi_money == 2'b10)
                              state <= ONE_HALF;
                          else
                              state <= HALF;
    
                ONE     : if(pi_money == 2'b01)
                              state <= ONE_HALF;
                          else    if(pi_money == 2'b10)
                              state <= TWO;
                          else
                              state <= ONE;
    
                ONE_HALF: if(pi_money == 2'b01)
                              state <= TWO;
                          else    if(pi_money == 2'b10)
                              state <= TWO;
                          else
                              state <= ONE_HALF;
        
                 TWO     : if((pi_money == 2'b01) || (pi_money == 2'b10))
                               state <= IDLE;
                           else
                               state <= TWO;
        
                default :       state <= IDLE;
            endcase

always@(posedge sys_clk)

 if(state == ONE_HALF && pi_money == 2'b01) begin
		  PCola <= 1'b0;
		  change1 <= 1'b0;
		end

else if(state == ONE_HALF && pi_money == 2'b10) begin
		  PCola <= 1'b0;
		  change1 <= 1'b1;
		end
		  
	else if(state == TWO) begin
		  PCola <= 1'b1;
		  change1 <= 1'b0;
		  end
	else begin
		  PCola <= 1'b0;
		  change1 <= 1'b0;
		  end
	

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n ==	1'b0)
        PMoney <= 1'b0;
    else if(state == HALF) 
        PMoney <= 4'b0001;
    else if(state == ONE) 
        PMoney <= 4'b0010;		  
    else if(state == ONE_HALF) 
        PMoney <= 4'b0100;
    else if(state == TWO) 
        PMoney <= 4'b1000;
		  
    else
        PMoney <= 1'b0;

endmodule
