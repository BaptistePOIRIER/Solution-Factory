----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.06.2021 10:28:04
-- Design Name: 
-- Module Name: ClockManagement - Behavioral
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

--111101000010010000
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
use IEEE.STD_LOGIC_unsigned.ALL;

entity ClockManagement is
    port( clock, reset    : in    std_logic;
		  CESlow            : out    std_logic;
		  CEDebounce        : out   std_logic;
		  clockEnableDisplay: out   std_logic
		);
end ClockManagement;




architecture Behavioral of ClockManagement is
signal clk_s : std_logic;
signal CESL : std_logic;
signal CEDeB : std_logic;
signal clockED : std_logic;
signal cpt200hz : std_logic_vector(17 downto 0) := "000000000000000000";
signal cpt4hz : std_logic_vector(23 downto 0) := "000000000000000000000000";

--signaux internes
signal clk20Mhz_i : std_logic := '0';
signal clk20khz_i : std_logic := '0';
signal clk200hz : std_logic := '0';
signal clk4hz : std_logic := '0';


begin
    cpt50million : process(clock, reset, clk200hz) is
begin

if reset = '1' then 
    cpt200hz <= "000000000000000000";
    clk200hz <= '0';
elsif  rising_edge(clock) then
    
--    if cpt20Mhz = "0110010" then
if cpt200hz = "111101000010001111" then
        cpt200hz <= "000000000000000000";
        clk200hz <= not clk200hz;
    else
        cpt200hz <= cpt200hz + 1;
    end if;


if cpt4hz = "101111101011110000011111" then
        cpt4hz <= "000000000000000000000000";
        clk4hz <= not clk4hz;
    else
        cpt4hz <= cpt4hz + 1;
    end if;
end if;

end process;

                
 CEDebounce <= clk200hz;
 clockEnableDisplay <= clk200hz;
 CESlow <= clk4hz;
 


------------------------------------------------------------------------------------
-- PARTIE POUR LE 4HZ  
 
--PClock : process(clk, reset,CESL , CEDeB,clockED ) is 
--begin 
--    if reset = '1' then 
--         clk_s <= '0';
--         CESL <= '0';
--         CEDeB <= '0';
--         clockED <= '0';
--    elsif rising_edge(clk) then
--        CESL <= '1'; --il nous faut un diviseur d'horlige a 4Hz
--        CEDeB <= '1'; -- 
--        clockED <= '1'; -- il nous faut un diviseur d'horlige a 200Hz
--    end if;
--end process PClock;
    



end Behavioral;

