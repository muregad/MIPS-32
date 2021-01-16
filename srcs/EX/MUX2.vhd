

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity MUX2 is
      Port (
            In1 : in std_logic_vector(31 downto 0);
            In2 : in std_logic_vector(31 downto 0);
            selector : in std_logic;
            output : out std_logic_vector(31 downto 0)
       );
end MUX2;

architecture Behavioral of MUX2 is

begin

output <= In1 when(selector = '0') else
          In2;  

end Behavioral;
