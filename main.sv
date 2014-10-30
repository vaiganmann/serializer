//****************************************************************
//                  The main module
//****************************************************************
`include "counter.sv"

module srializer(input logic clk_i, rst_i, data_val_i, 
            input logic [15:0] data_i,
            input logic [4:0] data_mod_i ,
            output logic ser_data_o, ser_data_val_o,
            output bit  busy_o
            );


bit [4:0] count;
bit overflow;

counter counter_inst(clk_i, rst_i, data_val_i, count, data_mod_i, overflow);

always_comb begin
	busy_o = overflow;
end

always_comb begin
    if (overflow == 0)
       begin
          ser_data_o = data_i[15 - count];
          ser_data_val_o = 1; 
       end
    else
      begin  
       ser_data_o = 0;
       ser_data_val_o = 0;
      end
	end
		
	
endmodule



//****************************************************************
//                  The testbench
//****************************************************************

module testbench;


logic clk_i, rst_i, data_val_i = 0; 
logic [15:0] data_i = 16'b1010101010101010;
logic [4:0] data_mod_i = 5'b00100;
logic ser_data_o, ser_data_val_o;
bit busy_o;  

  srializer DUT  (.* , .rst_i(1'b0));


always_ff @(posedge clk_i) begin
  if (!busy_o) data_val_i = 1;
    else if (data_val_i) data_val_i = 0;   
end


initial begin clk_i = 1'b0;
forever #50  clk_i = !clk_i;
end

endmodule
