library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shy_reg is
    generic (
        n : NATURAL := 4
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        data : in STD_LOGIC_VECTOR (n - 1 downto 0);
        data_out : out STD_LOGIC_VECTOR (n - 1 downto 0)
    );
end entity;

architecture Behavour of shy_reg is
    signal save_data : STD_LOGIC_VECTOR (n - 1 downto 0);
begin
    process (clk)
    begin 
        if (rising_edge(clk)) then
            if (reset = '1') then 
                save_data <= (others => '0');
            elsif (enable = '1') then 
                for i in save_data'high - 1 downto save_data'low loop
                    save_data (i) <= save_data (i + 1);
                end loop;
            end if;
        end if;
    end process;
    
    data_out <= save_data;
end architecture Behavour;