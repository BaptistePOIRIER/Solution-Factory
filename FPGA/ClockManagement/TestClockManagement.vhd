----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.06.2021 10:59:21
-- Design Name: 
-- Module Name: TestClockManagement - Behavioral
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


entity TestClockManagement is
end TestClockManagement;

architecture Behavioral of TestClockManagement is
   component ClockManagement
    port( clock, reset    : in    std_logic;
		  CESlow            : out    std_logic;
		  CEDebounce        : out   std_logic;
		  clockEnableDisplay: out   std_logic
		);
    end component;
    
    
    signal clk_signal : std_logic := '0';
    signal reset_signal : std_logic := '0';
    signal CESL_signal : std_logic;
    signal CEDB_signal : std_logic;
    signal clockED_signal : std_logic;
    
   
begin

    InstModulo : ClockManagement
        port map (
            clock => clk_signal,
            reset => reset_signal,
            CESlow => CESL_signal,
            clockEnableDisplay => clockED_signal,
            CEDebounce => CEDB_signal
        );
     
     clk_signal <= not clk_signal after 5000 ps;
   Modulo_proc : process
        
       begin

            wait;
            
       end process;

end Behavioral;


