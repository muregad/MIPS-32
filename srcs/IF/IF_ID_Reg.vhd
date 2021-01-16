library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;


entity IF_ID_Reg is
	port(
			clk: in std_logic; 
    		InstructionMem: in std_logic_vector(31 downto 0); 
      		InstMemOut : out std_logic_vector(31 downto 0)
		);  
end IF_ID_Reg;

architecture Behavioral of IF_ID_Reg is	 

begin		
	
	process (clk)  
      begin  
     	if (clk'event and clk = '1') then  
          	InstMemOut<=InstructionMem;
           	--PCout<= PC;
        end if; 
    end process;  

--PCoutSig<=PC;
--InstMemOutSig<=InstructionMem;
--PCout<=PCoutSig;
--InstMemOut<=InstMemOutSig;
end Behavioral;