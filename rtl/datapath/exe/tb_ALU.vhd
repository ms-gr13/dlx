library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.myTypes.all;

entity TBALU is
end TBALU;

architecture TEST of TBALU is
  constant nbits : integer := 32;

  component alu is
    generic (nbits : integer := 32);
    port (FUNC   : in  aluOp;           --4 bits for the 9 operations.
          A      : in  std_logic_vector(nbits-1 downto 0);
          B      : in  std_logic_vector(nbits-1 downto 0);
          OUTALU : out std_logic_vector(nbits-1 downto 0)
          );
  end component;

  signal Asig, Bsig : std_logic_vector(nbits-1 downto 0);
  signal FUNCsig    : aluOp;
  signal OUTsig     : std_logic_vector(nbits-1 downto 0);

begin

  ALU_DUT : alu
    generic map(nbits)
    port map(
      FUNCsig,
      Asig,
      Bsig,
      OUTsig
      );

  STIMULUS1 : process
  begin
    Asig <= X"00003333";
    Bsig <= X"00001111";
    FUNCsig <= ADDS;
    wait for 5 ns;

    FUNCsig <= ANDS;
    wait for 5 ns;

    FUNCsig <= SNES;
    wait for 5 ns;

  end process STIMULUS1;

end TEST;
