library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ID_tb is
end ID_tb;


architecture ID_tb of ID_tb is

component ID
    Port ( 
            Instruction : in std_logic_vector(31 downto 0);
            RegWriteIn : in std_logic;
            w_addr : in std_logic_vector(4 downto 0);
            w_data : in std_logic_vector (31 downto 0);
			ID_Ex_MemRead : in std_logic;
			ID_Ex_Reg : in std_logic_vector(4 downto 0); 
			
            Read_data1 : out std_logic_vector (31 downto 0);
            Read_data2 : out std_logic_vector (31 downto 0);	
            JAddress : out std_logic_vector(31 downto 0); 
			Branch_address : out std_logic_vector(31 downto 0);
            InstructionOut : out std_logic_vector(31 downto 0);	
            RegDst : out std_logic;
            RegWriteOut : out std_logic;
            ALUSrc : out std_logic;
            MemWrite : out std_logic;
            ALUOp : out std_logic_vector(1 downto 0);
            MemRead : out std_logic;
            MemToReg : out std_logic;
            Branch : out std_logic;
			Jump : out std_logic;
			stall : out std_logic
    );
end component;

signal Instruction, InstructionOut, w_data, Read_data1, Read_data2, JAddress, Branch_address : std_logic_vector(31 downto 0) := (others => '0');

begin

	 

end ID_tb;
