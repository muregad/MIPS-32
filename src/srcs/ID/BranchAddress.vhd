library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity BranchAddress is
    Port (
            Read_data2 : in std_logic_vector(31 downto 0);
            offset : in std_logic_vector(15 downto 0);
            address : out std_logic_vector(31 downto 0)
     );
end BranchAddress;

architecture Behavioral of BranchAddress is

begin

address <= std_logic_vector(to_signed(to_integer(signed(Read_data2)) + to_integer(signed(x"0000"&offset)) , 32));

end Behavioral;
