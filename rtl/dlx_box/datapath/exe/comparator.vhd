library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use work.myTypes.all;


entity comparator is
  generic (bits : integer := 32);
  port (Cout : in  std_logic;
        EN   : in  std_logic;
        func : in  aluOp;
        sum  : in  std_logic_vector(bits-1 downto 0);
        set  : out std_logic_vector(bits-1 downto 0)
        );
end comparator;


architecture BEHAVIORAL of comparator is

begin
  process(Cout, sum, func)
    variable z       : std_logic;
  variable CoutInv : std_logic;
  variable t       : std_logic;
  begin
    if EN = '1' then
      case func is
        when SGES =>
          if Cout = '1' then
            set <= X"00000001";
          else
            set <= (others => '0');
          end if;

        when SLES =>
          if sum = "0" then
            z := '1';
          else
            z := '0';
          end if;
          CoutInv := not Cout;
          t       := CoutInv xor z;
          if t = '1' then
            set <= X"00000001";
          else
            set <= (others => '0');
          end if;

        when SNES =>
          if sum = "0" then
            z := '1';
          else
            z := '0';
          end if;
          if z = '0' then
            set <= X"00000001";
          else
            set <= (others => '0');
          end if;
        when others =>
          set <= (others => '0');
        end case;
      else
        set <= (others => '0');
      end if;
    end process;
end BEHAVIORAL;
