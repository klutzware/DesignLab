--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.1
--  \   \         Application : sch2hdl
--  /   /         Filename : Papilio_DUO_LX9.vhf
-- /___/   /\     Timestamp : 12/26/2014 10:31:16
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/Benchy -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/Clocks -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/HQVGA -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/Papilio_Hardware -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/ZPUino_2 -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab/build/windows/work/libraries/ZPUino_Wishbone_Peripherals -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Benchy -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/BitCoin_Miner -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Clocks -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Gameduino -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/HQVGA -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/Papilio_Hardware -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/ZPUino_2 -sympath D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/ZPUino_Wishbone_Peripherals -intstyle ise -family spartan6 -flat -suppress -vhdl D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/BitCoin_Miner/circuit/DUO_LX9/Papilio_DUO_LX9.vhf -w D:/Dropbox/GadgetFactory_Engineering/DesignLab_Examples/libraries/BitCoin_Miner/circuit/Papilio_DUO_LX9.sch
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
   port ( Arduino_0  : in    std_logic; 
          CLK        : in    std_logic; 
          DUO_SW1    : in    std_logic; 
          RXD        : in    std_logic; 
          Arduino_48 : out   std_logic; 
          Arduino_50 : out   std_logic; 
          ARD_RESET  : out   std_logic; 
          TXD        : out   std_logic; 
          Arduino_1  : inout std_logic; 
          Arduino_2  : inout std_logic; 
          Arduino_3  : inout std_logic; 
          Arduino_4  : inout std_logic; 
          Arduino_5  : inout std_logic; 
          Arduino_6  : inout std_logic; 
          Arduino_7  : inout std_logic; 
          Arduino_8  : inout std_logic; 
          Arduino_9  : inout std_logic; 
          Arduino_10 : inout std_logic; 
          Arduino_11 : inout std_logic; 
          Arduino_12 : inout std_logic; 
          Arduino_13 : inout std_logic; 
          Arduino_14 : inout std_logic; 
          Arduino_15 : inout std_logic; 
          Arduino_16 : inout std_logic; 
          Arduino_17 : inout std_logic; 
          Arduino_18 : inout std_logic; 
          Arduino_19 : inout std_logic; 
          Arduino_20 : inout std_logic; 
          Arduino_21 : inout std_logic; 
          Arduino_22 : inout std_logic; 
          Arduino_23 : inout std_logic; 
          Arduino_24 : inout std_logic; 
          Arduino_25 : inout std_logic; 
          Arduino_26 : inout std_logic; 
          Arduino_27 : inout std_logic; 
          Arduino_28 : inout std_logic; 
          Arduino_29 : inout std_logic; 
          Arduino_30 : inout std_logic; 
          Arduino_31 : inout std_logic; 
          Arduino_32 : inout std_logic; 
          Arduino_33 : inout std_logic; 
          Arduino_34 : inout std_logic; 
          Arduino_35 : inout std_logic; 
          Arduino_36 : inout std_logic; 
          Arduino_37 : inout std_logic; 
          Arduino_38 : inout std_logic; 
          Arduino_39 : inout std_logic; 
          Arduino_40 : inout std_logic; 
          Arduino_41 : inout std_logic; 
          Arduino_42 : inout std_logic; 
          Arduino_43 : inout std_logic; 
          Arduino_44 : inout std_logic; 
          Arduino_45 : inout std_logic; 
          Arduino_46 : inout std_logic; 
          Arduino_47 : inout std_logic; 
          Arduino_49 : inout std_logic; 
          Arduino_51 : inout std_logic; 
          Arduino_52 : inout std_logic; 
          Arduino_53 : inout std_logic);
end Papilio_DUO_LX9;

