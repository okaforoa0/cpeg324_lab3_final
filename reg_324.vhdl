----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2025 03:09:30 PM
-- Design Name: 
-- Module Name: reg_324 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_324 is
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
end reg_324;

architecture Behavioral of reg_324 is

type reg_component is array (0 to 3) of std_logic_vector(15 downto 0);
signal registers : reg_component := (others => (others => '0'));

begin

read_reg:process(rs, rt, rd, registers)
    begin 
         rs_out <= registers(TO_INTEGER(unsigned(rs)));
         rt_out <= registers(TO_INTEGER(unsigned(rt)));
         rd_out <= registers(TO_INTEGER(unsigned(rd)));
end process;

write_reg:process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                registers <= (others => (others => '0'));
            elsif write_control = '1' then
                registers(to_integer(unsigned(rd))) <= write_data;
            end if;
        end if;
    end process;

end Behavioral;