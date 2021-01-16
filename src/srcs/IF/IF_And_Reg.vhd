library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;


entity IF_And_Reg is
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
end IF_And_Reg;



architecture Behavioral of IF_And_Reg is

component IF_ID_Reg
	port(
			clk: in std_logic; 
    		InstructionMem: in std_logic_vector(31 downto 0); 
      		InstMemOut : out std_logic_vector(31 downto 0)
		);  
end component;

component IFetch
	Port( 	
			clk : in std_logic;
			stall: in std_logic;
			JumpAddress : in  std_logic_vector(31 downto 0);
			BranchAddress : in std_logic_vector(31 downto 0);
			Jump : in std_logic;
			Branch : in std_logic;
			PCsrc : in std_logic;
			InsMemOut :out std_logic_vector (31 downto 0)
			--PC : out std_logic_vector(31 downto 0)
			);
end component;

signal InsMem : std_logic_vector(31 downto 0);

begin

u1: IFetch port map(clkPC, stall, JumpAddress, BranchAddress, Jump, Branch, PCsrc, InsMem);

u2: IF_ID_Reg port map(clk , InsMem, InsMemOut);
	 

end Behavioral;
