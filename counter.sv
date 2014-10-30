`ifndef DEFS_COUNTER // if the already-compiled flag is not set...
  `define DEFS_COUNTER // set the flag 
module counter (input clk, resetN,ready,
				output bit [4:0] count,
				input logic  [4:0] max_count,
				output bit overflow
				);
	
logic enable; // internal enable signal for the counter
	
always_latch begin // latch the ready input
	if (resetN)
		enable <= 0;
	else if (ready)
		enable <= 1;
end
	
always_ff @(posedge clk or negedge resetN) begin // 5-bit counter
 	if (resetN) count <= 0;
	else if (count==max_count) begin
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