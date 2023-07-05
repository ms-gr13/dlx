library ieee;
use ieee.std_logic_1164.all;

entity testFetch is
end testFetch;

architecture TEST of testFetch is

    constant nbits : integer := 32;

    signal clk          : std_logic := '0';                      -- Clock
    signal rst          : std_logic := '0';                            -- Reset:Active-Low
    signal DATA_IRAM    : std_logic_vector(nbits - 1 downto 0);
    signal IR_LATCH_EN  : std_logic := '1';                      -- Instruction Register Latch Enable
    signal NPC_LATCH_EN : std_logic := '1';
    signal PC_LATCH_EN  : std_logic := '1';                       -- Program Counte Latch Enable
    signal PC_IN        : std_logic_vector(nbits-1 downto 0);
    
    signal ADDRESS_IRAM : std_logic_vector(nbits -1 downto 0);
    signal NPC_OUT      : std_logic_vector(nbits -1 downto 0);
    signal IR_OUT       : std_logic_vector(nbits -1 downto 0);



    component fetchUnit is
    generic (nbits : integer := 32);
    port(
        clk          : in  std_logic;   
        rst          : in  std_logic;   
        DATA_IRAM    : in  std_logic_vector(nbits - 1 downto 0);
        IR_LATCH_EN  : in  std_logic;   
        NPC_LATCH_EN : in  std_logic;
        PC_LATCH_EN  : in  std_logic;   
        PC_IN        : in  std_logic_vector(nbits-1 downto 0);
        ADDRESS_IRAM : out std_logic_vector(nbits - 1 downto 0);
        NPC_OUT      : out std_logic_vector(nbits -1 downto 0);
        IR_OUT       : out std_logic_vector(nbits -1 downto 0)

        );

    end component;

    begin
        fetch : fetchUnit
        generic map(nbits)
        port map(clk,rst,DATA_IRAM,IR_LATCH_EN,NPC_LATCH_EN,PC_LATCH_EN,PC_IN,ADDRESS_IRAM,NPC_OUT,IR_OUT);

        STIMULUS: process
        
        begin
        rst <= '0', '1' after 25 ns;
        IR_LATCH_EN <= '0', '1' after 5 ns;
        NPC_LATCH_EN <= '0', '1' after 6 ns;
        PC_LATCH_EN <= '0', '1' after 5 ns;
        PC_IN <= X"0000FFFF";
        DATA_IRAM <= X"01010101";
        wait for 100 ns;
        end process;

        PCLOCK : process(clk)
        begin
        clk <= not(clk) after 0.5 ns;
        end process;


end TEST;
