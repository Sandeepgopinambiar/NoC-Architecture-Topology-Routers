module test_packet_sim();
reg [39:0] packet1,packet2,packet,packet3,packet4,packet5,packet6;
integer i;
reg [13 :0] random_var1;
reg [17 : 0] random_var2;
reg [35 : 0] random_var3;
reg [21:0] random_var4;
wire ge,gw,gs,gn,gpe;
reg clk,rst;
wire [39:0] stack_e_1,stack_w_1,stack_n_1,stack_s_1,stack_pe_1,stack_up_1,stack_down_1,stack_e_2,stack_w_2,stack_n_2,stack_s_2,stack_pe_2,stack_up_2,stack_down_2,
            stack_e_3,stack_w_3,stack_n_3,stack_s_3,stack_pe_3,stack_up_3,stack_down_3;
//wire wen_s,wen_n,wen_e,wen_w,wen_pe,fe,fn,fs,fpe,fw,ee,ew,es,en,epe;
wire [39:0] doutf_e,doutf_w,doutf_n,doutf_s,doutf_pe;
 wire [2:0] sel_e,sel_w,sel_n,sel_s,sel_pe;
wire [2:0] op_e,op_w,op_n,op_s,op_pe;

 wire [5:0] grante,
grantw,
grantn,
grants,                                // final123
grantl ;
 wire [5:0]req_e,req_w,req_n,req_s,req_l;

wire m_e,m_w,m_n,m_s,m_pe;
reg [39:0] flit_in_e,
flit_in_w,
flit_in_n,
flit_in_s,
flit_in_pe;// flit inputs to each port
wire [39:0] do_e,
do_w,
do_n,
do_s,
do_pe	;						//data output for each port
reg req_in_e, //reqs in frm adjcent routr..
req_in_w,
req_in_s,
req_in_n,
req_in_pe,
grnt_in_e,//acknldge signal coming from  adjcent router
grnt_in_w,
grnt_in_n,
grnt_in_s,
grnt_in_pe ;						
wire grantfe,  // grant out from present router to its adjacent router...   
grantfw,
grantfn,
grantfs,
grantfl,

