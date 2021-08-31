----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.06.2021 14:59:54
-- Design Name: 
-- Module Name: LEDManagement2 - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LEDManagement2 is
    Port ( clock : in STD_LOGIC;
           CESlow : in std_logic;
           reset : in STD_LOGIC;
           checkE : in STD_LOGIC;
           totalDayNumber : in STD_LOGIC_VECTOR (2 downto 0);
           led : out STD_LOGIC_VECTOR (7 downto 0));
end LEDManagement2;

architecture Behavioral of LEDManagement2 is

signal CESlow2Hz : std_logic := '0';
shared variable err : boolean := false;

begin

    clk2Hz : process(CESlow) is
    begin
        if rising_edge(CESlow) then
            CESlow2Hz <= not CESlow2Hz;
        end if;
    end process;
    
    ledManagement : process(clock, CESlow2Hz) is
    begin
        if(reset = '1') then
            led <= "00000010";
            err := false;

                 
--            if rising_edge(CESlow2Hz) then
--                led <= "10101010";
--            elsif falling_edge(CESlow2Hz) then
--                led <= "01010101";
--            end if;
        elsif(rising_edge(clock)) then
        
            if(checkE = '1') then
                 
                case(totalDayNumber) is
                    when "000" => 
                        led <= "00000010";
                        err := false;
                    when "001" => 
                        led <= "10000000";
                        err := false;
                    when "010" => 
                        led <= "01000000";
                        err := false;
                    when "011" => 
                        led <= "00100000";
                        err := false;
                    when "100" => 
                        led <= "00010000";
                        err := false;
                    when "101" => 
                        led <= "00001000";
                        err := false;
                    when "110" => 
                        led <= "00000100";
                        err := false;
                    when others => 
                        err := true;

                end case;
                end if;
            end if;
       if(err) then
                            case CESlow2Hz is
                                when '1'  => led <= "10101010";
                                when others => led <= "01010101";
                            end case;
       end if;
    end process;

end Behavioral;
