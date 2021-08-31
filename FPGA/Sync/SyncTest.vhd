----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.06.2021 12:24:56
-- Design Name: 
-- Module Name: SyncTest - Behavioral
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

entity SyncTest is
--  Port ( );
end SyncTest;

architecture SyncArch of SyncTest is

component Sync
  Port (
CEDebounce,reset,buttonMore,buttonChoice,buttonCheck: in std_logic;
buttonMoreSync,buttonChoiceSync,buttonCheckSync: out std_logic
 );
end component;
    signal CEDebounce_s : std_logic:='0';
    signal reset_s : std_logic:='0';
    signal buttonMore_s : std_logic:='0';
    signal buttonChoice_s : std_logic:='0';
    signal buttonCheck_s : std_logic:='0';
    signal buttonMoreSync_s : std_logic;
    signal buttonChoiceSync_s : std_logic;
    signal buttonCheckSync_s : std_logic;
    
begin

    InstSync : Sync
        port map(
        CEDebounce=>CEDebounce_s,
        reset=>reset_s,
        buttonMore =>buttonMore_s,
        buttonChoice=> buttonChoice_s,
        buttonCheck =>buttonCheck_s,
        buttonMoreSync=>buttonMoreSync_s,
        buttonChoiceSync=>buttonChoiceSync_s,
        buttonCheckSync=>buttonCheckSync_s
        );
        
        Sync_proc: process
        begin
        for i in 0 to 60 loop
        CEDebounce_s<= not CEDebounce_s;
        wait for 500 ns;
        if i>4 and i<25 then
        buttonMore_s<= '1';
               else 
         buttonMore_s<= '0';
        end if;
        if i>30 and i<36 then
         reset_s<= '1';
        else 
          reset_s<= '0';  
        end if;
        if i>2 then
            buttonChoice_s<= '1';
        end if;
        if i>6 then
            buttonCheck_s<= '1';
        end if;
        wait for 1ms;
        end loop;

        wait;
        end process;

end SyncArch;
