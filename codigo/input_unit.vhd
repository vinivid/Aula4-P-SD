library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity input_unit is
    port (
        word_entry : IN STD_LOGIC_VECTOR(2 downto 0);
        word_size : OUT STD_LOGIC_VECTOR(3 downto 0);
        word_symbols : OUT STD_LOGIC_VECTOR(4 downto 0)
    );
end entity input_unit;

architecture Behaviour of input_unit is
    
begin
    process (word_entry, word_symbols)
    begin
        case word_entry is
            when "000" => 
                word_size <= "0010";
                word_symbols <= "0001";
            when "001" =>
                word_size <= "0100";
                word_symbols <= "01000";
            when "010" =>
                word_size <= "0100";
                word_symbols <= "01010";
            when "011" => 
                word_size <= "0011";
                word_symbols <= "00100";
            when "100" =>
                word_size <= "0001";
                word_symbols <= "00000";
            when "101" =>
                word_size <= "0100";
                word_symbols <= "00010";
            when "110" => 
                word_size <= "0011";
                word_symbols <= "00110";
            when "111" =>
                word_size <= "0100";
                word_symbols <= "00000";
        end case;
    end process;
    
end architecture Behaviour;