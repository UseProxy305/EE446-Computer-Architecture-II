library verilog;
use verilog.vl_types.all;
entity ALU is
    generic(
        W               : integer := 4
    );
    port(
        A               : in     vl_logic_vector;
        B               : in     vl_logic_vector;
        ALUcntrl        : in     vl_logic_vector(2 downto 0);
        O               : out    vl_logic_vector;
        CO              : out    vl_logic;
        OVF             : out    vl_logic;
        N               : out    vl_logic;
        Z               : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of W : constant is 1;
end ALU;
