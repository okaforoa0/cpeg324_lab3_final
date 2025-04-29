----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2025 06:29:35 PM
-- Design Name: 
-- Module Name: mux_324 - Behavioral
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

entity mux_324 is
  Port (A: in std_logic_vector(15 downto 0);
        B: in std_logic_vector(15 downto 0);
        sel: in std_logic;
        output: out std_logic_vector(15 downto 0)); 
end mux_324;

architecture Behavioral of mux_324 is

begin

output <= A when sel = '1' else B;

end Behavioral;