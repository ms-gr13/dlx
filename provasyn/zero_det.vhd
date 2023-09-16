library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity ZERO_DEC is
  generic (bits : integer := 32);
  port    (data: in std_logic_vector(bits-1 downto 0);
           zero_detect: out std_logic
           );
end ZERO_DEC;

architecture BEHAVIORAL of ZERO_DEC is
begin

  zero_detect <= '1' when data = "00000000000000000000000000000000" else '0';
 
end BEHAVIORAL;
