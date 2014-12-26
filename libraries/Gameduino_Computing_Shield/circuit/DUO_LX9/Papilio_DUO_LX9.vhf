--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.1
--  \   \         Application : sch2hdl
--  /   /         Filename : Papilio_DUO_LX9.vhf
-- /___/   /\     Timestamp : 12/10/2014 17:58:50
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Benchy -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Clocks -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Gameduino -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/HQVGA -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Papilio_Hardware -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/ZPUino_2 -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/ZPUino_Wishbone_Peripherals -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Gameduino_Computing_Shield/circuit/DUO_LX9 -intstyle ise -family spartan6 -flat -suppress -vhdl D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Gameduino_Computing_Shield/circuit/DUO_LX9/Papilio_DUO_LX9.vhf -w D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Gameduino_Computing_Shield/circuit/Papilio_DUO_LX9.sch
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
   port ( Arduino_9    : in    std_logic; 
          Arduino_19   : in    std_logic; 
          Arduino_21   : in    std_logic; 
          ARD_SPI_MOSI : in    std_logic; 
          ARD_SPI_SCLK : in    std_logic; 
          clk          : in    std_logic; 
          ARD_RESET    : out   std_logic; 
          Arduino_14   : inout std_logic; 
          Arduino_15   : inout std_logic; 
          Arduino_16   : inout std_logic; 
          Arduino_17   : inout std_logic; 
          Arduino_18   : inout std_logic; 
          Arduino_20   : inout std_logic; 
          Arduino_22   : inout std_logic; 
          Arduino_23   : inout std_logic; 
          Arduino_24   : inout std_logic; 
          Arduino_25   : inout std_logic; 
          Arduino_26   : inout std_logic; 
          Arduino_27   : inout std_logic; 
          Arduino_28   : inout std_logic; 
          Arduino_29   : inout std_logic; 
          Arduino_30   : inout std_logic; 
          Arduino_31   : inout std_logic; 
          Arduino_32   : inout std_logic; 
          Arduino_33   : inout std_logic; 
          Arduino_34   : inout std_logic; 
          Arduino_35   : inout std_logic; 
          Arduino_36   : inout std_logic; 
          Arduino_37   : inout std_logic; 
          Arduino_38   : inout std_logic; 
          Arduino_39   : inout std_logic; 
          Arduino_40   : inout std_logic; 
          Arduino_41   : inout std_logic; 
          Arduino_42   : inout std_logic; 
          Arduino_43   : inout std_logic; 
          Arduino_44   : inout std_logic; 
          Arduino_45   : inout std_logic; 
          Arduino_46   : inout std_logic; 
          Arduino_47   : inout std_logic; 
          Arduino_48   : inout std_logic; 
          Arduino_49   : inout std_logic; 
          Arduino_50   : inout std_logic; 
          Arduino_51   : inout std_logic; 
          Arduino_52   : inout std_logic; 
          Arduino_53   : inout std_logic; 
          ARD_SPI_MISO : inout std_logic);
end Papilio_DUO_LX9;

