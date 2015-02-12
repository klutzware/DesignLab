--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.1
--  \   \         Application : sch2hdl
--  /   /         Filename : Papilio_DUO_LX9.vhf
-- /___/   /\     Timestamp : 02/08/2015 11:16:01
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/AVR_Wishbone_Bridge -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Benchy -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/BitCoin_Miner -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Building_Blocks -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Clocks -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Gameduino -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/HQVGA -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Papilio_Hardware -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/VGA_640_480 -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/VGA_ZXSpectrum -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/ZPUino_2 -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/ZPUino_Wishbone_Peripherals -intstyle ise -family spartan6 -flat -suppress -vhdl D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/LogicStart_LEDs/circuit/DUO_LX9/Papilio_DUO_LX9.vhf -w D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/LogicStart_LEDs/circuit/Papilio_DUO_LX9.sch
--Design Name: Papilio_DUO_LX9
--Device: spartan6
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--
----- CELL OBUF4_HXILINX_Papilio_DUO_LX9 -----
  
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity OBUF4_HXILINX_Papilio_DUO_LX9 is
  
port(
    O0  : out std_logic;
    O1  : out std_logic;
    O2  : out std_logic;
    O3  : out std_logic;

    I0  : in std_logic;
    I1  : in std_logic;
    I2  : in std_logic;
    I3  : in std_logic
  );
end OBUF4_HXILINX_Papilio_DUO_LX9;

architecture OBUF4_HXILINX_Papilio_DUO_LX9_V of OBUF4_HXILINX_Papilio_DUO_LX9 is
begin

  O0 <= I0;
  O1 <= I1;
  O2 <= I2;
  O3 <= I3;

end OBUF4_HXILINX_Papilio_DUO_LX9_V;

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity Papilio_DUO_LX9 is
   port ( Arduino_0  : in    std_logic; 
          Arduino_1  : in    std_logic; 
          Arduino_2  : in    std_logic; 
          Arduino_3  : in    std_logic; 
          Arduino_4  : in    std_logic; 
          Arduino_10 : in    std_logic; 
          Arduino_11 : in    std_logic; 
          Arduino_12 : in    std_logic; 
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
   attribute HU_SET     : string ;
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   component OBUF4_HXILINX_Papilio_DUO_LX9
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O0 : out   std_logic; 
             O1 : out   std_logic; 
             O2 : out   std_logic; 
             O3 : out   std_logic);
   end component;
   
   attribute HU_SET of XLXI_60 : label is "XLXI_60_0";
   attribute HU_SET of XLXI_64 : label is "XLXI_64_1";
begin
   XLXI_48 : INV
      port map (I=>DUO_SW1,
                O=>ARD_RESET);
   
   XLXI_60 : OBUF4_HXILINX_Papilio_DUO_LX9
      port map (I0=>Arduino_0,
                I1=>Arduino_1,
                I2=>Arduino_2,
                I3=>Arduino_3,
                O0=>Arduino_48,
                O1=>Arduino_50,
                O2=>Arduino_52,
                O3=>Arduino_5);
   
   XLXI_64 : OBUF4_HXILINX_Papilio_DUO_LX9
      port map (I0=>Arduino_4,
                I1=>Arduino_10,
                I2=>Arduino_11,
                I3=>Arduino_12,
                O0=>Arduino_6,
                O1=>Arduino_7,
                O2=>Arduino_8,
                O3=>Arduino_9);
   
end BEHAVIORAL;


