library IEEE;
use IEEE.std_logic_1164.all; 

entity XNOR_logic is
	Port (	A:	In	std_logic;
		B:	In	std_logic;
		Y:	Out	std_logic);
end XNOR_logic;



architecture BEHAVIORAL of XNOR_logic is

begin
    Y <= A xnor B;
end BEHAVIORAL;