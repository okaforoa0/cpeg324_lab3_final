----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2025 04:04:57 PM
-- Design Name: 
-- Module Name: top_324 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_324 is
  Port (clk : in std_logic;
        reset : in std_logic;
        instruction : in std_logic_vector(7 downto 0);
        output0: out std_logic_vector(3 downto 0);
        output1: out std_logic_vector(3 downto 0);
        output2: out std_logic_vector(3 downto 0);
        output3: out std_logic_vector(3 downto 0)
        );
end top_324;

architecture Behavioral of top_324 is

component pc
    port(  clk : in std_logic;
           reset : in std_logic;
           skip : in std_logic;
           pc_out : out std_logic_vector(7 downto 0)
    );
end component;

component reg_324
    Port (rs: in std_logic_vector(1 downto 0);
        rt: in std_logic_vector(1 downto 0);
        rd: in std_logic_vector(1 downto 0);
        write_data: in std_logic_vector(15 downto 0);
        write_control: in std_logic;
        clk: in std_logic;
        reset: in std_logic;
        rs_out: out std_logic_vector(15 downto 0);
        rt_out: out std_logic_vector(15 downto 0);
        rd_out: out std_logic_vector(15 downto 0) 
        );
end component;

component sign_extend4to16 
    port (
        input_4bit  : in std_logic_vector(3 downto 0);
        output_16bit : out std_logic_vector(15 downto 0)
    );
end component;

component main_alu 
    Port ( 
        A       : in  std_logic_vector(15 downto 0);
        B       : in  std_logic_vector(15 downto 0);
        clk     : in  std_logic;
        control : in  std_logic_vector(1 downto 0);
        result  : out std_logic_vector(15 downto 0)
    );
end component;

component control_324 
  Port (op: in std_logic_vector(1 downto 0);
        control: in std_logic;
        ALU_result: in std_logic_vector(15 downto 0);
        clk: in std_logic;
        AlU_op: out std_logic_vector(1 downto 0);
        A_mux: out std_logic;
        B_mux: out std_logic;
        print_control:out std_logic;
        skip_control: out std_logic;
        write_control: out std_logic
  );
end component;

component mux_324 
  Port (A: in std_logic_vector(15 downto 0);
        B: in std_logic_vector(15 downto 0);
        sel: in std_logic;
        output: out std_logic_vector(15 downto 0));
end component;

component print_module
    port (
        data_in      : in std_logic_vector(15 downto 0);
        print_enable : in std_logic;
        digits_out   : out std_logic_vector(15 downto 0)
    );
end component;

--internal signals 
signal inst_int: std_logic_vector(7 downto 0) := (others => '0');  
signal address_int: std_logic_vector(7 downto 0);
signal rs_int, rt_int, rd_int, imm_int, muxA_int, muxB_int, alu_res_int, digit_int: std_logic_vector(15 downto 0);
signal alu_op_int: std_logic_vector(1 downto 0); 
signal Amux_cont_int, Bmux_cont_int, print_cont_int, skip_cont_int, write_cont_int: std_logic;


begin
process (clk)
begin
    if rising_edge(clk) then
        inst_int <= instruction;
    end if;
end process;

           

--inst_int <= instruction;     


register_file: reg_324 port map(rs => inst_int(5 downto 4), rt => inst_int(3 downto 2), rd => inst_int(1 downto 0), write_data => alu_res_int, write_control => write_cont_int, clk => clk, reset => reset, rs_out => rs_int, rt_out => rt_int, rd_out => rd_int);
PC_module: pc port map(clk => clk, reset => reset, skip => skip_cont_int, pc_out => address_int); 
sign_extend_module: sign_extend4to16 port map(input_4bit => inst_int(5 downto 2), output_16bit => imm_int);


ALU_module: main_alu port map(A => muxA_int, B => muxB_int, clk => clk, control => alu_op_int, result => alu_res_int); 
control_module: control_324 port map(op => inst_int(7 downto 6), control => inst_int(3), ALU_result => alu_res_int, clk => clk, ALU_op => alu_op_int, A_mux => Amux_cont_int, B_mux => Bmux_cont_int, print_control => print_cont_int, skip_control => skip_cont_int, write_control => write_cont_int); 

muxA: mux_324 port map(A => rs_int, B => imm_int, sel => Amux_cont_int, output => muxA_int);
muxB: mux_324 port map(A => rt_int, B => rd_int, sel => Bmux_cont_int, output => muxB_int); 
print: print_module port map(data_in => rs_int, print_enable => print_cont_int, digits_out => digit_int); 

output3 <= digit_int(15 downto 12); 
output2 <= digit_int(11 downto 8);
output1 <= digit_int(7 downto 4);
output0 <= digit_int(3 downto 0);

end Behavioral;