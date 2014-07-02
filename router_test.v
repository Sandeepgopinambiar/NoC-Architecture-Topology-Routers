module router_test (clk,
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
					
	grantfe,	// grant out from present router to its adjacent router...   
	grantfw,	// req_in + header is sent 
	grantfn,	// chks header n fifo full at the neighboring router then sends grantfe frm it, which is taken in by grnat_in_x 
			// body flits are sent , then when tail is received by the ajaent router , it pulls down grnt_fe
	grantfs,
	grantfl,

	req_out_e, //reqs in frm adjcent routr..
	req_out_w,
	req_out_s,
	req_out_n
