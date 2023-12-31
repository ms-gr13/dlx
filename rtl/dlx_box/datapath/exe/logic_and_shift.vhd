
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.myTypes.all;


entity logic_and_shift is
  generic (N : integer := 32);
  port 	 ( FUNC: in aluOp; --4 bits for the 9 operations.
           DATA1, DATA2: in std_logic_vector(N-1 downto 0);
           OUTALU: out std_logic_vector(N-1 downto 0));
end logic_and_shift;

architecture BEHAVIOR of logic_and_shift is

begin

P_LS: process (FUNC, DATA1, DATA2)
  -- complete all the requested functions
       variable half1: std_logic_vector(N/2-1 downto 0);
       variable half2: std_logic_vector(N/2-1 downto 0);
  begin
      half1 := DATA1(N/2-1 downto 0);
      half2 := DATA2(N/2-1 downto 0);
 
    
    case FUNC is
 	when ANDS =>
               OUTALU <= DATA1 and DATA2; -- bitwise operations
 	when ORS =>
               OUTALU <= DATA1 or DATA2;
    when XORS =>
               OUTALU <= DATA1 xor DATA2;
	when LLS =>
              OUTALU <= std_logic_vector(unsigned(DATA1) SLL to_integer(unsigned(DATA2))); 
	when LRS =>
              OUTALU <= std_logic_vector(unsigned(DATA1) SRL to_integer(unsigned(DATA2)));

	when others => NULL;

    end case; 
  end process P_LS;

end BEHAVIOR;

configuration CFG_LS_BEHAVIORAL of logic_and_shift is
  for BEHAVIOR
  end for;
end CFG_LS_BEHAVIORAL;
