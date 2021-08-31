library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GeneralEntity is
  Port (clock_i,reset_i,buttonMore_i,buttonChoice_i,buttonCheck_i : in std_logic;
        swtch_i :  in std_logic_vector(7 downto 0);
        led_o : out std_logic_vector(7 downto 0);
        sevenSeg_o : out std_logic_vector(7 downto 0);
        AN_o : out std_logic_vector(3 downto 0);
        Rx_i : in std_logic;
        Tx_o : out std_logic
   );
end GeneralEntity;

architecture Behavioral of GeneralEntity is

component ClockManagement
port(   
		clock, reset    : in    std_logic;
		CESlow            : out    std_logic;
		CEDebounce        : out   std_logic;
		clockEnableDisplay: out   std_logic
		);
end component ClockManagement;

signal CESlow_ClockManagement : std_logic := '0';
signal CEDebounce_ClockManagement : std_logic := '0';
signal clockEnableDisplay_ClockManagement : std_logic := '0';

component Sync
port(   
        CEDebounce,reset,buttonMore,buttonChoice,buttonCheck: in std_logic;
        buttonMoreSync,buttonChoiceSync,buttonCheckSync: out std_logic
		);
end component Sync;

signal buttonMoreSync_Sync : std_logic := '0';
signal buttonChoiceSync_Sync : std_logic := '0';
signal buttonCheckSync_Sync : std_logic := '0';

component FSMCalendarCounters
port(   
		clock : in STD_LOGIC;
        reset : in STD_LOGIC;
        CESlow : in STD_LOGIC;
        buttonMoreSync : in STD_LOGIC;
        buttonChoiceSync : in STD_LOGIC;
        buttonCheckSync : in STD_LOGIC;
        checkE : out STD_LOGIC;
        dispDDMM : out STD_LOGIC;
        day : out STD_LOGIC_VECTOR(4 downto 0);
        month : out STD_LOGIC_VECTOR(3 downto 0);
        year : out STD_LOGIC_VECTOR(10 downto 0)
		);
end component FSMCalendarCounters;

signal checkE_FSMCalendarCounters : std_logic := '0';
signal dispDDMM_FSMCalendarCounters : std_logic := '0';
signal day_FSMCalendarCounters : std_logic_vector(4 downto 0) := "00001";
signal month_FSMCalendarCounters : std_logic_vector(3 downto 0) := "0001";
signal year_FSMCalendarCounters : std_logic_vector(10 downto 0) := "11111000000";

component Check
port(   
		day : in STD_LOGIC_VECTOR (4 downto 0);
        month : in STD_LOGIC_VECTOR (3 downto 0);
        year : in STD_LOGIC_VECTOR (10 downto 0);
        totalDayNumber : out STD_LOGIC_VECTOR (2 downto 0)
        );
end component Check;

signal totalDayNumber_Check : std_logic_vector(2 downto 0) := "000";

component LEDManagement
port(   
		clock : in STD_LOGIC;
        reset : in STD_LOGIC;
        CESlow : in STD_LOGIC;
        checkE : in STD_LOGIC;
        totalDayNumber : in STD_LOGIC_VECTOR (2 downto 0);
        led : out STD_LOGIC_VECTOR (7 downto 0)
		);
end component LEDManagement;

signal led_LEDManagement : std_logic_vector(7 downto 0) := "00000010";

component Transcoder
port(   
		dispDDMM : in STD_LOGIC;
        day : in STD_LOGIC_VECTOR(4 downto 0);
        month : in STD_LOGIC_VECTOR(3 downto 0);
        year : in STD_LOGIC_VECTOR(10 downto 0);
        disp0 : out STD_LOGIC_VECTOR(7 downto 0);
        disp1 : out STD_LOGIC_VECTOR(7 downto 0);
        disp2 : out STD_LOGIC_VECTOR(7 downto 0);
        disp3 : out STD_LOGIC_VECTOR(7 downto 0)
		);
end component Transcoder;

signal disp0_Transcoder : std_logic_vector(7 downto 0) := "00000000";
signal disp1_Transcoder : std_logic_vector(7 downto 0) := "00000000";
signal disp2_Transcoder : std_logic_vector(7 downto 0) := "00000000";
signal disp3_Transcoder : std_logic_vector(7 downto 0) := "00000000";

