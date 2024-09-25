library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg_test is
    port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        enable : IN STD_LOGIC;
        data : IN STD_LOGIC_VECTOR(3 downto 0);
        data_out : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
end entity reg_test;

architecture Behaviour of reg_test is

    component register_g is
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
    end component;
begin

    gih: register_g
        generic map (
            n => 4
        )
        port map (
            clk   => clk,
            reset => reset,
            enable => enable,
            data => data,
            data_out => data_out
        );
    
end architecture Behaviour;