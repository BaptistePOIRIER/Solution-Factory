----------------------------------------------------------------------------------
-- Solution Factory
-- Bloc : Transcoder
-- Equipe N°412
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Transcoder is
    port(   dispDDMM : in STD_LOGIC;
            day : in STD_LOGIC_VECTOR(4 downto 0);
            month : in STD_LOGIC_VECTOR(3 downto 0);
            year : in STD_LOGIC_VECTOR(10 downto 0);
            disp0 : out STD_LOGIC_VECTOR(7 downto 0);
            disp1 : out STD_LOGIC_VECTOR(7 downto 0);
            disp2 : out STD_LOGIC_VECTOR(7 downto 0);
            disp3 : out STD_LOGIC_VECTOR(7 downto 0));
end Transcoder;

architecture Behavioral of Transcoder is

    -- Signaux sortant des convertisseur binaire vers BCD
    signal day_0 : std_logic_vector(3 downto 0) := "0000";
    signal day_10 : std_logic_vector(3 downto 0) := "0000";
    signal month_0 : std_logic_vector(3 downto 0) := "0000";
    signal month_10 : std_logic_vector(3 downto 0) := "0000";
    signal year_0 : std_logic_vector(3 downto 0) := "0000";
    signal year_10 : std_logic_vector(3 downto 0) := "0000";
    signal year_100 : std_logic_vector(3 downto 0) := "0000";
    signal year_1000 : std_logic_vector(3 downto 0) := "0000";
    
    -- Signaux associés aux afficheurs 7 segments (en réalité 8 avec le point)
    signal day_0_seg : std_logic_vector(7 downto 0) := "00000000";
    signal day_10_seg : std_logic_vector(7 downto 0) := "00000000";
    signal month_0_seg : std_logic_vector(7 downto 0) := "00000000";
    signal month_10_seg : std_logic_vector(7 downto 0) := "00000000";
    signal year_0_seg : std_logic_vector(7 downto 0) := "00000000";
    signal year_10_seg : std_logic_vector(7 downto 0) := "00000000";
    signal year_100_seg : std_logic_vector(7 downto 0) := "00000000";
    signal year_1000_seg : std_logic_vector(7 downto 0) := "00000000";

