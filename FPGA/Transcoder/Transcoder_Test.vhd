----------------------------------------------------------------------------------
-- Solution Factory
-- Bloc : Testbench Transcoder
-- Equipe N°412
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_transcoder is
--  Port ( );
end testbench_transcoder;

architecture Transcoder_architecture of testbench_transcoder is

-- Déclaration du composant à tester
component Transcoder is
    port(   dispDDMM : in STD_LOGIC;
            day : in STD_LOGIC_VECTOR(4 downto 0);
            month : in STD_LOGIC_VECTOR(3 downto 0);
            year : in STD_LOGIC_VECTOR(10 downto 0);
            disp0 : out STD_LOGIC_VECTOR(7 downto 0);
            disp1 : out STD_LOGIC_VECTOR(7 downto 0);
            disp2 : out STD_LOGIC_VECTOR(7 downto 0);
            disp3 : out STD_LOGIC_VECTOR(7 downto 0));
end component;

-- Signaux internes
signal dispDDMM_signal : std_logic := '0';
signal day_signal : std_logic_vector(4 downto 0) := "00001";
signal month_signal : std_logic_vector(3 downto 0) := "0001";
signal year_signal : std_logic_vector(10 downto 0) := "11110011110";
signal disp0_signal : std_logic_vector(7 downto 0) := "00000000";
signal disp1_signal : std_logic_vector(7 downto 0) := "00000000";
signal disp2_signal : std_logic_vector(7 downto 0) := "00000000";
signal disp3_signal : std_logic_vector(7 downto 0) := "00000000";

begin

 -- Instanciation du composant à tester
 MyCompUnderTest : Transcoder
 port map (
    dispDDMM => dispDDMM_signal,
    day => day_signal,
    month => month_signal,
    year => year_signal,
    disp0 => disp0_signal,
    disp1 => disp1_signal,
    disp2 => disp2_signal,
    disp3 => disp3_signal
    );

 -- Description des évolutions des signaux d'entrées (stimuli)
 -- Description de l'évolution des jours
    MyDateProc : process
    begin
        for k in 1950 to 1999 loop
            year_signal <= std_logic_vector(to_unsigned(k, year_signal'length));
            for j in 1 to 12 loop
                month_signal <= std_logic_vector(to_unsigned(j, month_signal'length));
                for i in 1 to 31 loop
                    day_signal <= std_logic_vector(to_unsigned(i, day_signal'length));
                    WAIT FOR 10ns;
                end loop;
            end loop;
        end loop;
    end process;

 -- Description de l'évolution du switch JJMM/YYYY
    MyDispDDMMProc : process
    begin
        dispDDMM_signal <= '0';
        WAIT FOR 186000ns;
        dispDDMM_signal <= '1';
        WAIT;
    end process;

end Transcoder_architecture;
