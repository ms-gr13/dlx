library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.myTypes.all;


entity dlx_cu is
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
    RF_WE              : out std_logic   -- Register File Write Enable
    );  

end dlx_cu;

architecture dlx_cu_hw of dlx_cu is
  type mem_array is array (integer range 0 to MICROCODE_MEM_SIZE - 1) of std_logic_vector(CW_SIZE - 1 downto 0);
<<<<<<< HEAD
=======
  signal cw_mem : mem_array := ("110000000000100",   --NOP
                                "111101010000111", -- R type
                                "111011110000111", -- I type
                                "110110111001100", -- BEQZ
                                "110110110001100", -- BNEZ
                                "111011111001100", -- J (0X02) instruction encoding corresponds to the address to this ROM
                                "110100010001100", -- JAL
                                "111011110010101", -- LW
                                "110000000000100", -- NOP
                                "111111110110100"  -- SW
                                );
>>>>>>> ec79f2eef4f4036a904e894eae184ef7a16fbb7a
                                
                                
  signal IR_opcode : std_logic_vector(OP_CODE_SIZE -1 downto 0);  -- OpCode part of IR
  signal IR_func : std_logic_vector(FUNC_SIZE-1 downto 0);   -- Func part of IR when Rtype
  signal cw   : std_logic_vector(CW_SIZE - 1 downto 0); -- full control word read from cw_mem


  -- control word is shifted to the correct stage
  signal cw1 : std_logic_vector(CW_SIZE -1 downto 0); -- first stage (DECODE)
  signal cw2 : std_logic_vector(CW_SIZE - 1 - 2 downto 0); -- second stage (EXECUTE)
  signal cw3 : std_logic_vector(CW_SIZE - 1 - 5 downto 0); -- third stage (MEMORY)
  signal cw4 : std_logic_vector(CW_SIZE - 1 - 9 downto 0); -- fourth stage (WB)

  signal aluOpcode_i: aluOp := NOP; -- ALUOP defined in package
  signal aluOpcode1: aluOp := NOP;
  signal aluOpcode2: aluOp := NOP;
<<<<<<< HEAD
  signal IR_LATCH_ENs        :  std_logic;  
  signal NPC_LATCH_ENs       :  std_logic;
  signal RegA_LATCH_ENs      :  std_logic;
  signal RegB_LATCH_ENs      :  std_logic;  
  signal RegIMM_LATCH_ENs    :  std_logic;
  signal MUXA_SELs           :  std_logic;  
  signal MUXB_SELs           :  std_logic;  
  signal ALU_OUTREG_ENs      :  std_logic;  
  signal EQ_CONDs            :  std_logic;  
  signal DRAM_WEs            :  std_logic;  
  signal LMD_LATCH_ENs       :  std_logic;  
  signal JUMP_ENs            :  std_logic;  
  signal PC_LATCH_ENs        :  std_logic;  
  signal WB_MUX_SELs         :  std_logic;  
  signal RF_WEs              :  std_logic;  
  signal cw_mem              :  mem_array;
 
