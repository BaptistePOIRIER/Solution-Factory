library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LEDManagement_test is
end LEDManagement_test;

architecture LEDManagementArch of LEDManagement_test is
   component LEDManagement
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           checkE : in STD_LOGIC;
           totalDayNumber : in STD_LOGIC_VECTOR (2 downto 0);
           led : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal clock_i : std_logic := '0';
    signal reset_i : std_logic := '0';
    signal checkE_i : std_logic := '0';
    signal totalDayNumber_i : std_logic_vector(2 downto 0);
    signal led_i : std_logic_vector(7 downto 0);
   
begin

    InstLEDManagement : LEDManagement
        port map (
            clock => clock_i,
            reset => reset_i,
            checkE => checkE_i,
            totalDayNumber => totalDayNumber_i,
            led => led_i
        );
        
        clock_i <= not clock_i after 10ns;
        
        LEDManagement_proc : process
        begin
            
            totalDayNumber_i <= "001";
            wait for 50ns;
            checkE_i <= '1';
            wait for 50ns;
            totalDayNumber_i <= "010";
            wait for 50ns;
            reset_i <= '1';
            wait for 50ns;
            totalDayNumber_i <= "011";
            wait for 50ns;
            reset_i <= '0';
            totalDayNumber_i <= "001";
            wait for 50ns;
            totalDayNumber_i <= "010";
            wait for 50ns;
            totalDayNumber_i <= "011";
            wait for 50ns;
            totalDayNumber_i <= "100";
            wait for 50ns;
            totalDayNumber_i <= "101";
            wait for 50ns;
            totalDayNumber_i <= "110";
            wait for 50ns;
            totalDayNumber_i <= "000";
            wait for 50ns;
            totalDayNumber_i <= "111";
            wait;
            
            
        end process;


end LEDManagementArch;
