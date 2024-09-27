library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity proc_symbol is
    port (
        clk : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        word_bit : IN STD_LOGIC;
        out_led : OUT STD_LOGIC := '0';
        next_bit : OUT STD_LOGIC := '0'
    );
end entity proc_symbol;

architecture Behaviour of proc_symbol is
    --constant max_count : INTEGER := 90000000;
    --constant one_six_sec : INTEGER := 80000000;
    --constant one_five_sec : INTEGER := 75000000;
    --constant point_five_sec : INTEGER := 25000000;
    --constant point_six_sec : INTEGER := 30000000;

    constant max_count : INTEGER := 20;
    constant one_six_sec : INTEGER := 15;
    constant one_five_sec : INTEGER := 10;
    constant point_five_sec : INTEGER := 5;
    constant point_six_sec : INTEGER := 10;

    component counter is
        generic (
            modulo : INTEGER := 4;
            max : INTEGER := 4;
            min : INTEGER := 0
        );
        port (
            clk : in STD_LOGIC;
            enable : in STD_LOGIC;
            reset : in STD_LOGIC;
            counter : buffer INTEGER range min to max := min
        );
    end component;

    signal counter_exit : INTEGER range 0 to max_count;
    signal reset_counter : STD_LOGIC := '0';
begin
    
    sec_counter: counter
     generic map(
        modulo => one_six_sec,
        max => max_count,
        min => 0
    )
     port map(
        clk => clk,
        enable => enable,
        reset => reset_counter,
        counter => counter_exit
    );
    
    process (clk, reset)
    begin
        if (reset = '1') then
            reset_counter <= '1';
            out_led <= '0';
            next_bit <= '0';
        elsif (rising_edge(clk) and enable = '1')then
            reset_counter <= '0';
            next_bit <= '0';

            if (word_bit = '0') then
                if (counter_exit < point_five_sec) then
                    out_led <= '1';
                elsif (counter_exit >= point_six_sec) then 
                    out_led <= '0';
                    reset_counter <= '1';
                    next_bit <= '1';
                else
                    out_led <= '0';
                end if;
            else
                if (counter_exit < one_five_sec) then
                    out_led <= '1'; 
                elsif (counter_exit >= one_six_sec) then 
                    out_led <= '0';
                    reset_counter <= '1';
                    next_bit <= '1';
                else 
                    out_led <= '0';
                end if;
            end if;
        elsif (enable = '0') then 
            out_led <= '0'; 
        end if;
    end process;
    
end architecture Behaviour;