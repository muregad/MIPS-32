library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity MIPS32_tb is
end MIPS32_tb;

--}} End of automatically maintained section

architecture MIPS32_tb of MIPS32_tb is

component MIPS32
	port(
	clk : in std_logic;
	clkPC : in std_logic
	);
end component;

signal clk : std_logic := '1'; 
signal clkPC : std_logic := '1';

begin

uut: MIPS32 port map(clk , clkPC);
	
process
begin
	clk <= not clk;
	wait for 10ns;
end process;

process
begin
	clkPC <= not clkPC;
	wait for 11ns; 
	clkPC <= not clkPC;
	wait for 9ns; 
end process;
	
	 

end MIPS32_tb;
