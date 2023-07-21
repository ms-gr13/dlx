library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.myTypes.all;

entity TBDP is
end TBDP;

architecture TEST of TBDP is
    constant nbits : integer := 32;


    component datapath is
        generic(nbits : integer := 32);
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
            ADDRESS_IRAM       : out std_logic_vector(nbits - 1 downto 0)
        );
        end component;

        signal clock : std_logic := '0';  
        signal reset : std_logic := '0'; 
        
        --FETCH CONTROL SIGNALS
        signal DATA_IRAMs    : std_logic_vector(nbits - 1 downto 0);
        signal IR_LATCH_ENs  : std_logic;
        signal NPC_LATCH_ENs : std_logic;
        signal PC_LATCH_ENs  : std_logic;   -- Program Counte Latch Enable
        signal PC_INs        : std_logic_vector(nbits-1 downto 0) := (others => '0');

        --DECODE CONTROL SIGNALS
        signal RegA_LATCH_ENs   : std_logic;  -- Register A Latch Enable
        signal RegB_LATCH_ENs   : std_logic;  -- Register B Latch Enable
        signal RegIMM_LATCH_ENs : std_logic;  -- Immediate Register Latch Enable
        signal RF_WEs           : std_logic;


        -- EX Control Signals
        signal MUXA_SELs           : std_logic;  -- MUX-A Sel
        signal MUXB_SELs           : std_logic;  -- MUX-B Sel
        signal ALU_OUTREG_ENs      : std_logic;  -- ALU Output Register Enable
        signal EQ_CONDs            : std_logic;  -- Branch if (not) Equal to Zero
        signal ALU_OPCODEs         : aluOp; -- choose between implicit or exlicit coding, like std_logic_vector(ALU_OPC_SIZE -1 downto 0);


         -- MEM Control Signals
        signal DRAM_DATAs          : std_logic_vector(nbits -1 downto 0);
        signal LMD_LATCH_ENs       : std_logic;  -- LMD Register Latch Enable
        signal JUMP_ENs            : std_logic;  -- JUMP Enable Signal for PC input MUX
        
        -- WB Control signals
        signal WB_MUX_SELs         : std_logic;


        signal Bs                 : std_logic_vector(nbits -1 downto 0);
        signal ALU_OUTs            : std_logic_vector(nbits -1 downto 0);
        signal ADDRESS_IRAMs       : std_logic_vector(nbits - 1 downto 0);

        begin
            DATA_DUT : datapath
            generic map(nbits)
            port map(
                clock,
                reset,
                DATA_IRAMs,
                IR_LATCH_ENs,
                NPC_LATCH_ENs,
                PC_LATCH_ENs,
                PC_INs,
                RegA_LATCH_ENs,
                RegB_LATCH_ENs,
                RegIMM_LATCH_ENs,
                RF_WEs,
                MUXA_SELs,
                MUXB_SELs,
                ALU_OUTREG_ENs,
                EQ_CONDs,
                ALU_OPCODEs,
                DRAM_DATAs,
                LMD_LATCH_ENs,
                JUMP_ENs,
                WB_MUX_SELs,
                Bs,
                ALU_OUTs,
                ADDRESS_IRAMs
                );

    clock <= not clock after 1 ns; 

        STIMULUS1: process
            begin

                --SIMULATION OF ADD

                DATA_IRAMs <= "00000000010000110000100000100000";
                -- first clock cycle 
                IR_LATCH_ENs <= '1';
                NPC_LATCH_ENs <= '1';
                wait for 2 ns;

                
                -- second clock cycle
                RegA_LATCH_ENs <= '1';
                RegB_LATCH_ENs <= '1';
                RegIMM_LATCH_ENs <= '0';
                wait for 2 ns;

                

                --thrid clock cycle
                MUXA_SELs <= '1';
                MUXB_SELs <= '0';
                ALU_OUTREG_ENs <= '1';
                EQ_CONDs <= '0';
                ALU_OPCODEs <= ADDS;
                wait for 2 ns;


                --fourth clock cycle
                LMD_LATCH_ENs <= '1';
                JUMP_ENs <= '0';
                PC_LATCH_ENs <= '1';
                PC_INs <= "00000000000000000000000000000000";
                DRAM_DATAs <= "00000000100000000100000100000010";
                wait for 2 ns;

                --fifth clock cycle
                WB_MUX_SELs <= '1';
                RF_WEs <= '1';
                wait for 2 ns;




        end process STIMULUS1;

end TEST;
