<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="CLK" />
        <signal name="XLXN_516" />
        <signal name="XLXN_517" />
        <signal name="XLXN_518" />
        <signal name="XLXN_519" />
        <signal name="XLXN_522" />
        <signal name="XLXN_523" />
        <signal name="XLXN_524" />
        <signal name="XLXN_525" />
        <signal name="XLXN_526" />
        <signal name="XLXN_527" />
        <signal name="XLXN_528" />
        <signal name="XLXN_529" />
        <port polarity="Input" name="CLK" />
        <blockdef name="bscan_spi">
            <timestamp>2014-1-20T23:25:50</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="BENCHY_sa_SumpBlaze_LogicAnalyzer8_spi">
            <timestamp>2014-1-21T16:18:51</timestamp>
            <rect width="256" x="64" y="-768" height="768" />
            <line x2="0" y1="-736" y2="-736" x1="64" />
            <line x2="0" y1="-672" y2="-672" x1="64" />
            <line x2="0" y1="-608" y2="-608" x1="64" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-736" y2="-736" x1="320" />
        </blockdef>
        <blockdef name="gnd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
        </blockdef>
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
        </blockdef>
        <block symbolname="bscan_spi" name="XLXI_56">
            <blockpin signalname="XLXN_519" name="SPI_MISO" />
            <blockpin signalname="XLXN_516" name="SPI_MOSI" />
            <blockpin signalname="XLXN_517" name="SPI_CS" />
            <blockpin signalname="XLXN_518" name="SPI_SCK" />
        </block>
        <block symbolname="BENCHY_sa_SumpBlaze_LogicAnalyzer8_spi" name="XLXI_60">
            <blockpin signalname="CLK" name="clk_32Mhz" />
            <blockpin signalname="XLXN_522" name="la0" />
            <blockpin signalname="XLXN_526" name="la1" />
            <blockpin signalname="XLXN_523" name="la2" />
            <blockpin signalname="XLXN_527" name="la3" />
            <blockpin signalname="XLXN_524" name="la4" />
            <blockpin signalname="XLXN_528" name="la5" />
            <blockpin signalname="XLXN_525" name="la6" />
            <blockpin signalname="XLXN_529" name="la7" />
            <blockpin signalname="XLXN_516" name="mosi" />
            <blockpin signalname="XLXN_518" name="sclk" />
            <blockpin signalname="XLXN_517" name="cs" />
            <blockpin signalname="XLXN_519" name="miso" />
        </block>
        <block symbolname="vcc" name="XLXI_69">
            <blockpin signalname="XLXN_522" name="P" />
        </block>
        <block symbolname="vcc" name="XLXI_70">
            <blockpin signalname="XLXN_523" name="P" />
        </block>
        <block symbolname="vcc" name="XLXI_71">
            <blockpin signalname="XLXN_524" name="P" />
        </block>
        <block symbolname="vcc" name="XLXI_72">
            <blockpin signalname="XLXN_525" name="P" />
        </block>
        <block symbolname="gnd" name="XLXI_73">
            <blockpin signalname="XLXN_526" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_74">
            <blockpin signalname="XLXN_527" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_75">
            <blockpin signalname="XLXN_528" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_76">
            <blockpin signalname="XLXN_529" name="G" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="5440" height="3520">
        <branch name="CLK">
            <wire x2="336" y1="96" y2="96" x1="304" />
            <wire x2="336" y1="96" y2="1792" x1="336" />
            <wire x2="2656" y1="1792" y2="1792" x1="336" />
        </branch>
        <iomarker fontsize="28" x="304" y="96" name="CLK" orien="R180" />
        <instance x="1440" y="2448" name="XLXI_56" orien="R0">
        </instance>
        <instance x="2656" y="2528" name="XLXI_60" orien="R0">
        </instance>
        <branch name="XLXN_516">
            <wire x2="2240" y1="2288" y2="2288" x1="1824" />
            <wire x2="2240" y1="2288" y2="2368" x1="2240" />
            <wire x2="2656" y1="2368" y2="2368" x1="2240" />
        </branch>
        <branch name="XLXN_517">
            <wire x2="2224" y1="2352" y2="2352" x1="1824" />
            <wire x2="2224" y1="2352" y2="2496" x1="2224" />
            <wire x2="2656" y1="2496" y2="2496" x1="2224" />
        </branch>
        <branch name="XLXN_518">
            <wire x2="2240" y1="2416" y2="2416" x1="1824" />
            <wire x2="2240" y1="2416" y2="2432" x1="2240" />
            <wire x2="2656" y1="2432" y2="2432" x1="2240" />
        </branch>
        <branch name="XLXN_519">
            <wire x2="1392" y1="1696" y2="2288" x1="1392" />
            <wire x2="1440" y1="2288" y2="2288" x1="1392" />
            <wire x2="3104" y1="1696" y2="1696" x1="1392" />
            <wire x2="3104" y1="1696" y2="1792" x1="3104" />
            <wire x2="3104" y1="1792" y2="1792" x1="3040" />
        </branch>
        <branch name="XLXN_522">
            <wire x2="2656" y1="1856" y2="1856" x1="2624" />
        </branch>
        <branch name="XLXN_523">
            <wire x2="2656" y1="1984" y2="1984" x1="2624" />
        </branch>
        <branch name="XLXN_524">
            <wire x2="2656" y1="2112" y2="2112" x1="2624" />
        </branch>
        <branch name="XLXN_525">
            <wire x2="2656" y1="2240" y2="2240" x1="2624" />
        </branch>
        <branch name="XLXN_526">
            <wire x2="2656" y1="1920" y2="1920" x1="2624" />
        </branch>
        <branch name="XLXN_527">
            <wire x2="2656" y1="2048" y2="2048" x1="2624" />
        </branch>
        <branch name="XLXN_528">
            <wire x2="2656" y1="2176" y2="2176" x1="2624" />
        </branch>
        <branch name="XLXN_529">
            <wire x2="2656" y1="2304" y2="2304" x1="2624" />
        </branch>
        <instance x="2624" y="1920" name="XLXI_69" orien="R270" />
        <instance x="2624" y="2048" name="XLXI_70" orien="R270" />
        <instance x="2624" y="2176" name="XLXI_71" orien="R270" />
        <instance x="2624" y="2304" name="XLXI_72" orien="R270" />
        <instance x="2496" y="1856" name="XLXI_73" orien="R90" />
        <instance x="2496" y="1984" name="XLXI_74" orien="R90" />
        <instance x="2496" y="2112" name="XLXI_75" orien="R90" />
        <instance x="2496" y="2240" name="XLXI_76" orien="R90" />
    </sheet>
</drawing>