library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX3 is
      Port (
            In1 : in std_logic_vector(31 downto 0);
            In2 : in std_logic_vector(31 downto 0);
			In3 : in std_logic_vector(31 downto 0);
            selector : in std_logic_vector(1 downto 0);
            output : out std_logic_vector(31 downto 0)
       );
end MUX3;


architecture MUX3 of MUX3 is
begin


output <= In1 when (selector = "00") else
		  In2 when (selector = "01") else
		  In3;

end MUX3;
