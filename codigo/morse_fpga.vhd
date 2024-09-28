library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity morse_fpga is
    port (
        clk : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        word_entry : IN STD_LOGIC_VECTOR(2 downto 0);
        out_led : OUT STD_LOGIC
    );
end entity morse_fpga;

architecture Behaviour of morse_fpga is
    component input_unit is
        port (
            word_entry : IN STD_LOGIC_VECTOR(2 downto 0);
            word_size : OUT STD_LOGIC_VECTOR(3 downto 0);
            word_symbols : OUT STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

    component logic_unit is
        port (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            word_size : IN STD_LOGIC_VECTOR (3 downto 0);
            word_symbols : IN STD_LOGIC_VECTOR(4 downto 0);
            out_led : OUT STD_LOGIC
        );
    end component;

    signal word_size : STD_LOGIC_VECTOR(3 downto 0);
    signal word_symbols : STD_LOGIC_VECTOR(4 downto 0);
begin
    
    main_input: input_unit
     port map(
        word_entry => word_entry,
        word_size => word_size,
        word_symbols => word_symbols
    );

    main_logic: logic_unit
     port map(
        clk => clk,
        reset => reset,
        enable => enable,
        word_size => word_size,
        word_symbols => word_symbols,
        out_led => out_led
    );
    
end architecture Behaviour;