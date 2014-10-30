library verilog;
use verilog.vl_types.all;
entity srializer is
    port(
        clk_i           : in     vl_logic;
        rst_i           : in     vl_logic;
        data_val_i      : in     vl_logic;
        data_i          : in     vl_logic_vector(15 downto 0);
        data_mod_i      : in     vl_logic_vector(4 downto 0);
        ser_data_o      : out    vl_logic;
        ser_data_val_o  : out    vl_logic;
        busy_o          : out    vl_logic
    );
end srializer;
