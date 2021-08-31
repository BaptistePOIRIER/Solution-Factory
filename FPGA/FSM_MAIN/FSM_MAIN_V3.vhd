library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM_MAIN is
  Port (
            RX_done,  reset: in std_logic;
            clock : in std_logic;
            resE : in std_logic;
            resE2 : in std_logic;
            TX_done : in std_logic;
            result : in std_logic;
            result2 : in std_logic;
            switch : in std_logic_vector(7 downto 0);
            RX_byte : in std_logic_vector(7 downto 0);
            vecout : out std_logic_vector(51 downto 0);  
            CheckE : out std_logic; 
            TX_byte : out std_logic_vector(7 downto 0);
            TX_start : out std_logic;
            check_res : out std_logic_vector(7 downto 0)
            );

end FSM_MAIN;

architecture Behavioral of FSM_MAIN is

signal vecout_s : std_logic_vector(51 downto 0) := (others => '0');
signal converted : std_logic_vector(3 downto 0) := "0000";
type states is (IDLE, CONVERT, WRITE, RESET_ALL, START_CHECK, STOP_CHECK, TX_SEND, TX_END);
signal state : states := IDLE;

begin

FSM_proc : process(reset, clock)
begin
    if (reset = '1') then
        vecout_s <= (others => '0');
        converted <= "0000";
        TX_byte <= "00000000";
--        delay_counter <= 0;
        TX_start <= '0';
        CheckE <= '0';
        state <= IDLE;
    
    elsif (clock = '1') then
        if (switch(3) = '0') then
            case(state) is
                when IDLE =>
                    if (RX_done = '1') then
                        if (RX_byte = "01000010") then
                            state <= RESET_ALL;
                        elsif (RX_byte = "00110101") then
                            state <= START_CHECK;
                        else
                            case RX_byte is 
                               when "01001000" => converted <= "0000";
                               when "01001001" => converted <= "0001";
                               when "01010000" => converted <= "0010";
                               when "01010001" => converted <= "0011";
                               when "01010010" => converted <= "0100";
                               when "01010011" => converted <= "0101";
                               when "01010100" => converted <= "0110";
                               when "01010101" => converted <= "0111";
                               when "01010110" => converted <= "1000";
                               when "01010111" => converted <= "1001";
                               when others => converted <= "1111";
                            end case;
                            state <= CONVERT;
                        end if;
                    end if;
    
                when CONVERT =>
                        if (converted /= "1111") then
                            state <= WRITE;
                        else
                            state <= RESET_ALL;
                        end if;
    
                when WRITE =>
                    if (RX_done = '0') then
                        vecout_s <= vecout_s(47 downto 0) & converted;
                        converted <= "0000";
                        state <= IDLE;
                    end if;
    
                when START_CHECK =>
                    CheckE <= '1';
                    state <= STOP_CHECK;
                
                when STOP_CHECK =>
                    if (resE = '1' and resE2 = '1') then
                        if(result = '1' and result2 = '1') then
                            TX_byte <= "11110000";
                        else
                            TX_byte <= "00001111";
                        end if;
                        state <= TX_SEND;
                    end if;
    
                when TX_SEND =>
                    TX_start <= '1';
                    state <= TX_END;
    
                when TX_END =>
                    if (TX_done = '1') then
                        TX_start <= '0';
                        state <= RESET_ALL;
                    end if;
    
                when RESET_ALL =>
                    vecout_s <= (others => '0');
                    converted <= "0000";
                    TX_byte <= "00000000";
                    TX_start <= '0';
                    CheckE <= '0';
                    state <= IDLE;
    
                when others =>
                    state <= RESET_ALL;
            end case;

        else
            if (RX_done = '1' and RX_byte = "00110101") then
                if (switch(4) = '0') then
                    TX_byte <= "11110000"; 
                else
                    TX_byte <= "00001111"; 
                end if;
                TX_start <= '1';
            else
                TX_start <= '0';
            end if;
        end if;
    end if;
end process;

debug : process(clock)
begin
    case(switch) is
        when "00000000" =>
            case (state) is
                when IDLE =>
                    check_res <= "00000001";
                when CONVERT =>
                    check_res <= "00000010";
                when WRITE =>
                    check_res <= "00000100";
                when START_CHECK =>
                    check_res <= "00001000";
                when STOP_CHECK =>
                    check_res <= "00010000";
                when TX_SEND =>
                    check_res <= "00100000";
                when TX_END =>
                    check_res <= "01000000";
                when RESET_ALL =>
                    check_res <= "10000000";
                when others =>
                    check_res <= "10101010";
                end case;
            
            when "00000001" =>
                check_res <= RX_byte;
            
            when "00000010" =>
                check_res <= vecout_s(7 downto 0);

            when "00000100" =>
                check_res <= RX_done & RX_done & RX_done & RX_done & RX_done & RX_done & RX_done & RX_done;

            when "00001000" =>
                check_res <= "11110011";
                
            when "00011000" =>
                check_res <= "11111100";
                
            when others =>
                check_res <= "10101010";

            end case;
end process;

vecout <= vecout_s;

end Behavioral;
