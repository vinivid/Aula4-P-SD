library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity register_g is
    generic (
        n : NATURAL := 4
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        data : in STD_LOGIC_VECTOR (n - 1 downto 0);
        data_out : OUT STD_LOGIC_VECTOR (n - 1 downto 0)
    );
end entity;

architecture Behavour of register_g is
    signal save_data : STD_LOGIC_VECTOR (n - 1 downto 0);
begin
    process (clk)
    begin
        if (rising_edge(clk)) then 
            if (reset = '1') then
                save_data <= (others => '0');
            elsif (enable = '1') then
                save_data <= data;
            else 
                save_data <= save_data;
            end if;
        end if;
    end process;
    
    data_out <= save_data;
end architecture Behavour;