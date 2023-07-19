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
        A            : in  std_logic_vector(nbits-1 downto 0);
        B            : in  std_logic_vector(nbits-1 downto 0);
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


  --SIGNALS P4
  signal p4_ctrl_A   : std_logic_vector (NBITS-1 downto 0);
  signal p4_ctrl_B   : std_logic_vector (NBITS-1 downto 0);
  signal p4_ctrl_Cin : std_logic;
  signal p4_out      : std_logic_vector (NBITS-1 downto 0);
  signal p4_comp_Co  : std_logic;

  --SIGNALS LOGIC & SHIFT
  signal ctrl_LS_A   : std_logic_vector (NBITS-1 downto 0);
  signal ctrl_LS_B   : std_logic_vector (NBITS-1 downto 0);
  signal FUNC_SIGNAL : aluOp;
  signal LS_OUT      : std_logic_vector (NBITS-1 downto 0);

  --SIGNALS COMPARATOR
  signal enable_Comp : std_logic;

begin
  FUNC_SIGNAL <= FUNC;

  CTRLALU: ctrl_alu
    generic map(NBITS)
    port map(
      A,
      B,
      FUNC,
      p4_ctrl_A,
      p4_ctrl_B,
      p4_ctrl_Cin,
      ctrl_LS_A,
      ctrl_LS_B,
      enable_Comp
    );


  ADDER_SUB: P4_ADDER
    generic map(NBITS)
    port map(
      p4_ctrl_A,
      p4_ctrl_B,
      p4_ctrl_Cin,
      p4_out,
      p4_comp_Co
    );

  LOGIC_SHIFT: logic_and_shift
    generic map(NBITS)
    port map(
      FUNC_SIGNAL,
      ctrl_LS_A,
      ctrl_LS_B,
      LS_OUT
    );

  --HERE THE COMPARATOR

    

end STRUCTURAL;
