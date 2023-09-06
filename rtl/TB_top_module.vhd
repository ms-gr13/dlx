library ieee;
use ieee.std_logic_1164.all; 
use WORK.constants.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity TB_top is
end TB_top;

architecture TEST of TB_top is

constant NBITS : integer := 32;
signal clk,rst : std_logic := '1';

component top is
    generic (nbits : integer := 32);
    port(
        Clk_port_top                 : in  std_logic;  -- Clock
        Rst_port_top                 : in  std_logic  -- Reset:Active-Low
    );
end component;
begin
    DLX_TOP : top
    generic map(NBITS)
    port map(
        clk,
        rst
    );

process_clock: process
  begin  -- process p_clock
    clk <= '0';
	wait for 5 ns;
	clk <= '1';
	wait for 5 ns; 
  end process process_clock;

rst <= '0' after 50 ns;
end TEST;