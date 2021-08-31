library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4to1_test is
end mux4to1_test;

architecture mux4to1Arch of Mux4to1_test is
   component mux4to1
    Port (
          Disp0, Disp1, Disp2, Disp3      : in std_logic_vector(7 downto 0);
		  Mod4                            : in std_logic_vector(1 downto 0);
		  SevenSeg                        : out std_logic_vector(7 downto 0)
        );
    end component;
    
    signal Disp0_signal : std_logic_vector(7 downto 0) := "10000001";
    signal Disp1_signal : std_logic_vector(7 downto 0) := "01000010";
    signal Disp2_signal : std_logic_vector(7 downto 0) := "00100100";
    signal Disp3_signal : std_logic_vector(7 downto 0) := "00011000";
    signal Mod4_signal : std_logic_vector(1 downto 0);
    signal SevenSeg_signal : std_logic_vector(7 downto 0);
   
begin

    InstMux4to1 : mux4to1
        port map (
            Disp0 => Disp0_signal,
            Disp1 => Disp1_signal,
            Disp2 => Disp2_signal,
            Disp3 => Disp3_signal,
            Mod4 => Mod4_signal,
            SevenSeg => SevenSeg_signal
        );
        
        mux4to1_proc : process
        begin
            Mod4_signal <= "00";
            wait for 1ms;
            Mod4_signal <= "10";
            wait for 1ms;
            Mod4_signal <= "01";
            wait for 1ms;
            Mod4_signal <= "11";
            wait;
            
        end process;


end mux4to1Arch;
