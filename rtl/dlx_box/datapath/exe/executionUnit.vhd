----------------------------------------------------------------------------------------------------------
-- Title      : Execution/Address calculation Stage
-- Project    : DLX
----------------------------------------------------------------------------------------------------------
-- File      : dp_exe.vhd
-- Author    : ms23.13
-----------------------------------------------------------------------------------------------------------
-- Description: 
--
-----------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.myTypes.all;

entity executionUnit is
    generic (nbits : integer := 32);

    port(
        clk               : in  std_logic;  -- Clock
        rst               : in  std_logic;  -- Reset:Active-Low
        ALU_OUTREG_ENABLE : in  std_logic;  -- Register A Latch Enable
        MUXA_SEL          : in  std_logic;  -- Register B Latch Enable
        MUXB_SEL          : in  std_logic;  -- Immediate Register Latch Enable
        COND_ENABLE       : in  std_logic;
        ALU_BITS          : in  aluOp;
        NPC_OUT           : in  std_logic_vector(nbits -1 downto 0);
        A_out             : in  std_logic_vector(nbits -1 downto 0);
        B_out             : in  std_logic_vector(nbits -1 downto 0);
        Imm_out           : in  std_logic_vector(nbits -1 downto 0);
        ALUREG_OUTPUT     : out std_logic_vector(nbits -1 downto 0);
        COND_OUT          : out std_logic;  --to the selection bit of the mux in the mem stage
        IR_IN3            : in  std_logic_vector(nbits-1 downto 0);
        IR_OUT3           : out  std_logic_vector(nbits-1 downto 0);
        B_outreg          : out  std_logic_vector(nbits -1 downto 0)
        );

end executionUnit;

architecture STRUCTURAL of executionUnit is

    signal registerA_out : std_logic_vector(nbits-1 downto 0);
    signal registerB_out : std_logic_vector(nbits-1 downto 0);
    signal ALU_output    : std_logic_vector(nbits -1 downto 0);
    signal MUX1_OUT      : std_logic_vector(nbits -1 downto 0);
    signal MUX2_OUT      : std_logic_vector(nbits -1 downto 0);
    signal ZERO_DEC_OUT  : std_logic;
    signal XNOR_OUT       : std_logic;
    signal IR_IN3s       : std_logic_vector(nbits-1 downto 0);
    signal IR_OUT3s      : std_logic_vector(nbits-1 downto 0);
    signal B_outregs     : std_logic_vector(nbits -1 downto 0);

    component FD is
        port (D      : in  std_logic;
              CK     : in  std_logic;
              RESET  : in  std_logic;
              ENABLE : in  std_logic;
              Q      : out std_logic);
    end component;

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


    component MUX21_GENERIC is

        generic(bits : integer := 16);

        port
            (
                A : in  std_logic_vector (bits -1 downto 0);
                B : in  std_logic_vector (bits -1 downto 0);
                S : in  std_logic;
                Y : out std_logic_vector (bits -1 downto 0)
                );
    end component;

    component ZERO_DEC is
        generic (bits : integer := 32);
        port (data        : in  std_logic_vector(bits-1 downto 0);
              zero_detect : out std_logic
              );

    end component;

    component XNOR_logic is
	Port (	A:	In	std_logic;
		B:	In	std_logic;
		Y:	Out	std_logic);
    end component;

    component alu is
        generic (nbits : integer := 32);
        port (FUNC   : in  aluOp;       --4 bits for the 9 operations.
              A  : in  std_logic_vector(nbits-1 downto 0);
              B  : in  std_logic_vector(nbits-1 downto 0);
              OUTALU : out std_logic_vector(nbits-1 downto 0));
    end component;

   

begin

    registerA_out <= A_out;
    registerB_out <= B_out;
    IR_IN3s <= IR_IN3;
    IR_OUT3 <= IR_OUT3s;
    B_outreg <= B_outregs;

    zerodec : ZERO_DEC
        generic map (nbits)
        port map(
            registerA_out,
            ZERO_DEC_OUT
            );

    mux1 : MUX21_GENERIC
        generic map(nbits)
        port map(
            registerA_out,
            NPC_OUT,
            MUXA_SEL,
            MUX1_OUT
            );

    mux2 : MUX21_GENERIC
        generic map(nbits)
        port map(
            Imm_out,
            registerB_out,
            MUXB_SEL,
            MUX2_OUT
            );

    ALUoutput : register_generic
        generic map(nbits)
        port map(
            ALU_output,
            clk,
            rst,
            ALU_OUTREG_ENABLE,
            ALUREG_OUTPUT
            );

    IR3: register_generic
        generic map(nbits)
        port map(
            IR_IN3s,
            clk,
            rst,
            '1',
            IR_OUT3s
        );

    B_outregister: register_generic
        generic map(nbits)
        port map(
            registerB_out,
            clk,
            rst,
            '1',
            B_outregs
        );

    alu1 : ALU
        generic map(nbits)
        port map(
            ALU_BITS,
            MUX1_OUT,
            MUX2_OUT,
            ALU_output
            );

    XNOR_2: XNOR_logic
        port map(
            ZERO_DEC_OUT,
            COND_ENABLE,
            XNOR_OUT
        );
    
    COND : FD
        port map(
            XNOR_OUT,
            clk,
            rst,
            '1',
            COND_OUT
            );

end STRUCTURAL;
