library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.myTypes.all;

entity top is
    generic (nbits : integer := 32);
    port(
        Clk_port_top                 : in  std_logic;  -- Clock
        Rst_port_top                 : in  std_logic  -- Reset:Active-Low
    );
end top;

architecture STRUCTURAL of top is
    signal clk_s                   : std_logic;
    signal rst_s                   : std_logic;
    signal WE_DRAM_signal          : std_logic;
    signal ADDRESS_DRAM_signal     : std_logic_vector(nbits -1 downto 0);
    signal DATAread_DRAM_signal    : std_logic_vector(nbits -1 downto 0);
    signal DATAwrite_DRAM_signal   : std_logic_vector(nbits -1 downto 0);
    signal ADDRESS_IRAM_signal     : std_logic_vector(nbits - 1 downto 0);
    signal DATA_IRAM_signal        : std_logic_vector(nbits - 1 downto 0);

    component dlx is
    generic (nbits : integer := 32);
    port(
        Clk_port                 : in  std_logic;  -- Clock
        Rst_port                 : in  std_logic;  -- Reset:Active-Low
        DATA_IRAM_port           : in  std_logic_vector(nbits - 1 downto 0);
        DATAread_DRAM_port       : in  std_logic_vector(nbits -1 downto 0);
        WE_DRAM_port             : out std_logic;  -- Data RAM Write Enable
        ADDRESS_DRAM_port        : out std_logic_vector(nbits -1 downto 0);
        DATAwrite_DRAM_port      : out  std_logic_vector(nbits -1 downto 0);
        ADDRESS_IRAM_port        : out std_logic_vector(nbits - 1 downto 0)
    );
    end component;

    component dram is
    generic (
        D_WIDTH : integer := 32;    
        ADDR_WIDTH : integer := 16    
    );
    Port ( 
        clk      : in      STD_LOGIC;                
        w_r      : in      STD_LOGIC;                                  -- Write/READneg enable signal
        addr     : in      STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);  
        data_in  : in      STD_LOGIC_VECTOR(D_WIDTH-1 downto 0);     -- Data input for write operation
        data_out : out     STD_LOGIC_VECTOR(D_WIDTH-1 downto 0)      -- Data output for read operation
    );
    end component;

    component IRAM is
    generic (
    RAM_DEPTH : integer := 48;
    I_SIZE : integer := 32);
    port (
    Rst  : in  std_logic;
    Addr : in  std_logic_vector(I_SIZE - 1 downto 0);
    Dout : out std_logic_vector(I_SIZE - 1 downto 0)
    );
    end component;



    begin
    clk_s <= Clk_port_top;
    rst_s <= Rst_port_top;

    DLX_INST: dlx
    generic map (nbits)
    port map(
        clk_s,
        rst_s,
        DATA_IRAM_signal,
        DATAread_DRAM_signal,
        WE_DRAM_signal,
        DATAwrite_DRAM_signal,
        ADDRESS_DRAM_signal
    );

    I_RAM: IRAM
    port map(
        rst_s,
        ADDRESS_IRAM_signal,
        DATA_IRAM_signal
    );

    D_DRAM: DRAM
    port map(
        clk_s,
        WE_DRAM_signal,
        ADDRESS_DRAM_signal,
        DATAwrite_DRAM_signal,
        DATAread_DRAM_signal
    );

end STRUCTURAL;