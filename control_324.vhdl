----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2025 01:21:45 PM
-- Design Name: 
-- Module Name: control_324 - Behavioral
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

entity control_324 is
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
end control_324;

architecture Behavioral of control_324 is

begin

--gen_signals: process(clk)
    gen_signals: process(op, control, ALU_result)
    begin 
        if(op = "00")then --add
            ALU_op <= "00"; 
            A_mux <= '1';
            B_mux <= '1';
            print_control <= '0';
            skip_control <= '0';
            write_control <= '1';
        elsif(op = "01")then --load
            ALU_op <= "10";
            A_mux <= '0';
            B_mux <= '0';
            print_control <= '0';
            skip_control <= '0';
            write_control <= '1';
        elsif(op = "10")then -- compare
            ALU_op <= "11"; 
            A_mux <= '1';
            B_mux <= '1';
            print_control <= '0';
            write_control <= '0';
            if(ALU_result(7) = '0' and ALU_result(7 downto 0) /= "00000000") then 
                skip_control <= '1'; 
            else
                skip_control <= '0';
            end if;
        elsif(op = "11" and control = '0')then -- display
            print_control <= '1';
            skip_control <= '0';
            write_control <= '0';
            --other control signals are dont cares 
        elsif(op = "11" and control = '1')then --swap
            ALU_op <= "01"; 
            A_mux <= '1';
            print_control <= '0';
            skip_control <= '0';
            write_control <= '1';
            --B_mux is dont care 
        else 
            ALU_op <= "00"; 
            A_mux <= '0';
            B_mux <= '0';
            print_control <= '0';
            skip_control <= '0';
            write_control <= '0';
            --set all controls as 0
       end if;
end process;  
end Behavioral;