----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.06.2021 11:37:15
-- Design Name: 
-- Module Name: GeneralEntity_Test - Behavioral
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

entity GeneralEntity_Test is
--  Port ( );
end GeneralEntity_Test;

architecture Behavioral of GeneralEntity_Test is
Component GeneralEntity is 
port(
    clock_i,reset_i,buttonMore_i,buttonChoice_i,buttonCheck_i : in std_logic;
    led_o : out std_logic_vector(7 downto 0);
    sevenSeg_o : out std_logic_vector(7 downto 0);
    AN_o : out std_logic_vector(3 downto 0)
    );
end component;

signal clock_i_signal : std_logic := '0';
signal reset_i_signal : std_logic := '0';
signal buttonMore_i_signal : std_logic := '0';
signal buttonChoice_i_signal : std_logic := '0';
signal buttonCheck_i_signal : std_logic := '0';
signal led_o_signal : std_logic_vector(7 downto 0);
signal sevenSeg_o_signal : std_logic_vector(7 downto 0);
signal AN_o_signal : std_logic_vector(3 downto 0);

begin

    Inst_GeneralEntity : GeneralEntity port map (
        clock_i => clock_i_signal,
        reset_i => reset_i_signal,
        buttonMore_i => buttonMore_i_signal,
        buttonChoice_i => buttonChoice_i_signal,
        buttonCheck_i => buttonCheck_i_signal,
        led_o => led_o_signal,
        sevenSeg_o => sevenSeg_o_signal,
        AN_o => AN_o_signal
    );

    Clock : process
    begin
    
        clock_i_signal <= not clock_i_signal;
        wait for 5 ns;
    
    
    end process;
    
    GeneralTesting : process
    begin
       reset_i_signal <= '1';
       wait for 5 ms;
       reset_i_signal <= '0';
       
       buttonChoice_i_signal <= '0';
       wait for 5ms;
       buttonMore_i_signal <= '1'; 
       wait for 500 ms;
       buttonMore_i_signal <= '0';

       wait for 5 ms;
       buttonChoice_i_signal <= '1';
       buttonCheck_i_signal <= '1';
       wait for 5 ms;
       buttonChoice_i_signal <= '0';
       buttonCheck_i_signal <= '0';
       wait for 5 ms ;

       buttonMore_i_signal <= '1'; 
       wait for 500 ms;
       buttonMore_i_signal <= '0';

       wait for 5 ms;
       buttonChoice_i_signal <= '1';
       wait for 5 ms;
       buttonChoice_i_signal <= '0';
       wait for 5 ms ;
       
       buttonMore_i_signal <= '1'; 
       wait for 500 ms;
       buttonMore_i_signal <= '0';

       wait for 5 ms;
       buttonChoice_i_signal <= '1';
       wait for 5 ms;
       buttonChoice_i_signal <= '0';
       wait for 5 ms ;
       wait;
    end process;
end Behavioral;
