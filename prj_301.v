`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCUT
// Engineer: kayak4665664
// Module Name: prj_300
//////////////////////////////////////////////////////////////////////////////////


module prj_301(
	input in0,
	input in1,
	output [1:0] out0
	);
	assign out0={in0,in1};
endmodule
