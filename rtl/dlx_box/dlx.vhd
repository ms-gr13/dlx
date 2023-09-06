library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.myTypes.all;

entity dlx is
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
end dlx;

architecture STRUCTURAL of dlx is
    signal clk_signal                   : std_logic := '0';
    signal rst_signal                   : std_logic := '0';
    signal DATAread_DRAM_signal             : std_logic_vector(nbits -1 downto 0) := (others => '0');
    signal DATAwrite_DRAM_signal            : std_logic_vector(nbits -1 downto 0) := (others => '0');
    signal ADDRESS_DRAM_signal          : std_logic_vector(nbits -1 downto 0) := (others => '0');
        --IRAM:
    signal ADDRESS_IRAM_signal          : std_logic_vector(nbits - 1 downto 0) := (others => '0');
    signal DATA_IRAM_signal             : std_logic_vector(nbits - 1 downto 0) := (others => '0');    
    -- CONTROL UNIT:
    signal    IR_OUT_signal                : std_logic_vector(nbits - 1 downto 0) := (others => '0');
    signal    IR_LATCH_EN_signal        : std_logic := '0';  -- Instruction Register Latch Enable
    signal    NPC_LATCH_EN_signal       : std_logic := '0';
                                            -- NextProgramCounter Register Latch Enable
        -- ID Control Signals
    signal    RegA_LATCH_EN_signal      : std_logic := '0';  -- Register A Latch Enable
    signal    RegB_LATCH_EN_signal      : std_logic := '0';  -- Register B Latch Enable
    signal    RegIMM_LATCH_EN_signal    : std_logic := '0';  -- Immediate Register Latch Enable

        -- EX Control Signals
    signal    MUXA_SEL_signal           : std_logic := '0';  -- MUX-A Sel
    signal    MUXB_SEL_signal           : std_logic := '0';  -- MUX-B Sel
    signal    ALU_OUTREG_EN_signal      : std_logic := '0';  -- ALU Output Register Enable
    signal    EQ_COND_signal            : std_logic := '0';  -- Branch if (not) Equal to Zero
        -- ALU Operation Code
    signal    ALU_OPCODE_signal         : aluOp; -- choose between implicit or exlicit coding, like std_logic_vector(ALU_OPC_SIZE -1 downto 0);
        
        -- MEM Control Signals
    signal    DRAM_WE_signal            : std_logic := '0';  -- Data RAM Write Enable
    signal    LMD_LATCH_EN_signal       : std_logic := '0';  -- LMD Register Latch Enable
    signal    JUMP_EN_signal            : std_logic := '0';  -- JUMP Enable Signal for PC input MUX
    signal    PC_LATCH_EN_signal        : std_logic := '0';  -- Program Counte Latch Enable

        -- WB Control signals
    signal    WB_MUX_SEL_signal         : std_logic := '0';  -- Write Back MUX Sel
    signal    RF_WE_signal              : std_logic := '0';  -- Register File Write Enable


    component datapath is
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
            ALU_OUT            : out std_logic_vector(nbits -1 downto 0); --DATA IN TO DRAM
            ADDRESS_IRAM       : out std_logic_vector(nbits - 1 downto 0);
            IR_OUT             : out std_logic_vector(nbits-1 downto 0)  --I ADDDED THIS, THE CU NEEDS IT
            );
    end component;


    component dlx_cu is
    generic (
        MICROCODE_MEM_SIZE :     integer := 10;  -- Microcode Memory Size
        FUNC_SIZE          :     integer := 11;  -- Func Field Size for R-Type Ops
        OP_CODE_SIZE       :     integer := 6;  -- Op Code Size
        IR_SIZE            :     integer := 32;  -- Instruction Register Size    
        CW_SIZE            :     integer := 15);  -- Control Word Size
    port (
        Clk                : in  std_logic;  -- Clock
        Rst                : in  std_logic;  -- Reset:Active-Low
        -- Instruction Register
        IR_IN              : in  std_logic_vector(IR_SIZE - 1 downto 0);
        
        -- IF Control Signal
        IR_LATCH_EN        : out std_logic;  -- Instruction Register Latch Enable
        NPC_LATCH_EN       : out std_logic;
                                            -- NextProgramCounter Register Latch Enable
        -- ID Control Signals
        RegA_LATCH_EN      : out std_logic;  -- Register A Latch Enable
        RegB_LATCH_EN      : out std_logic;  -- Register B Latch Enable
        RegIMM_LATCH_EN    : out std_logic;  -- Immediate Register Latch Enable

        -- EX Control Signals
        MUXA_SEL           : out std_logic;  -- MUX-A Sel
        MUXB_SEL           : out std_logic;  -- MUX-B Sel
        ALU_OUTREG_EN      : out std_logic;  -- ALU Output Register Enable
        EQ_COND            : out std_logic;  -- Branch if (not) Equal to Zero
        -- ALU Operation Code
        ALU_OPCODE         : out aluOp; -- choose between implicit or exlicit coding, like std_logic_vector(ALU_OPC_SIZE -1 downto 0);
        
        -- MEM Control Signals
        DRAM_WE            : out std_logic;  -- Data RAM Write Enable
        LMD_LATCH_EN       : out std_logic;  -- LMD Register Latch Enable
        JUMP_EN            : out std_logic;  -- JUMP Enable Signal for PC input MUX
        PC_LATCH_EN        : out std_logic;  -- Program Counte Latch Enable

        -- WB Control signals
        WB_MUX_SEL         : out std_logic;  -- Write Back MUX Sel
        RF_WE              : out std_logic);  -- Register File Write Enable
    end component;

    begin
        --ASSIGNMENTS:
        clk_signal              <=      Clk_port;
        rst_signal              <=      Rst_port;
        DATA_IRAM_signal        <=      DATA_IRAM_port;
        DATAread_DRAM_signal    <=      DATAread_DRAM_port;
        --SET THE OUTPUTS:
        DATAwrite_DRAM_port <=      DATAwrite_DRAM_signal;
        ADDRESS_IRAM_port   <=      ADDRESS_IRAM_signal;
        ADDRESS_DRAM_port   <=      ADDRESS_DRAM_signal;
        WE_DRAM_port        <=      DRAM_WE_signal;

        --INSTANTIATIONS:
        CONTROL_UNIT: dlx_cu
        port map(
            clk_signal,
            rst_signal,
            IR_OUT_signal,
            IR_LATCH_EN_signal,
            NPC_LATCH_EN_signal,
            RegA_LATCH_EN_signal,
            RegB_LATCH_EN_signal,
            RegIMM_LATCH_EN_signal,
            MUXA_SEL_signal,
            MUXB_SEL_signal,
            ALU_OUTREG_EN_signal,
            EQ_COND_signal,
            ALU_OPCODE_signal,
            DRAM_WE_signal,
            LMD_LATCH_EN_signal,
            JUMP_EN_signal,
            PC_LATCH_EN_signal,
            WB_MUX_SEL_signal,
            RF_WE_signal
        );

        DATA_PATH: datapath
        generic map (nbits)
        port map(
            clk_signal,
            rst_signal,
            DATA_IRAM_signal,
            IR_LATCH_EN_signal,
            NPC_LATCH_EN_signal,
            PC_LATCH_EN_signal,
            RegA_LATCH_EN_signal,
            RegB_LATCH_EN_signal,
            RegIMM_LATCH_EN_signal,
            RF_WE_signal,
            MUXA_SEL_signal,
            MUXB_SEL_signal,
            ALU_OUTREG_EN_signal,
            EQ_COND_signal,
            ALU_OPCODE_signal,
            DATAread_DRAM_signal,
            LMD_LATCH_EN_signal,
            JUMP_EN_signal,
            WB_MUX_SEL_signal,
            ADDRESS_DRAM_signal,    --THE OPERAND B HOLDS THE ADDRESS I THINK
            DATAwrite_DRAM_signal,       --ALU_OUT IS THE DATA TO THE DRAM
            ADDRESS_IRAM_signal,
            IR_OUT_signal
        );

end STRUCTURAL;
        