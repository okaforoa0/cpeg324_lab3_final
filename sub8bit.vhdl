----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2025 01:12:10 PM
-- Design Name: 
-- Module Name: sub8bit - Behavioral
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

entity sub8bit is
  Port ( A   : in  std_logic_vector(7 downto 0);
         B   : in  std_logic_vector(7 downto 0);
         S   : out std_logic_vector(7 downto 0));
end sub8bit;

architecture Behavioral of sub8bit is

component full_adder
        port (
            a    : in std_logic;
            b    : in std_logic;
            cin  : in std_logic;
            sum  : out std_logic;
            cout : out std_logic
        );
    end component;

signal c : std_logic_vector(8 downto 0); -- Carry chain
signal b_int: std_logic_vector(7 downto 0); 

begin
    b_int <= B XOR "11111111";
    c(0) <= '1'; -- Initial carry-in is 1

    -- Bit 0
    fa0: full_adder port map(
        a => A(0),
        b => b_int(0),
        cin => c(0),
        sum => S(0),
        cout => c(1)
    );

    -- Bit 1
    fa1: full_adder port map(
        a => A(1),
        b => b_int(1),
        cin => c(1),
        sum => S(1),
        cout => c(2)
    );

    -- Bit 2
    fa2: full_adder port map(
        a => A(2),
        b => b_int(2),
        cin => c(2),
        sum => S(2),
        cout => c(3)
    );

    -- Bit 3
    fa3: full_adder port map(
        a => A(3),
        b => b_int(3),
        cin => c(3),
        sum => S(3),
        cout => c(4)
    );

    -- Bit 4
    fa4: full_adder port map(
        a => A(4),
        b => b_int(4),
        cin => c(4),
        sum => S(4),
        cout => c(5)
    );

    -- Bit 5
    fa5: full_adder port map(
        a => A(5),
        b => b_int(5),
        cin => c(5),
        sum => S(5),
        cout => c(6)
    );

    -- Bit 6
    fa6: full_adder port map(
        a => A(6),
        b => b_int(6),
        cin => c(6),
        sum => S(6),
        cout => c(7)
    );

    -- Bit 7
    fa7: full_adder port map(
        a => A(7),
        b => b_int(7),
        cin => c(7),
        sum => S(7),
        cout => c(8)  -- final carry-out (not used)
    );



end Behavioral;