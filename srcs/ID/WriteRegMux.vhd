library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity WriteRegMux is
	port(
			RegDst : in std_logic;
			Inst20_16 : in std_logic_vector (4 downto 0);
            Inst15_11 : in std_logic_vector (4 downto 0);	  
			w_addr : out std_logic_vector (4 downto 0)
	
	);
end WriteRegMux;



architecture WriteRegMux of WriteRegMux is
begin

	w_addr <= Inst15_11 when (RegDst = '1') else
			  Inst20_16;

end WriteRegMux;
