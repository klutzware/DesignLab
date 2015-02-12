--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.1
--  \   \         Application : sch2hdl
--  /   /         Filename : Papilio_DUO_LX9.vhf
-- /___/   /\     Timestamp : 02/12/2015 15:14:39
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/AVR_Wishbone_Bridge -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Benchy -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/BitCoin_Miner -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Building_Blocks -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Clocks -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Gameduino -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/HQVGA -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Papilio_Hardware -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/VGA_640_480 -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/VGA_ZXSpectrum -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/ZPUino_2 -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/ZPUino_Wishbone_Peripherals -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/Divider_Example/circuit/DUO_LX9 -intstyle ise -family spartan6 -flat -suppress -vhdl D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/Divider_Example/circuit/DUO_LX9/Papilio_DUO_LX9.vhf -w D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/Divider_Example/circuit/Papilio_DUO_LX9.sch
--Design Name: Papilio_DUO_LX9
--Device: spartan6
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity Papilio_DUO_LX9 is
   port ( Arduino_13 : in    std_logic; 
          DUO_SW1    : in    std_logic; 
          Arduino_5  : out   std_logic; 
          Arduino_6  : out   std_logic; 
          Arduino_7  : out   std_logic; 
          Arduino_8  : out   std_logic; 
          Arduino_9  : out   std_logic; 
          Arduino_48 : out   std_logic; 
          Arduino_50 : out   std_logic; 
          Arduino_52 : out   std_logic; 
          ARD_RESET  : out   std_logic);
end Papilio_DUO_LX9;

architecture BEHAVIORAL of Papilio_DUO_LX9 is
   attribute BOX_TYPE   : string ;
   attribute IOSTANDARD : string ;
   attribute SLEW       : string ;
   attribute DRIVE      : string ;
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   component OBUF
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute IOSTANDARD of OBUF : component is "DEFAULT";
   attribute SLEW of OBUF : component is "SLOW";
   attribute DRIVE of OBUF : component is "12";
   attribute BOX_TYPE of OBUF : component is "BLACK_BOX";
   
   component clk_divider
      port ( clk    : in    std_logic; 
             div2   : out   std_logic; 
             div4   : out   std_logic; 
             div8   : out   std_logic; 
             div16  : out   std_logic; 
             div32  : out   std_logic; 
             div64  : out   std_logic; 
             div128 : out   std_logic; 
             div256 : out   std_logic);
   end component;
   
begin
   XLXI_48 : INV
      port map (I=>DUO_SW1,
                O=>ARD_RESET);
   
   XLXI_63 : OBUF
      port map (I=>Arduino_13,
                O=>Arduino_48);
   
   XLXI_64 : clk_divider
      port map (clk=>Arduino_13,
                div2=>Arduino_50,
                div4=>Arduino_52,
                div8=>Arduino_5,
                div16=>Arduino_6,
                div32=>Arduino_7,
                div64=>Arduino_8,
                div128=>Arduino_9,
                div256=>open);
   
end BEHAVIORAL;


