----------------------------------------------------------------------------------------------------------
-- Title      : Multiplexer 2to1 generic
-- Project    : DLX
----------------------------------------------------------------------------------------------------------
-- File      : mux.vhd
-- Author    : ms23.13
-----------------------------------------------------------------------------------------------------------
-- Description: This file contains the structural and behavioral description of
--              a 2to1 multiplexer generic
--
-----------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all; --  libreria IEEE con definizione tipi standard logic



entity MUX21_GENERIC is

    generic(bits : integer := 16);
  
	port
      (
        A:	in	    std_logic_vector (bits -1 downto 0);
		    B:	in	    std_logic_vector (bits -1 downto 0);
		    S:	in	    std_logic;
		    Y:	out	    std_logic_vector (bits -1 downto 0)
        );
end MUX21_GENERIC;

----------------------------------------------------------------------------------------------------------------------------------
--   BEHAVIORAL ARCHITECTURE
----------------------------------------------------------------------------------------------------------------------------------

architecture BEHAVIORAL of MUX21_GENERIC is

begin
	Y <= A when S='0' else B;

end BEHAVIORAL;


<<<<<<< HEAD

=======
>>>>>>> bba84a4c4ddd4c1d2013204c30c68ca3c60c1a34



