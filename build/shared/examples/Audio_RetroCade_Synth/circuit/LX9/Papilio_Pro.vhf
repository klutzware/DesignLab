--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.1
--  \   \         Application : sch2hdl
--  /   /         Filename : Papilio_Pro.vhf
-- /___/   /\     Timestamp : 12/01/2014 19:04:31
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/Benchy -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/Clocks -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/HQVGA -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/Papilio_Hardware -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/ZPUino_1 -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/ZPUino_2 -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/ZPUino_Wishbone_Peripherals -intstyle ise -family spartan6 -flat -suppress -vhdl D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/Audio_RetroCade_Synth/circuit/LX9/Papilio_Pro.vhf -w D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/Audio_RetroCade_Synth/circuit/Papilio_Pro.sch
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
   port ( ext_pins_in    : in    std_logic_vector (100 downto 0); 
          WING_CL1       : in    std_logic; 
          WING_CL3       : in    std_logic; 
          WING_CL7       : in    std_logic; 
          ext_pins_out   : out   std_logic_vector (100 downto 0); 
          WING_BL0       : out   std_logic; 
          WING_BL1       : out   std_logic; 
          WING_BL2       : out   std_logic; 
          WING_BL3       : out   std_logic; 
          WING_CH0       : out   std_logic; 
          WING_CL0       : out   std_logic; 
          WING_CL2       : out   std_logic; 
          WING_CL4       : out   std_logic; 
          WING_CL6       : out   std_logic; 
          ext_pins_inout : inout std_logic_vector (100 downto 0); 
          WING_AH0       : inout std_logic; 
          WING_AH1       : inout std_logic; 
          WING_AH2       : inout std_logic; 
          WING_AH3       : inout std_logic; 
          WING_AH4       : inout std_logic; 
          WING_AH5       : inout std_logic; 
          WING_AH6       : inout std_logic; 
          WING_AH7       : inout std_logic; 
          WING_AL0       : inout std_logic; 
          WING_AL1       : inout std_logic; 
          WING_AL2       : inout std_logic; 
          WING_AL3       : inout std_logic; 
          WING_AL4       : inout std_logic; 
          WING_AL5       : inout std_logic; 
          WING_AL6       : inout std_logic; 
          WING_AL7       : inout std_logic; 
          WING_BH0       : inout std_logic; 
          WING_BH1       : inout std_logic; 
          WING_BH2       : inout std_logic; 
          WING_BH3       : inout std_logic; 
          WING_BH4       : inout std_logic; 
          WING_BH5       : inout std_logic; 
          WING_BH6       : inout std_logic; 
          WING_BH7       : inout std_logic; 
          WING_BL4       : inout std_logic; 
          WING_BL5       : inout std_logic; 
          WING_BL6       : inout std_logic; 
          WING_BL7       : inout std_logic; 
          WING_CH1       : inout std_logic; 
          WING_CH2       : inout std_logic; 
          WING_CH3       : inout std_logic; 
          WING_CH4       : inout std_logic; 
          WING_CH5       : inout std_logic; 
          WING_CH6       : inout std_logic; 
          WING_CH7       : inout std_logic; 
          WING_CL5       : inout std_logic);
end Papilio_Pro;

