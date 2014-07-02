module rcu_mod(clk_t, rst_t, flit, state, op);
parameter FW= 39;
parameter X=4'b0010, Y=4'b0001;
parameter LOCAL= 3'b001;
parameter EAST = 3'b010;
parameter WEST = 3'b011;
parameter NORTH= 3'b100;
parameter SOUTH= 3'b101;

//parameter d=2'b11;
input clk_t, rst_t;
input [FW:0] flit;
input [2:0] state;
output [2:0] op; //output port
reg [2:0] op;
reg [2:0] os;

always @ (posedge clk_t )

if (rst_t) begin
	op <= 3'b000;
	end
else if ( (flit[FW]&flit[FW-1]) && state[1]) 	// header=11, body=10, tail=01
	begin
	 if 		(flit[FW-10:FW-13]==X && flit[FW-14:FW-17]==Y) op<=LOCAL;
	else if (flit[FW-10:FW-13]==X && flit[FW-14:FW-17]!=Y) 
	begin
	   os=X-flit[FW-10:FW-13];
	   if(os==1) op<=SOUTH;
	   else if(os==-1)op<=NORTH;
	   else if(os==-3)op<=SOUTH;
	   else if(os==3)op<=NORTH;
	   else op<=NORTH;
	 end
	   
	else 
	begin
	   os=X-flit[FW-14:FW-17];
	   if(os==1) op<=EAST;
	   else if(os==-1)op<=WEST;
	   else if(os==-3)op<=WEST;
	   else if(os==3)op<=EAST;
	   else op<=EAST;
	 end	
	end
endmodule
