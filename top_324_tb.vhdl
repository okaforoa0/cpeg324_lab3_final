library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_324_tb is 
end top_324_tb; 

architecture Behavioral of top_324_tb is

    component top_324
    Port (
        clk : in std_logic;
        reset : in std_logic;
        instruction : in std_logic_vector(7 downto 0);
        output0 : out std_logic_vector(3 downto 0);
        output1 : out std_logic_vector(3 downto 0);
        output2 : out std_logic_vector(3 downto 0);
        output3 : out std_logic_vector(3 downto 0)
    ); 
end component;

signal clk_tb : std_logic := '0';
signal reset_tb  : std_logic := '0';
signal instr_tb  : std_logic_vector(7 downto 0) := (others => '0');
signal output0_tb, output1_tb, output2_tb, output3_tb : std_logic_vector(3 downto 0); --:= (others => '0');

constant clk_period : time := 10 ns;

begin

    -- Instantiate Unit Under Test (UUT)
    uut: top_324
        port map (
            clk => clk_tb,
            reset => reset_tb,
            instruction => instr_tb,
            output0 => output0_tb,
            output1 => output1_tb,
            output2 => output2_tb,
            output3 => output3_tb
        );

    -- Clock process
    clk_process : process
    begin
        while true loop
            clk_tb <= '0';
            wait for clk_period/2;
            clk_tb <= '1';
            wait for clk_period/2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset sequence
        reset_tb <= '1';
        wait for clk_period;
        reset_tb <= '0';
        wait for clk_period;

        -- Two NOPs (do nothing)
        instr_tb <= "00000000";
        wait for clk_period;
        instr_tb <= "00000000";
        wait for clk_period;

        -- Load 2 into R2
        instr_tb <= "01001010";
        wait for clk_period;
        instr_tb <= "00000000"; -- NOP for stabilization
        wait for clk_period;

        -- Load -1 into R3
        --instr_tb <= "01111111";

        --load 2 into r3
        instr_tb <= "01001010";
        wait for clk_period;
        instr_tb <= "00000000"; -- NOP for stabilization
        wait for clk_period;

        -- ADD r2 + r3 -> r1
        instr_tb <= "00101101";
        wait for clk_period;

        -- SWAP halves of r1
        instr_tb <= "11011000";
        wait for clk_period;

        -- COMPARE r1 and r2
        instr_tb <= "10011000";
        wait for clk_period;

        -- Load 4 into r1 (skipped if r1 < r2)
        instr_tb <= "01010001";
        wait for clk_period;

        -- DISPLAY r1 lower
        instr_tb <= "11010000";
        wait for clk_period;

        -- Finish simulation
        wait for 2 * clk_period;

        --wait for clk_period * 10;
        assert false report "Simulation completed successfully!" severity note;
        wait;
    end process;

end Behavioral;