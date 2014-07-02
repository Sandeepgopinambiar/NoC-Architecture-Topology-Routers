//`timescale 1ns / 1ps
module fifo1(
data_out,// 8 -12 bit words i.e height is 8,width is 12 ,ptr for addressin is 3 bit since 8 locations r there 
data_in,
stack_empty,
stack_full,
clk,
rst,
write_to_stack,
read_from_stack
);
parameter stack_width =40;  
parameter stack_height =8;
parameter stack_ptr_width =3;
output reg [stack_width-1 : 0 ] data_out;
output stack_empty,stack_full;
input [stack_width-1 : 0 ] data_in;
input clk,rst,write_to_stack,read_from_stack;
reg [stack_width-1 : 0] stack [stack_height-1 :0]; //memory ..
reg [stack_ptr_width : 0] ptr_diff;
reg [stack_ptr_width-1 : 0] read_ptr,write_ptr;
assign stack_empty =(ptr_diff==0) ? 1'b1 : 1'b0 ;
assign stack_full =(ptr_diff==stack_height) ? 1'b1 : 1'b0 ;


always @(posedge clk ,posedge rst)
begin: data_transfer
if(rst)
data_out <=0;
else if((read_from_stack)&&(!stack_empty)&&(!write_to_stack))
data_out <= stack[read_ptr];
else if ((write_to_stack)&&(!stack_full)&&(!read_from_stack))
stack[write_ptr]<= data_in;
end

always @(posedge clk ,posedge rst)
begin
if(rst)
begin
read_ptr <= 3'b000;
write_ptr <= 3'b000;
ptr_diff  <= 4'b0000;
end

else if ((write_to_stack)&&(!stack_full)&&(!read_from_stack))
begin 
write_ptr<= write_ptr + 1;
ptr_diff <= ptr_diff +1;
end

else if((read_from_stack)&&(!stack_empty)&&(!write_to_stack))
begin
read_ptr <= read_ptr +1;
ptr_diff <= ptr_diff -1;
end

end
endmodule
