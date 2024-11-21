`timescale  1ns/1ns
////////////////////////////////////////////////////////////////////////
// Author        : EmbedFire
// Create Date   : 2019/03/12
// Module Name   : vga_pic
// Project Name  : vga_char
// Target Devices: Altera EP4CE10F17C8N
// Tool Versions : Quartus 13.0
// Description   : 图像数据生成模块
// 
// Revision      : V1.0
// Additional Comments:
// 
// 实验平台: 野火_征途Pro_FPGA开发板
// 公司    : http://www.embedfire.com
// 论坛    : http://www.firebbs.cn
// 淘宝    : https://fire-stm32.taobao.com
////////////////////////////////////////////////////////////////////////

module  vga_pic
(
    input   wire            vga_clk     ,   //输入工作时钟,频率25MHz
    input   wire            sys_rst_n   ,   //输入复位信号,低电平有效
    input   wire    [9:0]   pix_x       ,   //输入有效显示区域像素点X轴坐标
    input   wire    [9:0]   pix_y       ,   //输入有效显示区域像素点Y轴坐标

    output  reg     [15:0]  pix_data        //输出像素点色彩信息
);

//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//
//parameter define
parameter   CHAR_B_H=   10'd192 ,   //字符开始X轴坐标
            CHAR_B_V=   10'd208 ;   //字符开始Y轴坐标

parameter   CHAR_W  =   10'd256 ,   //字符宽度
            CHAR_H  =   10'd64  ;   //字符高度

parameter   BLACK   =   16'h0000,   //黑色
            WHITE   =   16'hFFFF,   //白色
            GOLDEN  =   16'hFEC0;   //金色

//wire  define
wire    [9:0]   char_x  ;   //字符显示X轴坐标
wire    [9:0]   char_y  ;   //字符显示Y轴坐标

//reg   define
reg     [255:0] char    [63:0]  ;   //字符数据

//********************************************************************//
//***************************** Main Code ****************************//
//********************************************************************//

//字符显示坐标
assign  char_x  =   (((pix_x >= CHAR_B_H) && (pix_x < (CHAR_B_H + CHAR_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_x - CHAR_B_H) : 10'h3FF;
assign  char_y  =   (((pix_x >= CHAR_B_H) && (pix_x < (CHAR_B_H + CHAR_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_y - CHAR_B_V) : 10'h3FF;

//char:字符数据
always@(posedge vga_clk)
    begin
        char[0]     <=  256'h   ;
        char[1]     <=  256'h   ;
        char[2]     <=  256'h   ;
        char[3]     <=  256'h   ;
        char[4]     <=  256'h   ;
        char[5]     <=  256'h   ;
        char[6]     <=  256'h   ;
        char[7]     <=  256'h   ;
        char[8]     <=  256'h   ;
        char[9]     <=  256'h   ;
        char[10]    <=  256'h   ;
        char[11]    <=  256'h   ;
        char[12]    <=  256'h   ;
        char[13]    <=  256'h   ;
        char[14]    <=  256'h   ;
        char[15]    <=  256'h   ;
        char[16]    <=  256'h   ;
        char[17]    <=  256'h   ;
        char[18]    <=  256'h   ;
        char[19]    <=  256'h   ;
        char[20]    <=  256'h   ;
        char[21]    <=  256'h   ;
        char[22]    <=  256'h   ;
        char[23]    <=  256'h   ;
        char[24]    <=  256'h   ;
        char[25]    <=  256'h   ;
        char[26]    <=  256'h   ;
        char[27]    <=  256'h   ;
        char[28]    <=  256'h   ;
        char[29]    <=  256'h   ;
        char[30]    <=  256'h   ;
        char[31]    <=  256'h   ;
        char[32]    <=  256'h   ;
        char[33]    <=  256'h   ;
        char[34]    <=  256'h   ;
        char[35]    <=  256'h   ;
        char[36]    <=  256'h   ;
        char[37]    <=  256'h   ;
        char[38]    <=  256'h   ;
        char[39]    <=  256'h   ;
        char[40]    <=  256'h   ;
        char[41]    <=  256'h   ;
        char[42]    <=  256'h   ;
        char[43]    <=  256'h   ;
        char[44]    <=  256'h   ;
        char[45]    <=  256'h   ;
        char[46]    <=  256'h   ;
        char[47]    <=  256'h   ;
        char[48]    <=  256'h   ;
        char[49]    <=  256'h   ;
        char[50]    <=  256'h   ;
        char[51]    <=  256'h   ;
        char[52]    <=  256'h   ;
        char[53]    <=  256'h   ;
        char[54]    <=  256'h   ;
        char[55]    <=  256'h   ;
        char[56]    <=  256'h   ;
        char[57]    <=  256'h   ;
        char[58]    <=  256'h   ;
        char[59]    <=  256'h   ;
        char[60]    <=  256'h   ;
        char[61]    <=  256'h   ;
        char[62]    <=  256'h   ;
        char[63]    <=  256'h   ;
    end

//pix_data:输出像素点色彩信息,根据当前像素点坐标指定当前像素点颜色数据
always@(posedge vga_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pix_data    <= BLACK;
    else    if((((pix_x >= (CHAR_B_H - 1'b1))
                && (pix_x < (CHAR_B_H + CHAR_W -1'b1)))
                && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                && (char[char_y][10'd255 - char_x] == 1'b1))
        pix_data    <=  GOLDEN;
    else
        pix_data    <=  BLACK;

endmodule
