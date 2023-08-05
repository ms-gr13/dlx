----------------------------------------------------------------------------------------------------------
-- Title      : Data ram Testbench
-- Project    : DLX
----------------------------------------------------------------------------------------------------------
-- File      : tb_dram.vhd
-- Author    : Riccardo Fusari, Federico Fruttero, Gianluca Corso
-----------------------------------------------------------------------------------------------------------
-- Description: 
--
-----------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_dram is
end tb_dram;

architecture sim of tb_dram is
    -- Constants
    constant CLK_PERIOD : time := 1 ns;  -- Clock period (adjust as needed)
    constant D_WIDTH : integer := 32;     -- Data width for the memory
    constant ADDR_WIDTH : integer := 16;  -- Address width for the memory

    -- Signals
    signal clk       : std_logic := '0';         -- Clock signal
    signal en        : std_logic := '1';         -- Enable signal (active high)
    signal wm        : std_logic := '1';         -- Write enable signal (active high)
    signal rm        : std_logic := '1';         -- Read enable signal (active high)
    signal addr      : std_logic_vector(ADDR_WIDTH - 1 downto 0) := (others => '0');  -- Address signal
    signal data_in   : std_logic_vector(D_WIDTH - 1 downto 0) := (others => '0');     -- Data input for write
    signal data_out  : std_logic_vector(D_WIDTH - 1 downto 0);                        -- Data output for read

    -- Data memory component
    component dram
        generic (
            D_WIDTH    : integer := 32;
            ADDR_WIDTH : integer := 32
        );

        port (
            clk      : in  std_logic;
            en       : in  std_logic;
            wm       : in  std_logic;
            rm       : in  std_logic;
            addr     : in  std_logic_vector(ADDR_WIDTH - 1 downto 0);
            data_in  : in  std_logic_vector(D_WIDTH - 1 downto 0);
            data_out : out std_logic_vector(D_WIDTH - 1 downto 0)
        );
    end component;

begin
    -- Instantiate the dram component
    DUT: dram
        generic map (
            D_WIDTH    => D_WIDTH,
            ADDR_WIDTH => ADDR_WIDTH
        )
        port map (
            clk      => clk,
            en       => en,
            wm       => wm,
            rm       => rm,
            addr     => addr,
            data_in  => data_in,
            data_out => data_out
        );

    -- Clock process
    PCLOCK: process(clk)
    begin
        clk <= not(clk) after 0.5 ns;
    end process;

    -- Test process
    STIMULUS: process
    begin
        report "Starting the testbench" severity note;

        -- Write data to memory at address 0x00
        wm <= '1';       -- Enable write operation
        addr <= x"0000"; -- Address 0x00
        data_in <= x"11001100"; -- Data to be written
        wait for CLK_PERIOD * 5;  -- Wait for a few clock cycles
        report "Here!" severity note;
        wm <= '0';       -- Disable write operation

        -- Read data from memory at address 0x00
        rm <= '1';       -- Enable read operation
        addr <= x"0000"; -- Address 0x00
        wait for CLK_PERIOD * 5;  -- Wait for a few clock cycles
        assert data_out = x"11001100" report "Read data mismatch at address 0x00" severity error;
        rm <= '0';       -- Disable read operation

        -- Write data to memory at address 0x04
        wm <= '1';       -- Enable write operation
        addr <= x"0004"; -- Address 0x04
        data_in <= x"10101010"; -- Data to be written
        wait for CLK_PERIOD * 5;  -- Wait for a few clock cycles
        wm <= '0';       -- Disable write operation

        -- Read data from memory at address 0x04
        rm <= '1';       -- Enable read operation
        addr <= x"0004"; -- Address 0x04
        wait for 5 ns;
        assert data_out = x"10101010" report "Read data mismatch at address 0x04" severity error;
        rm <= '0';       -- Disable read operation

        ---- Write to the highest valid address
        wm <= '1';       -- Enable write operation
        addr <= x"FFFF"; -- Highest valid address
        data_in <= x"11110000"; -- Data to be written
        wait for CLK_PERIOD * 5;  -- Wait for a few clock cycles
        wm <= '0';       -- Disable write operation
        ---- Read from the highest valid address after writing
        rm <= '1';       -- Enable read operation
        addr <= x"FFFF"; -- Highest valid address
        wait for CLK_PERIOD * 5;  -- Wait for a few clock cycles
        assert data_out = x"11110000" report "Read from highest valid address after writing did not produce correct data" severity error;
        rm <= '0';       -- Disable read operation

        -- Add more read and write operations as needed for further testing

        report "All test cases passed!" severity note;
        wait;
    end process STIMULUS;

end sim;
