library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity CHECK_CODE is
  Port (    vecout : in std_logic_vector(51 downto 0);
            clock  : in std_logic; 
            CheckE : in std_logic;
            reset : in std_logic;
            resE2 : out std_logic;
            result2 : out std_logic
            
   );
end CHECK_CODE;



architecture Behavioral of CHECK_CODE is

type memory is array(15 downto 0) of std_logic_vector(51 downto 0);
        signal mem : memory := ("0000000000000000000000000000000000000000000000000000",
                                "0000000000000000000000000000000000000000000000000001",
                                "0000000000000000000000000000000000000000000000000000",
                                "0000000000000000000000000000000000000000000000000000",
                                "0000000000000000000000000000000000000000000000000000",
                                "0000000000000000000000000000000000000000000000000000",
                                "0000000000000000000000000000000000000000000000000000",
                                "0000000000000000000000000000000000000000000000000000",
                                "0000000100000001000110010101000001100000000000000000",
                                "0011000100010010000110011001100101001001100110011001",
                                "0010100100000010000110011001011000110100011110010010",
                                "0001010100000100000110011001011000110010000010000110",
                                "0010000000000111000110010110100101100111100001000011",
                                "0000001000001001000110011000011000010001100001100100",
                                "0010010000010010000110010101001000100000100100010110",
                                "0000100100000011000110010111000000000101010000010000"
                        );



begin
check :process(checkE, reset, clock) 
begin 
        if (reset= '1') then
            resE2 <= '0';
            result2 <= '0'; 
        elsif (checkE = '1') then
            result2 <= '0';
            for i in mem' range loop
                if (i = vecout) then 
                    result2 <= '1';
                end if;
            end loop;
            resE2 <= '1';
        else
            resE2 <= '0';
        end if;    
             
            
end process;

end Behavioral;