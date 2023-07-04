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
use ieee.numeric_std.all;


entity dp_exe is
    port (
        a       :   in    std_logic_vector(DATA_WIDTH-1 downto 0);
        b       :   in    std_logic_vector(DATA_WIDTH-1 downto 0);
        imm     :   in    std_logic_vector(DATA_WIDTH-1 downto 0);
        npc     :   in    std_logic_vector(DATA_WIDTH-1 downto 0);
        alu_out :   out   std_logic_vector(DATA_WIDTH-1 downto 0);
        cond_out:   out   std_logic;
    );
end entity dp_exe;