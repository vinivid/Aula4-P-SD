library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
    generic (
        bits_maximo : NATURAL := 4
    );
    port (
        clk : in STD_LOGIC;
        enable : in STD_LOGIC;
        reset : in STD_LOGIC;
        counter : buffer STD_LOGIC_VECTOR(bits_maximo - 1 downto 0)
    );
end entity;

architecture Behaviour of counter is
begin
    process (clk, reset)
    begin
        if (rising_edge(clk)) then
            if (reset =  '1') then
                counter <= (others => '0');
            elsif (enable = '1') then
                --é necessario usar std logic unsigned para somar
                counter <= counter + 1;
				if (save_counter = "10111110101111000010000000") then
					if (display_counter = "1001") then
						display_counter <= "0000";
                		save_counter <= "00000000000000000000000000";
					else 
						display_counter <= display_counter + 1;
						save_counter <= "00000000000000000000000000";
					end if;
				end if;	
            else
                save_counter <= save_counter;
        end if;
    end if;
    end process;

    Counter <= display_counter;

end architecture;
