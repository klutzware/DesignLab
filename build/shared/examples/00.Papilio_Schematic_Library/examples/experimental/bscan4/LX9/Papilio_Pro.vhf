--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.6
--  \   \         Application : sch2hdl
--  /   /         Filename : Papilio_Pro.vhf
-- /___/   /\     Timestamp : 01/27/2014 12:34:55
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan6 -flat -suppress -vhdl C:/dropbox/GadgetFactory/GadgetFactory_Engineering/Papilio-Schematic-Library/examples/experimental/bscan4/LX9/Papilio_Pro.vhf -w C:/dropbox/GadgetFactory/GadgetFactory_Engineering/Papilio-Schematic-Library/examples/experimental/bscan4/Papilio_Pro.sch
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
   port ( CLK : in    std_logic);
end Papilio_Pro;

architecture BEHAVIORAL of Papilio_Pro is
   attribute BOX_TYPE   : string ;
   signal XLXN_516 : std_logic;
   signal XLXN_517 : std_logic;
   signal XLXN_518 : std_logic;
   signal XLXN_519 : std_logic;
   signal XLXN_522 : std_logic;
   signal XLXN_523 : std_logic;
   signal XLXN_524 : std_logic;
   signal XLXN_525 : std_logic;
   signal XLXN_526 : std_logic;
   signal XLXN_527 : std_logic;
   signal XLXN_528 : std_logic;
   signal XLXN_529 : std_logic;
   component bscan_spi
      port ( SPI_MISO : in    std_logic; 
             SPI_MOSI : inout std_logic; 
             SPI_CS   : inout std_logic; 
             SPI_SCK  : inout std_logic);
   end component;
   
   component BENCHY_sa_SumpBlaze_LogicAnalyzer8_spi
      port ( clk_32Mhz : in    std_logic; 
             la0       : in    std_logic; 
             la1       : in    std_logic; 
             la2       : in    std_logic; 
             la3       : in    std_logic; 
             la4       : in    std_logic; 
             la5       : in    std_logic; 
             la6       : in    std_logic; 
             la7       : in    std_logic; 
             mosi      : in    std_logic; 
             sclk      : in    std_logic; 
             cs        : in    std_logic; 
             miso      : out   std_logic);
   end component;
   
   component VCC
      port ( P : out   std_logic);
   end component;
   attribute BOX_TYPE of VCC : component is "BLACK_BOX";
   
   component GND
      port ( G : out   std_logic);
   end component;
   attribute BOX_TYPE of GND : component is "BLACK_BOX";
   
begin
   XLXI_56 : bscan_spi
      port map (SPI_MISO=>XLXN_519,
                SPI_CS=>XLXN_517,
                SPI_MOSI=>XLXN_516,
                SPI_SCK=>XLXN_518);
   
   XLXI_60 : BENCHY_sa_SumpBlaze_LogicAnalyzer8_spi
      port map (clk_32Mhz=>CLK,
                cs=>XLXN_517,
                la0=>XLXN_522,
                la1=>XLXN_526,
                la2=>XLXN_523,
                la3=>XLXN_527,
                la4=>XLXN_524,
                la5=>XLXN_528,
                la6=>XLXN_525,
                la7=>XLXN_529,
                mosi=>XLXN_516,
                sclk=>XLXN_518,
                miso=>XLXN_519);
   
   XLXI_69 : VCC
      port map (P=>XLXN_522);
   
   XLXI_70 : VCC
      port map (P=>XLXN_523);
   
   XLXI_71 : VCC
      port map (P=>XLXN_524);
   
   XLXI_72 : VCC
      port map (P=>XLXN_525);
   
   XLXI_73 : GND
      port map (G=>XLXN_526);
   
   XLXI_74 : GND
      port map (G=>XLXN_527);
   
   XLXI_75 : GND
      port map (G=>XLXN_528);
   
   XLXI_76 : GND
      port map (G=>XLXN_529);
   
end BEHAVIORAL;


