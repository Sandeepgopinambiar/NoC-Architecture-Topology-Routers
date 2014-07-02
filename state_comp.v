module state_comp( state,flit,next_state,full,w_en,flit_rcu,read);

parameter IDLE=3'b001;
parameter RCU=3'b010;
parameter SA =3'b100;
parameter FW=40;
parameter tf= 4'd4;
input read;
input [2:0] state;
output reg [2:0] next_state;
input full;
output reg w_en;
output reg [ FW-1 : 0 ] flit_rcu;
input [FW-1:0] flit;


/* 1st cycle:flit comes in with req_in , it gets its header checked and then state is turned to RCU, header is written in fifo ( 2nd cycle).
2nd cycle : header written , o/p port selected , next state is SA , if any flit comes in , data is written in next cycle 
3rd cycle : arbitration done , read signal is given out , hence next cycle , data is sent out . 


In SA mode read signal is given out , if data is n't written into next router, then that flit vanishes ( not taken ). So a mechanism to
stop the read ( i.e read only if the o/p is free).
"s_read" is the signal to stop the read . So, it depends on the grant_in signal .If grant_in is 1, it decreases the count of tf,(i.e how 
many flits are read out ). If grant_in becomes 0 , then s_read is made 1 , denoting that the adjacent router has not allowed the flit to get
in so no read is to be done w_en is possible ( if tail flit has not come yet )
*/



always @ (state or  flit or full) 
begin
case (state)
	IDLE : 	if (flit[FW-1]&&flit[FW-2]&& (full!=1))
				begin
					next_state<=RCU;
					flit_rcu<= flit;
									
					w_en<=1;
					
				end
				else
				begin 
				next_state<=IDLE;
				w_en<=0;
				end
	RCU : 	if ( fe!=1)
			begin
			w_en<=1;
			end
			else
			w_en<=0;

			next_state<=SA;
	
	SA :	//if((flit[FW-1]==1)&& (flit[FW-2]==0)&& ~full)
			//begin
				if(tf==4'd0)
					next_state<= IDLE
				else if(!read)
					begin
						w_en<=1;
						next_state <= SA;
					end
				else
					begin
						w_en<=0;
						tf=tf-1;
						next_state <=SA;
					end
			//end
			//else if((flit[FW-1]==0)&& (flit[FW-2]==1)&& ~full)
			//	if(!read)
			//	w_en<=1;
			//	else
			//	w_en<=0;

default : next_state=IDLE;
endcase
end
	


endmodule
 /////////////////////////////////////////
