library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.myTypes.all;

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

        --DECODE CONTROL SIGNALS
        RegA_LATCH_EN   : in  std_logic;  -- Register A Latch Enable
        RegB_LATCH_EN   : in  std_logic;  -- Register B Latch Enable
        RegIMM_LATCH_EN : in  std_logic;  -- Immediate Register Latch Enable
        RF_WE           : in  std_logic;


        -- EX Control Signals
        MUXA_SEL           : in std_logic;  -- MUX-A Sel
        MUXB_SEL           : in std_logic;  -- MUX-B Sel
        ALU_OUTREG_EN      : in std_logic;  -- ALU Output Register Enable
        EQ_COND            : in std_logic;  -- Branch if (not) Equal to Zero
        ALU_OPCODE         : in aluOp; -- choose between implicit or exlicit coding, like std_logic_vector(ALU_OPC_SIZE -1 downto 0);


         -- MEM Control Signals
        DRAM_DATA          : in std_logic_vector(nbits -1 downto 0);
        LMD_LATCH_EN       : in std_logic;  -- LMD Register Latch Enable
        JUMP_EN            : in std_logic;  -- JUMP Enable Signal for PC input MUX
        
        -- WB Control signals
        WB_MUX_SEL         : in std_logic;  -- Write Back MUX Sel

        --OUTPUTS -> TO THE MOMORIES
        B                  : out std_logic_vector(nbits -1 downto 0);
        ALU_OUT            : out std_logic_vector(nbits -1 downto 0);
        ADDRESS_IRAM       : out std_logic_vector(nbits - 1 downto 0);
        IR_OUT             : out std_logic_vector(nbits-1 downto 0)  --I ADDDED THIS, THE CU NEEDS IT
        );

end datapath;
 

architecture STRUCTURAL of datapath is
    
    signal ADDRESS_IRAMs : std_logic_vector(nbits-1 downto 0) := (others => '0');
    signal NPC_OUTs      : std_logic_vector(nbits-1 downto 0) := (others => '0');
    signal IR_OUTs       : std_logic_vector(nbits-1 downto 0) := (others => '0');

    signal A_outs        : std_logic_vector(nbits-1 downto 0) := (others => '0');
    signal B_outs        : std_logic_vector(nbits-1 downto 0) := (others => '0');
    signal Imm_outs      : std_logic_vector(nbits-1 downto 0) := (others => '0');

    signal ALUREG_OUTPUTs     : std_logic_vector(nbits -1 downto 0) := (others => '0');
    signal COND_OUTs          : std_logic := '0';

    signal LMD_OUTs           : std_logic_vector(nbits -1 downto 0) := (others => '0'); 
    signal TO_PC_OUTs         : std_logic_vector(nbits -1 downto 0) := (others => '0');
    signal ALU_OUT2s          : std_logic_vector(nbits -1 downto 0);

    signal DATAIN_RFs         : std_logic_vector(nbits -1 downto 0) := (others => '0');

    signal IR_OUT2s           : std_logic_vector(nbits-1 downto 0);
    signal IR_OUT3s           : std_logic_vector(nbits-1 downto 0);
    signal IR_OUT4s           : std_logic_vector(nbits-1 downto 0);
    signal ADDERPC_OUTs       : std_logic_vector(nbits -1 downto 0);

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
        IR_OUT       : out std_logic_vector(nbits -1 downto 0);
        ADDERPC_OUT  : out std_logic_vector(nbits -1 downto 0)
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
        DATAIN          : in  std_logic_vector(nbits-1 downto 0);
        IR_OUT          : in  std_logic_vector(nbits-1 downto 0);
        A_out           : out std_logic_vector(nbits -1 downto 0);
        B_out           : out std_logic_vector(nbits -1 downto 0);
        Imm_out         : out std_logic_vector(nbits -1 downto 0);
        IR_IN2          : in  std_logic_vector(nbits-1 downto 0);
        IR_OUT2         : out  std_logic_vector(nbits-1 downto 0)
        );

    end component;

    component executionUnit is
        generic (nbits : integer := 32);
        port(
            clk                 : in  std_logic;  -- Clock
            rst                 : in  std_logic;  -- Reset:Active-Low
            ALU_OUTREG_ENABLE   : in  std_logic;  -- Register A Latch Enable
            MUXA_SEL            : in  std_logic;  -- Register B Latch Enable
            MUXB_SEL            : in  std_logic;  -- Immediate Register Latch Enable
            COND_ENABLE         : in  std_logic;
            ALU_BITS            : in  aluOp;
            NPC_OUT             : in  std_logic_vector(nbits -1 downto 0);
            A_out               : in  std_logic_vector(nbits -1 downto 0);
            B_out               : in  std_logic_vector(nbits -1 downto 0);
            Imm_out             : in  std_logic_vector(nbits -1 downto 0);
            ALUREG_OUTPUT       : out std_logic_vector(nbits -1 downto 0);
            COND_OUT            : out std_logic; --to the selection bit of the mux in the mem stage
            IR_IN3              : in  std_logic_vector(nbits-1 downto 0);
            IR_OUT3             : out  std_logic_vector(nbits-1 downto 0)
            );
    end component;

    component memoryUnit is
        generic (nbits : integer := 32);
        port(
            clk                 : in  std_logic;  -- Clock
            rst                 : in  std_logic;  -- Reset:Active-Low
            LMD_LATCH_EN        : in  std_logic;  -- Register A Latch Enable
            JUMP_EN             : in  std_logic;  -- Register B Latch Enable
            DRAM_DATA           : in  std_logic_vector(nbits-1 downto 0);
            ALUREG_OUTPUT       : in std_logic_vector(nbits -1 downto 0);
            NPC_OUT             : in std_logic_vector(nbits -1 downto 0);
            COND_OUT            : in std_logic;
            LMD_OUT             : out std_logic_vector(nbits -1 downto 0);
            TO_PC_OUT           : out std_logic_vector(nbits -1 downto 0);
            ALU_OUT2            : out std_logic_vector(nbits -1 downto 0);
            IR_IN4              : in  std_logic_vector(nbits-1 downto 0);
            IR_OUT4             : out  std_logic_vector(nbits-1 downto 0)
            );
    end component;

    component writeBack is
        generic (nbits : integer := 32);
        port(
            LMD_OUT             : in  std_logic_vector(nbits-1 downto 0);
            ALUREG_OUTPUT       : in std_logic_vector(nbits -1 downto 0);
            WB_MUX_SEL          : in std_logic;
            DATAIN_RF           : out std_logic_vector(nbits -1 downto 0) 
            );
    end component;


