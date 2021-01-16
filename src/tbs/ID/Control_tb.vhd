

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Control_tb is
--  Port ( );
end Control_tb;

architecture Behavioral of Control_tb is

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

signal OPCode, Func : std_logic_vector(5 downto 0);
signal RegDst, RegWrite, ALUSrc, MemWrite, MemRead, MemToReg, Branch, Jump: std_logic;
signal ALUOp : std_logic_vector(1 downto 0);

begin

cntrl: Control port map(OPCode, Func, RegDst, RegWrite, ALUSrc, MemWrite, ALUOp, MemRead, MemToReg, Branch, Jump);


process
begin

OPCode <= "000000"; Func <= "001000"; wait for 10ns;    --jmp
OPCode <= "100011"; Func <= "001000"; wait for 10ns;    --LW
OPCode <= "101011"; Func <= "001000"; wait for 10ns;    --SW
OPCode <= "000101"; Func <= "001000"; wait for 10ns;    --BEQZ


end process;

end Behavioral;
