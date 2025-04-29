----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2025 12:29:29 PM
-- Design Name: 
-- Module Name: mainALU_324 - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;

entity main_alu is
    Port ( 
        A       : in  std_logic_vector(15 downto 0);
        B       : in  std_logic_vector(15 downto 0);
        clk     : in  std_logic;
        control : in  std_logic_vector(1 downto 0);
        result  : out std_logic_vector(15 downto 0)
    );
end main_alu;

architecture Behavioral of main_alu is

    -- Declare the adder8bit component
    component adder8bit
        port (
            A   : in  std_logic_vector(7 downto 0);
            B   : in  std_logic_vector(7 downto 0);
            S   : out std_logic_vector(7 downto 0)
        );
    end component;
    
    component sub8bit
        port(
            A   : in  std_logic_vector(7 downto 0);
            B   : in  std_logic_vector(7 downto 0);
            S   : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Internal signals
    signal sum_upper, sum_lower, diff_lower : std_logic_vector(7 downto 0);

begin

    -- Instantiate adder for lower 8 bits
    lower_adder: adder8bit
    port map (
        A => A(7 downto 0),
        B => B(7 downto 0),
        S => sum_lower
    );

    -- Instantiate adder for upper 8 bits
    upper_adder: adder8bit
    port map (
        A => A(15 downto 8),
        B => B(15 downto 8),
        S => sum_upper
    );
    
    lower_sub: sub8bit
    port map(
        A => A(7 downto 0),
        B => B(7 downto 0),
        S => diff_lower
    );

    -- ALU operations
    process(clk)
    begin
        if rising_edge(clk) then
            case control is
                when "00" => -- ADD: separate 8-bit signed additions
                    result <= sum_upper & sum_lower;

                when "01" => -- SWAP halves of A
                    result <= A(7 downto 0) & A(15 downto 8);

                when "10" => -- FORWARD A
                    result <= A; --B(15 downto 8) & A(7 downto 0);

                when "11" => -- COMPARE lower halves
                    result <= "00000000" & diff_lower;
                    
                when others =>
                    result <= (others => '0');
            end case;
        end if;
    end process;

end Behavioral;
