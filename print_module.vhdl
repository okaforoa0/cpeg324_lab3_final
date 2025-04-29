library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity print_module is
    port (
        data_in      : in std_logic_vector(15 downto 0);
        print_enable : in std_logic;
        digits_out   : out std_logic_vector(15 downto 0)
    );
end print_module;

architecture Behavioral of print_module is

    signal lower8_signed : signed(7 downto 0);

    -- helper function to check clean input
    function is_clean(s : std_logic_vector) return boolean is
    begin
        for i in s'range loop
            if s(i) /= '0' and s(i) /= '1' then
                return false;
            end if;
        end loop;
        return true;
    end function;

begin

    process(data_in, print_enable)
        -- declare temp variables
        variable temp_value : integer;
        variable abs_value  : integer;
        variable d0, d1, d2, d3 : integer range 0 to 9;
    begin
        if print_enable = '1' then

            -- check input validity
            if is_clean(data_in(7 downto 0)) then

                -- sign-extend lower 8 bits
                lower8_signed <= signed(data_in(7 downto 0));

                -- convert to integer
                temp_value := to_integer(signed(data_in(7 downto 0)));

                -- abs value
                if temp_value < 0 then
                    abs_value := -temp_value;
                else
                    abs_value := temp_value;
                end if;

                -- protect the bounds (8-bit values only)
                abs_value := abs_value mod 256;

                -- split into decimal digits
                d3 := abs_value / 1000;
                d2 := (abs_value mod 1000) / 100;
                d1 := (abs_value mod 100) / 10;
                d0 := abs_value mod 10;

                -- pack into output
                digits_out <= 
                std_logic_vector(to_unsigned(d3, 4)) & 
                std_logic_vector(to_unsigned(d2, 4)) & 
                std_logic_vector(to_unsigned(d1, 4)) & 
                std_logic_vector(to_unsigned(d0, 4));



            else
                digits_out <= (others => '0'); -- bad input → blank
            end if;

        else
            digits_out <= (others => '0');
        end if;
    end process;

end Behavioral;
