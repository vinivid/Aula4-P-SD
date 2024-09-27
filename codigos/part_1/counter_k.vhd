LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity counter_k is
	generic (
		n : NATURAL := 4
	);
	port (
		clk : IN STD_LOGIC;
		max_count : IN STD_LOGIC_VECTOR (n - 1 downto 0);
		reset_n : IN STD_LOGIC;
		Q : OUT STD_LOGIC_VECTOR (n - 1 downto 0)
	);
end entity;

architecture behavour of counter_k is
	signal values : STD_LOGIC_VECTOR (n - 1 downto 0);
begin
	--O reset esta no processo pq queremos q ele possa ser resetado
	--independete do clock
	process (clk, reset_n)
	begin
		if (reset_n = '0') then
			values <= (others => '0');			
		elsif (rising_edge(clk)) then
			if (values = max_count) then
				values <= (others => '0');
			else 
				values <= values + 1;
			end if;
		end if;
	end process;
	
	Q <= values;
end architecture behavour;
