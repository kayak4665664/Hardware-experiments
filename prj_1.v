`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCUT
// Engineer: kayak4665664
// Module Name: prj_1
//////////////////////////////////////////////////////////////////////////////////

module prj_1(
    input clk,
    output [3:0] dig,
    output [7:0] number
    );
    reg clkout;
    integer cnt;
    reg [2:0] scan_cnt;
    parameter period=50;//用于控制扫描频率的常量
    reg [6:0] num;
    reg [3:0] d;
    assign number={num[6:0],1'b0};//数字
    assign dig=~d;//片选
    always @(posedge clk)begin//产生扫描频率
        cnt<=cnt+1;
        if(cnt==(period>>1)-1) clkout<=#1 1'b1;
        else if(cnt==period-1)begin
                clkout<=#1 1'b0;
                cnt<=#1 1'b0;
            end
    end
    always @(posedge clkout)begin
        scan_cnt<=scan_cnt+1;
        if(scan_cnt==2'd2) scan_cnt<=0;
    end
    always @(scan_cnt)begin//片选
        case(scan_cnt)
            0:d<=3'b001;
            1:d<=3'b010;
            2:d<=3'b100;
            default:d<=3'b000;
        endcase
    end
    always @(scan_cnt)begin//显示数字
        case(scan_cnt)
            0:num=7'b0110000;//1
            1:num=7'b1111110;//0
            2:num=7'b1011111;//6
            default:num=7'b0000000;
        endcase
    end
endmodule