----------------------------------------------------------------------------------------------------------
-- Title      : ALU
-- Project    : DLX
----------------------------------------------------------------------------------------------------------
-- File      : alu.vhd
-- Author    : Riccardo Fusari, Federico Fruttero, Gianluca Corso
-----------------------------------------------------------------------------------------------------------
-- Description: This file contains the behavioral description in VHDL of
--              an alu
--
-----------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use WORK.alu_types.all;                 -- Custom data types package



entity ALU is
  generic (N : integer := 16);  -- Generic parameter N representing the size of input and output data
  
  port (
              FUNC         : in  TYPE_OP;  
              DATA1, DATA2 : in  std_logic_vector(N-1 downto 0);  
              OUTALU       : out std_logic_vector(N-1 downto 0)
       ); 

end ALU;


architecture BEHAVIOUR of ALU is
begin

-- Process for performing arithmetic and logic operations
  P_ALU : process (FUNC, DATA1, DATA2)

    -- Declare variables for performing operations
    variable half1 : std_logic_vector(N/2-1 downto 0);  -- Variable for storing the first half of input data1
    variable half2 : std_logic_vector(N/2-1 downto 0);  -- Variable for storing the first half of input data2

  begin

    half1 := DATA1(N/2-1 downto 0);     -- Extract the first half of data1
    half2 := DATA2(N/2-1 downto 0);     -- Extract the first half of data2

    -- Perform the operation based on the input function
    case FUNC is
      when ADD =>
        OUTALU <= DATA1 + DATA2;  
      when SUB =>
        OUTALU <= DATA1 - DATA2;  
      when MULT =>
        OUTALU <= half1 * half2;  -- Multiply the first halves of data1 and data2 and store the result in output port
      when BITAND =>
        OUTALU <= DATA1 and DATA2;  
      when BITOR =>
        OUTALU <= DATA1 or DATA2;  
      when BITXOR =>
        OUTALU <= DATA1 xor DATA2;  
      when FUNCLSL =>
        OUTALU <= DATA1(N-2 downto 0) & '0';         -- Perform shift left using the concatenation operator &
      when FUNCLSR =>
        OUTALU <= '0' & DATA1(N-1 downto 1);         -- Perform shift right using the concatenation operator &
      when FUNCRL =>
        OUTALU <= DATA1(N-2 downto 0) & DATA1(N-1);  -- Perform rotate left using the concatenation operator &
      when FUNCRR =>
        OUTALU <= DATA1(0) & DATA1(N-1 downto 1);    -- Perform rotate right using the concatenation operator &
      when others => null;
    end case;
  end process P_ALU;

end BEHAVIOUR;


