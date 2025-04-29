library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
    port (
        clk : in std_logic;
        reset : in std_logic;
        skip : in std_logic;
        pc_out : out std_logic_vector(7 downto 0)
    );
end pc;

architecture Behavioral of pc is
    signal pc_reg : unsigned(7 downto 0) := (others => '0');
begin

    process(clk, reset)
    begin
        if reset = '1' then
            pc_reg <= (others => '0');
        elsif rising_edge(clk) then
            if skip = '1' then
                pc_reg <= pc_reg + 2; -- skip over one instruction
            else
                pc_reg <= pc_reg + 1; -- normal advance
            end if;
        end if;
    end process;

    pc_out <= std_logic_vector(pc_reg);

end Behavioral;
