
module switchalloc (rce,rcn,rcw,rcs,rcl,clk,reset,grant_e,grant_w,grant_n,grant_s,grant_l,grnt_in_e,grnt_in_w,grnt_in_n,grnt_in_s,
					ge,gw,gn,gs,m_e,m_w,m_n,m_s,m_pe,sel_e,sel_w,sel_n,sel_s,sel_pe);

input [2:0]rce,rcn,rcw,rcs,rcl;
input clk,reset;
output [3:0]grant_e,grant_w,grant_n,grant_s,grant_l;
output [2:0] sel_e,sel_w,sel_n,sel_s,sel_pe;
output ge,gw,gn,gs,m_e,m_w,m_n,m_s,m_pe;
input grnt_in_e,grnt_in_w,grnt_in_n,grnt_in_s;
wire [2:0] sel_e,sel_w,sel_n,sel_s,sel_pe;
reg rce_w,rce_n,rce_s,rce_l;
reg rcw_e,rcw_n,rcw_s,rcw_l;
reg rcn_e,rcn_w,rcn_s,rcn_l;
reg rcs_e,rcs_w,rcs_n,rcs_l;
reg rcl_e,rcl_w,rcl_n,rcl_s;

wire [3:0]req_e,req_w,req_n,req_s,req_l;
parameter East=3'b010;
parameter West=3'b011;
parameter North=3'b100;
parameter South=3'b101;
parameter Local=3'b001;



always@(rce)
begin
	if(rce==West)
	{rce_w,rce_n,rce_s,rce_l}=4'b1000;  // EAST input port requesting for WEST output port
	else if(rce==North)
	{rce_w,rce_n,rce_s,rce_l}=4'b0100;
	else if(rce==South)
	{rce_w,rce_n,rce_s,rce_l}=4'b0010;
	else if(rce ==Local)
	{rce_w,rce_n,rce_s,rce_l}=4'b0001;
	
	else
	{rce_w,rce_n,rce_s,rce_l}=4'b0000;
	end 

always@(rcw)
begin
	if(rcw==East)
	{rcw_e,rcw_n,rcw_s,rcw_l}=4'b1000; // EAST input port requesting for WEST output port
	else if(rcw==North)
	{rcw_e,rcw_n,rcw_s,rcw_l}=4'b0100;
	else if(rcw==South)
	{rcw_e,rcw_n,rcw_s,rcw_l}=4'b0010;
	else if(rcw ==Local)
	{rcw_e,rcw_n,rcw_s,rcw_l}=4'b0001;
		else
	{rcw_e,rcw_n,rcw_s,rcw_l}=4'b0000;
	end 


always@(rcn)
begin
	if(rcn==East)
	{rcn_e,rcn_w,rcn_s,rcn_l}=4'b1000;  // EAST input port requesting for WEST output port
	else if(rcn==West)
	{rcn_e,rcn_w,rcn_s,rcn_l}=4'b0100;
	else if(rcn==South)
	{rcn_e,rcn_w,rcn_s,rcn_l}=4'b0010;
	else if(rcn ==Local)
	{rcn_e,rcn_w,rcn_s,rcn_l}=4'b0001;
	else
	{rcn_e,rcn_w,rcn_s,rcn_l}=4'b0000;
	end

always@(rcs)
begin
	if(rcs==East)
	{rcs_e,rcs_w,rcs_n,rcs_l}=4'b1000;  // EAST input port requesting for WEST output port
	else if(rcs==West)
	{rcs_e,rcs_w,rcs_n,rcs_l}=4'b0100;
	else if(rcs==North)
	{rcs_e,rcs_w,rcs_n,rcs_l}=4'b0010;
	else if(rcs ==Local)
	{rcs_e,rcs_w,rcs_n,rcs_l}=4'b0001;
	else
	{rcs_e,rcs_w,rcs_n,rcs_l}=4'b0000;
	end


always@(rcl)
begin
	if(rcl==East)
	{rcl_e,rcl_w,rcl_n,rcl_s}=4'b1000;  // EAST input port requesting for WEST output port
	else if(rcl==West)
	{rcl_e,rcl_w,rcl_n,rcl_s}=4'b0100;
	else if(rcl==North)
	{rcl_e,rcl_w,rcl_n,rcl_s}=4'b0010;
	else if(rcl ==South)
	{rcl_e,rcl_w,rcl_n,rcl_s}=4'b0001;
	
	else
	{rcl_e,rcl_w,rcl_n,rcl_s}=4'b0000;
	end

	
	

//always@(posedge clk)
//begin
assign req_e={rcw_e,rcn_e,rcs_e,rcl_e}; // Signals indicating which input ports are requesting for EAST output port
assign req_w={rce_w,rcn_w,rcs_w,rcl_w};
assign req_n={rce_n,rcw_n,rcs_n,rcl_n};
assign req_s={rce_s,rcw_s,rcn_s,rcl_s};
assign req_l={rce_l,rcw_l,rcn_l,rcs_l};

RoundRobin_arbiter r_east(req_e,grant_e,clk,reset,sel_e, m_e);// grant_e signals which input port has been granted access to EAST output port
RoundRobin_arbiter r_west(req_w,grant_w,clk,reset,sel_w, m_w);
RoundRobin_arbiter r_north(req_n,grant_n,clk,reset,sel_n, m_n);
RoundRobin_arbiter r_south(req_s,grant_s,clk,reset,sel_s, m_s);
RoundRobin_arbiter r_local(req_l,grant_l,clk,reset,sel_pe, m_pe);



assign ge=  grant_w[3]| grant_n[3]| grant_s[3]| grant_l[3] && grnt_in_e;
assign gw=  grant_e[3]| grant_n[2]| grant_s[2]| grant_l[2] && grant_in_w;
assign gn= grant_e[2]| grant_w[2]| grant_s[1]| grant_l[1] && grant_in_n;
 assign gs= grant_e[1]| grant_w[1]| grant_n[1]| grant_l[0] && grant_in_s;
 //assign gpe= grant_e[0]| grant_w[0]| grant_n[0]| grant_s[0] &&;

 /* assign m_e= grant_e[3]| grant_e[2]| grant_e[1]| grant_e[0];
assign m_w= grant_w[3]| grant_w[2]| grant_w[1]| grant_w[0];
assign m_n= grant_n[3]| grant_n[2]| grant_n[1]| grant_n[0];
assign m_s= grant_s[3]| grant_s[2]| grant_s[1]| grant_s[0];
assign m_pe= grant_pe[3]| grant_pe[2]| grant_pe[1]| grant_pe[0]; */


endmodule 