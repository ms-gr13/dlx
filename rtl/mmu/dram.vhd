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
        ADDR_WIDTH : integer := 32    
    );
    Port ( 
        clk      : in      STD_LOGIC;                
        w_r      : in      STD_LOGIC;                                  -- Write/READneg enable signal
        addr     : in      STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);  
        data_in  : in      STD_LOGIC_VECTOR(D_WIDTH-1 downto 0);     -- Data input for write operation
        data_out : out     STD_LOGIC_VECTOR(D_WIDTH-1 downto 0)      -- Data output for read operation
    );
end dram;

architecture behavioral of dram is

    
    subtype mem_array is natural range 0 to (2**7);
    type data_array is array(mem_array) of std_logic_vector(D_WIDTH-1 downto 0);
    signal data_memory : data_array;-- := (others => (others => '0'));

begin
    process (clk)
    begin
        if rising_edge(clk)  then 
            -- Memory operations are synchronized with the rising edge of the clock
            if  w_r = '1' then  -- Write operation
                data_memory(to_integer(unsigned(addr))) <= data_in; -- Byte addressable in Big Endian    
            elsif (w_r = '0' and addr < "10000000" )then  -- Read operation, addr<128
                data_out <= data_memory(to_integer(unsigned(addr))); -- Byte addressable in Big Endian
            end if;
        end if;
    end process;
end behavioral;

