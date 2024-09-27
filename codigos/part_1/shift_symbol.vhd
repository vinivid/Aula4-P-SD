library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shift_symbol is
    port (
        clk : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        pos : IN INTEGER := 0;
        data_in : IN STD_LOGIC_VECTOR (3 downto 0);
        data_out : OUT STD_LOGIC := '0'
    );
end entity shift_symbol;

architecture Behaviour of shift_symbol is
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

    signal symbols : STD_LOGIC_VECTOR (3 downto 0);
begin

    reg_symbols: register_g
     generic map(
        qtt_of_bits => 4
    )
     port map(
        clk => clk,
        reset => reset,
        enable => enable,
        data_in => data_in,
        data_out => symbols
    );
    
    data_out <= symbols(pos);

end architecture Behaviour;