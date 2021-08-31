library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ModuloFour_Test is
end ModuloFour_Test;

architecture moduloArch of ModuloFour_Test is
   component ModuloFour
    Port ( clock, reset, clockEnableDisplay : in std_logic;
        mod4 :  out std_logic_vector(1 downto 0);
        AN :  out std_logic_vector(3 downto 0)       
    );
    end component;
    
    signal clkED_signal : std_logic := '0';
    signal clk_signal : std_logic := '0';
    signal reset_signal : std_logic := '0';
    signal mod4_signal : std_logic_vector(1 downto 0);
    signal AN_signal : std_logic_vector( 3 downto 0);
    
   
begin

    InstModulo : ModuloFour
        port map (
            clockEnableDisplay => clkED_signal,
            clock => clk_signal,
            reset => reset_signal,
            mod4 => mod4_signal,
            AN => AN_signal
        );
     
     clkED_signal <= not clkED_signal after 2500 ns;
     Modulo_proc : process
        
        begin
            reset_signal <= '1';
            wait for 1ms;
            reset_signal <= '0';
            wait;
            
        end process;


end moduloArch;
