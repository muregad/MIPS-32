library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity Reg_file is
    Port ( 
           clk : in std_logic; 
           r_addr1, r_addr2, w_addr : in std_logic_vector(4 downto 0);
           w_data : in std_logic_vector(31 downto 0);
           r_data1, r_data2 : out std_logic_vector(31 downto 0)
    
    );
end Reg_file;

architecture Behavioral of Reg_file is

type regs32 is array(2**5-1 downto 0) of std_logic_vector(31 downto 0);
signal registers : regs32 := (others => (others => '0'));	 


begin

    process(clk, w_data, w_addr)
        begin
           
            if(clk = '1') then
                --if(w_addr /= "00000") then
                registers(to_integer(unsigned(w_addr))) <= w_data; 
                 --end if;
            end if;
    end process;
    
    r_data1 <= registers(to_integer(unsigned(r_addr1)));
    r_data2 <= registers(to_integer(unsigned(r_addr2)));

end Behavioral;
