----------------------------------------------------------------------------------------------------------
-- Title      : Data ram
-- Project    : DLX
----------------------------------------------------------------------------------------------------------
-- File      : dram.vhd
-- Author    : Riccardo Fusari, Federico Fruttero, Gianluca Corso
-----------------------------------------------------------------------------------------------------------
-- Description: 
--
-----------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use ieee.std_logic_unsigned.all;


entity dram is
    generic (
        D_WIDTH : integer := 32;    
        ADDR_WIDTH : integer := 16    
    );
    Port ( 
        clk      : in      STD_LOGIC;                
        en       : in      STD_LOGIC;                                  -- Enable signal 
        wm       : in      STD_LOGIC;                                  -- Write enable signal
        rm       : in      STD_LOGIC;                                  -- Read enable signal
        addr     : in      STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);  
        data_in  : in      STD_LOGIC_VECTOR(D_WIDTH-1 downto 0);     -- Data input for write operation
        data_out : out     STD_LOGIC_VECTOR(D_WIDTH-1 downto 0)      -- Data output for read operation
    );
end dram;

architecture behavioral of dram is

    
    subtype mem_array is natural range 0 to (2**ADDR_WIDTH);
    type data_array is array(mem_array) of std_logic_vector(D_WIDTH-1 downto 0);
    signal data_memory : data_array;-- := (others => (others => '0'));

begin
    process (clk)
    begin
        if rising_edge(clk) then
            -- Memory operations are synchronized with the rising edge of the clock
            if en = '1' then
                if wm = '1' then  -- Write operation
                    data_memory(to_integer(unsigned(addr))) <= data_in; -- Byte addressable in Big Endian
                elsif rm = '1' then  -- Read operation
                    data_out <= data_memory(to_integer(unsigned(addr))); -- Byte addressable in Big Endian
                else
                    data_out <= (others => '0'); -- Invalid operation
                end if;
            else
                data_out <= (others => 'Z'); -- Tri-state output when ENABLE is '0'
            end if;
        end if;
    end process;
end behavioral;

