library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
	Port (

		r_data1 : in std_logic_vector(31 downto 0);
		r_data2 : in std_logic_vector(31 downto 0);
		ALUOp : in std_logic_vector(1 downto 0);
		ALU_result : out std_logic_vector(31 downto 0)
	);

end ALU;

architecture Behavioral of ALU is
begin
	
	ALU_result <= (r_data1 + r_data2) when (ALUOp = "00") else
				  (r_data1-r_data2) when (ALUOp = "01") else
				 (r_data1 and r_data2) when (ALUOp = "10") else
				 (r_data1 or r_data2); 

end Behavioral;
