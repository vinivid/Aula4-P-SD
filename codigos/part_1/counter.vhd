library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
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
end entity;

architecture Behaviour of counter is
begin
    process (clk, reset)
    begin
        if (rising_edge(clk)) then
            if (reset =  '1') then
                counter <= min;
            elsif (enable = '1') then
                if (counter = modulo) then 
                    counter <= min;
                else 
                    counter <= counter + 1;
                end if;
            else
                counter <= counter;
        end if;
    end if;
    end process; 
end architecture;
