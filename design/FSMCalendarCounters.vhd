----------------------------------------------------------------------------------
-- Solution Factory
-- Bloc : FSMCalendarCounters
-- Equipe N°412
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity FSMCalendarCounters is
    port(   clock : in STD_LOGIC;
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
end FSMCalendarCounters;

architecture automate of FSMCalendarCounters is

    -- Signaux des différents états
    type states is (WAIT_MODIFY_DAY,WAIT_MODIFY_MONTH,WAIT_MODIFY_YEAR,MODIFY_DAY,MODIFY_MONTH,MODIFY_YEAR,INCR_DAY,INCR_MONTH,INCR_YEAR);
    signal state : states;
    signal dispDDMM_in : STD_LOGIC := '1';

    -- Signaux pour les compteurs
    signal day_counter : STD_LOGIC_VECTOR(4 downto 0) := "00001";
    signal month_counter : STD_LOGIC_VECTOR(3 downto 0) := "0001";
    signal year_counter : STD_LOGIC_VECTOR(10 downto 0) := "11110011110";

begin
    
    -- Process effectuant la machine d'état
    FSM : process(clock, reset, CESlow, buttonMoreSync, buttonChoiceSync, buttonCheckSync)
    begin
        if (reset = '1') then
          state <= WAIT_MODIFY_DAY;
          day_counter <= "00001";
          month_counter <= "0001";
          year_counter <= "11110011110";
          dispDDMM_in  <='1';

        elsif rising_edge (CESlow)   then 
 --           elsif  (clock='1')   then
            case(state) is
                when WAIT_MODIFY_DAY =>
                    if(buttonChoiceSync = '0') then
                        state <= MODIFY_DAY;
                    end if;

                when MODIFY_DAY =>
                    if (buttonChoiceSync = '1') then
                        state <= WAIT_MODIFY_MONTH;
                    elsif (buttonMoreSync = '1') then
                        state <= INCR_DAY;
                        if day_counter = "11111" then
                            day_counter <= "00001";
                        else
                            day_counter <= day_counter + 1;
                        end if;
                    end if;

                when INCR_DAY =>
                    if (buttonMoreSync = '0') then
                        state <= MODIFY_DAY;
--                    elsif rising_edge(CESlow)   then
                    else   
                        if day_counter = "11111" then
                            day_counter <= "00001";
                        else
                            day_counter <= day_counter + 1;
                        end if;
                    end if;

                when WAIT_MODIFY_MONTH =>
                    if (buttonChoiceSync = '0') then
                        state <= MODIFY_MONTH;
                    end if;
                when MODIFY_MONTH =>
                    if (buttonChoiceSync = '1') then
                        state <= WAIT_MODIFY_YEAR;
                        dispDDMM_in <= '0';
                    elsif (buttonMoreSync = '1') then
                        state <= INCR_MONTH;
                        if month_counter = "1100" then
                            month_counter <= "0001";
                        else
                            month_counter <= month_counter + 1;
                        end if;
                    end if;

                when INCR_MONTH =>
                    if (buttonMoreSync = '0') then
                        state <= MODIFY_MONTH;
--                    elsif  rising_edge(CESlow)  then
else
                        if month_counter = "1100" then
                            month_counter <= "0001";
                        else
                            month_counter <= month_counter + 1;
                        end if;
                    end if;

                when WAIT_MODIFY_YEAR =>
                    if (buttonChoiceSync = '0') then
                        state <= MODIFY_YEAR;
                    end if;

                when MODIFY_YEAR =>
                    if (buttonChoiceSync = '1') then
                        state <= WAIT_MODIFY_DAY;
                        dispDDMM_in <= '1';
                    elsif (buttonMoreSync = '1') then
                        state <= INCR_YEAR;
                        if year_counter = "11111001111" then
                            year_counter <= "11110011110";
                        else
                            year_counter <= year_counter + 1;
                        end if;
                    end if;

                when INCR_YEAR =>
                    if (buttonMoreSync = '0') then
                        state <= MODIFY_YEAR;
--                    elsif  rising_edge(CESlow)  then
else
                        if year_counter = "11111001111" then
                            year_counter <= "11110011110";
                        else
                            year_counter <= year_counter + 1;
                        end if;
                    end if;

                when others =>
                    state <= WAIT_MODIFY_DAY;
            end case;
        end if;

    end process;

    -- Process implicites d'affectations immédiates des signaux de sortie
    day <= day_counter;
    month <= month_counter;
    year <= year_counter;
    dispDDMM <= dispDDMM_in;
    checkE <= buttonCheckSync;

end automate;
