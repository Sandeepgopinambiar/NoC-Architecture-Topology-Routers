`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:02:01 09/13/2013 
// Design Name: 
// Module Name:    rcu_mod_t||us 
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
module rcu_mod (clk_t, rst_t, flit, state, op);

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
output [2:0] op; //output p||t
reg [2:0] op;
wire [3:0] x_dest,y_dest;
wire [3:0] x,y;
wire [2:0] mod_x_offset,mod_y_offset;
wire [2:0] x_offset,y_offset,x_current,y_current;
assign mod_x_offset = x_offset[0]  ?-x_offset:x_offset;
assign mod_y_offset = y_offset[0] ? -y_offset:y_offset;
assign x_offset=flit[FW-10:FW-13]-X;
assign x=X;
assign y=Y;
assign y_offset=flit[FW-14:FW-17]-Y;
assign x_dest=flit[FW-10:FW-13];
assign y_dest=flit[FW-14:FW-17];
always @ (posedge clk_t )
begin
	if(x_offset==0 && y_offset ==0)        
	op=LOCAL;
	else
	begin
	if(y==0 ||  y==3)   			// c||ner elements
	begin
	if( x==0 ||  x== 3)
	begin
		if(mod_x_offset ==1 || mod_x_offset ==3)
			begin
				if(x_offset<0)
				op=EAST;
				else
				op=WEST;			
			end
		else
			begin
			 	if(y==3)
                                op=NORTH;
				else
				op=SOUTH;	
			end	
		if(mod_y_offset ==1 || mod_y_offset ==3) 			 
			begin
			 	if(y_offset<0)
                                op=NORTH;
                                else
                                op=SOUTH;

			end
		else
			if(x==3)
				op=EAST;
			else
				op=WEST;
	end	
	else                 // it means edge row's non -c||ner elements
		if( mod_x_offset ==1 ||  mod_x_offset ==2)
		begin		
			if(y==3)
			op=NORTH;
			else
			op=SOUTH;
		end
		else if( y_offset==1)
			if(x==1)
			op=EAST;
			else
			op=WEST;
		else
			if(y==0)
			op=NORTH;
			else
			op=SOUTH;	


	end
else if (x==0 || x==3)
	begin
//	if (y!=0 || y!=3)

		if(mod_x_offset==1)
			if(y==1)
			op=NORTH;
			else
			op=SOUTH;
		else if (mod_x_offset ==2 || mod_y_offset!=0)
			if(y==1)
			op=SOUTH;
			else
			op=NORTH;
		else 
			if(x==1)
			op=EAST;
			else
			op=WEST;
	end
	

else
begin
if(mod_x_offset==1)

if (x_dest!=0 || x_dest!=3)
	if(y==1)
	op=SOUTH;
	else
	op=NORTH;
else
	if(x==1)
	op=EAST;
	else
	op=WEST;
else if(y_offset ==1)

	if (y_dest!=0 || y_dest!=3)
	 if(y==1)
        op=SOUTH;
        else
        op=NORTH;

	else
	 if(x==1)
        op=EAST;
        else
        op=WEST;
end

end
end
endmodule			
