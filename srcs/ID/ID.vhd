library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ID is
    Port ( 
            Instruction : in std_logic_vector(31 downto 0);
            RegWriteIn : in std_logic;
            w_addr : in std_logic_vector(4 downto 0);
            w_data : in std_logic_vector (31 downto 0);
			ID_Ex_MemRead : in std_logic;
			ID_Ex_Reg : in std_logic_vector(4 downto 0); 
			Ex_MEM_Reg : in std_logic_vector(4 downto 0); --
			ID_Ex_RegWrite : in std_logic;
			Ex_MEM_RegWrite : in std_logic;
			nop : in std_logic;
			
            Read_data1 : out std_logic_vector (31 downto 0);
            Read_data2 : out std_logic_vector (31 downto 0);	
            JAddress : out std_logic_vector(31 downto 0); 
			Branch_address : out std_logic_vector(31 downto 0);
            InstructionOut : out std_logic_vector(31 downto 0);	
			w_addrOUT : out std_logic_vector(4 downto 0);
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
end ID;

architecture Behavioral of ID is

component Reg_file
    Port ( 
       clk: in std_logic; 
       r_addr1, r_addr2, w_addr : in std_logic_vector(4 downto 0);
       w_data : in std_logic_vector(31 downto 0);
       r_data1, r_data2 : out std_logic_vector(31 downto 0)
        );
end component;	

component JumpAddress
    Port (
            Rs : in std_logic_vector(31 downto 0);
            offset : in std_logic_vector(14 downto 0);
            address : out std_logic_vector(31 downto 0)
     );
end component; 

component BranchAddress
    Port (
            Read_data2 : in std_logic_vector(31 downto 0);
            offset : in std_logic_vector(15 downto 0);
            address : out std_logic_vector(31 downto 0)
     );
end component; 


component Control
    Port (
         OPCode : in std_logic_vector(5 downto 0);
         Func : in std_logic_vector(5 downto 0);
         RegDst : out std_logic;
         RegWrite : out std_logic;
         ALUSrc : out std_logic;
         MemWrite : out std_logic;
         ALUOp : out std_logic_vector(1 downto 0);
         MemRead : out std_logic;
         MemToReg : out std_logic;
         Branch : out std_logic;
         Jump : out std_logic
    );
end component; 

component HazardDetectionUnit
	port(
		ID_Ex_MemRead : in std_logic;
		ID_Ex_Reg : in std_logic_vector(4 downto 0);
		Ex_MEM_Reg : in std_logic_vector(4 downto 0);	
		IF_ID_Rs : in std_logic_vector(4 downto 0);
		IF_ID_Rt : in std_logic_vector(4 downto 0);	
		
		
		Opcode : in std_logic_vector(5 downto 0);
		Func : in std_logic_vector(5 downto 0);	
		
		ID_Ex_RegWrite : in std_logic;
		Ex_MEM_RegWrite : in std_logic;
		
		stall : out std_logic
	);
end component;	

component WriteRegMux
	port(
			RegDst : in std_logic;
			Inst20_16 : in std_logic_vector (4 downto 0);
            Inst15_11 : in std_logic_vector (4 downto 0);	  
			w_addr : out std_logic_vector (4 downto 0)
	
	);
end component; 

signal rd1,rd2 : std_logic_vector(31 downto 0);
signal instr : std_logic_vector(31 downto 0);  
signal RegDstt : std_logic;

begin

instr <= Instruction when(nop = '0') else
		"11111100000000000000000000000000";
InstructionOut <= instr;



regFile: Reg_file port map(RegWriteIn , instr(25 downto 21), instr(20 downto 16), w_addr , w_data, rd1 ,rd2);

HazardDetectionComp: HazardDetectionUnit port map(ID_Ex_MemRead, ID_Ex_Reg, Ex_MEM_Reg ,instr(25 downto 21), instr(20 downto 16), instr(31 downto 26), instr(5 downto 0), ID_Ex_RegWrite, Ex_MEM_RegWrite ,stall);

cntrl: Control port map(instr(31 downto 26), instr(5 downto 0), RegDstt, RegWriteOut, ALUSrc, MemWrite, ALUOp, MemRead, MemToReg, Branch, Jump);

WriteRegMuxComp: WriteRegMux port map(RegDstt, instr(20 downto 16), instr(15 downto 11), w_addrOUT);

RegDst <= RegDstt;
Read_data1 <= rd1;
Read_data2 <= rd2;

JumpaddressComp: JumpAddress port map(rd1, instr(20 downto 6), JAddress); 
BranchAddressComp: BranchAddress port map(rd2, instr(15 downto 0), Branch_address);



end Behavioral;
