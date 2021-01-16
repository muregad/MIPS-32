library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;




entity EX_And_Reg is 
	port(
				clk : in std_logic;
				Read_Data1 : in std_logic_vector (31 downto 0);
            	Read_Data2 : in std_logic_vector (31 downto 0);
				Instruction : in std_logic_vector (31 downto 0);
				EX_MEM_Rd : in std_logic_vector (4 downto 0);  
				MEM_WB_Rd : in std_logic_vector (4 downto 0); -- look at the cases when Rs, Rt are not meant for regs 
				EX_MEM_Val : in std_logic_vector (31 downto 0);
				MEM_WB_Val : in std_logic_vector (31 downto 0);	 
				w_addrIn : in std_logic_vector(4 downto 0);	-- recently added
				EX_MEM_RegWrite : in std_logic;	 --
				MEM_WB_RegWrite : in std_logic;	 --
            	RegDst : in std_logic;
            	RegWriteIn : in std_logic;
            	ALUSrc : in std_logic;
            	MemWriteIn : in std_logic;
            	ALUOp : in std_logic_vector(1 downto 0);
            	MemReadIn : in std_logic;
            	MemToRegIn : in std_logic;
				
				ALU_result : out std_logic_vector(31 downto 0);
				Read_Data2Out : out std_logic_vector(31 downto 0);
				w_addr : out std_logic_vector (4 downto 0);	
				MemToReg : out std_logic; 
				MemRead : out std_logic;	   
				MemWrite : out std_logic;
				RegWrite : out std_logic
	);
end EX_And_Reg;



architecture Behavioral of EX_And_Reg is

component EX
  Port (
			Read_Data1 : in std_logic_vector (31 downto 0);
            	Read_Data2 : in std_logic_vector (31 downto 0);
			Instruction : in std_logic_vector (31 downto 0);
			EX_MEM_Rd : in std_logic_vector (4 downto 0);  
			MEM_WB_Rd : in std_logic_vector (4 downto 0); -- look at the cases when Rs, Rt are not meant for regs 
			EX_MEM_Val : in std_logic_vector (31 downto 0);
			MEM_WB_Val : in std_logic_vector (31 downto 0);
			
			EX_MEM_RegWrite : in std_logic;
			MEM_WB_RegWrite : in std_logic;
            --Inst20_16 : in std_logic_vector (4 downto 0);
            --Inst15_11 : in std_logic_vector (4 downto 0); 
			--Inst15_0 : in std_logic_vector (15 downto 0);
            	RegDst : in std_logic;
            	RegWriteIn : in std_logic;
            	ALUSrc : in std_logic;
            	MemWriteIn : in std_logic;
            	ALUOp : in std_logic_vector(1 downto 0);
            	MemReadIn : in std_logic;
            	MemToRegIn : in std_logic;
            	--BranchIn : in std_logic;
			
			ALU_result : out std_logic_vector(31 downto 0);
			Read_Data2out : out std_logic_vector(31 downto 0); 
			--w_addr : out std_logic_vector (4 downto 0);
			--Branch_address : out std_logic_vector(31 downto 0);
			--Branch : out std_logic;
			MemToReg : out std_logic; 
			MemRead : out std_logic;	   
			MemWrite : out std_logic;
			RegWrite : out std_logic
   );
end component;

component EX_MEM_Reg 
	
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
	
end component;

signal ALU_resultIn, Read_Data2In : std_logic_vector(31 downto 0);
--signal w_addrIn : std_logic_vector(4 downto 0);	
signal MemToRegOut, MemReadOut, MemWriteOut, RegWriteOut : std_logic; 


begin

u1: EX port map (	Read_Data1,
            		Read_Data2,
					Instruction,
					EX_MEM_Rd,  
					MEM_WB_Rd,  
					EX_MEM_Val,
					MEM_WB_Val,
					EX_MEM_RegWrite,
					MEM_WB_RegWrite,
	            	RegDst,
	            	RegWriteIn,
	            	ALUSrc,
	            	MemWriteIn,
	            	ALUOp,
	            	MemReadIn,
	            	MemToRegIn,
					ALU_resultIn,
					Read_Data2In,
					--w_addrIn,
					MemToRegOut, 
					MemReadOut,	   
					MemWriteOut,
					RegWriteOut); 
					
					
u2: EX_MEM_Reg port map ( 	clk,
							ALU_resultIn,
							Read_Data2In,
							w_addrIn,	
							MemToRegOut,
							MemReadOut,	   
							MemWriteOut,
							RegWriteOut,
							ALU_result,
							Read_Data2Out,
							w_addr,	
							MemToReg, 
							MemRead,	   
							MemWrite,
							RegWrite);

end Behavioral;
