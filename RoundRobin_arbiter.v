	module RoundRobin_arbiter(req,grant,clk,rst,sel,m);
input [3:0]req;
output reg [3:0]grant;
input clk;
reg [2:0] state_rr;
reg [2:0] next_state_rr;
input rst;
output reg [2:0] sel;
output m;
//assign p_counter=p_counter+1'b1;
always@(posedge clk or posedge rst )
 
if(rst )
begin

state_rr <= 3'b000;
end
else 
state_rr <= next_state_rr;
always@(state_rr or req or grant)
 begin
	next_state_rr =3'b000;
	case(state_rr)
		3'b000:
				begin
					if(req[0])
						begin
							grant[3:0]=4'b0001;// local
							next_state_rr = 3'b001;
						end
					else if(req[1])
						begin
							grant[3:0]=4'b0010; //south
							next_state_rr = 3'b010;
						end
					else if(req[2])
begin
grant[3:0]=4'b0100; //north
next_state_rr = 3'b011;
end
else if(req[3])
begin
grant[3:0]=4'b1000;// west
next_state_rr = 3'b100;
end

else
begin
 grant[3:0] =4'b0000; 
next_state_rr = 3'b000;
end
end
3'b001:
begin
if(req[1])
begin
grant[3:0]=4'b0010;
next_state_rr = 3'b010;
end
else if(req[2])
begin
grant[3:0]=4'b0100;
next_state_rr = 3'b011;
end
else if(req[3])
begin
grant[3:0]=4'b1000;
next_state_rr = 3'b100;
end

else if (req[0])
begin
grant[3:0]=4'b0001;
next_state_rr = 3'b001;
end
else
begin
grant[3:0] =4'b0000; 
next_state_rr = 3'b000;
end
end


3'b010:
begin
if(req[2])
begin
grant[3:0]=4'b0100;
next_state_rr = 3'b011;
end
else if(req[3])
begin
grant[3:0]=4'b1000;
next_state_rr = 3'b100;
end

else if(req[0])
begin
grant[3:0]=4'b0001;
next_state_rr = 3'b001;
end
else if(req[1])

begin
grant[3:0]=4'b0010;
next_state_rr = 3'b010;
end
else
begin
grant[3:0]=4'b0000; 
next_state_rr = 3'b000;
end
end

3'b011:
begin
if(req[3])
begin
grant[3:0]=4'b1000;
next_state_rr = 3'b100;
end

else if(req[0])
begin
grant[3:0]=4'b0001;
next_state_rr = 3'b001;
end
else if(req[1])
begin
grant[3:0]=4'b0010;
next_state_rr = 3'b010;
end
else if(req[2])
begin
grant[3:0]=4'b0100;
next_state_rr = 3'b011;

end
else
begin
grant[3:0]=4'b0000; 
next_state_rr = 3'b000;
end
end


3'b100:
begin

if(req[0])
begin
grant[3:0]=4'b0001;
next_state_rr = 3'b001;
end
else if(req[1])
begin
grant[3:0]=4'b0010;
next_state_rr = 3'b010;
end
else if(req[2])
begin
grant[3:0]=4'b0100;
next_state_rr = 3'b011;
end
else if(req[3])
begin
grant[3:0]=4'b1000;
next_state_rr = 3'b100;
end

else
begin
grant[3:0]=4'b0000; 
next_state_rr = 3'b000;
end
end

3'b101:
begin
if(req[0])
begin
grant[3:0]=4'b0001;
next_state_rr = 3'b001;

end
else if(req[1])
begin
grant[3:0]=4'b0010;

next_state_rr = 3'b010;
end
else if(req[2])
begin
grant[3:0]=4'b0100;
next_state_rr = 3'b011;
end
else if(req[3])
begin
grant[3:0]=4'b1000;
next_state_rr = 3'b100;
end


else
begin
grant[3:0]=4'b0000; 
next_state_rr = 3'b100;
end
end

default :begin
grant[3:0] = 4'b0000;
next_state_rr = 3'b000;
end

endcase




if (grant==4'b0001)
	sel<=3'b000; //up  for east sel ; 
else if (grant==4'b0010)
	sel<=3'b001; //down
else if (grant==4'b0100)
	sel<=3'b010; //local
else if (grant==4'b1000)
	sel<=3'b011; //south




	else sel<=3'bz;
	
end




assign m = grant[3]|grant[2]|grant[1]|grant[0];

endmodule 