architecture BEHAVIORAL of Papilio_DUO_LX9 is
   attribute BOX_TYPE   : string ;
   attribute IOSTANDARD : string ;
   attribute SLEW       : string ;
   attribute DRIVE      : string ;
   signal XLXN_600                        : std_logic_vector (3 downto 0);
   signal XLXN_601                        : std_logic_vector (7 downto 0);
   signal XLXN_605                        : std_logic_vector (1 downto 0);
   signal XLXI_60_Audio_Left_openSignal   : std_logic;
   signal XLXI_60_Audio_Right_openSignal  : std_logic;
   signal XLXI_60_gpio_bus_out_openSignal : std_logic_vector (200 downto 0);
   signal XLXI_60_VGA_Blue0_openSignal    : std_logic;
   signal XLXI_60_VGA_Blue1_openSignal    : std_logic;
   signal XLXI_60_VGA_Green0_openSignal   : std_logic;
   signal XLXI_60_VGA_Green1_openSignal   : std_logic;
   signal XLXI_60_VGA_Green2_openSignal   : std_logic;
   signal XLXI_60_VGA_Hsync_openSignal    : std_logic;
   signal XLXI_60_VGA_Red0_openSignal     : std_logic;
   signal XLXI_60_VGA_Red1_openSignal     : std_logic;
   signal XLXI_60_VGA_Red2_openSignal     : std_logic;
   signal XLXI_60_VGA_Vsync_openSignal    : std_logic;
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   component LogicStart_Shield_Pinout
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
             WING_BL0     : inout std_logic; 
             WING_BL1     : inout std_logic; 
             WING_BL2     : inout std_logic; 
             WING_BL3     : inout std_logic; 
             WING_BL4     : inout std_logic; 
             WING_BL5     : inout std_logic; 
             WING_BL6     : inout std_logic; 
             WING_BL7     : inout std_logic; 
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
             Audio_Left   : in    std_logic; 
             Seg7_dot     : in    std_logic; 
             Seg7_enable  : in    std_logic_vector (3 downto 0); 
             Seg7_segdata : in    std_logic_vector (6 downto 0); 
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
             Audio_Right  : in    std_logic);
   end component;
   
   component BitCoin_Miner
      port ( clk_32Mhz   : in    std_logic; 
             TxD         : out   std_logic; 
             RxD         : in    std_logic; 
             disp_switch : in    std_logic; 
             anode       : out   std_logic_vector (3 downto 0); 
             segment     : out   std_logic_vector (7 downto 0); 
             led         : out   std_logic_vector (1 downto 0));
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
   XLXI_48 : INV
      port map (I=>DUO_SW1,
                O=>ARD_RESET);
   
   XLXI_60 : LogicStart_Shield_Pinout
      port map (Audio_Left=>XLXI_60_Audio_Left_openSignal,
                Audio_Right=>XLXI_60_Audio_Right_openSignal,
                gpio_bus_out(200 downto 0)=>XLXI_60_gpio_bus_out_openSignal(200 
            downto 0),
                Seg7_dot=>XLXN_601(7),
                Seg7_enable(3 downto 0)=>XLXN_600(3 downto 0),
                Seg7_segdata(6 downto 0)=>XLXN_601(6 downto 0),
                VGA_Blue0=>XLXI_60_VGA_Blue0_openSignal,
                VGA_Blue1=>XLXI_60_VGA_Blue1_openSignal,
                VGA_Green0=>XLXI_60_VGA_Green0_openSignal,
                VGA_Green1=>XLXI_60_VGA_Green1_openSignal,
                VGA_Green2=>XLXI_60_VGA_Green2_openSignal,
                VGA_Hsync=>XLXI_60_VGA_Hsync_openSignal,
                VGA_Red0=>XLXI_60_VGA_Red0_openSignal,
                VGA_Red1=>XLXI_60_VGA_Red1_openSignal,
                VGA_Red2=>XLXI_60_VGA_Red2_openSignal,
                VGA_Vsync=>XLXI_60_VGA_Vsync_openSignal,
                gpio_bus_in=>open,
                WING_AH0=>Arduino_8,
                WING_AH1=>Arduino_9,
                WING_AH2=>Arduino_10,
                WING_AH3=>Arduino_11,
                WING_AH4=>Arduino_12,
                WING_AH5=>Arduino_13,
                WING_AL0=>open,
                WING_AL1=>Arduino_1,
                WING_AL2=>Arduino_2,
                WING_AL3=>Arduino_3,
                WING_AL4=>Arduino_4,
                WING_AL5=>Arduino_5,
                WING_AL6=>Arduino_6,
                WING_AL7=>Arduino_7,
                WING_BL0=>Arduino_21,
                WING_BL1=>Arduino_20,
                WING_BL2=>Arduino_19,
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
                WING_CH5=>open,
                WING_CH6=>open,
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
   
   XLXI_61 : BitCoin_Miner
      port map (clk_32Mhz=>CLK,
                disp_switch=>Arduino_0,
                RxD=>RXD,
                anode(3 downto 0)=>XLXN_600(3 downto 0),
                led(1 downto 0)=>XLXN_605(1 downto 0),
                segment(7 downto 0)=>XLXN_601(7 downto 0),
                TxD=>TXD);
   
   XLXI_63 : OBUF
      port map (I=>XLXN_605(0),
                O=>Arduino_48);
   
   XLXI_64 : OBUF
      port map (I=>XLXN_605(1),
                O=>Arduino_50);
   
end BEHAVIORAL;


