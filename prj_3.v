`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCUT
// Engineer: kayak4665664
// Module Name: prj_3
//////////////////////////////////////////////////////////////////////////////////

module prj_3(
    input [1:0] data,
    output even
    );
    assign even=^data;
endmodule