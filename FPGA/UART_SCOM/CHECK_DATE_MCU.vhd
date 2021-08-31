----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.06.2021 15:03:33
-- Design Name: 
-- Module Name: CHECK_DATE_MCU - Behavioral
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

entity CHECK_DATE_MCU is
 Port ( clock_i, reset_i : std_logic;
        vecout: in  std_logic_vector(0 to 51)
    
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
           

signal led_LEDManagement : std_logic_vector(7 downto 0) := "00000010";
signal totalDayNumber_Check : std_logic_vector(2 downto 0) := "000";
signal checkE_FSMCalendarCounters : std_logic := '0';
signal dispDDMM_FSMCalendarCounters : std_logic := '0';
signal day_FSMCalendarCounters : std_logic_vector(4 downto 0) := "00001";
signal month_FSMCalendarCounters : std_logic_vector(3 downto 0) := "0001";
signal year_FSMCalendarCounters : std_logic_vector(10 downto 0) := "11111000000";
signal CESlow_ClockManagement : std_logic := '0';
begin

inst_Check : Check2
		port map(
		      day => day_FSMCalendarCounters,
              month => month_FSMCalendarCounters,
              year => year_FSMCalendarCounters,
              totalDayNumber => totalDayNumber_Check
              );
              
              
inst_LEDManagement : LEDManagement2
        port map(
              clock => clock_i,
              reset => reset_i,
              CESlow => CESlow_ClockManagement,
              checkE => checkE_FSMCalendarCounters,
              totalDayNumber => totalDayNumber_Check,
              led => led_LEDManagement
              );


end Behavioral;
