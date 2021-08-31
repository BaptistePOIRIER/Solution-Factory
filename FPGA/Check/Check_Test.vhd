library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Check_Test is
end Check_Test;

architecture checkArch of Check_Test is
   component Check
    Port ( day : in STD_LOGIC_VECTOR (4 downto 0);
           month : in STD_LOGIC_VECTOR (3 downto 0);
           year : in STD_LOGIC_VECTOR (10 downto 0);
           totalDayNumber : out STD_LOGIC_VECTOR (2 downto 0)
           );
    end component;
    
    signal day_i : std_logic_vector(4 downto 0) := "00001";
    signal month_i : std_logic_vector(3 downto 0) := "0001";
    signal year_i : std_logic_vector(10 downto 0) := "11110011110";
    signal totalDayNumber_i : std_logic_vector(2 downto 0);
   
begin

    InstCheck : Check
        port map (
            day => day_i,
            month => month_i,
            year => year_i,
            totalDayNumber => totalDayNumber_i
        );
        
        check_proc : process
        begin
            
            day_i <= "11101";
            month_i <= "0010";
            year_i <= "11110111100";
            wait for 30ms;
            day_i <= "10000";
            month_i <= "0110";
            year_i <= "11111100101";
            wait for 30ms;
            day_i <= "01011";
            month_i <= "1011";
            year_i <= "11101111110";
            wait for 30ms;
            day_i <= "11101";
            month_i <= "0010";
            year_i <= "11110111010";
            wait for 30ms;
            day_i <= "01101";
            month_i <= "1100";
            year_i <= "11110111010"; --
            wait for 30ms;
            day_i <= "10010";
            month_i <= "0110";
            year_i <= "11110010100";
            wait for 30ms;
            day_i <= "11101";
            month_i <= "0001";
            year_i <= "11110101011"; --
            wait for 30ms;
            day_i <= "11101";
            month_i <= "0010";
            year_i <= "11111010101";
            wait for 30ms;
            day_i <= "11111";
            month_i <= "0100";
            year_i <= "11111010011";
            wait for 30ms;
            day_i <= "11101";
            month_i <= "0010";
            year_i <= "11110111100";--
            wait;
            
        end process;


end checkArch;
