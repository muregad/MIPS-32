library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX_MEM_Reg is 
	
	port(	
			clk : in std_logic;
			ALU_resultIn : in std_logic_vector(31 downto 0);
			Read_Data2In : in std_logic_vector(31 downto 0);
			w_addrIn : in std_logic_vector (4 downto 0);	
			MemToRegIn : in std_logic; 
			MemReadIn : in std_logic;	   
			MemWriteIn : in std_logic;
			RegWriteIn : in std_logic;
			
			
			ALU_result : out std_logic_vector(31 downto 0);
			Read_Data2 : out std_logic_vector(31 downto 0);
			w_addr : out std_logic_vector (4 downto 0);	
			MemToReg : out std_logic; 
			MemRead : out std_logic;	   
			MemWrite : out std_logic;
			RegWrite : out std_logic
	);
	
end EX_MEM_Reg;


architecture EX_MEM_Reg of EX_MEM_Reg is
begin

	process(clk)
	begin
		if(clk'event and clk = '1') then   
			ALU_result <= ALU_resultIn;
			Read_Data2 <= Read_Data2In;
			w_addr <= w_addrIn;	
			MemToReg <= MemToRegIn; 
			MemRead <= MemReadIn;	   
			MemWrite <= MemWriteIn;
			RegWrite <= RegWriteIn;
		end if;	
	end process;

	

end EX_MEM_Reg;
