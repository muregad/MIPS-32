library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MIPS32 is
	port(
	  	clk : in std_logic;
		clkPC : in std_logic
	);
end MIPS32;



architecture Behavioral of MIPS32 is

component IF_And_Reg
	port(
			clk : in std_logic;
			clkPC : in std_logic;
			stall: in std_logic;
			JumpAddress : in  std_logic_vector(31 downto 0);
			BranchAddress : in std_logic_vector(31 downto 0);
			Jump : in std_logic;
			Branch : in std_logic;
			PCsrc : in std_logic;
			InsMemOut :out std_logic_vector (31 downto 0)
	);
end component;

signal stall, Jump, Branch, PCsrc : std_logic := '0';
signal JumpAddress, BranchAddress, InsMemOut : std_logic_vector(31 downto 0) := x"FFFFFFFF";

component ID
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
end component; 

signal ID_EX_Rd , ID_Rd : std_logic_vector(4 downto 0) := "00000";

signal RegWriteInID, ID_Ex_MemReadID, RegDstID, RegWriteOutID, ALUSrcID, MemWriteID, MemReadID, MemToRegID, BranchID, JumpID, stallID : std_logic := '0'; 
signal w_dataID, Read_data1ID, Read_data2ID, InstructionOutID, JumpAddressID, BranchAddressID : std_logic_vector(31 downto 0) := x"FFFFFFFF";
signal w_addrID, ID_EX_RegID : std_logic_vector(4 downto 0);
signal ALUOpID : std_logic_vector(1 downto 0):= "00";

component ID_EX_Reg
	
	port(
			clk : in std_logic;	
			stall : in std_logic;
			
			Read_data1In : in std_logic_vector (31 downto 0);
            Read_data2In : in std_logic_vector (31 downto 0);
       		InstructionIn : in std_logic_vector (31 downto 0);	
			JAddressIn : in std_logic_vector(31 downto 0);
			Branch_addressIn : in std_logic_vector(31 downto 0);  
			w_addrIn : in std_logic_vector(4 downto 0);
            RegDstIn : in std_logic;
            RegWriteOutIn : in std_logic;
            ALUSrcIn : in std_logic;
            MemWriteIn : in std_logic;
            ALUOpIn : in std_logic_vector(1 downto 0);
            MemReadIn : in std_logic;
            MemToRegIn : in std_logic;
            BranchIn : in std_logic;
			JumpIn : in std_logic;
            	 
			
			Read_data1 : out std_logic_vector (31 downto 0);
            Read_data2 : out std_logic_vector (31 downto 0);
            Instruction : out std_logic_vector (31 downto 0); 
			JAddress : out std_logic_vector(31 downto 0);
			Branch_address : out std_logic_vector(31 downto 0);
			w_addrOUT : out std_logic_vector(4 downto 0);
            RegDst : out std_logic;
            RegWriteOut : out std_logic;
            ALUSrc : out std_logic;
            MemWrite : out std_logic;
            ALUOp : out std_logic_vector(1 downto 0);
            MemRead : out std_logic;
            MemToReg : out std_logic;
            Branch : out std_logic;
			Jump : out std_logic
            
	
	
	);
	
end component;

signal Read_data1IDReg, Read_data2IDReg, InstructionIDReg : std_logic_vector(31 downto 0) := x"FFFFFFFF";
signal RegDstIDReg, RegWriteOutIDReg, ALUSrcIDReg, MemWriteIDReg, MemReadIDReg, MemToRegIDReg : std_logic := '0';
signal ALUOpIDReg : std_logic_vector(1 downto 0) := "00";

component EX_And_Reg 
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
end component;


signal ALU_result, Read_Data2EX : std_logic_vector(31 downto 0) := x"FFFFFFFF";
signal w_addrEX : std_logic_vector(4 downto 0) := "00001";	
signal MemToRegEX, MemReadEX, MemWriteEX, RegWriteEX : std_logic := '0';

component MEM_And_Reg 
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
end component;

signal ALU_resultMEM, MemoryDataMEM : std_logic_vector(31 downto 0) := x"FFFFFFFF";
signal RegWriteMEM, MemToRegMEM : std_logic := '0';


component WB	  
	Port (
			MemToReg : in std_logic;
			ALU_result : in std_logic_vector(31 downto 0);
			MemoryData : in std_logic_vector(31 downto 0);
			
			WriteData : out std_logic_vector(31 downto 0)
	);
end component;
signal st : std_logic := '0';
begin 
	
u1: IF_And_Reg port map(
			clk,
			clkPC,
			stallID,
			JumpAddress,
			BranchAddress,
			Jump,
			Branch,
			PCsrc,
			InsMemOut);
			

u2: ID port map(
			InsMemOut,
            RegWriteInID,
            w_addrID,
            w_dataID,
			MemReadIDReg,
			ID_EX_Rd, --------
			w_addrEX,-------
			RegWriteOutIDReg,
			RegWriteEX,
			st,
			
			
            Read_data1ID,
            Read_data2ID,	
            JumpAddressID,
			BranchAddressID,
            InstructionOutID,
			ID_Rd,
            RegDstID,
            RegWriteOutID,
            ALUSrcID,
            MemWriteID,
            ALUOpID,
            MemReadID,
            MemToRegID,
            BranchID,
			JumpID,
			stallID
    );
 


u3: ID_EX_Reg port map(
			clk,	
			stallID,
			Read_data1ID,
            Read_data2ID,
       		InstructionOutID,	
			JumpAddressID,
			BranchAddressID,
			ID_Rd,
            RegDstID,
            RegWriteOutID,
            ALUSrcID,
            MemWriteID,
            ALUOpID,
            MemReadID,
            MemToRegID,
            BranchID,
			JumpID,
            	 
			Read_data1IDReg,
            Read_data2IDReg,
            InstructionIDReg,
			JumpAddress,
			BranchAddress,
			ID_EX_Rd,
            RegDstIDReg,
            RegWriteOutIDReg,
            ALUSrcIDReg,
            MemWriteIDReg,
            ALUOpIDReg,
            MemReadIDReg,
            MemToRegIDReg,
            Branch,
			Jump);
st <= Jump or Branch;
	

u4: EX_And_Reg port map(
				clk,
				Read_data1IDReg,
            	Read_data2IDReg,
				InstructionIDReg,
				w_addrEX ,  
				w_addrID, -- look at the cases when Rs, Rt are not meant for regs 
				ALU_result,
				w_dataID, -- to be 
				ID_EX_Rd,-- add destination address
				RegWriteEX,
				RegWriteInID,
            	RegDstIDReg, 
            	RegWriteOutIDReg,
            	ALUSrcIDReg,
            	MemWriteIDReg,
            	ALUOpIDReg,
            	MemReadIDReg,
            	MemToRegIDReg,
				
				ALU_result,
				Read_Data2EX,
				w_addrEX,
				MemToRegEX, 
				MemReadEX,	   
				MemWriteEX,
				RegWriteEX);
				
u5: MEM_And_Reg port map( 
			clk,
			ALU_result,
			Read_Data2EX,
			w_addrEX,	
			MemToRegEX,
			MemReadEX,	   
			MemWriteEX,
			RegWriteEX,
			ALU_resultMEM,
			MemoryDataMEM,
			w_addrID,
			RegWriteInID,
			MemToRegMEM);



u6: WB Port map(
			MemToRegMEM ,
			ALU_resultMEM,
			MemoryDataMEM,
			w_dataID);

	
					


					

end Behavioral;