component ModuloFour
port(   
		clock, reset, clockEnableDisplay : in std_logic;
        mod4 :  out std_logic_vector(1 downto 0);
        AN :  out std_logic_vector(3 downto 0)
		);
end component ModuloFour;

signal mod4_ModuloFour : std_logic_vector(1 downto 0) := "00";

component Mux4to1
port(   
		Disp0, Disp1, Disp2, Disp3    : in    std_logic_vector(7 downto 0);
		Mod4                 : in    std_logic_vector(1 downto 0);
		SevenSeg                : out   std_logic_vector(7 downto 0)
		);
end component Mux4to1;

component UART_SCOM
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
end component UART_SCOM;

signal led_UART : std_logic_vector(7 downto 0) := "00000010";


begin
        inst_ClockManagement : ClockManagement
        port map(
              clock => clock_i,
              reset => reset_i,
		      CESlow => CESlow_ClockManagement,
		      CEDebounce => CEDebounce_ClockManagement,
		      clockEnableDisplay => clockEnableDisplay_ClockManagement
		      );
		      
		inst_Sync : Sync
		port map(
		      CEDebounce => CEDebounce_ClockManagement,
		      reset => reset_i,
		      buttonMore => buttonMore_i,
		      buttonChoice => buttonChoice_i,
		      buttonCheck => buttonCheck_i,
              buttonMoreSync => buttonMoreSync_Sync,
              buttonChoiceSync => buttonChoiceSync_Sync,
              buttonCheckSync => buttonCheckSync_Sync
              );
              
        inst_FSMCalendarCounters : FSMCalendarCounters
        port map(
              clock => clock_i,
              reset => reset_i,
              CESlow => CESlow_ClockManagement,
              buttonMoreSync => buttonMoreSync_Sync,
              buttonChoiceSync => buttonChoiceSync_Sync,
              buttonCheckSync => buttonCheckSync_Sync,
              checkE => checkE_FSMCalendarCounters,
              dispDDMM => dispDDMM_FSMCalendarCounters,
              day => day_FSMCalendarCounters,
              month => month_FSMCalendarCounters,
              year => year_FSMCalendarCounters
		      );
		      
		inst_Check : Check
		port map(
		      day => day_FSMCalendarCounters,
              month => month_FSMCalendarCounters,
              year => year_FSMCalendarCounters,
              totalDayNumber => totalDayNumber_Check
              );
              
        inst_LEDManagement : LEDManagement
        port map(
              clock => clock_i,
              reset => reset_i,
              CESlow => CESlow_ClockManagement,
              checkE => checkE_FSMCalendarCounters,
              totalDayNumber => totalDayNumber_Check,
              led => led_LEDManagement
              );

        inst_Transcoder : Transcoder
        port map(
              dispDDMM => dispDDMM_FSMCalendarCounters,
              day => day_FSMCalendarCounters,
              month => month_FSMCalendarCounters,
              year => year_FSMCalendarCounters,
              disp0 => disp0_Transcoder,
              disp1 => disp1_Transcoder,
              disp2 => disp2_Transcoder,
              disp3 => disp3_Transcoder
              );
        
        inst_ModuloFour : ModuloFour
        port map(
              clock => clock_i,
              reset => reset_i,
              clockEnableDisplay => clockEnableDisplay_ClockManagement,
              mod4 => mod4_ModuloFour,
              AN => AN_o
              );
              
        inst_Mux4to1 : Mux4to1
        port map(
              Disp0 => disp0_Transcoder,
              Disp1 => disp1_Transcoder,
              Disp2 => disp2_Transcoder,
              Disp3 => disp3_Transcoder,
              Mod4 => mod4_ModuloFour,
		      SevenSeg =>  sevenSeg_o
		      );
		      process(swtch_i)
		      begin
		          case swtch_i is
                  when "10000000"   => led_o <= led_LEDManagement;
                  when others => led_o <= led_UART;
              end case;
             end process;
        
        inst_UART_SCOM : UART_SCOM
        port map(
            CLOCK => clock_i,
            Reset => reset_i,
            RX_pin => Rx_i,
            TX_pin => Tx_o,
            SW_pins => swtch_i,
            test_TX_pin => Tx_o,
            test_RX_pin => Rx_i,
            LED_pins => led_UART,
            SEG1_pins => sevenSeg_o,
            SEG2_pins => sevenSeg_o
            );
end Behavioral;