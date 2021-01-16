library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is
component ALU
      Port (
            r_data1 : in std_logic_vector(31 downto 0);
            r_data2 : in std_logic_vector(31 downto 0);
            ALUOp : in std_logic_vector(1 downto 0);
            ALU_result : out std_logic_vector(31 downto 0)
       );
end component;

signal r_data1 , r_data2 : std_logic_vector(31 downto 0);
signal ALUOp : std_logic_vector(1 downto 0);
signal ALU_result : std_logic_vector(31 downto 0);

begin

uut: ALU port map(r_data1 , r_data2 , ALUOP , ALU_result);

process
begin 
r_data1 <= x"ABCDEF48";
r_data2 <= x"24567DFC";
ALUOP <= "00";
wait for 10ns;
ALUOP <= "01";
wait for 10ns;
ALUOP <= "10";
wait for 10ns;
ALUOP <= "11";
wait for 10ns;

end process;


end Behavioral;
