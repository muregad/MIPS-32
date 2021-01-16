library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity EX is
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
end EX;

architecture Behavioral of EX is

component ALU 
	Port (

		r_data1 : in std_logic_vector(31 downto 0);
		r_data2 : in std_logic_vector(31 downto 0);
		ALUOp : in std_logic_vector(1 downto 0);
		ALU_result : out std_logic_vector(31 downto 0);
		OverFlowOutput:Out std_logic
	);

end component;



component BranchAddress
    Port (
            Read_data2 : in std_logic_vector(31 downto 0);
            offset : in std_logic_vector(15 downto 0);
            address : out std_logic_vector(31 downto 0)
     );
end component; 

component ForwardingUnit	
	Port (
			Opcode : in std_logic_vector(5 downto 0);
			Rs : in std_logic_vector(4 downto 0); 
			Rt : in std_logic_vector(4 downto 0);
			EX_MEM_Rd : in std_logic_vector(4 downto 0); 
			MEM_WB_Rd : in std_logic_vector(4 downto 0); 
			EX_MEM_RegWrite : in std_logic;
			MEM_WB_RegWrite : in std_logic;
			Rs_select : out std_logic_vector(1 downto 0);
			Rt_select : out std_logic_vector(1 downto 0)
			
            
     );
end component;

component MUX2
      Port (
            In1 : in std_logic_vector(31 downto 0);
            In2 : in std_logic_vector(31 downto 0);
            selector : in std_logic;
            output : out std_logic_vector(31 downto 0)
       );
end component;

component MUX3
      Port (
            In1 : in std_logic_vector(31 downto 0);
            In2 : in std_logic_vector(31 downto 0);
			In3 : in std_logic_vector(31 downto 0);
            selector : in std_logic_vector(1 downto 0);
            output : out std_logic_vector(31 downto 0)
       );
end component;

signal Rs_select, Rt_select : std_logic_vector(1 downto 0);

signal rdata1, Inrdata2 , rdata2, SignExtended : std_logic_vector(31 downto 0);  

signal OverFlowOutput : std_logic := '0';

begin

MemToReg <= MemToRegIn; 
MemRead <= MemReadIn;	   
MemWrite <= MemWriteIn;
RegWrite <= RegWriteIn;
Read_Data2out <= Read_Data2;
SignExtended <= x"0000"&Instruction(15 downto 0); 

FUnit: ForwardingUnit port map(Instruction(31 downto 26), Instruction(25 downto 21), Instruction(20 downto 16), EX_MEM_Rd, MEM_WB_Rd, EX_MEM_RegWrite, MEM_WB_RegWrite, Rs_select, Rt_select);	 

MUX3_1: MUX3 port map(Read_Data1, EX_MEM_Val, MEM_WB_Val, Rs_select, rdata1);  

MUX3_2:	MUX3 port map(Read_Data2, EX_MEM_Val, MEM_WB_Val, Rt_select, Inrdata2);

MUXX: MUX2 port map(Inrdata2, SignExtended , ALUSrc, rdata2);

aluComp: ALU port map(rdata1, rdata2, ALUOp, ALU_result , OverFlowOutput);  

--WriteRegMuxComp: WriteRegMux port map(RegDst, Instruction(20 downto 16), Instruction(15 downto 11), w_addr);
RegWrite <= RegWriteIn when (OverFlowOutput='0') else '0';


end Behavioral;
