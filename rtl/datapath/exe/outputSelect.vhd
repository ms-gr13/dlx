library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.myTypes.all;

entity outputSelect is
generic (nbits : integer := 32);
  port (FUNC         : in  aluOp;       --4 bits for the 9 operations.
        p4_out       : in std_logic_vector (NBITS-1 downto 0);    
        LS_OUT       : in std_logic_vector (NBITS-1 downto 0);
        comp_out     : in std_logic_vector (NBITS-1 downto 0);
        outputSel    : out std_logic_vector(NBITS-1 downto 0)
        );
end outputSelect;

architecture BEHAVIORAL of outputSelect is
    
    begin

    process(FUNC, p4_out,LS_OUT,comp_out)
        begin
        case FUNC is
            when ADDS | SUBS =>
                outputSel <= p4_out;

            when LLS | LRS | ANDS | ORS | XORS =>
                outputSel <= LS_OUT;

            when SNES | SLES | SGES =>
                outputSel <= comp_out;
            when others =>
                outputSel <= (others => '0');
        end case;
        end process;
end BEHAVIORAL;