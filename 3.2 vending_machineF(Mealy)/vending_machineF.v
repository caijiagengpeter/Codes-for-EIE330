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


parameter   IDLE     = 4'b0001;
parameter   HALF     = 4'b0010;
parameter   ONE      = 4'b0100;
parameter   ONE_HALF = 4'b1000;


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
                              state <= IDLE;
                          else
                              state <= ONE;
    
                ONE_HALF: if(pi_money == 2'b01)
                              state <= IDLE;
                          else    if(pi_money == 2'b10)
                              state <= IDLE;
                          else
                              state <= ONE_HALF;
        
        
                default :       state <= IDLE;
            endcase

always@(posedge sys_clk)
 if(state == ONE && pi_money == 2'b10) begin
		  PCola <= 1'b1;
		  change1 <= 1'b0;
		  end

else if(state == ONE_HALF && pi_money == 2'b01) begin
		  PCola <= 1'b1;
		  change1 <= 1'b0;
		end

else if(state == ONE_HALF && pi_money == 2'b10) begin
		  PCola <= 1'b1;
		  change1 <= 1'b1;
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
		  
    else
        PMoney <= 1'b0;

endmodule
