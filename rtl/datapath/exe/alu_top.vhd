----------------------------------------------------------------------------------------------------------
-- Title      : ALU
-- Project    : DLX
----------------------------------------------------------------------------------------------------------
-- File      : ALU.vhd
-- Author    : ms23.13
-----------------------------------------------------------------------------------------------------------
-- Description:
--
-----------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.myTypes.all;

entity alu is
  generic (nbits : integer := 32);
  port (FUNC         : in  aluOp;       --4 bits for the 9 operations.
        DATA1, DATA2 : in  std_logic_vector(nbits-1 downto 0);
        OUTALU       : out std_logic_vector(nbits-1 downto 0)
        );
end alu;

architecture STRUCTURAL of alu is

  component P4_ADDER is
    generic (NBITS : integer := 32);
    port(
      A  : in  std_logic_vector(NBITS-1 downto 0);
      B  : in  std_logic_vector(NBITS-1 downto 0);
      Ci : in  std_logic;
      S  : out std_logic_vector(NBITS-1 downto 0);
      Co : out std_logic
      );
  end component;

  component logic_and_shift is
    generic (N : integer := 32);
    port (FUNC         : in  aluOp;     --4 bits for the 9 operations.
          DATA1, DATA2 : in  std_logic_vector(N-1 downto 0);
          OUTALU       : out std_logic_vector(N-1 downto 0));
  end component;


  component ctrl_alu is
  generic (NBITS : integer := 32);
port(
    A  : in  std_logic_vector(NBITS-1 downto 0);
    B  : in  std_logic_vector(NBITS-1 downto 0);
    FUNC: in aluOp;                                     --4 bits for the 9 operations.
    
    Ap4  : out  std_logic_vector(NBITS-1 downto 0);
    Bp4  : out  std_logic_vector(NBITS-1 downto 0);
    Cin  : out  std_logic;  

    Als  : out  std_logic_vector(NBITS-1 downto 0);
    Bls  : out  std_logic_vector(NBITS-1 downto 0);

    enableComp : out std_logic
);
end component;

begin


end STRUCTURAL;
