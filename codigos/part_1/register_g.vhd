library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity register_g is
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
end entity;

architecture Behavour of register_g is
begin
    process (clk, reset)
    begin
        if (rising_edge(clk)) then 
            if (reset = '1') then
                data_out <= (others => '0');
            elsif (enable = '1') then
                data_out <= data_in;
            end if;
        end if;
    end process;

end architecture Behavour;