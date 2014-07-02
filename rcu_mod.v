`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:02:01 09/13/2013 
// Design Name: 
// Module Name:    rcu_mod_torus 
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
module rcu_mod_1 (clk_t, rst_t, flit, state, op);

parameter FW= 39;
parameter X=4'b0010, Y=4'b0001, Z =4'b0011;
parameter LOCAL= 3'b001;
parameter EAST = 3'b010;
parameter WEST = 3'b011;
parameter NORTH= 3'b100;
parameter SOUTH= 3'b101;
parameter UP= 3'b110;
parameter DOWN= 3'b111;
parameter n = 3'b011;
parameter d = 3'b011;
input clk_t, rst_t;
input [FW:0] flit;
input [2:0] state;
output [2:0] op; //output port
reg [2:0] op;
wire [2:0] mod_x_offset,mod_y_offset;
wire [2:0] x_offset,y_offset,x_current,y_current;
assign mod_x_offset = x_offset[0]  ?-x_offset:x_offset;
assign mod_y_offset = y_offset[0] ? -y_offset:y_offset;
assign x_offset=flit[FW]&flit[FW-1]-X;

assign y_offset=flit[FW]&flit[FW-1]-Y;

always @ (posedge clk_t )
begin
if (rst_t) 
	begin
	op <= 3'b000;
	end

else if  ( (flit[FW]&flit[FW-1]) && state[1])
begin


 if  (mod_x_offset < d/2 && x_offset != 0 )  
	begin
	if (x_offset > 0)

			 op <= WEST;

         else 

			 op<=EAST;
	
	end
else if(mod_x_offset >= d/2  )  
	begin
	if (x_offset > 0)

			 op <= EAST;

         else 

			 op<=WEST;
	
	end
else if  (mod_y_offset < d/2 && y_offset != 0 )  
	begin
	if (y_offset > 0)

			 op <= NORTH;

         else 

			 op<=SOUTH;
	
	end
else if(mod_y_offset >= d/2  )  
	begin
	if (x_offset > 0)

			 op <= SOUTH;

         else 

			 op<=NORTH;
	
	end
else
	op <= LOCAL;		

       


end
else
op<= 3'b000;
end
endmodule 

