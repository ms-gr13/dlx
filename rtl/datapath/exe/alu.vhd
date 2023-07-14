
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
--use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;

entity alu is
  generic (N : integer := 8);
  port 	 ( FUNC: in std_logic_vector(3 downto 0); --4 bits for the 9 operations.
           DATA1, DATA2: in std_logic_vector(N-1 downto 0);
           OUTALU: out std_logic_vector(N-1 downto 0));
end alu;

architecture BEHAVIOR of alu is

begin

P_ALU: process (FUNC, DATA1, DATA2)
  -- complete all the requested functions
       variable half1: std_logic_vector(N/2-1 downto 0);
       variable half2: std_logic_vector(N/2-1 downto 0);
  begin
      half1 := DATA1(N/2-1 downto 0);
      half2 := DATA2(N/2-1 downto 0);
 
    
    case FUNC is
 	when "0000" =>
               OUTALU <= DATA1 + DATA2;
 	when "0001"    =>
               OUTALU <= DATA1 - DATA2;
 	when "0010"=>
               OUTALU <= half1 * half2;
 	when "0011"=>
               OUTALU <= DATA1 and DATA2; -- bitwise operations
 	when "0100"=>
               OUTALU <= DATA1 or DATA2;
  when "0101"=>
               OUTALU <= DATA1 xor DATA2;
	when "0110" => 
              OUTALU <= std_logic_vector(unsigned(DATA1) SLL to_integer(unsigned(DATA2))); 
	when "0111" => 
              OUTALU <= std_logic_vector(unsigned(DATA1) SRL to_integer(unsigned(DATA2)));
	when "1000" => 
              OUTALU <= std_logic_vector(unsigned(DATA1) ROL to_integer(unsigned(DATA2)));
	when "1001" => 
              OUTALU <=  std_logic_vector(unsigned(DATA1) ROR to_integer(unsigned(DATA2)));

	when others => NULL;

    end case; 
  end process P_ALU;

end BEHAVIOR;

configuration CFG_ALU_BEHAVIORAL of ALU is
  for BEHAVIOR
  end for;
end CFG_ALU_BEHAVIORAL;
