-- VHDL model created from schematic top.sch -- Apr 11 22:01:36 2016

LIBRARY ieee;
LIBRARY generics;
LIBRARY lat_vhd;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE generics.components.ALL;
USE lat_vhd.components.ALL;

entity TOP is
end TOP;

architecture SCHEMATIC of TOP is

   SIGNAL gnd : std_logic := '0';
   SIGNAL vcc : std_logic := '1';


   component ADDER
      Port (       a : In    std_logic_vector (3 downto 0);
                   b : In    std_logic_vector (3 downto 0);
                  ci : In    std_logic;
                  co : Out   std_logic;
                   s : Out   std_logic_vector (3 downto 0) );
   end component;

begin

   I1 : ADDER
      Port Map ( a(3 downto 0)=>open, b(3 downto 0)=>open, ci=>open,
                 co=>open, s(3 downto 0)=>open );

end SCHEMATIC;
