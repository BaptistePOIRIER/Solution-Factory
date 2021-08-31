library ieee;
use ieee.std_logic_1164.all;

entity Mux4to1 is
port(   Disp0, Disp1, Disp2, Disp3    : in    std_logic_vector(7 downto 0);
		Mod4                 : in    std_logic_vector(1 downto 0);
		SevenSeg                : out   std_logic_vector(7 downto 0)
		);
end entity Mux4to1;

architecture behavior of mux4to1 is
begin
process(Disp0, Disp1, Disp2, Disp3, Mod4) is
begin
case Mod4 is
	when "00"   => SevenSeg <= Disp0;
	when "01"   => SevenSeg <= Disp1;
	when "10"   => SevenSeg <= Disp2;
	when others => SevenSeg <= Disp3;
end case;
end process;
end architecture behavior;