begin

    -- Process qui convertit les bits binaire de jours en bits BCD
    Day_BCD_converter : process(day)
    variable BCD_reg : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    variable Bin : STD_LOGIC_VECTOR (4 downto 0) := "00000";
    begin
        Bin := "00000";
        BCD_reg := "00000000";
        Bin := day;
            for i in 0 to 4 loop
                if BCD_reg(3 downto 0) > 4 then
                    BCD_reg(3 downto 0) := BCD_reg(3 downto 0) + 3;
                end if;
                if BCD_reg(7 downto 4) > 4 then
                    BCD_reg(7 downto 4) := BCD_reg(7 downto 4) + 3;
                end if;
                
                BCD_reg(7 downto 0) := BCD_reg(6 downto 0) & Bin(4);
                Bin(4 downto 0) := Bin(3 downto 0) & 'L';

            end loop;
        
        day_0 <= BCD_reg(3 downto 0);
        day_10 <= BCD_reg(7 downto 4);
    end process;
    
    -- Affichage 7 segments en fonction de la valeur BCD (unités day)
    day_0_seg <=    "11000000" when day_0 = "0000" else -- Affichage 0
                    "11111001" when day_0 = "0001" else -- Affichage 1
                    "10100100" when day_0 = "0010" else -- Affichage 2
                    "10110000" when day_0 = "0011" else -- Affichage 3
                    "10011001" when day_0 = "0100" else -- Affichage 4
                    "10010010" when day_0 = "0101" else -- Affichage 5
                    "10000010" when day_0 = "0110" else -- Affichage 6
                    "11111000" when day_0 = "0111" else -- Affichage 7
                    "10000000" when day_0 = "1000" else -- Affichage 8
                    "10010000" when day_0 = "1001";     -- Affichage 9
    
    -- Affichage 7 segments en fonction de la valeur BCD (dizaines day)
    day_10_seg <=   "11000000" when day_10 = "0000" else -- Affichage 0
                    "11111001" when day_10 = "0001" else -- Affichage 1
                    "10100100" when day_10 = "0010" else -- Affichage 2
                    "10110000" when day_10 = "0011" else -- Affichage 3
                    "10011001" when day_10 = "0100" else -- Affichage 4
                    "10010010" when day_10 = "0101" else -- Affichage 5
                    "10000010" when day_10 = "0110" else -- Affichage 6
                    "11111000" when day_10 = "0111" else -- Affichage 7
                    "10000000" when day_10 = "1000" else -- Affichage 8
                    "10010000" when day_10 = "1001";     -- Affichage 9

    Month_BCD_converter : process(month)
    variable BCD_reg : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    variable Bin : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    begin
        Bin := "0000";
        BCD_reg := "00000000";
        Bin := month;
            for i in 0 to 3 loop
                if BCD_reg(3 downto 0) > 4 then
                    BCD_reg(3 downto 0) := BCD_reg(3 downto 0) + 3;
                end if;
                if BCD_reg(7 downto 4) > 4 then
                    BCD_reg(7 downto 4) := BCD_reg(7 downto 4) + 3;
                end if;
                
                BCD_reg(7 downto 0) := BCD_reg(6 downto 0) & Bin(3);
                Bin(3 downto 0) := Bin(2 downto 0) & 'L';   

            end loop;
        
        month_0 <= BCD_reg(3 downto 0);
        month_10 <= BCD_reg(7 downto 4);
    end process;
    
    -- Affichage 7 segments en fonction de la valeur BCD (unités month)
    month_0_seg <=  "11000000" when month_0 = "0000" else -- Affichage 0
                    "11111001" when month_0 = "0001" else -- Affichage 1
                    "10100100" when month_0 = "0010" else -- Affichage 2
                    "10110000" when month_0 = "0011" else -- Affichage 3
                    "10011001" when month_0 = "0100" else -- Affichage 4
                    "10010010" when month_0 = "0101" else -- Affichage 5
                    "10000010" when month_0 = "0110" else -- Affichage 6
                    "11111000" when month_0 = "0111" else -- Affichage 7
                    "10000000" when month_0 = "1000" else -- Affichage 8
                    "10010000" when month_0 = "1001";     -- Affichage 9
    
    -- Affichage 7 segments en fonction de la valeur BCD (dizaines month)
    month_10_seg <= "11000000" when month_10 = "0000" else -- Affichage 0
                    "11111001" when month_10 = "0001" else -- Affichage 1
                    "10100100" when month_10 = "0010" else -- Affichage 2
                    "10110000" when month_10 = "0011" else -- Affichage 3
                    "10011001" when month_10 = "0100" else -- Affichage 4
                    "10010010" when month_10 = "0101" else -- Affichage 5
                    "10000010" when month_10 = "0110" else -- Affichage 6
                    "11111000" when month_10 = "0111" else -- Affichage 7
                    "10000000" when month_10 = "1000" else -- Affichage 8
                    "10010000" when month_10 = "1001";     -- Affichage 9

    Year_BCD_converter : process(year)
    variable BCD_reg : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
    variable Bin : STD_LOGIC_VECTOR (10 downto 0) := "00000000000";
    begin
        Bin := "00000000000";
        BCD_reg := "0000000000000000";
        Bin := year;
            for i in 0 to 10 loop
                if BCD_reg(3 downto 0) > 4 then
                    BCD_reg(3 downto 0) := BCD_reg(3 downto 0) + 3;
                end if;
                if BCD_reg(7 downto 4) > 4 then
                    BCD_reg(7 downto 4) := BCD_reg(7 downto 4) + 3;
                end if;
                if BCD_reg(11 downto 8) > 4 then
                    BCD_reg(11 downto 8) := BCD_reg(11 downto 8) + 3;
                end if;
                if BCD_reg(15 downto 12) > 4 then
                    BCD_reg(15 downto 12) := BCD_reg(15 downto 12) + 3;
                end if;
                
                BCD_reg(14 downto 0) := BCD_reg(13 downto 0) & Bin(10);
                Bin(10 downto 0) := Bin(9 downto 0) & 'L';

            end loop;
        
        year_0 <= BCD_reg(3 downto 0);
        year_10 <= BCD_reg(7 downto 4);
        year_100 <= BCD_reg(11 downto 8);
        year_1000 <= BCD_reg(15 downto 12);
    end process;
    
    -- Affichage 7 segments en fonction de la valeur BCD (unités year)
    year_0_seg <=   "11000000" when year_0 = "0000" else -- Affichage 0
                    "11111001" when year_0 = "0001" else -- Affichage 1
                    "10100100" when year_0 = "0010" else -- Affichage 2
                    "10110000" when year_0 = "0011" else -- Affichage 3
                    "10011001" when year_0 = "0100" else -- Affichage 4
                    "10010010" when year_0 = "0101" else -- Affichage 5
                    "10000010" when year_0 = "0110" else -- Affichage 6
                    "11111000" when year_0 = "0111" else -- Affichage 7
                    "10000000" when year_0 = "1000" else -- Affichage 8
                    "10010000" when year_0 = "1001";     -- Affichage 9
    
    -- Affichage 7 segments en fonction de la valeur BCD (dizaines year)
    year_10_seg <=  "11000000" when year_10 = "0000" else -- Affichage 0
                    "11111001" when year_10 = "0001" else -- Affichage 1
                    "10100100" when year_10 = "0010" else -- Affichage 2
                    "10110000" when year_10 = "0011" else -- Affichage 3
                    "10011001" when year_10 = "0100" else -- Affichage 4
                    "10010010" when year_10 = "0101" else -- Affichage 5
                    "10000010" when year_10 = "0110" else -- Affichage 6
                    "11111000" when year_10 = "0111" else -- Affichage 7
                    "10000000" when year_10 = "1000" else -- Affichage 8
                    "10010000" when year_10 = "1001";     -- Affichage 9

    -- Affichage 7 segments en fonction de la valeur BCD (centaines year)
    year_100_seg <= "11000000" when year_100 = "0000" else -- Affichage 0
                    "11111001" when year_100 = "0001" else -- Affichage 1
                    "10100100" when year_100 = "0010" else -- Affichage 2
                    "10110000" when year_100 = "0011" else -- Affichage 3
                    "10011001" when year_100 = "0100" else -- Affichage 4
                    "10010010" when year_100 = "0101" else -- Affichage 5
                    "10000010" when year_100 = "0110" else -- Affichage 6
                    "11111000" when year_100 = "0111" else -- Affichage 7
                    "10000000" when year_100 = "1000" else -- Affichage 8
                    "10010000" when year_100 = "1001";     -- Affichage 9
    
    -- Affichage 7 segments en fonction de la valeur BCD (millier year)
    year_1000_seg <="11000000" when year_1000 = "0000" else -- Affichage 0
                    "11111001" when year_1000 = "0001" else -- Affichage 1
                    "10100100" when year_1000 = "0010" else -- Affichage 2
                    "10110000" when year_1000 = "0011" else -- Affichage 3
                    "10011001" when year_1000 = "0100" else -- Affichage 4
                    "10010010" when year_1000 = "0101" else -- Affichage 5
                    "10000010" when year_1000 = "0110" else -- Affichage 6
                    "11111000" when year_1000 = "0111" else -- Affichage 7
                    "10000000" when year_1000 = "1000" else -- Affichage 8
                    "10010000" when year_1000 = "1001";     -- Affichage 9

    -- Multiplexeur effectuant le choix de l'affichage (DDMM ou YYYY)
    disp0 <= day_10_seg when dispDDMM = '1' else
             year_1000_seg;
    disp1 <= day_0_seg when dispDDMM = '1' else
             year_100_seg;
    disp2 <= month_10_seg when dispDDMM = '1' else
             year_10_seg;    
    disp3 <= month_0_seg when dispDDMM = '1' else
             year_0_seg;    
     
end Behavioral;
