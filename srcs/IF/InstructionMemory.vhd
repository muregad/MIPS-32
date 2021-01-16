
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;

entity InstructionMemory is
	
	Port (
			PC: in std_logic_vector (31 downto 0);
			InsMemOut :out std_logic_vector (31 downto 0)
		);
end InstructionMemory;

architecture Behavioral of InstructionMemory is
--Instructions should be updated 
type Memory is array (0 to 4) of std_logic_vector (31 downto 0);	

signal memorySig: Memory:=(
						"10001100000000010000000000010100", -- LW R1, 20, R0
						"10001100000000100000000000010101", -- LW R2, 21, R0
						"00000000010000010000100000100000", -- ADD R1, R2,R1
						"00000000010000010000100000100000", -- ADD R1, R2,R1
						"00100000001000100000000000000101" -- ADDI R2, R1, 5
							);  


begin

InsMemOut <= memorySig(to_integer(unsigned(PC)));

end Behavioral;
