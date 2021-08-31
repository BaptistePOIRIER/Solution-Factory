library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity MCU_UART_RX is
  generic (
    g_CLKS_PER_BIT : integer := 651
    );
  port (
      i_Clk       : in  std_logic;
      i_RX_Serial_test : in  std_logic;
      o_RX_DV_test     : out std_logic;
      o_RX_Byte_test   : out std_logic_vector(7 downto 0)
      );
end MCU_UART_RX;
 
 
architecture RTL of MCU_UART_RX is
 
  type t_SM_Main is (s_Idle, s_RX_Start_Bit, s_RX_Data_Bits,
                     s_RX_Stop_Bit, s_Cleanup_DV, s_Cleanup);
  signal r_SM_Main : t_SM_Main := s_Idle;
 
  signal r_RX_Data_R : std_logic := '0';
  signal r_RX_Data   : std_logic := '0';
   
  signal r_Clk_Count : integer range 0 to g_CLKS_PER_BIT-1 := 0;
  signal r_Bit_Index : integer range 0 to 7 := 0;  -- 8 Bits in total
  signal r_RX_Byte   : std_logic_vector(7 downto 0) := (others => '0');
  signal r_RX_DV     : std_logic := '0';
   
begin
 
  -- Purpose: Double-register the incoming data.
  -- This allows it to be used in the UART RX Clock Domain.
  -- (It removes problems caused by metastabiliy)
  p_SAMPLE : process (i_Clk)
  begin
    if rising_edge(i_Clk) then
      r_RX_Data_R <= i_RX_Serial_test;
      r_RX_Data   <= r_RX_Data_R;
    end if;
  end process p_SAMPLE;
   
 
  -- Purpose: Control RX state machine
  p_UART_RX : process (i_Clk)
  begin
    if rising_edge(i_Clk) then
         
      case r_SM_Main is
 
        when s_Idle =>
            r_RX_DV <= '0';
            r_Bit_Index <= 0;
            r_Clk_Count <= 0;
            
            if(r_RX_Data = '0') then
                r_SM_Main <= s_RX_Start_Bit;
            else
                r_SM_Main <= s_Idle;
            end if;

        -- Check middle of start bit to make sure it is still low
        when s_RX_Start_Bit =>
            if (r_Clk_Count = (g_CLKS_PER_BIT-1)/2) then
                if (r_RX_Data = '0') then
                    r_Clk_Count <= 0;
                    r_SM_Main <= s_RX_Data_Bits;
                else
                    r_SM_Main <= s_Idle;
                end if;
            else
                r_Clk_Count <= r_Clk_Count +1;
                r_SM_Main <= s_RX_Start_Bit;
            end if;

        -- Wait g_CLKS_PER_BIT-1 clock cycles to sample serial data
        when s_RX_Data_Bits =>
            if r_Clk_Count < g_CLKS_PER_BIT then
                r_Clk_Count <= r_Clk_Count +1;
                r_SM_Main <= s_RX_Data_Bits;
            else
                r_Clk_Count <= 0;
                r_RX_Byte(r_Bit_Index) <= r_RX_Data;
                
                if r_Bit_Index < 7 then
                    r_Bit_Index <= r_Bit_Index + 1;
                    r_SM_Main <= s_RX_Data_Bits;
                else
                    r_Bit_Index <= 0;
                    r_SM_Main <= s_RX_Stop_Bit;
                end if;
            end if;
         

        -- Receive Stop bit.  Stop bit = 1
        when s_RX_Stop_Bit =>
			-- Check middle of stop bit to make sure it is still high
			if r_Clk_Count < g_CLKS_PER_BIT then
                r_Clk_Count <= r_Clk_Count +1;
                r_SM_Main <= s_RX_Stop_Bit;
            else
                r_Clk_Count <= 0;
                if r_RX_Data = '1' then
                    r_SM_Main <= s_Cleanup_DV;
                else
                    r_SM_Main <= s_Idle;
                end if;
            end if;

        when s_Cleanup_DV =>
            r_RX_DV   <= '1';
            r_SM_Main <= s_Cleanup;
            
        when s_Cleanup =>
            r_RX_DV   <= '0';
            if r_Clk_Count < (g_CLKS_PER_BIT-1)/2 then
                    r_Clk_Count <= r_Clk_Count + 1;
                    r_SM_Main   <= s_Cleanup;
            else
                    r_Clk_Count <= 0;
                    r_SM_Main <= s_Idle;
            end if;
             
        when others =>
          r_SM_Main <= s_Idle;
 
      end case;
    end if;
  end process p_UART_RX;
 
  o_RX_DV_test   <= r_RX_DV;
  o_RX_Byte_test <= r_RX_Byte;
   
end architecture RTL;
