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
shared variable converted : std_logic_vector(3 downto 0) := "0000";
signal tram_count : natural := 51;
signal state_FSM_main : natural := 0;
--shared variable check_res_s : std_logic_vector(7 downto 0) := (others => '0');
signal validate : boolean := false;
signal tx_start_s : std_logic := '0';
signal tx_byte_s : std_logic_vector(7 downto 0) := (others => '0');

begin

FSM_proc : process(reset, clock)
begin
    if (reset = '1') then
        state_FSM_main <= 0;
        tram_count <= 51;
        vecout_s <= (others => '0');
        tx_start_s <= '0';
        validate <= false;
        tx_byte_s <= "00000000";

    else
            if (state_FSM_main = 0) then
--        case (state_FSM_main) is
--            when 0 =>
                tx_start_s <= '0';
                if(RX_byte = "01000010" and RX_done = '1') then
                    state_FSM_main <= 1;
                else
                    state_FSM_main <= 0;
                end if;
                
            elsif (state_FSM_main = 1) then
--            when 1 =>
                if validate = true then
                    state_FSM_main <= 2;
                elsif(RX_byte /= "00000000") then
                    if (RX_done = '1') then
                        if(RX_byte = "01000010") then
                            vecout_s <= (others => '0');
                            tram_count <= 51;
                        elsif(RX_byte = "00110101") then
                            validate <= true;
                            CheckE <= '1';
                        else
                            --if(tram_count >= 3) then
                                case  RX_byte is 
                                   when "01001000" => converted := "0000";
                                   when "01001001" => converted := "0001";
                                   when "01010000" => converted := "0010";
                                   when "01010001" => converted := "0011";
                                   when "01010010" => converted := "0100";
                                   when "01010011" => converted := "0101";
                                   when "01010100" => converted := "0110";
                                   when "01010101" => converted := "0111";
                                   when "01010110" => converted := "1000";
                                   when "01010111" => converted := "1001";
                                   when others => converted := "1111";
                               end case;
                               vecout_s <= vecout_s(47 downto 0) & converted;		       
                            --else
                            --   vecout_s <= (others => '0');
                            --   tram_count <= 51;
                            --end if;  
                        end if;
                    end if;
                else
                    state_FSM_main <= 1;
                end if;
                
            elsif (state_FSM_main = 2) then
--            when 2 =>
                if (resE = '1') then
                    if (resE2 = '1') then
                        if (result2 = '1') then
                            tx_byte_s <= "11110000";
                        else
                            tx_byte_s <= "00001111";
                        end if;
    --                    while tx_start_s = '0' loop
    --                        tx_start_s := '1';
    --                    end loop;
                        tx_start_s <= '1';
                        state_FSM_main <= 3;
                    else
                        state_FSM_main <= 2;
                    end if;
                end if;

            elsif (state_FSM_main = 3) then
--             when 3 =>
                if (TX_done = '1') then
                    tram_count <= 51;
                    vecout_s <= (others => '0');
--                    tx_start_s := '0';
                    CheckE <= '0';
                    validate <= false;
                    state_FSM_main <= 0;
                else
                    state_FSM_main <= 3;

                end if;

            else
                state_FSM_main <= 0;
--             when others =>
--                check_res_s(3 downto 0) := "1111";
                
            end if;
--             end case;
    end if;
    
    vecout(51 downto 0) <= vecout_s(51 downto 0);
    TX_start <= tx_start_s;
    TX_byte <= tx_byte_s;
    
    case(state_FSM_main) is
        when 0 => check_res <= vecout_s(7 downto 0);
        when 1 => check_res <= vecout_s(7 downto 0);
        when 2 => check_res <= vecout_s(7 downto 0);
        when 3 => check_res <= vecout_s(7 downto 0);
        when others => check_res <= "10101010";
    end case;

end process;

end Behavioral;
