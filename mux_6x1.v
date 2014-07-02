module mux_6x1 (d0,d1,d2,d3,d4,d5, en, sel, dout);

parameter DW=40;

input en;
input [2:0] sel;
input [DW-1:0] d0,d1,d2,d3,d4,d5;
output  reg [DW-1:0] dout;

always @ (d0,d1,d2,d3,d4,d5,en,sel)

if (en) begin
case (sel)
 
3'b000: dout<=d0;
3'b001: dout<=d1;
3'b010: dout<=d2;
3'b011: dout<=d3;
3'b100: dout<=d4;  
3'b101: dout<=d5;
  default: dout<=40'bz;
 endcase
end
else begin
	dout<=40'bz;
end

endmodule