begin

    B <= B_outs;
    ALU_OUT <= ALUREG_OUTPUTS;
    ADDRESS_IRAM <= ADDRESS_IRAMS;
    IR_OUT <= IR_OUTs;
    FETCH : fetchUnit
    generic map (nbits)
    port map(
        clk,
        rst,
        DATA_IRAM,
        IR_LATCH_EN,
        NPC_LATCH_EN,
        PC_LATCH_EN,
        TO_PC_OUTs,
        ADDRESS_IRAMs,
        NPC_OUTs,
        IR_OUTs,
        ADDERPC_OUTs
    );

    DECODE: decodeUnit
    generic map (nbits)
    port map(
        clk,
        rst,
        RegA_LATCH_EN,
        RegB_LATCH_EN,
        RegIMM_LATCH_EN,
        RF_WE,
        DATAIN_RFs,
        IR_OUTs,
        A_outs,
        B_outs,
        Imm_outs,
        IR_OUT4s,
        IR_OUT2s
    );

    EXECUTE: executionUnit
    generic map (nbits)
    port map(
        clk,
        rst,
        ALU_OUTREG_EN,
        MUXA_SEL,           
        MUXB_SEL,            
        EQ_COND,         
        ALU_OPCODE, 
        NPC_OUTs,             
        A_outs,               
        B_outs,               
        Imm_outs,             
        ALUREG_OUTPUTs,       
        COND_OUTs,
        IR_OUT2s,
        IR_OUT3s         
    );

    MEMORY: memoryUnit
    generic map (nbits)
    port map(
        clk,
        rst,
        LMD_LATCH_EN,    
        JUMP_EN,             
        DRAM_DATA,           
        ALUREG_OUTPUTs,       
        ADDERPC_OUTs,             
        COND_OUTs,            
        LMD_OUTs,            
        TO_PC_OUTs,
        ALU_OUT2s,
        IR_OUT3s,
        IR_OUT4s
    );

    WB: writeBack
    generic map (nbits)
    port map(
        LMD_OUTs,
        ALU_OUT2s,       
        WB_MUX_SEL,
        DATAIN_RFs
    );




end STRUCTURAL;