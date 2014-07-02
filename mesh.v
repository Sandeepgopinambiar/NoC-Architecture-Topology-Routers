`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:51:45 09/06/2013 
// Design Name: 
// Module Name:    mesh 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mesh(clk, rst, flit_in_e, flit_in_w, flit_in_n, flit_in_s, flit_in_pe, flit_in_down, flit_in_up,
						req_in_e, req_in_w, req_in_s, req_in_n, req_in_pe, req_in_up, req_in_down,
						do_e, do_w, do_n, do_s, do_pe, do_up, do_down,						
						grantfe, grantfw, grantfn, grantfs, grantfl, grantfup, grantfdown,en,req_out_e, //reqs in frm adjcent routr..
req_out_w,
req_out_s,
req_out_n,

req_out_up,
req_out_down,
grnt_in_e,//acknldge signal coming from  adjcent router
grnt_in_w,
grnt_in_n,
grnt_in_s,
grnt_in_pe,	
grnt_in_up,
grnt_in_down
    );

/*module mesh( clk, rst, flit_in_pe, req_in_pe,
					do_e, do_w, do_n, do_s, do_pe, do_up, do_down,						
						grantfe, grantfw, grantfn, grantfs, grantfl, grantfup, grantfdown
				);*/

parameter IDLE=001;
parameter RCU=010;
parameter SA =100;
parameter FW= 40;
input clk,rst,en;
//io dec for router1
input req_in_e,req_in_w,req_in_s,req_in_n, req_in_pe,req_in_up,req_in_down;
input [FW-1:0] flit_in_e,flit_in_w,flit_in_n,flit_in_s,flit_in_pe,flit_in_up,flit_in_down;
//input clk, rst, req_in_pe;
//input [FW-1:0] flit_in_pe;
output grantfe,grantfw,grantfn,grantfs,grantfl,grantfup,grantfdown;
output [39:0] do_e,do_w,do_n,do_s,do_pe,do_up,do_down;


input grnt_in_e,//acknldge signal coming from  adjcent router
grnt_in_w,
grnt_in_n,
grnt_in_s,
grnt_in_pe,	
grnt_in_up,
grnt_in_down;
output req_out_w,
req_out_s,
req_out_n,
req_out_e,
req_out_up,
req_out_down;
//wire
wire [39:0] do_e11, do_w11, do_n11, do_s11, do_pe11, do_up11, do_down11;
wire [39:0] do_e21, do_w21, do_n21, do_s21, do_pe21, do_up21, do_down21;
wire [39:0] do_e31, do_w31, do_n31, do_s31, do_pe31, do_up31, do_down31;
wire [39:0] do_e41, do_w41, do_n41, do_s41, do_pe41, do_up41, do_down41;
wire [39:0] do_e12, do_w12, do_n12, do_s12, do_pe12, do_up12, do_down12;
wire [39:0] do_e22, do_w22, do_n22, do_s22, do_pe22, do_up22, do_down22;
wire [39:0] do_e32, do_w32, do_n32, do_s32, do_pe32, do_up32, do_down32;
wire [39:0] do_e42, do_w42, do_n42, do_s42, do_pe42, do_up42, do_down42;
wire [39:0] do_e13, do_w13, do_n13, do_s13, do_pe13, do_up13, do_down13;
wire [39:0] do_e23, do_w23, do_n23, do_s23, do_pe23, do_up23, do_down23;
wire [39:0] do_e33, do_w33, do_n33, do_s33, do_pe33, do_up33, do_down33;
wire [39:0] do_e43, do_w43, do_n43, do_s43, do_pe43, do_up43, do_down43;
wire [39:0] do_e14, do_w14, do_n14, do_s14, do_pe14, do_up14, do_down14;
wire [39:0] do_e24, do_w24, do_n24, do_s24, do_pe24, do_up24, do_down24;
wire [39:0] do_e34, do_w34, do_n34, do_s34, do_pe34, do_up34, do_down34;
wire [39:0] do_e44, do_w44, do_n44, do_s44, do_pe44, do_up44, do_down44;
wire req_out_e11,req_out_w11,req_out_s11,req_out_n11,req_out_up11,req_out_down11;
wire req_out_e21,req_out_w21,req_out_s21,req_out_n21,req_out_up21,req_out_down21;
wire req_out_e31,req_out_w31,req_out_s31,req_out_n31,req_out_up31,req_out_down31;
wire req_out_e41req_out_w41,req_out_s41,req_out_n41,req_out_up41,req_out_down41;
wire req_out_e12,req_out_w12,req_out_s12,req_out_n12,req_out_up12,req_out_down12;
wire req_out_e22,req_out_w22,req_out_s22,req_out_n22,req_out_up22,req_out_down22;
wire req_out_e32,req_out_w32,req_out_s32,req_out_n32,req_out_up32,req_out_down32;
wire req_out_e42,req_out_w42,req_out_s42,req_out_n42,req_out_up42,req_out_down42;
wire req_out_e13,req_out_w13,req_out_s13,req_out_n13,req_out_up13,req_out_down13;
wire req_out_e23,req_out_w23,req_out_s23,req_out_n23,req_out_up23,req_out_down23;
wire req_out_e33,req_out_w33,req_out_s33,req_out_n33,req_out_up33,req_out_down33;
wire req_out_e43,req_out_w43,req_out_s43,req_out_n43,req_out_up43,req_out_down43;
wire req_out_e14,req_out_w14,req_out_s14,req_out_n14,req_out_up14,req_out_down14;
wire req_out_e24,req_out_w24,req_out_s24,req_out_n24,req_out_up24,req_out_down24;
wire req_out_e34,req_out_w34,req_out_s34,req_out_n34,req_out_up34,req_out_down34;
wire req_out_e44,req_out_w44,req_out_s44,req_out_n44,req_out_up44,req_out_down44;


wire grnt_in_e11,grnt_in_w11,grnt_in_n11,grnt_in_s11,grnt_in_pe11,grnt_in_up11,grnt_in_down11;
wire grnt_in_e21,grnt_in_w21,grnt_in_n21,grnt_in_s21,grnt_in_pe21,grnt_in_up21,grnt_in_down21;
wire grnt_in_e31,grnt_in_w31,grnt_in_n31,grnt_in_s31,grnt_in_pe31,grnt_in_up31,grnt_in_down31;
wire grnt_in_e41,grnt_in_w41,grnt_in_n41,grnt_in_s41,grnt_in_pe41,grnt_in_up41,grnt_in_down41;

wire grnt_in_e12,grnt_in_w12,grnt_in_n12,grnt_in_s12,grnt_in_pe12,grnt_in_up12,grnt_in_down12;
wire grnt_in_e22,grnt_in_w22,grnt_in_n22,grnt_in_s22,grnt_in_pe22,grnt_in_up22,grnt_in_down22;
wire grnt_in_e32,grnt_in_w32,grnt_in_n32,grnt_in_s32,grnt_in_pe32,grnt_in_up32,grnt_in_down32;
wire grnt_in_e42,grnt_in_w42,grnt_in_n42,grnt_in_s42,grnt_in_pe42,grnt_in_up42,grnt_in_down42;

wire grnt_in_e13,grnt_in_w13,grnt_in_n13,grnt_in_s13,grnt_in_pe13,grnt_in_up13,grnt_in_down13;
wire grnt_in_e23,grnt_in_w23,grnt_in_n23,grnt_in_s23,grnt_in_pe23,grnt_in_up23,grnt_in_down23;
wire grnt_in_e33,grnt_in_w33,grnt_in_n33,grnt_in_s33,grnt_in_pe33,grnt_in_up33,grnt_in_down33;
wire grnt_in_e43,grnt_in_w43,grnt_in_n43,grnt_in_s43,grnt_in_pe43,grnt_in_up43,grnt_in_down43;

wire grnt_in_e14,grnt_in_w14,grnt_in_n14,grnt_in_s14,grnt_in_pe14,grnt_in_up14,grnt_in_down14;
wire grnt_in_e24,grnt_in_w24,grnt_in_n24,grnt_in_s24,grnt_in_pe24,grnt_in_up24,grnt_in_down24;
wire grnt_in_e34,grnt_in_w34,grnt_in_n34,grnt_in_s34,grnt_in_pe34,grnt_in_up34,grnt_in_down34;
wire grnt_in_e44,grnt_in_w44,grnt_in_n44,grnt_in_s44,grnt_in_pe44,grnt_in_up44,grnt_in_down44;


















wire grantf1e11, grantf1w11, grantf1n11, grantf1s11, grantf1l11, grantf1up11, grantf1down11;
wire grantf1e21, grantf1w21, grantf1n21, grantf1s21, grantf1l21, grantf1up21, grantf1down21;
wire grantf1e31, grantf1w31, grantf1n31, grantf1s31, grantf1l31, grantf1up31, grantf1down31;
wire grantf1e41, grantf1w41, grantf1n41, grantf1s41, grantf1l41, grantf1up41, grantf1down41;

wire grantf1e12, grantf1w12, grantf1n12, grantf1s12, grantf1l12, grantf1up12, grantf1down12;
wire grantf1e22, grantf1w22, grantf1n22, grantf1s22, grantf1l22, grantf1up22, grantf1down22;
wire grantf1e32, grantf1w32, grantf1n32, grantf1s32, grantf1l32, grantf1up32, grantf1down32;
wire grantf1e42, grantf1w42, grantf1n42, grantf1s42, grantf1l42, grantf1up42, grantf1down42;

wire grantf1e13, grantf1w13, grantf1n13, grantf1s13, grantf1l13, grantf1up13, grantf1down13;
wire grantf1e23, grantf1w23, grantf1n23, grantf1s23, grantf1l23, grantf1up23, grantf1down23;
wire grantf1e33, grantf1w33, grantf1n33, grantf1s33, grantf1l33, grantf1up33, grantf1down33;
wire grantf1e43, grantf1w43, grantf1n43, grantf1s43, grantf1l43, grantf1up43, grantf1down43;

wire grantf1e14, grantf1w14, grantf1n14, grantf1s14, grantf1l14, grantf1up14, grantf1down14;
wire grantf1e24, grantf1w24, grantf1n24, grantf1s24, grantf1l24, grantf1up24, grantf1down24;
wire grantf1e34, grantf1w34, grantf1n34, grantf1s34, grantf1l34, grantf1up34, grantf1down34;
wire grantf1e44, grantf1w44, grantf1n44, grantf1s44, grantf1l44, grantf1up44, grantf1down44;

router r11 
		(.clk(clk), .rst(rst), .flit_in_e(do_w21), .flit_in_w(flit_in_w), .flit_in_n(do_s12),
			.flit_in_s(flit_in_s), .flit_in_pe(flit_in_pe), .flit_in_down(flit_in_down), .flit_in_up(flit_in_up), // flit inputs to each port
			.do_e(do_e11), .do_w(do_w11), .do_n(do_n11), .do_s(do_s11),
			.do_pe(do_pe11), .do_up(do_up11), .do_down(do_down11),						//data output for each port
			.req_in_e(grantf1w21), .req_in_w(req_in_w), .req_in_s(req_in_s), .req_in_n(grantf1s12), 
			.req_in_pe(req_in_pe), .req_in_up(req_in_up), .req_in_down(req_in_down),//reqs in frm adjcent routr..
			.grantfe(grantf1e11), .grantfw(grantf1w11), .grantfn(grantf1n11), .grantfs(grantf1s11),
			.grantfl(grantf1pe11), .grantfup(grantf1up11), .grantfdown(grantf1down11),
			.req_out_e(req_out_e11),.req_out_w(req_out_w11),.req_out_s(req_out_s11),.req_out_n(req_out_n11),
			.req_out_up(req_out_up11),.req_out_down(req_out_down11)// req out from present router to its adjacent router...
		);
		
router r21 
		(.clk(clk), .rst(rst), .flit_in_e(do_w31), .flit_in_w(do_e11), .flit_in_n(do_s22),
			.flit_in_s(), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e21), .do_w(do_w21), .do_n(do_n21), .do_s(do_s21),
			.do_pe(do_pe21), .do_up(do_up21), .do_down(do_down21),						//data output for each port
			.req_in_e(grantf1w31), .req_in_w(grantf1e11), .req_in_s(), .req_in_n(grantf1s22), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e21), .grantfw(grantf1w21), .grantfn(grantf1n21), .grantfs(grantf1s21),
			.grantfl(grantf1pe21), .grantfup(grantf1up21), .grantfdown(grantf1down),
			.req_out_e(req_out_e21),.req_out_w(req_out_w21),.req_out_s(req_out_s21),.req_out_n(req_out_n21),
			.req_out_up(req_out_up21),.req_out_down(req_out_down21)// req out from present router to its adjacent router...
		);
router r31 
		(.clk(clk), .rst(rst), .flit_in_e(do_w41), .flit_in_w(do_e21), .flit_in_n(do_s32),
			.flit_in_s(), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e31), .do_w(do_w31), .do_n(do_n31), .do_s(do_s31),
			.do_pe(do_pe31), .do_up(do_up31), .do_down(do_down31),						//data output for each port
			.req_in_e(grantf1w41), .req_in_w(grantf1e21), .req_in_s(), .req_in_n(grantf1s32), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e31), .grantfw(grantf1w31), .grantfn(grantf1n31), .grantfs(grantf1s31),
			.grantfl(grantf1pe31), .grantfup(grantf1up31), .grantfdown(grantf1down31),// grant out from present router to its adjacent router...
			.req_out_e(req_out_e31),.req_out_w(req_out_w31),.req_out_s(req_out_s31),.req_out_n(req_out_n31),
			.req_out_up(req_out_up31),.req_out_down(req_out_down31)
		);
router r41 
		(.clk(clk), .rst(rst), .flit_in_e(), .flit_in_w(do_e31), .flit_in_n(do_s42),
			.flit_in_s(), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e41), .do_w(do_w41), .do_n(do_n41), .do_s(do_s41),
			.do_pe(do_pe41), .do_up(do_up41), .do_down(do_down41),						//data output for each port
			.req_in_e(), .req_in_w(grantf1e31), .req_in_s(), .req_in_n(grantf1s42), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e41), .grantfw(grantf1w41), .grantfn(grantf1n41), .grantfs(grantf1s41),
			.grantfl(grantf1pe41), .grantfup(grantf1up41), .grantfdown(grantf1down41),// grant out from present router to its adjacent router...
			.req_out_e(req_out_e41),.req_out_w(req_out_w41),.req_out_s(req_out_s41),.req_out_n(req_out_n41),
			.req_out_up(req_out_up41),.req_out_down(req_out_down41)
		);
router r12 
		(.clk(clk), .rst(rst), .flit_in_e(do_w22), .flit_in_w(), .flit_in_n(do_s13),
			.flit_in_s(do_n11), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e12), .do_w(do_w12), .do_n(do_n12), .do_s(do_s12),
			.do_pe(do_pe12), .do_up(do_up12), .do_down(do_down12),						//data output for each port
			.req_in_e(grantf1w22), .req_in_w(), .req_in_s(grantf1n11), .req_in_n(grantf1s13), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e12), .grantfw(grantf1w12), .grantfn(grantf1n12), .grantfs(grantf1s12),
			.grantfl(grantf1pe12), .grantfup(grantf1up12), .grantfdown(grantf1down12),// grant out from present router to its adjacent router...
			.req_out_e(req_out_e21),.req_out_w(req_out_w21),.req_out_s(req_out_s21),.req_out_n(req_out_n21),
			.req_out_up(req_out_up21),.req_out_down(req_out_down21)
		);
router r22 
		(.clk(clk), .rst(rst), .flit_in_e(do_w32), .flit_in_w(do_e12), .flit_in_n(do_s23),
			.flit_in_s(do_n21), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e22), .do_w(do_w22), .do_n(do_n22), .do_s(do_s22),
			.do_pe(do_pe22), .do_up(do_up22), .do_down(do_down22),						//data output for each port
			.req_in_e(grantf1w32), .req_in_w(grantf1e12), .req_in_s(grantf1n21), .req_in_n(grantf1s23), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e22), .grantfw(grantf1w22), .grantfn(grantf1n22), .grantfs(grantf1s22),
			.grantfl(grantf1pe22), .grantfup(grantf1up22), .grantfdown(grantf1down22),
			.req_out_e(req_out_e22),.req_out_w(req_out_w22),.req_out_s(req_out_s22),.req_out_n(req_out_n22),
			.req_out_up(req_out_up22),.req_out_down(req_out_down22)// grant out from present router to its adjacent router...
		);
router r32 
		(.clk(clk), .rst(rst), .flit_in_e(do_w42), .flit_in_w(do_e22), .flit_in_n(do_s33),
			.flit_in_s(do_n31), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e32), .do_w(do_w32), .do_n(do_n32), .do_s(do_s32),
			.do_pe(do_pe32), .do_up(do_up32), .do_down(do_down32),						//data output for each port
			.req_in_e(grantf1w42), .req_in_w(grantf1e22), .req_in_s(grantf1n31), .req_in_n(grantf1s33), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e32), .grantfw(grantf1w32), .grantfn(grantf1n32), .grantfs(grantf1s32),
			.grantfl(grantf1pe32), .grantfup(grantf1up32), .grantfdown(grantf1down32),// grant out from present router to its adjacent router...
			.req_out_e(req_out_e32),.req_out_w(req_out_w32),.req_out_s(req_out_s32),.req_out_n(req_out_n32),
			.req_out_up(req_out_up31),.req_out_down(req_out_down32)
		);
router r42 
		(.clk(clk), .rst(rst), .flit_in_e(), .flit_in_w(do_e32), .flit_in_n(do_s43),
			.flit_in_s(do_n41), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e42), .do_w(do_w42), .do_n(do_n42), .do_s(do_s42),
			.do_pe(do_pe42), .do_up(do_up42), .do_down(do_down42),						//data output for each port
			.req_in_e(), .req_in_w(grantf1e32), .req_in_s(grantf1n41), .req_in_n(grantf1s43), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e42), .grantfw(grantf1w42), .grantfn(grantf1n42), .grantfs(grantf1s42),
			.grantfl(grantf1pe42), .grantfup(grantf1up42), .grantfdown(grantf1down42),// grant out from present router to its adjacent router...
			.req_out_e(req_out_e42),.req_out_w(req_out_w42),.req_out_s(req_out_s42),.req_out_n(req_out_n42),
			.req_out_up(req_out_up42),.req_out_down(req_out_down42)
		);
router r13 
		(.clk(clk), .rst(rst), .flit_in_e(do_w23), .flit_in_w(), .flit_in_n(do_s14),
			.flit_in_s(do_n12), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e13), .do_w(do_w13), .do_n(do_n13), .do_s(do_s13),
			.do_pe(do_pe13), .do_up(do_up13), .do_down(do_down13),						//data output for each port
			.req_in_e(grantf1w23), .req_in_w(), .req_in_s(grantf1n12), .req_in_n(grantf1s14), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e13), .grantfw(grantf1w13), .grantfn(grantf1n13), .grantfs(grantf1s13),
			.grantfl(grantf1pe13), .grantfup(grantf1up13), .grantfdown(grantf1down13),// grant out from present router to its adjacent router...
			.req_out_e(req_out_e13),.req_out_w(req_out_w13),.req_out_s(req_out_s13),.req_out_n(req_out_n13),
			.req_out_up(req_out_up13),.req_out_down(req_out_down13)
		);
router r23 
		(.clk(clk), .rst(rst), .flit_in_e(do_w33), .flit_in_w(do_e13), .flit_in_n(do_s24),
			.flit_in_s(do_n22), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e23), .do_w(do_w23), .do_n(do_n23), .do_s(do_s23),
			.do_pe(do_pe23), .do_up(do_up23), .do_down(do_down23),						//data output for each port
			.req_in_e(grantf1w33), .req_in_w(grantf1e13), .req_in_s(grantf1n22), .req_in_n(grantf1s24), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e23), .grantfw(grantf1w23), .grantfn(grantf1n23), .grantfs(grantf1s23),
			.grantfl(grantf1pe23), .grantfup(grantf1up23), .grantfdown(grantf1down23),// grant out from present router to its adjacent router...
			.req_out_e(req_out_e23),.req_out_w(req_out_w23),.req_out_s(req_out_s23),.req_out_n(req_out_n23),
			.req_out_up(req_out_up23),.req_out_down(req_out_down23)
		);
router r33 
		(.clk(clk), .rst(rst), .flit_in_e(do_w43), .flit_in_w(do_e23), .flit_in_n(do_s34),
			.flit_in_s(do_n32), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e33), .do_w(do_w33), .do_n(do_n33), .do_s(do_s33),
			.do_pe(do_pe33), .do_up(do_up33), .do_down(do_down33),						//data output for each port
			.req_in_e(grantf1w43), .req_in_w(grantf1e23), .req_in_s(grantf1n32), .req_in_n(grantf1s34), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e33), .grantfw(grantf1w33), .grantfn(grantf1n33), .grantfs(grantf1s33),
			.grantfl(grantf1pe33), .grantfup(grantf1up33), .grantfdown(grantf1down33),// grant out from present router to its adjacent router...
			.req_out_e(req_out_e33),.req_out_w(req_out_w33),.req_out_s(req_out_s33),.req_out_n(req_out_n33),
			.req_out_up(req_out_up33),.req_out_down(req_out_down33)
		);
router r43 
		(.clk(clk), .rst(rst), .flit_in_e(), .flit_in_w(do_e33), .flit_in_n(do_s44),
			.flit_in_s(do_n42), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e43), .do_w(do_w43), .do_n(do_n43), .do_s(do_s43),
			.do_pe(do_pe43), .do_up(do_up43), .do_down(do_down43),						//data output for each port
			.req_in_e(), .req_in_w(grantf1e33), .req_in_s(grantf1n42), .req_in_n(grantf1s44), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e43), .grantfw(grantf1w43), .grantfn(grantf1n43), .grantfs(grantf1s43),
			.grantfl(grantf1pe43), .grantfup(grantf1up43), .grantfdown(grantf1down43),// grant out from present router to its adjacent router...
			.req_out_e(req_out_e43),.req_out_w(req_out_w43),.req_out_s(req_out_s43),.req_out_n(req_out_n43),
			.req_out_up(req_out_up43),.req_out_down(req_out_down43)
		);
router r14 
		(.clk(clk), .rst(rst), .flit_in_e(do_w24), .flit_in_w(), .flit_in_n(),
			.flit_in_s(do_n13), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e14), .do_w(do_w14), .do_n(do_n14), .do_s(do_s14),
			.do_pe(do_pe14), .do_up(do_up14), .do_down(do_down14),						//data output for each port
			.req_in_e(grantf1w24), .req_in_w(), .req_in_s(grantf1n13), .req_in_n(), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e14), .grantfw(grantf1w14), .grantfn(grantf1n14), .grantfs(grantf1s14),
			.grantfl(grantf1pe14), .grantfup(grantf1up14), .grantfdown(grantf1down14),// grant out from present router to its adjacent router...
			.req_out_e(req_out_e14),.req_out_w(req_out_w14),.req_out_s(req_out_s14),.req_out_n(req_out_n14),
			.req_out_up(req_out_up14),.req_out_down(req_out_down14)
		);
router r24 
		(.clk(clk), .rst(rst), .flit_in_e(do_w34), .flit_in_w(do_e14), .flit_in_n(),
			.flit_in_s(do_n23), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e24), .do_w(do_w24), .do_n(do_n24), .do_s(do_s24),
			.do_pe(do_pe24), .do_up(do_up24), .do_down(do_down24),						//data output for each port
			.req_in_e(grantf1w34), .req_in_w(grantf1e14), .req_in_s(grantf1n23), .req_in_n(), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e24), .grantfw(grantf1w24), .grantfn(grantf1n24), .grantfs(grantf1s24),
			.grantfl(grantf1pe24), .grantfup(grantf1up24), .grantfdown(grantf1down24),// grant out from present router to its adjacent router...
			.req_out_e(req_out_e24),.req_out_w(req_out_w24),.req_out_s(req_out_s24),.req_out_n(req_out_n24),
			.req_out_up(req_out_up24),.req_out_down(req_out_down24)
		);
router r34 
		(.clk(clk), .rst(rst), .flit_in_e(do_w44), .flit_in_w(do_e24), .flit_in_n(),
			.flit_in_s(do_n33), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e34), .do_w(do_w34), .do_n(do_n34), .do_s(do_s34),
			.do_pe(do_pe34), .do_up(do_up34), .do_down(do_down34),						//data output for each port
			.req_in_e(grantf1w44), .req_in_w(grantf1e24), .req_in_s(grantf1n33), .req_in_n(), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e34), .grantfw(grantf1w34), .grantfn(grantf1n34), .grantfs(grantf1s34),
			.grantfl(grantf1pe34), .grantfup(grantf1up34), .grantfdown(grantf1down34),// grant out from present router to its adjacent router...
			.req_out_e(req_out_e34),.req_out_w(req_out_w34),.req_out_s(req_out_s34),.req_out_n(req_out_n34),
			.req_out_up(req_out_up34),.req_out_down(req_out_down34)
		);
router r44 
		(.clk(clk), .rst(rst), .flit_in_e(), .flit_in_w(do_e34), .flit_in_n(),
			.flit_in_s(do_n43), .flit_in_pe(), .flit_in_down(), .flit_in_up(), // flit inputs to each port
			.do_e(do_e44), .do_w(do_w44), .do_n(do_n44), .do_s(do_s44),
			.do_pe(do_pe44), .do_up(do_up44), .do_down(do_down44),						//data output for each port
			.req_in_e(), .req_in_w(grantf1e34), .req_in_s(grantf1n43), .req_in_n(), 
			.req_in_pe(), .req_in_up(), .req_in_down(),//reqs in frm adjcent routr..
			.grantfe(grantf1e44), .grantfw(grantf1w44), .grantfn(grantf1n44), .grantfs(grantf1s44),
			.grantfl(grantf1pe44), .grantfup(grantf1up44), .grantfdown(grantf1down44),// grant out from present router to its adjacent router...
			.req_out_e(req_out_e44),.req_out_w(req_out_w44),.req_out_s(req_out_s44),.req_out_n(req_out_n44),
			.req_out_up(req_out_up44),.req_out_down(req_out_down44)
		);
assign do_e = do_e44 ;
assign do_w = do_w44 ;
assign do_n = do_n44 ;
assign do_s = do_s44 ;
assign do_up = do_up44 ;
assign do_down = do_down44;
assign do_pe = do_pe44 ;

assign grantfe = grantf1e44;
assign grantfw= grantf1w44;
assign grantfn = grantf1n44;
assign grantfs = grantf1s44;
assign grantfup = grantf1up44;
assign grantfdown = grantf1down44;
assign grantfpe = grantf1pe44;
endmodule
