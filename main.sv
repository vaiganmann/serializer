//****************************************************************
//                  The main module
//****************************************************************
module main(input logic clk_i, rst_i, data_val_i, 
            logic [15:0] data_i,
            logic [4:0] data_mod_i ,
            output logic ser_data_o, ser_data_val_o,
            output bit  busy_o
            );


logic [4:0] count = 5'b0, count_mod_i  = 5'b0;
logic data_val_i_set = 0;
//assign busy_o = 0;
 
always_ff @(posedge data_val_i) begin
    data_val_i_set = 1;
    busy_o = 1;
    count_mod_i = data_mod_i;
end

always_ff @(posedge clk_i or posedge rst_i) begin

  if(rst_i)
    begin
      ser_data_o = 0;
      busy_o = 0;
      ser_data_val_o = 0;
    end
  else
  begin  
    if ((count_mod_i > 0) && (data_val_i_set))
       begin
          ser_data_o = data_i[15 - count];
          ser_data_val_o = 1; 
         	busy_o = 1;
          count_mod_i <= count_mod_i - 1;
          count <= count + 1;
       end
    else
      begin  
      //count_mod_i = data_mod_i + 1;
       count = 0;
       ser_data_o = 0;
       ser_data_val_o = 0;
       busy_o = 0;
    end
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

  main DUT  (.* , .rst_i(1'b0));


always_ff @(posedge clk_i) begin
  if (!busy_o) data_val_i = 1;
    else if (data_val_i) data_val_i = 0;   
end


initial begin clk_i = 1'b0;
forever #50  clk_i = !clk_i;
end

endmodule