----------------------------------------------------------------------------------
-- Solution Factory
-- Bloc : Testbench FSMCalendarCounters
-- Equipe N°412
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity FSMCalender_Counters_test is
--  Port ( );
end FSMCalender_Counters_test;

architecture Behavioral of FSMCalender_Counters_test is
 Component FSMCalendarCounters is
  port (     clock : in STD_LOGIC;
             reset : in STD_LOGIC;
             CESlow : in STD_LOGIC;
             buttonMoreSync : in STD_LOGIC;
             buttonChoiceSync : in STD_LOGIC;
             buttonCheckSync : in STD_LOGIC;
             checkE : out STD_LOGIC;
             dispDDMM : out STD_LOGIC;
             day : out STD_LOGIC_VECTOR(4 downto 0);
             month : out STD_LOGIC_VECTOR(3 downto 0);
             year : out STD_LOGIC_VECTOR(10 downto 0));
  end Component;
  
          SIGNAL  clock_S : std_logic := '0' ;
          SIGNAL  reset_S : std_logic:='0';
          SIGNAL  CESlow_S :  STD_LOGIC := '0';
          SIGNAL  buttonMoreSync_S : STD_LOGIC;
          SIGNAL  buttonChoiceSync_S : STD_LOGIC;
          SIGNAL  buttonCheckSync_S :  STD_LOGIC;
          SIGNAL  checkE_S :  STD_LOGIC;
          SIGNAL  dispDDMM_S :  STD_LOGIC;
          SIGNAL  day_S : STD_LOGIC_VECTOR(4 downto 0);
          SIGNAL  month_S : STD_LOGIC_VECTOR(3 downto 0);
          SIGNAL  year_S : STD_LOGIC_VECTOR(10 downto 0);
          
          
 begin
        UUT : FSMCalendarCounters
        port map (
               clock => clock_S,
               reset=> reset_S,
               CESlow => CESlow_S,
               buttonMoreSync => buttonMoreSync_S,
               buttonChoiceSync => buttonChoiceSync_S,
               buttonCheckSync => buttonCheckSync_S,
               checkE =>checkE_S,
               dispDDMM=> dispDDMM_S,
               day => day_S,
               month =>month_S,
               year =>year_S
               );
       
       
       Testing: process
       begin
       
       clock_S <= not clock_S;
       wait for 5 ns;
       
       
  end process;
     
    Testin2 : process
    begin
     
       reset_S <= '1';
       wait for 5ms;
       reset_S <= '0';
       buttonChoiceSync_S <= '0';
       wait for 5ms;
       buttonMoreSync_S <= '1'; 
       wait for 500 ms;
       buttonMoreSync_S <= '0';
       wait for 5 ms;
       buttonChoiceSync_S <= '1';
       wait for 5 ms;
       buttonChoiceSync_S <= '0';
       wait for 5 ms ;
       buttonMoreSync_S <= '1';
       wait for 500 ms;
       buttonMoreSync_S <= '0';
       wait for 5 ms;
       buttonChoiceSync_S <= '1';
       wait for 5 ms;
       buttonChoiceSync_S <= '0';
       wait for 5 ms ;
       buttonMoreSync_S <= '1';
       wait for 500 ms;
       buttonMoreSync_S <= '0';
       wait for 5 ms;
       buttonChoiceSync_S <= '1';
       wait for 5 ms;
       buttonChoiceSync_S <= '0';
       wait for 5 ms ;
       buttonMoreSync_S <= '1';
       wait;
   end process;
   
   Testing3: process
            begin
            
            CESlow_S <= not CESlow_S;
            wait for 100 us;
    
 end process;

end Behavioral;