begin  -- dlx_cu_rtl
                     cw_mem  <= ("110000000000100",   --NOP
                                "111101010000111", -- R type
                                "111011110000111", -- I type
                                "110110111001100", -- BEQZ
                                "110110110001100", -- BNEZ
                                "111011111001100", -- J (0X02) instruction encoding corresponds to the address to this ROM
                                "110100010001100", -- JAL
                                "111011110010101", -- LW
                                "110000000000100", -- NOP
                                "111111110110100"  -- SW
                                );
  IR_opcode(OP_CODE_SIZE-1 downto 0) <= IR_IN(31 downto 26);
  IR_func(10 downto 0)  <= IR_IN(FUNC_SIZE - 1 downto 0);

  IR_LATCH_EN    <= IR_LATCH_ENs;    
  NPC_LATCH_EN   <= NPC_LATCH_ENs;   
  RegA_LATCH_EN  <= RegA_LATCH_ENs;  
  RegB_LATCH_EN  <= RegB_LATCH_ENs;  
  RegIMM_LATCH_EN <= RegIMM_LATCH_ENs;
  MUXA_SEL       <= MUXA_SELs;       
  MUXB_SEL       <= MUXB_SELs;       
  ALU_OUTREG_EN  <= ALU_OUTREG_ENs;  
  EQ_COND        <= EQ_CONDs;           
  DRAM_WE        <= DRAM_WEs;        
  LMD_LATCH_EN   <= LMD_LATCH_ENs;   
  JUMP_EN        <= JUMP_ENs;        
  PC_LATCH_EN    <= PC_LATCH_ENs;    
  WB_MUX_SEL     <= WB_MUX_SELs;     
  RF_WE          <= RF_WEs;          

  -- stage one control signals
  IR_LATCH_ENs  <= '1';--cw1(CW_SIZE - 1);
  NPC_LATCH_ENs <= '1';--cw1(CW_SIZE - 2);
  PC_LATCH_ENs  <= '1';--cw1(CW_SIZE - 13);
  -- stage two control signals
  RegA_LATCH_ENs   <= cw(CW_SIZE - 3);
  RegB_LATCH_ENs   <= cw(CW_SIZE - 4);
  RegIMM_LATCH_ENs <= cw(CW_SIZE - 5);
  
  -- stage three control signals
  MUXA_SELs      <= cw1(CW_SIZE - 6);
  MUXB_SELs      <= cw1(CW_SIZE - 7);
  ALU_OUTREG_ENs <= cw1(CW_SIZE - 8);
  EQ_CONDs       <= cw1(CW_SIZE - 9);
  
  -- stage four control signals
  DRAM_WEs      <= cw2(CW_SIZE - 10);
  LMD_LATCH_ENs <= cw2(CW_SIZE - 11);
  JUMP_ENs      <= cw2(CW_SIZE - 12);
  
  
  -- stage five control signals
  WB_MUX_SELs <= cw3(CW_SIZE - 14);
  RF_WEs      <= cw3(CW_SIZE - 15);
=======


 
begin  -- dlx_cu_rtl

  IR_opcode(OP_CODE_SIZE-1 downto 0) <= IR_IN(31 downto 26);
  IR_func(10 downto 0)  <= IR_IN(FUNC_SIZE - 1 downto 0);



  -- stage one control signals
  IR_LATCH_EN  <= '1';--cw1(CW_SIZE - 1);
  NPC_LATCH_EN <= '1';--cw1(CW_SIZE - 2);
  PC_LATCH_EN  <= '1';--cw1(CW_SIZE - 13);
  -- stage two control signals
  RegA_LATCH_EN   <= cw(CW_SIZE - 3);
  RegB_LATCH_EN   <= cw(CW_SIZE - 4);
  RegIMM_LATCH_EN <= cw(CW_SIZE - 5);
  
  -- stage three control signals
  MUXA_SEL      <= cw1(CW_SIZE - 6);
  MUXB_SEL      <= cw1(CW_SIZE - 7);
  ALU_OUTREG_EN <= cw1(CW_SIZE - 8);
  EQ_COND       <= cw1(CW_SIZE - 9);
  
  -- stage four control signals
  DRAM_WE      <= cw2(CW_SIZE - 10);
  LMD_LATCH_EN <= cw2(CW_SIZE - 11);
  JUMP_EN      <= cw2(CW_SIZE - 12);
  
  
  -- stage five control signals
  WB_MUX_SEL <= cw3(CW_SIZE - 14);
  RF_WE      <= cw3(CW_SIZE - 15);
