library verilog;
use verilog.vl_types.all;
entity decoder is
    port(
        I               : in     vl_logic_vector(1 downto 0);
        O               : out    vl_logic_vector(3 downto 0)
    );
end decoder;
