library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.myTypes.all;

entity ctrl_alu is
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
end ctrl_alu;

architecture BEHAVIORAL of ctrl_alu is
    begin
    control_alu: process(FUNC, A, B)
    begin
    case FUNC is
        when ADDS => 
                    Ap4 <= A;
                    Bp4 <= B;
                    Cin <= '0';
                    Als <= "0";
                    Bls <= "0";
                    enableComp <= '0';
        when SUBS =>
                    Ap4 <= A;
                    Bp4 <= B;
                    Cin <= '1';
                    Als <= "0";
                    Bls <= "0";
                    enableComp <= '0';
        
        when LLS | LRS | ANDS | ORS | XORS =>
                    Ap4 <= "0";
                    Bp4 <= "0";
                    Cin <= '0';
                    enableComp <= '0';
                    Als <= A;
                    Bls <= B;

        when SNES | SLES | SGES =>
                    Ap4 <= A;
                    Bp4 <= B;
                    Cin <= '1';
                    enableComp <= '1';
                    Als <= "0";
                    Bls <= "0";

        when others =>
                    Ap4 <= "0";
                    Bp4 <= "0";
                    Als <= "0";
                    Bls <= "0";
                    Cin <= '0';
                    enableComp <= '0';
    end case;
    end process control_alu;
end BEHAVIORAL;