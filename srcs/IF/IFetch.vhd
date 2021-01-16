library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity IFetch is
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
end IFetch;

architecture Behavioral of IFetch is



component InstructionMemory
	Port (
			PC: in std_logic_vector (31 downto 0);
			InsMemOut :out std_logic_vector (31 downto 0)
			);
end component;	  

component ProgramCounter
	Port ( 	  
			clk : in std_logic;
			stall :in std_logic;
			JumpAddress : in  std_logic_vector(31 downto 0);
			BranchAddress : in std_logic_vector(31 downto 0);
			Jump : in std_logic;
			Branch : in std_logic;
			PCsrc :in std_logic;
			PCout : out std_logic_vector(31 downto 0)
);
end component;

signal PCout:std_logic_vector(31 downto 0);

begin
	
u1: ProgramCounter port map(clk, stall, JumpAddress, BranchAddress, Jump, Branch, PCsrc, PCout);

u2: InstructionMemory port map (PCout,InsMemOut);

--PC<=PCout;

end Behavioral;
