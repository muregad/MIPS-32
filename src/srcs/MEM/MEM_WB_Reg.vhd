library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEM_WB_Reg is
	Port (
			clk :in std_logic;
	
			ALU_resultIn : in std_logic_vector(31 downto 0);
			MemoryDataIn : in std_logic_vector(31 downto 0);	
			w_addrIn : in std_logic_vector(4 downto 0);
			RegWriteIn : in std_logic;
			MemToRegIn : in std_logic;
			
			ALU_result : out std_logic_vector(31 downto 0);
			MemoryData : out std_logic_vector(31 downto 0);	
			w_addr : out std_logic_vector(4 downto 0);
			RegWrite : out std_logic;
			MemToReg : out std_logic
		);
end MEM_WB_Reg;

architecture Behavioral of MEM_WB_Reg is

begin
	
	process(clk)
	begin
		if(rising_edge(clk)) then 
			ALU_result <= ALU_resultIn;
			MemoryData <= MemoryDataIn;
			w_addr <= w_addrIn;
			RegWrite <= RegWriteIn;
			MemToReg <= MemToRegIn;
		end if;
	end process;

end Behavioral;
