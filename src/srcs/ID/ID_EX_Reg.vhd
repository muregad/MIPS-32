library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ID_EX_Reg is	
	
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
	
end ID_EX_Reg;


architecture ID_EX_Reg of ID_EX_Reg is 



begin

	process(clk)
        begin
           
            if(clk'event and clk = '1') then
				if(stall = '0') then
					Read_data1 <= Read_data1In;
					Read_data2 <= Read_data2In;	 
					Instruction <= InstructionIn;
					JAddress <= JAddressIn;
					Branch_address <= Branch_addressIn;
					RegDst <= RegDstIn;
					RegWriteOut	<= RegWriteOutIn;  
					ALUSrc <= ALUSrcIn; 
					MemWrite <= MemWriteIn;
					ALUOp <= ALUOpIn;	
					MemRead <= MemReadIn;	 
					MemToReg <= MemToRegIn;  
					Branch <= BranchIn;
					Jump <= JumpIn;
					w_addrOUT <= w_addrIn;
					
				else   
					Read_data1 <= x"00000000";
					Read_data2 <= x"00000000";	 
					Instruction <= "11111100000000000000000000000000";
					JAddress <= JAddressIn;
					Branch_address <= Branch_addressIn;
					RegDst <= RegDstIn;
					RegWriteOut	<= '0';  
					ALUSrc <= ALUSrcIn; 
					MemWrite <= '0';
					ALUOp <= "00";	
					MemRead <= '0';	 
					MemToReg <= '0';  
					Branch <= '0';
					Jump <= '0'; 
					w_addrOUT <= "00000";
				end if;
					
                
            end if;
    end process;

end ID_EX_Reg;
