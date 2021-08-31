----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.06.2021 12:02:35
-- Design Name: 
-- Module Name: Sync - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
--            if buttonChoice='1' then
--                buttonChoiceSync<='1';
--            end if;
--            if buttonCheck='1' then
--                buttonCheckSync<='1';
--            end if;

--        else
--            buttonMoreSync<='0';
--            buttonChoiceSync<='0';
--            buttonCheckSync<='0';
        end if;
    end process;
end Behavioral;