architecture BEHAVIORAL of Papilio_DUO_LX9 is
   attribute BOX_TYPE   : string ;
   signal XLXN_600                        : std_logic;
   signal XLXN_717                        : std_logic_vector (32 downto 0);
   signal XLXN_737                        : std_logic;
   signal XLXN_738                        : std_logic;
   signal XLXN_739                        : std_logic;
   signal XLXN_740                        : std_logic;
   signal XLXN_741                        : std_logic;
   signal XLXN_742                        : std_logic;
   signal XLXI_63_gpio_bus_out_openSignal : std_logic_vector (200 downto 0);
   signal XLXI_63_RS232_RX_openSignal     : std_logic;
   signal XLXI_63_SD_MOSI_openSignal      : std_logic;
   signal XLXI_63_SD_SCK_openSignal       : std_logic;
   signal XLXI_63_VGA_Blue0_openSignal    : std_logic;
   signal XLXI_63_VGA_Blue1_openSignal    : std_logic;
   signal XLXI_63_VGA_Blue2_openSignal    : std_logic;
   signal XLXI_63_VGA_Blue3_openSignal    : std_logic;
   signal XLXI_63_VGA_Green0_openSignal   : std_logic;
   signal XLXI_63_VGA_Green1_openSignal   : std_logic;
   signal XLXI_63_VGA_Green2_openSignal   : std_logic;
   signal XLXI_63_VGA_Green3_openSignal   : std_logic;
   signal XLXI_63_VGA_Hsync_openSignal    : std_logic;
   signal XLXI_63_VGA_Red0_openSignal     : std_logic;
   signal XLXI_63_VGA_Red1_openSignal     : std_logic;
   signal XLXI_63_VGA_Red2_openSignal     : std_logic;
   signal XLXI_63_VGA_Red3_openSignal     : std_logic;
   signal XLXI_63_VGA_Vsync_openSignal    : std_logic;
   signal XLXI_70_flashMISO_openSignal    : std_logic;
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   component clk_32to25_dcm
      port ( CLK_IN1  : in    std_logic; 
             CLK_OUT1 : out   std_logic);
   end component;
   
   component Computing_Shield_Pinout
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
             VGA_Red2     : in    std_logic; 
             VGA_Red1     : in    std_logic; 
             VGA_Red0     : in    std_logic; 
             VGA_Green2   : in    std_logic; 
             VGA_Green1   : in    std_logic; 
             VGA_Green0   : in    std_logic; 
             VGA_Hsync    : in    std_logic; 
             VGA_Vsync    : in    std_logic; 
             Audio1_Left  : in    std_logic; 
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
             SD_MISO      : out   std_logic; 
             SD_MOSI      : in    std_logic; 
             RS232_RX     : in    std_logic; 
             RS232_TX     : out   std_logic; 
             SD_SCK       : in    std_logic; 
             Audio1_Right : in    std_logic; 
             Audio2_Right : in    std_logic; 
             Audio2_Left  : in    std_logic; 
             WING_BL0     : inout std_logic; 
             WING_BL1     : inout std_logic; 
             WING_BL2     : inout std_logic; 
             WING_BL3     : inout std_logic; 
             WING_BL4     : inout std_logic; 
             WING_BL5     : inout std_logic; 
             WING_BL6     : inout std_logic; 
             WING_BL7     : inout std_logic; 
             WING_DL0     : inout std_logic; 
             WING_DL1     : inout std_logic; 
             WING_DL2     : inout std_logic; 
             WING_DL3     : inout std_logic; 
             WING_DL4     : inout std_logic; 
             WING_DL5     : inout std_logic; 
             WING_DL6     : inout std_logic; 
             WING_DL7     : inout std_logic; 
             WING_DH0     : inout std_logic; 
             WING_DH1     : inout std_logic; 
             WING_DH2     : inout std_logic; 
             WING_DH3     : inout std_logic; 
             WING_DH4     : inout std_logic; 
             WING_DH5     : inout std_logic; 
             WING_DH6     : inout std_logic; 
             WING_DH7     : inout std_logic; 
             VGA_Red3     : in    std_logic; 
             VGA_Green3   : in    std_logic; 
             VGA_Blue3    : in    std_logic; 
             VGA_Blue1    : in    std_logic; 
             VGA_Blue0    : in    std_logic; 
             VGA_Blue2    : in    std_logic; 
             VGA_Bus      : inout std_logic_vector (32 downto 0));
   end component;
   
   component Spartan6_Reset
      port ( reset : in    std_logic);
   end component;
   
   component Gameduino
      port ( clk_25Mhz   : in    std_logic; 
             vga_hsync_n : out   std_logic; 
             vga_vsync_n : out   std_logic; 
             vga_red     : out   std_logic_vector (2 downto 0); 
             vga_green   : out   std_logic_vector (2 downto 0); 
             vga_blue    : out   std_logic_vector (2 downto 0); 
             VGA_Bus     : inout std_logic_vector (32 downto 0); 
             AUDIOL      : out   std_logic; 
             AUDIOR      : out   std_logic; 
             MISO        : inout std_logic; 
             MOSI        : in    std_logic; 
             SCK         : in    std_logic; 
             SSEL        : in    std_logic; 
             flashMISO   : in    std_logic; 
             flashMOSI   : out   std_logic; 
             flashSCK    : out   std_logic; 
             AUX         : inout std_logic; 
             flashSSEL   : out   std_logic);
   end component;
   
   component MISC_zpuino_sa_splitter2
      port ( in1  : in    std_logic; 
             out1 : out   std_logic; 
             out2 : out   std_logic);
   end component;
   
