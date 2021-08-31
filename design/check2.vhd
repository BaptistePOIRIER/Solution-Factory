library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 
use IEEE.std_logic_unsigned.all;
use IEEE.math_real.all;

entity Check2 is
    Port ( vecout: in  std_logic_vector(51 downto 0);
            CheckE : in std_logic;
            --totalDayNumber : out STD_LOGIC_VECTOR (2 downto 0);
            reset : in std_logic;
            resE : out std_logic;
            result : out std_logic
           );
end Check2;

architecture Behavioral of Check2 is

type dateRegister is array(natural range <>) of natural;
type dateDatabase is array(natural range <>, natural range <>) of natural;

shared variable leapYear : boolean := false;
    
shared variable day_i : natural:=0;
shared variable month_i : natural:=0;
shared variable year_i : natural:=0;
shared variable wd : natural:=0;
shared variable new_day : std_logic_vector(4 downto 0) := (others => '0');
shared variable new_month : std_logic_vector(3 downto 0) := (others => '0');
shared variable new_year : std_logic_vector(9 downto 0) := (others => '0');
shared variable new_day_temp : std_logic_vector(7 downto 0) := (others => '0');
shared variable new_month_temp : std_logic_vector(7 downto 0) := (others => '0');
shared variable new_year_temp : std_logic_vector(13 downto 0) := (others => '0');


begin
  
    check : process(vecout, CheckE) is
    
    function isLeapYear(Y: natural) return boolean is
    begin
     
      
        if (Y mod 4) /= 0 then
           return false;
        else
             if (Y mod 100) /= 0 then
                 return true;
              elsif (Y mod 400) = 0 then
                 return true;
              else
                 return false;
              end if;
        end if;
    end function;
    
    function checkDate( Y: natural;
                        D: natural;
                        M: natural) return boolean is
         
    variable anneeBis : dateRegister(0 to 12) := (1,31,29,31,30,31,30,31,31,30,31,30,31);
    variable anneeNotBis : dateRegister(0 to 12) := (1,31,28,31,30,31,30,31,31,30,31,30,31);
                
    variable CheckD : natural := 0;         
                        
    begin
        if(isLeapYear(Y)) then
            CheckD := D mod (anneeBis(M)+1);
            if(D /= CheckD) then
                return false;
            else
                return True;
            end if;
        else
            CheckD := D mod (anneeNotBis(M)+1);
            if(D /= CheckD) then
                return false;
            else
                return True;
            end if;
        end if;
    end function;
    
    function calculateWD( D: natural;
                          M: natural;
                          Y: natural) return natural is
    
    variable value : natural:=0;
    
    begin
        if M < 3 then
            value := (M*23)/9;
            value := (value + D + 4 + Y);
            value := (value + (Y-1)/4);
            value := (value - (Y-1)/100);
            value := (value + (Y-1)/400);
        else
            value := (M*23)/9;
            value := (value + D + 2 + Y);
            value := (value + (Y)/4);
            value := (value - (Y)/100);
            value := (value + (Y)/400);
        end if;
        value := value mod 7;
        return value;
    end function;
    
    function CmprDateWithDatabase( D: natural;
                                   M: natural;
                                   Y: natural) return boolean is
                                   
    variable Database : dateDatabase(0 to 2, 0 to 2) := ((1978,13,12),(1963,29,1),(1980,29,2));
    

            
    begin
  
        for I in 0 to ((Database'length(1)-1)) loop
            if((Y = Database(I,0)) AND (D = Database(I,1)) AND (M = Database(I,2))) then
                return true;
            end if;
        end loop;
        return false;
    
    end function;
    
    begin
    
     if (reset = '1') then 
            resE <= '0';
     elsif CheckE = '1' then 
        
--        resE <= '0';
          
        new_day_temp :=  vecout(51 downto 48) * "1010" + vecout(47 downto 44);
        new_day := new_day_temp(4 downto 0);
        new_month_temp := vecout(43 downto 40)*"1010" + vecout(39 downto 36);
        new_month := new_month_temp(3 downto 0);
        new_year_temp := vecout(35 downto 32)*"1111101000"+ vecout(31 downto 28)*"1100100"+ vecout(27 downto 24)*"1010" + vecout(23 downto 20);
        new_year := new_year_temp(9 downto 0);
        
        year_i := to_integer(unsigned(new_year));
        day_i := to_integer(unsigned(new_day));
        month_i := to_integer(unsigned(new_month));
       
        
        if(checkDate(year_i, day_i, month_i)) then
 --           if(CmprDateWithDatabase(day_i, month_i, year_i)) then
                wd := calculateWD(day_i, month_i,year_i);
                --totalDayNumber <= std_logic_vector(to_unsigned(wd, totalDayNumber'length));
  --          else
  --              totalDayNumber <= "111";
  --          end if;
               result <= '1';
               
        else
            --totalDayNumber <= "111";
            result <= '0';
            
        end if;
        resE <= '1';
        
    end if;
    end process;
    
end Behavioral;