architecture BEHAVIORAL of Papilio_Pro is
   attribute BOX_TYPE   : string ;
   signal XLXN_504                                  : std_logic;
   signal XLXN_509                                  : std_logic;
   signal XLXN_511                                  : std_logic;
   signal XLXN_514                                  : std_logic_vector (17 
         downto 0);
   signal XLXN_516                                  : std_logic;
   signal XLXN_533                                  : std_logic;
   signal XLXN_582                                  : std_logic_vector (7 
         downto 0);
   signal XLXN_583                                  : std_logic_vector (7 
         downto 0);
   signal XLXN_584                                  : std_logic_vector (7 
         downto 0);
   signal XLXN_585                                  : std_logic_vector (7 
         downto 0);
   signal XLXN_586                                  : std_logic_vector (7 
         downto 0);
   signal XLXN_587                                  : std_logic_vector (7 
         downto 0);
   signal XLXN_588                                  : std_logic_vector (7 
         downto 0);
   signal XLXN_589                                  : std_logic_vector (7 
         downto 0);
   signal XLXN_590                                  : std_logic_vector (7 
         downto 0);
   signal XLXN_591                                  : std_logic_vector (7 
         downto 0);
   signal XLXN_592                                  : std_logic_vector (7 
         downto 0);
   signal XLXN_593                                  : std_logic_vector (7 
         downto 0);
   signal XLXN_594                                  : std_logic_vector (200 
         downto 0);
   signal XLXN_595                                  : std_logic_vector (200 
         downto 0);
   signal XLXN_598                                  : std_logic_vector (100 
         downto 0);
   signal XLXN_599                                  : std_logic_vector (100 
         downto 0);
   signal XLXN_600                                  : std_logic_vector (100 
         downto 0);
   signal XLXN_601                                  : std_logic_vector (100 
         downto 0);
   signal XLXN_606                                  : std_logic_vector (100 
         downto 0);
   signal XLXN_607                                  : std_logic_vector (100 
         downto 0);
   signal XLXN_610                                  : std_logic_vector (100 
         downto 0);
   signal XLXN_611                                  : std_logic_vector (100 
         downto 0);
   signal XLXN_612                                  : std_logic_vector (100 
         downto 0);
   signal XLXN_613                                  : std_logic_vector (100 
         downto 0);
   signal XLXN_676                                  : std_logic_vector (100 
         downto 0);
   signal XLXN_677                                  : std_logic_vector (100 
         downto 0);
   signal XLXN_681                                  : std_logic_vector (17 
         downto 0);
   signal XLXN_682                                  : std_logic_vector (17 
         downto 0);
   signal XLXI_71_Flex_Pin_out_0_openSignal         : std_logic;
   signal XLXI_71_Flex_Pin_out_1_openSignal         : std_logic;
   signal XLXI_71_Flex_Pin_out_2_openSignal         : std_logic;
   signal XLXI_71_Flex_Pin_out_3_openSignal         : std_logic;
   signal XLXI_71_Flex_Pin_out_4_openSignal         : std_logic;
   signal XLXI_71_Flex_Pin_out_5_openSignal         : std_logic;
   signal XLXI_73_wishbone_slot_video_in_openSignal : std_logic_vector (100 
         downto 0);
   signal XLXI_73_wishbone_slot_9_out_openSignal    : std_logic_vector (100 
         downto 0);
   signal XLXI_73_wishbone_slot_10_out_openSignal   : std_logic_vector (100 
         downto 0);
   signal XLXI_73_wishbone_slot_12_out_openSignal   : std_logic_vector (100 
         downto 0);
   component Wing_GPIO
      port ( wt_miso : inout std_logic_vector (7 downto 0); 
             wt_mosi : inout std_logic_vector (7 downto 0));
   end component;
   
   component AUDIO_zpuino_wb_passthrough
      port ( raw_out      : out   std_logic_vector (17 downto 0); 
             wishbone_in  : in    std_logic_vector (100 downto 0); 
             wishbone_out : out   std_logic_vector (100 downto 0));
   end component;
   
   component AUDIO_zpuino_wb_YM2149
      port ( data_out     : out   std_logic_vector (17 downto 0); 
             wishbone_in  : in    std_logic_vector (100 downto 0); 
             wishbone_out : out   std_logic_vector (100 downto 0));
   end component;
   
   component AUDIO_zpuino_wb_sid6581
      port ( clk_1MHZ     : in    std_logic; 
             audio_data   : out   std_logic_vector (17 downto 0); 
             wishbone_in  : in    std_logic_vector (100 downto 0); 
             wishbone_out : out   std_logic_vector (100 downto 0));
   end component;
   
   component COMM_zpuino_wb_UART
      port ( rx           : in    std_logic; 
             wishbone_in  : in    std_logic_vector (100 downto 0); 
             wishbone_out : out   std_logic_vector (100 downto 0); 
             tx           : out   std_logic);
   end component;
   
   component AUDIO_zpuino_sa_audiomixer
      port ( clk       : in    std_logic; 
             rst       : in    std_logic; 
             ena       : in    std_logic; 
             data_in1  : in    std_logic_vector (17 downto 0); 
             data_in2  : in    std_logic_vector (17 downto 0); 
             data_in3  : in    std_logic_vector (17 downto 0); 
             audio_out : out   std_logic);
   end component;
   
   component MISC_zpuino_sa_splitter4
      port ( in1  : in    std_logic; 
             out1 : out   std_logic; 
             out2 : out   std_logic; 
             out3 : out   std_logic; 
             out4 : out   std_logic);
   end component;
   
   component GND
      port ( G : out   std_logic);
   end component;
   attribute BOX_TYPE of GND : component is "BLACK_BOX";
   
   component COMM_zpuino_wb_SPI
      port ( miso         : in    std_logic; 
             sck          : out   std_logic; 
             mosi         : out   std_logic; 
             wishbone_in  : in    std_logic_vector (100 downto 0); 
             wishbone_out : out   std_logic_vector (100 downto 0));
   end component;
   
   component VCC
      port ( P : out   std_logic);
   end component;
   attribute BOX_TYPE of VCC : component is "BLACK_BOX";
   
   component Papilio_Default_Wing_Pinout
      port ( WING_AH0         : inout std_logic; 
             WING_AH1         : inout std_logic; 
             WING_AH2         : inout std_logic; 
             WING_AH3         : inout std_logic; 
             WING_AH4         : inout std_logic; 
             WING_AH5         : inout std_logic; 
             WING_AH6         : inout std_logic; 
             WING_AH7         : inout std_logic; 
             WING_AL0         : inout std_logic; 
             WING_AL1         : inout std_logic; 
             WING_AL2         : inout std_logic; 
             WING_AL3         : inout std_logic; 
             WING_AL4         : inout std_logic; 
             WING_AL5         : inout std_logic; 
             WING_AL6         : inout std_logic; 
             WING_AL7         : inout std_logic; 
             WING_BH0         : inout std_logic; 
             WING_BH1         : inout std_logic; 
             WING_BH2         : inout std_logic; 
             WING_BH3         : inout std_logic; 
             WING_BH4         : inout std_logic; 
             WING_BH5         : inout std_logic; 
             WING_BH6         : inout std_logic; 
             WING_BH7         : inout std_logic; 
             WING_BL0         : inout std_logic; 
             WING_BL1         : inout std_logic; 
             WING_BL2         : inout std_logic; 
             WING_BL3         : inout std_logic; 
             WING_BL4         : inout std_logic; 
             WING_BL5         : inout std_logic; 
             WING_BL6         : inout std_logic; 
             WING_BL7         : inout std_logic; 
             WING_CL0         : inout std_logic; 
             WING_CL1         : inout std_logic; 
             WING_CL2         : inout std_logic; 
             WING_CL3         : inout std_logic; 
             WING_CL4         : inout std_logic; 
             WING_CL5         : inout std_logic; 
             WING_CL6         : inout std_logic; 
             WING_CL7         : inout std_logic; 
             WING_CH0         : inout std_logic; 
             WING_CH1         : inout std_logic; 
             WING_CH2         : inout std_logic; 
             WING_CH3         : inout std_logic; 
             WING_CH4         : inout std_logic; 
             WING_CH5         : inout std_logic; 
             WING_CH6         : inout std_logic; 
             WING_CH7         : inout std_logic; 
             gpio_bus_out     : in    std_logic_vector (200 downto 0); 
             gpio_bus_in      : out   std_logic_vector (200 downto 0); 
             WingType_miso_BH : inout std_logic_vector (7 downto 0); 
             WingType_miso_BL : inout std_logic_vector (7 downto 0); 
             WingType_miso_AH : inout std_logic_vector (7 downto 0); 
             WingType_mosi_BL : inout std_logic_vector (7 downto 0); 
             WingType_mosi_BH : inout std_logic_vector (7 downto 0); 
             WingType_mosi_CL : inout std_logic_vector (7 downto 0); 
             WingType_mosi_AH : inout std_logic_vector (7 downto 0); 
             WingType_miso_CL : inout std_logic_vector (7 downto 0); 
             WingType_miso_CH : inout std_logic_vector (7 downto 0); 
             WingType_mosi_CH : inout std_logic_vector (7 downto 0); 
             WingType_mosi_AL : inout std_logic_vector (7 downto 0); 
             WingType_miso_AL : inout std_logic_vector (7 downto 0); 
             Flex_Pin_out_0   : in    std_logic; 
             Flex_Pin_out_1   : in    std_logic; 
             Flex_Pin_out_2   : in    std_logic; 
             Flex_Pin_out_3   : in    std_logic; 
             Flex_Pin_out_4   : in    std_logic; 
             Flex_Pin_out_5   : in    std_logic; 
             Flex_Pin_in_0    : out   std_logic; 
             Flex_Pin_in_1    : out   std_logic; 
             Flex_Pin_in_2    : out   std_logic; 
             Flex_Pin_in_3    : out   std_logic; 
             Flex_Pin_in_4    : out   std_logic; 
             Flex_Pin_in_5    : out   std_logic);
   end component;
   
   component ZPUino_Papilio_Pro_V2
      port ( gpio_bus_out            : out   std_logic_vector (200 downto 0); 
             gpio_bus_in             : in    std_logic_vector (200 downto 0); 
             clk_96Mhz               : out   std_logic; 
             clk_1Mhz                : out   std_logic; 
             clk_osc_32Mhz           : out   std_logic; 
             ext_pins_in             : in    std_logic_vector (100 downto 0); 
             ext_pins_out            : out   std_logic_vector (100 downto 0); 
             ext_pins_inout          : inout std_logic_vector (100 downto 0); 
             wishbone_slot_5_out     : in    std_logic_vector (100 downto 0); 
             wishbone_slot_5_in      : out   std_logic_vector (100 downto 0); 
             wishbone_slot_6_in      : out   std_logic_vector (100 downto 0); 
             wishbone_slot_6_out     : in    std_logic_vector (100 downto 0); 
             wishbone_slot_8_in      : out   std_logic_vector (100 downto 0); 
             wishbone_slot_8_out     : in    std_logic_vector (100 downto 0); 
             wishbone_slot_9_in      : out   std_logic_vector (100 downto 0); 
             wishbone_slot_9_out     : in    std_logic_vector (100 downto 0); 
             wishbone_slot_10_in     : out   std_logic_vector (100 downto 0); 
             wishbone_slot_10_out    : in    std_logic_vector (100 downto 0); 
             wishbone_slot_11_in     : out   std_logic_vector (100 downto 0); 
             wishbone_slot_11_out    : in    std_logic_vector (100 downto 0); 
             wishbone_slot_12_in     : out   std_logic_vector (100 downto 0); 
             wishbone_slot_12_out    : in    std_logic_vector (100 downto 0); 
             wishbone_slot_13_in     : out   std_logic_vector (100 downto 0); 
             wishbone_slot_13_out    : in    std_logic_vector (100 downto 0); 
             wishbone_slot_14_in     : out   std_logic_vector (100 downto 0); 
             wishbone_slot_14_out    : in    std_logic_vector (100 downto 0); 
             wishbone_slot_video_in  : in    std_logic_vector (100 downto 0); 
             wishbone_slot_video_out : out   std_logic_vector (100 downto 0); 
             vgaclkout               : out   std_logic);
   end component;
   
