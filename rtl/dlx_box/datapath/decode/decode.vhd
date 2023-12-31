library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity decodeUnit is
    generic (nbits : integer := 32;
    bits : integer := 16
    );

    port(
        clk             : in  std_logic;  -- Clock
        rst             : in  std_logic;  -- Reset:Active-Low
        RegA_LATCH_EN   : in  std_logic;  -- Register A Latch Enable
        RegB_LATCH_EN   : in  std_logic;  -- Register B Latch Enable
        RegIMM_LATCH_EN : in  std_logic;  -- Immediate Register Latch Enable
        RF_WE           : in  std_logic;
        DATAIN          : in  std_logic_vector(nbits-1 downto 0);
        IR_OUT          : in  std_logic_vector(nbits-1 downto 0);
        A_out           : out std_logic_vector(nbits -1 downto 0);
        B_out           : out std_logic_vector(nbits -1 downto 0);
        Imm_out         : out std_logic_vector(nbits -1 downto 0);
        IR_IN2          : in  std_logic_vector(nbits-1 downto 0);
        IR_OUT2         : out  std_logic_vector(nbits-1 downto 0);
        NPC_IN          : in std_logic_vector(nbits -1 downto 0);
        NPC2_OUT       : out std_logic_vector(nbits -1 downto 0)
        );

end decodeUnit;


architecture STRUCTURAL of decodeUnit is

    signal RegisterAout   : std_logic_vector(nbits-1 downto 0);
    signal RegisterBout   : std_logic_vector(nbits-1 downto 0);
    signal RegisterImmOut : std_logic_vector(nbits-1 downto 0);
    signal signExtIn      : std_logic_vector(16-1 downto 0);
    signal signExtOut     : std_logic_vector(nbits-1 downto 0);
    signal RF_out1        : std_logic_vector(nbits-1 downto 0);
    signal RF_out2        : std_logic_vector(nbits-1 downto 0);

    signal RS1      : std_logic_vector(4 downto 0);
    signal RS2      : std_logic_vector(4 downto 0);
    signal WR_ADDR  : std_logic_vector(4 downto 0);
    signal datainRF : std_logic_vector(nbits-1 downto 0);
    signal IR_OUTs  : std_logic_vector(nbits-1 downto 0);
    signal IR_IN2s  : std_logic_vector(nbits-1 downto 0);
    signal IR_OUT2s : std_logic_vector(nbits-1 downto 0);
    signal NPC_INs  : std_logic_vector(nbits -1 downto 0);
    signal NPC2_OUTs  : std_logic_vector(nbits -1 downto 0);

    component register_generic is
        generic (nbits : integer := 32);

        port (
            data_in  : in  std_logic_vector(nbits-1 downto 0);
            CK       : in  std_logic;
            RESET    : in  std_logic;
            ENABLE   : in  std_logic;
            data_out : out std_logic_vector(nbits-1 downto 0)
            );
    end component;

    component REGISTER_FILE is
        generic (NBITS      : integer := 32;
                 NREGISTERS : integer := 32);

        port (
            CLK     : in  std_logic;
            RESET   : in  std_logic;
            ENABLE  : in  std_logic;
            RD1     : in  std_logic;
            RD2     : in  std_logic;
            WR      : in  std_logic;
            ADD_WR  : in  std_logic_vector(4 downto 0);
            ADD_RD1 : in  std_logic_vector(4 downto 0);
            ADD_RD2 : in  std_logic_vector(4 downto 0);
            DATAIN  : in  std_logic_vector(NBITS-1 downto 0);
            OUT1    : out std_logic_vector(NBITS-1 downto 0);
            OUT2    : out std_logic_vector(NBITS-1 downto 0));
    end component;

    component SIGN_EXT is
        generic (bits : integer := 16);
        port (
            inputt  : in  std_logic_vector(bits-1 downto 0);
            outputt : out std_logic_vector(2*bits-1 downto 0)
            );
    end component;

begin
    --CHECK THIS, I DONT HAVE ANY IDEA
    RS1       <= IR_OUT(25 downto 21);
    RS2       <= IR_OUT(20 downto 16);
    WR_ADDR   <= IR_IN2s(15 downto 11) when (IR_IN2s(31 downto 26) = 0) else IR_IN2s(20 downto 16); --When RTYPE --> 15 downto 1
                                                                                               --When ITYPE --> 20 downto 16
    IR_OUTs  <= IR_OUT;
    IR_OUT2  <= IR_OUT2s;
    IR_IN2s  <= IR_IN2;
    signExtIn <= IR_OUT(15 downto 0);

    A_out <= RF_out1;
    B_out <= RF_out2;
    Imm_out <= RegisterImmout;
    datainRF <= DATAIN;
    NPC_INs <= NPC_IN;
    NPC2_OUT <= NPC2_OUTs;

    NPC2 : register_generic
        generic map(nbits)
        port map(
            NPC_INs,
            clk,
            rst,
            '1',
            NPC2_OUTs
            );

--    B : register_generic
--        generic map(nbits)
--        port map(
--            RF_out2,
--            clk,
--            rst,
--            RegB_LATCH_EN,
--            RegisterBout
--            );

    Imm : register_generic
        generic map(nbits)
        port map(
            signExtOut,
            clk,
            rst,
            RegIMM_LATCH_EN,
            RegisterImmOut
            );

    IR2: register_generic
        generic map(nbits)
        port map(
            IR_OUTs,
            clk,
            rst,
            '1',
            IR_OUT2s
        );

    Signext : SIGN_EXT
        generic map(bits)
        port map(
            signExtIn,
            signExtOut
            );

    RF : REGISTER_FILE
        generic map(nbits)
        port map(
            CLK     => clk,
            RESET   => rst,
            ENABLE  => '1',             --ALWAYS ACTUALLY ENABLED
            RD1     => '1',  --ALWAYS READING, WE WILL ACTUALLY READ WHEN WE ENABLE THE REGISTERS A AND B
            RD2     => '1',             --ALWAYS READING
            WR      => RF_WE,
            ADD_RD1 => RS1,
            ADD_RD2 => RS2,
            ADD_WR  => WR_ADDR,
            DATAIN  => datainRF,
            OUT1    => RF_out1,
            OUT2    => RF_out2
            );

end STRUCTURAL;
