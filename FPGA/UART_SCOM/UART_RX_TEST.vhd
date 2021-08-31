----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.06.2021 14:42:12
-- Design Name: 
-- Module Name: rx_test - Behavioral
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

entity rx_test is
--  Port ( );
end rx_test;

architecture Behavioral of rx_test is

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
end component;

signal i_Clk_signal : std_logic := '0';
signal i_RX_Serial_signal : std_logic := '1';
signal o_RX_DV_signal : std_logic := '0';
signal o_RX_Byte_signal : std_logic_vector(7 downto 0) := "00000000";

begin

MyCompUnderTest : UART_RX
 port map (
    i_Clk => i_Clk_signal,
    i_RX_Serial => i_RX_Serial_signal,
    o_RX_DV => o_RX_DV_signal,
    o_RX_Byte => o_RX_Byte_signal
    );

    i_Clk_signal <= not i_Clk_signal after 80ns;
    
    test : process
    begin
        i_RX_Serial_signal <= '1';
        wait for 300us;
        i_RX_Serial_signal <= '0';
        wait for 104us;
        i_RX_Serial_signal <= '1';
        wait for 104us;
        i_RX_Serial_signal <= '1';
        wait for 104us;
        i_RX_Serial_signal <= '0';
        wait for 104us;
        i_RX_Serial_signal <= '0';
        wait for 104us;
        i_RX_Serial_signal <= '1';
        wait for 104us;
        i_RX_Serial_signal <= '0';
        wait for 104us;
        i_RX_Serial_signal <= '1';
        wait for 104us;
        i_RX_Serial_signal <= '0';
        wait for 104us;
        i_RX_Serial_signal <= '1';
        wait for 104us;
        wait;
    end process;
end Behavioral;
