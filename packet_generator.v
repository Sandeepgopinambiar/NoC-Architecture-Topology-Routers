module packet_generator(tf,flit_out,clk,rst, tr_pattern );
	parameter FW = 40;
	parameter RESET = 3'b000;
	parameter HEADER = 3'b001;
	parameter 


	input [4:0] tf;
	output [FW-1:0] flit_out;
	input clk,rst;
	input tr_pattern;

reg [2:0] state,next_state;

always@( posedge clk or negedge rst )
//begin
	if(negedge rst)
	begin
		state <= 3'd0;
	end
	else
	begin
		state<=next_sate;
	end	


always@(state or tr_pattern)	
	
case (state)
begin
	



















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