--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.1
--  \   \         Application : sch2hdl
--  /   /         Filename : Papilio_Pro.vhf
-- /___/   /\     Timestamp : 12/24/2014 19:21:50
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/Benchy -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/Clocks -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/HQVGA -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/Papilio_Hardware -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/ZPUino_2 -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/ZPUino_Wishbone_Peripherals -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Benchy -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/BitCoin_Miner -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Clocks -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Gameduino -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/HQVGA -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Papilio_Hardware -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/ZPUino_2 -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/ZPUino_Wishbone_Peripherals -intstyle ise -family spartan6 -flat -suppress -vhdl D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/BitCoin_Miner/circuit/LX9/Papilio_Pro.vhf -w D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/BitCoin_Miner/circuit/Papilio_Pro.sch
--Design Name: Papilio_Pro
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

entity Papilio_Pro is
   port ( CLK      : in    std_logic; 
          RXD      : in    std_logic; 
          WING_CL0 : in    std_logic; 
          TXD      : out   std_logic; 
          WING_CH0 : out   std_logic; 
          WING_CH1 : out   std_logic; 
          WING_AH0 : inout std_logic; 
          WING_AH1 : inout std_logic; 
          WING_AH2 : inout std_logic; 
          WING_AH3 : inout std_logic; 
          WING_AH4 : inout std_logic; 
          WING_AH5 : inout std_logic; 
          WING_AH6 : inout std_logic; 
          WING_AH7 : inout std_logic; 
          WING_AL0 : inout std_logic; 
          WING_AL1 : inout std_logic; 
          WING_AL2 : inout std_logic; 
          WING_AL3 : inout std_logic; 
          WING_AL4 : inout std_logic; 
          WING_AL5 : inout std_logic; 
          WING_AL6 : inout std_logic; 
          WING_AL7 : inout std_logic; 
          WING_BH0 : inout std_logic; 
          WING_BH1 : inout std_logic; 
          WING_BH2 : inout std_logic; 
          WING_BH3 : inout std_logic; 
          WING_BH4 : inout std_logic; 
          WING_BH5 : inout std_logic; 
          WING_BH6 : inout std_logic; 
          WING_BH7 : inout std_logic; 
          WING_BL0 : inout std_logic; 
          WING_BL1 : inout std_logic; 
          WING_BL2 : inout std_logic; 
          WING_BL3 : inout std_logic; 
          WING_BL4 : inout std_logic; 
          WING_BL5 : inout std_logic; 
          WING_BL6 : inout std_logic; 
          WING_BL7 : inout std_logic; 
          WING_CH2 : inout std_logic; 
          WING_CH3 : inout std_logic; 
          WING_CH4 : inout std_logic; 
          WING_CH5 : inout std_logic; 
          WING_CH6 : inout std_logic; 
          WING_CH7 : inout std_logic; 
          WING_CL1 : inout std_logic; 
          WING_CL2 : inout std_logic; 
          WING_CL3 : inout std_logic; 
          WING_CL4 : inout std_logic; 
          WING_CL5 : inout std_logic; 
          WING_CL6 : inout std_logic; 
          WING_CL7 : inout std_logic);
end Papilio_Pro;

