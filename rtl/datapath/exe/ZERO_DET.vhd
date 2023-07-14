library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity ZERO_DEC is
  generic (bits : integer := 64);
  port    (data1: in std_logic_vector(bits-1 downto 0);
           data2: in std_logic_vector(bits-1 downto 0);
           Cin: in std_logic;
           zero_detect64: out std_logic;
           zero_detect32: out std_logic
           );
end ZERO_DEC;

architecture BEHAVIORAL of ZER0_DEC is
begin

  signal p: std_logic_vector(bits-1 downto 0);
  signal k: std_logic_vector(bits-2 downto 0);

  1_p: process(data1, data2)

    variable neg1 := not data1(bits-2 downto 0);
    variable neg2 := not data2(bits-2 downto 0);

  begin
    p <= data1 xor data2; --both operands are 0 and carry in bit too
    k <= neg1 and neg2; --one operand has 64 bits set to 1 and the other one or
                        --the carry in bit is the equivalent to 1 in decimal
  end process 1_p;

  2_p: process(p, k, Cin)
    --one operand has the k MSBs set to 1 and the others n LSBs to 0, the other
    --operand has the LSBs set to 0 and the k MSBs set to the binary equivalent
    --of a decimal base 1, the carry is set to 0
    variable C_neg := not C_in;
    variable z: std_logic_vector(bits-1 downto 0);
    variable temp: std_logic;

  begin
    z(63 downto 1) <= p(63 downto 1) xor k;
    z(0) <= p(0) xor C_neg;

    temp := z(0);
    for i in 1 to 63 loop
      temp := temp and z(i);
      if i = 32 then
        zero_detect32 <= temp;
      end if;
    end loop;
    zero_detect64 <= temp;
  end process 2_p;

end BEHAVIORAL;
