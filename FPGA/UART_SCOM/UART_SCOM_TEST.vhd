library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_uart is
 -- Port ( );
end test_uart;

architecture Behavioral of test_uart is 

component UART_SCOM is 
port(CLOCK : in std_logic;
     Reset : in std_logic;
     TX_pin : out std_logic;
     RX_pin : in std_logic;
	 SW_pins :in std_logic_vector(7 downto 0);
	 test_TX_pin : out std_logic;
	 test_RX_pin : in std_logic;
	 LED_pins :out std_logic_vector(7 downto 0);
	 SEG1_pins :out std_logic_vector(7 downto 0);
	 SEG2_pins :out std_logic_vector(7 downto 0) 
	 );
end component;

signal CLOCK_s :  std_logic := '0';
signal Reset_s : std_logic := '0';
signal TX_pin_s :  std_logic := '1';
signal RX_pin_s :  std_logic := '1';
signal SW_pins_s : std_logic_vector(7 downto 0) := (others => '0');
signal test_TX_pin_s :  std_logic := '0';
signal test_RX_pin_s :  std_logic := '0';
signal LED_pins_s : std_logic_vector(7 downto 0) := (others => '0');
signal SEG1_pins_s : std_logic_vector(7 downto 0) := (others => '0');
signal SEG2_pins_s : std_logic_vector(7 downto 0) := (others => '0');

begin


CLOCK_s <= not CLOCK_s after 5ns;

uart : UART_SCOM
port map( 

CLOCK => CLOCK_s,
Reset => Reset_s,
TX_pin => TX_pin_s,
RX_pin => RX_pin_s,
SW_pins => SW_pins_s,
test_TX_pin => test_TX_pin_s,
test_RX_pin => test_RX_pin_s,
LED_pins => LED_pins_s,
SEG1_pins => SEG1_pins_s,
SEG2_pins => SEG2_pins_s

);

test : process
    begin
        Reset_s <= '1';
        wait for 300us;
        RX_pin_s <= '1';
        Reset_s <= '0';
        wait for 300us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 200us;
        
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 200us;
     
                RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 200us;
        
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 200us;
        
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 200us;
        
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 200us;
        
                RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 200us;
        
                RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 200us;
        
                RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 200us;
        
                RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 200us;
        
                RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 200us;
        
                RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 200us;
        
                RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 200us;
        
                RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 104us;
        RX_pin_s <= '0';
        wait for 104us;
        RX_pin_s <= '1';
        wait for 200us;
        
                  RX_pin_s <= '0';
      wait for 104us;
      RX_pin_s <= '1';
      wait for 104us;
      RX_pin_s <= '0';
      wait for 104us;
      RX_pin_s <= '1';
      wait for 104us;
      RX_pin_s <= '0';
      wait for 104us;
      RX_pin_s <= '1';
      wait for 104us;
      RX_pin_s <= '1';
      wait for 104us;
      RX_pin_s <= '0';
      wait for 104us;
      RX_pin_s <= '0';
      wait for 104us;
      RX_pin_s <= '1';
      wait for 200us;
        wait;
    end process;



end Behavioral;