begin
   XLXI_24 : Wing_GPIO
      port map (wt_miso(7 downto 0)=>XLXN_588(7 downto 0),
                wt_mosi(7 downto 0)=>XLXN_589(7 downto 0));
   
   XLXI_25 : Wing_GPIO
      port map (wt_miso(7 downto 0)=>XLXN_586(7 downto 0),
                wt_mosi(7 downto 0)=>XLXN_587(7 downto 0));
   
   XLXI_26 : Wing_GPIO
      port map (wt_miso(7 downto 0)=>XLXN_584(7 downto 0),
                wt_mosi(7 downto 0)=>XLXN_585(7 downto 0));
   
   XLXI_27 : Wing_GPIO
      port map (wt_miso(7 downto 0)=>XLXN_582(7 downto 0),
                wt_mosi(7 downto 0)=>XLXN_583(7 downto 0));
   
   XLXI_38 : AUDIO_zpuino_wb_passthrough
      port map (wishbone_in(100 downto 0)=>XLXN_676(100 downto 0),
                raw_out(17 downto 0)=>XLXN_682(17 downto 0),
                wishbone_out(100 downto 0)=>XLXN_677(100 downto 0));
   
   XLXI_49 : Wing_GPIO
      port map (wt_miso(7 downto 0)=>XLXN_590(7 downto 0),
                wt_mosi(7 downto 0)=>XLXN_591(7 downto 0));
   
   XLXI_50 : AUDIO_zpuino_wb_YM2149
      port map (wishbone_in(100 downto 0)=>XLXN_610(100 downto 0),
                data_out(17 downto 0)=>XLXN_681(17 downto 0),
                wishbone_out(100 downto 0)=>XLXN_611(100 downto 0));
   
   XLXI_51 : AUDIO_zpuino_wb_sid6581
      port map (clk_1MHZ=>XLXN_509,
                wishbone_in(100 downto 0)=>XLXN_612(100 downto 0),
                audio_data(17 downto 0)=>XLXN_514(17 downto 0),
                wishbone_out(100 downto 0)=>XLXN_613(100 downto 0));
   
   XLXI_52 : COMM_zpuino_wb_UART
      port map (rx=>WING_CL1,
                wishbone_in(100 downto 0)=>XLXN_606(100 downto 0),
                tx=>WING_CL0,
                wishbone_out(100 downto 0)=>XLXN_607(100 downto 0));
   
   XLXI_53 : Wing_GPIO
      port map (wt_miso(7 downto 0)=>XLXN_592(7 downto 0),
                wt_mosi(7 downto 0)=>XLXN_593(7 downto 0));
   
   XLXI_54 : AUDIO_zpuino_sa_audiomixer
      port map (clk=>XLXN_511,
                data_in1(17 downto 0)=>XLXN_514(17 downto 0),
                data_in2(17 downto 0)=>XLXN_681(17 downto 0),
                data_in3(17 downto 0)=>XLXN_682(17 downto 0),
                ena=>XLXN_533,
                rst=>XLXN_516,
                audio_out=>XLXN_504);
   
   XLXI_58 : MISC_zpuino_sa_splitter4
      port map (in1=>XLXN_504,
                out1=>WING_BL0,
                out2=>WING_BL1,
                out3=>WING_BL2,
                out4=>WING_BL3);
   
   XLXI_59 : GND
      port map (G=>XLXN_516);
   
   XLXI_61 : COMM_zpuino_wb_SPI
      port map (miso=>WING_CL3,
                wishbone_in(100 downto 0)=>XLXN_598(100 downto 0),
                mosi=>WING_CL4,
                sck=>WING_CL2,
                wishbone_out(100 downto 0)=>XLXN_599(100 downto 0));
   
   XLXI_62 : COMM_zpuino_wb_SPI
      port map (miso=>WING_CL7,
                wishbone_in(100 downto 0)=>XLXN_600(100 downto 0),
                mosi=>WING_CH0,
                sck=>WING_CL6,
                wishbone_out(100 downto 0)=>XLXN_601(100 downto 0));
   
   XLXI_63 : VCC
      port map (P=>XLXN_533);
   
   XLXI_71 : Papilio_Default_Wing_Pinout
      port map (Flex_Pin_out_0=>XLXI_71_Flex_Pin_out_0_openSignal,
                Flex_Pin_out_1=>XLXI_71_Flex_Pin_out_1_openSignal,
                Flex_Pin_out_2=>XLXI_71_Flex_Pin_out_2_openSignal,
                Flex_Pin_out_3=>XLXI_71_Flex_Pin_out_3_openSignal,
                Flex_Pin_out_4=>XLXI_71_Flex_Pin_out_4_openSignal,
                Flex_Pin_out_5=>XLXI_71_Flex_Pin_out_5_openSignal,
                gpio_bus_out(200 downto 0)=>XLXN_595(200 downto 0),
                Flex_Pin_in_0=>open,
                Flex_Pin_in_1=>open,
                Flex_Pin_in_2=>open,
                Flex_Pin_in_3=>open,
                Flex_Pin_in_4=>open,
                Flex_Pin_in_5=>open,
                gpio_bus_in(200 downto 0)=>XLXN_594(200 downto 0),
                WingType_miso_AH(7 downto 0)=>XLXN_584(7 downto 0),
                WingType_miso_AL(7 downto 0)=>XLXN_582(7 downto 0),
                WingType_miso_BH(7 downto 0)=>XLXN_588(7 downto 0),
                WingType_miso_BL(7 downto 0)=>XLXN_586(7 downto 0),
                WingType_miso_CH(7 downto 0)=>XLXN_592(7 downto 0),
                WingType_miso_CL(7 downto 0)=>XLXN_590(7 downto 0),
                WingType_mosi_AH(7 downto 0)=>XLXN_585(7 downto 0),
                WingType_mosi_AL(7 downto 0)=>XLXN_583(7 downto 0),
                WingType_mosi_BH(7 downto 0)=>XLXN_589(7 downto 0),
                WingType_mosi_BL(7 downto 0)=>XLXN_587(7 downto 0),
                WingType_mosi_CH(7 downto 0)=>XLXN_593(7 downto 0),
                WingType_mosi_CL(7 downto 0)=>XLXN_591(7 downto 0),
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
                WING_BL0=>open,
                WING_BL1=>open,
                WING_BL2=>open,
                WING_BL3=>open,
                WING_BL4=>WING_BL4,
                WING_BL5=>WING_BL5,
                WING_BL6=>WING_BL6,
                WING_BL7=>WING_BL7,
                WING_CH0=>open,
                WING_CH1=>WING_CH1,
                WING_CH2=>WING_CH2,
                WING_CH3=>WING_CH3,
                WING_CH4=>WING_CH4,
                WING_CH5=>WING_CH5,
                WING_CH6=>WING_CH6,
                WING_CH7=>WING_CH7,
                WING_CL0=>open,
                WING_CL1=>open,
                WING_CL2=>open,
                WING_CL3=>open,
                WING_CL4=>open,
                WING_CL5=>WING_CL5,
                WING_CL6=>open,
                WING_CL7=>open);
   
   XLXI_73 : ZPUino_Papilio_Pro_V2
      port map (ext_pins_in(100 downto 0)=>ext_pins_in(100 downto 0),
                gpio_bus_in(200 downto 0)=>XLXN_594(200 downto 0),
                wishbone_slot_video_in(100 downto 
            0)=>XLXI_73_wishbone_slot_video_in_openSignal(100 downto 0),
                wishbone_slot_5_out(100 downto 0)=>XLXN_677(100 downto 0),
                wishbone_slot_6_out(100 downto 0)=>XLXN_599(100 downto 0),
                wishbone_slot_8_out(100 downto 0)=>XLXN_601(100 downto 0),
                wishbone_slot_9_out(100 downto 
            0)=>XLXI_73_wishbone_slot_9_out_openSignal(100 downto 0),
                wishbone_slot_10_out(100 downto 
            0)=>XLXI_73_wishbone_slot_10_out_openSignal(100 downto 0),
                wishbone_slot_11_out(100 downto 0)=>XLXN_607(100 downto 0),
                wishbone_slot_12_out(100 downto 
            0)=>XLXI_73_wishbone_slot_12_out_openSignal(100 downto 0),
                wishbone_slot_13_out(100 downto 0)=>XLXN_611(100 downto 0),
                wishbone_slot_14_out(100 downto 0)=>XLXN_613(100 downto 0),
                clk_osc_32Mhz=>open,
                clk_1Mhz=>XLXN_509,
                clk_96Mhz=>XLXN_511,
                ext_pins_out(100 downto 0)=>ext_pins_out(100 downto 0),
                gpio_bus_out(200 downto 0)=>XLXN_595(200 downto 0),
                vgaclkout=>open,
                wishbone_slot_video_out=>open,
                wishbone_slot_5_in(100 downto 0)=>XLXN_676(100 downto 0),
                wishbone_slot_6_in(100 downto 0)=>XLXN_598(100 downto 0),
                wishbone_slot_8_in(100 downto 0)=>XLXN_600(100 downto 0),
                wishbone_slot_9_in=>open,
                wishbone_slot_10_in=>open,
                wishbone_slot_11_in(100 downto 0)=>XLXN_606(100 downto 0),
                wishbone_slot_12_in=>open,
                wishbone_slot_13_in(100 downto 0)=>XLXN_610(100 downto 0),
                wishbone_slot_14_in(100 downto 0)=>XLXN_612(100 downto 0),
                ext_pins_inout(100 downto 0)=>ext_pins_inout(100 downto 0));
   
end BEHAVIORAL;


