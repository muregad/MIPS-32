library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity JumpAddress_tb is
--  Port ( );
end JumpAddress_tb;

architecture Behavioral of JumpAddress_tb is

component JumpAddress 
    Port (
            Rs : in std_logic_vector(31 downto 0);
            offset : in std_logic_vector(14 downto 0);
            address : out std_logic_vector(31 downto 0)
     );
end component;

signal Rs, address : std_logic_vector(31 downto 0);
signal offset : std_logic_vector(14 downto 0);

begin

uut: JumpAddress port map(Rs , offset , address);

process
begin

Rs <= x"00000000"; offset <= "111"&x"111";
wait for 10ns;

end process;

end Behavioral;
