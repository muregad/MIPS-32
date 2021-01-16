library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ProgramCounter is
	Port ( 	  
			clk : in std_logic;
			stall :in std_logic;
			JumpAddress : in  std_logic_vector(31 downto 0);
			BranchAddress : in std_logic_vector(31 downto 0);
			Jump : in std_logic;
			Branch : in std_logic;
			PCsrc :in std_logic;
			PCout : out std_logic_vector(31 downto 0)
);
end ProgramCounter;

architecture Behavioral of ProgramCounter is

signal PC : std_logic_vector (31 downto 0):="00000000000000000000000000000000";	

begin  
	
	process(clk)
		begin
			
			if(clk'event and clk = '1')then 
				if(stall = '0') then
					if(Jump = '1')then
						PC<=JumpAddress;
					elsif(Branch = '1')then
						PC<=BranchAddress; 
				 	else
						if(PC < 4) then
							PC<=PC+1;
						end if;
					end if;
				end if;
				
			end if;
	
	end process;

PCout<=PC;

end Behavioral;
