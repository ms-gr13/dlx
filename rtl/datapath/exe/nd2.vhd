library IEEE;
use IEEE.std_logic_1164.all; --  libreria IEEE con definizione tipi standard logic
use WORK.constants.all; -- libreria WORK user-defined

entity ND2 is
	Port (	A:	In	std_logic;
		B:	In	std_logic;
		Y:	Out	std_logic);
end ND2;


architecture ARCH1 of ND2 is

begin
	Y <= not( A and B) after NDDELAY; -- 

end ARCH1;

<<<<<<< HEAD
architecture ARCH2 of ND2 is

begin
     -- nome processo
     --  |
     -- \/
	P1: process(A,B) -- tutti gli ingressi utilizzati devono essere nella sensitivity list
	begin
	  if (A='1') and (B='1') then
	    Y <='0' after NDDELAY;
	  elsif (A='0') or (B='0') then 
	    Y <='1' after NDDELAY;
	  end if;
	end process;

end ARCH2;


=======
>>>>>>> e679a782b465149b648f5c25bad876ab11c85644
configuration CFG_ND2_ARCH1 of ND2 is
	for ARCH1
	end for;
end CFG_ND2_ARCH1;

