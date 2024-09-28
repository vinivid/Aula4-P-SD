library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity logic_unit is
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        word_size : IN STD_LOGIC_VECTOR (3 downto 0);
        word_symbols : IN STD_LOGIC_VECTOR(4 downto 0);
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
            counter : buffer INTEGER range min to max := min
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
            data_in : IN STD_LOGIC_VECTOR (4 downto 0);
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
    signal control_counter_number : INTEGER range 0 to 6;
    signal control_counter_clock : STD_LOGIC := '0';
    signal control_counter_reset : STD_LOGIC := '0';
    signal current_symbol : STD_LOGIC;
    signal proc_enable : STD_LOGIC := '0';
    signal is_proc_enabled : STD_LOGIC := '0';
	 signal n_reset : STD_LOGIc := '0';
begin
	n_reset <= not reset;
		
    control_counter: counter
     generic map(
        modulo => 6,
        max => 8,
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
        reset => n_reset,
        enable =>  '1',
        data_in(0) => proc_enable,
        data_out(0) => is_proc_enabled
    );

    word_size_reg: register_g
     generic map(
        qtt_of_bits => 4
    )
     port map(
        clk => clk,
        reset => n_reset,
        enable => enable,
        data_in => word_size,
        data_out => size_of_word
    );
    
    shift_word_symbols: shift_symbol
     port map(
        clk => clk,
        enable => proc_enable,
        reset => n_reset,
        pos => control_counter_number,
        data_in => word_symbols,
        data_out => current_symbol
    );

    main_proc: proc_symbol
     port map(
        clk => clk,
        enable => is_proc_enabled,
        reset => n_reset,
        word_bit => current_symbol,
        out_led => out_led,
        next_bit => control_counter_clock
    );

    process (clk, reset)
    begin
        if (reset = '0') then
            control_counter_reset <= '1';
        elsif (enable = '0') then
            proc_enable <= '1';
            control_counter_reset <= '0';
        elsif (to_integer(unsigned(size_of_word)) = control_counter_number) then 
            proc_enable <= '0';
            control_counter_reset <= '1';
        else
            control_counter_reset <= '0';
        end if;
    end process;
end architecture Behaviour;