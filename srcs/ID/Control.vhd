library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Control is
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
end Control;

architecture Behavioral of Control is

begin

    process(OPCode, Func)
        begin
            if(OPCode = "000000") then
                Branch <= '0'; MemWrite <= '0';
                MemRead <= '0'; RegDst <= '1'; MemToReg <= '0';
                ALUSrc <= '0';
				
                if(Func = "100000") then    --ADD
                    Jump <= '0';
                    RegWrite <= '1'; ALUOp <= "00";   
                    
                elsif(Func = "100010") then --SUB
                    Jump <= '0'; 
                    RegWrite <= '1'; ALUOp <= "01"; 
                    
                elsif(Func = "100100") then --AND
                    Jump <= '0';
                    RegWrite <= '1'; ALUOp <= "10"; 
                    
                elsif(Func = "100101") then --OR
                    Jump <= '0'; 
                    RegWrite <= '1'; ALUOp <= "11"; 
                    
                elsif(Func = "001000") then --Jump
                    Jump <= '1';
                    RegWrite <= '0'; ALUOp <= "00"; 
                
                end if;
                
                 
            elsif(OPCode = "001000") then   --ADDI
                Branch <= '0'; MemWrite <= '0'; Jump <= '0';
                MemRead <= '0'; RegDst <= '0'; MemToReg <= '0';
                ALUSrc <= '1'; RegWrite <= '1'; ALUOp <= "00";
                
            elsif(OPCode = "001100") then   --SUBI
                Branch <= '0'; MemWrite <= '0'; Jump <= '0';
                MemRead <= '0'; RegDst <= '0'; MemToReg <= '0';
                ALUSrc <= '1'; RegWrite <= '1'; ALUOp <= "01";
                
            elsif(OPCode = "000101") then   --BEQZ
                Branch <= '1'; MemWrite <= '0'; Jump <= '0';
                MemRead <= '0'; RegDst <= '0'; MemToReg <= '0';
                ALUSrc <= '1'; RegWrite <= '0'; ALUOp <= "01";
                
            elsif(OPCode = "100011") then   --LW   
                Branch <= '0'; MemWrite <= '0'; Jump <= '0';
                MemRead <= '1'; RegDst <= '0'; MemToReg <= '1';
                ALUSrc <= '1'; RegWrite <= '1'; ALUOp <= "00";
                
            elsif(OPCode = "101011") then   --SW
                Branch <= '0'; MemWrite <= '1'; Jump <= '0';
                MemRead <= '0'; RegDst <= '0'; MemToReg <= '0';
                ALUSrc <= '1'; RegWrite <= '0'; ALUOp <= "00";
			else
				Branch <= '0'; MemWrite <= '0'; Jump <= '0';
                MemRead <= '0'; RegDst <= '0'; MemToReg <= '0';
                ALUSrc <= '0'; RegWrite <= '0'; ALUOp <= "00";				
            end if;
    end process;

end Behavioral;
