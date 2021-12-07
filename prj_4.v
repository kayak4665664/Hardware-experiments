`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCUT
// Engineer: kayak4665664
// Module Name: prj_4
//////////////////////////////////////////////////////////////////////////////////

module prj_4(
    input K0,
    input [7:0] Ks,
    input RST,
    output L1,
    output L2,
    output L3,
    output L4,
    output L5,
    output L6,
    output L7,
    output L8,
    output [7:0] NUM
    );
    parameter S0=3'b001,S1=3'b010,S2=3'b100;//状态独热编码
    reg [2:0] crnt;//当前状态
    reg [6:0] num;
    assign NUM={num[6:0],1'b0};//数码管显示的数字
    reg [2:0] cnt;
    reg [3:0] pos;
    reg [7:0] flags;
    assign L8=flags[7],L7=flags[6],L6=flags[5],L5=flags[4],L4=flags[3],L3=flags[2],L2=flags[1],L1=flags[0];//二极管
    always @(RST)begin
        if(RST)begin
            if(!pos)begin
                for(pos=0;pos<=7;pos=pos+1)begin//状态机
                    case(crnt)
                        S0:crnt=Ks[pos]?S1:S0;
                        S1:crnt=!Ks[pos]?S2:S1;
                        S2:begin
                            if(Ks[pos])begin
                                if(!K0) crnt=S1;//带重复
                                else crnt=S0;//不带重复
                                flags[pos]=1;
                                cnt=cnt+1;
                            end
                            else crnt=S0;
                        end
                        default:crnt=S0;
                    endcase
                end
            end
        end
        else begin//RST
            pos=0;
            cnt=0;
            flags=0;
            crnt=S0;
        end
    end
    always @(cnt)begin//数码管显示结果
        case(cnt)
            0:num=7'b1111110;//0
            1:num=7'b0110000;//1
            2:num=7'b1101101;//2
            3:num=7'b1111001;//3
            4:num=7'b0110011;//4
            5:num=7'b1011011;//5
            6:num=7'b1011111;//6
            default:num=7'b0000000;
        endcase
    end
endmodule