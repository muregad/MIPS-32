library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity MUX2_tb is
--  Port ( );
end MUX2_tb;

architecture Behavioral of MUX2_tb is

component MUX2 
      Port (
            In1 : in std_logic_vector(31 downto 0);
            In2 : in std_logic_vector(31 downto 0);
            selector : in std_logic;
            output : out std_logic_vector(31 downto 0)
       );
end component;

signal In1, In2, output : std_logic_vector(31 downto 0);
signal selector : std_logic;

begin

uut: MUX2 port map(In1 , In2 , selector , output);

process
begin
In1 <= x"FFFFFFFF"; In2 <= x"AAAAAAAA";
selector <= '0';
wait for 10ns;
selector <= '1';
wait for 10ns;

end process;

end Behavioral;