architecture BEHAVIORAL of Papilio_Pro is
   attribute IOSTANDARD : string ;
   attribute SLEW       : string ;
   attribute DRIVE      : string ;
   attribute BOX_TYPE   : string ;
   signal XLXN_529                        : std_logic_vector (3 downto 0);
   signal XLXN_538                        : std_logic_vector (1 downto 0);
   signal XLXN_543                        : std_logic_vector (7 downto 0);
   signal XLXI_53_Audio_openSignal        : std_logic;
   signal XLXI_53_gpio_bus_out_openSignal : std_logic_vector (200 downto 0);
   signal XLXI_53_SPI_CLK_openSignal      : std_logic;
   signal XLXI_53_SPI_CS_openSignal       : std_logic;
   signal XLXI_53_SPI_MOSI_openSignal     : std_logic;
   signal XLXI_53_VGA_Blue0_openSignal    : std_logic;
   signal XLXI_53_VGA_Blue1_openSignal    : std_logic;
   signal XLXI_53_VGA_Green0_openSignal   : std_logic;
   signal XLXI_53_VGA_Green1_openSignal   : std_logic;
   signal XLXI_53_VGA_Green2_openSignal   : std_logic;
   signal XLXI_53_VGA_Hsync_openSignal    : std_logic;
   signal XLXI_53_VGA_Red0_openSignal     : std_logic;
   signal XLXI_53_VGA_Red1_openSignal     : std_logic;
   signal XLXI_53_VGA_Red2_openSignal     : std_logic;
   signal XLXI_53_VGA_Vsync_openSignal    : std_logic;
   component BitCoin_Miner
      port ( clk_32Mhz   : in    std_logic; 
             TxD         : out   std_logic; 
             RxD         : in    std_logic; 
             disp_switch : in    std_logic; 
             anode       : out   std_logic_vector (3 downto 0); 
             segment     : out   std_logic_vector (7 downto 0); 
             led         : out   std_logic_vector (1 downto 0));
   end component;
   
   component LogicStart_MegaWing_Pinout
      port ( gpio_bus_out : in    std_logic_vector (200 downto 0); 
             gpio_bus_in  : out   std_logic_vector (200 downto 0); 
             WING_AL0     : inout std_logic; 
             WING_AL1     : inout std_logic; 
             WING_AL2     : inout std_logic; 
             WING_AL3     : inout std_logic; 
             WING_AL4     : inout std_logic; 
             WING_AL5     : inout std_logic; 
             WING_AL6     : inout std_logic; 
             WING_AL7     : inout std_logic; 
             WING_AH0     : inout std_logic; 
             WING_AH1     : inout std_logic; 
             WING_AH2     : inout std_logic; 
             WING_AH3     : inout std_logic; 
             WING_AH4     : inout std_logic; 
             WING_AH5     : inout std_logic; 
             WING_AH6     : inout std_logic; 
             WING_AH7     : inout std_logic; 
             WING_BL0     : inout std_logic; 
             WING_BL1     : inout std_logic; 
             WING_BL2     : inout std_logic; 
             WING_BL3     : inout std_logic; 
             WING_BL4     : inout std_logic; 
             WING_BL5     : inout std_logic; 
             WING_BL6     : inout std_logic; 
             WING_BL7     : inout std_logic; 
             WING_BH0     : inout std_logic; 
             WING_BH1     : inout std_logic; 
             WING_BH2     : inout std_logic; 
             WING_BH3     : inout std_logic; 
             WING_BH4     : inout std_logic; 
             WING_BH5     : inout std_logic; 
             WING_BH6     : inout std_logic; 
             WING_BH7     : inout std_logic; 
             WING_CL0     : inout std_logic; 
             WING_CL1     : inout std_logic; 
             WING_CL2     : inout std_logic; 
             WING_CL3     : inout std_logic; 
             WING_CL4     : inout std_logic; 
             WING_CL5     : inout std_logic; 
             WING_CL6     : inout std_logic; 
             WING_CL7     : inout std_logic; 
             WING_CH0     : inout std_logic; 
             WING_CH1     : inout std_logic; 
             WING_CH2     : inout std_logic; 
             WING_CH3     : inout std_logic; 
             WING_CH4     : inout std_logic; 
             WING_CH5     : inout std_logic; 
             WING_CH6     : inout std_logic; 
             WING_CH7     : inout std_logic; 
             VGA_Red2     : in    std_logic; 
             VGA_Red1     : in    std_logic; 
             VGA_Red0     : in    std_logic; 
             VGA_Green2   : in    std_logic; 
             VGA_Green1   : in    std_logic; 
             VGA_Green0   : in    std_logic; 
             VGA_Blue1    : in    std_logic; 
             VGA_Blue0    : in    std_logic; 
             VGA_Hsync    : in    std_logic; 
             VGA_Vsync    : in    std_logic; 
             Audio        : in    std_logic; 
             SPI_MISO     : out   std_logic; 
             SPI_MOSI     : in    std_logic; 
             SPI_CLK      : in    std_logic; 
             SPI_CS       : in    std_logic; 
             Seg7_dot     : in    std_logic; 
             Seg7_enable  : in    std_logic_vector (3 downto 0); 
             Seg7_segdata : in    std_logic_vector (6 downto 0));
   end component;
   
   component OBUF
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute IOSTANDARD of OBUF : component is "DEFAULT";
   attribute SLEW of OBUF : component is "SLOW";
   attribute DRIVE of OBUF : component is "12";
   attribute BOX_TYPE of OBUF : component is "BLACK_BOX";
   
