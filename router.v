
module router (clk,
	 rst,
	flit_in_e,
	flit_in_w,
	flit_in_n,
	flit_in_s,
	flit_in_pe,

	do_e,
	do_w,
	do_n,
	do_s,
	do_pe,	

	req_in_e, //reqs in frm adjcent routr..
	req_in_w,
	req_in_s,
	req_in_n,
	req_in_pe,
	
	grnt_in_e,//acknldge signal coming from  adjcent router
	grnt_in_w,
	grnt_in_n,
	grnt_in_s,
	grnt_in_pe,	
					
	grantfe,	// grant out from present router to its adjacent router...   
	grantfw,	// req_in + header is sent 
	grantfn,	// chks header n fifo full at the neighboring router then sends grantfe frm it, which is taken in by grnat_in_x 
			// body flits are sent , then when tail is received by the ajaent router , it pulls down grnt_fe
	grantfs,
	grantfl,

	req_out_e, //reqs in frm adjcent routr..
	req_out_w,
	req_out_s,
	req_out_n

); 

parameter IDLE=001;
parameter RCU=010;
parameter SA =100;
parameter FW= 40;
input req_in_e,
	req_in_w,
	req_in_s,
	req_in_n, 
	req_in_pe;
output grantfe,
	grantfw,
	grantfn,
	grantfs,
	grantfl,
	req_out_e, //reqs in frm adjcent routr.. // take out grant_out or req_out keep only one
	req_out_w,
	req_out_s,
	req_out_n;
input grnt_in_e,//acknldge signal coming from  adjcent router
	grnt_in_w,
	grnt_in_n,
	grnt_in_s;
input [FW-1:0] flit_in_e,
flit_in_w,
flit_in_n,
flit_in_s,
flit_in_pe;
output [39:0] do_e,
do_w,
do_n,
do_s,
do_pe;
reg  [2:0]state_e,state_w,state_n,state_s,state_pe;
wire [2:0]next_state_e,next_state_w,next_state_n,next_state_s,next_state_pe;
//wire  empty_e,empty_w,empty_n,empty_s,empty_pe,empty_up,empty_down;
 reg [39:0] flit_r_e,flit_r_w,flit_r_n,flit_r_s,flit_r_pe;
 
wire ge ,gw,gs,gn,gpe;
wire m_e,m_w,m_n,m_s,m_pe;
input clk, rst;
//input [FW-1:0] flit;
wire [3:0] grante,
grantw,
grantn,
grants,
grantl ;
wire wen_s,wen_n,wen_e,wen_w,wen_pe,fe,fn,fsouth,fpe,fw,ee,ew,es,en,epe;
wire [39:0] doutf_e,doutf_w,doutf_n,doutf_s,doutf_pe;
 wire [2:0] sel_e,sel_w,sel_n,sel_s,sel_pe;
wire [2:0] op_e,op_w,op_n,op_s,op_pe;
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

assign req_out_e=ge;
assign req_out_w=gw;
assign req_out_n=gn;
assign req_out_s=gs;


/*	

assign wen_e = (state_e < 100) ? ((~fe)&&(req_in_e)): ~ge ;
assign wen_w =  (state_w < 100) ?((~fw)&&(req_in_w)):~gw;
assign wen_n = (state_n < 100) ?((~fn)&&(req_in_n)): ~gn;
assign wen_s = (state_s < 100) ?((~fsouth)&&(req_in_s)): ~gs;
assign wen_pe =  (state_pe < 100) ?((~fpe)&&(req_in_pe)): ~gpe;*/

/* Since the fifos used are synchronous ones, read and write cannot be done at the same time .IDLE,RCU and SA - 2 cycles of read and 
then 2 cycles of write 1 header , 1 body flit tail flit ?  */


