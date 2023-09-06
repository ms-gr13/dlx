library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity fetchUnit is
    generic (nbits : integer := 32);
    port(
        clk          : in  std_logic;   -- Clock
        rst          : in  std_logic;   -- Reset:Active-Low
        DATA_IRAM    : in  std_logic_vector(nbits - 1 downto 0);
        IR_LATCH_EN  : in  std_logic;   -- Instruction Register Latch Enable
        NPC_LATCH_EN : in  std_logic;
        PC_LATCH_EN  : in  std_logic;   -- Program Counter Latch Enable
        PC_IN        : in  std_logic_vector(nbits-1 downto 0);
        ADDRESS_IRAM : out std_logic_vector(nbits - 1 downto 0);
        NPC_OUT      : out std_logic_vector(nbits -1 downto 0);
        IR_OUT       : out std_logic_vector(nbits -1 downto 0)

        );

end fetchUnit;


architecture STRUCTURAL of fetchUnit is
    type mySignals is array (1 downto 0) of std_logic_vector(nbits-1 downto 0);
    signal sigVec : mySignals;
    signal one   : std_logic_vector(nbits-1 downto 0);

    component register_generic is
        generic (nbits : integer := 16);
        port (
            data_in  : in  std_logic_vector(nbits-1 downto 0);
            CK       : in  std_logic;
            RESET    : in  std_logic;
            ENABLE   : in  std_logic;
            data_out : out std_logic_vector(nbits-1 downto 0)
            );
    end component;

    component RCA is
        generic (NBITS : integer := 32);
        port (A  : in  std_logic_vector(NBITS-1 downto 0);
              B  : in  std_logic_vector(NBITS-1 downto 0);
              Ci : in  std_logic;
              S  : out std_logic_vector(NBITS-1 downto 0);
              Co : out std_logic);
    end component;


begin
    one <= std_logic_vector(to_unsigned(1, nbits));
    ADDRESS_IRAM <= sigVec(0);


    ADD : RCA
        generic map(nbits)
        port map(
            A  => sigVec(0),
            B  => one,
            Ci => '0',
            S  => sigVec(1)
            );

    PC : register_generic
        generic map(nbits)
        port map(
            PC_IN,
            clk,
            rst,
            PC_LATCH_EN,
            sigVec(0)
            );

    IR : register_generic
        generic map(nbits)
        port map(
            DATA_IRAM,
            clk,
            rst,
            IR_LATCH_EN,
            IR_OUT
            );

    NPC : register_generic
        generic map(nbits)
        port map(
            sigVec(1),
            clk,
            rst,
            NPC_LATCH_EN,
            NPC_OUT
            );

end STRUCTURAL;
