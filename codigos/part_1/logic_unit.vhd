library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity logic_unit is
    port (
        clk : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        word_sz : IN NATURAL;
        word_char : IN STD_LOGIC_VECTOR(3 downto 0);
        out_led : out STD_LOGIC
    );
end entity logic_unit; 

architecture Behaviour of logic_unit is

    component counter_k is
        generic (
            n : NATURAL := 4
        );
        port (
            clk : IN STD_LOGIC;
            max_count : IN STD_LOGIC_VECTOR (n - 1 downto 0);
            reset_n : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR (n - 1 downto 0)
        );
    end component;

    signal buff : STD_LOGIC_VECTOR(3 downto 0) := word_char;
    signal out_size_counter : STD_LOGIC_VECTOR;
begin
    
    process (clk)
    begin 
    
    end process;
    


end architecture Behaviour;