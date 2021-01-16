library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity JumpAddress is
    Port (
            Rs : in std_logic_vector(31 downto 0);
            offset : in std_logic_vector(14 downto 0);
            address : out std_logic_vector(31 downto 0)
     );
end JumpAddress;

architecture Behavioral of JumpAddress is

begin

address <= std_logic_vector(to_signed(to_integer(signed(Rs)) + to_integer(signed('0'&x"0000"&offset)) , 32));

end Behavioral;