begin
   XLXI_48 : INV
      port map (I=>Arduino_21,
                O=>ARD_RESET);
   
   XLXI_61 : clk_32to25_dcm
      port map (CLK_IN1=>clk,
                CLK_OUT1=>XLXN_600);
   
   XLXI_63 : Computing_Shield_Pinout
      port map (Audio1_Left=>XLXN_739,
                Audio1_Right=>XLXN_741,
                Audio2_Left=>XLXN_740,
                Audio2_Right=>XLXN_742,
                gpio_bus_out(200 downto 0)=>XLXI_63_gpio_bus_out_openSignal(200 
            downto 0),
                RS232_RX=>XLXI_63_RS232_RX_openSignal,
                SD_MOSI=>XLXI_63_SD_MOSI_openSignal,
                SD_SCK=>XLXI_63_SD_SCK_openSignal,
                VGA_Blue0=>XLXI_63_VGA_Blue0_openSignal,
                VGA_Blue1=>XLXI_63_VGA_Blue1_openSignal,
                VGA_Blue2=>XLXI_63_VGA_Blue2_openSignal,
                VGA_Blue3=>XLXI_63_VGA_Blue3_openSignal,
                VGA_Green0=>XLXI_63_VGA_Green0_openSignal,
                VGA_Green1=>XLXI_63_VGA_Green1_openSignal,
                VGA_Green2=>XLXI_63_VGA_Green2_openSignal,
                VGA_Green3=>XLXI_63_VGA_Green3_openSignal,
                VGA_Hsync=>XLXI_63_VGA_Hsync_openSignal,
                VGA_Red0=>XLXI_63_VGA_Red0_openSignal,
                VGA_Red1=>XLXI_63_VGA_Red1_openSignal,
                VGA_Red2=>XLXI_63_VGA_Red2_openSignal,
                VGA_Red3=>XLXI_63_VGA_Red3_openSignal,
                VGA_Vsync=>XLXI_63_VGA_Vsync_openSignal,
                gpio_bus_in=>open,
                RS232_TX=>open,
                SD_MISO=>open,
                VGA_Bus(32 downto 0)=>XLXN_717(32 downto 0),
                WING_AH0=>open,
                WING_AH1=>open,
                WING_AH2=>open,
                WING_AH3=>open,
                WING_AH4=>open,
                WING_AH5=>open,
                WING_AL0=>open,
                WING_AL1=>open,
                WING_AL2=>open,
                WING_AL3=>open,
                WING_AL4=>open,
                WING_AL5=>open,
                WING_AL6=>open,
                WING_AL7=>open,
                WING_BL0=>open,
                WING_BL1=>Arduino_20,
                WING_BL2=>open,
                WING_BL3=>Arduino_18,
                WING_BL4=>Arduino_17,
                WING_BL5=>Arduino_16,
                WING_BL6=>Arduino_15,
                WING_BL7=>Arduino_14,
                WING_CH0=>Arduino_38,
                WING_CH1=>Arduino_40,
                WING_CH2=>Arduino_42,
                WING_CH3=>Arduino_44,
                WING_CH4=>Arduino_46,
                WING_CH5=>Arduino_48,
                WING_CH6=>Arduino_50,
                WING_CH7=>Arduino_52,
                WING_CL0=>Arduino_22,
                WING_CL1=>Arduino_24,
                WING_CL2=>Arduino_26,
                WING_CL3=>Arduino_28,
                WING_CL4=>Arduino_30,
                WING_CL5=>Arduino_32,
                WING_CL6=>Arduino_34,
                WING_CL7=>Arduino_36,
                WING_DH0=>Arduino_37,
                WING_DH1=>Arduino_35,
                WING_DH2=>Arduino_33,
                WING_DH3=>Arduino_31,
                WING_DH4=>Arduino_29,
                WING_DH5=>Arduino_27,
                WING_DH6=>Arduino_25,
                WING_DH7=>Arduino_23,
                WING_DL0=>Arduino_53,
                WING_DL1=>Arduino_51,
                WING_DL2=>Arduino_49,
                WING_DL3=>Arduino_47,
                WING_DL4=>Arduino_45,
                WING_DL5=>Arduino_43,
                WING_DL6=>Arduino_41,
                WING_DL7=>Arduino_39);
   
   XLXI_69 : Spartan6_Reset
      port map (reset=>Arduino_19);
   
   XLXI_70 : Gameduino
      port map (clk_25Mhz=>XLXN_600,
                flashMISO=>XLXI_70_flashMISO_openSignal,
                MOSI=>ARD_SPI_MOSI,
                SCK=>ARD_SPI_SCLK,
                SSEL=>Arduino_9,
                AUDIOL=>XLXN_737,
                AUDIOR=>XLXN_738,
                flashMOSI=>open,
                flashSCK=>open,
                flashSSEL=>open,
                vga_blue=>open,
                vga_green=>open,
                vga_hsync_n=>open,
                vga_red=>open,
                vga_vsync_n=>open,
                AUX=>open,
                MISO=>ARD_SPI_MISO,
                VGA_Bus(32 downto 0)=>XLXN_717(32 downto 0));
   
   XLXI_71 : MISC_zpuino_sa_splitter2
      port map (in1=>XLXN_737,
                out1=>XLXN_739,
                out2=>XLXN_740);
   
   XLXI_72 : MISC_zpuino_sa_splitter2
      port map (in1=>XLXN_738,
                out1=>XLXN_741,
                out2=>XLXN_742);
   
end BEHAVIORAL;


