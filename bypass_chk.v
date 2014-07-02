`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:05:58 07/10/2013 
// Design Name: 
// Module Name:    bypass_chk 
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
//baseline router bypass_chk
module router (clk,
 rst,
flit_in_e,
flit_in_w,
flit_in_n,
flit_in_s,
flit_in_pe,
flit_in_down,
flit_in_up, // flit inputs to each port
do_e,
do_w,
do_n,
do_s,
do_pe,	
do_up,
do_down,						//data output for each port
req_in_e, //reqs in frm adjcent routr..
req_in_w,
req_in_s,
req_in_n,
req_in_pe,
req_in_up,
req_in_down,
grnt_in_e,//acknldge signal coming from  adjcent router
grnt_in_w,
grnt_in_n,
grnt_in_s,
grnt_in_pe,	
grnt_in_up,
grnt_in_down,					
grantfe,  // grant out from present router to its adjacent router...   
grantfw,
grantfn,
grantfs,
grantfl,
grantfup,
grantfdown
req_out_e, //reqs in frm adjcent routr..
req_out_w,
req_out_s,
req_out_n,
req_out_pe,
req_out_up,
req_out_down
); 

parameter IDLE=001;
parameter RCU=010;
parameter SA =100;
parameter FW= 40;
input req_in_e,
req_in_w,
req_in_s,
req_in_n, 
req_in_pe,
req_in_up,
req_in_down;
output grantfe,
grantfw,
grantfn,
grantfs,
grantfl,grantfup,
grantfdown;/*req_out_e, //reqs in frm adjcent routr..
req_out_w,
req_out_s,
req_out_n,
req_out_pe,req_out_up,
req_out_down;
input grnt_in_e,//acknldge signal coming from  adjcent router
grnt_in_w,
grnt_in_n,
grnt_in_s,
grnt_in_pe,
grnt_in_up,
grnt_in_down;*/
input [FW-1:0] flit_in_e,
flit_in_w,
flit_in_n,
flit_in_s,
flit_in_pe,
flit_in_up,
flit_in_down;
output [39:0] do_e,
do_w,
do_n,
do_s,
do_pe,
do_up,
do_down;
reg  [2:0]state_e,state_w,state_n,state_s,state_pe,state_up,state_down;
wire [2:0]next_state_e,next_state_w,next_state_n,next_state_s,next_state_pe,next_state_up,next_state_down;
//wire  empty_e,empty_w,empty_n,empty_s,empty_pe,empty_up,empty_down;
 reg [39:0] flit_r_e,flit_r_w,flit_r_n,flit_r_s,flit_r_pe,flit_r_up,flit_r_down;
 
wire ge ,gw,gs,gn,gpe,gup,gdown ;
wire m_e,m_w,m_n,m_s,m_pe,m_up,m_down;
input clk, rst;
//input [FW-1:0] flit;
wire [5:0] grante,
grantw,
grantn,
grants,
grantl ,
grantup,
grantdown;
wire wen_s,wen_n,wen_e,wen_w,wen_pe,wen_up,wen_down,fe,fn,fsouth,fpe,fw,fup,fdown,ee,ew,es,en,epe,eup,edown;
wire [39:0] doutf_e,doutf_w,doutf_n,doutf_s,doutf_pe,doutf_up,doutf_down;
 wire [2:0] sel_e,sel_w,sel_n,sel_s,sel_pe,sel_up,sel_down;
wire [2:0] op_e,op_w,op_n,op_s,op_pe,op_up,op_down;
 fifo1 ff_east(.data_out(doutf_e),
			  .data_in(flit_in_e),
			  .stack_empty(ee),
			  .stack_full(fe),
			  .clk(clk),
			  .rst(rst),
			  .write_to_stack(wen_e),
			  .read_from_stack(ge));
			  
fifo1 ff_west(.data_out(doutf_w),
			  .data_in(flit_in_w),
			  .stack_empty(ew),
			  .stack_full(fw),
			  .clk(clk),
			  .rst(rst),
			  .write_to_stack(wen_w),
			  .read_from_stack(gw));
			
fifo1 ff_north(.data_out(doutf_n),
			  .data_in(flit_in_n),
			  .stack_empty(en),
			  .stack_full(fn),
			  .clk(clk),
			  .rst(rst),
			  .write_to_stack(wen_n),
			  .read_from_stack(gn));
			  
fifo1 ff_south(.data_out(doutf_s),
			  .data_in(flit_in_s),
			  .stack_empty(es),
			  .stack_full(fsouth),
			  .clk(clk),
			  .rst(rst),
			  .write_to_stack(wen_s),
			  .read_from_stack(gs));

fifo1 ff_pe(.data_out(doutf_pe),
			  .data_in(flit_in_pe),
			  .stack_empty(epe),
			  .stack_full(fpe),
			  .clk(clk),
			  .rst(rst),
			  .write_to_stack(wen_pe),
			  .read_from_stack(gpe));
fifo1 ff_up(.data_out(doutf_up),
			  .data_in(flit_in_up),
			  .stack_empty(eup),
			  .stack_full(fup),
			  .clk(clk),
			  .rst(rst),
			  .write_to_stack(wen_up),
			  .read_from_stack(gup));
fifo1 ff_down(.data_out(doutf_down),
			  .data_in(flit_in_down),
			  .stack_empty(edown),
			  .stack_full(fdown),
			  .clk(clk),
			  .rst(rst),
			  .write_to_stack(wen_down),
			  .read_from_stack(gdown));			  
			  

assign wen_e =  (state_e < 3'b100) ? ((~fe)&&(req_in_e)) : (~ge) ;
assign wen_w = (state_w < 3'b100)? ((~fw)&&(req_in_w)): (~gw);
assign wen_n = (state_n < 3'b100)? ((~fn)&&(req_in_n)): (~gn);
assign wen_s = (state_s < 3'b100)?((~fsouth)&&(req_in_s)) : (~gs);
assign wen_pe = (state_pe < 3'b100)? ((~fpe)&&(req_in_pe)): (~gpe);
assign wen_up = (state_up < 3'b100)? ((~fup)&&(req_in_up)): (~gup);
assign wen_down = (state_down < 3'b100)? ((~fdown)&&(req_in_down)): (~gdown);

assign grantfe = rst? 0 : ((do_e[FW-1])?((~fe)&&(req_in_e)):0);
assign grantfw = rst? 0 :((do_w[FW-1])?((~fw)&&(req_in_w)):0);
assign grantfn = rst? 0 :((do_n[FW-1])?((~fn)&&(req_in_n)):0);
assign grantfs = rst? 0 :((do_s[FW-1])?((~fsouth)&&(req_in_s)):0);
assign grantfl = rst? 0 :((do_pe[FW-1])?((~fpe)&&(req_in_pe)):0);
assign grantfup = rst? 0 :((do_up[FW-1])?((~fup)&&(req_in_up)):0);
assign grantfdown = 	rst? 0: ((do_down[FW-1])?((~fdown)&&(req_in_down)):0);
			
rcu_mod r_e(clk, rst, flit_r_e, state_e, op_e); // op_e gives info about which port flit in EAST inpurt port is requesting
rcu_mod r_w(clk, rst, flit_r_w, state_w, op_w);
rcu_mod r_n(clk, rst, flit_r_n, state_n, op_n);
rcu_mod r_s(clk, rst, flit_r_s, state_s, op_s);
rcu_mod r_pe(clk, rst, flit_r_pe, state_pe,op_pe);
rcu_mod r_up(clk, rst, flit_r_up, state_up,op_up);
rcu_mod r_down(clk, rst, flit_r_down, state_down,op_down);
switchalloc sa(.rce(op_e),    
				.rcn(op_n),
				.rcw(op_w),
				.rcs(op_s),
				.rcl(op_pe),
				.rcup(op_up),
				.rcdown(op_down),
				.clk(clk),
				.reset(rst),
				.grant_e(grante),
				.grant_w(grantw),
				.grant_n(grantn),
				.grant_s(grants),
				.grant_l(grantl),
				.grant_up(grantup),
				.grant_down(grantdown),
				.ge(ge),.gw(gw),.gn(gn),.gs(gs),.gpe(gpe),.gup(gup),.gdown(gdown),    // Grant signal generated for read enable for all FIFOs
				.m_e(m_e),.m_w(m_w),.m_n(m_n),.m_s(m_s),.m_pe(m_pe),.m_up(m_up),.m_down(m_down),
				.sel_e(sel_e),.sel_w(sel_w),.sel_n(sel_n),.sel_s(sel_s),.sel_pe(sel_pe),.sel_up(sel_up),.sel_down(sel_down)); // Mux enable signals for each output port



//State Computation for each port
state_comp s_East(state_e,flit_in_e,next_state_e,ee,wen_e);				
state_comp s_West(state_w,flit_in_e,next_state_w,ew,wen_w);				
state_comp s_North(state_n,flit_in_n,next_state_n,en,wen_n);				
state_comp s_South(state_s,flit_in_s,next_state_s,es,wen_s);				
state_comp s_Local(state_pe,flit_in_pe,next_state_pe,epe,wen_pe);				
state_comp s_up(state_up,flit_in_up,next_state_up,eup,wen_up);	
state_comp s_down(state_down,flit_in_down,next_state_down,edown,wen_down);	
//Muxes for each port
mux_6x1 mux_e (.d0(doutf_down),.d1(doutf_up),.d2(doutf_pe),.d3(doutf_s),.d4(doutf_n),.d5(doutf_w), .en(m_e), .sel(sel_e), .dout(do_e));
mux_6x1 mux_w (.d0(doutf_down),.d1(doutf_up),.d2(doutf_pe),.d3(doutf_s),.d4(doutf_n),.d5(doutf_e), .en(m_w), .sel(sel_w), .dout(do_w));
mux_6x1 mux_n (.d0(doutf_down),.d1(doutf_up),.d2(doutf_pe),.d3(doutf_s),.d4(doutf_w),.d5(doutf_e), .en(m_n), .sel(sel_n), .dout(do_n));
mux_6x1 mux_s (.d0(doutf_down),.d1(doutf_up),.d2(doutf_pe),.d3(doutf_n),.d4(doutf_w),.d5(doutf_e), .en(m_s), .sel(sel_s), .dout(do_s));
mux_6x1 mux_pe (.d0(doutf_down),.d1(doutf_up),.d2(doutf_s),.d3(doutf_n),.d4(doutf_w),.d5(doutf_e), .en(m_pe), .sel(sel_pe), .dout(do_pe));
mux_6x1 mux_up (.d0(doutf_down),.d1(doutf_pe),.d2(doutf_s),.d3(doutf_n),.d4(doutf_w),.d5(doutf_e), .en(m_up), .sel(sel_up), .dout(do_up));
mux_6x1 mux_down (.d0(doutf_up),.d1(doutf_pe),.d2(doutf_s),.d3(doutf_n),.d4(doutf_w),.d5(doutf_e),.en(m_down), .sel(sel_down), .dout(do_down));
// wen for each 


//FSM -- State Assignment
always @ (posedge clk or posedge rst)
begin
	if (rst) begin
	state_e <= IDLE;
	state_w <= IDLE;
	state_n <= IDLE;
	state_s <= IDLE;
	state_pe <= IDLE;
	state_up <= IDLE;
	state_down <= IDLE;
	end
	else begin
	state_e <= next_state_e;
	state_w <= next_state_w;
	state_n <= next_state_n;
	state_s <= next_state_s;
	state_pe <= next_state_pe;
	state_up <= next_state_up;
	state_down <= next_state_down;
	end
	
end

// Assigning value to registers placed before routing computation unit of each port
always @(posedge clk or posedge rst)
begin

if (rst)
begin
flit_r_e<= 40'b0;
flit_r_w<= 40'b0;
flit_r_n<= 40'b0;
flit_r_s<= 40'b0;
flit_r_pe<= 40'b0;
flit_r_up<= 40'b0;
flit_r_down<= 40'b0;
end

else
begin  
	if (state_e==3'b001 && (flit_in_e[FW-1]&flit_in_e[FW-2]) && wen_e==1'b1)  // state is in IDLE and header flit 
		flit_r_e<=flit_in_e;
	else
		flit_r_e<=flit_r_e;
	
	if (state_w==3'b001 && (flit_in_w[FW-1]&flit_in_w[FW-2]) && wen_w==1'b1)  // state is in IDLE and header flit 
		flit_r_w<=flit_in_w;
	else
		flit_r_w<=flit_r_w;
	if (state_n==3'b001 && (flit_in_n[FW-1]&flit_in_n[FW-2]) && wen_n==1'b1)  // state is in IDLE and header flit 
		flit_r_n<=flit_in_n;
	else
		flit_r_n<=flit_r_n;
	if (state_s==3'b001 && (flit_in_s[FW-1]&flit_in_s[FW-2]) && wen_s==1'b1)  // state is in IDLE and header flit 
		flit_r_s<=flit_in_s;
	else
		flit_r_s<=flit_r_s;
	if (state_pe==3'b001 && (flit_in_pe[FW-1]&flit_in_pe[FW-2]) && wen_pe==1'b1)  // state is in IDLE and header flit 
		flit_r_pe<=flit_in_pe;
	else
		flit_r_pe<=flit_r_pe;
	if (state_up==3'b001 && (flit_in_up[FW-1]&flit_in_up[FW-2]) && wen_up==1'b1)  // state is in IDLE and header flit 
		flit_r_up<=flit_in_up;
	else
		flit_r_up<=flit_r_up;
		if (state_down==3'b001 && (flit_in_down[FW-1]&flit_in_down[FW-2]) && wen_down==1'b1)  // state is in IDLE and header flit 
		flit_r_down<=flit_in_down;
	else
		flit_r_down<=flit_r_down;
		end 

end
endmodule

////////////////////////////


