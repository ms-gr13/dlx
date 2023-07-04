----------------------------------------------------------------------------------------------------------
-- Title      : Data ram
-- Project    : DLX
----------------------------------------------------------------------------------------------------------
-- File      : alu.vhd
-- Author    : Riccardo Fusari, Federico Fruttero, Gianluca Corso
-----------------------------------------------------------------------------------------------------------
-- Description: 
--
-----------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dram is
  generic (
    DATA_WIDTH : positive := 32; -- Width of each data word in bits
    ADDR_WIDTH : positive := 10  -- Width of address bus in bits
  );
  port (
    clk   : in  std_logic;
    reset : in  std_logic;
    we    : in  std_logic;     -- Write enable signal
    addr  : in  unsigned(ADDR_WIDTH - 1 downto 0);
    din   : in  std_logic_vector(DATA_WIDTH - 1 downto 0);
    dout  : out std_logic_vector(DATA_WIDTH - 1 downto 0)
  );
end dram;

architecture behavioral of dram is
  type MemoryArray is array (natural range <>) of std_logic_vector(DATA_WIDTH - 1 downto 0);
  signal memory : MemoryArray(0 to 2**ADDR_WIDTH - 1);
begin
  process(clk, reset)
  begin
    if reset = '1' then
      -- Reset memory contents to all zeros
      memory <= (others => (others => '0'));
    elsif rising_edge(clk) then
      if we = '1' then
        -- Write operation: Store data at specified address
        memory(to_integer(addr)) <= din;
      else
        -- Read operation: Provide data from specified address
        dout <= memory(to_integer(addr));
      end if;
    end if;
  end process;
end behavioral;
