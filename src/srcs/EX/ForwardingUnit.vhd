library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ForwardingUnit is	
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
end ForwardingUnit;



architecture ForwardingUnit of ForwardingUnit is
begin

process(Opcode, Rs, Rt, EX_MEM_Rd, MEM_WB_Rd, EX_MEM_RegWrite, MEM_WB_RegWrite)
begin
	

	if(Opcode = "000000" or Opcode = "101011")then	   				-- SW, ADD, SUB, AND, OR	has both Rs, Rt to be forwarded
		if((Rs = EX_MEM_Rd) and (EX_MEM_RegWrite = '1'))then
			 Rs_select <= "01";
		elsif((Rs = MEM_WB_Rd) and (MEM_WB_RegWrite = '1'))then	
			Rs_select <= "10";
		else 
			Rs_select <= "00";
		end if;
		
		if((Rt = EX_MEM_Rd) and (EX_MEM_RegWrite = '1'))then
			 Rt_select <= "01";
		elsif((Rt = MEM_WB_Rd) and (MEM_WB_RegWrite = '1'))then	
			Rt_select <= "10";
		else 
			Rt_select <= "00";
		end if;
	else  															-- ADDI, SUBI, LW			has only Rs to be forwarded
		if((Rs = EX_MEM_Rd) and (EX_MEM_RegWrite = '1'))then
			 Rs_select <= "01";
		elsif((Rs = MEM_WB_Rd) and (MEM_WB_RegWrite = '1'))then	
			Rs_select <= "10";
		else 
			Rs_select <= "00";
		end if;	
		
		Rt_select <= "00";

	end if;	 
	
end process;


end ForwardingUnit;