begin
   XLXI_52 : BitCoin_Miner
      port map (clk_32Mhz=>CLK,
                disp_switch=>WING_CL0,
                RxD=>RXD,
                anode(3 downto 0)=>XLXN_529(3 downto 0),
                led(1 downto 0)=>XLXN_538(1 downto 0),
                segment(7 downto 0)=>XLXN_543(7 downto 0),
                TxD=>TXD);
   
   XLXI_53 : LogicStart_MegaWing_Pinout
      port map (Audio=>XLXI_53_Audio_openSignal,
                gpio_bus_out(200 downto 0)=>XLXI_53_gpio_bus_out_openSignal(200 
            downto 0),
                Seg7_dot=>XLXN_543(7),
                Seg7_enable(3 downto 0)=>XLXN_529(3 downto 0),
                Seg7_segdata(6 downto 0)=>XLXN_543(6 downto 0),
                SPI_CLK=>XLXI_53_SPI_CLK_openSignal,
                SPI_CS=>XLXI_53_SPI_CS_openSignal,
                SPI_MOSI=>XLXI_53_SPI_MOSI_openSignal,
                VGA_Blue0=>XLXI_53_VGA_Blue0_openSignal,
                VGA_Blue1=>XLXI_53_VGA_Blue1_openSignal,
                VGA_Green0=>XLXI_53_VGA_Green0_openSignal,
                VGA_Green1=>XLXI_53_VGA_Green1_openSignal,
                VGA_Green2=>XLXI_53_VGA_Green2_openSignal,
                VGA_Hsync=>XLXI_53_VGA_Hsync_openSignal,
                VGA_Red0=>XLXI_53_VGA_Red0_openSignal,
                VGA_Red1=>XLXI_53_VGA_Red1_openSignal,
                VGA_Red2=>XLXI_53_VGA_Red2_openSignal,
                VGA_Vsync=>XLXI_53_VGA_Vsync_openSignal,
                gpio_bus_in=>open,
                SPI_MISO=>open,
                WING_AH0=>WING_AH0,
                WING_AH1=>WING_AH1,
                WING_AH2=>WING_AH2,
                WING_AH3=>WING_AH3,
                WING_AH4=>WING_AH4,
                WING_AH5=>WING_AH5,
                WING_AH6=>WING_AH6,
                WING_AH7=>WING_AH7,
                WING_AL0=>WING_AL0,
                WING_AL1=>WING_AL1,
                WING_AL2=>WING_AL2,
                WING_AL3=>WING_AL3,
                WING_AL4=>WING_AL4,
                WING_AL5=>WING_AL5,
                WING_AL6=>WING_AL6,
                WING_AL7=>WING_AL7,
                WING_BH0=>WING_BH0,
                WING_BH1=>WING_BH1,
                WING_BH2=>WING_BH2,
                WING_BH3=>WING_BH3,
                WING_BH4=>WING_BH4,
                WING_BH5=>WING_BH5,
                WING_BH6=>WING_BH6,
                WING_BH7=>WING_BH7,
                WING_BL0=>WING_BL0,
                WING_BL1=>WING_BL1,
                WING_BL2=>WING_BL2,
                WING_BL3=>WING_BL3,
                WING_BL4=>WING_BL4,
                WING_BL5=>WING_BL5,
                WING_BL6=>WING_BL6,
                WING_BL7=>WING_BL7,
                WING_CH0=>open,
                WING_CH1=>open,
                WING_CH2=>WING_CH2,
                WING_CH3=>WING_CH3,
                WING_CH4=>WING_CH4,
                WING_CH5=>WING_CH5,
                WING_CH6=>WING_CH6,
                WING_CH7=>WING_CH7,
                WING_CL0=>open,
                WING_CL1=>WING_CL1,
                WING_CL2=>WING_CL2,
                WING_CL3=>WING_CL3,
                WING_CL4=>WING_CL4,
                WING_CL5=>WING_CL5,
                WING_CL6=>WING_CL6,
                WING_CL7=>WING_CL7);
   
   XLXI_54 : OBUF
      port map (I=>XLXN_538(1),
                O=>WING_CH1);
   
   XLXI_55 : OBUF
      port map (I=>XLXN_538(0),
                O=>WING_CH0);
   
end BEHAVIORAL;