>>>>>>> ec79f2eef4f4036a904e894eae184ef7a16fbb7a


  -- process to pipeline control words
  CW_PIPE: process (Clk, Rst)
  begin  -- process Clk
    if Rst = '1' then                   -- asynchronous reset (active low)
      cw1 <= (others => '0');
      cw2 <= (others => '0');
      cw3 <= (others => '0');
      cw4 <= (others => '0'); 
      aluOpcode1 <= NOP;
      aluOpcode2 <= NOP;
    elsif Clk'event and Clk = '1' then  -- rising clock edge
     -- if (conv_integer(IR_IN) /= 0) then --!= 0
        cw1 <= cw;
        cw2 <= cw1(CW_SIZE - 1 - 2 downto 0);
        cw3 <= cw2(CW_SIZE - 1 - 5 downto 0);
        cw4 <= cw3(CW_SIZE - 1 - 9 downto 0);

        aluOpcode1 <= aluOpcode_i;
        aluOpcode2 <= aluOpcode1;
    --  end if;
    end if;
  end process CW_PIPE;

  ALU_OPCODE <= aluOpcode1;

  -- purpose: Generation of ALU OpCode
  -- type   : combinational
  -- inputs : IR_i
  -- outputs: aluOpcode
   ALU_OP_CODE_P : process (IR_opcode, IR_func)
   begin  -- process ALU_OP_CODE_P
	 
   case conv_integer(unsigned(IR_opcode)) is
	        -- case of R type requires analysis of FUNC
		when 0 =>
      if (conv_integer(IR_IN) /= 0) then
        cw <= cw_mem(1); --RTYPE
      else 
        cw <= cw_mem(0); --NOP
      end if;
			case conv_integer(unsigned(IR_func)) is
        when 4 => aluOpcode_i <= LLS; -- sll according to instruction set coding
				when 6 => aluOpcode_i <= LRS; -- srl
        when 32 => aluOpcode_i <= ADDS; -- add
        when 34 => aluOpcode_i <= SUBS; -- sub
        when 36 => aluOpcode_i <= ANDS; -- and
        when 37 => aluOpcode_i <= ORS; -- or
        when 38 => aluOpcode_i <= XORS; -- xor
        when 41 => aluOpcode_i <= SNES; -- sne
        when 44 => aluOpcode_i <= SLES; -- sle
        when 45 => aluOpcode_i <= SGES;  -- sge
				when others => aluOpcode_i <= NOP;
			end case;
      -- not anymore R-type
		when 2 => 
              cw <= cw_mem(5);
              aluOpcode_i <= NOP; -- j
		when 3 => 
              cw <= cw_mem(6);
              aluOpcode_i <= NOP; -- jal
    when 4 => 
              cw <= cw_mem(3);
              aluOpcode_i <= ADDS; -- BEQZ
    when 5 => 
              cw <= cw_mem(4);
              aluOpcode_i <= ADDS; -- BNEZ
		when 8 => 
              cw <= cw_mem(2);
              aluOpcode_i <= ADDS; -- addi
    when 10 => 
              cw <= cw_mem(2);
              aluOpcode_i <= SUBS; --subi
    when 12 => 
              cw <= cw_mem(2);
              aluOpcode_i <= ANDS; -- andi
    when 13 => 
              cw <= cw_mem(2);
              aluOpcode_i <= ORS; --ori
    when 14 => 
              cw <= cw_mem(2);
              aluOpcode_i <= XORS; --xori
    when 20 => 
              cw <= cw_mem(2);
              aluOpcode_i <= LLS; --slli
    when 22 => 
              cw <= cw_mem(2);
              aluOpcode_i <= LRS; --srli
    when 35 => 
              cw <= cw_mem(7);
              aluOpcode_i <= ADDS; -- lw 
    when 25 => 
              cw <= cw_mem(2);
              aluOpcode_i <= SNES; -- snei
    when 28 => 
              cw <= cw_mem(2);
              aluOpcode_i <= SLES; --slei
    when 29 => 
              cw <= cw_mem(2);
              aluOpcode_i <= SGES; --sgei
    when 43 => 
              cw <= cw_mem(9);
              aluOpcode_i <= ADDS; -- sw
		when others => 
              cw <= cw_mem(0);     --nop
              aluOpcode_i <= NOP;
	 end case;
	end process ALU_OP_CODE_P;


end dlx_cu_hw;
