library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MEM_And_Reg is 
	port( 
			clk :in std_logic; 
	
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
end MEM_And_Reg;



architecture MEM_And_Reg of MEM_And_Reg is 

component MEM
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
end component; 

component MEM_WB_Reg
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
end component;

signal ALU_resultOut, MemoryDataOut : std_logic_vector(31 downto 0);	
signal w_addrOut : std_logic_vector(4 downto 0);
signal RegWriteOut, MemToRegOut : std_logic;


begin
	
u1: MEM Port map(	 
	
			ALU_resultIn,
			Read_Data2,
			w_addrIn,	
			MemToRegIn, 
			MemRead,   
			MemWrite,
			RegWriteIn,
			ALU_resultOut,
			MemoryDataOut,
			w_addrOut,
			RegWriteOut,
			MemToRegOut);
			
u2: MEM_WB_Reg Port map(
			clk,
			ALU_resultOut,
			MemoryDataOut,	
			w_addrOut,
			RegWriteOut,
			MemToRegOut,
			ALU_result,
			MemoryData,	
			w_addr,
			RegWrite,
			MemToReg);
			
			


	 

end MEM_And_Reg;
