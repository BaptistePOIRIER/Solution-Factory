library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GeneralEntity_Test is
--  Port ( );
end GeneralEntity_Test;

architecture Behavioral of GeneralEntity_Test is

component GeneralEntity is
Port (clock_i,reset_i,buttonMore_i,buttonChoice_i,buttonCheck_i : in std_logic;
        swtch_i :  in std_logic_vector(7 downto 0);
        led_o : out std_logic_vector(7 downto 0);
        sevenSeg_o : out std_logic_vector(7 downto 0);
        AN_o : out std_logic_vector(3 downto 0);
        Rx_i : in std_logic;
        Tx_o : out std_logic
   );
end component;

signal clock_i_s : std_logic := '0';
signal reset_i_s : std_logic := '0';
signal buttonMore_i_s : std_logic := '0';
signal buttonChoice_i_s : std_logic := '0';
signal buttonCheck_i_s : std_logic := '0';
signal swtch_i_s : std_logic_vector(7 downto 0) := "00000000";
signal led_o_s : std_logic_vector(7 downto 0) := "00000000";
signal sevenSeg_o_s : std_logic_vector(7 downto 0) := "00000000";
signal AN_o_s : std_logic_vector(3 downto 0) := "0000";
signal Rx_i_s : std_logic := '1';
signal Tx_o_s : std_logic := '0';

begin

U0 : GeneralEntity
port map (
    clock_i => clock_i_s,
    reset_i => reset_i_s,
    buttonMore_i => buttonMore_i_s,
    buttonChoice_i => buttonChoice_i_s,
    buttonCheck_i => buttonCheck_i_s,
    swtch_i => swtch_i_s,
    led_o => led_o_s,
    sevenSeg_o => sevenSeg_o_s,
    AN_o => AN_o_s,
    Rx_i => Rx_i_s,
    Tx_o => Tx_o_s
);

clock_i_s <= not clock_i_s after 5ns;

test : process
    begin
        reset_i_s <= '1';
        wait for 300us;
        reset_i_s <= '0';
        swtch_i_s <= "00000000";
        Rx_i_s <= '1';
        wait for 1ms;
        Rx_i_s <= '0'; --bit de start ********************
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';  --bit de stop
        wait for 500us;
        
        Rx_i_s <= '0'; -- 0
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';  --bit de stop
        wait for 500us;
     
                Rx_i_s <= '0'; --1
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';  --bit de stop
        wait for 500us;
        
        Rx_i_s <= '0'; --0
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';  --bit de stop
        wait for 500us;
     
                Rx_i_s <= '0'; --1
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';  --bit de stop
        wait for 500us;
        
                        Rx_i_s <= '0'; --1
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';  --bit de stop
        wait for 500us;
        
        Rx_i_s <= '0'; -- 9
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';  --bit de stop
        wait for 500us;
        
                Rx_i_s <= '0'; --5
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';  --bit de stop
        wait for 500us;
        
                Rx_i_s <= '0'; --0
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';  --bit de stop
        wait for 500us;

                Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';  --bit de stop
        wait for 500us;
        
                Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';  --bit de stop
        wait for 500us;
        
                Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';  --bit de stop
        wait for 500us;
        
                Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';  --bit de stop
        wait for 500us;
        
                Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';
        wait for 104us;
        Rx_i_s <= '0';
        wait for 104us;
        Rx_i_s <= '1';  --bit de stop
        wait for 500us;
                
                  Rx_i_s <= '0';  --################
      wait for 104us;
      Rx_i_s <= '1';
      wait for 104us;
      Rx_i_s <= '0';
      wait for 104us;
      Rx_i_s <= '1';
      wait for 104us;
      Rx_i_s <= '0';
      wait for 104us;
      Rx_i_s <= '1';
      wait for 104us;
      Rx_i_s <= '1';
      wait for 104us;
      Rx_i_s <= '0';
      wait for 104us;
      Rx_i_s <= '0';
      wait for 104us;
      Rx_i_s <= '1';  --bit de stop
      wait for 500us;
        wait;
    end process;



end Behavioral;
