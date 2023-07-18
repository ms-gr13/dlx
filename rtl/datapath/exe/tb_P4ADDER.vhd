library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity TBSUM_GENERATOR is
end TBSUM_GENERATOR;

architecture TEST of TBSUM_GENERATOR is
        constant nbits : integer := 32;

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

        signal A, B, S   : std_logic_vector(nbits-1 downto 0);
        signal cin, cout : std_logic;

begin

        P4ADDER : P4_ADDER
                port map(A, B, cin, S, cout);



        STIMULUS1 : process                                 --without carrys
        begin
                cin <= '1';
                A   <= "00000001000000100000001000000000";  --0x8000000
                B   <= "00000000001000000100000000100000";
                wait for 5 ns;

                --Carry in bit number 3 (C4 in the proff drawing)
                A <= "00000000000000000000000000001100";
                B <= "00000000000000000000000000001110";
                wait for 5 ns;

                A <= "01010101010101010101010101010101";
                B <= "00101010101010101010101010101010";
                wait for 5 ns;

                A <= "00001000100010001000100010001000";
                B <= "00000001110110001000100010001000";
                wait for 5 ns;

                A <= "11111000100000001000100010001000";
                B <= "00000000000100010001000111111111";
                wait for 5 ns;

                A <= "00000101110100010001000100010100";
                B <= "00111001000100010001000100010100";
                wait for 5 ns;

                A <= "00000001111110001000100010001000";
                B <= "00000010000010001000100010001000";
                wait for 5 ns;

                A <= "01000000101010101000100010001000";
                B <= "01000000010000101000100010001000";
                wait for 5 ns;

                A <= "00101110111011101000100010001000";
                B <= "00001000100010001000100010001000";
                wait for 5 ns;

                A <= "11111111111111111111111111111111";
                B <= "00000000000000000000000000000001";
                wait for 5 ns;

        end process STIMULUS1;
end TEST;

configuration SUM_GENERATORTEST of TBSUM_GENERATOR is
        for TEST
--     for all : SUMGENERATOR
--          use configuration WORK.CFG_SUM_GENERATOR_STRUCTURAL;
--       end for;
        end for;
end SUM_GENERATORTEST;
