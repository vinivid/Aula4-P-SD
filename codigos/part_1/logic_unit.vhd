library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity logic_unit is
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        word_size : IN STD_LOGIC_VECTOR (3 downto 0);
        word_symbols : IN STD_LOGIC_VECTOR(3 downto 0);
        out_led : OUT STD_LOGIC
    );
end entity logic_unit;

architecture Behaviour of logic_unit is

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
            counter : buffer INTEGER range max to min := min
        );
    end component;

    component register_g is
        generic (
            qtt_of_bits : NATURAL := 4
        );
        port (
            clk   : in std_logic;
            reset : in std_logic;
            enable : in std_logic;
            data_in : in STD_LOGIC_VECTOR (qtt_of_bits - 1 downto 0);
            data_out : BUFFER STD_LOGIC_VECTOR (qtt_of_bits - 1 downto 0) := (others => '0')
        );
    end component;

    component shift_symbol is
        port (
            clk : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            pos : IN INTEGER := 0;
            data_in : IN STD_LOGIC_VECTOR (3 downto 0);
            data_out : OUT STD_LOGIC := '0'
        );
    end component;

    component proc_symbol is
        port (
            clk : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            word_bit : IN STD_LOGIC;
            out_led : OUT STD_LOGIC := '0';
            next_bit : OUT STD_LOGIC := '0'
        );
    end component;

    signal size_of_word : STD_LOGIC_VECTOR (3 downto 0);
    signal control_counter_number : INTEGER range 0 to 3;
    signal control_counter_clock : STD_LOGIC;
    signal control_counter_reset : STD_LOGIC;
    signal current_symbol : STD_LOGIC;
    signal proc_enable : STD_LOGIC;
    signal is_proc_enabled : STD_LOGIC;
begin
    
    control_counter: counter
     generic map(
        modulo => 3,
        max => 3,
        min => 0
    )
     port map(
        clk => control_counter_clock,
        enable => '1',
        reset => control_counter_reset,
        counter => control_counter_number
    );

    curr_proc_state: register_g
     generic map(
        qtt_of_bits => 1
    )
     port map(
        clk => clk,
        reset => reset,
        enable => '1',
        data_in(0) => enable,
        data_out(0) => is_proc_enabled
    );

    word_size_reg: register_g
     generic map(
        qtt_of_bits => 4
    )
     port map(
        clk => clk,
        reset => reset,
        enable => enable,
        data_in => word_size,
        data_out => size_of_word
    );
    
    shift_word_symbols: shift_symbol
     port map(
        clk => clk,
        enable => enable,
        reset => reset,
        pos => control_counter_number,
        data_in => word_symbols,
        data_out => current_symbol
    );

    main_proc: proc_symbol
     port map(
        clk => clk,
        enable => is_proc_enabled,
        reset => reset,
        word_bit => current_symbol,
        out_led => out_led,
        next_bit => control_counter_clock
    );

    process (clk, reset)
    begin
        if (reset = '1') then
            control_counter_reset <= '1';
        elsif (to_integer(unsigned(size_of_word)) = control_counter_number) then
            control_counter_reset <= '1';
            proc_enable <= '0';
        elsif (enable = '1') then 
            proc_enable <= '1';
            control_counter_reset <= '0';
        else
            control_counter_reset <= '0';
        end if;
    end process;
end architecture Behaviour;