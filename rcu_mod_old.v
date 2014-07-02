 module rcu_mod (clk_t, rst_t, flit, state, op);
parameter FW= 39;
parameter X=4'b0000, Y=4'b0000;
parameter LOCAL= 3'b001;
parameter EAST = 3'b010;
parameter WEST = 3'b011;
parameter NORTH= 3'b100;
parameter SOUTH= 3'b101;
/* parameter UP= 3'b110;
parameter DOWN= 3'b111; */
//parameter d=2'b11;
input clk_t, rst_t;
input [FW:0] flit;
input [2:0] state;
output [2:0] op; //output port
reg [2:0] op;

always@(posedge clk_t )

if (rst_t) begin
	op <= 3'b000;
	end
else if ( (flit[FW]&flit[FW-1]) && state[1]) 	// header=11, body=10, tail=01
	begin
	 if 		(flit[FW-14:FW-17]>X) op<=EAST;
	else if (flit[ FW-14:FW-17 ]<X)  op<=WEST;
	else if (flit[ FW-14:FW-17 ]==X && flit[FW-18:FW-21]> Y ) op <= NORTH;
	else if (flit[ FW-14:FW-17 ]==X && flit[FW-18:FW-21]< Y ) op <= SOUTH;
	else if (flit[ FW-14:FW-17 ]==X && flit[FW-18:FW-21]==Y  ) op <= LOCAL;
	/* else if (flit[ FW-14:FW-17 ]==X && flit[FW-18:FW-21]==Y && flit[FW-18:FW-25] > Z ) op <= UP;
	else if (flit[ FW-14:FW-17 ]==X && flit[FW-18:FW-21]==Y && flit[FW-18:FW-25] < Z ) op <= DOWN;	 */
	else op<=op;
	end
	
endmodule
