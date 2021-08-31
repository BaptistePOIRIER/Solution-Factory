library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.ALL;


library work;
use work.all;

entity UART_SCOM is
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
end entity UART_SCOM;

architecture struct of UART_SCOM is

component freq_div is
port(   
    clkin:in std_logic;
	clkout:out std_logic
	);
end component freq_div;

component UART_TX is
  generic (
    g_CLKS_PER_BIT : integer := 651
    );
  port (
    i_Clk       : in  std_logic;
    i_TX_DV     : in  std_logic;
    i_TX_Byte   : in  std_logic_vector(7 downto 0);
    o_TX_Active : out std_logic;
    o_TX_Serial : out std_logic;
    o_TX_Done   : out std_logic
    );
end component UART_TX;

component UART_RX is
  generic (
    g_CLKS_PER_BIT : integer := 651
    );
  port (
    i_Clk       : in  std_logic;
    i_RX_Serial : in  std_logic;
    o_RX_DV     : out std_logic;
    o_RX_Byte   : out std_logic_vector(7 downto 0)
    );
end component UART_RX;

--component MCU_UART_TX is 
--generic (
--    g_CLKS_PER_BIT : integer := 651
--    );
--  port (
--    i_Clk       : in  std_logic;
--    i_TX_DV_test     : in  std_logic;
--    i_TX_Byte_test   : in  std_logic_vector(7 downto 0);
--    o_TX_Active_test : out std_logic;
--    o_TX_Serial_test : out std_logic;
--    o_TX_Done_test   : out std_logic
--    );
--    end component;
     

--component MCU_UART_RX  is
--  generic (
--    g_CLKS_PER_BIT : integer := 651
--    );
--  port (
--    i_Clk       : in  std_logic;
--    i_RX_Serial_test : in  std_logic;
--    o_RX_DV_test     : out std_logic;
--    o_RX_Byte_test   : out std_logic_vector(7 downto 0)
--    );
--end component MCU_UART_RX ;


component CHECK_CODE is
port( vecout : in std_logic_vector(51 downto 0):= (others => '0');
            clock  : in std_logic := '0'; 
            CheckE : in std_logic := '0';
            reset : in std_logic := '0';
            resE2 : out std_logic;
            result2 : out std_logic

);
end component CHECK_CODE;

component Check2 is
    Port ( vecout: in  std_logic_vector(51 downto 0);
            CheckE : in std_logic;
            --totalDayNumber : out STD_LOGIC_VECTOR (2 downto 0);
            reset : in std_logic;
            resE : out std_logic;
            result : out std_logic
           );
end component;
        
component FSM_Main is
 Port (   RX_done,  reset : in std_logic;
           resE : in std_logic;
           resE2 : in std_logic;
           TX_done : in std_logic;
           result : in std_logic;
           result2 : in std_logic;
           RX_byte : in std_logic_vector(7 downto 0);
           --switch
           vecout : out std_logic_vector(51 downto 0);  
           CheckE : out std_logic; 
           TX_byte : out std_logic_vector(7 downto 0);
           TX_start : out std_logic;
           check_res : out std_logic_vector(7 downto 0)
           
            );
end component;


signal Tx_B, Rx_B,Rx_B_test : std_logic_vector(7 downto 0);
signal en_Tx, DV_Rx,DV_Rx_test, clk_int : std_logic;
signal vecout_i : std_logic_vector(51 downto 0) := (others => '0');
signal resE_i : std_logic;
signal result_i : std_logic ;
signal CheckE_i : std_logic := '0';
signal resE2_i : std_logic;
signal result2_i : std_logic ;
signal Tx_done_i : std_logic;

--signal totalDayNumber_check : STD_LOGIC_VECTOR (2 downto 0);
            

begin

U0: freq_div port map (clkin => CLOCK, clkout => clk_int);

U2: UART_TX generic map (g_CLKS_PER_BIT=>  651 ) 
		port map(i_Clk => clk_int, 
					i_TX_DV => en_Tx, 
					i_TX_Byte => Tx_B, 
					o_TX_Serial => TX_pin, 
					o_TX_Active => open,
					o_TX_Done=> Tx_done_i
					);

U3: UART_RX generic map (g_CLKS_PER_BIT=>  651 ) 
		  port map (i_Clk => clk_int,
					i_RX_Serial => RX_pin,
					o_RX_DV => DV_Rx,
					o_RX_Byte => Rx_B
					--o_RX_Byte => LED_pins
					);
--U5: MCU_UART_RX generic map (g_CLKS_PER_BIT=>  651 ) 
--                              port map (i_Clk => clk_int,
--                                        i_RX_Serial_test => test_RX_pin,
--                                        o_RX_DV_test => DV_Rx_test,
--                                        o_RX_Byte_test => Rx_B_test
--                                        );
--U6: MCU_UART_TX generic map (g_CLKS_PER_BIT=>  651 ) 
--                                port map(i_Clk => clk_int, 
--                                    i_TX_DV_test => en_Tx, 
--                                    i_TX_Byte_test => Tx_B, 
--                                    o_TX_Serial_test => TX_pin, 
--                                    o_TX_Active_test => open,
--                                    o_TX_Done_test=> open
--                                    );

U4: FSM_MAIN 
port map (
            vecout => vecout_i,
            check_res => LED_pins,
            --check_res => Rx_B,
            CheckE => CheckE_i,
            resE2 => resE2_i,
            result2 => result2_i,
            resE => resE_i,
            result => result_i,
            reset => Reset,
            TX_byte => Tx_B,
            TX_start => en_Tx,
            TX_done => Tx_done_i,
            RX_done => DV_Rx,
            RX_Byte => Rx_B
            
             
           );
  
  

                     
U7 : Check2
           port map(
                 
                 
                 vecout => vecout_i,
                 resE => resE_i,
                 result => result_i,
                 reset => reset,
                 CheckE => CheckE_i
                
                         
                 );
            
U8: CHECK_CODE 
            port map (
            vecout => vecout_i,
            clock => CLOCK,
            reset => Reset,
            CheckE  => CheckE_i,
            resE2  => resE2_i,
            result2  => result2_i
            );
                       
                       
end architecture struct;
