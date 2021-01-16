library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEM is
	Port (	 
	
			ALU_resultIn : in std_logic_vector(31 downto 0);
			Read_Data2 : in std_logic_vector(31 downto 0);
			w_addrIn : in std_logic_vector (4 downto 0);	
			MemToRegIn : in std_logic; 
			MemRead : in std_logic;	   
			MemWrite : in std_logic;
			RegWriteIn : in std_logic;
			
			
			ALU_result : out std_logic_vector(31 downto 0);
			MemoryData : out std_logic_vector(31 downto 0);	
			w_addr : out std_logic_vector(4 downto 0);
			RegWrite : out std_logic;
			MemToReg : out std_logic

		);
end MEM;

architecture Behavioral of MEM is  

component DataMemory 
	Port (
			Address : in std_logic_vector(31 downto 0);
			WriteData : in std_logic_vector(31 downto 0);
			MemWrite, MemRead : in std_logic;
			ReadData : out std_logic_vector(31 downto 0)
		);
end component;	 

signal ReadDataX: std_logic_vector (31 downto 0);

begin

ALU_result <= ALU_resultIn;	
w_addr <= w_addrIn;
RegWrite <= RegWriteIn;
MemToReg <= MemToRegIn;
DataMemoryComp: DataMemory port map (ALU_resultIn, Read_Data2, MemWrite, MemRead, MemoryData);	

--u2:FinalRegister port map(clk,MemToReg,RegWrite,Data,ReadDataX,ExMemReg,MemWBReg,MemToRegOut,RegWriteOut,DataOut,ReadDataOut);

end Behavioral;
