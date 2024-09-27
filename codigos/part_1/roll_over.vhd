library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity roll_over is
    generic (
        n : STD_LOGIC_VECTOR (25 downto 0) := "011111010111100001000000"
    );

    port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        enable : in STD_LOGIC;
        roll : OUT STD_LOGIC := '0'
    );
end entity roll_over;

architecture Behaviour of roll_over is
    signal save_counter : STD_LOGIC_VECTOR (25 downto 0);
begin
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (reset = '1') then
                save_counter <= "00000000000000000000000000";
				roll <= '0';
            elsif (Enable = '1') then
                --é necessario usar std logic unsigned para somar
                save_counter <= save_counter + 1;
				if (save_counter = n) then
					roll <= '1';
                    save_counter <= "00000000000000000000000000";
                else 
                    roll <= '0';
				end if;	
            else
                save_counter <= save_counter;
        end if;
    end if;
    end process;
end architecture Behaviour;