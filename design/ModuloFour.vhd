library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ModuloFour is

 Port ( clock, reset, clockEnableDisplay : in std_logic;
        mod4 :  out std_logic_vector(1 downto 0);
        AN :  out std_logic_vector(3 downto 0)
        );
end ModuloFour;

architecture Behavioral of ModuloFour is

signal mod4_internal: std_logic_vector(1 downto 0) := "00";

begin  

    Modulo4 : process(clock, reset, clockEnableDisplay) is
    begin

    if reset = '1' then 
        mod4_internal <= "00";
    end if;
    if rising_edge(clockEnableDisplay) then
        if mod4_internal = "11" then
            mod4_internal <= "00";
        else
            mod4_internal <= mod4_internal + 1;
        end if;
    end if;
    
    case mod4_internal is
        when "00"   => AN <= "1000";
        when "01"   => AN <= "0100";
        when "10"   => AN <= "0010";
        when others => AN <= "0001";
    end case;
    
    mod4 <= mod4_internal;
        
    end process;

end architecture;