assign grantfe = rst? 0 : wen_e; 
assign grantfw = rst? 0 : wen_w; 
assign grantfn = rst? 0 : wen_n; 
assign grantfs = rst? 0 : wen_s; 
assign grantfl = rst? 0 : wen_pe; 

			
rcu_mod r_e(clk, rst, flit_r_e, state_e, op_e); // op_e gives info about which port flit in EAST inpurt port is requesting
rcu_mod r_w(clk, rst, flit_r_w, state_w, op_w);
rcu_mod r_n(clk, rst, flit_r_n, state_n, op_n);
rcu_mod r_s(clk, rst, flit_r_s, state_s, op_s);
rcu_mod r_pe(clk, rst, flit_r_pe, state_pe,op_pe);
/* rcu_mod r_up(clk, rst, flit_r_up, state_up,op_up);
rcu_mod r_down(clk, rst, flit_r_down, state_down,op_down); */
switchalloc sa(	.rce(op_e),    
				.rcn(op_n),
				.rcw(op_w),
				.rcs(op_s),
				.rcl(op_pe),
				.grnt_in_e(grnt_in_e),//acknldge signal coming from  adjcent router
				.grnt_in_w(grnt_in_w),
				.grnt_in_n(grnt_in_n),
				.grnt_in_s(grnt_in_s),
			//	.grnt_in_pe,	
			//	.grnt_in_up,
//				.grnt_in_down,
				.clk(clk),
				.reset(rst),
				.grant_e(grante),
				.grant_w(grantw),
				.grant_n(grantn),
				.grant_s(grants),
				.grant_l(grantl),
//				grant_e(gr)
				.ge(ge),.gw(gw),.gn(gn),.gs(gs),//.gpe(gpe),    // Grant signal generated for read enable for all FIFOs
				.m_e(m_e),.m_w(m_w),.m_n(m_n),.m_s(m_s),.m_pe(m_pe),
				.sel_e(sel_e),.sel_w(sel_w),.sel_n(sel_n),.sel_s(sel_s),.sel_pe(sel_pe)); // Mux enable signals for each output port



//State Computation for each port
state_comp s_East(.state(state_e),.flit(flit_in_e),.next_state(next_state_e),.full(fe),.w_en(wen_e),.flit_rcu(flit_r_e),.read(ge));				
state_comp s_West(.state(state_w),.flit(flit_in_w),.next_state(next_state_w),.full(fw),.w_en(wen_w),.flit_rcu(flit_r_w),.read(gw));				
state_comp s_North(.state(state_n),.flit(flit_in_n),.next_state(next_state_n),.full(fn),.w_en(wen_n),.flit_rcu(flit_r_n),.read(gn));				
state_comp s_South(.state(state_s),.flit(flit_in_s),.next_state(next_state_s),.full(fs),.w_en(wen_s),.flit_rcu(flit_r_s),.read(gs));					
state_comp s_Local(.state(state_pe),.flit(flit_in_pe),.next_state(next_state_pe),.full(fpe),.w_en(wen_pe),.flit_rcu(flit_r_pe),.read(gpe));			
/* state_comp s_up(state_up,flit_in_up,next_state_up,eup,wen_up);	
state_comp s_down(state_down,flit_in_down,next_state_down,edown,wen_down);	 */
//Muxes for each port
mux_4x1 mux_e (.d0(doutf_pe),.d1(doutf_s),.d2(doutf_n),.d3(doutf_w), .en(m_e), .sel(sel_e), .dout(do_e));
mux_4x1 mux_w (.d0(doutf_pe),.d1(doutf_s),.d2(doutf_n),.d3(doutf_e), .en(m_w), .sel(sel_w), .dout(do_w));
mux_4x1 mux_n (.d0(doutf_pe),.d1(doutf_s),.d2(doutf_w),.d3(doutf_e), .en(m_n), .sel(sel_n), .dout(do_n));
mux_4x1 mux_s (.d0(doutf_pe),.d1(doutf_n),.d2(doutf_w),.d3(doutf_e), .en(m_s), .sel(sel_s), .dout(do_s));
mux_4x1 mux_pe ( .d0(doutf_s),.d1(doutf_n),.d2(doutf_w),.d3(doutf_e), .en(m_pe), .sel(sel_pe), .dout(do_pe));
/* mux_6x1 mux_up (.d0(doutf_down),.d1(doutf_pe),.d2(doutf_s),.d3(doutf_n),.d4(doutf_w),.d5(doutf_e), .en(m_up), .sel(sel_up), .dout(do_up));
mux_6x1 mux_down (.d0(doutf_up),.d1(doutf_pe),.d2(doutf_s),.d3(doutf_n),.d4(doutf_w),.d5(doutf_e),.en(m_down), .sel(sel_down), .dout(do_down)); */
// wen for each 


//FSM -- State Assignment
always @ (posedge clk or posedge rst)
begin
	if (rst) 
	begin
	state_e <= IDLE;
	state_w <= IDLE;
	state_n <= IDLE;
	state_s <= IDLE;
	state_pe <= IDLE;
	// state_up <= IDLE;
	// state_down <= IDLE;
	end
	else 
	begin
	state_e <= next_state_e;
	state_w <= next_state_w;
	state_n <= next_state_n;
	state_s <= next_state_s;
	state_pe <= next_state_pe;
	/* state_up <= next_state_up;
	state_down <= next_state_down; */
	end
	
end

// Assigning value to registers placed before routing computation unit of each port



endmodule

////////////////////////////


