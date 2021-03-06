`ifndef DEFS_COUNTER // if the already-compiled flag is not set...
  `define DEFS_COUNTER // set the flag 
module counter (input bit clk, resetN,ready,
				output bit [4:0] count,
				input bit  [4:0] max_count,
				output bit overflow,
				input bit counter_disable
				);
	
logic enable; // internal enable signal for the counter

always_comb begin // latch the ready input
	if (resetN)
		enable = 0;
	else if (ready && !counter_disable)
		enable = 1;
		else enable = 0;
end
	
always_ff @(posedge clk or posedge resetN) begin // 5-bit counter
	if (resetN) begin
	 count <= 0;
	 overflow <= 0;
	end
	else if ((count==max_count-1) && enable) begin
		overflow <= 1;
		count <= 0;
	end 
	else if(enable) begin
		count <= count + 1;
		overflow <= 0;
	end
end


endmodule
`endif
