
library ieee;
use ieee.std_logic_1164.all;

entity CarrySelect is
  generic(
    NBITS : integer := 4);

  port (
    A   : in  std_logic_vector(NBITS-1 downto 0);  --each input 4 bits
    B   : in  std_logic_vector(NBITS-1 downto 0);
    Cin : in  std_logic;
    S   : out std_logic_vector(NBITS-1 downto 0)
    );
end CarrySelect;

architecture STRUCTURAL of CarrySelect is
  signal CI1  : std_logic := '1';
  signal CI0  : std_logic := '0';
  signal sum1 : std_logic_vector(NBITS-1 downto 0);
  signal sum2 : std_logic_vector(NBITS-1 downto 0);


  component RCA
    generic (DRCAS : time    := 0 ns;
             DRCAC : time    := 0 ns;
             NBITS : integer := 32
             );
    port (A  : in  std_logic_vector(NBITS-1 downto 0);
          B  : in  std_logic_vector(NBITS-1 downto 0);
          Ci : in  std_logic;
          S  : out std_logic_vector(NBITS-1 downto 0);
          Co : out std_logic);
  end component;

  component MUX21_GENERIC
    generic (bits : integer := 16);

    port (
      A : in  std_logic_vector (bits -1 downto 0);
      B : in  std_logic_vector (bits -1 downto 0);
      S : in  std_logic;
      Y : out std_logic_vector (bits -1 downto 0)
      );

  end component;

begin
  --Instantiate the 2 RCA:
<<<<<<< HEAD
  RCA1 : entity work.RCA(STRUCTURAL)
    generic map (DRCAS => 0 ns, DRCAC => 0 ns, NBITS => NBITS)
    port map (A, B, CI0, sum1);


  RCA2 : entity work.RCA(STRUCTURAL)
    generic map (DRCAS => 0 ns, DRCAC => 0 ns, NBITS => NBITS)
=======
  RCA1 : RCA
    generic map (NBITS => NBITS)
    port map (A, B, CI0, sum1);


  RCA2 : RCA
    generic map (NBITS => NBITS)
>>>>>>> e679a782b465149b648f5c25bad876ab11c85644
    port map (A, B, CI1, sum2);

  MUX21_GEN : MUX21_GENERIC
    generic map (NBITS)
    port map(sum2, sum1, Cin, S);


end STRUCTURAL;
