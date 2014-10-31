//****************************************************************
//                  The main module
//****************************************************************
`include "counter.sv"

module srializer(input bit clk_i, rst_i, data_val_i, 
            input bit [15:0] data_i,
            input bit [4:0] data_mod_i ,
            output bit ser_data_o, ser_data_val_o,
            output bit  busy_o
            );


bit [4:0] count;
bit overflow, counter_disable;


counter counter_inst(clk_i, rst_i, data_val_i, count, data_mod_i, overflow, counter_disable);


always_comb begin
	busy_o = overflow;
end

always_comb begin
    if ((data_mod_i-1)<3) begin
       ser_data_o = 0;
       ser_data_val_o = 0;
       counter_disable = 1; 
    end
    else
    if (!overflow || !count)
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


logic clk_i, rst_i, data_val_i = 1; 
logic [15:0] data_i = 16'b1010101010101010;
logic [4:0] data_mod_i = 5'b00110;
logic ser_data_o, ser_data_val_o;
bit busy_o;  

  srializer DUT  (.* , .rst_i(1'b0));

initial begin clk_i = 1'b0;
forever #50  clk_i = !clk_i;
end

endmodule
