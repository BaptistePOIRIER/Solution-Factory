library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sync is
  Port (
  CEDebounce,reset,buttonMore,buttonChoice,buttonCheck: in std_logic;
  buttonMoreSync,buttonChoiceSync,buttonCheckSync: out std_logic
   );
end Sync;

architecture Behavioral of Sync is

begin
    process(reset,CEDebounce,buttonMore,buttonChoice,buttonCheck)
    begin
        if reset ='1' then
            buttonMoreSync<='0';
            buttonChoiceSync<='0';
            buttonCheckSync<='0';
        elsif rising_edge (CEDebounce)  then 
             case buttonMore is
             when '1' => buttonMoreSync <= '1';
             when others => buttonMoreSync <= '0';
 end case;
            case buttonChoice is
                when '1' => buttonChoiceSync <= '1';
                when others => buttonChoiceSync <= '0';
end case;  
            case buttonCheck is
                when '1' => buttonCheckSync <= '1';
                when others => buttonCheckSync <= '0';
end case;          
        end if;
    end process;
end Behavioral;
