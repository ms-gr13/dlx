library IEEE;
use IEEE.std_logic_1164.all; --  libreria IEEE con definizione tipi standard logic

entity AND2 is
	Port (	A:	In	std_logic;
		B:	In	std_logic;
		Y:	Out	std_logic);
end AND2;


architecture ARCH of AND2 is

begin
	Y <=  A and B; 

end ARCH;


configuration CFG_AND2_ARCH of AND2 is
	for ARCH
	end for;
end CFG_AND2_ARCH;


