library IEEE;
use IEEE.std_logic_1164.all;

entity SIGN_EXT is
  generic (bits: integer := 16);

  port (
    inputt: in std_logic_vector(bits-1 downto 0);
    outputt: out std_logic_vector(2*bits-1 downto 0)
  );

end SIGN_EXT;

architecture BEHAVIORAL of SIGN_EXT is

begin

  process (inputt)
  begin
    -- Check the MSB of the 16 bit input
    if inputt(15) = '1' then
      -- If MSB is '1', fill the upper 16 bits of the output with '1's
      outputt <= "1111111111111111" & inputt;
    else
      -- If MSB is '0', fill the upper 16 bits of the output with '0's
      outputt <= "0000000000000000" & inputt;
    end if;
  end process;

end BEHAVIORAL;
