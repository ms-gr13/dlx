----------------------------------------------------------------------------------------------------------
-- Title      : Memory Stage
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

entity memoryUnit is
    generic (nbits : integer := 32);

    port(
        clk                 : in  std_logic;  -- Clock
        rst                 : in  std_logic;  -- Reset:Active-Low
        LMD_LATCH_EN        : in  std_logic;  -- Register A Latch Enable
        JUMP_EN             : in  std_logic;  -- Register B Latch Enable
        DRAM_DATA           : in  std_logic_vector(nbits-1 downto 0);
        ALUREG_OUTPUT       : in std_logic_vector(nbits -1 downto 0);
        NPC_OUT             : in std_logic_vector(nbits -1 downto 0);
        COND_OUT            : in std_logic;
        LMD_OUT             : out std_logic_vector(nbits -1 downto 0); 
        TO_PC_OUT           : out std_logic_vector(nbits -1 downto 0)
        );

end memoryUnit;

architecture STRUCTURAL of memoryUnit is


    signal muxjmp_to_mux : std_logic; 
    signal LMD_OUTsig    : std_logic_vector(nbits -1 downto 0);

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

    component MUX21 is
	Port (	A:	In	std_logic;
		B:	In	std_logic;
		S:	In	std_logic;
		Y:	Out	std_logic);
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
    
    begin

        LMD_OUT <= LMD_OUTsig;

        JUMPMUX: MUX21  --MUX21 STD_LOGIC
        generic map (1)
        port map(
            COND_OUT,
            '0',
            JUMP_EN,
            muxjmp_to_mux 
        );

        MUX_PC: MUX21_GENERIC
        generic map (nbits)
        port map(
            ALUREG_OUTPUT, --I PUT THIS FIRST BECAUSE IF SEL = '1' WE SELECT THE OUTPUT OF THE ALU
            NPC_OUT,
            muxjmp_to_mux,
            TO_PC_OUT 
        );

        LMD : register_generic
        generic map (nbits)
        port map(
            DRAM_DATA,
            clk,
            rst,
            LMD_LATCH_EN,
            LMD_OUTsig
        );


end STRUCTURAL;