library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HazardDetectionUnit is 
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
end HazardDetectionUnit;



architecture HazardDetectionUnit of HazardDetectionUnit is
begin

	process(ID_Ex_MemRead, ID_Ex_Reg, IF_ID_Rs, IF_ID_Rt, Opcode, Func, ID_Ex_RegWrite, Ex_MEM_RegWrite, Ex_MEM_Reg)
	begin 
		
		if(Opcode = "000000") then
			if(Func = "001000") then 
				if(((ID_Ex_RegWrite = '1') and (IF_ID_Rs = ID_Ex_Reg)) or ((Ex_MEM_RegWrite = '1') and (IF_ID_Rs = Ex_MEM_Reg))) then	  --Stall for jumping
					stall <= '1';
				else
					stall <= '0';
				end if;
			else
				if(ID_Ex_MemRead = '1') then
					if((IF_ID_Rs = ID_Ex_Reg) or (IF_ID_Rt = ID_Ex_Reg)) then  --Stall for Add, Sub, OR, AND
						stall <= '1';
					else
						stall <= '0';
					end if;
				else
					stall <= '0';
				end if;
			end if;
		elsif(Opcode = "000101") then  -- Stall for BEQZ
			if(((ID_Ex_RegWrite = '1') and ((IF_ID_Rs = ID_Ex_Reg) or (IF_ID_Rt = ID_Ex_Reg))) or ((Ex_MEM_RegWrite = '1') and ((IF_ID_Rs = Ex_MEM_Reg) or (IF_ID_Rt = Ex_MEM_Reg)))) then	  --Stall for jumping
				stall <= '1';
			else
				stall <= '0';
			end if;
		else
			if(ID_Ex_MemRead = '1') then -- Stall for other instructions
				if(Opcode = "101011" )then
					if((IF_ID_Rs = ID_Ex_Reg) or (IF_ID_Rt = ID_Ex_Reg)) then 
						stall <= '1';
					else
						stall <= '0';
					end if;
				else
					if(IF_ID_Rs = ID_Ex_Reg) then 
						stall <= '1';
					else
						stall <= '0';
					end if;
				end if;
			else
				stall <= '0';
			end if;
		end if;
		
	end process;
	
	

end HazardDetectionUnit;
