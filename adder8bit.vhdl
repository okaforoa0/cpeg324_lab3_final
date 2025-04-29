library ieee;
use ieee.std_logic_1164.all;

entity adder8bit is
    port (
        A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);
        S : out std_logic_vector(7 downto 0)
    );
end adder8bit;

architecture behav of adder8bit is

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

begin

    c(0) <= '0'; -- Initial carry-in is 0

    -- Bit 0
    fa0: full_adder port map(
        a => A(0),
        b => B(0),
        cin => c(0),
        sum => S(0),
        cout => c(1)
    );

    -- Bit 1
    fa1: full_adder port map(
        a => A(1),
        b => B(1),
        cin => c(1),
        sum => S(1),
        cout => c(2)
    );

    -- Bit 2
    fa2: full_adder port map(
        a => A(2),
        b => B(2),
        cin => c(2),
        sum => S(2),
        cout => c(3)
    );

    -- Bit 3
    fa3: full_adder port map(
        a => A(3),
        b => B(3),
        cin => c(3),
        sum => S(3),
        cout => c(4)
    );

    -- Bit 4
    fa4: full_adder port map(
        a => A(4),
        b => B(4),
        cin => c(4),
        sum => S(4),
        cout => c(5)
    );

    -- Bit 5
    fa5: full_adder port map(
        a => A(5),
        b => B(5),
        cin => c(5),
        sum => S(5),
        cout => c(6)
    );

    -- Bit 6
    fa6: full_adder port map(
        a => A(6),
        b => B(6),
        cin => c(6),
        sum => S(6),
        cout => c(7)
    );

    -- Bit 7
    fa7: full_adder port map(
        a => A(7),
        b => B(7),
        cin => c(7),
        sum => S(7),
        cout => c(8)  -- final carry-out (not used)
    );

end behav;
