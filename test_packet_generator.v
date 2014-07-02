module test_packet_generator();
reg [39:0] packet1,packet2,packet;
integer i;
reg [21 :0] random_var1;
reg [13 : 0] random_var2;
reg [35 : 0] random_var3;

reg clk,rst;
wire [39:0] stack0,stack1,stack2,stack3,stack4,stack5,stack6,stack7;
reg [39:0] flit_in_e,
flit_in_w,
flit_in_n,
flit_in_s,
flit_in_pe;

wire [39:0] do_e,
do_w,
do_n,
do_s,
do_pe;						//data output for each port
reg req_in_e, //reqs in frm adjcent routr..
req_in_w,
req_in_s,
req_in_n,
req_in_pe,

grnt_in_e,//acknldge signal coming from  adjcent router
grnt_in_w,
grnt_in_n,
grnt_in_s,
grnt_in_pe;

wire grantfe,  // grant out from present router to its adjacent router...   
grantfw,
grantfn,
grantfs,
grantfl,

req_out_e, //reqs in frm adjcent routr..
req_out_w,
req_out_s,
req_out_n;

 router b1(  clk,
 rst,
flit_in_e,
flit_in_w,
flit_in_n,
flit_in_s,
flit_in_pe,

 // flit inputs to each port
do_e,
do_w,
do_n,
do_s,
do_pe,
//data output for each port
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


grantfe,  // grant out from present router to its adjacent router...   
grantfw,
grantfn,
grantfs,
grantfl,

req_out_e, //reqs in frm adjcent routr..
req_out_w,
req_out_s,
req_out_n


); 
  
assign stack0 = b1.ff_east.stack[0] ;
assign stack1 = b1.ff_west.stack[0] ;
assign stack2 = b1.ff_north.stack[0] ;
assign stack3 = b1.ff_south.stack[0] ;
assign stack4 = b1.ff_pe.stack[0] ;
assign stack5 = b1.ff_west.stack[1] ;
assign stack6 = b1.ff_east.stack[1] ;
assign stack7 = b1.ff_north.stack[1] ;

initial 
begin
clk=0;
rst=1;

 req_in_e = 0;
    req_in_w = 0;
	 req_in_n = 0;
	 req_in_s = 0;
	 req_in_pe = 0;
random_var1 =$random;
random_var2 =$random;
random_var3 =$random;

 #6 rst=0;
 
 #2 req_in_e = 1;
    req_in_w = 1;
	 req_in_n = 1;
	 req_in_s = 1;
	 req_in_pe = 1;
	 flit_in_e = packet;
    flit_in_w = packet1;
flit_in_s = packet1;
flit_in_n = packet2;
flit_in_pe = packet;
#10 req_in_e = 0;
    req_in_w = 0;
	 req_in_n = 0;
	 req_in_s = 0;
	 req_in_pe = 0;
#6 req_in_e = 1;
    req_in_w = 1;
	 req_in_n = 1;
	 req_in_s = 1;
	 req_in_pe = 1; 
	 flit_in_e = packet;
    flit_in_w = packet;
flit_in_s = packet;
flit_in_n = packet;
flit_in_pe = packet;

end
always
#5 clk =~clk;

initial
$monitor($time ," packet %b,packet1 %b, packet2 %b,read from stack %b%b%b%b write to stack  %b%b%b%b  state  %b%b%b%b",packet,packet1,packet2,b1.ge,b1.gw,b1.gn,b1.gs,b1.wen_e,b1.wen_w,b1.wen_n,b1.wen_s,b1.s_East.state,b1.s_West.state,b1.s_North.state,b1.s_South.state);

/*always 
begin
if(b1.state_e==3'b001)
	$display($time, " state is " , "IDLE");
else if(b1.state_e==3'b010)
	$display($time, " state is " , "RCU");
else if(b1.state_e==3'b100)
	$display($time, " state is " , "SA");
else
	$display($time, " state is " , "default");
end*/
initial 
#250 $stop;



initial
begin
 header(2,4'b0001,4'b0010,4'b0011,4'b1010);
#40 payload;

#10 tail;

end

 task header;
 input di_no,S_add_x,
  S_add_y,
  D_add_x,
 D_add_y;
//output [39:0] packet;
 integer di_no;
 reg [3:0] S_add_x,
  S_add_y,
  D_add_x,
 D_add_y;
 

begin

if(di_no == 2)
begin
       packet = { 2'b11,S_add_x,S_add_y, D_add_x, D_add_y,random_var1 };
			packet1={ 2'b11,S_add_x,S_add_y, D_add_x, D_add_y,random_var1 };
		
        packet2={2'b11,S_add_x,S_add_y, D_add_x, D_add_y,random_var1 };
		  end
		  
		/*  else if ( di_no ==3)
         packet  =  { 2'b11, S_add_x,S_add_y,S_add_z,D_add_x,D_add_y,D_add_z,random_var2 };*/
         else 
         packet ={ 2'b11 ,random_var3,2'b00};
         
         end
         endtask
 task payload;
		 begin
		 packet = { 2'b10 ,random_var3,2'b00 };
		end
		 endtask
task tail;
begin
packet = {2'b01,random_var3,2'b00};
end
endtask
//$monitor( $time ,"read from stack %b%b%b%b write to stack  %b%b%b%b",b1.ge,b1.gw,b1.gn,b1.gs,b1.wen_e,b1.wen_w,b1.wen_n,b1.wen_s); 

endmodule