req_out_e, //reqs in frm adjcent routr..
req_out_w,
req_out_s,
req_out_n,
req_out_pe ;
wire [2:0]state_e,state_w,state_n,state_s,state_pe;
wire [2:0] p_counter_e,p_counter_w,p_counter_n,p_counter_s,p_counter_pe;
router b1(clk,
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
 
assign p_counter_e = b1.sa.r_east.state_rr;
assign p_counter_w = b1.sa.r_west.state_rr;
assign p_counter_pe = b1.sa.r_north.state_rr;
assign p_counter_n = b1.sa.r_south.state_rr;
assign p_counter_s= b1.sa.r_local.state_rr;

 
assign stack_e_1 = b1.ff_east.stack[0] ;
assign stack_w_1 = b1.ff_west.stack[0] ;
assign stack_n_1= b1.ff_north.stack[0] ;
assign stack_s_1 = b1.ff_south.stack[0] ;
assign stack_pe_1 = b1.ff_pe.stack[0] ;
assign stack_e_2= b1.ff_east.stack[1] ;
assign stack_w_2 = b1.ff_west.stack[1] ;
assign stack_n_2= b1.ff_north.stack[1] ;
assign stack_s_2 = b1.ff_north.stack[1] ;

assign stack_pe_2 = b1.ff_pe.stack[1] ;
assign stack_e_3 = b1.ff_east.stack[2] ;
assign stack_w_3 = b1.ff_west.stack[2] ;
assign stack_n_3 = b1.ff_north.stack[2] ;
assign stack_s_3 = b1.ff_south.stack[2] ;
assign stack_pe_3= b1.ff_pe.stack[2] ;
assign stack_e_4= b1.ff_east.stack[3] ;
assign stack_w_4= b1.ff_west.stack[3] ;
assign stack_n_4 = b1.ff_north.stack[3] ;
assign stack_s_4= b1.ff_south.stack[3] ;
assign stack_pe_4= b1.ff_pe.stack[3] ;
assign stack_e_5 = b1.ff_east.stack[4] ;
assign sel_e = b1.sel_e;
assign sel_w = b1.sel_w;
assign sel_n = b1.sel_n;
assign sel_s = b1.sel_s;
assign sel_pe = b1.sel_pe;


assign m_e = b1.m_e;
assign m_w = b1.m_w;
assign m_n = b1.m_n;
assign m_s = b1.m_s;
assign m_pe = b1.m_pe;

assign op_e = b1.op_e;
assign op_w = b1.op_w;
assign op_n = b1.op_n;
assign op_s = b1.op_s;
assign op_pe = b1.op_pe;

assign ge =b1.ge;
assign gw =b1.gw;
assign gn =b1.gn;
assign gs =b1.gs;
assign gpe =b1.gpe;

assign grante =b1.grante;
assign grantw =b1.grantw;
assign grantn =b1.grantn;
assign grants =b1.grants;
assign grantl =b1.grantl;

assign doutf_pe = b1.doutf_pe;
assign doutf_s = b1.doutf_s;
assign doutf_n = b1.doutf_n;
assign doutf_e = b1.doutf_e;
assign doutf_w = b1.doutf_w;


assign req_e =b1.sa.req_e;
assign req_w =b1.sa.req_w;
assign req_s =b1.sa.req_s;
assign req_n =b1.sa.req_n;
assign req_l=b1.sa.req_l;


assign state_e =b1.state_e;
assign state_w =b1.state_w;
assign state_n =b1.state_n;
assign state_s =b1.state_s;
assign state_pe =b1.state_pe;

initial 
begin
clk=0;
rst=1;

random_var1 =$random;
random_var2 =$random;
random_var3 =$random;
random_var4=$random;
 
 #6 rst=0;
 
  req_in_e = 1;
    req_in_w = 1;
	 req_in_n = 1;
	 req_in_s = 1;
	 req_in_pe = 1;

	 flit_in_e = packet3;//down
    flit_in_w = packet;//east
flit_in_s = packet;//east
flit_in_n = packet3;//down
flit_in_pe = packet;//east



end
always
#5 clk =~clk;

initial
$monitor( $time ," req %b %b %b %b %b \n read from stack %b %b %b %b %b   \n write to stack  %b %b %b %b %b state  %b %b %b %b 
                 \n op_e %b %b %b  %b %b  flit_r %h %h %h %h %h data %h %h %h %h %h \n sel %b %b %b %b %b  ", b1.sa.req_e,b1.sa.req_w,
                b1.sa.req_n,b1.sa.req_s,b1.sa.req_l,b1.ge,b1.gw,b1.gn,b1.gs,b1.gpe,b1.wen_e,b1.wen_w,b1.wen_n,b1.wen_s,b1.wen_pe,
                b1.s_East.state,b1.s_West.state,b1.s_North.state, b1.s_South.state,b1.r_e.op,b1.r_w.op,b1.r_n.op,b1.op_s,
                b1.op_pe,b1.flit_r_e,b1.flit_r_w,b1.flit_r_n,b1.flit_r_s,b1.flit_r_pe,b1.do_e,b1.do_w,b1.do_n, b1.do_s,b1.do_pe,
                b1.sel_e,b1.sel_w,b1.sel_n,b1.sel_s,b1.sel_pe);


initial 
#500 $stop;



initial
begin
 header(packet,packet1,packet2,packet3,packet4,packet5,packet6,2,4'b0000,4'b0000,4'b0000,4'b1010,4'b0001,4'b0100);
#23 payload(packet,packet1,packet2,packet3);
#1 flit_in_e = packet;       
    flit_in_w = packet;   
flit_in_s = packet;			
flit_in_n = packet1;			
flit_in_pe = packet2;			
		
	 

#10 tail(packet);flit_in_e = packet;		
    flit_in_w = packet;			
flit_in_s = packet;				
flit_in_n = packet;			
flit_in_pe = packet;			



end

 task header;
   output [39:0] packet,packet1,packet2,packet3,packet4,packet5,packet6; 
 input integer di_no;
 input [3:0] S_add_x,
  S_add_y,
  S_add_z,
  D_add_x,
 D_add_y,
 D_add_z;

 

begin

if(di_no == 3)
begin
       packet = { 2'b11,S_add_x,S_add_y,S_add_z,D_add_x, D_add_y,4'b0011,random_var1 };   //east   x-6 ,y-1,z-4
			
			packet1={ 2'b11,S_add_x,S_add_y,S_add_z,4'b0001, D_add_y,4'b0100,random_var1 };  //west  x-1 ,y-1,z-4
		  
		  packet2={ 2'b11,S_add_x,S_add_y,S_add_z,4'b0010,4'b0001,4'b0100,random_var1 };   //up    x-2,y-1,z-4
    
     packet3={2'b11,S_add_x,S_add_y,S_add_z,4'b0010, 4'b0001,4'b0001,random_var1 };     //down   x-2,y-1 ,z-1
    
       packet4={2'b11,S_add_x,S_add_y,S_add_z,4'b0010, 4'b0010,4'b0001,random_var1 };     // north   
    
        packet5={2'b11,S_add_x,S_add_y,S_add_z,4'b0010, 4'b0000,4'b0001,random_var1 };    //south
        
         packet6={2'b11,S_add_x,S_add_y,S_add_z,4'b0010, 4'b0001,4'b0011,random_var1 };     //local
		  end
	else if(di_no==2)
	begin
	    
       packet = { 2'b11,S_add_x,S_add_y,4'b0010, D_add_y,random_var4 };   //east   x-6 ,y-1,z-4
			
			packet1={ 2'b11,S_add_x,S_add_y,4'b0001, D_add_y,random_var4 };  //west  x-1 ,y-1,z-4
		  
		  packet2={ 2'b11,S_add_x,S_add_y,4'b0011, D_add_y,random_var4 };   //up    x-2,y-1,z-4
    
     packet3={ 2'b11,S_add_x,S_add_y,D_add_x, 4'b1000,random_var4 };     //down   x-2,y-1 ,z-1
    
       packet4={ 2'b11,S_add_x,S_add_y,D_add_x, 4'b0010,random_var4 };   // north   
    
        packet5={ 2'b11,S_add_x,S_add_y,D_add_x, 4'b0101,random_var4 };    //south
        
         packet6={ 2'b11,S_add_x,S_add_y,D_add_x, 4'b0111,random_var4 };  
    end
		  else 
         packet ={ 2'b11 ,random_var3,2'b00};
         end
         endtask
 task payload;
   output reg [39:0] packet,packet1,packet2,packet3;
   		 begin
		 packet = { 2'b10 ,random_var3,2'b00 };
		 packet1 ={ 2'b10 ,random_var2,12'd1024,8'b00 };
		 packet2 ={2'b10 ,random_var2,12'd512,8'b00 };
		 packet3={2'b10 ,random_var2,12'd512,8'b00 };
		end
		 endtask
task tail;
   output reg [39:0] packet;
begin

packet = { 2'b01,random_var3,2'b00 };
end
endtask
endmodule


