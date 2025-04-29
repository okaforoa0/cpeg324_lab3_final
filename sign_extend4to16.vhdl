library ieee;
use ieee.std_logic_1164.all;

entity sign_extend4to16 is
    port (
        input_4bit  : in std_logic_vector(3 downto 0);
        output_16bit : out std_logic_vector(15 downto 0)
    );
end sign_extend4to16;

architecture Behavioral of sign_extend4to16 is
begin
    process(input_4bit)
    begin
        if input_4bit(3) = '1' then
            output_16bit <= (15 downto 8 => '0') & (7 downto 4 => '1') & input_4bit;
            --output_16bit <= (15 downto 8 => '0') & ("1111" & input_4bit);
        else
            output_16bit <= (15 downto 8 => '0') & (7 downto 4 => '0') & input_4bit;
            --output_16bit <= (15 downto 8 => '0') & ("0000" & input_4bit);
        end if;
    end process;
end Behavioral;