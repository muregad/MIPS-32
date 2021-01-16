
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity Reg_file_tb is
--  Port ( );
end Reg_file_tb;

architecture Behavioral of Reg_file_tb is

component Reg_file
    Port ( 
       clk , reset : in std_logic; 
       r_addr1, r_addr2, w_addr : in std_logic_vector(4 downto 0);
       w_data : in std_logic_vector(31 downto 0);
       r_data1, r_data2 : out std_logic_vector(31 downto 0)
        );
end component;

signal clk, reset : std_logic := '0';
signal r_addr1, r_addr2, w_addr : std_logic_vector(4 downto 0);
signal r_data1, r_data2, w_data : std_logic_vector(31 downto 0);

begin

regFile: Reg_file port map(clk , reset , r_addr1 , r_addr2 , w_addr , w_data, r_data1 ,r_data2);

clkk: process
        begin
            clk <= '1'; wait for 5ns;
            clk <= '0'; wait for 5ns;
     end process;

uut: process
        begin
            r_addr1 <= "00000"; r_addr2 <= "00000"; w_data <= x"FFFFFFFF"; w_addr <= "00001"; wait for 10ns;
            r_addr1 <= "00000"; r_addr2 <= "00000"; w_data <= x"FACBFACB"; w_addr <= "00010"; wait for 10ns;
            w_addr <= "00000"; r_addr1 <= "00001"; r_addr2 <= "00010"; wait for 10ns;
        end process;


end Behavioral;
