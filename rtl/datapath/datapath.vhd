library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity datapath is
    generic (nbits : integer := 32);
    port(
        clk          : in  std_logic;   -- Clock
        rst          : in  std_logic;   -- Reset:Active-Low
        
        --FETCH CONTROL SIGNALS
        DATA_IRAM    : in  std_logic_vector(nbits - 1 downto 0);
        IR_LATCH_EN  : in  std_logic;   -- Instruction Register Latch Enable
        NPC_LATCH_EN : in  std_logic;
        PC_LATCH_EN  : in  std_logic;   -- Program Counte Latch Enable
        PC_IN        : in  std_logic_vector(nbits-1 downto 0);

        --DECODE CONTROL SIGNALS
        RegA_LATCH_EN   : in  std_logic;  -- Register A Latch Enable
        RegB_LATCH_EN   : in  std_logic;  -- Register B Latch Enable
        RegIMM_LATCH_EN : in  std_logic;  -- Immediate Register Latch Enable
        RF_WE           : in  std_logic
    );
end datapath;
 

architecture STRUCTURAL of datapath is
    
    signal DATA_IRAMs    : std_logic_vector(nbits-1 downto 0);
    signal IR_LATCH_ENs  : std_logic;
    signal NPC_LATCH_ENs : std_logic;
    signal PC_LATCH_ENs  : std_logic;
    signal PC_INs        : std_logic_vector(nbits-1 downto 0);
    signal ADDRESS_IRAMs : std_logic_vector(nbits-1 downto 0);
    signal NPC_OUTs      : std_logic_vector(nbits-1 downto 0);
    signal IR_OUTs       : std_logic_vector(nbits-1 downto 0);

    signal RegA_LATCH_ENs  : std_logic;
    signal RegB_LATCH_ENs  : std_logic;
    signal RegIMM_LATCH_ENs : std_logic;
    signal RF_WEs          : std_logic;
    signal A_outs          : std_logic_vector(nbits-1 downto 0);
    signal B_outs          : std_logic_vector(nbits-1 downto 0);
    signal Imm_outs        : std_logic_vector(nbits-1 downto 0);


    component fetchUnit is
    generic (nbits : integer := 32);

    port(
        clk          : in  std_logic;   -- Clock
        rst          : in  std_logic;   -- Reset:Active-Low
        DATA_IRAM    : in  std_logic_vector(nbits - 1 downto 0);
        IR_LATCH_EN  : in  std_logic;   -- Instruction Register Latch Enable
        NPC_LATCH_EN : in  std_logic;
        PC_LATCH_EN  : in  std_logic;   -- Program Counte Latch Enable
        PC_IN        : in  std_logic_vector(nbits-1 downto 0);
        ADDRESS_IRAM : out std_logic_vector(nbits - 1 downto 0);
        NPC_OUT      : out std_logic_vector(nbits -1 downto 0);
        IR_OUT       : out std_logic_vector(nbits -1 downto 0)

        );
    end component;

    component decodeUnit is
    generic (nbits : integer := 32);
    port(
        clk             : in  std_logic;  -- Clock
        rst             : in  std_logic;  -- Reset:Active-Low
        RegA_LATCH_EN   : in  std_logic;  -- Register A Latch Enable
        RegB_LATCH_EN   : in  std_logic;  -- Register B Latch Enable
        RegIMM_LATCH_EN : in  std_logic;  -- Immediate Register Latch Enable
        RF_WE           : in  std_logic;
        IR_OUT          : in  std_logic_vector(nbits-1 downto 0);
        A_out           : out std_logic_vector(nbits -1 downto 0);
        B_out           : out std_logic_vector(nbits -1 downto 0);
        Imm_out         : out std_logic_vector(nbits -1 downto 0)
        );

    end component;


begin
    
    DATA_IRAMs <= DATA_IRAM;
    IR_LATCH_ENs <= IR_LATCH_EN;
    NPC_LATCH_ENs <= NPC_LATCH_EN;
    PC_LATCH_ENs <= PC_LATCH_EN;
    PC_INs <= PC_IN;

    RegA_LATCH_ENs <= RegA_LATCH_EN;
    RegB_LATCH_ENs <= RegB_LATCH_EN;
    RegIMM_LATCH_ENs <= RegIMM_LATCH_EN;
    RF_WEs <= RF_WE; 

    
    FETCH : fetchUnit
    generic map (nbits)
    port map(
        clk,
        rst,
        DATA_IRAMs,
        IR_LATCH_ENs,
        NPC_LATCH_ENs,
        PC_LATCH_ENs,
        PC_INs,
        ADDRESS_IRAMs,
        NPC_OUTs,
        IR_OUTs
    );

    DECODE: decodeUnit
    generic map (nbits)
    port map(
        clk,
        rst,
        RegA_LATCH_ENs,
        RegB_LATCH_ENs,
        RegIMM_LATCH_ENs,
        RF_WEs,
        IR_OUTs,
        A_outs,
        B_outs,
        Imm_outs
    );




end STRUCTURAL;