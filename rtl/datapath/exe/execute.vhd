----------------------------------------------------------------------------------------------------------
-- Title      : Execution/Address calculation Stage
-- Project    : DLX
----------------------------------------------------------------------------------------------------------
-- File      : dp_exe.vhd
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


entity executionUnit is
    generic (nbits : integer := 32);

    port(
        clk                 : in  std_logic;  -- Clock
        rst                 : in  std_logic;  -- Reset:Active-Low
        ALU_OUTREG_ENABLE   : in  std_logic;  -- Register A Latch Enable
        MUXA_SEL            : in  std_logic;  -- Register B Latch Enable
        MUXB_SEL            : in  std_logic;  -- Immediate Register Latch Enable
        EQ_ENABLE           : in  std_logic;
        ALU_BITS            : in  aluOp;
        NPC_OUT             : in  std_logic_vector(nbits -1 downto 0);
        A_out               : in  std_logic_vector(nbits -1 downto 0);
        B_out               : in  std_logic_vector(nbits -1 downto 0);
        Imm_out             : in  std_logic_vector(nbits -1 downto 0);
        ALU_OUTPUT          : out std_logic_vector(nbits -1 downto 0);
        COND_OUT            : out std_logic; --to the selection bit of the mux in the mem stage

        );

end executionUnit;

architecture STRUCTURAL of executionUnit is



    component register_generic is
        generic (nbits : integer := 16);

        port (
            data_in  : in  std_logic_vector(nbits-1 downto 0);
            CK       : in  std_logic;
            RESET    : in  std_logic;
            ENABLE   : in  std_logic;
            data_out : out std_logic_vector(nbits-1 downto 0)
            );
    end component;


    component MUX21_GENERIC is

    generic(bits : integer := 16);
  
	port
      (
        A:	in	    std_logic_vector (bits -1 downto 0);
		    B:	in	    std_logic_vector (bits -1 downto 0);
		    S:	in	    std_logic;
		    Y:	out	    std_logic_vector (bits -1 downto 0)
        );
    end component;