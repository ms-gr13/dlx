library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity Comparator is
  generic (bits : integer :=32);
  port (Cout: in std_logic;
        sum: in std_logic_vector(bits-1 downto 0);
        setneq: out std_logic;
        setgr : out std_logic;
        setlo : out std_logic
        );
end Comparator;


architecture BEHAVIORAL of Comparator is
  signal z : std_logic;
  signal CoutInv : std_logic;
  signal t : std_logic;
  begin
    process(Cout, sum)
    begin
      for i in bits-1 downto 0 loop
        z <= not (sum(i) or '0');
      end loop;

      if z = '0' then
        setneq <= '1';
      end if;

      if Cout = '1' then
        setgr <= '1';
      end if;

      CoutInv <= not Cout;

      t <= CoutInv xor z;

      if t = '1' then
        setlo <= '1';
      end if;

  end process;

end BEHAVIORAL;











