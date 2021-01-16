library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity WB is	  
	Port (
			MemToReg : in std_logic;
			ALU_result : in std_logic_vector(31 downto 0);
			MemoryData : in std_logic_vector(31 downto 0);
			
			WriteData : out std_logic_vector(31 downto 0)
	);
end WB;



architecture Behavioral of WB is
begin

WriteData <= MemoryData when(MemToReg = '1') else 
			 ALU_result;
			

end Behavioral;
