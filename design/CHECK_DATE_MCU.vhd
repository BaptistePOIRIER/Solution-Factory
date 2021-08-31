library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CHECK_DATE_MCU is
 Port ( clock, reset : std_logic;
        vecout: in std_logic_vector(0 to 51);
        resE: out std_logic;
        result: out boolean;
        led : out STD_LOGIC_VECTOR(7 downto 0)
        );

end CHECK_DATE_MCU;

architecture Behavioral of CHECK_DATE_MCU is

component check2 is
Port ( vecout: in  std_logic_vector(0 to 51);
            totalDayNumber : out STD_LOGIC_VECTOR (2 downto 0);
            reset : in std_logic;
            resE : out std_logic;
            result : out boolean
           );
end component;

component LEDManagement2 is

 Port ( clock : in STD_LOGIC;
           CESlow : in std_logic;
           reset : in STD_LOGIC;
           checkE : in STD_LOGIC;
           totalDayNumber : in STD_LOGIC_VECTOR (2 downto 0);
           led : out STD_LOGIC_VECTOR (7 downto 0)
           );
end component;
           
signal totalDayNumber_Check : std_logic_vector(2 downto 0) := "000";
signal checkE_FSMCalendarCounters : std_logic := '0';
signal CESlow_ClockManagement : std_logic := '0';

begin

inst_Check : Check2
		port map(
		      vecout => vecout,
              totalDayNumber => totalDayNumber_Check,
              reset => reset,
              resE => resE,
              result => result
              );
              
              
inst_LEDManagement : LEDManagement2
        port map(
              clock => clock,
              reset => reset,
              CESlow => CESlow_ClockManagement,
              checkE => checkE_FSMCalendarCounters,
              totalDayNumber => totalDayNumber_Check,
              led => led
              );

end Behavioral;
