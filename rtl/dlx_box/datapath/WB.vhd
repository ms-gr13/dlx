----------------------------------------------------------------------------------------------------------
-- Title      : Write Back Stage
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

entity writeBack is
    generic (nbits : integer := 32);
    port(
        LMD_OUT             : in  std_logic_vector(nbits-1 downto 0);
        ALUREG_OUTPUT       : in std_logic_vector(nbits -1 downto 0);
        WB_MUX_SEL          : in std_logic;
        DATAIN_RF           : out std_logic_vector(nbits -1 downto 0)  
        );
end writeBack;


architecture STRUCTURAL of writeBack is

    signal DATAIN_RFsig : std_logic_vector(nbits-1 downto 0); 

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
        DATAIN_RF <= DATAIN_RFsig;

    MUXWB: MUX21_GENERIC
    generic map(nbits)
    port map(
        ALUREG_OUTPUT,
        LMD_OUT,
        WB_MUX_SEL,
        DATAIN_RFsig
    );

end STRUCTURAL;
