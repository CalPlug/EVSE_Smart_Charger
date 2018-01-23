-- Version: v11.8 11.8.0.26

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity SF2_MSS_sys_sb_CCC_0_FCCC is

    port( FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC : in    std_logic;
          FAB_CCC_LOCK                                       : out   std_logic;
          CCC_0_GL1                                          : out   std_logic;
          FAB_CCC_GL0                                        : out   std_logic
        );

end SF2_MSS_sys_sb_CCC_0_FCCC;

architecture DEF_ARCH of SF2_MSS_sys_sb_CCC_0_FCCC is 

  component CLKINT
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CCC

            generic (INIT:std_logic_vector(209 downto 0) := "00" & x"0000000000000000000000000000000000000000000000000000"; 
        VCOFREQUENCY:real := 0.0);

    port( Y0              : out   std_logic;
          Y1              : out   std_logic;
          Y2              : out   std_logic;
          Y3              : out   std_logic;
          PRDATA          : out   std_logic_vector(7 downto 0);
          LOCK            : out   std_logic;
          BUSY            : out   std_logic;
          CLK0            : in    std_logic := 'U';
          CLK1            : in    std_logic := 'U';
          CLK2            : in    std_logic := 'U';
          CLK3            : in    std_logic := 'U';
          NGMUX0_SEL      : in    std_logic := 'U';
          NGMUX1_SEL      : in    std_logic := 'U';
          NGMUX2_SEL      : in    std_logic := 'U';
          NGMUX3_SEL      : in    std_logic := 'U';
          NGMUX0_HOLD_N   : in    std_logic := 'U';
          NGMUX1_HOLD_N   : in    std_logic := 'U';
          NGMUX2_HOLD_N   : in    std_logic := 'U';
          NGMUX3_HOLD_N   : in    std_logic := 'U';
          NGMUX0_ARST_N   : in    std_logic := 'U';
          NGMUX1_ARST_N   : in    std_logic := 'U';
          NGMUX2_ARST_N   : in    std_logic := 'U';
          NGMUX3_ARST_N   : in    std_logic := 'U';
          PLL_BYPASS_N    : in    std_logic := 'U';
          PLL_ARST_N      : in    std_logic := 'U';
          PLL_POWERDOWN_N : in    std_logic := 'U';
          GPD0_ARST_N     : in    std_logic := 'U';
          GPD1_ARST_N     : in    std_logic := 'U';
          GPD2_ARST_N     : in    std_logic := 'U';
          GPD3_ARST_N     : in    std_logic := 'U';
          PRESET_N        : in    std_logic := 'U';
          PCLK            : in    std_logic := 'U';
          PSEL            : in    std_logic := 'U';
          PENABLE         : in    std_logic := 'U';
          PWRITE          : in    std_logic := 'U';
          PADDR           : in    std_logic_vector(7 downto 2) := (others => 'U');
          PWDATA          : in    std_logic_vector(7 downto 0) := (others => 'U');
          CLK0_PAD        : in    std_logic := 'U';
          CLK1_PAD        : in    std_logic := 'U';
          CLK2_PAD        : in    std_logic := 'U';
          CLK3_PAD        : in    std_logic := 'U';
          GL0             : out   std_logic;
          GL1             : out   std_logic;
          GL2             : out   std_logic;
          GL3             : out   std_logic;
          RCOSC_25_50MHZ  : in    std_logic := 'U';
          RCOSC_1MHZ      : in    std_logic := 'U';
          XTLOSC          : in    std_logic := 'U'
        );
  end component;

    signal GL0_net, GL1_net, VCC_net_1, GND_net_1 : std_logic;
    signal nc8, nc7, nc6, nc2, nc5, nc4, nc3, nc1 : std_logic;

begin 


    GL1_INST : CLKINT
      port map(A => GL1_net, Y => CCC_0_GL1);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    GL0_INST : CLKINT
      port map(A => GL0_net, Y => FAB_CCC_GL0);
    
    CCC_INST : CCC

              generic map(INIT => "00" & x"000007FA8000044D74000F18C6308C271839DEC0404051800604",
         VCOFREQUENCY => 560.0)

      port map(Y0 => OPEN, Y1 => OPEN, Y2 => OPEN, Y3 => OPEN, 
        PRDATA(7) => nc8, PRDATA(6) => nc7, PRDATA(5) => nc6, 
        PRDATA(4) => nc2, PRDATA(3) => nc5, PRDATA(2) => nc4, 
        PRDATA(1) => nc3, PRDATA(0) => nc1, LOCK => FAB_CCC_LOCK, 
        BUSY => OPEN, CLK0 => VCC_net_1, CLK1 => VCC_net_1, CLK2
         => VCC_net_1, CLK3 => VCC_net_1, NGMUX0_SEL => GND_net_1, 
        NGMUX1_SEL => GND_net_1, NGMUX2_SEL => GND_net_1, 
        NGMUX3_SEL => GND_net_1, NGMUX0_HOLD_N => VCC_net_1, 
        NGMUX1_HOLD_N => VCC_net_1, NGMUX2_HOLD_N => VCC_net_1, 
        NGMUX3_HOLD_N => VCC_net_1, NGMUX0_ARST_N => VCC_net_1, 
        NGMUX1_ARST_N => VCC_net_1, NGMUX2_ARST_N => VCC_net_1, 
        NGMUX3_ARST_N => VCC_net_1, PLL_BYPASS_N => VCC_net_1, 
        PLL_ARST_N => VCC_net_1, PLL_POWERDOWN_N => VCC_net_1, 
        GPD0_ARST_N => VCC_net_1, GPD1_ARST_N => VCC_net_1, 
        GPD2_ARST_N => VCC_net_1, GPD3_ARST_N => VCC_net_1, 
        PRESET_N => GND_net_1, PCLK => VCC_net_1, PSEL => 
        VCC_net_1, PENABLE => VCC_net_1, PWRITE => VCC_net_1, 
        PADDR(7) => VCC_net_1, PADDR(6) => VCC_net_1, PADDR(5)
         => VCC_net_1, PADDR(4) => VCC_net_1, PADDR(3) => 
        VCC_net_1, PADDR(2) => VCC_net_1, PWDATA(7) => VCC_net_1, 
        PWDATA(6) => VCC_net_1, PWDATA(5) => VCC_net_1, PWDATA(4)
         => VCC_net_1, PWDATA(3) => VCC_net_1, PWDATA(2) => 
        VCC_net_1, PWDATA(1) => VCC_net_1, PWDATA(0) => VCC_net_1, 
        CLK0_PAD => GND_net_1, CLK1_PAD => GND_net_1, CLK2_PAD
         => GND_net_1, CLK3_PAD => GND_net_1, GL0 => GL0_net, GL1
         => GL1_net, GL2 => OPEN, GL3 => OPEN, RCOSC_25_50MHZ => 
        FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC, 
        RCOSC_1MHZ => GND_net_1, XTLOSC => GND_net_1);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity SF2_MSS_sys_sb_CoreUARTapb_0_Clock_gen is

    port( controlReg2 : in    std_logic_vector(7 downto 3);
          controlReg1 : in    std_logic_vector(7 downto 0);
          xmit_pulse  : out   std_logic;
          baud_clock  : out   std_logic;
          FAB_CCC_GL0 : in    std_logic;
          MSS_READY   : in    std_logic
        );

end SF2_MSS_sys_sb_CoreUARTapb_0_Clock_gen;

architecture DEF_ARCH of SF2_MSS_sys_sb_CoreUARTapb_0_Clock_gen is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component ARI1
    generic (INIT:std_logic_vector(19 downto 0) := x"00000");

    port( A   : in    std_logic := 'U';
          B   : in    std_logic := 'U';
          C   : in    std_logic := 'U';
          D   : in    std_logic := 'U';
          FCI : in    std_logic := 'U';
          S   : out   std_logic;
          Y   : out   std_logic;
          FCO : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal \xmit_clock\, VCC_net_1, un8_baud_clock_int, 
        \baud_clock\, GND_net_1, \xmit_cntr[0]_net_1\, 
        \xmit_cntr_3[0]\, \xmit_cntr[1]_net_1\, \xmit_cntr_3[1]\, 
        \xmit_cntr[2]_net_1\, \xmit_cntr_3[2]\, 
        \xmit_cntr[3]_net_1\, \xmit_cntr_3[3]\, 
        un2_baud_cntr_1_RNIQKSK_Y, \baud_cntr[0]_net_1\, 
        \baud_cntr_s[0]\, \baud_cntr[1]_net_1\, \baud_cntr_s[1]\, 
        \baud_cntr[2]_net_1\, \baud_cntr_s[2]\, 
        \baud_cntr[3]_net_1\, \baud_cntr_s[3]\, 
        \baud_cntr[4]_net_1\, \baud_cntr_s[4]\, 
        \baud_cntr[5]_net_1\, \baud_cntr_s[5]\, 
        \baud_cntr[6]_net_1\, \baud_cntr_s[6]\, 
        \baud_cntr[7]_net_1\, \baud_cntr_s[7]\, 
        \baud_cntr[8]_net_1\, \baud_cntr_s[8]\, 
        \baud_cntr[9]_net_1\, \baud_cntr_s[9]\, 
        \baud_cntr[10]_net_1\, \baud_cntr_s[10]\, 
        \baud_cntr[11]_net_1\, \baud_cntr_s[11]\, 
        \baud_cntr[12]_net_1\, \baud_cntr_s[12]\, 
        baud_cntr_cry_cy, un2_baud_cntr_1, un2_baud_cntr_7, 
        un2_baud_cntr_8, \baud_cntr_cry[0]\, \baud_cntr_cry[1]\, 
        \baud_cntr_cry[2]\, \baud_cntr_cry[3]\, 
        \baud_cntr_cry[4]\, \baud_cntr_cry[5]\, 
        \baud_cntr_cry[6]\, \baud_cntr_cry[7]\, 
        \baud_cntr_cry[8]\, \baud_cntr_cry[9]\, 
        \baud_cntr_cry[10]\, \baud_cntr_cry[11]\, CO0
         : std_logic;

begin 

    baud_clock <= \baud_clock\;

    \baud_cntr[7]\ : SLE
      port map(D => \baud_cntr_s[7]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \baud_cntr[7]_net_1\);
    
    \baud_cntr_RNIUD0RB[10]\ : ARI1
      generic map(INIT => x"64700")

      port map(A => VCC_net_1, B => controlReg2(5), C => 
        un2_baud_cntr_1_RNIQKSK_Y, D => \baud_cntr[10]_net_1\, 
        FCI => \baud_cntr_cry[9]\, S => \baud_cntr_s[10]\, Y => 
        OPEN, FCO => \baud_cntr_cry[10]\);
    
    \baud_cntr[0]\ : SLE
      port map(D => \baud_cntr_s[0]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \baud_cntr[0]_net_1\);
    
    \baud_cntr_RNIUBEJ2[1]\ : ARI1
      generic map(INIT => x"64700")

      port map(A => VCC_net_1, B => controlReg1(1), C => 
        un2_baud_cntr_1_RNIQKSK_Y, D => \baud_cntr[1]_net_1\, FCI
         => \baud_cntr_cry[0]\, S => \baud_cntr_s[1]\, Y => OPEN, 
        FCO => \baud_cntr_cry[1]\);
    
    \baud_cntr[9]\ : SLE
      port map(D => \baud_cntr_s[9]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \baud_cntr[9]_net_1\);
    
    \xmit_cntr[3]\ : SLE
      port map(D => \xmit_cntr_3[3]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_cntr[3]_net_1\);
    
    \baud_cntr_RNINBHF9[8]\ : ARI1
      generic map(INIT => x"64700")

      port map(A => VCC_net_1, B => controlReg2(3), C => 
        un2_baud_cntr_1_RNIQKSK_Y, D => \baud_cntr[8]_net_1\, FCI
         => \baud_cntr_cry[7]\, S => \baud_cntr_s[8]\, Y => OPEN, 
        FCO => \baud_cntr_cry[8]\);
    
    \UG10.make_baud_cntr2.un2_baud_cntr_1\ : CFG4
      generic map(INIT => x"0001")

      port map(A => \baud_cntr[11]_net_1\, B => 
        \baud_cntr[10]_net_1\, C => \baud_cntr[1]_net_1\, D => 
        \baud_cntr[0]_net_1\, Y => un2_baud_cntr_1);
    
    \baud_cntr_RNO[12]\ : ARI1
      generic map(INIT => x"44700")

      port map(A => VCC_net_1, B => controlReg2(7), C => 
        un2_baud_cntr_1_RNIQKSK_Y, D => \baud_cntr[12]_net_1\, 
        FCI => \baud_cntr_cry[11]\, S => \baud_cntr_s[12]\, Y => 
        OPEN, FCO => OPEN);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \baud_cntr_RNIBF5K1[0]\ : ARI1
      generic map(INIT => x"64700")

      port map(A => VCC_net_1, B => controlReg1(0), C => 
        un2_baud_cntr_1_RNIQKSK_Y, D => \baud_cntr[0]_net_1\, FCI
         => baud_cntr_cry_cy, S => \baud_cntr_s[0]\, Y => OPEN, 
        FCO => \baud_cntr_cry[0]\);
    
    \baud_cntr_RNIUIIG6[5]\ : ARI1
      generic map(INIT => x"64700")

      port map(A => VCC_net_1, B => controlReg1(5), C => 
        un2_baud_cntr_1_RNIQKSK_Y, D => \baud_cntr[5]_net_1\, FCI
         => \baud_cntr_cry[4]\, S => \baud_cntr_s[5]\, Y => OPEN, 
        FCO => \baud_cntr_cry[5]\);
    
    \UG10.make_baud_cntr2.un2_baud_cntr_7\ : CFG4
      generic map(INIT => x"0001")

      port map(A => \baud_cntr[5]_net_1\, B => 
        \baud_cntr[4]_net_1\, C => \baud_cntr[3]_net_1\, D => 
        \baud_cntr[2]_net_1\, Y => un2_baud_cntr_7);
    
    \baud_cntr_RNIRPRF7[6]\ : ARI1
      generic map(INIT => x"64700")

      port map(A => VCC_net_1, B => controlReg1(6), C => 
        un2_baud_cntr_1_RNIQKSK_Y, D => \baud_cntr[6]_net_1\, FCI
         => \baud_cntr_cry[5]\, S => \baud_cntr_s[6]\, Y => OPEN, 
        FCO => \baud_cntr_cry[6]\);
    
    \baud_cntr[5]\ : SLE
      port map(D => \baud_cntr_s[5]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \baud_cntr[5]_net_1\);
    
    \baud_cntr[3]\ : SLE
      port map(D => \baud_cntr_s[3]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \baud_cntr[3]_net_1\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \make_xmit_clock.xmit_cntr_3_1.SUM[3]\ : CFG4
      generic map(INIT => x"6AAA")

      port map(A => \xmit_cntr[3]_net_1\, B => 
        \xmit_cntr[2]_net_1\, C => \xmit_cntr[1]_net_1\, D => CO0, 
        Y => \xmit_cntr_3[3]\);
    
    \baud_cntr_RNIQ25F8[7]\ : ARI1
      generic map(INIT => x"64700")

      port map(A => VCC_net_1, B => controlReg1(7), C => 
        un2_baud_cntr_1_RNIQKSK_Y, D => \baud_cntr[7]_net_1\, FCI
         => \baud_cntr_cry[6]\, S => \baud_cntr_s[7]\, Y => OPEN, 
        FCO => \baud_cntr_cry[7]\);
    
    \baud_cntr[2]\ : SLE
      port map(D => \baud_cntr_s[2]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \baud_cntr[2]_net_1\);
    
    \baud_cntr_RNIMMTFA[9]\ : ARI1
      generic map(INIT => x"64700")

      port map(A => VCC_net_1, B => controlReg2(4), C => 
        un2_baud_cntr_1_RNIQKSK_Y, D => \baud_cntr[9]_net_1\, FCI
         => \baud_cntr_cry[8]\, S => \baud_cntr_s[9]\, Y => OPEN, 
        FCO => \baud_cntr_cry[9]\);
    
    \UG10.make_baud_cntr2.un2_baud_cntr_8\ : CFG4
      generic map(INIT => x"0001")

      port map(A => \baud_cntr[9]_net_1\, B => 
        \baud_cntr[8]_net_1\, C => \baud_cntr[7]_net_1\, D => 
        \baud_cntr[6]_net_1\, Y => un2_baud_cntr_8);
    
    \baud_cntr[10]\ : SLE
      port map(D => \baud_cntr_s[10]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \baud_cntr[10]_net_1\);
    
    \baud_cntr[11]\ : SLE
      port map(D => \baud_cntr_s[11]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \baud_cntr[11]_net_1\);
    
    \baud_cntr[6]\ : SLE
      port map(D => \baud_cntr_s[6]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \baud_cntr[6]_net_1\);
    
    \baud_cntr[4]\ : SLE
      port map(D => \baud_cntr_s[4]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \baud_cntr[4]_net_1\);
    
    \baud_cntr_RNI3E9H5[4]\ : ARI1
      generic map(INIT => x"64700")

      port map(A => VCC_net_1, B => controlReg1(4), C => 
        un2_baud_cntr_1_RNIQKSK_Y, D => \baud_cntr[4]_net_1\, FCI
         => \baud_cntr_cry[3]\, S => \baud_cntr_s[4]\, Y => OPEN, 
        FCO => \baud_cntr_cry[4]\);
    
    \xmit_cntr[2]\ : SLE
      port map(D => \xmit_cntr_3[2]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_cntr[2]_net_1\);
    
    \make_xmit_clock.xmit_cntr_3_1.SUM[1]\ : CFG2
      generic map(INIT => x"6")

      port map(A => CO0, B => \xmit_cntr[1]_net_1\, Y => 
        \xmit_cntr_3[1]\);
    
    \baud_cntr[1]\ : SLE
      port map(D => \baud_cntr_s[1]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \baud_cntr[1]_net_1\);
    
    \baud_cntr_RNIAB0I4[3]\ : ARI1
      generic map(INIT => x"64700")

      port map(A => VCC_net_1, B => controlReg1(3), C => 
        un2_baud_cntr_1_RNIQKSK_Y, D => \baud_cntr[3]_net_1\, FCI
         => \baud_cntr_cry[2]\, S => \baud_cntr_s[3]\, Y => OPEN, 
        FCO => \baud_cntr_cry[3]\);
    
    xmit_clock : SLE
      port map(D => un8_baud_clock_int, CLK => FAB_CCC_GL0, EN
         => \baud_clock\, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_clock\);
    
    baud_clock_int : SLE
      port map(D => un2_baud_cntr_1_RNIQKSK_Y, CLK => FAB_CCC_GL0, 
        EN => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \baud_clock\);
    
    \make_xmit_clock.xmit_cntr_3_1.CO0\ : CFG2
      generic map(INIT => x"8")

      port map(A => \baud_clock\, B => \xmit_cntr[0]_net_1\, Y
         => CO0);
    
    \baud_cntr_RNI8736D[11]\ : ARI1
      generic map(INIT => x"64700")

      port map(A => VCC_net_1, B => controlReg2(6), C => 
        un2_baud_cntr_1_RNIQKSK_Y, D => \baud_cntr[11]_net_1\, 
        FCI => \baud_cntr_cry[10]\, S => \baud_cntr_s[11]\, Y => 
        OPEN, FCO => \baud_cntr_cry[11]\);
    
    \xmit_cntr[1]\ : SLE
      port map(D => \xmit_cntr_3[1]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_cntr[1]_net_1\);
    
    \baud_cntr[12]\ : SLE
      port map(D => \baud_cntr_s[12]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \baud_cntr[12]_net_1\);
    
    \xmit_pulse\ : CFG2
      generic map(INIT => x"8")

      port map(A => \baud_clock\, B => \xmit_clock\, Y => 
        xmit_pulse);
    
    \xmit_cntr[0]\ : SLE
      port map(D => \xmit_cntr_3[0]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_cntr[0]_net_1\);
    
    \make_xmit_clock.xmit_cntr_3_1.SUM[0]\ : CFG2
      generic map(INIT => x"6")

      port map(A => \baud_clock\, B => \xmit_cntr[0]_net_1\, Y
         => \xmit_cntr_3[0]\);
    
    \UG10.make_baud_cntr2.un2_baud_cntr_1_RNIQKSK\ : ARI1
      generic map(INIT => x"40080")

      port map(A => \baud_cntr[12]_net_1\, B => un2_baud_cntr_1, 
        C => un2_baud_cntr_7, D => un2_baud_cntr_8, FCI => 
        VCC_net_1, S => OPEN, Y => un2_baud_cntr_1_RNIQKSK_Y, FCO
         => baud_cntr_cry_cy);
    
    \make_xmit_clock.un8_baud_clock_int\ : CFG4
      generic map(INIT => x"8000")

      port map(A => \xmit_cntr[2]_net_1\, B => 
        \xmit_cntr[3]_net_1\, C => \xmit_cntr[1]_net_1\, D => 
        \xmit_cntr[0]_net_1\, Y => un8_baud_clock_int);
    
    \make_xmit_clock.xmit_cntr_3_1.SUM[2]\ : CFG3
      generic map(INIT => x"6A")

      port map(A => \xmit_cntr[2]_net_1\, B => 
        \xmit_cntr[1]_net_1\, C => CO0, Y => \xmit_cntr_3[2]\);
    
    \baud_cntr_RNIJANI3[2]\ : ARI1
      generic map(INIT => x"64700")

      port map(A => VCC_net_1, B => controlReg1(2), C => 
        un2_baud_cntr_1_RNIQKSK_Y, D => \baud_cntr[2]_net_1\, FCI
         => \baud_cntr_cry[1]\, S => \baud_cntr_s[2]\, Y => OPEN, 
        FCO => \baud_cntr_cry[2]\);
    
    \baud_cntr[8]\ : SLE
      port map(D => \baud_cntr_s[8]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \baud_cntr[8]_net_1\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity SF2_MSS_sys_sb_CoreUARTapb_0_Tx_async is

    port( controlReg2         : in    std_logic_vector(2 downto 0);
          tx_hold_reg         : in    std_logic_vector(7 downto 0);
          un1_csn             : in    std_logic;
          un1_csn_i           : in    std_logic;
          CoreUARTapb_0_TXRDY : out   std_logic;
          TX_c                : out   std_logic;
          xmit_pulse          : in    std_logic;
          FAB_CCC_GL0         : in    std_logic;
          MSS_READY           : in    std_logic
        );

end SF2_MSS_sys_sb_CoreUARTapb_0_Tx_async;

architecture DEF_ARCH of SF2_MSS_sys_sb_CoreUARTapb_0_Tx_async is 

  component ARI1
    generic (INIT:std_logic_vector(19 downto 0) := x"00000");

    port( A   : in    std_logic := 'U';
          B   : in    std_logic := 'U';
          C   : in    std_logic := 'U';
          D   : in    std_logic := 'U';
          FCI : in    std_logic := 'U';
          S   : out   std_logic;
          Y   : out   std_logic;
          FCO : out   std_logic
        );
  end component;

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \tx_byte[4]_net_1\, VCC_net_1, N_136_i, GND_net_1, 
        \tx_byte[5]_net_1\, \tx_byte[6]_net_1\, 
        \tx_byte[7]_net_1\, \xmit_bit_sel[0]_net_1\, 
        \xmit_bit_sel_113\, \xmit_bit_sel[1]_net_1\, 
        \xmit_bit_sel_114\, \xmit_bit_sel[2]_net_1\, 
        \xmit_bit_sel_115\, \xmit_bit_sel[3]_net_1\, N_131_i, 
        \tx_byte[0]_net_1\, \tx_byte[1]_net_1\, 
        \tx_byte[2]_net_1\, \tx_byte[3]_net_1\, \tx_parity\, 
        tx_parity_4, \un1_tx_parity_1_sqmuxa_0\, tx_xhdl2_3_iv_i, 
        N_148_i, \CoreUARTapb_0_TXRDY\, \txrdy_int_1_sqmuxa_i\, 
        \xmit_state[5]_net_1\, \xmit_state_ns[0]_net_1\, 
        \xmit_state[4]_net_1\, \xmit_state_ns[1]\, 
        \xmit_state[3]_net_1\, \xmit_state_ns[2]_net_1\, 
        \xmit_state[2]_net_1\, N_118_i, \xmit_state[1]_net_1\, 
        \xmit_state_ns[4]_net_1\, \xmit_state[0]_net_1\, 
        \xmit_state_ns[5]_net_1\, N_65, tx_xhdl2_1_7_i_m2_4_0_y1, 
        tx_xhdl2_1_7_i_m2_4_0_y3, tx_xhdl2_1_7_i_m2_4_co1_0, 
        tx_xhdl2_1_7_i_m2_4_y0_0, tx_xhdl2_1_7_i_m2_4_co0_0, 
        tx_xhdl2_1_7_i_m2_4_0_co1, tx_xhdl2_1_7_i_m2_4_0_y0, 
        tx_xhdl2_1_7_i_m2_4_0_co0, N_133_i, N_57, tx_xhdl2_2_i_m, 
        N_175, N_176, N_158 : std_logic;

begin 

    CoreUARTapb_0_TXRDY <= \CoreUARTapb_0_TXRDY\;

    \xmit_sel.tx_xhdl2_1_7_i_m2_4_wmux_0\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => tx_xhdl2_1_7_i_m2_4_0_y0, B => 
        \xmit_bit_sel[0]_net_1\, C => \tx_byte[1]_net_1\, D => 
        \tx_byte[3]_net_1\, FCI => tx_xhdl2_1_7_i_m2_4_0_co0, S
         => OPEN, Y => tx_xhdl2_1_7_i_m2_4_0_y1, FCO => 
        tx_xhdl2_1_7_i_m2_4_0_co1);
    
    tx_parity : SLE
      port map(D => tx_parity_4, CLK => FAB_CCC_GL0, EN => 
        \un1_tx_parity_1_sqmuxa_0\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \tx_parity\);
    
    txrdy_int : SLE
      port map(D => un1_csn_i, CLK => FAB_CCC_GL0, EN => 
        \txrdy_int_1_sqmuxa_i\, ALn => MSS_READY, ADn => 
        GND_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CoreUARTapb_0_TXRDY\);
    
    \xmit_state_ns_a3[5]\ : CFG4
      generic map(INIT => x"4000")

      port map(A => controlReg2(1), B => \xmit_state[2]_net_1\, C
         => xmit_pulse, D => N_175, Y => N_158);
    
    \xmit_state_ns_i_x2[3]\ : CFG2
      generic map(INIT => x"6")

      port map(A => controlReg2(0), B => \xmit_bit_sel[0]_net_1\, 
        Y => N_133_i);
    
    xmit_bit_sel_115 : CFG4
      generic map(INIT => x"B430")

      port map(A => N_57, B => xmit_pulse, C => 
        \xmit_bit_sel[2]_net_1\, D => \xmit_state[2]_net_1\, Y
         => \xmit_bit_sel_115\);
    
    \xmit_state[3]\ : SLE
      port map(D => \xmit_state_ns[2]_net_1\, CLK => FAB_CCC_GL0, 
        EN => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_state[3]_net_1\);
    
    \tx_byte[0]\ : SLE
      port map(D => tx_hold_reg(0), CLK => FAB_CCC_GL0, EN => 
        N_136_i, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \tx_byte[0]_net_1\);
    
    \xmit_state[0]\ : SLE
      port map(D => \xmit_state_ns[5]_net_1\, CLK => FAB_CCC_GL0, 
        EN => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_state[0]_net_1\);
    
    \tx_byte[4]\ : SLE
      port map(D => tx_hold_reg(4), CLK => FAB_CCC_GL0, EN => 
        N_136_i, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \tx_byte[4]_net_1\);
    
    \xmit_sel.tx_xhdl2_1_7_i_m2_4_wmux_3\ : ARI1
      generic map(INIT => x"0EC2C")

      port map(A => tx_xhdl2_1_7_i_m2_4_0_y3, B => 
        tx_xhdl2_1_7_i_m2_4_0_y1, C => \xmit_bit_sel[2]_net_1\, D
         => VCC_net_1, FCI => tx_xhdl2_1_7_i_m2_4_co1_0, S => 
        OPEN, Y => N_65, FCO => OPEN);
    
    un1_tx_parity_1_sqmuxa_0_a2 : CFG3
      generic map(INIT => x"80")

      port map(A => controlReg2(1), B => xmit_pulse, C => 
        \xmit_state[2]_net_1\, Y => N_176);
    
    \xmit_cnt.xmit_bit_sel_3_i_0_o2[1]\ : CFG2
      generic map(INIT => x"7")

      port map(A => \xmit_bit_sel[0]_net_1\, B => 
        \xmit_bit_sel[1]_net_1\, Y => N_57);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \tx_byte[5]\ : SLE
      port map(D => tx_hold_reg(5), CLK => FAB_CCC_GL0, EN => 
        N_136_i, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \tx_byte[5]_net_1\);
    
    txrdy_int_1_sqmuxa_i : CFG3
      generic map(INIT => x"EA")

      port map(A => un1_csn, B => \xmit_state[3]_net_1\, C => 
        xmit_pulse, Y => \txrdy_int_1_sqmuxa_i\);
    
    \xmit_state[5]\ : SLE
      port map(D => \xmit_state_ns[0]_net_1\, CLK => FAB_CCC_GL0, 
        EN => VCC_net_1, ALn => MSS_READY, ADn => GND_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_state[5]_net_1\);
    
    \xmit_sel.tx_xhdl2_3_iv_i\ : CFG4
      generic map(INIT => x"0501")

      port map(A => \xmit_state[3]_net_1\, B => 
        \xmit_state[2]_net_1\, C => tx_xhdl2_2_i_m, D => N_65, Y
         => tx_xhdl2_3_iv_i);
    
    tx_xhdl2_RNO : CFG3
      generic map(INIT => x"FE")

      port map(A => \xmit_state[4]_net_1\, B => 
        \xmit_state[5]_net_1\, C => xmit_pulse, Y => N_148_i);
    
    \xmit_state_ns[2]\ : CFG3
      generic map(INIT => x"F2")

      port map(A => \xmit_state[3]_net_1\, B => xmit_pulse, C => 
        \xmit_state[4]_net_1\, Y => \xmit_state_ns[2]_net_1\);
    
    \xmit_state_ns[4]\ : CFG4
      generic map(INIT => x"CE0A")

      port map(A => \xmit_state[1]_net_1\, B => N_175, C => 
        xmit_pulse, D => N_176, Y => \xmit_state_ns[4]_net_1\);
    
    \xmit_state[2]\ : SLE
      port map(D => N_118_i, CLK => FAB_CCC_GL0, EN => VCC_net_1, 
        ALn => MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_state[2]_net_1\);
    
    \xmit_sel.tx_xhdl2_1_7_i_m2_4_0_wmux\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => \xmit_bit_sel[1]_net_1\, B => 
        \xmit_bit_sel[0]_net_1\, C => \tx_byte[0]_net_1\, D => 
        \tx_byte[2]_net_1\, FCI => VCC_net_1, S => OPEN, Y => 
        tx_xhdl2_1_7_i_m2_4_0_y0, FCO => 
        tx_xhdl2_1_7_i_m2_4_0_co0);
    
    \xmit_bit_sel[3]\ : SLE
      port map(D => N_131_i, CLK => FAB_CCC_GL0, EN => xmit_pulse, 
        ALn => MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_bit_sel[3]_net_1\);
    
    \xmit_sel.tx_xhdl2_1_7_i_m2_4_wmux_2\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => tx_xhdl2_1_7_i_m2_4_y0_0, B => 
        \xmit_bit_sel[0]_net_1\, C => \tx_byte[5]_net_1\, D => 
        \tx_byte[7]_net_1\, FCI => tx_xhdl2_1_7_i_m2_4_co0_0, S
         => OPEN, Y => tx_xhdl2_1_7_i_m2_4_0_y3, FCO => 
        tx_xhdl2_1_7_i_m2_4_co1_0);
    
    tx_xhdl2 : SLE
      port map(D => tx_xhdl2_3_iv_i, CLK => FAB_CCC_GL0, EN => 
        N_148_i, ALn => MSS_READY, ADn => GND_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => TX_c);
    
    \xmit_bit_sel[2]\ : SLE
      port map(D => \xmit_bit_sel_115\, CLK => FAB_CCC_GL0, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_bit_sel[2]_net_1\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \tx_byte[3]\ : SLE
      port map(D => tx_hold_reg(3), CLK => FAB_CCC_GL0, EN => 
        N_136_i, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \tx_byte[3]_net_1\);
    
    \tx_byte[7]\ : SLE
      port map(D => tx_hold_reg(7), CLK => FAB_CCC_GL0, EN => 
        N_136_i, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \tx_byte[7]_net_1\);
    
    xmit_bit_sel_114 : CFG4
      generic map(INIT => x"6C0C")

      port map(A => \xmit_bit_sel[0]_net_1\, B => 
        \xmit_bit_sel[1]_net_1\, C => xmit_pulse, D => 
        \xmit_state[2]_net_1\, Y => \xmit_bit_sel_114\);
    
    un1_tx_parity_1_sqmuxa_0 : CFG4
      generic map(INIT => x"ECCC")

      port map(A => \xmit_state[2]_net_1\, B => 
        \xmit_state[0]_net_1\, C => xmit_pulse, D => 
        controlReg2(1), Y => \un1_tx_parity_1_sqmuxa_0\);
    
    \xmit_state_ns_i_a2[3]\ : CFG4
      generic map(INIT => x"0040")

      port map(A => \xmit_bit_sel[3]_net_1\, B => 
        \xmit_bit_sel[2]_net_1\, C => \xmit_bit_sel[1]_net_1\, D
         => N_133_i, Y => N_175);
    
    \xmit_state_ns_a3[1]\ : CFG2
      generic map(INIT => x"4")

      port map(A => \CoreUARTapb_0_TXRDY\, B => 
        \xmit_state[5]_net_1\, Y => \xmit_state_ns[1]\);
    
    \xmit_par_calc.tx_parity_4\ : CFG3
      generic map(INIT => x"14")

      port map(A => \xmit_state[0]_net_1\, B => N_65, C => 
        \tx_parity\, Y => tx_parity_4);
    
    \xmit_sel.tx_xhdl2_3_iv_i_RNO\ : CFG3
      generic map(INIT => x"82")

      port map(A => \xmit_state[1]_net_1\, B => controlReg2(2), C
         => \tx_parity\, Y => tx_xhdl2_2_i_m);
    
    \xmit_state_ns[5]\ : CFG4
      generic map(INIT => x"FDEC")

      port map(A => xmit_pulse, B => N_158, C => 
        \xmit_state[1]_net_1\, D => \xmit_state[0]_net_1\, Y => 
        \xmit_state_ns[5]_net_1\);
    
    \xmit_sel.tx_xhdl2_1_7_i_m2_4_wmux_1\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => \xmit_bit_sel[1]_net_1\, B => 
        \xmit_bit_sel[0]_net_1\, C => \tx_byte[4]_net_1\, D => 
        \tx_byte[6]_net_1\, FCI => tx_xhdl2_1_7_i_m2_4_0_co1, S
         => OPEN, Y => tx_xhdl2_1_7_i_m2_4_y0_0, FCO => 
        tx_xhdl2_1_7_i_m2_4_co0_0);
    
    \tx_byte[6]\ : SLE
      port map(D => tx_hold_reg(6), CLK => FAB_CCC_GL0, EN => 
        N_136_i, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \tx_byte[6]_net_1\);
    
    \xmit_bit_sel[1]\ : SLE
      port map(D => \xmit_bit_sel_114\, CLK => FAB_CCC_GL0, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_bit_sel[1]_net_1\);
    
    xmit_bit_sel_113 : CFG3
      generic map(INIT => x"4A")

      port map(A => \xmit_bit_sel[0]_net_1\, B => 
        \xmit_state[2]_net_1\, C => xmit_pulse, Y => 
        \xmit_bit_sel_113\);
    
    \xmit_state[1]\ : SLE
      port map(D => \xmit_state_ns[4]_net_1\, CLK => FAB_CCC_GL0, 
        EN => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_state[1]_net_1\);
    
    \xmit_bit_sel[0]\ : SLE
      port map(D => \xmit_bit_sel_113\, CLK => FAB_CCC_GL0, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_bit_sel[0]_net_1\);
    
    \xmit_state_RNO[2]\ : CFG4
      generic map(INIT => x"F7C0")

      port map(A => N_175, B => xmit_pulse, C => 
        \xmit_state[3]_net_1\, D => \xmit_state[2]_net_1\, Y => 
        N_118_i);
    
    \tx_byte[2]\ : SLE
      port map(D => tx_hold_reg(2), CLK => FAB_CCC_GL0, EN => 
        N_136_i, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \tx_byte[2]_net_1\);
    
    \xmit_state_ns[0]\ : CFG4
      generic map(INIT => x"ECA0")

      port map(A => \xmit_state[5]_net_1\, B => 
        \xmit_state[0]_net_1\, C => \CoreUARTapb_0_TXRDY\, D => 
        xmit_pulse, Y => \xmit_state_ns[0]_net_1\);
    
    \tx_byte[1]\ : SLE
      port map(D => tx_hold_reg(1), CLK => FAB_CCC_GL0, EN => 
        N_136_i, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \tx_byte[1]_net_1\);
    
    \xmit_state[4]\ : SLE
      port map(D => \xmit_state_ns[1]\, CLK => FAB_CCC_GL0, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \xmit_state[4]_net_1\);
    
    \xmit_bit_sel_RNO[3]\ : CFG4
      generic map(INIT => x"82A0")

      port map(A => \xmit_state[2]_net_1\, B => N_57, C => 
        \xmit_bit_sel[3]_net_1\, D => \xmit_bit_sel[2]_net_1\, Y
         => N_131_i);
    
    \xmit_state_RNII0DL[3]\ : CFG2
      generic map(INIT => x"8")

      port map(A => xmit_pulse, B => \xmit_state[3]_net_1\, Y => 
        N_136_i);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity SF2_MSS_sys_sb_CoreUARTapb_0_Rx_async is

    port( controlReg2               : in    std_logic_vector(2 downto 0);
          data_out                  : out   std_logic_vector(7 downto 0);
          RX_c                      : in    std_logic;
          CoreUARTapb_0_OVERFLOW    : out   std_logic;
          CoreUARTapb_0_FRAMING_ERR : out   std_logic;
          stop_strobe               : out   std_logic;
          baud_clock                : in    std_logic;
          clear_parity              : in    std_logic;
          receive_full              : out   std_logic;
          CoreUARTapb_0_PARITY_ERR  : out   std_logic;
          FAB_CCC_GL0               : in    std_logic;
          MSS_READY                 : in    std_logic
        );

end SF2_MSS_sys_sb_CoreUARTapb_0_Rx_async;

architecture DEF_ARCH of SF2_MSS_sys_sb_CoreUARTapb_0_Rx_async is 

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \rx_bit_cnt[1]_net_1\, VCC_net_1, \rx_bit_cnt_4[1]\, 
        GND_net_1, \rx_bit_cnt[2]_net_1\, \rx_bit_cnt_4[2]\, 
        \rx_bit_cnt[3]_net_1\, \rx_bit_cnt_4[3]\, 
        \samples[2]_net_1\, \samples_78\, \rx_shift[0]_net_1\, 
        \rx_shift_12[0]\, \un1_samples8_1_0\, \rx_shift[1]_net_1\, 
        \rx_shift_12[1]\, \rx_shift[2]_net_1\, \rx_shift_12[2]\, 
        \rx_shift[3]_net_1\, \rx_shift_12[3]\, 
        \rx_shift[4]_net_1\, \rx_shift_12[4]\, 
        \rx_shift[5]_net_1\, \rx_shift_12[5]\, 
        \rx_shift[6]_net_1\, \rx_shift_12[6]\, 
        \rx_shift[7]_net_1\, \rx_shift_12[7]\, 
        \rx_shift[8]_net_1\, \rx_shift_12[8]\, 
        \receive_count[0]_net_1\, \receive_count_95\, 
        \receive_count[1]_net_1\, \receive_count_96\, 
        \receive_count[2]_net_1\, \receive_count_97\, 
        \receive_count[3]_net_1\, \receive_count_98\, 
        \rx_bit_cnt[0]_net_1\, \rx_bit_cnt_4[0]\, 
        \rx_byte_xhdl5_1_sqmuxa\, \rx_byte_xhdl5_2[7]\, 
        \samples[0]_net_1\, \samples_76\, \samples[1]_net_1\, 
        \samples_77\, parity_err_xhdl2_9, 
        \parity_err_xhdl2_1_sqmuxa_i\, \receive_full\, 
        \un1_receive_full_int_1_sqmuxa_i_0\, \rx_parity_calc\, 
        rx_parity_calc_3, \framing_error_int\, 
        framing_error_int_0_sqmuxa, \overflow_int\, 
        overflow_int_3, framing_error_int_2_sqmuxa, 
        \framing_error_i_0_sqmuxa\, un1_framing_error_i4_i, 
        \overflow_xhdl1_1_sqmuxa_i\, \last_bit[0]_net_1\, 
        N_55_i_i, un30_baud_clock, \last_bit[1]_net_1\, 
        clear_parity_en_xhdl3_1_sqmuxa, \last_bit[3]_net_1\, 
        clear_parity_en_xhdl3_1_sqmuxa_i, \rx_state[1]_net_1\, 
        N_135_mux, \rx_state[0]_net_1\, \rx_state_RNO[0]_net_1\, 
        N_23_mux, CO1, rx_bit_cnt_0_sqmuxa, N_247, 
        \rx_state_d[2]\, \un1_receive_full_int_1_sqmuxa_i_0_1\, 
        N_79, N_81_5, \rx_shift_9_3_1_1[7]\, rx_filtered, 
        \rx_shift_9[7]\, un47_baud_clock_NE_i_1, un47_baud_clock, 
        \rx_state_108_2_1\, \rx_state_108_2\, \rx_state_108_3\, 
        i5_mux, N_79_1, rx_state_150_d, N_230, N_135, 
        \rx_state_d[3]\, N_19, 
        \framing_error_int_0_sqmuxa_0_a4_2\, 
        \receive_count_3_i_a2_1[0]\, N_24_mux, 
        \un1_receive_full_int_1_sqmuxa_i_a2_2\, N_260, N_89, 
        \un1_parity_err_xhdl222_1\, \receive_count_3_i_0[3]\, 
        rx_parity_calc_1, rx_bit_cnt_1_sqmuxa, un79_baud_clock, 
        un1_parity_err_xhdl2_0_sqmuxa_i, 
        un1_parity_err_xhdl2_0_sqmuxa_1_i, N_229 : std_logic;

begin 

    receive_full <= \receive_full\;

    \rx_par_calc.un79_baud_clock\ : CFG2
      generic map(INIT => x"8")

      port map(A => N_23_mux, B => controlReg2(1), Y => 
        un79_baud_clock);
    
    \rx_byte_xhdl5[0]\ : SLE
      port map(D => \rx_shift[0]_net_1\, CLK => FAB_CCC_GL0, EN
         => \rx_byte_xhdl5_1_sqmuxa\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => data_out(0));
    
    un1_parity_err_xhdl2_0_sqmuxa_1_0_a4_0 : CFG4
      generic map(INIT => x"1000")

      port map(A => \rx_bit_cnt[1]_net_1\, B => 
        \rx_bit_cnt[0]_net_1\, C => controlReg2(0), D => N_79_1, 
        Y => N_89);
    
    overflow_int : SLE
      port map(D => overflow_int_3, CLK => FAB_CCC_GL0, EN => 
        baud_clock, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \overflow_int\);
    
    un1_receive_full_int_1_sqmuxa_i_a2 : CFG4
      generic map(INIT => x"9020")

      port map(A => controlReg2(0), B => \rx_bit_cnt[0]_net_1\, C
         => \un1_receive_full_int_1_sqmuxa_i_a2_2\, D => 
        controlReg2(1), Y => N_79);
    
    \samples[0]\ : SLE
      port map(D => \samples_76\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => GND_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \samples[0]_net_1\);
    
    \rx_shift[2]\ : SLE
      port map(D => \rx_shift_12[2]\, CLK => FAB_CCC_GL0, EN => 
        \un1_samples8_1_0\, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \rx_shift[2]_net_1\);
    
    \rx_byte_xhdl5[6]\ : SLE
      port map(D => \rx_shift[6]_net_1\, CLK => FAB_CCC_GL0, EN
         => \rx_byte_xhdl5_1_sqmuxa\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => data_out(6));
    
    \receive_count[1]\ : SLE
      port map(D => \receive_count_96\, CLK => FAB_CCC_GL0, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \receive_count[1]_net_1\);
    
    \make_parity_err.parity_err_xhdl2_9_iv\ : CFG4
      generic map(INIT => x"B080")

      port map(A => un1_parity_err_xhdl2_0_sqmuxa_1_i, B => 
        rx_parity_calc_1, C => clear_parity, D => 
        un1_parity_err_xhdl2_0_sqmuxa_i, Y => parity_err_xhdl2_9);
    
    \rx_state_RNO_0[1]\ : CFG2
      generic map(INIT => x"8")

      port map(A => baud_clock, B => \rx_state[0]_net_1\, Y => 
        N_135);
    
    \rx_shift[7]\ : SLE
      port map(D => \rx_shift_12[7]\, CLK => FAB_CCC_GL0, EN => 
        \un1_samples8_1_0\, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \rx_shift[7]_net_1\);
    
    un1_receive_full_int_1_sqmuxa_i_a2_2 : CFG4
      generic map(INIT => x"0800")

      port map(A => N_79_1, B => \rx_state_d[2]\, C => 
        \rx_bit_cnt[1]_net_1\, D => baud_clock, Y => 
        \un1_receive_full_int_1_sqmuxa_i_a2_2\);
    
    framing_error_int_0_sqmuxa_0_a4 : CFG3
      generic map(INIT => x"40")

      port map(A => rx_filtered, B => rx_state_150_d, C => 
        \framing_error_int_0_sqmuxa_0_a4_2\, Y => 
        framing_error_int_0_sqmuxa);
    
    \rx_shift[0]\ : SLE
      port map(D => \rx_shift_12[0]\, CLK => FAB_CCC_GL0, EN => 
        \un1_samples8_1_0\, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \rx_shift[0]_net_1\);
    
    \rcv_cnt.receive_count_3_i_a2_1_0[0]\ : CFG3
      generic map(INIT => x"08")

      port map(A => \rx_state[1]_net_1\, B => \rx_state[0]_net_1\, 
        C => \receive_count[3]_net_1\, Y => 
        \receive_count_3_i_a2_1[0]\);
    
    rx_byte_xhdl5_1_sqmuxa : CFG4
      generic map(INIT => x"0800")

      port map(A => \rx_state_d[2]\, B => un47_baud_clock, C => 
        \receive_full\, D => baud_clock, Y => 
        \rx_byte_xhdl5_1_sqmuxa\);
    
    \receive_shift.rx_shift_12[0]\ : CFG2
      generic map(INIT => x"4")

      port map(A => \rx_state_d[3]\, B => \rx_shift[1]_net_1\, Y
         => \rx_shift_12[0]\);
    
    framing_error_i : SLE
      port map(D => \framing_error_i_0_sqmuxa\, CLK => 
        FAB_CCC_GL0, EN => un1_framing_error_i4_i, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreUARTapb_0_FRAMING_ERR);
    
    \un1_rx_bit_cnt_1_1.CO1\ : CFG4
      generic map(INIT => x"8000")

      port map(A => \rx_bit_cnt[0]_net_1\, B => 
        \rx_bit_cnt[1]_net_1\, C => N_23_mux, D => baud_clock, Y
         => CO1);
    
    un1_receive_full_int_1_sqmuxa_i_0 : CFG4
      generic map(INIT => x"F8FF")

      port map(A => \rx_state_d[2]\, B => 
        \un1_receive_full_int_1_sqmuxa_i_0_1\, C => N_79, D => 
        clear_parity, Y => \un1_receive_full_int_1_sqmuxa_i_0\);
    
    \rx_byte_xhdl5[7]\ : SLE
      port map(D => \rx_byte_xhdl5_2[7]\, CLK => FAB_CCC_GL0, EN
         => \rx_byte_xhdl5_1_sqmuxa\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => data_out(7));
    
    \receive_shift.rx_shift_9_3[7]\ : CFG4
      generic map(INIT => x"6F09")

      port map(A => controlReg2(0), B => controlReg2(1), C => 
        \rx_shift_9_3_1_1[7]\, D => rx_filtered, Y => 
        \rx_shift_9[7]\);
    
    \receive_count[3]\ : SLE
      port map(D => \receive_count_98\, CLK => FAB_CCC_GL0, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \receive_count[3]_net_1\);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \rcv_sm.overflow_int_3\ : CFG3
      generic map(INIT => x"80")

      port map(A => \receive_full\, B => \rx_state_d[2]\, C => 
        un47_baud_clock, Y => overflow_int_3);
    
    rx_parity_calc : SLE
      port map(D => rx_parity_calc_3, CLK => FAB_CCC_GL0, EN => 
        baud_clock, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \rx_parity_calc\);
    
    \rx_bit_cnt[2]\ : SLE
      port map(D => \rx_bit_cnt_4[2]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \rx_bit_cnt[2]_net_1\);
    
    \receive_shift.rx_bit_cnt_4[3]\ : CFG4
      generic map(INIT => x"006C")

      port map(A => \rx_bit_cnt[2]_net_1\, B => 
        \rx_bit_cnt[3]_net_1\, C => CO1, D => rx_bit_cnt_0_sqmuxa, 
        Y => \rx_bit_cnt_4[3]\);
    
    rx_bit_cnt_0_sqmuxa_0_a2 : CFG3
      generic map(INIT => x"10")

      port map(A => \rx_state[0]_net_1\, B => \rx_state[1]_net_1\, 
        C => baud_clock, Y => rx_bit_cnt_0_sqmuxa);
    
    \rx_bit_cnt[1]\ : SLE
      port map(D => \rx_bit_cnt_4[1]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \rx_bit_cnt[1]_net_1\);
    
    receive_count_95 : CFG4
      generic map(INIT => x"01F0")

      port map(A => un30_baud_clock, B => N_229, C => 
        \receive_count[0]_net_1\, D => baud_clock, Y => 
        \receive_count_95\);
    
    rx_state_s2_0_a2 : CFG2
      generic map(INIT => x"4")

      port map(A => \rx_state[0]_net_1\, B => \rx_state[1]_net_1\, 
        Y => rx_state_150_d);
    
    rx_state_s0_0_a2 : CFG2
      generic map(INIT => x"1")

      port map(A => \rx_state[0]_net_1\, B => \rx_state[1]_net_1\, 
        Y => \rx_state_d[3]\);
    
    parity_err_xhdl2_1_sqmuxa_i : CFG4
      generic map(INIT => x"54FF")

      port map(A => \un1_parity_err_xhdl222_1\, B => 
        un1_parity_err_xhdl2_0_sqmuxa_1_i, C => 
        un1_parity_err_xhdl2_0_sqmuxa_i, D => clear_parity, Y => 
        \parity_err_xhdl2_1_sqmuxa_i\);
    
    \receive_shift.rx_shift_12[8]\ : CFG4
      generic map(INIT => x"0D08")

      port map(A => N_19, B => \rx_shift[8]_net_1\, C => 
        \rx_state_d[3]\, D => rx_filtered, Y => \rx_shift_12[8]\);
    
    \rcv_cnt.receive_count_3_i_0[3]\ : CFG4
      generic map(INIT => x"F3F9")

      port map(A => \receive_count[2]_net_1\, B => 
        \receive_count[3]_net_1\, C => N_260, D => N_230, Y => 
        \receive_count_3_i_0[3]\);
    
    un1_parity_err_xhdl222_1 : CFG3
      generic map(INIT => x"7F")

      port map(A => baud_clock, B => N_23_mux, C => 
        controlReg2(1), Y => \un1_parity_err_xhdl222_1\);
    
    \rcv_cnt.receive_count_3_i_a4[3]\ : CFG4
      generic map(INIT => x"E800")

      port map(A => \samples[0]_net_1\, B => \samples[1]_net_1\, 
        C => \samples[2]_net_1\, D => rx_bit_cnt_0_sqmuxa, Y => 
        N_247);
    
    rx_state_108_3 : CFG4
      generic map(INIT => x"BC8C")

      port map(A => i5_mux, B => \rx_state_108_2\, C => 
        \rx_state[1]_net_1\, D => N_23_mux, Y => \rx_state_108_3\);
    
    \samples[1]\ : SLE
      port map(D => \samples_77\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => GND_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \samples[1]_net_1\);
    
    \rx_state_RNO[1]\ : CFG4
      generic map(INIT => x"E6C4")

      port map(A => N_135, B => \rx_state[1]_net_1\, C => i5_mux, 
        D => un47_baud_clock, Y => N_135_mux);
    
    receive_count_97 : CFG4
      generic map(INIT => x"21F0")

      port map(A => N_230, B => N_229, C => 
        \receive_count[2]_net_1\, D => baud_clock, Y => 
        \receive_count_97\);
    
    \receive_count[2]\ : SLE
      port map(D => \receive_count_97\, CLK => FAB_CCC_GL0, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \receive_count[2]_net_1\);
    
    stop_strobe_i : SLE
      port map(D => framing_error_int_2_sqmuxa, CLK => 
        FAB_CCC_GL0, EN => baud_clock, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => stop_strobe);
    
    rx_state_108_2_1 : CFG4
      generic map(INIT => x"0002")

      port map(A => \receive_count[3]_net_1\, B => 
        \receive_count[2]_net_1\, C => \receive_count[1]_net_1\, 
        D => \receive_count[0]_net_1\, Y => \rx_state_108_2_1\);
    
    \receive_shift.rx_shift_12[2]\ : CFG2
      generic map(INIT => x"4")

      port map(A => \rx_state_d[3]\, B => \rx_shift[3]_net_1\, Y
         => \rx_shift_12[2]\);
    
    \receive_shift.rx_shift_12[5]\ : CFG2
      generic map(INIT => x"4")

      port map(A => \rx_state_d[3]\, B => \rx_shift[6]_net_1\, Y
         => \rx_shift_12[5]\);
    
    \rx_state[1]\ : SLE
      port map(D => N_135_mux, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \rx_state[1]_net_1\);
    
    framing_error_i_0_sqmuxa : CFG2
      generic map(INIT => x"8")

      port map(A => baud_clock, B => \framing_error_int\, Y => 
        \framing_error_i_0_sqmuxa\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \rx_shift[4]\ : SLE
      port map(D => \rx_shift_12[4]\, CLK => FAB_CCC_GL0, EN => 
        \un1_samples8_1_0\, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \rx_shift[4]_net_1\);
    
    \last_bit_RNO[0]\ : CFG2
      generic map(INIT => x"9")

      port map(A => controlReg2(1), B => controlReg2(0), Y => 
        N_55_i_i);
    
    \rx_par_calc.rx_parity_calc_3_u\ : CFG4
      generic map(INIT => x"1222")

      port map(A => \rx_parity_calc\, B => rx_state_150_d, C => 
        rx_filtered, D => un79_baud_clock, Y => rx_parity_calc_3);
    
    \rx_par_calc.rx_parity_calc_1\ : CFG2
      generic map(INIT => x"6")

      port map(A => rx_filtered, B => \rx_parity_calc\, Y => 
        rx_parity_calc_1);
    
    clear_parity_en_xhdl3_1_sqmuxa_0_a2 : CFG2
      generic map(INIT => x"1")

      port map(A => controlReg2(1), B => controlReg2(0), Y => 
        clear_parity_en_xhdl3_1_sqmuxa);
    
    rx_filtered_i_o2 : CFG3
      generic map(INIT => x"E8")

      port map(A => \samples[1]_net_1\, B => \samples[0]_net_1\, 
        C => \samples[2]_net_1\, Y => rx_filtered);
    
    \rcv_sm.rx_byte_xhdl5_2[7]\ : CFG2
      generic map(INIT => x"8")

      port map(A => controlReg2(0), B => \rx_shift[7]_net_1\, Y
         => \rx_byte_xhdl5_2[7]\);
    
    \receive_shift.rx_bit_cnt_4[2]\ : CFG3
      generic map(INIT => x"12")

      port map(A => \rx_bit_cnt[2]_net_1\, B => 
        rx_bit_cnt_0_sqmuxa, C => CO1, Y => \rx_bit_cnt_4[2]\);
    
    framing_error_int_2_sqmuxa_0_a4 : CFG2
      generic map(INIT => x"8")

      port map(A => N_23_mux, B => rx_state_150_d, Y => 
        framing_error_int_2_sqmuxa);
    
    \last_bit[3]\ : SLE
      port map(D => clear_parity_en_xhdl3_1_sqmuxa_i, CLK => 
        FAB_CCC_GL0, EN => un30_baud_clock, ALn => MSS_READY, ADn
         => GND_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \last_bit[3]_net_1\);
    
    \rx_state_ns_1_0_.m10\ : CFG4
      generic map(INIT => x"0040")

      port map(A => \receive_count[3]_net_1\, B => 
        \receive_count[2]_net_1\, C => \receive_count[1]_net_1\, 
        D => \receive_count[0]_net_1\, Y => N_24_mux);
    
    \receive_shift.rx_shift_12[1]\ : CFG2
      generic map(INIT => x"4")

      port map(A => \rx_state_d[3]\, B => \rx_shift[2]_net_1\, Y
         => \rx_shift_12[1]\);
    
    un1_parity_err_xhdl2_0_sqmuxa_1_0_a4_3 : CFG4
      generic map(INIT => x"4000")

      port map(A => \rx_bit_cnt[3]_net_1\, B => 
        \rx_bit_cnt[2]_net_1\, C => \rx_bit_cnt[1]_net_1\, D => 
        \rx_bit_cnt[0]_net_1\, Y => N_81_5);
    
    \make_last_bit.un30_baud_clock_0_a4\ : CFG2
      generic map(INIT => x"8")

      port map(A => N_260, B => \receive_count[3]_net_1\, Y => 
        un30_baud_clock);
    
    receive_full_int : SLE
      port map(D => clear_parity, CLK => FAB_CCC_GL0, EN => 
        \un1_receive_full_int_1_sqmuxa_i_0\, ALn => MSS_READY, 
        ADn => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT
         => GND_net_1, Q => \receive_full\);
    
    framing_error_i_RNO : CFG3
      generic map(INIT => x"D5")

      port map(A => clear_parity, B => \framing_error_int\, C => 
        baud_clock, Y => un1_framing_error_i4_i);
    
    framing_error_int_0_sqmuxa_0_a4_2 : CFG4
      generic map(INIT => x"0080")

      port map(A => \receive_count[3]_net_1\, B => 
        \receive_count[2]_net_1\, C => \receive_count[1]_net_1\, 
        D => \receive_count[0]_net_1\, Y => 
        \framing_error_int_0_sqmuxa_0_a4_2\);
    
    un1_parity_err_xhdl2_0_sqmuxa_0_a2 : CFG4
      generic map(INIT => x"AA20")

      port map(A => controlReg2(2), B => controlReg2(0), C => 
        N_81_5, D => N_89, Y => un1_parity_err_xhdl2_0_sqmuxa_i);
    
    clear_parity_en_xhdl3_1_sqmuxa_0_a2_i : CFG2
      generic map(INIT => x"E")

      port map(A => controlReg2(1), B => controlReg2(0), Y => 
        clear_parity_en_xhdl3_1_sqmuxa_i);
    
    parity_err_xhdl2 : SLE
      port map(D => parity_err_xhdl2_9, CLK => FAB_CCC_GL0, EN
         => \parity_err_xhdl2_1_sqmuxa_i\, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => CoreUARTapb_0_PARITY_ERR);
    
    samples_77 : CFG3
      generic map(INIT => x"AC")

      port map(A => \samples[2]_net_1\, B => \samples[1]_net_1\, 
        C => baud_clock, Y => \samples_77\);
    
    \rx_byte_xhdl5[4]\ : SLE
      port map(D => \rx_shift[4]_net_1\, CLK => FAB_CCC_GL0, EN
         => \rx_byte_xhdl5_1_sqmuxa\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => data_out(4));
    
    \rcv_cnt.receive_count_3_i_o4[0]\ : CFG4
      generic map(INIT => x"FF80")

      port map(A => \receive_count[2]_net_1\, B => 
        \receive_count[1]_net_1\, C => 
        \receive_count_3_i_a2_1[0]\, D => N_247, Y => N_229);
    
    \rx_shift[6]\ : SLE
      port map(D => \rx_shift_12[6]\, CLK => FAB_CCC_GL0, EN => 
        \un1_samples8_1_0\, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \rx_shift[6]_net_1\);
    
    clear_parity_en_xhdl3_0_sqmuxa_i : CFG2
      generic map(INIT => x"7")

      port map(A => controlReg2(1), B => controlReg2(0), Y => 
        N_19);
    
    \rx_state_RNO[0]\ : CFG3
      generic map(INIT => x"E2")

      port map(A => \rx_state[0]_net_1\, B => baud_clock, C => 
        \rx_state_108_3\, Y => \rx_state_RNO[0]_net_1\);
    
    \rx_shift[1]\ : SLE
      port map(D => \rx_shift_12[1]\, CLK => FAB_CCC_GL0, EN => 
        \un1_samples8_1_0\, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \rx_shift[1]_net_1\);
    
    samples_78 : CFG3
      generic map(INIT => x"D8")

      port map(A => baud_clock, B => RX_c, C => 
        \samples[2]_net_1\, Y => \samples_78\);
    
    \rx_shift[3]\ : SLE
      port map(D => \rx_shift_12[3]\, CLK => FAB_CCC_GL0, EN => 
        \un1_samples8_1_0\, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \rx_shift[3]_net_1\);
    
    framing_error_int : SLE
      port map(D => framing_error_int_0_sqmuxa, CLK => 
        FAB_CCC_GL0, EN => baud_clock, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \framing_error_int\);
    
    \rx_byte_xhdl5[2]\ : SLE
      port map(D => \rx_shift[2]_net_1\, CLK => FAB_CCC_GL0, EN
         => \rx_byte_xhdl5_1_sqmuxa\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => data_out(2));
    
    overflow_xhdl1_1_sqmuxa_i : CFG3
      generic map(INIT => x"D5")

      port map(A => clear_parity, B => \overflow_int\, C => 
        baud_clock, Y => \overflow_xhdl1_1_sqmuxa_i\);
    
    \rx_state[0]\ : SLE
      port map(D => \rx_state_RNO[0]_net_1\, CLK => FAB_CCC_GL0, 
        EN => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \rx_state[0]_net_1\);
    
    \samples[2]\ : SLE
      port map(D => \samples_78\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => GND_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \samples[2]_net_1\);
    
    rx_state_108_2 : CFG4
      generic map(INIT => x"F30A")

      port map(A => \rx_state_108_2_1\, B => un47_baud_clock, C
         => \rx_state[1]_net_1\, D => \rx_state[0]_net_1\, Y => 
        \rx_state_108_2\);
    
    \receive_shift.rx_shift_12[6]\ : CFG4
      generic map(INIT => x"0E04")

      port map(A => clear_parity_en_xhdl3_1_sqmuxa, B => 
        \rx_shift[7]_net_1\, C => \rx_state_d[3]\, D => 
        rx_filtered, Y => \rx_shift_12[6]\);
    
    un1_samples8_1_0 : CFG3
      generic map(INIT => x"F8")

      port map(A => baud_clock, B => N_23_mux, C => 
        rx_bit_cnt_0_sqmuxa, Y => \un1_samples8_1_0\);
    
    un1_receive_full_int_1_sqmuxa_i_a2_1_0 : CFG2
      generic map(INIT => x"4")

      port map(A => \rx_bit_cnt[2]_net_1\, B => 
        \rx_bit_cnt[3]_net_1\, Y => N_79_1);
    
    \receive_count[0]\ : SLE
      port map(D => \receive_count_95\, CLK => FAB_CCC_GL0, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \receive_count[0]_net_1\);
    
    \last_bit[1]\ : SLE
      port map(D => clear_parity_en_xhdl3_1_sqmuxa, CLK => 
        FAB_CCC_GL0, EN => un30_baud_clock, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \last_bit[1]_net_1\);
    
    \rx_state_ns_1_0_.m14\ : CFG4
      generic map(INIT => x"0107")

      port map(A => \samples[2]_net_1\, B => \samples[0]_net_1\, 
        C => N_24_mux, D => \samples[1]_net_1\, Y => i5_mux);
    
    \rx_byte_xhdl5[3]\ : SLE
      port map(D => \rx_shift[3]_net_1\, CLK => FAB_CCC_GL0, EN
         => \rx_byte_xhdl5_1_sqmuxa\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => data_out(3));
    
    \receive_shift.rx_shift_12[4]\ : CFG2
      generic map(INIT => x"4")

      port map(A => \rx_state_d[3]\, B => \rx_shift[5]_net_1\, Y
         => \rx_shift_12[4]\);
    
    \receive_shift.rx_bit_cnt_4[0]\ : CFG3
      generic map(INIT => x"12")

      port map(A => \rx_bit_cnt[0]_net_1\, B => 
        rx_bit_cnt_0_sqmuxa, C => rx_bit_cnt_1_sqmuxa, Y => 
        \rx_bit_cnt_4[0]\);
    
    \receive_shift.rx_shift_12[3]\ : CFG2
      generic map(INIT => x"4")

      port map(A => \rx_state_d[3]\, B => \rx_shift[4]_net_1\, Y
         => \rx_shift_12[3]\);
    
    \rx_shift[5]\ : SLE
      port map(D => \rx_shift_12[5]\, CLK => FAB_CCC_GL0, EN => 
        \un1_samples8_1_0\, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \rx_shift[5]_net_1\);
    
    \receive_shift.rx_shift_9_3_1_1[7]\ : CFG3
      generic map(INIT => x"53")

      port map(A => \rx_shift[8]_net_1\, B => \rx_shift[7]_net_1\, 
        C => controlReg2(1), Y => \rx_shift_9_3_1_1[7]\);
    
    \rcv_cnt.receive_count_3_i_a2[3]\ : CFG4
      generic map(INIT => x"0004")

      port map(A => \receive_count[0]_net_1\, B => 
        rx_bit_cnt_0_sqmuxa, C => \receive_count[2]_net_1\, D => 
        \receive_count[1]_net_1\, Y => N_260);
    
    \rcv_cnt.receive_count_3_i_o2[1]\ : CFG2
      generic map(INIT => x"7")

      port map(A => \receive_count[0]_net_1\, B => 
        \receive_count[1]_net_1\, Y => N_230);
    
    un1_receive_full_int_1_sqmuxa_i_0_1 : CFG4
      generic map(INIT => x"1000")

      port map(A => controlReg2(1), B => controlReg2(0), C => 
        N_81_5, D => baud_clock, Y => 
        \un1_receive_full_int_1_sqmuxa_i_0_1\);
    
    \rx_bit_cnt[0]\ : SLE
      port map(D => \rx_bit_cnt_4[0]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \rx_bit_cnt[0]_net_1\);
    
    \rx_shift[8]\ : SLE
      port map(D => \rx_shift_12[8]\, CLK => FAB_CCC_GL0, EN => 
        \un1_samples8_1_0\, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \rx_shift[8]_net_1\);
    
    \rx_byte_xhdl5[1]\ : SLE
      port map(D => \rx_shift[1]_net_1\, CLK => FAB_CCC_GL0, EN
         => \rx_byte_xhdl5_1_sqmuxa\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => data_out(1));
    
    \last_bit_RNIMH261[0]\ : CFG4
      generic map(INIT => x"7BDE")

      port map(A => \last_bit[3]_net_1\, B => \last_bit[0]_net_1\, 
        C => \rx_bit_cnt[3]_net_1\, D => \rx_bit_cnt[0]_net_1\, Y
         => un47_baud_clock_NE_i_1);
    
    \last_bit[0]\ : SLE
      port map(D => N_55_i_i, CLK => FAB_CCC_GL0, EN => 
        un30_baud_clock, ALn => MSS_READY, ADn => GND_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \last_bit[0]_net_1\);
    
    \rx_state_ns_1_0_.m8\ : CFG4
      generic map(INIT => x"8000")

      port map(A => \receive_count[0]_net_1\, B => 
        \receive_count[1]_net_1\, C => \receive_count[2]_net_1\, 
        D => \receive_count[3]_net_1\, Y => N_23_mux);
    
    rx_bit_cnt_1_sqmuxa_0_a4 : CFG2
      generic map(INIT => x"8")

      port map(A => N_23_mux, B => baud_clock, Y => 
        rx_bit_cnt_1_sqmuxa);
    
    un1_parity_err_xhdl2_0_sqmuxa_1_0_a2 : CFG4
      generic map(INIT => x"5510")

      port map(A => controlReg2(2), B => controlReg2(0), C => 
        N_81_5, D => N_89, Y => un1_parity_err_xhdl2_0_sqmuxa_1_i);
    
    receive_count_98 : CFG4
      generic map(INIT => x"11F0")

      port map(A => N_247, B => \receive_count_3_i_0[3]\, C => 
        \receive_count[3]_net_1\, D => baud_clock, Y => 
        \receive_count_98\);
    
    \receive_shift.rx_shift_12[7]\ : CFG2
      generic map(INIT => x"2")

      port map(A => \rx_shift_9[7]\, B => \rx_state_d[3]\, Y => 
        \rx_shift_12[7]\);
    
    samples_76 : CFG3
      generic map(INIT => x"B8")

      port map(A => \samples[1]_net_1\, B => baud_clock, C => 
        \samples[0]_net_1\, Y => \samples_76\);
    
    \rx_byte_xhdl5[5]\ : SLE
      port map(D => \rx_shift[5]_net_1\, CLK => FAB_CCC_GL0, EN
         => \rx_byte_xhdl5_1_sqmuxa\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => data_out(5));
    
    \rx_bit_cnt[3]\ : SLE
      port map(D => \rx_bit_cnt_4[3]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \rx_bit_cnt[3]_net_1\);
    
    \last_bit_RNIRE352[1]\ : CFG4
      generic map(INIT => x"2001")

      port map(A => \rx_bit_cnt[1]_net_1\, B => 
        un47_baud_clock_NE_i_1, C => \last_bit[1]_net_1\, D => 
        \rx_bit_cnt[2]_net_1\, Y => un47_baud_clock);
    
    receive_count_96 : CFG4
      generic map(INIT => x"06CC")

      port map(A => \receive_count[0]_net_1\, B => 
        \receive_count[1]_net_1\, C => N_229, D => baud_clock, Y
         => \receive_count_96\);
    
    overflow_xhdl1 : SLE
      port map(D => clear_parity, CLK => FAB_CCC_GL0, EN => 
        \overflow_xhdl1_1_sqmuxa_i\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => CoreUARTapb_0_OVERFLOW);
    
    rx_state_s1_0_a4 : CFG2
      generic map(INIT => x"2")

      port map(A => \rx_state[0]_net_1\, B => \rx_state[1]_net_1\, 
        Y => \rx_state_d[2]\);
    
    \receive_shift.rx_bit_cnt_4[1]\ : CFG4
      generic map(INIT => x"006C")

      port map(A => \rx_bit_cnt[0]_net_1\, B => 
        \rx_bit_cnt[1]_net_1\, C => rx_bit_cnt_1_sqmuxa, D => 
        rx_bit_cnt_0_sqmuxa, Y => \rx_bit_cnt_4[1]\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity SF2_MSS_sys_sb_CoreUARTapb_0_COREUART is

    port( data_out                      : out   std_logic_vector(7 downto 0);
          controlReg2                   : in    std_logic_vector(7 downto 0);
          controlReg1                   : in    std_logic_vector(7 downto 0);
          CoreAPB3_0_APBmslave0_PADDR   : in    std_logic_vector(4 downto 2);
          CoreAPB3_0_APBmslave0_PWDATA  : in    std_logic_vector(7 downto 0);
          CoreUARTapb_0_PARITY_ERR      : out   std_logic;
          CoreUARTapb_0_FRAMING_ERR     : out   std_logic;
          CoreUARTapb_0_OVERFLOW        : out   std_logic;
          RX_c                          : in    std_logic;
          TX_c                          : out   std_logic;
          CoreUARTapb_0_TXRDY           : out   std_logic;
          CoreAPB3_0_APBmslave2_PSELx   : in    std_logic;
          CoreAPB3_0_APBmslave0_PENABLE : in    std_logic;
          CoreAPB3_0_APBmslave0_PWRITE  : in    std_logic;
          CoreUARTapb_0_RXRDY           : out   std_logic;
          FAB_CCC_GL0                   : in    std_logic;
          MSS_READY                     : in    std_logic
        );

end SF2_MSS_sys_sb_CoreUARTapb_0_COREUART;

architecture DEF_ARCH of SF2_MSS_sys_sb_CoreUARTapb_0_COREUART is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component SF2_MSS_sys_sb_CoreUARTapb_0_Clock_gen
    port( controlReg2 : in    std_logic_vector(7 downto 3) := (others => 'U');
          controlReg1 : in    std_logic_vector(7 downto 0) := (others => 'U');
          xmit_pulse  : out   std_logic;
          baud_clock  : out   std_logic;
          FAB_CCC_GL0 : in    std_logic := 'U';
          MSS_READY   : in    std_logic := 'U'
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component SF2_MSS_sys_sb_CoreUARTapb_0_Tx_async
    port( controlReg2         : in    std_logic_vector(2 downto 0) := (others => 'U');
          tx_hold_reg         : in    std_logic_vector(7 downto 0) := (others => 'U');
          un1_csn             : in    std_logic := 'U';
          un1_csn_i           : in    std_logic := 'U';
          CoreUARTapb_0_TXRDY : out   std_logic;
          TX_c                : out   std_logic;
          xmit_pulse          : in    std_logic := 'U';
          FAB_CCC_GL0         : in    std_logic := 'U';
          MSS_READY           : in    std_logic := 'U'
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component SF2_MSS_sys_sb_CoreUARTapb_0_Rx_async
    port( controlReg2               : in    std_logic_vector(2 downto 0) := (others => 'U');
          data_out                  : out   std_logic_vector(7 downto 0);
          RX_c                      : in    std_logic := 'U';
          CoreUARTapb_0_OVERFLOW    : out   std_logic;
          CoreUARTapb_0_FRAMING_ERR : out   std_logic;
          stop_strobe               : out   std_logic;
          baud_clock                : in    std_logic := 'U';
          clear_parity              : in    std_logic := 'U';
          receive_full              : out   std_logic;
          CoreUARTapb_0_PARITY_ERR  : out   std_logic;
          FAB_CCC_GL0               : in    std_logic := 'U';
          MSS_READY                 : in    std_logic := 'U'
        );
  end component;

    signal \tx_hold_reg[7]_net_1\, VCC_net_1, un1_csn, GND_net_1, 
        \tx_hold_reg[0]_net_1\, \tx_hold_reg[1]_net_1\, 
        \tx_hold_reg[2]_net_1\, \tx_hold_reg[3]_net_1\, 
        \tx_hold_reg[4]_net_1\, \tx_hold_reg[5]_net_1\, 
        \tx_hold_reg[6]_net_1\, receive_full, un1_rx_fifo, 
        un1_csn_0, un1_csn_i, stop_strobe, \un1_temp_xhdl10_1\, 
        clear_parity, xmit_pulse, baud_clock : std_logic;

    for all : SF2_MSS_sys_sb_CoreUARTapb_0_Clock_gen
	Use entity work.SF2_MSS_sys_sb_CoreUARTapb_0_Clock_gen(DEF_ARCH);
    for all : SF2_MSS_sys_sb_CoreUARTapb_0_Tx_async
	Use entity work.SF2_MSS_sys_sb_CoreUARTapb_0_Tx_async(DEF_ARCH);
    for all : SF2_MSS_sys_sb_CoreUARTapb_0_Rx_async
	Use entity work.SF2_MSS_sys_sb_CoreUARTapb_0_Rx_async(DEF_ARCH);
begin 


    \tx_hold_reg[7]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => un1_csn, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \tx_hold_reg[7]_net_1\);
    
    make_SF2_MSS_sys_sb_CoreUARTapb_0_Clock_gen : 
        SF2_MSS_sys_sb_CoreUARTapb_0_Clock_gen
      port map(controlReg2(7) => controlReg2(7), controlReg2(6)
         => controlReg2(6), controlReg2(5) => controlReg2(5), 
        controlReg2(4) => controlReg2(4), controlReg2(3) => 
        controlReg2(3), controlReg1(7) => controlReg1(7), 
        controlReg1(6) => controlReg1(6), controlReg1(5) => 
        controlReg1(5), controlReg1(4) => controlReg1(4), 
        controlReg1(3) => controlReg1(3), controlReg1(2) => 
        controlReg1(2), controlReg1(1) => controlReg1(1), 
        controlReg1(0) => controlReg1(0), xmit_pulse => 
        xmit_pulse, baud_clock => baud_clock, FAB_CCC_GL0 => 
        FAB_CCC_GL0, MSS_READY => MSS_READY);
    
    \RXRDY_NEW.un1_rx_fifo\ : CFG2
      generic map(INIT => x"D")

      port map(A => receive_full, B => stop_strobe, Y => 
        un1_rx_fifo);
    
    make_TX : SF2_MSS_sys_sb_CoreUARTapb_0_Tx_async
      port map(controlReg2(2) => controlReg2(2), controlReg2(1)
         => controlReg2(1), controlReg2(0) => controlReg2(0), 
        tx_hold_reg(7) => \tx_hold_reg[7]_net_1\, tx_hold_reg(6)
         => \tx_hold_reg[6]_net_1\, tx_hold_reg(5) => 
        \tx_hold_reg[5]_net_1\, tx_hold_reg(4) => 
        \tx_hold_reg[4]_net_1\, tx_hold_reg(3) => 
        \tx_hold_reg[3]_net_1\, tx_hold_reg(2) => 
        \tx_hold_reg[2]_net_1\, tx_hold_reg(1) => 
        \tx_hold_reg[1]_net_1\, tx_hold_reg(0) => 
        \tx_hold_reg[0]_net_1\, un1_csn => un1_csn, un1_csn_i => 
        un1_csn_i, CoreUARTapb_0_TXRDY => CoreUARTapb_0_TXRDY, 
        TX_c => TX_c, xmit_pulse => xmit_pulse, FAB_CCC_GL0 => 
        FAB_CCC_GL0, MSS_READY => MSS_READY);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \tx_hold_reg[5]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => un1_csn, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \tx_hold_reg[5]_net_1\);
    
    \tx_hold_reg[0]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => un1_csn, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \tx_hold_reg[0]_net_1\);
    
    \reg_write.un1_csn\ : CFG4
      generic map(INIT => x"8000")

      port map(A => CoreAPB3_0_APBmslave0_PWRITE, B => 
        CoreAPB3_0_APBmslave0_PENABLE, C => 
        CoreAPB3_0_APBmslave2_PSELx, D => un1_csn_0, Y => un1_csn);
    
    \reg_write.un1_csn_i_0\ : CFG4
      generic map(INIT => x"7FFF")

      port map(A => CoreAPB3_0_APBmslave0_PWRITE, B => 
        CoreAPB3_0_APBmslave0_PENABLE, C => 
        CoreAPB3_0_APBmslave2_PSELx, D => un1_csn_0, Y => 
        un1_csn_i);
    
    \tx_hold_reg[3]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => un1_csn, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \tx_hold_reg[3]_net_1\);
    
    un1_temp_xhdl10 : CFG4
      generic map(INIT => x"FFF7")

      port map(A => \un1_temp_xhdl10_1\, B => 
        CoreAPB3_0_APBmslave2_PSELx, C => 
        CoreAPB3_0_APBmslave0_PADDR(3), D => 
        CoreAPB3_0_APBmslave0_PADDR(4), Y => clear_parity);
    
    \tx_hold_reg[2]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => un1_csn, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \tx_hold_reg[2]_net_1\);
    
    \tx_hold_reg[1]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => un1_csn, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \tx_hold_reg[1]_net_1\);
    
    \reg_write.un1_csn_0_0\ : CFG3
      generic map(INIT => x"01")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        CoreAPB3_0_APBmslave0_PADDR(3), Y => un1_csn_0);
    
    \tx_hold_reg[6]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => un1_csn, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \tx_hold_reg[6]_net_1\);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    un1_temp_xhdl10_1 : CFG3
      generic map(INIT => x"40")

      port map(A => CoreAPB3_0_APBmslave0_PWRITE, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        CoreAPB3_0_APBmslave0_PENABLE, Y => \un1_temp_xhdl10_1\);
    
    \tx_hold_reg[4]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => un1_csn, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \tx_hold_reg[4]_net_1\);
    
    make_RX : SF2_MSS_sys_sb_CoreUARTapb_0_Rx_async
      port map(controlReg2(2) => controlReg2(2), controlReg2(1)
         => controlReg2(1), controlReg2(0) => controlReg2(0), 
        data_out(7) => data_out(7), data_out(6) => data_out(6), 
        data_out(5) => data_out(5), data_out(4) => data_out(4), 
        data_out(3) => data_out(3), data_out(2) => data_out(2), 
        data_out(1) => data_out(1), data_out(0) => data_out(0), 
        RX_c => RX_c, CoreUARTapb_0_OVERFLOW => 
        CoreUARTapb_0_OVERFLOW, CoreUARTapb_0_FRAMING_ERR => 
        CoreUARTapb_0_FRAMING_ERR, stop_strobe => stop_strobe, 
        baud_clock => baud_clock, clear_parity => clear_parity, 
        receive_full => receive_full, CoreUARTapb_0_PARITY_ERR
         => CoreUARTapb_0_PARITY_ERR, FAB_CCC_GL0 => FAB_CCC_GL0, 
        MSS_READY => MSS_READY);
    
    rxrdy_xhdl4 : SLE
      port map(D => receive_full, CLK => FAB_CCC_GL0, EN => 
        un1_rx_fifo, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        CoreUARTapb_0_RXRDY);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity SF2_MSS_sys_sb_CoreUARTapb_0_CoreUARTapb is

    port( CoreAPB3_0_APBmslave0_PADDR   : in    std_logic_vector(4 downto 2);
          CoreAPB3_0_APBmslave2_PRDATA  : out   std_logic_vector(7 downto 0);
          CoreAPB3_0_APBmslave0_PWDATA  : in    std_logic_vector(7 downto 0);
          TX_c                          : out   std_logic;
          RX_c                          : in    std_logic;
          CoreUARTapb_0_OVERFLOW        : out   std_logic;
          CoreUARTapb_0_FRAMING_ERR     : out   std_logic;
          CoreAPB3_0_APBmslave2_PSELx   : in    std_logic;
          CoreAPB3_0_APBmslave0_PENABLE : in    std_logic;
          CoreAPB3_0_APBmslave0_PWRITE  : in    std_logic;
          CoreUARTapb_0_PARITY_ERR      : out   std_logic;
          CoreUARTapb_0_RXRDY           : out   std_logic;
          CoreUARTapb_0_TXRDY           : out   std_logic;
          FAB_CCC_GL0                   : in    std_logic;
          MSS_READY                     : in    std_logic
        );

end SF2_MSS_sys_sb_CoreUARTapb_0_CoreUARTapb;

architecture DEF_ARCH of 
        SF2_MSS_sys_sb_CoreUARTapb_0_CoreUARTapb is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component SF2_MSS_sys_sb_CoreUARTapb_0_COREUART
    port( data_out                      : out   std_logic_vector(7 downto 0);
          controlReg2                   : in    std_logic_vector(7 downto 0) := (others => 'U');
          controlReg1                   : in    std_logic_vector(7 downto 0) := (others => 'U');
          CoreAPB3_0_APBmslave0_PADDR   : in    std_logic_vector(4 downto 2) := (others => 'U');
          CoreAPB3_0_APBmslave0_PWDATA  : in    std_logic_vector(7 downto 0) := (others => 'U');
          CoreUARTapb_0_PARITY_ERR      : out   std_logic;
          CoreUARTapb_0_FRAMING_ERR     : out   std_logic;
          CoreUARTapb_0_OVERFLOW        : out   std_logic;
          RX_c                          : in    std_logic := 'U';
          TX_c                          : out   std_logic;
          CoreUARTapb_0_TXRDY           : out   std_logic;
          CoreAPB3_0_APBmslave2_PSELx   : in    std_logic := 'U';
          CoreAPB3_0_APBmslave0_PENABLE : in    std_logic := 'U';
          CoreAPB3_0_APBmslave0_PWRITE  : in    std_logic := 'U';
          CoreUARTapb_0_RXRDY           : out   std_logic;
          FAB_CCC_GL0                   : in    std_logic := 'U';
          MSS_READY                     : in    std_logic := 'U'
        );
  end component;

    signal \controlReg1[2]_net_1\, VCC_net_1, un5_psel, 
        GND_net_1, \controlReg1[3]_net_1\, \controlReg1[4]_net_1\, 
        \controlReg1[5]_net_1\, \controlReg1[6]_net_1\, 
        \controlReg1[7]_net_1\, \nxtprdata_xhdl7_1[3]\, 
        un1_nxtprdata_xhdl722_i, \nxtprdata_xhdl7_1[4]\, 
        \nxtprdata_xhdl7_1[5]\, \nxtprdata_xhdl7_1[6]\, 
        \nxtprdata_xhdl7_1[7]\, \controlReg2[0]_net_1\, un13_psel, 
        \controlReg2[1]_net_1\, \controlReg2[2]_net_1\, 
        \controlReg2[3]_net_1\, \controlReg2[4]_net_1\, 
        \controlReg2[5]_net_1\, \controlReg2[6]_net_1\, 
        \controlReg2[7]_net_1\, \controlReg1[0]_net_1\, 
        \controlReg1[1]_net_1\, \nxtprdata_xhdl7_1[0]\, 
        \nxtprdata_xhdl7_1[1]\, \nxtprdata_xhdl7_1[2]\, 
        \nxtprdata_xhdl7_1_5_0[1]_net_1\, 
        \nxtprdata_xhdl7_1_5_0[0]_net_1\, 
        \nxtprdata_xhdl7_1_5_0[2]_net_1\, \data_out[7]\, 
        \nxtprdata_xhdl7_1_5_1_0[7]_net_1\, \data_out[6]\, 
        \nxtprdata_xhdl7_1_5_1_0[6]_net_1\, \data_out[5]\, 
        \nxtprdata_xhdl7_1_5_1_0[5]_net_1\, 
        \nxtprdata_xhdl7_1_5_3[2]_net_1\, 
        \nxtprdata_xhdl7_1_5_1[2]_net_1\, N_106, 
        \nxtprdata_xhdl7_1_5_2[2]_net_1\, \data_out[2]\, 
        \nxtprdata_xhdl7_1_5_3[0]_net_1\, 
        \nxtprdata_xhdl7_1_5_1[0]_net_1\, N_104, 
        \nxtprdata_xhdl7_1_5_2[0]_net_1\, \data_out[0]\, 
        \nxtprdata_xhdl7_1_5_3[1]_net_1\, 
        \nxtprdata_xhdl7_1_5_1[1]_net_1\, N_105, 
        \nxtprdata_xhdl7_1_5_2[1]_net_1\, \data_out[1]\, 
        \CoreUARTapb_0_TXRDY\, \CoreUARTapb_0_RXRDY\, 
        \CoreUARTapb_0_PARITY_ERR\, N_75_2, \data_out[4]\, N_63, 
        \data_out[3]\, N_64, \un1_nxtprdata_xhdl722_0\, un3_psel, 
        \CoreUARTapb_0_FRAMING_ERR\, 
        \nxtprdata_xhdl7_1_5_0_0[4]_net_1\, 
        \CoreUARTapb_0_OVERFLOW\, 
        \nxtprdata_xhdl7_1_5_0_0[3]_net_1\ : std_logic;

    for all : SF2_MSS_sys_sb_CoreUARTapb_0_COREUART
	Use entity work.SF2_MSS_sys_sb_CoreUARTapb_0_COREUART(DEF_ARCH);
begin 

    CoreUARTapb_0_OVERFLOW <= \CoreUARTapb_0_OVERFLOW\;
    CoreUARTapb_0_FRAMING_ERR <= \CoreUARTapb_0_FRAMING_ERR\;
    CoreUARTapb_0_PARITY_ERR <= \CoreUARTapb_0_PARITY_ERR\;
    CoreUARTapb_0_RXRDY <= \CoreUARTapb_0_RXRDY\;
    CoreUARTapb_0_TXRDY <= \CoreUARTapb_0_TXRDY\;

    \controlReg1[5]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => un5_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg1[5]_net_1\);
    
    \nxtprdata_xhdl7_1_5_1_0[5]\ : CFG4
      generic map(INIT => x"503F")

      port map(A => \controlReg2[5]_net_1\, B => 
        \controlReg1[5]_net_1\, C => 
        CoreAPB3_0_APBmslave0_PADDR(3), D => 
        CoreAPB3_0_APBmslave0_PADDR(2), Y => 
        \nxtprdata_xhdl7_1_5_1_0[5]_net_1\);
    
    \controlReg1[7]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => un5_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg1[7]_net_1\);
    
    \nxtprdata_xhdl7_1_5_0[0]\ : CFG3
      generic map(INIT => x"C8")

      port map(A => \controlReg1[0]_net_1\, B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => 
        CoreAPB3_0_APBmslave0_PADDR(2), Y => 
        \nxtprdata_xhdl7_1_5_0[0]_net_1\);
    
    \iPRDATA[1]\ : SLE
      port map(D => \nxtprdata_xhdl7_1[1]\, CLK => FAB_CCC_GL0, 
        EN => un1_nxtprdata_xhdl722_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => CoreAPB3_0_APBmslave2_PRDATA(1));
    
    \nxtprdata_xhdl7_1_4[0]\ : CFG2
      generic map(INIT => x"4")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        \CoreUARTapb_0_TXRDY\, Y => N_104);
    
    \nxtprdata_xhdl7_1_2_i_m2[3]\ : CFG3
      generic map(INIT => x"CA")

      port map(A => \data_out[3]\, B => \controlReg2[3]_net_1\, C
         => CoreAPB3_0_APBmslave0_PADDR(3), Y => N_64);
    
    \controlReg2[4]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => un13_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg2[4]_net_1\);
    
    \nxtprdata_xhdl7_1_5_0[1]\ : CFG3
      generic map(INIT => x"C8")

      port map(A => \controlReg1[1]_net_1\, B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => 
        CoreAPB3_0_APBmslave0_PADDR(2), Y => 
        \nxtprdata_xhdl7_1_5_0[1]_net_1\);
    
    \nxtprdata_xhdl7_1_5_0_0[4]\ : CFG4
      generic map(INIT => x"3808")

      port map(A => \CoreUARTapb_0_FRAMING_ERR\, B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => 
        CoreAPB3_0_APBmslave0_PADDR(2), D => N_63, Y => 
        \nxtprdata_xhdl7_1_5_0_0[4]_net_1\);
    
    \nxtprdata_xhdl7_1_2_i_m2[4]\ : CFG3
      generic map(INIT => x"CA")

      port map(A => \data_out[4]\, B => \controlReg2[4]_net_1\, C
         => CoreAPB3_0_APBmslave0_PADDR(3), Y => N_63);
    
    \iPRDATA[4]\ : SLE
      port map(D => \nxtprdata_xhdl7_1[4]\, CLK => FAB_CCC_GL0, 
        EN => un1_nxtprdata_xhdl722_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => CoreAPB3_0_APBmslave2_PRDATA(4));
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \iPRDATA_RNO[1]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => \nxtprdata_xhdl7_1_5_3[1]_net_1\, B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => 
        \nxtprdata_xhdl7_1_5_1[1]_net_1\, Y => 
        \nxtprdata_xhdl7_1[1]\);
    
    \nxtprdata_xhdl7_1_5_1_0[6]\ : CFG4
      generic map(INIT => x"503F")

      port map(A => \controlReg2[6]_net_1\, B => 
        \controlReg1[6]_net_1\, C => 
        CoreAPB3_0_APBmslave0_PADDR(3), D => 
        CoreAPB3_0_APBmslave0_PADDR(2), Y => 
        \nxtprdata_xhdl7_1_5_1_0[6]_net_1\);
    
    \nxtprdata_xhdl7_1_5_1[0]\ : CFG4
      generic map(INIT => x"CFA0")

      port map(A => \data_out[0]\, B => \controlReg2[0]_net_1\, C
         => CoreAPB3_0_APBmslave0_PADDR(2), D => 
        \nxtprdata_xhdl7_1_5_0[0]_net_1\, Y => 
        \nxtprdata_xhdl7_1_5_1[0]_net_1\);
    
    \iPRDATA[3]\ : SLE
      port map(D => \nxtprdata_xhdl7_1[3]\, CLK => FAB_CCC_GL0, 
        EN => un1_nxtprdata_xhdl722_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => CoreAPB3_0_APBmslave2_PRDATA(3));
    
    \controlReg2[6]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => un13_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg2[6]_net_1\);
    
    \controlReg1[3]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => un5_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg1[3]_net_1\);
    
    un1_nxtprdata_xhdl722_0_RNIA1KG : CFG4
      generic map(INIT => x"4044")

      port map(A => \un1_nxtprdata_xhdl722_0\, B => 
        CoreAPB3_0_APBmslave2_PSELx, C => 
        \CoreUARTapb_0_PARITY_ERR\, D => 
        CoreAPB3_0_APBmslave0_PENABLE, Y => 
        un1_nxtprdata_xhdl722_i);
    
    \nxtprdata_xhdl7_1_5_1_0[7]\ : CFG4
      generic map(INIT => x"503F")

      port map(A => \controlReg2[7]_net_1\, B => 
        \controlReg1[7]_net_1\, C => 
        CoreAPB3_0_APBmslave0_PADDR(3), D => 
        CoreAPB3_0_APBmslave0_PADDR(2), Y => 
        \nxtprdata_xhdl7_1_5_1_0[7]_net_1\);
    
    \controlReg1[6]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => un5_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg1[6]_net_1\);
    
    \controlReg2[3]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => un13_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg2[3]_net_1\);
    
    \controlReg1[2]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => un5_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg1[2]_net_1\);
    
    \controlReg1[4]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => un5_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg1[4]_net_1\);
    
    \nxtprdata_xhdl7_1_5_1[1]\ : CFG4
      generic map(INIT => x"CFA0")

      port map(A => \data_out[1]\, B => \controlReg2[1]_net_1\, C
         => CoreAPB3_0_APBmslave0_PADDR(2), D => 
        \nxtprdata_xhdl7_1_5_0[1]_net_1\, Y => 
        \nxtprdata_xhdl7_1_5_1[1]_net_1\);
    
    \iPRDATA[5]\ : SLE
      port map(D => \nxtprdata_xhdl7_1[5]\, CLK => FAB_CCC_GL0, 
        EN => un1_nxtprdata_xhdl722_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => CoreAPB3_0_APBmslave2_PRDATA(5));
    
    \nxtprdata_xhdl7_1_4[2]\ : CFG2
      generic map(INIT => x"4")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        \CoreUARTapb_0_PARITY_ERR\, Y => N_106);
    
    \nxtprdata_xhdl7_1_5_0_a2_1_2[3]\ : CFG2
      generic map(INIT => x"1")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), Y => N_75_2);
    
    \iPRDATA[7]\ : SLE
      port map(D => \nxtprdata_xhdl7_1[7]\, CLK => FAB_CCC_GL0, 
        EN => un1_nxtprdata_xhdl722_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => CoreAPB3_0_APBmslave2_PRDATA(7));
    
    \controlReg2[1]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => un13_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg2[1]_net_1\);
    
    \nxtprdata_xhdl7_1_5_3[2]\ : CFG3
      generic map(INIT => x"D8")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => N_106, C
         => \nxtprdata_xhdl7_1_5_2[2]_net_1\, Y => 
        \nxtprdata_xhdl7_1_5_3[2]_net_1\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \iPRDATA_RNO[2]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => \nxtprdata_xhdl7_1_5_3[2]_net_1\, B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => 
        \nxtprdata_xhdl7_1_5_1[2]_net_1\, Y => 
        \nxtprdata_xhdl7_1[2]\);
    
    \iPRDATA_RNO[0]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => \nxtprdata_xhdl7_1_5_3[0]_net_1\, B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => 
        \nxtprdata_xhdl7_1_5_1[0]_net_1\, Y => 
        \nxtprdata_xhdl7_1[0]\);
    
    \p_CtrlReg2Seq.un13_psel\ : CFG4
      generic map(INIT => x"0080")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => un3_psel, 
        C => CoreAPB3_0_APBmslave0_PADDR(3), D => 
        CoreAPB3_0_APBmslave0_PADDR(4), Y => un13_psel);
    
    \nxtprdata_xhdl7_1_4[1]\ : CFG2
      generic map(INIT => x"4")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        \CoreUARTapb_0_RXRDY\, Y => N_105);
    
    \controlReg2[7]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => un13_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg2[7]_net_1\);
    
    \iPRDATA[2]\ : SLE
      port map(D => \nxtprdata_xhdl7_1[2]\, CLK => FAB_CCC_GL0, 
        EN => un1_nxtprdata_xhdl722_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => CoreAPB3_0_APBmslave2_PRDATA(2));
    
    \nxtprdata_xhdl7_1_5_1[2]\ : CFG4
      generic map(INIT => x"CFA0")

      port map(A => \data_out[2]\, B => \controlReg2[2]_net_1\, C
         => CoreAPB3_0_APBmslave0_PADDR(2), D => 
        \nxtprdata_xhdl7_1_5_0[2]_net_1\, Y => 
        \nxtprdata_xhdl7_1_5_1[2]_net_1\);
    
    \nxtprdata_xhdl7_1_5[5]\ : CFG4
      generic map(INIT => x"000E")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        \data_out[5]\, C => \nxtprdata_xhdl7_1_5_1_0[5]_net_1\, D
         => CoreAPB3_0_APBmslave0_PADDR(4), Y => 
        \nxtprdata_xhdl7_1[5]\);
    
    \controlReg2[5]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => un13_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg2[5]_net_1\);
    
    \nxtprdata_xhdl7_1_5_3[1]\ : CFG3
      generic map(INIT => x"D8")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => N_105, C
         => \nxtprdata_xhdl7_1_5_2[1]_net_1\, Y => 
        \nxtprdata_xhdl7_1_5_3[1]_net_1\);
    
    \controlReg2[2]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => un13_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg2[2]_net_1\);
    
    \nxtprdata_xhdl7_1_5_0[2]\ : CFG3
      generic map(INIT => x"C8")

      port map(A => \controlReg1[2]_net_1\, B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => 
        CoreAPB3_0_APBmslave0_PADDR(2), Y => 
        \nxtprdata_xhdl7_1_5_0[2]_net_1\);
    
    un1_nxtprdata_xhdl722_0 : CFG3
      generic map(INIT => x"EC")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => 
        CoreAPB3_0_APBmslave0_PWRITE, C => 
        CoreAPB3_0_APBmslave0_PADDR(3), Y => 
        \un1_nxtprdata_xhdl722_0\);
    
    \iPRDATA[6]\ : SLE
      port map(D => \nxtprdata_xhdl7_1[6]\, CLK => FAB_CCC_GL0, 
        EN => un1_nxtprdata_xhdl722_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => CoreAPB3_0_APBmslave2_PRDATA(6));
    
    \nxtprdata_xhdl7_1_5_2[2]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => N_106, Y => 
        \nxtprdata_xhdl7_1_5_2[2]_net_1\);
    
    \iPRDATA[0]\ : SLE
      port map(D => \nxtprdata_xhdl7_1[0]\, CLK => FAB_CCC_GL0, 
        EN => un1_nxtprdata_xhdl722_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => CoreAPB3_0_APBmslave2_PRDATA(0));
    
    uUART : SF2_MSS_sys_sb_CoreUARTapb_0_COREUART
      port map(data_out(7) => \data_out[7]\, data_out(6) => 
        \data_out[6]\, data_out(5) => \data_out[5]\, data_out(4)
         => \data_out[4]\, data_out(3) => \data_out[3]\, 
        data_out(2) => \data_out[2]\, data_out(1) => 
        \data_out[1]\, data_out(0) => \data_out[0]\, 
        controlReg2(7) => \controlReg2[7]_net_1\, controlReg2(6)
         => \controlReg2[6]_net_1\, controlReg2(5) => 
        \controlReg2[5]_net_1\, controlReg2(4) => 
        \controlReg2[4]_net_1\, controlReg2(3) => 
        \controlReg2[3]_net_1\, controlReg2(2) => 
        \controlReg2[2]_net_1\, controlReg2(1) => 
        \controlReg2[1]_net_1\, controlReg2(0) => 
        \controlReg2[0]_net_1\, controlReg1(7) => 
        \controlReg1[7]_net_1\, controlReg1(6) => 
        \controlReg1[6]_net_1\, controlReg1(5) => 
        \controlReg1[5]_net_1\, controlReg1(4) => 
        \controlReg1[4]_net_1\, controlReg1(3) => 
        \controlReg1[3]_net_1\, controlReg1(2) => 
        \controlReg1[2]_net_1\, controlReg1(1) => 
        \controlReg1[1]_net_1\, controlReg1(0) => 
        \controlReg1[0]_net_1\, CoreAPB3_0_APBmslave0_PADDR(4)
         => CoreAPB3_0_APBmslave0_PADDR(4), 
        CoreAPB3_0_APBmslave0_PADDR(3) => 
        CoreAPB3_0_APBmslave0_PADDR(3), 
        CoreAPB3_0_APBmslave0_PADDR(2) => 
        CoreAPB3_0_APBmslave0_PADDR(2), 
        CoreAPB3_0_APBmslave0_PWDATA(7) => 
        CoreAPB3_0_APBmslave0_PWDATA(7), 
        CoreAPB3_0_APBmslave0_PWDATA(6) => 
        CoreAPB3_0_APBmslave0_PWDATA(6), 
        CoreAPB3_0_APBmslave0_PWDATA(5) => 
        CoreAPB3_0_APBmslave0_PWDATA(5), 
        CoreAPB3_0_APBmslave0_PWDATA(4) => 
        CoreAPB3_0_APBmslave0_PWDATA(4), 
        CoreAPB3_0_APBmslave0_PWDATA(3) => 
        CoreAPB3_0_APBmslave0_PWDATA(3), 
        CoreAPB3_0_APBmslave0_PWDATA(2) => 
        CoreAPB3_0_APBmslave0_PWDATA(2), 
        CoreAPB3_0_APBmslave0_PWDATA(1) => 
        CoreAPB3_0_APBmslave0_PWDATA(1), 
        CoreAPB3_0_APBmslave0_PWDATA(0) => 
        CoreAPB3_0_APBmslave0_PWDATA(0), CoreUARTapb_0_PARITY_ERR
         => \CoreUARTapb_0_PARITY_ERR\, CoreUARTapb_0_FRAMING_ERR
         => \CoreUARTapb_0_FRAMING_ERR\, CoreUARTapb_0_OVERFLOW
         => \CoreUARTapb_0_OVERFLOW\, RX_c => RX_c, TX_c => TX_c, 
        CoreUARTapb_0_TXRDY => \CoreUARTapb_0_TXRDY\, 
        CoreAPB3_0_APBmslave2_PSELx => 
        CoreAPB3_0_APBmslave2_PSELx, 
        CoreAPB3_0_APBmslave0_PENABLE => 
        CoreAPB3_0_APBmslave0_PENABLE, 
        CoreAPB3_0_APBmslave0_PWRITE => 
        CoreAPB3_0_APBmslave0_PWRITE, CoreUARTapb_0_RXRDY => 
        \CoreUARTapb_0_RXRDY\, FAB_CCC_GL0 => FAB_CCC_GL0, 
        MSS_READY => MSS_READY);
    
    \nxtprdata_xhdl7_1_5_2[0]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => N_104, Y => 
        \nxtprdata_xhdl7_1_5_2[0]_net_1\);
    
    \nxtprdata_xhdl7_1_5_0[4]\ : CFG4
      generic map(INIT => x"ECCC")

      port map(A => N_75_2, B => 
        \nxtprdata_xhdl7_1_5_0_0[4]_net_1\, C => 
        \controlReg1[4]_net_1\, D => 
        CoreAPB3_0_APBmslave0_PADDR(3), Y => 
        \nxtprdata_xhdl7_1[4]\);
    
    \nxtprdata_xhdl7_1_5_0_0[3]\ : CFG4
      generic map(INIT => x"3808")

      port map(A => \CoreUARTapb_0_OVERFLOW\, B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => 
        CoreAPB3_0_APBmslave0_PADDR(2), D => N_64, Y => 
        \nxtprdata_xhdl7_1_5_0_0[3]_net_1\);
    
    \controlReg2[0]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => un13_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg2[0]_net_1\);
    
    \nxtprdata_xhdl7_1_5_2[1]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => N_105, Y => 
        \nxtprdata_xhdl7_1_5_2[1]_net_1\);
    
    \nxtprdata_xhdl7_1_5[6]\ : CFG4
      generic map(INIT => x"000E")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        \data_out[6]\, C => \nxtprdata_xhdl7_1_5_1_0[6]_net_1\, D
         => CoreAPB3_0_APBmslave0_PADDR(4), Y => 
        \nxtprdata_xhdl7_1[6]\);
    
    \p_CtrlReg1Seq.un5_psel\ : CFG3
      generic map(INIT => x"80")

      port map(A => N_75_2, B => un3_psel, C => 
        CoreAPB3_0_APBmslave0_PADDR(3), Y => un5_psel);
    
    \controlReg1[1]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => un5_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg1[1]_net_1\);
    
    \nxtprdata_xhdl7_1_5_0[3]\ : CFG4
      generic map(INIT => x"ECCC")

      port map(A => N_75_2, B => 
        \nxtprdata_xhdl7_1_5_0_0[3]_net_1\, C => 
        \controlReg1[3]_net_1\, D => 
        CoreAPB3_0_APBmslave0_PADDR(3), Y => 
        \nxtprdata_xhdl7_1[3]\);
    
    \nxtprdata_xhdl7_1_5[7]\ : CFG4
      generic map(INIT => x"000E")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        \data_out[7]\, C => \nxtprdata_xhdl7_1_5_1_0[7]_net_1\, D
         => CoreAPB3_0_APBmslave0_PADDR(4), Y => 
        \nxtprdata_xhdl7_1[7]\);
    
    \nxtprdata_xhdl7_1_5_3[0]\ : CFG3
      generic map(INIT => x"D8")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => N_104, C
         => \nxtprdata_xhdl7_1_5_2[0]_net_1\, Y => 
        \nxtprdata_xhdl7_1_5_3[0]_net_1\);
    
    \p_CtrlReg1Seq.un3_psel\ : CFG3
      generic map(INIT => x"80")

      port map(A => CoreAPB3_0_APBmslave0_PENABLE, B => 
        CoreAPB3_0_APBmslave0_PWRITE, C => 
        CoreAPB3_0_APBmslave2_PSELx, Y => un3_psel);
    
    \controlReg1[0]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => un5_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \controlReg1[0]_net_1\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity CoreResetP is

    port( SF2_MSS_sys_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N : in    std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_MSS_RESET_N_M2F      : in    std_logic;
          POWER_ON_RESET_N                              : in    std_logic;
          FAB_CCC_GL0                                   : in    std_logic;
          MSS_READY                                     : out   std_logic
        );

end CoreResetP;

architecture DEF_ARCH of CoreResetP is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CLKINT
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal \MSS_HPMS_READY_int\, \mss_ready_select\, VCC_net_1, 
        \POWER_ON_RESET_N_clk_base\, 
        \un6_fic_2_apb_m_preset_n_clk_base\, GND_net_1, 
        \mss_ready_state\, \RESET_N_M2F_clk_base\, 
        \MSS_HPMS_READY_int_3\, \POWER_ON_RESET_N_q1\, 
        \RESET_N_M2F_q1\, \FIC_2_APB_M_PRESET_N_q1\, 
        \FIC_2_APB_M_PRESET_N_clk_base\ : std_logic;

begin 


    RESET_N_M2F_clk_base : SLE
      port map(D => \RESET_N_M2F_q1\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => 
        SF2_MSS_sys_sb_MSS_TMP_0_MSS_RESET_N_M2F, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \RESET_N_M2F_clk_base\);
    
    POWER_ON_RESET_N_clk_base : SLE
      port map(D => \POWER_ON_RESET_N_q1\, CLK => FAB_CCC_GL0, EN
         => VCC_net_1, ALn => POWER_ON_RESET_N, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \POWER_ON_RESET_N_clk_base\);
    
    mss_ready_select : SLE
      port map(D => VCC_net_1, CLK => FAB_CCC_GL0, EN => 
        \un6_fic_2_apb_m_preset_n_clk_base\, ALn => 
        \POWER_ON_RESET_N_clk_base\, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \mss_ready_select\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    mss_ready_state : SLE
      port map(D => VCC_net_1, CLK => FAB_CCC_GL0, EN => 
        \RESET_N_M2F_clk_base\, ALn => 
        \POWER_ON_RESET_N_clk_base\, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \mss_ready_state\);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    un6_fic_2_apb_m_preset_n_clk_base : CFG2
      generic map(INIT => x"8")

      port map(A => \FIC_2_APB_M_PRESET_N_clk_base\, B => 
        \mss_ready_state\, Y => 
        \un6_fic_2_apb_m_preset_n_clk_base\);
    
    RESET_N_M2F_q1 : SLE
      port map(D => VCC_net_1, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => 
        SF2_MSS_sys_sb_MSS_TMP_0_MSS_RESET_N_M2F, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \RESET_N_M2F_q1\);
    
    FIC_2_APB_M_PRESET_N_clk_base : SLE
      port map(D => \FIC_2_APB_M_PRESET_N_q1\, CLK => FAB_CCC_GL0, 
        EN => VCC_net_1, ALn => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \FIC_2_APB_M_PRESET_N_clk_base\);
    
    POWER_ON_RESET_N_q1 : SLE
      port map(D => VCC_net_1, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => POWER_ON_RESET_N, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \POWER_ON_RESET_N_q1\);
    
    FIC_2_APB_M_PRESET_N_q1 : SLE
      port map(D => VCC_net_1, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \FIC_2_APB_M_PRESET_N_q1\);
    
    MSS_HPMS_READY_int_RNIDDQA : CLKINT
      port map(A => \MSS_HPMS_READY_int\, Y => MSS_READY);
    
    MSS_HPMS_READY_int_3 : CFG3
      generic map(INIT => x"E0")

      port map(A => \RESET_N_M2F_clk_base\, B => 
        \mss_ready_select\, C => \FIC_2_APB_M_PRESET_N_clk_base\, 
        Y => \MSS_HPMS_READY_int_3\);
    
    MSS_HPMS_READY_int : SLE
      port map(D => \MSS_HPMS_READY_int_3\, CLK => FAB_CCC_GL0, 
        EN => VCC_net_1, ALn => \POWER_ON_RESET_N_clk_base\, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \MSS_HPMS_READY_int\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity CoreGPIO is

    port( GPIO_OUT_c                    : out   std_logic_vector(2 downto 0);
          CoreAPB3_0_APBmslave0_PADDR   : in    std_logic_vector(7 downto 0);
          CoreAPB3_0_APBmslave0_PWDATA  : in    std_logic_vector(7 downto 0);
          CONFIG_regrx                  : out   std_logic_vector(7 downto 3);
          GPIO_IN_c                     : in    std_logic_vector(2 downto 0);
          PRDATA_o_2_am_0               : out   std_logic;
          PRDATA_o_2_bm_0               : out   std_logic;
          int_or_i                      : out   std_logic;
          CoreAPB3_0_APBmslave0_PENABLE : in    std_logic;
          CoreAPB3_0_APBmslave1_PSELx   : in    std_logic;
          CoreAPB3_0_APBmslave0_PWRITE  : in    std_logic;
          N_45                          : out   std_logic;
          GEN_N_3_mux_0                 : out   std_logic;
          PRDATA_o_sn_N_6_mux           : out   std_logic;
          N_86_mux_0                    : out   std_logic;
          un3_prdata_o                  : out   std_logic;
          un27_psel                     : out   std_logic;
          FAB_CCC_GL0                   : in    std_logic;
          MSS_READY                     : in    std_logic
        );

end CoreGPIO;

architecture DEF_ARCH of CoreGPIO is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component RAM64x18
    generic (MEMORYFILE:string := "");

    port( A_DOUT        : out   std_logic_vector(17 downto 0);
          B_DOUT        : out   std_logic_vector(17 downto 0);
          BUSY          : out   std_logic;
          A_ADDR_CLK    : in    std_logic := 'U';
          A_DOUT_CLK    : in    std_logic := 'U';
          A_ADDR_SRST_N : in    std_logic := 'U';
          A_DOUT_SRST_N : in    std_logic := 'U';
          A_ADDR_ARST_N : in    std_logic := 'U';
          A_DOUT_ARST_N : in    std_logic := 'U';
          A_ADDR_EN     : in    std_logic := 'U';
          A_DOUT_EN     : in    std_logic := 'U';
          A_BLK         : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_ADDR        : in    std_logic_vector(9 downto 0) := (others => 'U');
          B_ADDR_CLK    : in    std_logic := 'U';
          B_DOUT_CLK    : in    std_logic := 'U';
          B_ADDR_SRST_N : in    std_logic := 'U';
          B_DOUT_SRST_N : in    std_logic := 'U';
          B_ADDR_ARST_N : in    std_logic := 'U';
          B_DOUT_ARST_N : in    std_logic := 'U';
          B_ADDR_EN     : in    std_logic := 'U';
          B_DOUT_EN     : in    std_logic := 'U';
          B_BLK         : in    std_logic_vector(1 downto 0) := (others => 'U');
          B_ADDR        : in    std_logic_vector(9 downto 0) := (others => 'U');
          C_CLK         : in    std_logic := 'U';
          C_ADDR        : in    std_logic_vector(9 downto 0) := (others => 'U');
          C_DIN         : in    std_logic_vector(17 downto 0) := (others => 'U');
          C_WEN         : in    std_logic := 'U';
          C_BLK         : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_EN          : in    std_logic := 'U';
          A_ADDR_LAT    : in    std_logic := 'U';
          A_DOUT_LAT    : in    std_logic := 'U';
          A_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_EN          : in    std_logic := 'U';
          B_ADDR_LAT    : in    std_logic := 'U';
          B_DOUT_LAT    : in    std_logic := 'U';
          B_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          C_EN          : in    std_logic := 'U';
          C_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          SII_LOCK      : in    std_logic := 'U'
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

    signal \CONFIG_reg_0[7]_net_1\, VCC_net_1, 
        \CONFIG_reg_0_RNO[7]_net_1\, GND_net_1, 
        \CONFIG_reg_2[0]_net_1\, un60_psel, 
        \CONFIG_reg_2[1]_net_1\, \CONFIG_reg_2[3]_net_1\, 
        \CONFIG_reg_2_RNO[3]_net_1\, \CONFIG_reg_1[0]_net_1\, 
        un35_psel, \CONFIG_reg_1[1]_net_1\, 
        \CONFIG_reg_1[3]_net_1\, \CONFIG_reg_1_RNO[3]_net_1\, 
        \CONFIG_reg_0[0]_net_1\, un8_psel, 
        \CONFIG_reg_0[1]_net_1\, \CONFIG_reg_0[3]_net_1\, 
        \CONFIG_reg_0_RNO[3]_net_1\, \CONFIG_reg_2[5]_net_1\, 
        \CONFIG_reg_2_RNO[5]_net_1\, \CONFIG_reg_2[6]_net_1\, 
        \CONFIG_reg_2_RNO[6]_net_1\, \CONFIG_reg_2[7]_net_1\, 
        \CONFIG_reg_2_RNO[7]_net_1\, \CONFIG_reg_1[5]_net_1\, 
        \CONFIG_reg_1_RNO[5]_net_1\, \CONFIG_reg_1[6]_net_1\, 
        \CONFIG_reg_1_RNO[6]_net_1\, \CONFIG_reg_1[7]_net_1\, 
        \CONFIG_reg_1_RNO[7]_net_1\, \CONFIG_reg_0[5]_net_1\, 
        \CONFIG_reg_0_RNO[5]_net_1\, \CONFIG_reg_0[6]_net_1\, 
        \CONFIG_reg_0_RNO[6]_net_1\, CONFIG_regro_2, 
        \edge_pos[2]_net_1\, \edge_pos_31_iv_i[2]\, 
        \edge_pos_2_sqmuxa_2_i\, \edge_pos[1]_net_1\, 
        \edge_pos_19_iv_i[1]\, \edge_pos_2_sqmuxa_i\, 
        \edge_pos[0]_net_1\, \edge_pos_7_iv_i[0]\, 
        \edge_pos_2_sqmuxa_1_i\, \GPOUT_reg[2]_net_1\, 
        GPOUT_reg_0_sqmuxa, \GPOUT_reg[1]_net_1\, 
        \GPOUT_reg[0]_net_1\, CONFIG_regro_0, CONFIG_regro_1, 
        \edge_both[2]_net_1\, \edge_both_31_iv_i[2]\, 
        \edge_both_2_sqmuxa_2_i\, \edge_both[1]_net_1\, N_80_mux, 
        \edge_both_2_sqmuxa_1_i\, \edge_both[0]_net_1\, N_83_mux, 
        \edge_both_2_sqmuxa_i\, \edge_neg[2]_net_1\, 
        \edge_neg_31_iv_i[2]\, \edge_neg_2_sqmuxa_1_i\, 
        \edge_neg[1]_net_1\, \edge_neg_19_iv_i[1]\, 
        \edge_neg_2_sqmuxa_2_i\, \edge_neg[0]_net_1\, 
        \edge_neg_7_iv_i[0]\, \edge_neg_2_sqmuxa_i\, 
        \INTR_reg[0]_net_1\, \INTR_reg_36[0]\, 
        \INTR_reg[1]_net_1\, \INTR_reg_48[1]\, 
        \INTR_reg[2]_net_1\, \INTR_reg_60[2]\, \gpin2[0]_net_1\, 
        \gpin1[0]_net_1\, \gpin2[1]_net_1\, \gpin1[1]_net_1\, 
        \gpin2[2]_net_1\, \gpin1[2]_net_1\, \gpin3[0]_net_1\, 
        \gpin3[1]_net_1\, \gpin3[2]_net_1\, \CONFIG_regrx[0]\, 
        \CONFIG_regrx[1]\, \CONFIG_regrx[2]\, CONFIG_reg_0_0_we, 
        un1_psel_1_1, \un1_psel_1_0_a2_0\, \intr_3_u_0[1]\, 
        \intr_5_u_0[2]\, \intr_5_u_2[2]\, \intr_3_u_2[1]\, 
        \un27_psel\, \un3_prdata_o\, N_2926_0, N_2925_0, 
        un1_psel_1_3, g0_5_0, g0_4_0, N_29, g0_5, \g0_4\, g1_1, 
        un15_fixed_config, \GEN_N_3_mux_0\, m66_1_0_1, m66_1_0, 
        m66_1, \intr_1[0]\, \intr_5_u_3[2]\, \intr_5_u_4_1[2]\, 
        \intr_5[2]\, N_335, \intr_3_u_3[1]\, \intr_3_u_4_1[1]\, 
        \intr_3[1]\, N_322, CONFIG_reg_0_0_RNIKAQ42, 
        \CONFIG_reg_2_RNI7ELE1[1]_net_1\, 
        un15_fixed_config_0_a2_RNIRT8P, N_34, un4_fixed_config, 
        un25_fixed_config, un43_fixed_config, un137_fixed_config, 
        un117_fixed_config, un99_fixed_config, un81_fixed_config, 
        un61_fixed_config, N_30, N_16_0_i, \INTR_reg_0_sqmuxa\
         : std_logic;
    signal nc24, nc1, nc8, nc13, nc16, nc19, nc25, nc20, nc27, 
        nc9, nc22, nc28, nc14, nc5, nc21, nc15, nc3, nc10, nc7, 
        nc17, nc4, nc12, nc2, nc23, nc18, nc26, nc6, nc11
         : std_logic;

begin 

    GEN_N_3_mux_0 <= \GEN_N_3_mux_0\;
    un3_prdata_o <= \un3_prdata_o\;
    un27_psel <= \un27_psel\;

    \CONFIG_reg_2[1]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => un60_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_2[1]_net_1\);
    
    \CONFIG_reg_0_RNIGH302[6]\ : CFG4
      generic map(INIT => x"2822")

      port map(A => \CONFIG_reg_0[3]_net_1\, B => m66_1_0_1, C
         => \CONFIG_reg_0[6]_net_1\, D => \gpin3[0]_net_1\, Y => 
        m66_1_0);
    
    \GEN_BITS.1.REG_INT.intr_3_2_RNIKSCN[1]\ : CFG3
      generic map(INIT => x"35")

      port map(A => \intr_3_u_0[1]\, B => N_322, C => 
        \CONFIG_reg_1[6]_net_1\, Y => \intr_3_u_4_1[1]\);
    
    \GEN_BITS.0.APB_32.un25_fixed_config\ : CFG2
      generic map(INIT => x"4")

      port map(A => \gpin2[0]_net_1\, B => \gpin3[0]_net_1\, Y
         => un25_fixed_config);
    
    un1_psel_1_0_a2_0_RNIRPTQ_0 : CFG4
      generic map(INIT => x"2000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => un1_psel_1_1, D => 
        \un1_psel_1_0_a2_0\, Y => un35_psel);
    
    \CONFIG_reg_1[6]\ : SLE
      port map(D => \CONFIG_reg_1_RNO[6]_net_1\, CLK => 
        FAB_CCC_GL0, EN => VCC_net_1, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_1[6]_net_1\);
    
    \CONFIG_reg_2[7]\ : SLE
      port map(D => \CONFIG_reg_2_RNO[7]_net_1\, CLK => 
        FAB_CCC_GL0, EN => VCC_net_1, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_2[7]_net_1\);
    
    
        \GEN_BITS.0.REG_GEN.CONFIG_reg_GEN_BITS.0.REG_GEN.CONFIG_reg_0_0\ : 
        RAM64x18
      port map(A_DOUT(17) => nc24, A_DOUT(16) => nc1, A_DOUT(15)
         => nc8, A_DOUT(14) => nc13, A_DOUT(13) => nc16, 
        A_DOUT(12) => nc19, A_DOUT(11) => nc25, A_DOUT(10) => 
        nc20, A_DOUT(9) => nc27, A_DOUT(8) => nc9, A_DOUT(7) => 
        CONFIG_regrx(7), A_DOUT(6) => CONFIG_regrx(6), A_DOUT(5)
         => CONFIG_regrx(5), A_DOUT(4) => CONFIG_regrx(4), 
        A_DOUT(3) => CONFIG_regrx(3), A_DOUT(2) => 
        \CONFIG_regrx[2]\, A_DOUT(1) => \CONFIG_regrx[1]\, 
        A_DOUT(0) => \CONFIG_regrx[0]\, B_DOUT(17) => nc22, 
        B_DOUT(16) => nc28, B_DOUT(15) => nc14, B_DOUT(14) => nc5, 
        B_DOUT(13) => nc21, B_DOUT(12) => nc15, B_DOUT(11) => nc3, 
        B_DOUT(10) => nc10, B_DOUT(9) => nc7, B_DOUT(8) => nc17, 
        B_DOUT(7) => nc4, B_DOUT(6) => nc12, B_DOUT(5) => nc2, 
        B_DOUT(4) => nc23, B_DOUT(3) => nc18, B_DOUT(2) => nc26, 
        B_DOUT(1) => nc6, B_DOUT(0) => nc11, BUSY => OPEN, 
        A_ADDR_CLK => VCC_net_1, A_DOUT_CLK => VCC_net_1, 
        A_ADDR_SRST_N => VCC_net_1, A_DOUT_SRST_N => VCC_net_1, 
        A_ADDR_ARST_N => VCC_net_1, A_DOUT_ARST_N => VCC_net_1, 
        A_ADDR_EN => VCC_net_1, A_DOUT_EN => VCC_net_1, A_BLK(1)
         => VCC_net_1, A_BLK(0) => VCC_net_1, A_ADDR(9) => 
        GND_net_1, A_ADDR(8) => GND_net_1, A_ADDR(7) => GND_net_1, 
        A_ADDR(6) => GND_net_1, A_ADDR(5) => GND_net_1, A_ADDR(4)
         => CoreAPB3_0_APBmslave0_PADDR(3), A_ADDR(3) => 
        CoreAPB3_0_APBmslave0_PADDR(2), A_ADDR(2) => GND_net_1, 
        A_ADDR(1) => GND_net_1, A_ADDR(0) => GND_net_1, 
        B_ADDR_CLK => VCC_net_1, B_DOUT_CLK => VCC_net_1, 
        B_ADDR_SRST_N => VCC_net_1, B_DOUT_SRST_N => VCC_net_1, 
        B_ADDR_ARST_N => VCC_net_1, B_DOUT_ARST_N => VCC_net_1, 
        B_ADDR_EN => VCC_net_1, B_DOUT_EN => VCC_net_1, B_BLK(1)
         => VCC_net_1, B_BLK(0) => VCC_net_1, B_ADDR(9) => 
        GND_net_1, B_ADDR(8) => GND_net_1, B_ADDR(7) => GND_net_1, 
        B_ADDR(6) => GND_net_1, B_ADDR(5) => GND_net_1, B_ADDR(4)
         => CoreAPB3_0_APBmslave0_PADDR(3), B_ADDR(3) => 
        CoreAPB3_0_APBmslave0_PADDR(2), B_ADDR(2) => GND_net_1, 
        B_ADDR(1) => GND_net_1, B_ADDR(0) => GND_net_1, C_CLK => 
        FAB_CCC_GL0, C_ADDR(9) => GND_net_1, C_ADDR(8) => 
        GND_net_1, C_ADDR(7) => GND_net_1, C_ADDR(6) => GND_net_1, 
        C_ADDR(5) => GND_net_1, C_ADDR(4) => 
        CoreAPB3_0_APBmslave0_PADDR(3), C_ADDR(3) => 
        CoreAPB3_0_APBmslave0_PADDR(2), C_ADDR(2) => GND_net_1, 
        C_ADDR(1) => GND_net_1, C_ADDR(0) => GND_net_1, C_DIN(17)
         => GND_net_1, C_DIN(16) => GND_net_1, C_DIN(15) => 
        GND_net_1, C_DIN(14) => GND_net_1, C_DIN(13) => GND_net_1, 
        C_DIN(12) => GND_net_1, C_DIN(11) => GND_net_1, C_DIN(10)
         => GND_net_1, C_DIN(9) => GND_net_1, C_DIN(8) => 
        GND_net_1, C_DIN(7) => CoreAPB3_0_APBmslave0_PWDATA(7), 
        C_DIN(6) => CoreAPB3_0_APBmslave0_PWDATA(6), C_DIN(5) => 
        CoreAPB3_0_APBmslave0_PWDATA(5), C_DIN(4) => 
        CoreAPB3_0_APBmslave0_PWDATA(4), C_DIN(3) => 
        CoreAPB3_0_APBmslave0_PWDATA(3), C_DIN(2) => 
        CoreAPB3_0_APBmslave0_PWDATA(2), C_DIN(1) => 
        CoreAPB3_0_APBmslave0_PWDATA(1), C_DIN(0) => 
        CoreAPB3_0_APBmslave0_PWDATA(0), C_WEN => 
        CONFIG_reg_0_0_we, C_BLK(1) => VCC_net_1, C_BLK(0) => 
        VCC_net_1, A_EN => VCC_net_1, A_ADDR_LAT => VCC_net_1, 
        A_DOUT_LAT => VCC_net_1, A_WIDTH(2) => GND_net_1, 
        A_WIDTH(1) => VCC_net_1, A_WIDTH(0) => VCC_net_1, B_EN
         => GND_net_1, B_ADDR_LAT => VCC_net_1, B_DOUT_LAT => 
        VCC_net_1, B_WIDTH(2) => GND_net_1, B_WIDTH(1) => 
        VCC_net_1, B_WIDTH(0) => VCC_net_1, C_EN => VCC_net_1, 
        C_WIDTH(2) => GND_net_1, C_WIDTH(1) => VCC_net_1, 
        C_WIDTH(0) => VCC_net_1, SII_LOCK => GND_net_1);
    
    \CONFIG_reg_2[3]\ : SLE
      port map(D => \CONFIG_reg_2_RNO[3]_net_1\, CLK => 
        FAB_CCC_GL0, EN => VCC_net_1, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_2[3]_net_1\);
    
    \CONFIG_reg_2_RNO[3]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(3), B => 
        un60_psel, C => \CONFIG_reg_2[3]_net_1\, Y => 
        \CONFIG_reg_2_RNO[3]_net_1\);
    
    \CONFIG_reg_1[5]\ : SLE
      port map(D => \CONFIG_reg_1_RNO[5]_net_1\, CLK => 
        FAB_CCC_GL0, EN => VCC_net_1, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_1[5]_net_1\);
    
    \edge_both[2]\ : SLE
      port map(D => \edge_both_31_iv_i[2]\, CLK => FAB_CCC_GL0, 
        EN => \edge_both_2_sqmuxa_2_i\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \edge_both[2]_net_1\);
    
    un1_psel_1_0_a2_1_RNISCLM : CFG3
      generic map(INIT => x"80")

      port map(A => N_29, B => N_30, C => un1_psel_1_1, Y => 
        un8_psel);
    
    \edge_pos_RNI7EQ31[0]\ : CFG4
      generic map(INIT => x"503F")

      port map(A => \edge_neg[0]_net_1\, B => \edge_pos[0]_net_1\, 
        C => \CONFIG_reg_0[6]_net_1\, D => 
        \CONFIG_reg_0[5]_net_1\, Y => m66_1_0_1);
    
    \GPOUT_reg[2]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => GPOUT_reg_0_sqmuxa, ALn => MSS_READY, 
        ADn => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT
         => GND_net_1, Q => \GPOUT_reg[2]_net_1\);
    
    \GEN_BITS.2.REG_INT.intr_5_2_RNIT3LP[2]\ : CFG3
      generic map(INIT => x"35")

      port map(A => \intr_5_u_0[2]\, B => N_335, C => 
        \CONFIG_reg_2[6]_net_1\, Y => \intr_5_u_4_1[2]\);
    
    \gpin2_RNIN3JI_0[2]\ : CFG2
      generic map(INIT => x"4")

      port map(A => \gpin2[2]_net_1\, B => \gpin3[2]_net_1\, Y
         => un137_fixed_config);
    
    \CONFIG_reg_1[7]\ : SLE
      port map(D => \CONFIG_reg_1_RNO[7]_net_1\, CLK => 
        FAB_CCC_GL0, EN => VCC_net_1, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_1[7]_net_1\);
    
    \CONFIG_reg_1_RNO[7]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(7), B => 
        un35_psel, C => \CONFIG_reg_1[7]_net_1\, Y => 
        \CONFIG_reg_1_RNO[7]_net_1\);
    
    \CONFIG_reg_2[6]\ : SLE
      port map(D => \CONFIG_reg_2_RNO[6]_net_1\, CLK => 
        FAB_CCC_GL0, EN => VCC_net_1, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_2[6]_net_1\);
    
    \GEN_BITS.0.REG_GPOUT.GPIO_OUT_i_1[0]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \CONFIG_reg_0[0]_net_1\, B => 
        \GPOUT_reg[0]_net_1\, Y => GPIO_OUT_c(0));
    
    g0_7 : CFG4
      generic map(INIT => x"0040")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), C => 
        CoreAPB3_0_APBmslave0_PADDR(5), D => 
        CoreAPB3_0_APBmslave0_PADDR(4), Y => \g0_4\);
    
    \CONFIG_reg_0_RNI25KI7[7]\ : CFG3
      generic map(INIT => x"FE")

      port map(A => \intr_5[2]\, B => \intr_3[1]\, C => 
        \intr_1[0]\, Y => int_or_i);
    
    \CONFIG_reg_0[7]\ : SLE
      port map(D => \CONFIG_reg_0_RNO[7]_net_1\, CLK => 
        FAB_CCC_GL0, EN => VCC_net_1, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_0[7]_net_1\);
    
    \GEN_BITS.2.APB_32.edge_pos_31_iv_i[2]\ : CFG4
      generic map(INIT => x"C0C8")

      port map(A => \edge_pos[2]_net_1\, B => 
        \CONFIG_reg_2[3]_net_1\, C => un117_fixed_config, D => 
        CoreAPB3_0_APBmslave0_PWDATA(2), Y => 
        \edge_pos_31_iv_i[2]\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \edge_both[0]\ : SLE
      port map(D => N_83_mux, CLK => FAB_CCC_GL0, EN => 
        \edge_both_2_sqmuxa_i\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \edge_both[0]_net_1\);
    
    \CONFIG_reg_2_RNO[6]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(6), B => 
        un60_psel, C => \CONFIG_reg_2[6]_net_1\, Y => 
        \CONFIG_reg_2_RNO[6]_net_1\);
    
    \GEN_BITS.0.REG_GEN.CONFIG_regrff_2\ : SLE
      port map(D => VCC_net_1, CLK => FAB_CCC_GL0, EN => 
        un60_psel, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        CONFIG_regro_2);
    
    \CONFIG_reg_2[5]\ : SLE
      port map(D => \CONFIG_reg_2_RNO[5]_net_1\, CLK => 
        FAB_CCC_GL0, EN => VCC_net_1, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_2[5]_net_1\);
    
    \GPOUT_reg[0]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => GPOUT_reg_0_sqmuxa, ALn => MSS_READY, 
        ADn => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT
         => GND_net_1, Q => \GPOUT_reg[0]_net_1\);
    
    g0_13 : CFG2
      generic map(INIT => x"1")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(5), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), Y => un1_psel_1_3);
    
    \edge_pos[0]\ : SLE
      port map(D => \edge_pos_7_iv_i[0]\, CLK => FAB_CCC_GL0, EN
         => \edge_pos_2_sqmuxa_1_i\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \edge_pos[0]_net_1\);
    
    \GEN_BITS.0.APB_32.un15_fixed_config_0_a2\ : CFG4
      generic map(INIT => x"0080")

      port map(A => un1_psel_1_3, B => N_29, C => 
        CoreAPB3_0_APBmslave0_PADDR(7), D => 
        CoreAPB3_0_APBmslave0_PADDR(4), Y => un15_fixed_config);
    
    \PRDATA_o_2_am[0]\ : CFG4
      generic map(INIT => x"ACA0")

      port map(A => \GPOUT_reg[0]_net_1\, B => 
        \CONFIG_reg_0[1]_net_1\, C => \un27_psel\, D => 
        \gpin3[0]_net_1\, Y => PRDATA_o_2_am_0);
    
    \CONFIG_reg_0_RNIDUER3[7]\ : CFG3
      generic map(INIT => x"BA")

      port map(A => m66_1, B => \CONFIG_reg_0[7]_net_1\, C => 
        m66_1_0, Y => \intr_1[0]\);
    
    \gpin1[0]\ : SLE
      port map(D => GPIO_IN_c(0), CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \gpin1[0]_net_1\);
    
    \GEN_BITS.1.APB_32.un81_fixed_config\ : CFG2
      generic map(INIT => x"4")

      port map(A => \gpin2[1]_net_1\, B => \gpin3[1]_net_1\, Y
         => un81_fixed_config);
    
    \CONFIG_reg_0_RNO[5]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(5), B => 
        un8_psel, C => \CONFIG_reg_0[5]_net_1\, Y => 
        \CONFIG_reg_0_RNO[5]_net_1\);
    
    \GPOUT_reg[1]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => GPOUT_reg_0_sqmuxa, ALn => MSS_READY, 
        ADn => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT
         => GND_net_1, Q => \GPOUT_reg[1]_net_1\);
    
    edge_neg_2_sqmuxa_i : CFG3
      generic map(INIT => x"FD")

      port map(A => \CONFIG_reg_0[3]_net_1\, B => 
        un25_fixed_config, C => \INTR_reg_0_sqmuxa\, Y => 
        \edge_neg_2_sqmuxa_i\);
    
    un1_psel_1_0_a2_0 : CFG3
      generic map(INIT => x"04")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(1), B => N_30, C
         => CoreAPB3_0_APBmslave0_PADDR(0), Y => 
        \un1_psel_1_0_a2_0\);
    
    \CONFIG_reg_1_RNO[3]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(3), B => 
        un35_psel, C => \CONFIG_reg_1[3]_net_1\, Y => 
        \CONFIG_reg_1_RNO[3]_net_1\);
    
    g0_8 : CFG4
      generic map(INIT => x"0001")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => 
        CoreAPB3_0_APBmslave0_PADDR(1), D => 
        CoreAPB3_0_APBmslave0_PADDR(0), Y => g0_5);
    
    \gpin3[2]\ : SLE
      port map(D => \gpin2[2]_net_1\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \gpin3[2]_net_1\);
    
    \gpin1[1]\ : SLE
      port map(D => GPIO_IN_c(1), CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \gpin1[1]_net_1\);
    
    \GEN_BITS.0.APB_32.edge_pos_7_iv_i[0]\ : CFG4
      generic map(INIT => x"C0C8")

      port map(A => \edge_pos[0]_net_1\, B => 
        \CONFIG_reg_0[3]_net_1\, C => un4_fixed_config, D => 
        CoreAPB3_0_APBmslave0_PWDATA(0), Y => 
        \edge_pos_7_iv_i[0]\);
    
    \edge_both_RNIB94I1[0]\ : CFG4
      generic map(INIT => x"0800")

      port map(A => \edge_both[0]_net_1\, B => 
        \CONFIG_reg_0[7]_net_1\, C => \CONFIG_reg_0[6]_net_1\, D
         => N_34, Y => m66_1);
    
    \INTR_reg[2]\ : SLE
      port map(D => \INTR_reg_60[2]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \INTR_reg[2]_net_1\);
    
    \GEN_BITS.0.APB_32.edge_neg_7_iv_i[0]\ : CFG4
      generic map(INIT => x"C0C8")

      port map(A => \edge_neg[0]_net_1\, B => 
        \CONFIG_reg_0[3]_net_1\, C => un25_fixed_config, D => 
        CoreAPB3_0_APBmslave0_PWDATA(0), Y => 
        \edge_neg_7_iv_i[0]\);
    
    \INTR_reg[0]\ : SLE
      port map(D => \INTR_reg_36[0]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \INTR_reg[0]_net_1\);
    
    \gpin2[2]\ : SLE
      port map(D => \gpin1[2]_net_1\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \gpin2[2]_net_1\);
    
    \gpin2[1]\ : SLE
      port map(D => \gpin1[1]_net_1\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \gpin2[1]_net_1\);
    
    \GEN_BITS.0.APB_32.un15_fixed_config_0_a2_RNIRT8P\ : CFG3
      generic map(INIT => x"32")

      port map(A => \un3_prdata_o\, B => \un27_psel\, C => 
        un15_fixed_config, Y => un15_fixed_config_0_a2_RNIRT8P);
    
    INTR_reg_0_sqmuxa : CFG4
      generic map(INIT => x"8000")

      port map(A => CoreAPB3_0_APBmslave0_PENABLE, B => 
        CoreAPB3_0_APBmslave0_PWRITE, C => 
        CoreAPB3_0_APBmslave1_PSELx, D => un15_fixed_config, Y
         => \INTR_reg_0_sqmuxa\);
    
    edge_pos_2_sqmuxa_i : CFG3
      generic map(INIT => x"FD")

      port map(A => \CONFIG_reg_1[3]_net_1\, B => 
        un61_fixed_config, C => \INTR_reg_0_sqmuxa\, Y => 
        \edge_pos_2_sqmuxa_i\);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \GEN_BITS.2.REG_INT.intr_5_2[2]\ : CFG4
      generic map(INIT => x"0200")

      port map(A => \edge_both[2]_net_1\, B => 
        \CONFIG_reg_2[5]_net_1\, C => \CONFIG_reg_2[6]_net_1\, D
         => \CONFIG_reg_2[3]_net_1\, Y => N_335);
    
    edge_both_2_sqmuxa_i : CFG3
      generic map(INIT => x"FD")

      port map(A => \CONFIG_reg_0[3]_net_1\, B => 
        un43_fixed_config, C => \INTR_reg_0_sqmuxa\, Y => 
        \edge_both_2_sqmuxa_i\);
    
    \CONFIG_reg_0[6]\ : SLE
      port map(D => \CONFIG_reg_0_RNO[6]_net_1\, CLK => 
        FAB_CCC_GL0, EN => VCC_net_1, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_0[6]_net_1\);
    
    g0_4 : CFG2
      generic map(INIT => x"8")

      port map(A => g0_5, B => \g0_4\, Y => \un27_psel\);
    
    \CONFIG_reg_0[5]\ : SLE
      port map(D => \CONFIG_reg_0_RNO[5]_net_1\, CLK => 
        FAB_CCC_GL0, EN => VCC_net_1, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_0[5]_net_1\);
    
    \gpin3[1]\ : SLE
      port map(D => \gpin2[1]_net_1\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \gpin3[1]_net_1\);
    
    \GEN_BITS.0.REG_GEN.CONFIG_regrff_1\ : SLE
      port map(D => VCC_net_1, CLK => FAB_CCC_GL0, EN => 
        un35_psel, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        CONFIG_regro_1);
    
    \CONFIG_reg_2_RNO[7]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(7), B => 
        un60_psel, C => \CONFIG_reg_2[7]_net_1\, Y => 
        \CONFIG_reg_2_RNO[7]_net_1\);
    
    \CONFIG_reg_2_RNI7ELE1[1]\ : CFG4
      generic map(INIT => x"35F5")

      port map(A => \INTR_reg[2]_net_1\, B => 
        \CONFIG_reg_2[1]_net_1\, C => \un3_prdata_o\, D => 
        \gpin3[2]_net_1\, Y => \CONFIG_reg_2_RNI7ELE1[1]_net_1\);
    
    g0_10 : CFG4
      generic map(INIT => x"0001")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => 
        CoreAPB3_0_APBmslave0_PADDR(1), D => 
        CoreAPB3_0_APBmslave0_PADDR(0), Y => N_29);
    
    \gpin3[0]\ : SLE
      port map(D => \gpin2[0]_net_1\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \gpin3[0]_net_1\);
    
    
        \GEN_BITS.0.REG_GEN.CONFIG_reg_GEN_BITS.0.REG_GEN.CONFIG_reg_0_0_RNIARCV3\ : 
        CFG4
      generic map(INIT => x"FE10")

      port map(A => \un27_psel\, B => \un3_prdata_o\, C => 
        N_2926_0, D => N_2925_0, Y => N_86_mux_0);
    
    \edge_both[1]\ : SLE
      port map(D => N_80_mux, CLK => FAB_CCC_GL0, EN => 
        \edge_both_2_sqmuxa_1_i\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \edge_both[1]_net_1\);
    
    \GEN_BITS.0.REG_GEN.CONFIG_regrff_2_RNIPQ2B1\ : CFG4
      generic map(INIT => x"AFCC")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => g1_1, C
         => CONFIG_regro_2, D => CoreAPB3_0_APBmslave0_PADDR(3), 
        Y => \GEN_N_3_mux_0\);
    
    \GEN_BITS.2.APB_32.edge_both_31_iv_i[2]\ : CFG4
      generic map(INIT => x"C0C8")

      port map(A => \edge_both[2]_net_1\, B => 
        \CONFIG_reg_2[3]_net_1\, C => N_16_0_i, D => 
        CoreAPB3_0_APBmslave0_PWDATA(2), Y => 
        \edge_both_31_iv_i[2]\);
    
    \GEN_BITS.2.APB_32.edge_neg_31_iv_i[2]\ : CFG4
      generic map(INIT => x"C0C8")

      port map(A => \edge_neg[2]_net_1\, B => 
        \CONFIG_reg_2[3]_net_1\, C => un137_fixed_config, D => 
        CoreAPB3_0_APBmslave0_PWDATA(2), Y => 
        \edge_neg_31_iv_i[2]\);
    
    \CONFIG_reg_2[0]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => un60_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_2[0]_net_1\);
    
    \GEN_BITS.1.REG_GPOUT.GPIO_OUT_i_3[1]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \CONFIG_reg_1[0]_net_1\, B => 
        \GPOUT_reg[1]_net_1\, Y => GPIO_OUT_c(1));
    
    \CONFIG_reg_0_RNO[6]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(6), B => 
        un8_psel, C => \CONFIG_reg_0[6]_net_1\, Y => 
        \CONFIG_reg_0_RNO[6]_net_1\);
    
    \GEN_BITS.2.REG_INT.intr_5_u_2[2]\ : CFG3
      generic map(INIT => x"9C")

      port map(A => \CONFIG_reg_2[6]_net_1\, B => 
        \CONFIG_reg_2[5]_net_1\, C => \gpin3[2]_net_1\, Y => 
        \intr_5_u_2[2]\);
    
    \CONFIG_reg_2_RNO[5]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(5), B => 
        un60_psel, C => \CONFIG_reg_2[5]_net_1\, Y => 
        \CONFIG_reg_2_RNO[5]_net_1\);
    
    \CONFIG_reg_1_RNO[6]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(6), B => 
        un35_psel, C => \CONFIG_reg_1[6]_net_1\, Y => 
        \CONFIG_reg_1_RNO[6]_net_1\);
    
    \CONFIG_reg_1[0]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => un35_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_1[0]_net_1\);
    
    \PRDATA_o_2_bm[0]\ : CFG4
      generic map(INIT => x"CC50")

      port map(A => \GEN_N_3_mux_0\, B => \INTR_reg[0]_net_1\, C
         => \CONFIG_regrx[0]\, D => un15_fixed_config, Y => 
        PRDATA_o_2_bm_0);
    
    \GEN_BITS.0.APB_32.un15_fixed_config_0_a2_RNIG0QQ\ : CFG4
      generic map(INIT => x"0004")

      port map(A => \un3_prdata_o\, B => 
        CoreAPB3_0_APBmslave0_PADDR(7), C => un15_fixed_config, D
         => \un27_psel\, Y => PRDATA_o_sn_N_6_mux);
    
    \CONFIG_reg_1[1]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => un35_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_1[1]_net_1\);
    
    \GEN_BITS.1.REG_INT.intr_3_u_2[1]\ : CFG3
      generic map(INIT => x"9C")

      port map(A => \CONFIG_reg_1[6]_net_1\, B => 
        \CONFIG_reg_1[5]_net_1\, C => \gpin3[1]_net_1\, Y => 
        \intr_3_u_2[1]\);
    
    \GEN_BITS.1.APB_32.edge_neg_19_iv_i[1]\ : CFG4
      generic map(INIT => x"C0C8")

      port map(A => \edge_neg[1]_net_1\, B => 
        \CONFIG_reg_1[3]_net_1\, C => un81_fixed_config, D => 
        CoreAPB3_0_APBmslave0_PWDATA(1), Y => 
        \edge_neg_19_iv_i[1]\);
    
    \GEN_BITS.0.APB_32.un15_fixed_config_0_a2_RNIMMOC4\ : CFG3
      generic map(INIT => x"CA")

      port map(A => CONFIG_reg_0_0_RNIKAQ42, B => 
        \CONFIG_reg_2_RNI7ELE1[1]_net_1\, C => 
        un15_fixed_config_0_a2_RNIRT8P, Y => N_45);
    
    \edge_neg[0]\ : SLE
      port map(D => \edge_neg_7_iv_i[0]\, CLK => FAB_CCC_GL0, EN
         => \edge_neg_2_sqmuxa_i\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \edge_neg[0]_net_1\);
    
    edge_both_2_sqmuxa_2_i : CFG3
      generic map(INIT => x"FD")

      port map(A => \CONFIG_reg_2[3]_net_1\, B => N_16_0_i, C => 
        \INTR_reg_0_sqmuxa\, Y => \edge_both_2_sqmuxa_2_i\);
    
    \GEN_BITS.1.APB_32.un61_fixed_config\ : CFG2
      generic map(INIT => x"2")

      port map(A => \gpin2[1]_net_1\, B => \gpin3[1]_net_1\, Y
         => un61_fixed_config);
    
    \GEN_BITS.1.REG_INT.intr_3_2[1]\ : CFG4
      generic map(INIT => x"0200")

      port map(A => \edge_both[1]_net_1\, B => 
        \CONFIG_reg_1[5]_net_1\, C => \CONFIG_reg_1[6]_net_1\, D
         => \CONFIG_reg_1[3]_net_1\, Y => N_322);
    
    un1_psel_1_0_a2_0_RNIRPTQ : CFG4
      generic map(INIT => x"4000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => un1_psel_1_1, D => 
        \un1_psel_1_0_a2_0\, Y => un60_psel);
    
    \gpin1[2]\ : SLE
      port map(D => GPIO_IN_c(2), CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \gpin1[2]_net_1\);
    
    
        \GEN_BITS.0.REG_GEN.CONFIG_reg_GEN_BITS.0.REG_GEN.CONFIG_reg_0_0_RNI4IEV1\ : 
        CFG4
      generic map(INIT => x"33AF")

      port map(A => \GEN_N_3_mux_0\, B => \INTR_reg[1]_net_1\, C
         => \CONFIG_regrx[1]\, D => un15_fixed_config, Y => 
        N_2926_0);
    
    \edge_pos[2]\ : SLE
      port map(D => \edge_pos_31_iv_i[2]\, CLK => FAB_CCC_GL0, EN
         => \edge_pos_2_sqmuxa_2_i\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \edge_pos[2]_net_1\);
    
    \edge_pos[1]\ : SLE
      port map(D => \edge_pos_19_iv_i[1]\, CLK => FAB_CCC_GL0, EN
         => \edge_pos_2_sqmuxa_i\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \edge_pos[1]_net_1\);
    
    \CONFIG_reg_0_RNIU0EI[5]\ : CFG2
      generic map(INIT => x"2")

      port map(A => \CONFIG_reg_0[3]_net_1\, B => 
        \CONFIG_reg_0[5]_net_1\, Y => N_34);
    
    \GEN_BITS.1.REG_INT.intr_3_u_3_RNI3A2O1[1]\ : CFG4
      generic map(INIT => x"3A33")

      port map(A => \intr_3_u_3[1]\, B => \intr_3_u_4_1[1]\, C
         => \CONFIG_reg_1[7]_net_1\, D => \CONFIG_reg_1[3]_net_1\, 
        Y => \intr_3[1]\);
    
    \GEN_BITS.1.APB_32.un99_fixed_config\ : CFG2
      generic map(INIT => x"6")

      port map(A => \gpin2[1]_net_1\, B => \gpin3[1]_net_1\, Y
         => un99_fixed_config);
    
    
        \GEN_BITS.0.REG_GEN.CONFIG_reg_GEN_BITS.0.REG_GEN.CONFIG_reg_0_0_RNO\ : 
        CFG2
      generic map(INIT => x"8")

      port map(A => un1_psel_1_1, B => \un1_psel_1_0_a2_0\, Y => 
        CONFIG_reg_0_0_we);
    
    \CONFIG_reg_1_RNO[5]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(5), B => 
        un35_psel, C => \CONFIG_reg_1[5]_net_1\, Y => 
        \CONFIG_reg_1_RNO[5]_net_1\);
    
    \GEN_BITS.2.REG_GPOUT.GPIO_OUT_i_5[2]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \CONFIG_reg_2[0]_net_1\, B => 
        \GPOUT_reg[2]_net_1\, Y => GPIO_OUT_c(2));
    
    \CONFIG_reg_1_RNIMUC71[1]\ : CFG4
      generic map(INIT => x"535F")

      port map(A => \GPOUT_reg[1]_net_1\, B => 
        \CONFIG_reg_1[1]_net_1\, C => \un27_psel\, D => 
        \gpin3[1]_net_1\, Y => N_2925_0);
    
    edge_pos_2_sqmuxa_2_i : CFG3
      generic map(INIT => x"FD")

      port map(A => \CONFIG_reg_2[3]_net_1\, B => 
        un117_fixed_config, C => \INTR_reg_0_sqmuxa\, Y => 
        \edge_pos_2_sqmuxa_2_i\);
    
    \GEN_BITS.2.REG_INT.intr_5_u_0[2]\ : CFG4
      generic map(INIT => x"AA40")

      port map(A => \CONFIG_reg_2[6]_net_1\, B => 
        \CONFIG_reg_2[3]_net_1\, C => \edge_both[2]_net_1\, D => 
        \CONFIG_reg_2[5]_net_1\, Y => \intr_5_u_0[2]\);
    
    \GEN_BITS.0.REG_GEN.CONFIG_regrff_0_RNIG46R\ : CFG3
      generic map(INIT => x"53")

      port map(A => CONFIG_regro_1, B => CONFIG_regro_0, C => 
        CoreAPB3_0_APBmslave0_PADDR(2), Y => g1_1);
    
    edge_pos_2_sqmuxa_1_i : CFG3
      generic map(INIT => x"FD")

      port map(A => \CONFIG_reg_0[3]_net_1\, B => 
        un4_fixed_config, C => \INTR_reg_0_sqmuxa\, Y => 
        \edge_pos_2_sqmuxa_1_i\);
    
    \GEN_BITS.2.REG_INT.intr_5_u_3[2]\ : CFG4
      generic map(INIT => x"CFA0")

      port map(A => \edge_pos[2]_net_1\, B => \edge_neg[2]_net_1\, 
        C => \CONFIG_reg_2[6]_net_1\, D => \intr_5_u_2[2]\, Y => 
        \intr_5_u_3[2]\);
    
    \CONFIG_reg_0[1]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => un8_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_0[1]_net_1\);
    
    \GEN_BITS.0.REG_GEN.CONFIG_regrff_0\ : SLE
      port map(D => VCC_net_1, CLK => FAB_CCC_GL0, EN => un8_psel, 
        ALn => MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => CONFIG_regro_0);
    
    \GEN_BITS.1.APB_32.edge_pos_19_iv_i[1]\ : CFG4
      generic map(INIT => x"C0C8")

      port map(A => \edge_pos[1]_net_1\, B => 
        \CONFIG_reg_1[3]_net_1\, C => un61_fixed_config, D => 
        CoreAPB3_0_APBmslave0_PWDATA(1), Y => 
        \edge_pos_19_iv_i[1]\);
    
    \edge_both_RNO[1]\ : CFG4
      generic map(INIT => x"C0C8")

      port map(A => \edge_both[1]_net_1\, B => 
        \CONFIG_reg_1[3]_net_1\, C => un99_fixed_config, D => 
        CoreAPB3_0_APBmslave0_PWDATA(1), Y => N_80_mux);
    
    m69 : CFG4
      generic map(INIT => x"8000")

      port map(A => CoreAPB3_0_APBmslave0_PENABLE, B => 
        CoreAPB3_0_APBmslave0_PWRITE, C => 
        CoreAPB3_0_APBmslave1_PSELx, D => \un27_psel\, Y => 
        GPOUT_reg_0_sqmuxa);
    
    \GEN_BITS.1.APB_32.INTR_reg_48[1]\ : CFG4
      generic map(INIT => x"7340")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(1), B => 
        \INTR_reg_0_sqmuxa\, C => \INTR_reg[1]_net_1\, D => 
        \intr_3[1]\, Y => \INTR_reg_48[1]\);
    
    g0_9 : CFG2
      generic map(INIT => x"8")

      port map(A => g0_5_0, B => g0_4_0, Y => \un3_prdata_o\);
    
    \gpin2[0]\ : SLE
      port map(D => \gpin1[0]_net_1\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \gpin2[0]_net_1\);
    
    \edge_neg[1]\ : SLE
      port map(D => \edge_neg_19_iv_i[1]\, CLK => FAB_CCC_GL0, EN
         => \edge_neg_2_sqmuxa_2_i\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \edge_neg[1]_net_1\);
    
    m1_e : CFG2
      generic map(INIT => x"2")

      port map(A => un1_psel_1_3, B => 
        CoreAPB3_0_APBmslave0_PADDR(4), Y => N_30);
    
    \GEN_BITS.0.APB_32.INTR_reg_36[0]\ : CFG4
      generic map(INIT => x"7340")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(0), B => 
        \INTR_reg_0_sqmuxa\, C => \INTR_reg[0]_net_1\, D => 
        \intr_1[0]\, Y => \INTR_reg_36[0]\);
    
    \CONFIG_reg_1[3]\ : SLE
      port map(D => \CONFIG_reg_1_RNO[3]_net_1\, CLK => 
        FAB_CCC_GL0, EN => VCC_net_1, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_1[3]_net_1\);
    
    \GEN_BITS.0.APB_32.un4_fixed_config\ : CFG2
      generic map(INIT => x"2")

      port map(A => \gpin2[0]_net_1\, B => \gpin3[0]_net_1\, Y
         => un4_fixed_config);
    
    \edge_neg[2]\ : SLE
      port map(D => \edge_neg_31_iv_i[2]\, CLK => FAB_CCC_GL0, EN
         => \edge_neg_2_sqmuxa_1_i\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \edge_neg[2]_net_1\);
    
    \gpin2_RNIN3JI_1[2]\ : CFG2
      generic map(INIT => x"2")

      port map(A => \gpin2[2]_net_1\, B => \gpin3[2]_net_1\, Y
         => un117_fixed_config);
    
    \CONFIG_reg_0_RNO[7]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(7), B => 
        un8_psel, C => \CONFIG_reg_0[7]_net_1\, Y => 
        \CONFIG_reg_0_RNO[7]_net_1\);
    
    \GEN_BITS.2.APB_32.INTR_reg_60[2]\ : CFG4
      generic map(INIT => x"7340")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(2), B => 
        \INTR_reg_0_sqmuxa\, C => \INTR_reg[2]_net_1\, D => 
        \intr_5[2]\, Y => \INTR_reg_60[2]\);
    
    edge_neg_2_sqmuxa_2_i : CFG3
      generic map(INIT => x"FD")

      port map(A => \CONFIG_reg_1[3]_net_1\, B => 
        un81_fixed_config, C => \INTR_reg_0_sqmuxa\, Y => 
        \edge_neg_2_sqmuxa_2_i\);
    
    \gpin2_RNIN3JI[2]\ : CFG2
      generic map(INIT => x"6")

      port map(A => \gpin2[2]_net_1\, B => \gpin3[2]_net_1\, Y
         => N_16_0_i);
    
    \CONFIG_reg_0[3]\ : SLE
      port map(D => \CONFIG_reg_0_RNO[3]_net_1\, CLK => 
        FAB_CCC_GL0, EN => VCC_net_1, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_0[3]_net_1\);
    
    \GEN_BITS.2.REG_INT.intr_5_u_3_RNIIS2V1[2]\ : CFG4
      generic map(INIT => x"3A33")

      port map(A => \intr_5_u_3[2]\, B => \intr_5_u_4_1[2]\, C
         => \CONFIG_reg_2[7]_net_1\, D => \CONFIG_reg_2[3]_net_1\, 
        Y => \intr_5[2]\);
    
    \GEN_BITS.1.REG_INT.intr_3_u_0[1]\ : CFG4
      generic map(INIT => x"AA40")

      port map(A => \CONFIG_reg_1[6]_net_1\, B => 
        \CONFIG_reg_1[3]_net_1\, C => \edge_both[1]_net_1\, D => 
        \CONFIG_reg_1[5]_net_1\, Y => \intr_3_u_0[1]\);
    
    \edge_both_RNO[0]\ : CFG4
      generic map(INIT => x"C0C8")

      port map(A => \edge_both[0]_net_1\, B => 
        \CONFIG_reg_0[3]_net_1\, C => un43_fixed_config, D => 
        CoreAPB3_0_APBmslave0_PWDATA(0), Y => N_83_mux);
    
    \INTR_reg[1]\ : SLE
      port map(D => \INTR_reg_48[1]\, CLK => FAB_CCC_GL0, EN => 
        VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \INTR_reg[1]_net_1\);
    
    edge_neg_2_sqmuxa_1_i : CFG3
      generic map(INIT => x"FD")

      port map(A => \CONFIG_reg_2[3]_net_1\, B => 
        un137_fixed_config, C => \INTR_reg_0_sqmuxa\, Y => 
        \edge_neg_2_sqmuxa_1_i\);
    
    
        \GEN_BITS.0.REG_GEN.CONFIG_reg_GEN_BITS.0.REG_GEN.CONFIG_reg_0_0_RNIKAQ42\ : 
        CFG4
      generic map(INIT => x"33AF")

      port map(A => \GEN_N_3_mux_0\, B => \GPOUT_reg[2]_net_1\, C
         => \CONFIG_regrx[2]\, D => \un27_psel\, Y => 
        CONFIG_reg_0_0_RNIKAQ42);
    
    \GEN_BITS.0.APB_32.un43_fixed_config\ : CFG2
      generic map(INIT => x"6")

      port map(A => \gpin2[0]_net_1\, B => \gpin3[0]_net_1\, Y
         => un43_fixed_config);
    
    \CONFIG_reg_0[0]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => un8_psel, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \CONFIG_reg_0[0]_net_1\);
    
    \GEN_BITS.1.REG_INT.intr_3_u_3[1]\ : CFG4
      generic map(INIT => x"CFA0")

      port map(A => \edge_pos[1]_net_1\, B => \edge_neg[1]_net_1\, 
        C => \CONFIG_reg_1[6]_net_1\, D => \intr_3_u_2[1]\, Y => 
        \intr_3_u_3[1]\);
    
    un1_psel_1_0_a2_1 : CFG4
      generic map(INIT => x"0800")

      port map(A => CoreAPB3_0_APBmslave0_PWRITE, B => 
        CoreAPB3_0_APBmslave1_PSELx, C => 
        CoreAPB3_0_APBmslave0_PADDR(7), D => 
        CoreAPB3_0_APBmslave0_PENABLE, Y => un1_psel_1_1);
    
    g0_11 : CFG4
      generic map(INIT => x"0040")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => 
        CoreAPB3_0_APBmslave0_PADDR(3), Y => g0_4_0);
    
    g0_12 : CFG4
      generic map(INIT => x"0001")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        CoreAPB3_0_APBmslave0_PADDR(5), C => 
        CoreAPB3_0_APBmslave0_PADDR(1), D => 
        CoreAPB3_0_APBmslave0_PADDR(0), Y => g0_5_0);
    
    \CONFIG_reg_0_RNO[3]\ : CFG3
      generic map(INIT => x"B8")

      port map(A => CoreAPB3_0_APBmslave0_PWDATA(3), B => 
        un8_psel, C => \CONFIG_reg_0[3]_net_1\, Y => 
        \CONFIG_reg_0_RNO[3]_net_1\);
    
    edge_both_2_sqmuxa_1_i : CFG3
      generic map(INIT => x"FD")

      port map(A => \CONFIG_reg_1[3]_net_1\, B => 
        un99_fixed_config, C => \INTR_reg_0_sqmuxa\, Y => 
        \edge_both_2_sqmuxa_1_i\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity SF2_MSS_sys_sb_FABOSC_0_OSC is

    port( FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC : out   std_logic
        );

end SF2_MSS_sys_sb_FABOSC_0_OSC;

architecture DEF_ARCH of SF2_MSS_sys_sb_FABOSC_0_OSC is 

  component RCOSC_25_50MHZ
    generic (FREQUENCY:real := 50.0);

    port( CLKOUT : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal GND_net_1, VCC_net_1 : std_logic;

begin 


    I_RCOSC_25_50MHZ : RCOSC_25_50MHZ
      generic map(FREQUENCY => 50.0)

      port map(CLKOUT => 
        FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity corepwm_pwm_gen is

    port( pwm_enable_reg  : in    std_logic_vector(8 downto 1);
          pwm_posedge_reg : in    std_logic_vector(128 downto 1);
          pwm_negedge_reg : in    std_logic_vector(128 downto 1);
          period_cnt      : in    std_logic_vector(15 downto 0);
          PWM_c           : out   std_logic_vector(7 downto 0);
          sync_pulse_1    : in    std_logic;
          CCC_0_GL1       : in    std_logic;
          MSS_READY       : in    std_logic
        );

end corepwm_pwm_gen;

architecture DEF_ARCH of corepwm_pwm_gen is 

  component ARI1
    generic (INIT:std_logic_vector(19 downto 0) := x"00000");

    port( A   : in    std_logic := 'U';
          B   : in    std_logic := 'U';
          C   : in    std_logic := 'U';
          D   : in    std_logic := 'U';
          FCI : in    std_logic := 'U';
          S   : out   std_logic;
          Y   : out   std_logic;
          FCO : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

    signal \PWM_c[7]\, VCC_net_1, N_14_i, 
        \un1_pwm_enable_reg_i[0]\, GND_net_1, \PWM_c[6]\, N_16_i, 
        \un1_pwm_enable_reg_1_i[0]\, \PWM_c[5]\, N_18_i, 
        \un1_pwm_enable_reg_2_i[0]\, \PWM_c[4]\, N_20_i, 
        \un1_pwm_enable_reg_3_i[0]\, \PWM_c[3]\, N_32_i, 
        \un1_pwm_enable_reg_4_i[0]\, \PWM_c[2]\, N_33_i, 
        \un1_pwm_enable_reg_5_i[0]\, \PWM_c[1]\, N_34_i, 
        \un1_pwm_enable_reg_6_i[0]\, \PWM_c[0]\, N_41_i, 
        \un1_pwm_enable_reg_7_i[0]\, 
        \un52_pwm_enable_reg_1_data_tmp[0]\, 
        \un52_pwm_enable_reg_1_data_tmp[1]\, 
        \un52_pwm_enable_reg_1_data_tmp[2]\, 
        \un52_pwm_enable_reg_1_data_tmp[3]\, 
        \un52_pwm_enable_reg_1_data_tmp[4]\, 
        \un52_pwm_enable_reg_1_data_tmp[5]\, 
        \un52_pwm_enable_reg_1_data_tmp[6]\, un52_pwm_enable_reg, 
        \un49_pwm_enable_reg_1_data_tmp[0]\, 
        \un49_pwm_enable_reg_1_data_tmp[1]\, 
        \un49_pwm_enable_reg_1_data_tmp[2]\, 
        \un49_pwm_enable_reg_1_data_tmp[3]\, 
        \un49_pwm_enable_reg_1_data_tmp[4]\, 
        \un49_pwm_enable_reg_1_data_tmp[5]\, 
        \un49_pwm_enable_reg_1_data_tmp[6]\, 
        \un49_pwm_enable_reg_1_data_tmp[7]\, 
        \un14_pwm_enable_reg_1_data_tmp[0]\, 
        \un14_pwm_enable_reg_1_data_tmp[1]\, 
        \un14_pwm_enable_reg_1_data_tmp[2]\, 
        \un14_pwm_enable_reg_1_data_tmp[3]\, 
        \un14_pwm_enable_reg_1_data_tmp[4]\, 
        \un14_pwm_enable_reg_1_data_tmp[5]\, 
        \un14_pwm_enable_reg_1_data_tmp[6]\, un14_pwm_enable_reg, 
        \un11_pwm_enable_reg_1_data_tmp[0]\, 
        \un11_pwm_enable_reg_1_data_tmp[1]\, 
        \un11_pwm_enable_reg_1_data_tmp[2]\, 
        \un11_pwm_enable_reg_1_data_tmp[3]\, 
        \un11_pwm_enable_reg_1_data_tmp[4]\, 
        \un11_pwm_enable_reg_1_data_tmp[5]\, 
        \un11_pwm_enable_reg_1_data_tmp[6]\, 
        \un11_pwm_enable_reg_1_data_tmp[7]\, 
        \un107_pwm_enable_reg_0_data_tmp[0]\, 
        \un107_pwm_enable_reg_0_data_tmp[1]\, 
        \un107_pwm_enable_reg_0_data_tmp[2]\, 
        \un107_pwm_enable_reg_0_data_tmp[3]\, 
        \un107_pwm_enable_reg_0_data_tmp[4]\, 
        \un107_pwm_enable_reg_0_data_tmp[5]\, 
        \un107_pwm_enable_reg_0_data_tmp[6]\, 
        \un107_pwm_enable_reg_0_data_tmp[7]\, 
        \un69_pwm_enable_reg_0_data_tmp[0]\, 
        \un69_pwm_enable_reg_0_data_tmp[1]\, 
        \un69_pwm_enable_reg_0_data_tmp[2]\, 
        \un69_pwm_enable_reg_0_data_tmp[3]\, 
        \un69_pwm_enable_reg_0_data_tmp[4]\, 
        \un69_pwm_enable_reg_0_data_tmp[5]\, 
        \un69_pwm_enable_reg_0_data_tmp[6]\, 
        \un69_pwm_enable_reg_0_data_tmp[7]\, 
        \un31_pwm_enable_reg_0_data_tmp[0]\, 
        \un31_pwm_enable_reg_0_data_tmp[1]\, 
        \un31_pwm_enable_reg_0_data_tmp[2]\, 
        \un31_pwm_enable_reg_0_data_tmp[3]\, 
        \un31_pwm_enable_reg_0_data_tmp[4]\, 
        \un31_pwm_enable_reg_0_data_tmp[5]\, 
        \un31_pwm_enable_reg_0_data_tmp[6]\, 
        \un31_pwm_enable_reg_0_data_tmp[7]\, 
        \un280_pwm_enable_reg_1_data_tmp[0]\, 
        \un280_pwm_enable_reg_1_data_tmp[1]\, 
        \un280_pwm_enable_reg_1_data_tmp[2]\, 
        \un280_pwm_enable_reg_1_data_tmp[3]\, 
        \un280_pwm_enable_reg_1_data_tmp[4]\, 
        \un280_pwm_enable_reg_1_data_tmp[5]\, 
        \un280_pwm_enable_reg_1_data_tmp[6]\, 
        un280_pwm_enable_reg, 
        \un277_pwm_enable_reg_1_data_tmp[0]\, 
        \un277_pwm_enable_reg_1_data_tmp[1]\, 
        \un277_pwm_enable_reg_1_data_tmp[2]\, 
        \un277_pwm_enable_reg_1_data_tmp[3]\, 
        \un277_pwm_enable_reg_1_data_tmp[4]\, 
        \un277_pwm_enable_reg_1_data_tmp[5]\, 
        \un277_pwm_enable_reg_1_data_tmp[6]\, 
        \un277_pwm_enable_reg_1_data_tmp[7]\, 
        \un242_pwm_enable_reg_1_data_tmp[0]\, 
        \un242_pwm_enable_reg_1_data_tmp[1]\, 
        \un242_pwm_enable_reg_1_data_tmp[2]\, 
        \un242_pwm_enable_reg_1_data_tmp[3]\, 
        \un242_pwm_enable_reg_1_data_tmp[4]\, 
        \un242_pwm_enable_reg_1_data_tmp[5]\, 
        \un242_pwm_enable_reg_1_data_tmp[6]\, 
        un242_pwm_enable_reg, 
        \un239_pwm_enable_reg_1_data_tmp[0]\, 
        \un239_pwm_enable_reg_1_data_tmp[1]\, 
        \un239_pwm_enable_reg_1_data_tmp[2]\, 
        \un239_pwm_enable_reg_1_data_tmp[3]\, 
        \un239_pwm_enable_reg_1_data_tmp[4]\, 
        \un239_pwm_enable_reg_1_data_tmp[5]\, 
        \un239_pwm_enable_reg_1_data_tmp[6]\, 
        \un239_pwm_enable_reg_1_data_tmp[7]\, 
        \un204_pwm_enable_reg_1_data_tmp[0]\, 
        \un204_pwm_enable_reg_1_data_tmp[1]\, 
        \un204_pwm_enable_reg_1_data_tmp[2]\, 
        \un204_pwm_enable_reg_1_data_tmp[3]\, 
        \un204_pwm_enable_reg_1_data_tmp[4]\, 
        \un204_pwm_enable_reg_1_data_tmp[5]\, 
        \un204_pwm_enable_reg_1_data_tmp[6]\, 
        un204_pwm_enable_reg, 
        \un201_pwm_enable_reg_1_data_tmp[0]\, 
        \un201_pwm_enable_reg_1_data_tmp[1]\, 
        \un201_pwm_enable_reg_1_data_tmp[2]\, 
        \un201_pwm_enable_reg_1_data_tmp[3]\, 
        \un201_pwm_enable_reg_1_data_tmp[4]\, 
        \un201_pwm_enable_reg_1_data_tmp[5]\, 
        \un201_pwm_enable_reg_1_data_tmp[6]\, 
        \un201_pwm_enable_reg_1_data_tmp[7]\, 
        \un166_pwm_enable_reg_1_data_tmp[0]\, 
        \un166_pwm_enable_reg_1_data_tmp[1]\, 
        \un166_pwm_enable_reg_1_data_tmp[2]\, 
        \un166_pwm_enable_reg_1_data_tmp[3]\, 
        \un166_pwm_enable_reg_1_data_tmp[4]\, 
        \un166_pwm_enable_reg_1_data_tmp[5]\, 
        \un166_pwm_enable_reg_1_data_tmp[6]\, 
        un166_pwm_enable_reg, 
        \un163_pwm_enable_reg_1_data_tmp[0]\, 
        \un163_pwm_enable_reg_1_data_tmp[1]\, 
        \un163_pwm_enable_reg_1_data_tmp[2]\, 
        \un163_pwm_enable_reg_1_data_tmp[3]\, 
        \un163_pwm_enable_reg_1_data_tmp[4]\, 
        \un163_pwm_enable_reg_1_data_tmp[5]\, 
        \un163_pwm_enable_reg_1_data_tmp[6]\, 
        \un163_pwm_enable_reg_1_data_tmp[7]\, 
        \un128_pwm_enable_reg_1_data_tmp[0]\, 
        \un128_pwm_enable_reg_1_data_tmp[1]\, 
        \un128_pwm_enable_reg_1_data_tmp[2]\, 
        \un128_pwm_enable_reg_1_data_tmp[3]\, 
        \un128_pwm_enable_reg_1_data_tmp[4]\, 
        \un128_pwm_enable_reg_1_data_tmp[5]\, 
        \un128_pwm_enable_reg_1_data_tmp[6]\, 
        un128_pwm_enable_reg, 
        \un125_pwm_enable_reg_1_data_tmp[0]\, 
        \un125_pwm_enable_reg_1_data_tmp[1]\, 
        \un125_pwm_enable_reg_1_data_tmp[2]\, 
        \un125_pwm_enable_reg_1_data_tmp[3]\, 
        \un125_pwm_enable_reg_1_data_tmp[4]\, 
        \un125_pwm_enable_reg_1_data_tmp[5]\, 
        \un125_pwm_enable_reg_1_data_tmp[6]\, 
        \un125_pwm_enable_reg_1_data_tmp[7]\, 
        \un90_pwm_enable_reg_1_data_tmp[0]\, 
        \un90_pwm_enable_reg_1_data_tmp[1]\, 
        \un90_pwm_enable_reg_1_data_tmp[2]\, 
        \un90_pwm_enable_reg_1_data_tmp[3]\, 
        \un90_pwm_enable_reg_1_data_tmp[4]\, 
        \un90_pwm_enable_reg_1_data_tmp[5]\, 
        \un90_pwm_enable_reg_1_data_tmp[6]\, un90_pwm_enable_reg, 
        \un87_pwm_enable_reg_1_data_tmp[0]\, 
        \un87_pwm_enable_reg_1_data_tmp[1]\, 
        \un87_pwm_enable_reg_1_data_tmp[2]\, 
        \un87_pwm_enable_reg_1_data_tmp[3]\, 
        \un87_pwm_enable_reg_1_data_tmp[4]\, 
        \un87_pwm_enable_reg_1_data_tmp[5]\, 
        \un87_pwm_enable_reg_1_data_tmp[6]\, 
        \un87_pwm_enable_reg_1_data_tmp[7]\, 
        \un297_pwm_enable_reg_0_data_tmp[0]\, 
        \un297_pwm_enable_reg_0_data_tmp[1]\, 
        \un297_pwm_enable_reg_0_data_tmp[2]\, 
        \un297_pwm_enable_reg_0_data_tmp[3]\, 
        \un297_pwm_enable_reg_0_data_tmp[4]\, 
        \un297_pwm_enable_reg_0_data_tmp[5]\, 
        \un297_pwm_enable_reg_0_data_tmp[6]\, 
        \un297_pwm_enable_reg_0_data_tmp[7]\, 
        \un259_pwm_enable_reg_0_data_tmp[0]\, 
        \un259_pwm_enable_reg_0_data_tmp[1]\, 
        \un259_pwm_enable_reg_0_data_tmp[2]\, 
        \un259_pwm_enable_reg_0_data_tmp[3]\, 
        \un259_pwm_enable_reg_0_data_tmp[4]\, 
        \un259_pwm_enable_reg_0_data_tmp[5]\, 
        \un259_pwm_enable_reg_0_data_tmp[6]\, 
        \un259_pwm_enable_reg_0_data_tmp[7]\, 
        \un221_pwm_enable_reg_0_data_tmp[0]\, 
        \un221_pwm_enable_reg_0_data_tmp[1]\, 
        \un221_pwm_enable_reg_0_data_tmp[2]\, 
        \un221_pwm_enable_reg_0_data_tmp[3]\, 
        \un221_pwm_enable_reg_0_data_tmp[4]\, 
        \un221_pwm_enable_reg_0_data_tmp[5]\, 
        \un221_pwm_enable_reg_0_data_tmp[6]\, 
        \un221_pwm_enable_reg_0_data_tmp[7]\, 
        \un183_pwm_enable_reg_0_data_tmp[0]\, 
        \un183_pwm_enable_reg_0_data_tmp[1]\, 
        \un183_pwm_enable_reg_0_data_tmp[2]\, 
        \un183_pwm_enable_reg_0_data_tmp[3]\, 
        \un183_pwm_enable_reg_0_data_tmp[4]\, 
        \un183_pwm_enable_reg_0_data_tmp[5]\, 
        \un183_pwm_enable_reg_0_data_tmp[6]\, 
        \un183_pwm_enable_reg_0_data_tmp[7]\, 
        \un145_pwm_enable_reg_0_data_tmp[0]\, 
        \un145_pwm_enable_reg_0_data_tmp[1]\, 
        \un145_pwm_enable_reg_0_data_tmp[2]\, 
        \un145_pwm_enable_reg_0_data_tmp[3]\, 
        \un145_pwm_enable_reg_0_data_tmp[4]\, 
        \un145_pwm_enable_reg_0_data_tmp[5]\, 
        \un145_pwm_enable_reg_0_data_tmp[6]\, 
        \un145_pwm_enable_reg_0_data_tmp[7]\, un4_pwm_enable_reg, 
        \N_35_i\, \N_30_i\, \N_36_i\, \N_37_i\, \N_38_i\, 
        \N_39_i\, \N_40_i\ : std_logic;

begin 

    PWM_c(7) <= \PWM_c[7]\;
    PWM_c(6) <= \PWM_c[6]\;
    PWM_c(5) <= \PWM_c[5]\;
    PWM_c(4) <= \PWM_c[4]\;
    PWM_c(3) <= \PWM_c[3]\;
    PWM_c(2) <= \PWM_c[2]\;
    PWM_c(1) <= \PWM_c[1]\;
    PWM_c(0) <= \PWM_c[0]\;

    
        \PWM_output_select.2.PWM_output_generation.un49_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(18), B => pwm_negedge_reg(17), 
        C => pwm_negedge_reg(18), D => pwm_posedge_reg(17), FCI
         => GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un49_pwm_enable_reg_1_data_tmp[0]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un69_pwm_enable_reg_0_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(26), B => period_cnt(8), C
         => period_cnt(9), D => pwm_negedge_reg(25), FCI => 
        \un69_pwm_enable_reg_0_data_tmp[3]\, S => OPEN, Y => OPEN, 
        FCO => \un69_pwm_enable_reg_0_data_tmp[4]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un90_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(36), B => period_cnt(2), C
         => period_cnt(3), D => pwm_posedge_reg(35), FCI => 
        \un90_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y => OPEN, 
        FCO => \un90_pwm_enable_reg_1_data_tmp[1]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un52_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(32), B => period_cnt(14), C
         => period_cnt(15), D => pwm_posedge_reg(31), FCI => 
        \un52_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y => OPEN, 
        FCO => un52_pwm_enable_reg);
    
    
        \PWM_output_select.3.PWM_output_generation.un90_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(42), B => period_cnt(8), C
         => period_cnt(9), D => pwm_posedge_reg(41), FCI => 
        \un90_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y => OPEN, 
        FCO => \un90_pwm_enable_reg_1_data_tmp[4]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un52_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(26), B => period_cnt(8), C
         => period_cnt(9), D => pwm_posedge_reg(25), FCI => 
        \un52_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y => OPEN, 
        FCO => \un52_pwm_enable_reg_1_data_tmp[4]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un166_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(80), B => period_cnt(14), C
         => period_cnt(15), D => pwm_posedge_reg(79), FCI => 
        \un166_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => un166_pwm_enable_reg);
    
    
        \PWM_output_select.7.PWM_output_generation.un242_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(108), B => period_cnt(10), C
         => period_cnt(11), D => pwm_posedge_reg(107), FCI => 
        \un242_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un242_pwm_enable_reg_1_data_tmp[5]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un204_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(88), B => period_cnt(6), C
         => period_cnt(7), D => pwm_posedge_reg(87), FCI => 
        \un204_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un204_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un145_pwm_enable_reg_0_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(56), B => period_cnt(6), C
         => period_cnt(7), D => pwm_negedge_reg(55), FCI => 
        \un145_pwm_enable_reg_0_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un145_pwm_enable_reg_0_data_tmp[3]\);
    
    \PWM_int_RNO_0[8]\ : CFG4
      generic map(INIT => x"1BBB")

      port map(A => \N_35_i\, B => pwm_enable_reg(8), C => 
        un280_pwm_enable_reg, D => 
        \un297_pwm_enable_reg_0_data_tmp[7]\, Y => 
        \un1_pwm_enable_reg_i[0]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un204_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(92), B => period_cnt(10), C
         => period_cnt(11), D => pwm_posedge_reg(91), FCI => 
        \un204_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un204_pwm_enable_reg_1_data_tmp[5]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un125_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(56), B => pwm_negedge_reg(55), 
        C => pwm_negedge_reg(56), D => pwm_posedge_reg(55), FCI
         => \un125_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y
         => OPEN, FCO => \un125_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un277_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(116), B => 
        pwm_negedge_reg(115), C => pwm_negedge_reg(116), D => 
        pwm_posedge_reg(115), FCI => 
        \un277_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un277_pwm_enable_reg_1_data_tmp[1]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un183_pwm_enable_reg_0_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(78), B => period_cnt(12), C
         => period_cnt(13), D => pwm_negedge_reg(77), FCI => 
        \un183_pwm_enable_reg_0_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un183_pwm_enable_reg_0_data_tmp[6]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un14_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(2), B => period_cnt(0), C => 
        period_cnt(1), D => pwm_posedge_reg(1), FCI => GND_net_1, 
        S => OPEN, Y => OPEN, FCO => 
        \un14_pwm_enable_reg_1_data_tmp[0]\);
    
    N_40_i : CFG2
      generic map(INIT => x"2")

      port map(A => pwm_enable_reg(2), B => sync_pulse_1, Y => 
        \N_40_i\);
    
    
        \PWM_output_select.6.PWM_output_generation.un221_pwm_enable_reg_0_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(82), B => period_cnt(0), C
         => period_cnt(1), D => pwm_negedge_reg(81), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un221_pwm_enable_reg_0_data_tmp[0]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un163_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(78), B => pwm_negedge_reg(77), 
        C => pwm_negedge_reg(78), D => pwm_posedge_reg(77), FCI
         => \un163_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y
         => OPEN, FCO => \un163_pwm_enable_reg_1_data_tmp[6]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un87_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(48), B => pwm_negedge_reg(47), 
        C => pwm_negedge_reg(48), D => pwm_posedge_reg(47), FCI
         => \un87_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => \un87_pwm_enable_reg_1_data_tmp[7]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un11_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(16), B => pwm_negedge_reg(15), 
        C => pwm_negedge_reg(16), D => pwm_posedge_reg(15), FCI
         => \un11_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => \un11_pwm_enable_reg_1_data_tmp[7]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un277_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(128), B => 
        pwm_negedge_reg(127), C => pwm_negedge_reg(128), D => 
        pwm_posedge_reg(127), FCI => 
        \un277_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => \un277_pwm_enable_reg_1_data_tmp[7]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un11_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(12), B => pwm_negedge_reg(11), 
        C => pwm_negedge_reg(12), D => pwm_posedge_reg(11), FCI
         => \un11_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un11_pwm_enable_reg_1_data_tmp[5]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un145_pwm_enable_reg_0_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(62), B => period_cnt(12), C
         => period_cnt(13), D => pwm_negedge_reg(61), FCI => 
        \un145_pwm_enable_reg_0_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un145_pwm_enable_reg_0_data_tmp[6]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un280_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(114), B => period_cnt(0), C
         => period_cnt(1), D => pwm_posedge_reg(113), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un280_pwm_enable_reg_1_data_tmp[0]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un183_pwm_enable_reg_0_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(76), B => period_cnt(10), C
         => period_cnt(11), D => pwm_negedge_reg(75), FCI => 
        \un183_pwm_enable_reg_0_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un183_pwm_enable_reg_0_data_tmp[5]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un166_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(68), B => period_cnt(2), C
         => period_cnt(3), D => pwm_posedge_reg(67), FCI => 
        \un166_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un166_pwm_enable_reg_1_data_tmp[1]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un242_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(112), B => period_cnt(14), C
         => period_cnt(15), D => pwm_posedge_reg(111), FCI => 
        \un242_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => un242_pwm_enable_reg);
    
    
        \PWM_output_select.8.PWM_output_generation.un280_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(124), B => period_cnt(10), C
         => period_cnt(11), D => pwm_posedge_reg(123), FCI => 
        \un280_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un280_pwm_enable_reg_1_data_tmp[5]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un166_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(72), B => period_cnt(6), C
         => period_cnt(7), D => pwm_posedge_reg(71), FCI => 
        \un166_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un166_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un90_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(38), B => period_cnt(4), C
         => period_cnt(5), D => pwm_posedge_reg(37), FCI => 
        \un90_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y => OPEN, 
        FCO => \un90_pwm_enable_reg_1_data_tmp[2]\);
    
    N_35_i : CFG2
      generic map(INIT => x"2")

      port map(A => pwm_enable_reg(8), B => sync_pulse_1, Y => 
        \N_35_i\);
    
    
        \PWM_output_select.8.PWM_output_generation.un280_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(126), B => period_cnt(12), C
         => period_cnt(13), D => pwm_posedge_reg(125), FCI => 
        \un280_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un280_pwm_enable_reg_1_data_tmp[6]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un107_pwm_enable_reg_0_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(34), B => period_cnt(0), C
         => period_cnt(1), D => pwm_negedge_reg(33), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un107_pwm_enable_reg_0_data_tmp[0]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un163_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(76), B => pwm_negedge_reg(75), 
        C => pwm_negedge_reg(76), D => pwm_posedge_reg(75), FCI
         => \un163_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y
         => OPEN, FCO => \un163_pwm_enable_reg_1_data_tmp[5]\);
    
    \PWM_int_RNO[7]\ : CFG4
      generic map(INIT => x"00C4")

      port map(A => \PWM_c[6]\, B => \N_30_i\, C => 
        \un239_pwm_enable_reg_1_data_tmp[7]\, D => 
        un242_pwm_enable_reg, Y => N_16_i);
    
    
        \PWM_output_select.7.PWM_output_generation.un239_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(106), B => 
        pwm_negedge_reg(105), C => pwm_negedge_reg(106), D => 
        pwm_posedge_reg(105), FCI => 
        \un239_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un239_pwm_enable_reg_1_data_tmp[4]\);
    
    \PWM_int[2]\ : SLE
      port map(D => N_34_i, CLK => CCC_0_GL1, EN => 
        \un1_pwm_enable_reg_6_i[0]\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \PWM_c[1]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un239_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(112), B => 
        pwm_negedge_reg(111), C => pwm_negedge_reg(112), D => 
        pwm_posedge_reg(111), FCI => 
        \un239_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => \un239_pwm_enable_reg_1_data_tmp[7]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un259_pwm_enable_reg_0_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(108), B => period_cnt(10), C
         => period_cnt(11), D => pwm_negedge_reg(107), FCI => 
        \un259_pwm_enable_reg_0_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un259_pwm_enable_reg_0_data_tmp[5]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un221_pwm_enable_reg_0_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(96), B => period_cnt(14), C
         => period_cnt(15), D => pwm_negedge_reg(95), FCI => 
        \un221_pwm_enable_reg_0_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => \un221_pwm_enable_reg_0_data_tmp[7]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un31_pwm_enable_reg_0_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(10), B => period_cnt(8), C
         => period_cnt(9), D => pwm_negedge_reg(9), FCI => 
        \un31_pwm_enable_reg_0_data_tmp[3]\, S => OPEN, Y => OPEN, 
        FCO => \un31_pwm_enable_reg_0_data_tmp[4]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un221_pwm_enable_reg_0_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(84), B => period_cnt(2), C
         => period_cnt(3), D => pwm_negedge_reg(83), FCI => 
        \un221_pwm_enable_reg_0_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un221_pwm_enable_reg_0_data_tmp[1]\);
    
    \PWM_int_RNO[1]\ : CFG4
      generic map(INIT => x"00C4")

      port map(A => \PWM_c[0]\, B => un4_pwm_enable_reg, C => 
        \un11_pwm_enable_reg_1_data_tmp[7]\, D => 
        un14_pwm_enable_reg, Y => N_41_i);
    
    
        \PWM_output_select.5.PWM_output_generation.un183_pwm_enable_reg_0_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(72), B => period_cnt(6), C
         => period_cnt(7), D => pwm_negedge_reg(71), FCI => 
        \un183_pwm_enable_reg_0_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un183_pwm_enable_reg_0_data_tmp[3]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un11_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(2), B => pwm_negedge_reg(1), 
        C => pwm_negedge_reg(2), D => pwm_posedge_reg(1), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un11_pwm_enable_reg_1_data_tmp[0]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un297_pwm_enable_reg_0_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(126), B => period_cnt(12), C
         => period_cnt(13), D => pwm_negedge_reg(125), FCI => 
        \un297_pwm_enable_reg_0_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un297_pwm_enable_reg_0_data_tmp[6]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un166_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(66), B => period_cnt(0), C
         => period_cnt(1), D => pwm_posedge_reg(65), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un166_pwm_enable_reg_1_data_tmp[0]\);
    
    \PWM_int_RNO[4]\ : CFG4
      generic map(INIT => x"00C4")

      port map(A => \PWM_c[3]\, B => \N_38_i\, C => 
        \un125_pwm_enable_reg_1_data_tmp[7]\, D => 
        un128_pwm_enable_reg, Y => N_32_i);
    
    
        \PWM_output_select.2.PWM_output_generation.un69_pwm_enable_reg_0_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(24), B => period_cnt(6), C
         => period_cnt(7), D => pwm_negedge_reg(23), FCI => 
        \un69_pwm_enable_reg_0_data_tmp[2]\, S => OPEN, Y => OPEN, 
        FCO => \un69_pwm_enable_reg_0_data_tmp[3]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un14_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(8), B => period_cnt(6), C => 
        period_cnt(7), D => pwm_posedge_reg(7), FCI => 
        \un14_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y => OPEN, 
        FCO => \un14_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un166_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(70), B => period_cnt(4), C
         => period_cnt(5), D => pwm_posedge_reg(69), FCI => 
        \un166_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un166_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un183_pwm_enable_reg_0_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(80), B => period_cnt(14), C
         => period_cnt(15), D => pwm_negedge_reg(79), FCI => 
        \un183_pwm_enable_reg_0_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => \un183_pwm_enable_reg_0_data_tmp[7]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un128_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(54), B => period_cnt(4), C
         => period_cnt(5), D => pwm_posedge_reg(53), FCI => 
        \un128_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un128_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un49_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(32), B => pwm_negedge_reg(31), 
        C => pwm_negedge_reg(32), D => pwm_posedge_reg(31), FCI
         => \un49_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => \un49_pwm_enable_reg_1_data_tmp[7]\);
    
    \PWM_int[3]\ : SLE
      port map(D => N_33_i, CLK => CCC_0_GL1, EN => 
        \un1_pwm_enable_reg_5_i[0]\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \PWM_c[2]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un128_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(62), B => period_cnt(12), C
         => period_cnt(13), D => pwm_posedge_reg(61), FCI => 
        \un128_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un128_pwm_enable_reg_1_data_tmp[6]\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    
        \PWM_output_select.5.PWM_output_generation.un163_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(70), B => pwm_negedge_reg(69), 
        C => pwm_negedge_reg(70), D => pwm_posedge_reg(69), FCI
         => \un163_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y
         => OPEN, FCO => \un163_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un280_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(118), B => period_cnt(4), C
         => period_cnt(5), D => pwm_posedge_reg(117), FCI => 
        \un280_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un280_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un163_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(68), B => pwm_negedge_reg(67), 
        C => pwm_negedge_reg(68), D => pwm_posedge_reg(67), FCI
         => \un163_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y
         => OPEN, FCO => \un163_pwm_enable_reg_1_data_tmp[1]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un277_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(120), B => 
        pwm_negedge_reg(119), C => pwm_negedge_reg(120), D => 
        pwm_posedge_reg(119), FCI => 
        \un277_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un277_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un239_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(100), B => 
        pwm_negedge_reg(99), C => pwm_negedge_reg(100), D => 
        pwm_posedge_reg(99), FCI => 
        \un239_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un239_pwm_enable_reg_1_data_tmp[1]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un204_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(84), B => period_cnt(2), C
         => period_cnt(3), D => pwm_posedge_reg(83), FCI => 
        \un204_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un204_pwm_enable_reg_1_data_tmp[1]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un31_pwm_enable_reg_0_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(4), B => period_cnt(2), C => 
        period_cnt(3), D => pwm_negedge_reg(3), FCI => 
        \un31_pwm_enable_reg_0_data_tmp[0]\, S => OPEN, Y => OPEN, 
        FCO => \un31_pwm_enable_reg_0_data_tmp[1]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un280_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(116), B => period_cnt(2), C
         => period_cnt(3), D => pwm_posedge_reg(115), FCI => 
        \un280_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un280_pwm_enable_reg_1_data_tmp[1]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un90_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(44), B => period_cnt(10), C
         => period_cnt(11), D => pwm_posedge_reg(43), FCI => 
        \un90_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y => OPEN, 
        FCO => \un90_pwm_enable_reg_1_data_tmp[5]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un87_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(34), B => pwm_negedge_reg(33), 
        C => pwm_negedge_reg(34), D => pwm_posedge_reg(33), FCI
         => GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un87_pwm_enable_reg_1_data_tmp[0]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un259_pwm_enable_reg_0_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(98), B => period_cnt(0), C
         => period_cnt(1), D => pwm_negedge_reg(97), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un259_pwm_enable_reg_0_data_tmp[0]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un107_pwm_enable_reg_0_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(44), B => period_cnt(10), C
         => period_cnt(11), D => pwm_negedge_reg(43), FCI => 
        \un107_pwm_enable_reg_0_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un107_pwm_enable_reg_0_data_tmp[5]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un145_pwm_enable_reg_0_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(60), B => period_cnt(10), C
         => period_cnt(11), D => pwm_negedge_reg(59), FCI => 
        \un145_pwm_enable_reg_0_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un145_pwm_enable_reg_0_data_tmp[5]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un242_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(102), B => period_cnt(4), C
         => period_cnt(5), D => pwm_posedge_reg(101), FCI => 
        \un242_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un242_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un4_pwm_enable_reg\ : 
        CFG2
      generic map(INIT => x"2")

      port map(A => pwm_enable_reg(1), B => sync_pulse_1, Y => 
        un4_pwm_enable_reg);
    
    
        \PWM_output_select.1.PWM_output_generation.un31_pwm_enable_reg_0_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(16), B => period_cnt(14), C
         => period_cnt(15), D => pwm_negedge_reg(15), FCI => 
        \un31_pwm_enable_reg_0_data_tmp[6]\, S => OPEN, Y => OPEN, 
        FCO => \un31_pwm_enable_reg_0_data_tmp[7]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un31_pwm_enable_reg_0_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(6), B => period_cnt(4), C => 
        period_cnt(5), D => pwm_negedge_reg(5), FCI => 
        \un31_pwm_enable_reg_0_data_tmp[1]\, S => OPEN, Y => OPEN, 
        FCO => \un31_pwm_enable_reg_0_data_tmp[2]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un239_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(102), B => 
        pwm_negedge_reg(101), C => pwm_negedge_reg(102), D => 
        pwm_posedge_reg(101), FCI => 
        \un239_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un239_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un69_pwm_enable_reg_0_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(18), B => period_cnt(0), C
         => period_cnt(1), D => pwm_negedge_reg(17), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un69_pwm_enable_reg_0_data_tmp[0]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un49_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(22), B => pwm_negedge_reg(21), 
        C => pwm_negedge_reg(22), D => pwm_posedge_reg(21), FCI
         => \un49_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un49_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un145_pwm_enable_reg_0_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(52), B => period_cnt(2), C
         => period_cnt(3), D => pwm_negedge_reg(51), FCI => 
        \un145_pwm_enable_reg_0_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un145_pwm_enable_reg_0_data_tmp[1]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un277_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(114), B => 
        pwm_negedge_reg(113), C => pwm_negedge_reg(114), D => 
        pwm_posedge_reg(113), FCI => GND_net_1, S => OPEN, Y => 
        OPEN, FCO => \un277_pwm_enable_reg_1_data_tmp[0]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un204_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(82), B => period_cnt(0), C
         => period_cnt(1), D => pwm_posedge_reg(81), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un204_pwm_enable_reg_1_data_tmp[0]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un145_pwm_enable_reg_0_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(64), B => period_cnt(14), C
         => period_cnt(15), D => pwm_negedge_reg(63), FCI => 
        \un145_pwm_enable_reg_0_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => \un145_pwm_enable_reg_0_data_tmp[7]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un11_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(10), B => pwm_negedge_reg(9), 
        C => pwm_negedge_reg(10), D => pwm_posedge_reg(9), FCI
         => \un11_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un11_pwm_enable_reg_1_data_tmp[4]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un125_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(62), B => pwm_negedge_reg(61), 
        C => pwm_negedge_reg(62), D => pwm_posedge_reg(61), FCI
         => \un125_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y
         => OPEN, FCO => \un125_pwm_enable_reg_1_data_tmp[6]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un125_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(64), B => pwm_negedge_reg(63), 
        C => pwm_negedge_reg(64), D => pwm_posedge_reg(63), FCI
         => \un125_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y
         => OPEN, FCO => \un125_pwm_enable_reg_1_data_tmp[7]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un163_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(66), B => pwm_negedge_reg(65), 
        C => pwm_negedge_reg(66), D => pwm_posedge_reg(65), FCI
         => GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un163_pwm_enable_reg_1_data_tmp[0]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un87_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(42), B => pwm_negedge_reg(41), 
        C => pwm_negedge_reg(42), D => pwm_posedge_reg(41), FCI
         => \un87_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un87_pwm_enable_reg_1_data_tmp[4]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un128_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(60), B => period_cnt(10), C
         => period_cnt(11), D => pwm_posedge_reg(59), FCI => 
        \un128_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un128_pwm_enable_reg_1_data_tmp[5]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un201_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(96), B => pwm_negedge_reg(95), 
        C => pwm_negedge_reg(96), D => pwm_posedge_reg(95), FCI
         => \un201_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y
         => OPEN, FCO => \un201_pwm_enable_reg_1_data_tmp[7]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un87_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(40), B => pwm_negedge_reg(39), 
        C => pwm_negedge_reg(40), D => pwm_posedge_reg(39), FCI
         => \un87_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un87_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un52_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(30), B => period_cnt(12), C
         => period_cnt(13), D => pwm_posedge_reg(29), FCI => 
        \un52_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y => OPEN, 
        FCO => \un52_pwm_enable_reg_1_data_tmp[6]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un31_pwm_enable_reg_0_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(14), B => period_cnt(12), C
         => period_cnt(13), D => pwm_negedge_reg(13), FCI => 
        \un31_pwm_enable_reg_0_data_tmp[5]\, S => OPEN, Y => OPEN, 
        FCO => \un31_pwm_enable_reg_0_data_tmp[6]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un52_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(28), B => period_cnt(10), C
         => period_cnt(11), D => pwm_posedge_reg(27), FCI => 
        \un52_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y => OPEN, 
        FCO => \un52_pwm_enable_reg_1_data_tmp[5]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un221_pwm_enable_reg_0_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(86), B => period_cnt(4), C
         => period_cnt(5), D => pwm_negedge_reg(85), FCI => 
        \un221_pwm_enable_reg_0_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un221_pwm_enable_reg_0_data_tmp[2]\);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    
        \PWM_output_select.5.PWM_output_generation.un183_pwm_enable_reg_0_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(74), B => period_cnt(8), C
         => period_cnt(9), D => pwm_negedge_reg(73), FCI => 
        \un183_pwm_enable_reg_0_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un183_pwm_enable_reg_0_data_tmp[4]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un297_pwm_enable_reg_0_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(114), B => period_cnt(0), C
         => period_cnt(1), D => pwm_negedge_reg(113), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un297_pwm_enable_reg_0_data_tmp[0]\);
    
    \PWM_int_RNO_0[1]\ : CFG4
      generic map(INIT => x"1BBB")

      port map(A => un4_pwm_enable_reg, B => pwm_enable_reg(1), C
         => un14_pwm_enable_reg, D => 
        \un31_pwm_enable_reg_0_data_tmp[7]\, Y => 
        \un1_pwm_enable_reg_7_i[0]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un204_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(90), B => period_cnt(8), C
         => period_cnt(9), D => pwm_posedge_reg(89), FCI => 
        \un204_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un204_pwm_enable_reg_1_data_tmp[4]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un201_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(94), B => pwm_negedge_reg(93), 
        C => pwm_negedge_reg(94), D => pwm_posedge_reg(93), FCI
         => \un201_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y
         => OPEN, FCO => \un201_pwm_enable_reg_1_data_tmp[6]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un69_pwm_enable_reg_0_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(28), B => period_cnt(10), C
         => period_cnt(11), D => pwm_negedge_reg(27), FCI => 
        \un69_pwm_enable_reg_0_data_tmp[4]\, S => OPEN, Y => OPEN, 
        FCO => \un69_pwm_enable_reg_0_data_tmp[5]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un128_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(58), B => period_cnt(8), C
         => period_cnt(9), D => pwm_posedge_reg(57), FCI => 
        \un128_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un128_pwm_enable_reg_1_data_tmp[4]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un259_pwm_enable_reg_0_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(100), B => period_cnt(2), C
         => period_cnt(3), D => pwm_negedge_reg(99), FCI => 
        \un259_pwm_enable_reg_0_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un259_pwm_enable_reg_0_data_tmp[1]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un90_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(34), B => period_cnt(0), C
         => period_cnt(1), D => pwm_posedge_reg(33), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un90_pwm_enable_reg_1_data_tmp[0]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un14_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(10), B => period_cnt(8), C
         => period_cnt(9), D => pwm_posedge_reg(9), FCI => 
        \un14_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y => OPEN, 
        FCO => \un14_pwm_enable_reg_1_data_tmp[4]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un239_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(104), B => 
        pwm_negedge_reg(103), C => pwm_negedge_reg(104), D => 
        pwm_posedge_reg(103), FCI => 
        \un239_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un239_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un52_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(18), B => period_cnt(0), C
         => period_cnt(1), D => pwm_posedge_reg(17), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un52_pwm_enable_reg_1_data_tmp[0]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un52_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(20), B => period_cnt(2), C
         => period_cnt(3), D => pwm_posedge_reg(19), FCI => 
        \un52_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y => OPEN, 
        FCO => \un52_pwm_enable_reg_1_data_tmp[1]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un145_pwm_enable_reg_0_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(54), B => period_cnt(4), C
         => period_cnt(5), D => pwm_negedge_reg(53), FCI => 
        \un145_pwm_enable_reg_0_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un145_pwm_enable_reg_0_data_tmp[2]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un107_pwm_enable_reg_0_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(48), B => period_cnt(14), C
         => period_cnt(15), D => pwm_negedge_reg(47), FCI => 
        \un107_pwm_enable_reg_0_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => \un107_pwm_enable_reg_0_data_tmp[7]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un221_pwm_enable_reg_0_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(94), B => period_cnt(12), C
         => period_cnt(13), D => pwm_negedge_reg(93), FCI => 
        \un221_pwm_enable_reg_0_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un221_pwm_enable_reg_0_data_tmp[6]\);
    
    \PWM_int[4]\ : SLE
      port map(D => N_32_i, CLK => CCC_0_GL1, EN => 
        \un1_pwm_enable_reg_4_i[0]\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \PWM_c[3]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un69_pwm_enable_reg_0_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(32), B => period_cnt(14), C
         => period_cnt(15), D => pwm_negedge_reg(31), FCI => 
        \un69_pwm_enable_reg_0_data_tmp[6]\, S => OPEN, Y => OPEN, 
        FCO => \un69_pwm_enable_reg_0_data_tmp[7]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un31_pwm_enable_reg_0_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(12), B => period_cnt(10), C
         => period_cnt(11), D => pwm_negedge_reg(11), FCI => 
        \un31_pwm_enable_reg_0_data_tmp[4]\, S => OPEN, Y => OPEN, 
        FCO => \un31_pwm_enable_reg_0_data_tmp[5]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un201_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(84), B => pwm_negedge_reg(83), 
        C => pwm_negedge_reg(84), D => pwm_posedge_reg(83), FCI
         => \un201_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y
         => OPEN, FCO => \un201_pwm_enable_reg_1_data_tmp[1]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un163_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(72), B => pwm_negedge_reg(71), 
        C => pwm_negedge_reg(72), D => pwm_posedge_reg(71), FCI
         => \un163_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y
         => OPEN, FCO => \un163_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un87_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(44), B => pwm_negedge_reg(43), 
        C => pwm_negedge_reg(44), D => pwm_posedge_reg(43), FCI
         => \un87_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un87_pwm_enable_reg_1_data_tmp[5]\);
    
    N_39_i : CFG2
      generic map(INIT => x"2")

      port map(A => pwm_enable_reg(3), B => sync_pulse_1, Y => 
        \N_39_i\);
    
    
        \PWM_output_select.4.PWM_output_generation.un145_pwm_enable_reg_0_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(50), B => period_cnt(0), C
         => period_cnt(1), D => pwm_negedge_reg(49), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un145_pwm_enable_reg_0_data_tmp[0]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un49_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(26), B => pwm_negedge_reg(25), 
        C => pwm_negedge_reg(26), D => pwm_posedge_reg(25), FCI
         => \un49_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un49_pwm_enable_reg_1_data_tmp[4]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un11_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(8), B => pwm_negedge_reg(7), 
        C => pwm_negedge_reg(8), D => pwm_posedge_reg(7), FCI => 
        \un11_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y => OPEN, 
        FCO => \un11_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un297_pwm_enable_reg_0_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(116), B => period_cnt(2), C
         => period_cnt(3), D => pwm_negedge_reg(115), FCI => 
        \un297_pwm_enable_reg_0_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un297_pwm_enable_reg_0_data_tmp[1]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un107_pwm_enable_reg_0_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(42), B => period_cnt(8), C
         => period_cnt(9), D => pwm_negedge_reg(41), FCI => 
        \un107_pwm_enable_reg_0_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un107_pwm_enable_reg_0_data_tmp[4]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un163_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(80), B => pwm_negedge_reg(79), 
        C => pwm_negedge_reg(80), D => pwm_posedge_reg(79), FCI
         => \un163_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y
         => OPEN, FCO => \un163_pwm_enable_reg_1_data_tmp[7]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un125_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(60), B => pwm_negedge_reg(59), 
        C => pwm_negedge_reg(60), D => pwm_posedge_reg(59), FCI
         => \un125_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y
         => OPEN, FCO => \un125_pwm_enable_reg_1_data_tmp[5]\);
    
    \PWM_int_RNO_0[7]\ : CFG4
      generic map(INIT => x"1BBB")

      port map(A => \N_30_i\, B => pwm_enable_reg(7), C => 
        un242_pwm_enable_reg, D => 
        \un259_pwm_enable_reg_0_data_tmp[7]\, Y => 
        \un1_pwm_enable_reg_1_i[0]\);
    
    N_37_i : CFG2
      generic map(INIT => x"2")

      port map(A => pwm_enable_reg(5), B => sync_pulse_1, Y => 
        \N_37_i\);
    
    
        \PWM_output_select.7.PWM_output_generation.un242_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(106), B => period_cnt(8), C
         => period_cnt(9), D => pwm_posedge_reg(105), FCI => 
        \un242_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un242_pwm_enable_reg_1_data_tmp[4]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un201_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(82), B => pwm_negedge_reg(81), 
        C => pwm_negedge_reg(82), D => pwm_posedge_reg(81), FCI
         => GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un201_pwm_enable_reg_1_data_tmp[0]\);
    
    \PWM_int[5]\ : SLE
      port map(D => N_20_i, CLK => CCC_0_GL1, EN => 
        \un1_pwm_enable_reg_3_i[0]\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \PWM_c[4]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un297_pwm_enable_reg_0_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(124), B => period_cnt(10), C
         => period_cnt(11), D => pwm_negedge_reg(123), FCI => 
        \un297_pwm_enable_reg_0_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un297_pwm_enable_reg_0_data_tmp[5]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un166_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(76), B => period_cnt(10), C
         => period_cnt(11), D => pwm_posedge_reg(75), FCI => 
        \un166_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un166_pwm_enable_reg_1_data_tmp[5]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un277_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(126), B => 
        pwm_negedge_reg(125), C => pwm_negedge_reg(126), D => 
        pwm_posedge_reg(125), FCI => 
        \un277_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un277_pwm_enable_reg_1_data_tmp[6]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un297_pwm_enable_reg_0_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(122), B => period_cnt(8), C
         => period_cnt(9), D => pwm_negedge_reg(121), FCI => 
        \un297_pwm_enable_reg_0_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un297_pwm_enable_reg_0_data_tmp[4]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un277_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(118), B => 
        pwm_negedge_reg(117), C => pwm_negedge_reg(118), D => 
        pwm_posedge_reg(117), FCI => 
        \un277_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un277_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un49_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(28), B => pwm_negedge_reg(27), 
        C => pwm_negedge_reg(28), D => pwm_posedge_reg(27), FCI
         => \un49_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un49_pwm_enable_reg_1_data_tmp[5]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un259_pwm_enable_reg_0_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(112), B => period_cnt(14), C
         => period_cnt(15), D => pwm_negedge_reg(111), FCI => 
        \un259_pwm_enable_reg_0_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => \un259_pwm_enable_reg_0_data_tmp[7]\);
    
    N_38_i : CFG2
      generic map(INIT => x"2")

      port map(A => pwm_enable_reg(4), B => sync_pulse_1, Y => 
        \N_38_i\);
    
    
        \PWM_output_select.6.PWM_output_generation.un221_pwm_enable_reg_0_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(88), B => period_cnt(6), C
         => period_cnt(7), D => pwm_negedge_reg(87), FCI => 
        \un221_pwm_enable_reg_0_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un221_pwm_enable_reg_0_data_tmp[3]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un204_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(96), B => period_cnt(14), C
         => period_cnt(15), D => pwm_posedge_reg(95), FCI => 
        \un204_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => un204_pwm_enable_reg);
    
    
        \PWM_output_select.3.PWM_output_generation.un90_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(46), B => period_cnt(12), C
         => period_cnt(13), D => pwm_posedge_reg(45), FCI => 
        \un90_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y => OPEN, 
        FCO => \un90_pwm_enable_reg_1_data_tmp[6]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un69_pwm_enable_reg_0_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(22), B => period_cnt(4), C
         => period_cnt(5), D => pwm_negedge_reg(21), FCI => 
        \un69_pwm_enable_reg_0_data_tmp[1]\, S => OPEN, Y => OPEN, 
        FCO => \un69_pwm_enable_reg_0_data_tmp[2]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un11_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(6), B => pwm_negedge_reg(5), 
        C => pwm_negedge_reg(6), D => pwm_posedge_reg(5), FCI => 
        \un11_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y => OPEN, 
        FCO => \un11_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un204_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(86), B => period_cnt(4), C
         => period_cnt(5), D => pwm_posedge_reg(85), FCI => 
        \un204_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un204_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un201_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(90), B => pwm_negedge_reg(89), 
        C => pwm_negedge_reg(90), D => pwm_posedge_reg(89), FCI
         => \un201_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y
         => OPEN, FCO => \un201_pwm_enable_reg_1_data_tmp[4]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un69_pwm_enable_reg_0_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(30), B => period_cnt(12), C
         => period_cnt(13), D => pwm_negedge_reg(29), FCI => 
        \un69_pwm_enable_reg_0_data_tmp[5]\, S => OPEN, Y => OPEN, 
        FCO => \un69_pwm_enable_reg_0_data_tmp[6]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un239_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(110), B => 
        pwm_negedge_reg(109), C => pwm_negedge_reg(110), D => 
        pwm_posedge_reg(109), FCI => 
        \un239_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un239_pwm_enable_reg_1_data_tmp[6]\);
    
    \PWM_int_RNO_0[3]\ : CFG4
      generic map(INIT => x"1BBB")

      port map(A => \N_39_i\, B => pwm_enable_reg(3), C => 
        un90_pwm_enable_reg, D => 
        \un107_pwm_enable_reg_0_data_tmp[7]\, Y => 
        \un1_pwm_enable_reg_5_i[0]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un297_pwm_enable_reg_0_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(118), B => period_cnt(4), C
         => period_cnt(5), D => pwm_negedge_reg(117), FCI => 
        \un297_pwm_enable_reg_0_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un297_pwm_enable_reg_0_data_tmp[2]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un183_pwm_enable_reg_0_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(68), B => period_cnt(2), C
         => period_cnt(3), D => pwm_negedge_reg(67), FCI => 
        \un183_pwm_enable_reg_0_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un183_pwm_enable_reg_0_data_tmp[1]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un128_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(56), B => period_cnt(6), C
         => period_cnt(7), D => pwm_posedge_reg(55), FCI => 
        \un128_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un128_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un280_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(128), B => period_cnt(14), C
         => period_cnt(15), D => pwm_posedge_reg(127), FCI => 
        \un280_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => un280_pwm_enable_reg);
    
    
        \PWM_output_select.7.PWM_output_generation.un242_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(104), B => period_cnt(6), C
         => period_cnt(7), D => pwm_posedge_reg(103), FCI => 
        \un242_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un242_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un204_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(94), B => period_cnt(12), C
         => period_cnt(13), D => pwm_posedge_reg(93), FCI => 
        \un204_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un204_pwm_enable_reg_1_data_tmp[6]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un90_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(48), B => period_cnt(14), C
         => period_cnt(15), D => pwm_posedge_reg(47), FCI => 
        \un90_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y => OPEN, 
        FCO => un90_pwm_enable_reg);
    
    
        \PWM_output_select.1.PWM_output_generation.un14_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(14), B => period_cnt(12), C
         => period_cnt(13), D => pwm_posedge_reg(13), FCI => 
        \un14_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y => OPEN, 
        FCO => \un14_pwm_enable_reg_1_data_tmp[6]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un128_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(50), B => period_cnt(0), C
         => period_cnt(1), D => pwm_posedge_reg(49), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un128_pwm_enable_reg_1_data_tmp[0]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un125_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(54), B => pwm_negedge_reg(53), 
        C => pwm_negedge_reg(54), D => pwm_posedge_reg(53), FCI
         => \un125_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y
         => OPEN, FCO => \un125_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un14_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(12), B => period_cnt(10), C
         => period_cnt(11), D => pwm_posedge_reg(11), FCI => 
        \un14_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y => OPEN, 
        FCO => \un14_pwm_enable_reg_1_data_tmp[5]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un87_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(36), B => pwm_negedge_reg(35), 
        C => pwm_negedge_reg(36), D => pwm_posedge_reg(35), FCI
         => \un87_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un87_pwm_enable_reg_1_data_tmp[1]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un125_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(50), B => pwm_negedge_reg(49), 
        C => pwm_negedge_reg(50), D => pwm_posedge_reg(49), FCI
         => GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un125_pwm_enable_reg_1_data_tmp[0]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un297_pwm_enable_reg_0_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(128), B => period_cnt(14), C
         => period_cnt(15), D => pwm_negedge_reg(127), FCI => 
        \un297_pwm_enable_reg_0_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => \un297_pwm_enable_reg_0_data_tmp[7]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un259_pwm_enable_reg_0_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(102), B => period_cnt(4), C
         => period_cnt(5), D => pwm_negedge_reg(101), FCI => 
        \un259_pwm_enable_reg_0_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un259_pwm_enable_reg_0_data_tmp[2]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un145_pwm_enable_reg_0_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(58), B => period_cnt(8), C
         => period_cnt(9), D => pwm_negedge_reg(57), FCI => 
        \un145_pwm_enable_reg_0_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un145_pwm_enable_reg_0_data_tmp[4]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un259_pwm_enable_reg_0_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(106), B => period_cnt(8), C
         => period_cnt(9), D => pwm_negedge_reg(105), FCI => 
        \un259_pwm_enable_reg_0_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un259_pwm_enable_reg_0_data_tmp[4]\);
    
    \PWM_int_RNO[3]\ : CFG4
      generic map(INIT => x"00C4")

      port map(A => \PWM_c[2]\, B => \N_39_i\, C => 
        \un87_pwm_enable_reg_1_data_tmp[7]\, D => 
        un90_pwm_enable_reg, Y => N_33_i);
    
    
        \PWM_output_select.1.PWM_output_generation.un31_pwm_enable_reg_0_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(8), B => period_cnt(6), C => 
        period_cnt(7), D => pwm_negedge_reg(7), FCI => 
        \un31_pwm_enable_reg_0_data_tmp[2]\, S => OPEN, Y => OPEN, 
        FCO => \un31_pwm_enable_reg_0_data_tmp[3]\);
    
    \PWM_int_RNO[2]\ : CFG4
      generic map(INIT => x"00C4")

      port map(A => \PWM_c[1]\, B => \N_40_i\, C => 
        \un49_pwm_enable_reg_1_data_tmp[7]\, D => 
        un52_pwm_enable_reg, Y => N_34_i);
    
    
        \PWM_output_select.4.PWM_output_generation.un128_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(52), B => period_cnt(2), C
         => period_cnt(3), D => pwm_posedge_reg(51), FCI => 
        \un128_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un128_pwm_enable_reg_1_data_tmp[1]\);
    
    N_36_i : CFG2
      generic map(INIT => x"2")

      port map(A => pwm_enable_reg(6), B => sync_pulse_1, Y => 
        \N_36_i\);
    
    
        \PWM_output_select.1.PWM_output_generation.un14_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(6), B => period_cnt(4), C => 
        period_cnt(5), D => pwm_posedge_reg(5), FCI => 
        \un14_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y => OPEN, 
        FCO => \un14_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un166_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(78), B => period_cnt(12), C
         => period_cnt(13), D => pwm_posedge_reg(77), FCI => 
        \un166_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un166_pwm_enable_reg_1_data_tmp[6]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un90_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(40), B => period_cnt(6), C
         => period_cnt(7), D => pwm_posedge_reg(39), FCI => 
        \un90_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y => OPEN, 
        FCO => \un90_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un87_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(38), B => pwm_negedge_reg(37), 
        C => pwm_negedge_reg(38), D => pwm_posedge_reg(37), FCI
         => \un87_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un87_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un183_pwm_enable_reg_0_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(70), B => period_cnt(4), C
         => period_cnt(5), D => pwm_negedge_reg(69), FCI => 
        \un183_pwm_enable_reg_0_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un183_pwm_enable_reg_0_data_tmp[2]\);
    
    \PWM_int_RNO_0[2]\ : CFG4
      generic map(INIT => x"1BBB")

      port map(A => \N_40_i\, B => pwm_enable_reg(2), C => 
        un52_pwm_enable_reg, D => 
        \un69_pwm_enable_reg_0_data_tmp[7]\, Y => 
        \un1_pwm_enable_reg_6_i[0]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un125_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(52), B => pwm_negedge_reg(51), 
        C => pwm_negedge_reg(52), D => pwm_posedge_reg(51), FCI
         => \un125_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y
         => OPEN, FCO => \un125_pwm_enable_reg_1_data_tmp[1]\);
    
    N_30_i : CFG2
      generic map(INIT => x"2")

      port map(A => pwm_enable_reg(7), B => sync_pulse_1, Y => 
        \N_30_i\);
    
    
        \PWM_output_select.2.PWM_output_generation.un49_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(30), B => pwm_negedge_reg(29), 
        C => pwm_negedge_reg(30), D => pwm_posedge_reg(29), FCI
         => \un49_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un49_pwm_enable_reg_1_data_tmp[6]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un107_pwm_enable_reg_0_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(36), B => period_cnt(2), C
         => period_cnt(3), D => pwm_negedge_reg(35), FCI => 
        \un107_pwm_enable_reg_0_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un107_pwm_enable_reg_0_data_tmp[1]\);
    
    \PWM_int[1]\ : SLE
      port map(D => N_41_i, CLK => CCC_0_GL1, EN => 
        \un1_pwm_enable_reg_7_i[0]\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \PWM_c[0]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un201_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(88), B => pwm_negedge_reg(87), 
        C => pwm_negedge_reg(88), D => pwm_posedge_reg(87), FCI
         => \un201_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y
         => OPEN, FCO => \un201_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un201_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(92), B => pwm_negedge_reg(91), 
        C => pwm_negedge_reg(92), D => pwm_posedge_reg(91), FCI
         => \un201_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y
         => OPEN, FCO => \un201_pwm_enable_reg_1_data_tmp[5]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un277_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(122), B => 
        pwm_negedge_reg(121), C => pwm_negedge_reg(122), D => 
        pwm_posedge_reg(121), FCI => 
        \un277_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un277_pwm_enable_reg_1_data_tmp[4]\);
    
    \PWM_int_RNO[8]\ : CFG4
      generic map(INIT => x"00C4")

      port map(A => \PWM_c[7]\, B => \N_35_i\, C => 
        \un277_pwm_enable_reg_1_data_tmp[7]\, D => 
        un280_pwm_enable_reg, Y => N_14_i);
    
    
        \PWM_output_select.2.PWM_output_generation.un69_pwm_enable_reg_0_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(20), B => period_cnt(2), C
         => period_cnt(3), D => pwm_negedge_reg(19), FCI => 
        \un69_pwm_enable_reg_0_data_tmp[0]\, S => OPEN, Y => OPEN, 
        FCO => \un69_pwm_enable_reg_0_data_tmp[1]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un87_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(46), B => pwm_negedge_reg(45), 
        C => pwm_negedge_reg(46), D => pwm_posedge_reg(45), FCI
         => \un87_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un87_pwm_enable_reg_1_data_tmp[6]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un242_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(110), B => period_cnt(12), C
         => period_cnt(13), D => pwm_posedge_reg(109), FCI => 
        \un242_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un242_pwm_enable_reg_1_data_tmp[6]\);
    
    \PWM_int_RNO_0[4]\ : CFG4
      generic map(INIT => x"1BBB")

      port map(A => \N_38_i\, B => pwm_enable_reg(4), C => 
        un128_pwm_enable_reg, D => 
        \un145_pwm_enable_reg_0_data_tmp[7]\, Y => 
        \un1_pwm_enable_reg_4_i[0]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un201_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(86), B => pwm_negedge_reg(85), 
        C => pwm_negedge_reg(86), D => pwm_posedge_reg(85), FCI
         => \un201_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y
         => OPEN, FCO => \un201_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un297_pwm_enable_reg_0_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(120), B => period_cnt(6), C
         => period_cnt(7), D => pwm_negedge_reg(119), FCI => 
        \un297_pwm_enable_reg_0_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un297_pwm_enable_reg_0_data_tmp[3]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un49_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(20), B => pwm_negedge_reg(19), 
        C => pwm_negedge_reg(20), D => pwm_posedge_reg(19), FCI
         => \un49_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un49_pwm_enable_reg_1_data_tmp[1]\);
    
    \PWM_int[6]\ : SLE
      port map(D => N_18_i, CLK => CCC_0_GL1, EN => 
        \un1_pwm_enable_reg_2_i[0]\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \PWM_c[5]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un31_pwm_enable_reg_0_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(2), B => period_cnt(0), C => 
        period_cnt(1), D => pwm_negedge_reg(1), FCI => GND_net_1, 
        S => OPEN, Y => OPEN, FCO => 
        \un31_pwm_enable_reg_0_data_tmp[0]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un259_pwm_enable_reg_0_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(110), B => period_cnt(12), C
         => period_cnt(13), D => pwm_negedge_reg(109), FCI => 
        \un259_pwm_enable_reg_0_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un259_pwm_enable_reg_0_data_tmp[6]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un239_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(98), B => pwm_negedge_reg(97), 
        C => pwm_negedge_reg(98), D => pwm_posedge_reg(97), FCI
         => GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un239_pwm_enable_reg_1_data_tmp[0]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un107_pwm_enable_reg_0_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(40), B => period_cnt(6), C
         => period_cnt(7), D => pwm_negedge_reg(39), FCI => 
        \un107_pwm_enable_reg_0_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un107_pwm_enable_reg_0_data_tmp[3]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un14_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(4), B => period_cnt(2), C => 
        period_cnt(3), D => pwm_posedge_reg(3), FCI => 
        \un14_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y => OPEN, 
        FCO => \un14_pwm_enable_reg_1_data_tmp[1]\);
    
    \PWM_int_RNO_0[6]\ : CFG4
      generic map(INIT => x"1BBB")

      port map(A => \N_36_i\, B => pwm_enable_reg(6), C => 
        un204_pwm_enable_reg, D => 
        \un221_pwm_enable_reg_0_data_tmp[7]\, Y => 
        \un1_pwm_enable_reg_2_i[0]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un183_pwm_enable_reg_0_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(66), B => period_cnt(0), C
         => period_cnt(1), D => pwm_negedge_reg(65), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un183_pwm_enable_reg_0_data_tmp[0]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un107_pwm_enable_reg_0_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(46), B => period_cnt(12), C
         => period_cnt(13), D => pwm_negedge_reg(45), FCI => 
        \un107_pwm_enable_reg_0_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un107_pwm_enable_reg_0_data_tmp[6]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un221_pwm_enable_reg_0_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(92), B => period_cnt(10), C
         => period_cnt(11), D => pwm_negedge_reg(91), FCI => 
        \un221_pwm_enable_reg_0_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un221_pwm_enable_reg_0_data_tmp[5]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un125_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(58), B => pwm_negedge_reg(57), 
        C => pwm_negedge_reg(58), D => pwm_posedge_reg(57), FCI
         => \un125_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y
         => OPEN, FCO => \un125_pwm_enable_reg_1_data_tmp[4]\);
    
    \PWM_int_RNO_0[5]\ : CFG4
      generic map(INIT => x"1BBB")

      port map(A => \N_37_i\, B => pwm_enable_reg(5), C => 
        un166_pwm_enable_reg, D => 
        \un183_pwm_enable_reg_0_data_tmp[7]\, Y => 
        \un1_pwm_enable_reg_3_i[0]\);
    
    \PWM_int[7]\ : SLE
      port map(D => N_16_i, CLK => CCC_0_GL1, EN => 
        \un1_pwm_enable_reg_1_i[0]\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \PWM_c[6]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un239_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(108), B => 
        pwm_negedge_reg(107), C => pwm_negedge_reg(108), D => 
        pwm_posedge_reg(107), FCI => 
        \un239_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un239_pwm_enable_reg_1_data_tmp[5]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un14_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(16), B => period_cnt(14), C
         => period_cnt(15), D => pwm_posedge_reg(15), FCI => 
        \un14_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y => OPEN, 
        FCO => un14_pwm_enable_reg);
    
    
        \PWM_output_select.2.PWM_output_generation.un49_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(24), B => pwm_negedge_reg(23), 
        C => pwm_negedge_reg(24), D => pwm_posedge_reg(23), FCI
         => \un49_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un49_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un259_pwm_enable_reg_0_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(104), B => period_cnt(6), C
         => period_cnt(7), D => pwm_negedge_reg(103), FCI => 
        \un259_pwm_enable_reg_0_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un259_pwm_enable_reg_0_data_tmp[3]\);
    
    
        \PWM_output_select.3.PWM_output_generation.un107_pwm_enable_reg_0_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(38), B => period_cnt(4), C
         => period_cnt(5), D => pwm_negedge_reg(37), FCI => 
        \un107_pwm_enable_reg_0_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un107_pwm_enable_reg_0_data_tmp[2]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un280_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(122), B => period_cnt(8), C
         => period_cnt(9), D => pwm_posedge_reg(121), FCI => 
        \un280_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un280_pwm_enable_reg_1_data_tmp[4]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un280_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(120), B => period_cnt(6), C
         => period_cnt(7), D => pwm_posedge_reg(119), FCI => 
        \un280_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un280_pwm_enable_reg_1_data_tmp[3]\);
    
    \PWM_int_RNO[6]\ : CFG4
      generic map(INIT => x"00C4")

      port map(A => \PWM_c[5]\, B => \N_36_i\, C => 
        \un201_pwm_enable_reg_1_data_tmp[7]\, D => 
        un204_pwm_enable_reg, Y => N_18_i);
    
    \PWM_int[8]\ : SLE
      port map(D => N_14_i, CLK => CCC_0_GL1, EN => 
        \un1_pwm_enable_reg_i[0]\, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \PWM_c[7]\);
    
    
        \PWM_output_select.1.PWM_output_generation.un11_pwm_enable_reg_1_I_39\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(14), B => pwm_negedge_reg(13), 
        C => pwm_negedge_reg(14), D => pwm_posedge_reg(13), FCI
         => \un11_pwm_enable_reg_1_data_tmp[5]\, S => OPEN, Y => 
        OPEN, FCO => \un11_pwm_enable_reg_1_data_tmp[6]\);
    
    \PWM_int_RNO[5]\ : CFG4
      generic map(INIT => x"00C4")

      port map(A => \PWM_c[4]\, B => \N_37_i\, C => 
        \un163_pwm_enable_reg_1_data_tmp[7]\, D => 
        un166_pwm_enable_reg, Y => N_20_i);
    
    
        \PWM_output_select.5.PWM_output_generation.un166_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(74), B => period_cnt(8), C
         => period_cnt(9), D => pwm_posedge_reg(73), FCI => 
        \un166_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un166_pwm_enable_reg_1_data_tmp[4]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un52_pwm_enable_reg_1_I_15\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(22), B => period_cnt(4), C
         => period_cnt(5), D => pwm_posedge_reg(21), FCI => 
        \un52_pwm_enable_reg_1_data_tmp[1]\, S => OPEN, Y => OPEN, 
        FCO => \un52_pwm_enable_reg_1_data_tmp[2]\);
    
    
        \PWM_output_select.8.PWM_output_generation.un277_pwm_enable_reg_1_I_33\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(124), B => 
        pwm_negedge_reg(123), C => pwm_negedge_reg(124), D => 
        pwm_posedge_reg(123), FCI => 
        \un277_pwm_enable_reg_1_data_tmp[4]\, S => OPEN, Y => 
        OPEN, FCO => \un277_pwm_enable_reg_1_data_tmp[5]\);
    
    
        \PWM_output_select.2.PWM_output_generation.un52_pwm_enable_reg_1_I_27\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(24), B => period_cnt(6), C
         => period_cnt(7), D => pwm_posedge_reg(23), FCI => 
        \un52_pwm_enable_reg_1_data_tmp[2]\, S => OPEN, Y => OPEN, 
        FCO => \un52_pwm_enable_reg_1_data_tmp[3]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un242_pwm_enable_reg_1_I_1\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(98), B => period_cnt(0), C
         => period_cnt(1), D => pwm_posedge_reg(97), FCI => 
        GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un242_pwm_enable_reg_1_data_tmp[0]\);
    
    
        \PWM_output_select.6.PWM_output_generation.un221_pwm_enable_reg_0_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_negedge_reg(90), B => period_cnt(8), C
         => period_cnt(9), D => pwm_negedge_reg(89), FCI => 
        \un221_pwm_enable_reg_0_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un221_pwm_enable_reg_0_data_tmp[4]\);
    
    
        \PWM_output_select.5.PWM_output_generation.un163_pwm_enable_reg_1_I_45\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(74), B => pwm_negedge_reg(73), 
        C => pwm_negedge_reg(74), D => pwm_posedge_reg(73), FCI
         => \un163_pwm_enable_reg_1_data_tmp[3]\, S => OPEN, Y
         => OPEN, FCO => \un163_pwm_enable_reg_1_data_tmp[4]\);
    
    
        \PWM_output_select.4.PWM_output_generation.un128_pwm_enable_reg_1_I_21\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(64), B => period_cnt(14), C
         => period_cnt(15), D => pwm_posedge_reg(63), FCI => 
        \un128_pwm_enable_reg_1_data_tmp[6]\, S => OPEN, Y => 
        OPEN, FCO => un128_pwm_enable_reg);
    
    
        \PWM_output_select.1.PWM_output_generation.un11_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(4), B => pwm_negedge_reg(3), 
        C => pwm_negedge_reg(4), D => pwm_posedge_reg(3), FCI => 
        \un11_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y => OPEN, 
        FCO => \un11_pwm_enable_reg_1_data_tmp[1]\);
    
    
        \PWM_output_select.7.PWM_output_generation.un242_pwm_enable_reg_1_I_9\ : 
        ARI1
      generic map(INIT => x"68421")

      port map(A => pwm_posedge_reg(100), B => period_cnt(2), C
         => period_cnt(3), D => pwm_posedge_reg(99), FCI => 
        \un242_pwm_enable_reg_1_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un242_pwm_enable_reg_1_data_tmp[1]\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity corepwm_reg_if is

    port( PRDATA_regif_0_iv_0_0              : out   std_logic_vector(15 downto 8);
          PRDATA_regif_iv_0_0                : out   std_logic_vector(7 downto 4);
          CoreAPB3_0_APBmslave0_PADDR        : in    std_logic_vector(7 downto 2);
          period_cnt                         : in    std_logic_vector(15 downto 0);
          period_reg                         : out   std_logic_vector(15 downto 0);
          prescale_reg                       : out   std_logic_vector(15 downto 0);
          pwm_posedge_reg                    : out   std_logic_vector(128 downto 1);
          pwm_enable_reg                     : out   std_logic_vector(8 downto 1);
          pwm_negedge_reg                    : out   std_logic_vector(128 downto 1);
          CoreAPB3_0_APBmslave0_PWDATA       : in    std_logic_vector(15 downto 0);
          PRDATA_generated_6_0_0             : out   std_logic;
          PRDATA_generated_15_0_0_wmux_0_Y_3 : out   std_logic;
          PRDATA_generated_15_0_0_wmux_0_Y_0 : out   std_logic;
          PRDATA_generated_15_2_0_wmux_0_Y_3 : out   std_logic;
          PRDATA_generated_15_2_0_wmux_0_Y_0 : out   std_logic;
          N_166                              : out   std_logic;
          N_62                               : out   std_logic;
          un9_psel                           : out   std_logic;
          un7_psel                           : out   std_logic;
          un11_psel                          : out   std_logic;
          N_60                               : out   std_logic;
          sync_pulse_1                       : in    std_logic;
          N_174                              : out   std_logic;
          N_962                              : out   std_logic;
          N_959                              : out   std_logic;
          N_960                              : out   std_logic;
          N_966                              : out   std_logic;
          N_963                              : out   std_logic;
          N_964                              : out   std_logic;
          N_961                              : out   std_logic;
          N_965                              : out   std_logic;
          N_936                              : out   std_logic;
          N_940                              : out   std_logic;
          N_941                              : out   std_logic;
          N_939                              : out   std_logic;
          N_942                              : out   std_logic;
          N_937                              : out   std_logic;
          CoreAPB3_0_APBmslave0_PENABLE      : in    std_logic;
          CoreAPB3_0_APBmslave0_PSELx        : in    std_logic;
          CoreAPB3_0_APBmslave0_PWRITE       : in    std_logic;
          N_781                              : out   std_logic;
          N_779                              : out   std_logic;
          N_780                              : out   std_logic;
          N_732                              : out   std_logic;
          N_731                              : out   std_logic;
          N_730                              : out   std_logic;
          N_782                              : out   std_logic;
          N_777                              : out   std_logic;
          N_10_1                             : out   std_logic;
          N_729                              : out   std_logic;
          N_733                              : out   std_logic;
          N_776                              : out   std_logic;
          N_734                              : out   std_logic;
          N_728                              : out   std_logic;
          sync_update                        : out   std_logic;
          FAB_CCC_GL0                        : in    std_logic;
          MSS_READY                          : in    std_logic
        );

end corepwm_reg_if;

architecture DEF_ARCH of corepwm_reg_if is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component ARI1
    generic (INIT:std_logic_vector(19 downto 0) := x"00000");

    port( A   : in    std_logic := 'U';
          B   : in    std_logic := 'U';
          C   : in    std_logic := 'U';
          D   : in    std_logic := 'U';
          FCI : in    std_logic := 'U';
          S   : out   std_logic;
          Y   : out   std_logic;
          FCO : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

    signal \pwm_posedge_reg[29]\, VCC_net_1, 
        psh_posedge_reg_0_sqmuxa_6, GND_net_1, 
        \pwm_posedge_reg[30]\, \pwm_posedge_reg[31]\, 
        \pwm_posedge_reg[32]\, \pwm_posedge_reg[46]\, 
        \psh_posedge_reg_0_sqmuxa_3\, \pwm_posedge_reg[47]\, 
        \pwm_posedge_reg[48]\, \pwm_posedge_reg[18]\, 
        \pwm_posedge_reg[19]\, \pwm_posedge_reg[20]\, 
        \pwm_posedge_reg[21]\, \pwm_posedge_reg[22]\, 
        \pwm_posedge_reg[23]\, \pwm_posedge_reg[24]\, 
        \pwm_posedge_reg[25]\, \pwm_posedge_reg[26]\, 
        \pwm_posedge_reg[27]\, \pwm_posedge_reg[28]\, 
        \pwm_posedge_reg[63]\, psh_posedge_reg_0_sqmuxa_7, 
        \pwm_posedge_reg[64]\, \pwm_posedge_reg[33]\, 
        \pwm_posedge_reg[34]\, \pwm_posedge_reg[35]\, 
        \pwm_posedge_reg[36]\, \pwm_posedge_reg[37]\, 
        \pwm_posedge_reg[38]\, \pwm_posedge_reg[39]\, 
        \pwm_posedge_reg[40]\, \pwm_posedge_reg[41]\, 
        \pwm_posedge_reg[42]\, \pwm_posedge_reg[43]\, 
        \pwm_posedge_reg[44]\, \pwm_posedge_reg[45]\, 
        \pwm_posedge_reg[80]\, psh_posedge_reg_0_sqmuxa_4, 
        \pwm_posedge_reg[49]\, \pwm_posedge_reg[50]\, 
        \pwm_posedge_reg[51]\, \pwm_posedge_reg[52]\, 
        \pwm_posedge_reg[53]\, \pwm_posedge_reg[54]\, 
        \pwm_posedge_reg[55]\, \pwm_posedge_reg[56]\, 
        \pwm_posedge_reg[57]\, \pwm_posedge_reg[58]\, 
        \pwm_posedge_reg[59]\, \pwm_posedge_reg[60]\, 
        \pwm_posedge_reg[61]\, \pwm_posedge_reg[62]\, 
        \pwm_posedge_reg[65]\, \pwm_posedge_reg[66]\, 
        \pwm_posedge_reg[67]\, \pwm_posedge_reg[68]\, 
        \pwm_posedge_reg[69]\, \pwm_posedge_reg[70]\, 
        \pwm_posedge_reg[71]\, \pwm_posedge_reg[72]\, 
        \pwm_posedge_reg[73]\, \pwm_posedge_reg[74]\, 
        \pwm_posedge_reg[75]\, \pwm_posedge_reg[76]\, 
        \pwm_posedge_reg[77]\, \pwm_posedge_reg[78]\, 
        \pwm_posedge_reg[79]\, \pwm_posedge_reg[82]\, 
        psh_posedge_reg_0_sqmuxa_2, \pwm_posedge_reg[83]\, 
        \pwm_posedge_reg[84]\, \pwm_posedge_reg[85]\, 
        \pwm_posedge_reg[86]\, \pwm_posedge_reg[87]\, 
        \pwm_posedge_reg[88]\, \pwm_posedge_reg[89]\, 
        \pwm_posedge_reg[90]\, \pwm_posedge_reg[91]\, 
        \pwm_posedge_reg[92]\, \pwm_posedge_reg[93]\, 
        \pwm_posedge_reg[94]\, \pwm_posedge_reg[95]\, 
        \pwm_posedge_reg[96]\, \pwm_posedge_reg[99]\, 
        psh_posedge_reg_0_sqmuxa_5, \pwm_posedge_reg[100]\, 
        \pwm_posedge_reg[101]\, \pwm_posedge_reg[102]\, 
        \pwm_posedge_reg[103]\, \pwm_posedge_reg[104]\, 
        \pwm_posedge_reg[105]\, \pwm_posedge_reg[106]\, 
        \pwm_posedge_reg[107]\, \pwm_posedge_reg[108]\, 
        \pwm_posedge_reg[109]\, \pwm_posedge_reg[110]\, 
        \pwm_posedge_reg[111]\, \pwm_posedge_reg[112]\, 
        \pwm_posedge_reg[81]\, \pwm_posedge_reg[116]\, 
        psh_posedge_reg_0_sqmuxa_1, \pwm_posedge_reg[117]\, 
        \pwm_posedge_reg[118]\, \pwm_posedge_reg[119]\, 
        \pwm_posedge_reg[120]\, \pwm_posedge_reg[121]\, 
        \pwm_posedge_reg[122]\, \pwm_posedge_reg[123]\, 
        \pwm_posedge_reg[124]\, \pwm_posedge_reg[125]\, 
        \pwm_posedge_reg[126]\, \pwm_posedge_reg[127]\, 
        \pwm_posedge_reg[128]\, \pwm_posedge_reg[97]\, 
        \pwm_posedge_reg[98]\, \pwm_negedge_reg[5]\, 
        psh_negedge_reg_1_sqmuxa, \pwm_negedge_reg[6]\, 
        \pwm_negedge_reg[7]\, \pwm_negedge_reg[8]\, 
        \pwm_negedge_reg[9]\, \pwm_negedge_reg[10]\, 
        \pwm_negedge_reg[11]\, \pwm_negedge_reg[12]\, 
        \pwm_negedge_reg[13]\, \pwm_negedge_reg[14]\, 
        \pwm_negedge_reg[15]\, \pwm_negedge_reg[16]\, 
        \pwm_posedge_reg[113]\, \pwm_posedge_reg[114]\, 
        \pwm_posedge_reg[115]\, \pwm_negedge_reg[22]\, 
        psh_negedge_reg_1_sqmuxa_5, \pwm_negedge_reg[23]\, 
        \pwm_negedge_reg[24]\, \pwm_negedge_reg[25]\, 
        \pwm_negedge_reg[26]\, \pwm_negedge_reg[27]\, 
        \pwm_negedge_reg[28]\, \pwm_negedge_reg[29]\, 
        \pwm_negedge_reg[30]\, \pwm_negedge_reg[31]\, 
        \pwm_negedge_reg[32]\, \pwm_negedge_reg[2]\, 
        \pwm_negedge_reg[3]\, \pwm_negedge_reg[4]\, 
        \pwm_negedge_reg[39]\, psh_negedge_reg_1_sqmuxa_4, 
        \pwm_negedge_reg[40]\, \pwm_negedge_reg[41]\, 
        \pwm_negedge_reg[42]\, \pwm_negedge_reg[43]\, 
        \pwm_negedge_reg[44]\, \pwm_negedge_reg[45]\, 
        \pwm_negedge_reg[46]\, \pwm_negedge_reg[47]\, 
        \pwm_negedge_reg[48]\, \pwm_negedge_reg[18]\, 
        \pwm_negedge_reg[19]\, \pwm_negedge_reg[20]\, 
        \pwm_negedge_reg[21]\, \pwm_negedge_reg[56]\, 
        psh_negedge_reg_1_sqmuxa_1, \pwm_negedge_reg[57]\, 
        \pwm_negedge_reg[58]\, \pwm_negedge_reg[59]\, 
        \pwm_negedge_reg[60]\, \pwm_negedge_reg[61]\, 
        \pwm_negedge_reg[62]\, \pwm_negedge_reg[63]\, 
        \pwm_negedge_reg[64]\, \pwm_negedge_reg[33]\, 
        \pwm_negedge_reg[34]\, \pwm_negedge_reg[35]\, 
        \pwm_negedge_reg[36]\, \pwm_negedge_reg[37]\, 
        \pwm_negedge_reg[38]\, \pwm_negedge_reg[73]\, 
        psh_negedge_reg_1_sqmuxa_2, \pwm_negedge_reg[74]\, 
        \pwm_negedge_reg[75]\, \pwm_negedge_reg[76]\, 
        \pwm_negedge_reg[77]\, \pwm_negedge_reg[78]\, 
        \pwm_negedge_reg[79]\, \pwm_negedge_reg[80]\, 
        \pwm_negedge_reg[49]\, \pwm_negedge_reg[50]\, 
        \pwm_negedge_reg[51]\, \pwm_negedge_reg[52]\, 
        \pwm_negedge_reg[53]\, \pwm_negedge_reg[54]\, 
        \pwm_negedge_reg[55]\, \pwm_negedge_reg[90]\, 
        psh_negedge_reg_1_sqmuxa_7, \pwm_negedge_reg[91]\, 
        \pwm_negedge_reg[92]\, \pwm_negedge_reg[93]\, 
        \pwm_negedge_reg[94]\, \pwm_negedge_reg[95]\, 
        \pwm_negedge_reg[96]\, \pwm_negedge_reg[65]\, 
        \pwm_negedge_reg[66]\, \pwm_negedge_reg[67]\, 
        \pwm_negedge_reg[68]\, \pwm_negedge_reg[69]\, 
        \pwm_negedge_reg[70]\, \pwm_negedge_reg[71]\, 
        \pwm_negedge_reg[72]\, \pwm_negedge_reg[107]\, 
        psh_negedge_reg_1_sqmuxa_6, \pwm_negedge_reg[108]\, 
        \pwm_negedge_reg[109]\, \pwm_negedge_reg[110]\, 
        \pwm_negedge_reg[111]\, \pwm_negedge_reg[112]\, 
        \pwm_negedge_reg[81]\, \pwm_negedge_reg[82]\, 
        \pwm_negedge_reg[83]\, \pwm_negedge_reg[84]\, 
        \pwm_negedge_reg[85]\, \pwm_negedge_reg[86]\, 
        \pwm_negedge_reg[87]\, \pwm_negedge_reg[88]\, 
        \pwm_negedge_reg[89]\, \pwm_negedge_reg[124]\, 
        psh_negedge_reg_1_sqmuxa_3, \pwm_negedge_reg[125]\, 
        \pwm_negedge_reg[126]\, \pwm_negedge_reg[127]\, 
        \pwm_negedge_reg[128]\, \pwm_negedge_reg[97]\, 
        \pwm_negedge_reg[98]\, \pwm_negedge_reg[99]\, 
        \pwm_negedge_reg[101]\, \pwm_negedge_reg[102]\, 
        \pwm_negedge_reg[103]\, \pwm_negedge_reg[104]\, 
        \pwm_negedge_reg[105]\, \pwm_negedge_reg[106]\, 
        \pwm_enable_reg[5]\, N_75_i, \pwm_enable_reg[6]\, 
        \pwm_enable_reg[7]\, \pwm_enable_reg[8]\, 
        \pwm_negedge_reg[113]\, \pwm_negedge_reg[114]\, 
        \pwm_negedge_reg[115]\, \pwm_negedge_reg[117]\, 
        \pwm_negedge_reg[118]\, \pwm_negedge_reg[119]\, 
        \pwm_negedge_reg[120]\, \pwm_negedge_reg[121]\, 
        \pwm_negedge_reg[122]\, \pwm_negedge_reg[123]\, 
        \pwm_posedge_reg[8]\, psh_posedge_reg_0_sqmuxa, 
        \pwm_posedge_reg[9]\, \pwm_posedge_reg[10]\, 
        \pwm_posedge_reg[11]\, \pwm_posedge_reg[12]\, 
        \pwm_posedge_reg[13]\, \pwm_posedge_reg[14]\, 
        \pwm_posedge_reg[15]\, \pwm_posedge_reg[16]\, 
        \pwm_posedge_reg[2]\, \pwm_posedge_reg[3]\, 
        \pwm_posedge_reg[4]\, \pwm_posedge_reg[5]\, 
        \pwm_posedge_reg[6]\, \pwm_posedge_reg[7]\, 
        \psh_prescale_reg[3]_net_1\, prescale_reg7, 
        \prescale_reg[4]_net_1\, \psh_prescale_reg[4]_net_1\, 
        \prescale_reg[5]_net_1\, \psh_prescale_reg[5]_net_1\, 
        \prescale_reg[6]_net_1\, \psh_prescale_reg[6]_net_1\, 
        \prescale_reg[7]_net_1\, \psh_prescale_reg[7]_net_1\, 
        \prescale_reg[8]_net_1\, \psh_prescale_reg[8]_net_1\, 
        \prescale_reg[9]_net_1\, \psh_prescale_reg[9]_net_1\, 
        \prescale_reg[10]_net_1\, \psh_prescale_reg[10]_net_1\, 
        \prescale_reg[11]_net_1\, \psh_prescale_reg[11]_net_1\, 
        \prescale_reg[12]_net_1\, \psh_prescale_reg[12]_net_1\, 
        \prescale_reg[13]_net_1\, \psh_prescale_reg[13]_net_1\, 
        \prescale_reg[14]_net_1\, \psh_prescale_reg[14]_net_1\, 
        \prescale_reg[15]_net_1\, \psh_prescale_reg[15]_net_1\, 
        \period_reg[4]_net_1\, \psh_period_reg[4]_net_1\, 
        \period_reg[5]_net_1\, \psh_period_reg[5]_net_1\, 
        \period_reg[6]_net_1\, \psh_period_reg[6]_net_1\, 
        \period_reg[7]_net_1\, \psh_period_reg[7]_net_1\, 
        \period_reg[8]_net_1\, \psh_period_reg[8]_net_1\, 
        \period_reg[9]_net_1\, \psh_period_reg[9]_net_1\, 
        \period_reg[10]_net_1\, \psh_period_reg[10]_net_1\, 
        \period_reg[11]_net_1\, \psh_period_reg[11]_net_1\, 
        \period_reg[12]_net_1\, \psh_period_reg[12]_net_1\, 
        \period_reg[13]_net_1\, \psh_period_reg[13]_net_1\, 
        \period_reg[14]_net_1\, \psh_period_reg[14]_net_1\, 
        \period_reg[15]_net_1\, \psh_period_reg[15]_net_1\, 
        \psh_prescale_reg[0]_net_1\, \psh_prescale_reg[1]_net_1\, 
        \psh_prescale_reg[2]_net_1\, N_71_i, 
        \period_reg[0]_net_1\, \psh_period_reg[0]_net_1\, 
        \period_reg[1]_net_1\, \psh_period_reg[1]_net_1\, 
        \period_reg[2]_net_1\, \psh_period_reg[2]_net_1\, 
        \period_reg[3]_net_1\, \psh_period_reg[3]_net_1\, N_73_i, 
        sync_update_0_sqmuxa, un1_period_cnt_cry_0, 
        un1_period_cnt_cry_1, un1_period_cnt_cry_2, 
        un1_period_cnt_cry_3, un1_period_cnt_cry_4, 
        un1_period_cnt_cry_5, un1_period_cnt_cry_6, 
        un1_period_cnt_cry_7, un1_period_cnt_cry_8, 
        un1_period_cnt_cry_9, un1_period_cnt_cry_10, 
        un1_period_cnt_cry_11, un1_period_cnt_cry_12, 
        un1_period_cnt_cry_13, un1_period_cnt_cry_14, 
        un1_period_cnt, \PRDATA_generated_15_2_0_wmux_0_Y[1]\, 
        \PRDATA_generated_15_2_0_y0[1]\, 
        \PRDATA_generated_15_2_0_co0[1]\, 
        \PRDATA_generated_15_0_0_wmux_0_Y[1]\, 
        \PRDATA_generated_15_0_0_y0[1]\, 
        \PRDATA_generated_15_0_0_co0[1]\, 
        \PRDATA_generated_15_2_0_wmux_0_Y[7]\, 
        \PRDATA_generated_15_2_0_y0[7]\, 
        \PRDATA_generated_15_2_0_co0[7]\, 
        \PRDATA_generated_15_0_0_wmux_0_Y[7]\, 
        \PRDATA_generated_15_0_0_y0[7]\, 
        \PRDATA_generated_15_0_0_co0[7]\, 
        \PRDATA_generated_15_2_0_wmux_0_Y[6]\, 
        \PRDATA_generated_15_2_0_y0[6]\, 
        \PRDATA_generated_15_2_0_co0[6]\, 
        \PRDATA_generated_15_0_0_wmux_0_Y[6]\, 
        \PRDATA_generated_15_0_0_y0[6]\, 
        \PRDATA_generated_15_0_0_co0[6]\, 
        \PRDATA_generated_15_2_0_wmux_0_Y[5]\, 
        \PRDATA_generated_15_2_0_y0[5]\, 
        \PRDATA_generated_15_2_0_co0[5]\, 
        \PRDATA_generated_15_0_0_wmux_0_Y[5]\, 
        \PRDATA_generated_15_0_0_y0[5]\, 
        \PRDATA_generated_15_0_0_co0[5]\, 
        \PRDATA_generated_15_2_0_wmux_0_Y[4]\, 
        \PRDATA_generated_15_2_0_y0[4]\, 
        \PRDATA_generated_15_2_0_co0[4]\, 
        \PRDATA_generated_15_0_0_wmux_0_Y[4]\, 
        \PRDATA_generated_15_0_0_y0[4]\, 
        \PRDATA_generated_15_0_0_co0[4]\, 
        \PRDATA_generated_15_2_0_y0[3]\, 
        \PRDATA_generated_15_2_0_co0[3]\, 
        \PRDATA_generated_15_0_0_y0[3]\, 
        \PRDATA_generated_15_0_0_co0[3]\, 
        \PRDATA_generated_15_2_0_wmux_0_Y[2]\, 
        \PRDATA_generated_15_2_0_y0[2]\, 
        \PRDATA_generated_15_2_0_co0[2]\, 
        \PRDATA_generated_15_0_0_wmux_0_Y[2]\, 
        \PRDATA_generated_15_0_0_y0[2]\, 
        \PRDATA_generated_15_0_0_co0[2]\, 
        \PRDATA_generated_15_2_0_y0[0]\, 
        \PRDATA_generated_15_2_0_co0[0]\, 
        \PRDATA_generated_15_0_0_y0[0]\, 
        \PRDATA_generated_15_0_0_co0[0]\, N_742, 
        \PRDATA_generated_3_0_0_y0[15]\, 
        \PRDATA_generated_3_0_0_co0[15]\, N_787, 
        \PRDATA_generated_6_0_0_y0[12]\, 
        \PRDATA_generated_6_0_0_co0[12]\, N_736, 
        \PRDATA_generated_3_0_0_y0[9]\, 
        \PRDATA_generated_3_0_0_co0[9]\, N_737, 
        \PRDATA_generated_3_0_0_y0[10]\, 
        \PRDATA_generated_3_0_0_co0[10]\, 
        \PRDATA_generated_3_0_0_y0[1]\, 
        \PRDATA_generated_3_0_0_co0[1]\, N_735, 
        \PRDATA_generated_3_0_0_y0[8]\, 
        \PRDATA_generated_3_0_0_co0[8]\, 
        \PRDATA_generated_3_0_0_y0[7]\, 
        \PRDATA_generated_3_0_0_co0[7]\, 
        \PRDATA_generated_6_0_0_y0[1]\, 
        \PRDATA_generated_6_0_0_co0[1]\, 
        \PRDATA_generated_3_0_0_y0[6]\, 
        \PRDATA_generated_3_0_0_co0[6]\, 
        \PRDATA_generated_3_0_0_y0[2]\, 
        \PRDATA_generated_3_0_0_co0[2]\, N_741, 
        \PRDATA_generated_3_0_0_y0[14]\, 
        \PRDATA_generated_3_0_0_co0[14]\, N_786, 
        \PRDATA_generated_6_0_0_y0[11]\, 
        \PRDATA_generated_6_0_0_co0[11]\, 
        \PRDATA_generated_6_0_0_y0[0]\, 
        \PRDATA_generated_6_0_0_co0[0]\, N_789, 
        \PRDATA_generated_6_0_0_y0[14]\, 
        \PRDATA_generated_6_0_0_co0[14]\, 
        \PRDATA_generated_6_0_0_y0[2]\, 
        \PRDATA_generated_6_0_0_co0[2]\, N_738, 
        \PRDATA_generated_3_0_0_y0[11]\, 
        \PRDATA_generated_3_0_0_co0[11]\, N_739, 
        \PRDATA_generated_3_0_0_y0[12]\, 
        \PRDATA_generated_3_0_0_co0[12]\, N_740, 
        \PRDATA_generated_3_0_0_y0[13]\, 
        \PRDATA_generated_3_0_0_co0[13]\, 
        \PRDATA_generated_6_0_0_y0[7]\, 
        \PRDATA_generated_6_0_0_co0[7]\, 
        \PRDATA_generated_3_0_0_y0[3]\, 
        \PRDATA_generated_3_0_0_co0[3]\, 
        \PRDATA_generated_3_0_0_y0[4]\, 
        \PRDATA_generated_3_0_0_co0[4]\, 
        \PRDATA_generated_3_0_0_y0[5]\, 
        \PRDATA_generated_3_0_0_co0[5]\, N_788, 
        \PRDATA_generated_6_0_0_y0[13]\, 
        \PRDATA_generated_6_0_0_co0[13]\, N_790, 
        \PRDATA_generated_6_0_0_y0[15]\, 
        \PRDATA_generated_6_0_0_co0[15]\, 
        \PRDATA_generated_6_0_0_y0[5]\, 
        \PRDATA_generated_6_0_0_co0[5]\, N_783, 
        \PRDATA_generated_6_0_0_y0[8]\, 
        \PRDATA_generated_6_0_0_co0[8]\, N_784, 
        \PRDATA_generated_6_0_0_y0[9]\, 
        \PRDATA_generated_6_0_0_co0[9]\, N_785, 
        \PRDATA_generated_6_0_0_y0[10]\, 
        \PRDATA_generated_6_0_0_co0[10]\, 
        \PRDATA_generated_6_0_0_y0[4]\, 
        \PRDATA_generated_6_0_0_co0[4]\, 
        \PRDATA_generated_6_0_0_y0[6]\, 
        \PRDATA_generated_6_0_0_co0[6]\, N_934, 
        \PRDATA_generated_15_4_0_y1[15]\, 
        \PRDATA_generated_15_4_0_y3[15]\, 
        \PRDATA_generated_15_4_0_co1_0[15]\, 
        \PRDATA_generated_15_4_0_y0_0[15]\, 
        \PRDATA_generated_15_4_0_co0_0[15]\, 
        \PRDATA_generated_15_4_0_co1[15]\, 
        \PRDATA_generated_15_4_0_y0[15]\, 
        \PRDATA_generated_15_4_0_co0[15]\, N_931, 
        \PRDATA_generated_15_4_0_y1[12]\, 
        \PRDATA_generated_15_4_0_y3[12]\, 
        \PRDATA_generated_15_4_0_co1_0[12]\, 
        \PRDATA_generated_15_4_0_y0_0[12]\, 
        \PRDATA_generated_15_4_0_co0_0[12]\, 
        \PRDATA_generated_15_4_0_co1[12]\, 
        \PRDATA_generated_15_4_0_y0[12]\, 
        \PRDATA_generated_15_4_0_co0[12]\, N_930, 
        \PRDATA_generated_15_4_0_y1[11]\, 
        \PRDATA_generated_15_4_0_y3[11]\, 
        \PRDATA_generated_15_4_0_co1_0[11]\, 
        \PRDATA_generated_15_4_0_y0_0[11]\, 
        \PRDATA_generated_15_4_0_co0_0[11]\, 
        \PRDATA_generated_15_4_0_co1[11]\, 
        \PRDATA_generated_15_4_0_y0[11]\, 
        \PRDATA_generated_15_4_0_co0[11]\, N_929, 
        \PRDATA_generated_15_4_0_y1[10]\, 
        \PRDATA_generated_15_4_0_y3[10]\, 
        \PRDATA_generated_15_4_0_co1_0[10]\, 
        \PRDATA_generated_15_4_0_y0_0[10]\, 
        \PRDATA_generated_15_4_0_co0_0[10]\, 
        \PRDATA_generated_15_4_0_co1[10]\, 
        \PRDATA_generated_15_4_0_y0[10]\, 
        \PRDATA_generated_15_4_0_co0[10]\, N_928, 
        \PRDATA_generated_15_4_0_y1[9]\, 
        \PRDATA_generated_15_4_0_y3[9]\, 
        \PRDATA_generated_15_4_0_co1_0[9]\, 
        \PRDATA_generated_15_4_0_y0_0[9]\, 
        \PRDATA_generated_15_4_0_co0_0[9]\, 
        \PRDATA_generated_15_4_0_co1[9]\, 
        \PRDATA_generated_15_4_0_y0[9]\, 
        \PRDATA_generated_15_4_0_co0[9]\, N_927, 
        \PRDATA_generated_15_4_0_y1[8]\, 
        \PRDATA_generated_15_4_0_y3[8]\, 
        \PRDATA_generated_15_4_0_co1_0[8]\, 
        \PRDATA_generated_15_4_0_y0_0[8]\, 
        \PRDATA_generated_15_4_0_co0_0[8]\, 
        \PRDATA_generated_15_4_0_co1[8]\, 
        \PRDATA_generated_15_4_0_y0[8]\, 
        \PRDATA_generated_15_4_0_co0[8]\, N_933, 
        \PRDATA_generated_15_4_0_y1[14]\, 
        \PRDATA_generated_15_4_0_y3[14]\, 
        \PRDATA_generated_15_4_0_co1_0[14]\, 
        \PRDATA_generated_15_4_0_y0_0[14]\, 
        \PRDATA_generated_15_4_0_co0_0[14]\, 
        \PRDATA_generated_15_4_0_co1[14]\, 
        \PRDATA_generated_15_4_0_y0[14]\, 
        \PRDATA_generated_15_4_0_co0[14]\, N_932, 
        \PRDATA_generated_15_4_0_y1[13]\, 
        \PRDATA_generated_15_4_0_y3[13]\, 
        \PRDATA_generated_15_4_0_co1_0[13]\, 
        \PRDATA_generated_15_4_0_y0_0[13]\, 
        \PRDATA_generated_15_4_0_co0_0[13]\, 
        \PRDATA_generated_15_4_0_co1[13]\, 
        \PRDATA_generated_15_4_0_y0[13]\, 
        \PRDATA_generated_15_4_0_co0[13]\, 
        psh_posedge_reg_0_sqmuxa_3_2_0_1, N_69, 
        \PRDATA_generated_17_1_0[14]_net_1\, 
        \PRDATA_generated_17_1_0[10]_net_1\, 
        \PRDATA_generated_17_1_0[13]_net_1\, 
        \PRDATA_generated_17_1_0[12]_net_1\, 
        \PRDATA_generated_17_1_0[15]_net_1\, 
        \PRDATA_generated_17_1_0[9]_net_1\, 
        \PRDATA_generated_17_1_0[8]_net_1\, 
        \PRDATA_generated_17_1_0[11]_net_1\, \N_174\, N_119, 
        \psh_posedge_reg_0_sqmuxa_3_2\, 
        \psh_negedge_reg_1_sqmuxa_0_a3_1\, \N_60\, 
        psh_negedge_reg_1_sqmuxa_6_0_a2_0, 
        psh_negedge_reg_1_sqmuxa_1_0, N_54, \un11_psel\, N_167, 
        \un7_psel\, psh_posedge_reg_0_sqmuxa_0_a2_0, N_171, N_170, 
        \un9_psel\, \N_62\ : std_logic;

begin 

    period_reg(15) <= \period_reg[15]_net_1\;
    period_reg(14) <= \period_reg[14]_net_1\;
    period_reg(13) <= \period_reg[13]_net_1\;
    period_reg(12) <= \period_reg[12]_net_1\;
    period_reg(11) <= \period_reg[11]_net_1\;
    period_reg(10) <= \period_reg[10]_net_1\;
    period_reg(9) <= \period_reg[9]_net_1\;
    period_reg(8) <= \period_reg[8]_net_1\;
    period_reg(7) <= \period_reg[7]_net_1\;
    period_reg(6) <= \period_reg[6]_net_1\;
    period_reg(5) <= \period_reg[5]_net_1\;
    period_reg(4) <= \period_reg[4]_net_1\;
    period_reg(3) <= \period_reg[3]_net_1\;
    period_reg(2) <= \period_reg[2]_net_1\;
    period_reg(1) <= \period_reg[1]_net_1\;
    period_reg(0) <= \period_reg[0]_net_1\;
    prescale_reg(15) <= \prescale_reg[15]_net_1\;
    prescale_reg(14) <= \prescale_reg[14]_net_1\;
    prescale_reg(13) <= \prescale_reg[13]_net_1\;
    prescale_reg(12) <= \prescale_reg[12]_net_1\;
    prescale_reg(11) <= \prescale_reg[11]_net_1\;
    prescale_reg(10) <= \prescale_reg[10]_net_1\;
    prescale_reg(9) <= \prescale_reg[9]_net_1\;
    prescale_reg(8) <= \prescale_reg[8]_net_1\;
    prescale_reg(7) <= \prescale_reg[7]_net_1\;
    prescale_reg(6) <= \prescale_reg[6]_net_1\;
    prescale_reg(5) <= \prescale_reg[5]_net_1\;
    prescale_reg(4) <= \prescale_reg[4]_net_1\;
    pwm_posedge_reg(128) <= \pwm_posedge_reg[128]\;
    pwm_posedge_reg(127) <= \pwm_posedge_reg[127]\;
    pwm_posedge_reg(126) <= \pwm_posedge_reg[126]\;
    pwm_posedge_reg(125) <= \pwm_posedge_reg[125]\;
    pwm_posedge_reg(124) <= \pwm_posedge_reg[124]\;
    pwm_posedge_reg(123) <= \pwm_posedge_reg[123]\;
    pwm_posedge_reg(122) <= \pwm_posedge_reg[122]\;
    pwm_posedge_reg(121) <= \pwm_posedge_reg[121]\;
    pwm_posedge_reg(120) <= \pwm_posedge_reg[120]\;
    pwm_posedge_reg(119) <= \pwm_posedge_reg[119]\;
    pwm_posedge_reg(118) <= \pwm_posedge_reg[118]\;
    pwm_posedge_reg(117) <= \pwm_posedge_reg[117]\;
    pwm_posedge_reg(116) <= \pwm_posedge_reg[116]\;
    pwm_posedge_reg(115) <= \pwm_posedge_reg[115]\;
    pwm_posedge_reg(114) <= \pwm_posedge_reg[114]\;
    pwm_posedge_reg(113) <= \pwm_posedge_reg[113]\;
    pwm_posedge_reg(112) <= \pwm_posedge_reg[112]\;
    pwm_posedge_reg(111) <= \pwm_posedge_reg[111]\;
    pwm_posedge_reg(110) <= \pwm_posedge_reg[110]\;
    pwm_posedge_reg(109) <= \pwm_posedge_reg[109]\;
    pwm_posedge_reg(108) <= \pwm_posedge_reg[108]\;
    pwm_posedge_reg(107) <= \pwm_posedge_reg[107]\;
    pwm_posedge_reg(106) <= \pwm_posedge_reg[106]\;
    pwm_posedge_reg(105) <= \pwm_posedge_reg[105]\;
    pwm_posedge_reg(104) <= \pwm_posedge_reg[104]\;
    pwm_posedge_reg(103) <= \pwm_posedge_reg[103]\;
    pwm_posedge_reg(102) <= \pwm_posedge_reg[102]\;
    pwm_posedge_reg(101) <= \pwm_posedge_reg[101]\;
    pwm_posedge_reg(100) <= \pwm_posedge_reg[100]\;
    pwm_posedge_reg(99) <= \pwm_posedge_reg[99]\;
    pwm_posedge_reg(98) <= \pwm_posedge_reg[98]\;
    pwm_posedge_reg(97) <= \pwm_posedge_reg[97]\;
    pwm_posedge_reg(96) <= \pwm_posedge_reg[96]\;
    pwm_posedge_reg(95) <= \pwm_posedge_reg[95]\;
    pwm_posedge_reg(94) <= \pwm_posedge_reg[94]\;
    pwm_posedge_reg(93) <= \pwm_posedge_reg[93]\;
    pwm_posedge_reg(92) <= \pwm_posedge_reg[92]\;
    pwm_posedge_reg(91) <= \pwm_posedge_reg[91]\;
    pwm_posedge_reg(90) <= \pwm_posedge_reg[90]\;
    pwm_posedge_reg(89) <= \pwm_posedge_reg[89]\;
    pwm_posedge_reg(88) <= \pwm_posedge_reg[88]\;
    pwm_posedge_reg(87) <= \pwm_posedge_reg[87]\;
    pwm_posedge_reg(86) <= \pwm_posedge_reg[86]\;
    pwm_posedge_reg(85) <= \pwm_posedge_reg[85]\;
    pwm_posedge_reg(84) <= \pwm_posedge_reg[84]\;
    pwm_posedge_reg(83) <= \pwm_posedge_reg[83]\;
    pwm_posedge_reg(82) <= \pwm_posedge_reg[82]\;
    pwm_posedge_reg(81) <= \pwm_posedge_reg[81]\;
    pwm_posedge_reg(80) <= \pwm_posedge_reg[80]\;
    pwm_posedge_reg(79) <= \pwm_posedge_reg[79]\;
    pwm_posedge_reg(78) <= \pwm_posedge_reg[78]\;
    pwm_posedge_reg(77) <= \pwm_posedge_reg[77]\;
    pwm_posedge_reg(76) <= \pwm_posedge_reg[76]\;
    pwm_posedge_reg(75) <= \pwm_posedge_reg[75]\;
    pwm_posedge_reg(74) <= \pwm_posedge_reg[74]\;
    pwm_posedge_reg(73) <= \pwm_posedge_reg[73]\;
    pwm_posedge_reg(72) <= \pwm_posedge_reg[72]\;
    pwm_posedge_reg(71) <= \pwm_posedge_reg[71]\;
    pwm_posedge_reg(70) <= \pwm_posedge_reg[70]\;
    pwm_posedge_reg(69) <= \pwm_posedge_reg[69]\;
    pwm_posedge_reg(68) <= \pwm_posedge_reg[68]\;
    pwm_posedge_reg(67) <= \pwm_posedge_reg[67]\;
    pwm_posedge_reg(66) <= \pwm_posedge_reg[66]\;
    pwm_posedge_reg(65) <= \pwm_posedge_reg[65]\;
    pwm_posedge_reg(64) <= \pwm_posedge_reg[64]\;
    pwm_posedge_reg(63) <= \pwm_posedge_reg[63]\;
    pwm_posedge_reg(62) <= \pwm_posedge_reg[62]\;
    pwm_posedge_reg(61) <= \pwm_posedge_reg[61]\;
    pwm_posedge_reg(60) <= \pwm_posedge_reg[60]\;
    pwm_posedge_reg(59) <= \pwm_posedge_reg[59]\;
    pwm_posedge_reg(58) <= \pwm_posedge_reg[58]\;
    pwm_posedge_reg(57) <= \pwm_posedge_reg[57]\;
    pwm_posedge_reg(56) <= \pwm_posedge_reg[56]\;
    pwm_posedge_reg(55) <= \pwm_posedge_reg[55]\;
    pwm_posedge_reg(54) <= \pwm_posedge_reg[54]\;
    pwm_posedge_reg(53) <= \pwm_posedge_reg[53]\;
    pwm_posedge_reg(52) <= \pwm_posedge_reg[52]\;
    pwm_posedge_reg(51) <= \pwm_posedge_reg[51]\;
    pwm_posedge_reg(50) <= \pwm_posedge_reg[50]\;
    pwm_posedge_reg(49) <= \pwm_posedge_reg[49]\;
    pwm_posedge_reg(48) <= \pwm_posedge_reg[48]\;
    pwm_posedge_reg(47) <= \pwm_posedge_reg[47]\;
    pwm_posedge_reg(46) <= \pwm_posedge_reg[46]\;
    pwm_posedge_reg(45) <= \pwm_posedge_reg[45]\;
    pwm_posedge_reg(44) <= \pwm_posedge_reg[44]\;
    pwm_posedge_reg(43) <= \pwm_posedge_reg[43]\;
    pwm_posedge_reg(42) <= \pwm_posedge_reg[42]\;
    pwm_posedge_reg(41) <= \pwm_posedge_reg[41]\;
    pwm_posedge_reg(40) <= \pwm_posedge_reg[40]\;
    pwm_posedge_reg(39) <= \pwm_posedge_reg[39]\;
    pwm_posedge_reg(38) <= \pwm_posedge_reg[38]\;
    pwm_posedge_reg(37) <= \pwm_posedge_reg[37]\;
    pwm_posedge_reg(36) <= \pwm_posedge_reg[36]\;
    pwm_posedge_reg(35) <= \pwm_posedge_reg[35]\;
    pwm_posedge_reg(34) <= \pwm_posedge_reg[34]\;
    pwm_posedge_reg(33) <= \pwm_posedge_reg[33]\;
    pwm_posedge_reg(32) <= \pwm_posedge_reg[32]\;
    pwm_posedge_reg(31) <= \pwm_posedge_reg[31]\;
    pwm_posedge_reg(30) <= \pwm_posedge_reg[30]\;
    pwm_posedge_reg(29) <= \pwm_posedge_reg[29]\;
    pwm_posedge_reg(28) <= \pwm_posedge_reg[28]\;
    pwm_posedge_reg(27) <= \pwm_posedge_reg[27]\;
    pwm_posedge_reg(26) <= \pwm_posedge_reg[26]\;
    pwm_posedge_reg(25) <= \pwm_posedge_reg[25]\;
    pwm_posedge_reg(24) <= \pwm_posedge_reg[24]\;
    pwm_posedge_reg(23) <= \pwm_posedge_reg[23]\;
    pwm_posedge_reg(22) <= \pwm_posedge_reg[22]\;
    pwm_posedge_reg(21) <= \pwm_posedge_reg[21]\;
    pwm_posedge_reg(20) <= \pwm_posedge_reg[20]\;
    pwm_posedge_reg(19) <= \pwm_posedge_reg[19]\;
    pwm_posedge_reg(18) <= \pwm_posedge_reg[18]\;
    pwm_posedge_reg(16) <= \pwm_posedge_reg[16]\;
    pwm_posedge_reg(15) <= \pwm_posedge_reg[15]\;
    pwm_posedge_reg(14) <= \pwm_posedge_reg[14]\;
    pwm_posedge_reg(13) <= \pwm_posedge_reg[13]\;
    pwm_posedge_reg(12) <= \pwm_posedge_reg[12]\;
    pwm_posedge_reg(11) <= \pwm_posedge_reg[11]\;
    pwm_posedge_reg(10) <= \pwm_posedge_reg[10]\;
    pwm_posedge_reg(9) <= \pwm_posedge_reg[9]\;
    pwm_posedge_reg(8) <= \pwm_posedge_reg[8]\;
    pwm_posedge_reg(7) <= \pwm_posedge_reg[7]\;
    pwm_posedge_reg(6) <= \pwm_posedge_reg[6]\;
    pwm_posedge_reg(5) <= \pwm_posedge_reg[5]\;
    pwm_posedge_reg(4) <= \pwm_posedge_reg[4]\;
    pwm_posedge_reg(3) <= \pwm_posedge_reg[3]\;
    pwm_posedge_reg(2) <= \pwm_posedge_reg[2]\;
    pwm_enable_reg(8) <= \pwm_enable_reg[8]\;
    pwm_enable_reg(7) <= \pwm_enable_reg[7]\;
    pwm_enable_reg(6) <= \pwm_enable_reg[6]\;
    pwm_enable_reg(5) <= \pwm_enable_reg[5]\;
    pwm_negedge_reg(128) <= \pwm_negedge_reg[128]\;
    pwm_negedge_reg(127) <= \pwm_negedge_reg[127]\;
    pwm_negedge_reg(126) <= \pwm_negedge_reg[126]\;
    pwm_negedge_reg(125) <= \pwm_negedge_reg[125]\;
    pwm_negedge_reg(124) <= \pwm_negedge_reg[124]\;
    pwm_negedge_reg(123) <= \pwm_negedge_reg[123]\;
    pwm_negedge_reg(122) <= \pwm_negedge_reg[122]\;
    pwm_negedge_reg(121) <= \pwm_negedge_reg[121]\;
    pwm_negedge_reg(120) <= \pwm_negedge_reg[120]\;
    pwm_negedge_reg(119) <= \pwm_negedge_reg[119]\;
    pwm_negedge_reg(118) <= \pwm_negedge_reg[118]\;
    pwm_negedge_reg(117) <= \pwm_negedge_reg[117]\;
    pwm_negedge_reg(115) <= \pwm_negedge_reg[115]\;
    pwm_negedge_reg(114) <= \pwm_negedge_reg[114]\;
    pwm_negedge_reg(113) <= \pwm_negedge_reg[113]\;
    pwm_negedge_reg(112) <= \pwm_negedge_reg[112]\;
    pwm_negedge_reg(111) <= \pwm_negedge_reg[111]\;
    pwm_negedge_reg(110) <= \pwm_negedge_reg[110]\;
    pwm_negedge_reg(109) <= \pwm_negedge_reg[109]\;
    pwm_negedge_reg(108) <= \pwm_negedge_reg[108]\;
    pwm_negedge_reg(107) <= \pwm_negedge_reg[107]\;
    pwm_negedge_reg(106) <= \pwm_negedge_reg[106]\;
    pwm_negedge_reg(105) <= \pwm_negedge_reg[105]\;
    pwm_negedge_reg(104) <= \pwm_negedge_reg[104]\;
    pwm_negedge_reg(103) <= \pwm_negedge_reg[103]\;
    pwm_negedge_reg(102) <= \pwm_negedge_reg[102]\;
    pwm_negedge_reg(101) <= \pwm_negedge_reg[101]\;
    pwm_negedge_reg(99) <= \pwm_negedge_reg[99]\;
    pwm_negedge_reg(98) <= \pwm_negedge_reg[98]\;
    pwm_negedge_reg(97) <= \pwm_negedge_reg[97]\;
    pwm_negedge_reg(96) <= \pwm_negedge_reg[96]\;
    pwm_negedge_reg(95) <= \pwm_negedge_reg[95]\;
    pwm_negedge_reg(94) <= \pwm_negedge_reg[94]\;
    pwm_negedge_reg(93) <= \pwm_negedge_reg[93]\;
    pwm_negedge_reg(92) <= \pwm_negedge_reg[92]\;
    pwm_negedge_reg(91) <= \pwm_negedge_reg[91]\;
    pwm_negedge_reg(90) <= \pwm_negedge_reg[90]\;
    pwm_negedge_reg(89) <= \pwm_negedge_reg[89]\;
    pwm_negedge_reg(88) <= \pwm_negedge_reg[88]\;
    pwm_negedge_reg(87) <= \pwm_negedge_reg[87]\;
    pwm_negedge_reg(86) <= \pwm_negedge_reg[86]\;
    pwm_negedge_reg(85) <= \pwm_negedge_reg[85]\;
    pwm_negedge_reg(84) <= \pwm_negedge_reg[84]\;
    pwm_negedge_reg(83) <= \pwm_negedge_reg[83]\;
    pwm_negedge_reg(82) <= \pwm_negedge_reg[82]\;
    pwm_negedge_reg(81) <= \pwm_negedge_reg[81]\;
    pwm_negedge_reg(80) <= \pwm_negedge_reg[80]\;
    pwm_negedge_reg(79) <= \pwm_negedge_reg[79]\;
    pwm_negedge_reg(78) <= \pwm_negedge_reg[78]\;
    pwm_negedge_reg(77) <= \pwm_negedge_reg[77]\;
    pwm_negedge_reg(76) <= \pwm_negedge_reg[76]\;
    pwm_negedge_reg(75) <= \pwm_negedge_reg[75]\;
    pwm_negedge_reg(74) <= \pwm_negedge_reg[74]\;
    pwm_negedge_reg(73) <= \pwm_negedge_reg[73]\;
    pwm_negedge_reg(72) <= \pwm_negedge_reg[72]\;
    pwm_negedge_reg(71) <= \pwm_negedge_reg[71]\;
    pwm_negedge_reg(70) <= \pwm_negedge_reg[70]\;
    pwm_negedge_reg(69) <= \pwm_negedge_reg[69]\;
    pwm_negedge_reg(68) <= \pwm_negedge_reg[68]\;
    pwm_negedge_reg(67) <= \pwm_negedge_reg[67]\;
    pwm_negedge_reg(66) <= \pwm_negedge_reg[66]\;
    pwm_negedge_reg(65) <= \pwm_negedge_reg[65]\;
    pwm_negedge_reg(64) <= \pwm_negedge_reg[64]\;
    pwm_negedge_reg(63) <= \pwm_negedge_reg[63]\;
    pwm_negedge_reg(62) <= \pwm_negedge_reg[62]\;
    pwm_negedge_reg(61) <= \pwm_negedge_reg[61]\;
    pwm_negedge_reg(60) <= \pwm_negedge_reg[60]\;
    pwm_negedge_reg(59) <= \pwm_negedge_reg[59]\;
    pwm_negedge_reg(58) <= \pwm_negedge_reg[58]\;
    pwm_negedge_reg(57) <= \pwm_negedge_reg[57]\;
    pwm_negedge_reg(56) <= \pwm_negedge_reg[56]\;
    pwm_negedge_reg(55) <= \pwm_negedge_reg[55]\;
    pwm_negedge_reg(54) <= \pwm_negedge_reg[54]\;
    pwm_negedge_reg(53) <= \pwm_negedge_reg[53]\;
    pwm_negedge_reg(52) <= \pwm_negedge_reg[52]\;
    pwm_negedge_reg(51) <= \pwm_negedge_reg[51]\;
    pwm_negedge_reg(50) <= \pwm_negedge_reg[50]\;
    pwm_negedge_reg(49) <= \pwm_negedge_reg[49]\;
    pwm_negedge_reg(48) <= \pwm_negedge_reg[48]\;
    pwm_negedge_reg(47) <= \pwm_negedge_reg[47]\;
    pwm_negedge_reg(46) <= \pwm_negedge_reg[46]\;
    pwm_negedge_reg(45) <= \pwm_negedge_reg[45]\;
    pwm_negedge_reg(44) <= \pwm_negedge_reg[44]\;
    pwm_negedge_reg(43) <= \pwm_negedge_reg[43]\;
    pwm_negedge_reg(42) <= \pwm_negedge_reg[42]\;
    pwm_negedge_reg(41) <= \pwm_negedge_reg[41]\;
    pwm_negedge_reg(40) <= \pwm_negedge_reg[40]\;
    pwm_negedge_reg(39) <= \pwm_negedge_reg[39]\;
    pwm_negedge_reg(38) <= \pwm_negedge_reg[38]\;
    pwm_negedge_reg(37) <= \pwm_negedge_reg[37]\;
    pwm_negedge_reg(36) <= \pwm_negedge_reg[36]\;
    pwm_negedge_reg(35) <= \pwm_negedge_reg[35]\;
    pwm_negedge_reg(34) <= \pwm_negedge_reg[34]\;
    pwm_negedge_reg(33) <= \pwm_negedge_reg[33]\;
    pwm_negedge_reg(32) <= \pwm_negedge_reg[32]\;
    pwm_negedge_reg(31) <= \pwm_negedge_reg[31]\;
    pwm_negedge_reg(30) <= \pwm_negedge_reg[30]\;
    pwm_negedge_reg(29) <= \pwm_negedge_reg[29]\;
    pwm_negedge_reg(28) <= \pwm_negedge_reg[28]\;
    pwm_negedge_reg(27) <= \pwm_negedge_reg[27]\;
    pwm_negedge_reg(26) <= \pwm_negedge_reg[26]\;
    pwm_negedge_reg(25) <= \pwm_negedge_reg[25]\;
    pwm_negedge_reg(24) <= \pwm_negedge_reg[24]\;
    pwm_negedge_reg(23) <= \pwm_negedge_reg[23]\;
    pwm_negedge_reg(22) <= \pwm_negedge_reg[22]\;
    pwm_negedge_reg(21) <= \pwm_negedge_reg[21]\;
    pwm_negedge_reg(20) <= \pwm_negedge_reg[20]\;
    pwm_negedge_reg(19) <= \pwm_negedge_reg[19]\;
    pwm_negedge_reg(18) <= \pwm_negedge_reg[18]\;
    pwm_negedge_reg(16) <= \pwm_negedge_reg[16]\;
    pwm_negedge_reg(15) <= \pwm_negedge_reg[15]\;
    pwm_negedge_reg(14) <= \pwm_negedge_reg[14]\;
    pwm_negedge_reg(13) <= \pwm_negedge_reg[13]\;
    pwm_negedge_reg(12) <= \pwm_negedge_reg[12]\;
    pwm_negedge_reg(11) <= \pwm_negedge_reg[11]\;
    pwm_negedge_reg(10) <= \pwm_negedge_reg[10]\;
    pwm_negedge_reg(9) <= \pwm_negedge_reg[9]\;
    pwm_negedge_reg(8) <= \pwm_negedge_reg[8]\;
    pwm_negedge_reg(7) <= \pwm_negedge_reg[7]\;
    pwm_negedge_reg(6) <= \pwm_negedge_reg[6]\;
    pwm_negedge_reg(5) <= \pwm_negedge_reg[5]\;
    pwm_negedge_reg(4) <= \pwm_negedge_reg[4]\;
    pwm_negedge_reg(3) <= \pwm_negedge_reg[3]\;
    pwm_negedge_reg(2) <= \pwm_negedge_reg[2]\;
    N_62 <= \N_62\;
    un9_psel <= \un9_psel\;
    un7_psel <= \un7_psel\;
    un11_psel <= \un11_psel\;
    N_60 <= \N_60\;
    N_174 <= \N_174\;

    \psh_posedge_reg[26]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[26]\);
    
    \psh_negedge_reg[110]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[110]\);
    
    \G2.1.prescale_reg7\ : CFG2
      generic map(INIT => x"1")

      port map(A => un1_period_cnt, B => sync_pulse_1, Y => 
        prescale_reg7);
    
    un11_psel_0_a2 : CFG4
      generic map(INIT => x"0100")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => N_119, Y => 
        \un11_psel\);
    
    \PRDATA_generated_15_2_0_wmux[7]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[72]\, D => \pwm_posedge_reg[88]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_2_0_y0[7]\, FCO => 
        \PRDATA_generated_15_2_0_co0[7]\);
    
    \psh_prescale_reg[1]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[1]_net_1\);
    
    \psh_posedge_reg[2]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[2]\);
    
    \psh_negedge_reg[4]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[4]\);
    
    \G2.1.un1_period_cnt_cry_11\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[11]_net_1\, B => period_cnt(11), 
        C => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_10, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt_cry_11);
    
    \PRDATA_generated_15_2_0_wmux[0]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[65]\, D => \pwm_posedge_reg[81]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_2_0_y0[0]\, FCO => 
        \PRDATA_generated_15_2_0_co0[0]\);
    
    \period_reg[5]\ : SLE
      port map(D => \psh_period_reg[5]_net_1\, CLK => FAB_CCC_GL0, 
        EN => prescale_reg7, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_reg[5]_net_1\);
    
    un11_psel_0_a2_RNIHCAK : CFG2
      generic map(INIT => x"8")

      port map(A => \N_174\, B => \un11_psel\, Y => N_75_i);
    
    \psh_posedge_reg[108]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[108]\);
    
    \psh_negedge_reg[99]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[99]\);
    
    psh_posedge_reg_0_sqmuxa_6_0_a2 : CFG3
      generic map(INIT => x"80")

      port map(A => N_69, B => \N_174\, C => N_119, Y => 
        psh_posedge_reg_0_sqmuxa_6);
    
    \psh_posedge_reg[18]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[18]\);
    
    \period_reg[14]\ : SLE
      port map(D => \psh_period_reg[14]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \period_reg[14]_net_1\);
    
    \PRDATA_generated_15_2_0_wmux_0[4]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_2_0_y0[4]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[69]\, D => \pwm_negedge_reg[85]\, FCI
         => \PRDATA_generated_15_2_0_co0[4]\, S => OPEN, Y => 
        \PRDATA_generated_15_2_0_wmux_0_Y[4]\, FCO => OPEN);
    
    \psh_negedge_reg[124]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[124]\);
    
    \psh_posedge_reg[84]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[84]\);
    
    \psh_posedge_reg[15]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[15]\);
    
    \PRDATA_regif_0_iv_0_0[12]\ : CFG4
      generic map(INIT => x"EAC0")

      port map(A => \prescale_reg[12]_net_1\, B => 
        \period_reg[12]_net_1\, C => \un9_psel\, D => \un7_psel\, 
        Y => PRDATA_regif_0_iv_0_0(12));
    
    \PRDATA_generated_15_4_0_wmux_3[9]\ : ARI1
      generic map(INIT => x"0EC2C")

      port map(A => \PRDATA_generated_15_4_0_y3[9]\, B => 
        \PRDATA_generated_15_4_0_y1[9]\, C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => VCC_net_1, FCI => 
        \PRDATA_generated_15_4_0_co1_0[9]\, S => OPEN, Y => N_928, 
        FCO => OPEN);
    
    \psh_negedge_reg[126]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[126]\);
    
    \psh_posedge_reg[90]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[90]\);
    
    \psh_negedge_reg[95]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[95]\);
    
    \prescale_reg[7]\ : SLE
      port map(D => \psh_prescale_reg[7]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \prescale_reg[7]_net_1\);
    
    \psh_posedge_reg[40]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[40]\);
    
    \PRDATA_generated_3_0_0_wmux_0[8]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[8]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_negedge_reg[9]\, 
        D => \pwm_negedge_reg[25]\, FCI => 
        \PRDATA_generated_3_0_0_co0[8]\, S => OPEN, Y => N_735, 
        FCO => OPEN);
    
    \period_reg[12]\ : SLE
      port map(D => \psh_period_reg[12]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \period_reg[12]_net_1\);
    
    \PRDATA_generated_15_4_0_wmux_2[10]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0_0[10]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[75]\, D => \pwm_negedge_reg[91]\, FCI
         => \PRDATA_generated_15_4_0_co0_0[10]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y3[10]\, FCO => 
        \PRDATA_generated_15_4_0_co1_0[10]\);
    
    \PRDATA_generated_15_2_0_wmux[1]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[66]\, D => \pwm_posedge_reg[82]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_2_0_y0[1]\, FCO => 
        \PRDATA_generated_15_2_0_co0[1]\);
    
    \psh_negedge_reg[123]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[123]\);
    
    \psh_posedge_reg[79]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[79]\);
    
    \psh_posedge_reg[86]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[86]\);
    
    \psh_period_reg[14]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[14]_net_1\);
    
    \psh_negedge_reg[79]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[79]\);
    
    \psh_negedge_reg[66]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[66]\);
    
    \PRDATA_generated_15_4_0_wmux[9]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[42]\, D => \pwm_posedge_reg[58]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0[9]\, FCO => 
        \PRDATA_generated_15_4_0_co0[9]\);
    
    \psh_posedge_reg[110]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[110]\);
    
    \psh_posedge_reg[21]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[21]\);
    
    psh_negedge_reg_1_sqmuxa_0_a3 : CFG4
      generic map(INIT => x"1000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), C => 
        psh_negedge_reg_1_sqmuxa_1_0, D => 
        \psh_negedge_reg_1_sqmuxa_0_a3_1\, Y => 
        psh_negedge_reg_1_sqmuxa);
    
    \psh_negedge_reg[39]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[39]\);
    
    \psh_posedge_reg[8]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[8]\);
    
    \psh_posedge_reg[115]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[115]\);
    
    \prescale_reg[2]\ : SLE
      port map(D => \psh_prescale_reg[2]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => prescale_reg(2));
    
    \PRDATA_generated_15_4_0_wmux_3[8]\ : ARI1
      generic map(INIT => x"0EC2C")

      port map(A => \PRDATA_generated_15_4_0_y3[8]\, B => 
        \PRDATA_generated_15_4_0_y1[8]\, C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => VCC_net_1, FCI => 
        \PRDATA_generated_15_4_0_co1_0[8]\, S => OPEN, Y => N_927, 
        FCO => OPEN);
    
    \psh_negedge_reg[82]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[82]\);
    
    \psh_negedge_reg[80]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[80]\);
    
    \psh_negedge_reg[48]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[48]\);
    
    \psh_posedge_reg[33]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[33]\);
    
    \psh_negedge_reg[8]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[8]\);
    
    \psh_prescale_reg[9]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[9]_net_1\);
    
    \psh_negedge_reg[29]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[29]\);
    
    \period_reg[13]\ : SLE
      port map(D => \psh_period_reg[13]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \period_reg[13]_net_1\);
    
    \psh_prescale_reg[0]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[0]_net_1\);
    
    \period_reg[8]\ : SLE
      port map(D => \psh_period_reg[8]_net_1\, CLK => FAB_CCC_GL0, 
        EN => prescale_reg7, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_reg[8]_net_1\);
    
    \psh_negedge_reg[111]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[111]\);
    
    \PRDATA_generated_15_2_0_wmux_0[1]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_2_0_y0[1]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[66]\, D => \pwm_negedge_reg[82]\, FCI
         => \PRDATA_generated_15_2_0_co0[1]\, S => OPEN, Y => 
        \PRDATA_generated_15_2_0_wmux_0_Y[1]\, FCO => OPEN);
    
    \psh_negedge_reg[75]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[75]\);
    
    \PRDATA_generated_3_0_0_wmux_0[11]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[11]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[12]\, D => \pwm_negedge_reg[28]\, FCI
         => \PRDATA_generated_3_0_0_co0[11]\, S => OPEN, Y => 
        N_738, FCO => OPEN);
    
    \psh_negedge_reg[61]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[61]\);
    
    \psh_posedge_reg[97]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[97]\);
    
    \psh_negedge_reg[35]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[35]\);
    
    \PRDATA_generated_6_0_0_wmux[15]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[112]\, D => \pwm_posedge_reg[128]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[15]\, FCO => 
        \PRDATA_generated_6_0_0_co0[15]\);
    
    \PRDATA_generated_3_0_0_wmux[9]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[10]\, D => \pwm_posedge_reg[26]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_3_0_0_y0[9]\, FCO => 
        \PRDATA_generated_3_0_0_co0[9]\);
    
    \PRDATA_generated_15_0_0_wmux_0[3]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_0_0_y0[3]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[36]\, D => \pwm_negedge_reg[52]\, FCI
         => \PRDATA_generated_15_0_0_co0[3]\, S => OPEN, Y => 
        PRDATA_generated_15_0_0_wmux_0_Y_3, FCO => OPEN);
    
    psh_posedge_reg_0_sqmuxa_7_0_a2 : CFG3
      generic map(INIT => x"20")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => N_171, Y => 
        psh_posedge_reg_0_sqmuxa_7);
    
    \psh_posedge_reg[47]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[47]\);
    
    \psh_negedge_reg[19]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[19]\);
    
    \prescale_reg[5]\ : SLE
      port map(D => \psh_prescale_reg[5]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \prescale_reg[5]_net_1\);
    
    \period_reg[11]\ : SLE
      port map(D => \psh_period_reg[11]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \period_reg[11]_net_1\);
    
    \G2.1.un1_period_cnt_cry_1\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[1]_net_1\, B => period_cnt(1), C
         => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_0, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt_cry_1);
    
    \psh_period_reg[12]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[12]_net_1\);
    
    \psh_enable_reg1[4]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => N_75_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => pwm_enable_reg(4));
    
    \PRDATA_generated_6_0_0_wmux[9]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[106]\, D => \pwm_posedge_reg[122]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[9]\, FCO => 
        \PRDATA_generated_6_0_0_co0[9]\);
    
    \psh_negedge_reg[25]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[25]\);
    
    \psh_negedge_reg[120]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[120]\);
    
    \PRDATA_generated_6_0_0_wmux_0[15]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[15]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[112]\, D => \pwm_negedge_reg[128]\, FCI
         => \PRDATA_generated_6_0_0_co0[15]\, S => OPEN, Y => 
        N_790, FCO => OPEN);
    
    \PRDATA_generated_3_0_0_wmux[3]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_posedge_reg[4]\, 
        D => \pwm_posedge_reg[20]\, FCI => VCC_net_1, S => OPEN, 
        Y => \PRDATA_generated_3_0_0_y0[3]\, FCO => 
        \PRDATA_generated_3_0_0_co0[3]\);
    
    \PRDATA_generated_15_0_0_wmux[4]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[37]\, D => \pwm_posedge_reg[53]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_0_0_y0[4]\, FCO => 
        \PRDATA_generated_15_0_0_co0[4]\);
    
    \psh_posedge_reg[92]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[92]\);
    
    \PRDATA_generated_6_0_0_wmux_0[6]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[6]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[103]\, D => \pwm_negedge_reg[119]\, FCI
         => \PRDATA_generated_6_0_0_co0[6]\, S => OPEN, Y => 
        N_781, FCO => OPEN);
    
    \psh_posedge_reg[81]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[81]\);
    
    \G2.1.un1_period_cnt_cry_8\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[8]_net_1\, B => period_cnt(8), C
         => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_7, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt_cry_8);
    
    \psh_posedge_reg[53]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[53]\);
    
    \psh_posedge_reg[42]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[42]\);
    
    \psh_negedge_reg[15]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[15]\);
    
    \PRDATA_generated_3_0_0_wmux[4]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_posedge_reg[5]\, 
        D => \pwm_posedge_reg[21]\, FCI => VCC_net_1, S => OPEN, 
        Y => \PRDATA_generated_3_0_0_y0[4]\, FCO => 
        \PRDATA_generated_3_0_0_co0[4]\);
    
    \PRDATA_generated_3_0_0_wmux_0[5]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[5]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_negedge_reg[6]\, 
        D => \pwm_negedge_reg[22]\, FCI => 
        \PRDATA_generated_3_0_0_co0[5]\, S => OPEN, Y => N_732, 
        FCO => OPEN);
    
    \period_reg[3]\ : SLE
      port map(D => \psh_period_reg[3]_net_1\, CLK => FAB_CCC_GL0, 
        EN => prescale_reg7, ALn => MSS_READY, ADn => GND_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_reg[3]_net_1\);
    
    \psh_negedge_reg[119]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[119]\);
    
    \PRDATA_generated_6_0_0_wmux[4]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[101]\, D => \pwm_posedge_reg[117]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[4]\, FCO => 
        \PRDATA_generated_6_0_0_co0[4]\);
    
    \PRDATA_generated_17[11]\ : CFG4
      generic map(INIT => x"0AC3")

      port map(A => N_930, B => 
        \PRDATA_generated_17_1_0[11]_net_1\, C => 
        CoreAPB3_0_APBmslave0_PADDR(6), D => 
        CoreAPB3_0_APBmslave0_PADDR(5), Y => N_962);
    
    \psh_posedge_reg[123]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[123]\);
    
    \PRDATA_generated_3_0_0_wmux[13]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[14]\, D => \pwm_posedge_reg[30]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_3_0_0_y0[13]\, FCO => 
        \PRDATA_generated_3_0_0_co0[13]\);
    
    \PRDATA_generated_15_4_0_wmux_2[8]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0_0[8]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[73]\, D => \pwm_negedge_reg[89]\, FCI
         => \PRDATA_generated_15_4_0_co0_0[8]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y3[8]\, FCO => 
        \PRDATA_generated_15_4_0_co1_0[8]\);
    
    \prescale_reg[3]\ : SLE
      port map(D => \psh_prescale_reg[3]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => GND_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => prescale_reg(3));
    
    \psh_posedge_reg[4]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[4]\);
    
    \PRDATA_generated_15_4_0_wmux[15]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[48]\, D => \pwm_posedge_reg[64]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0[15]\, FCO => 
        \PRDATA_generated_15_4_0_co0[15]\);
    
    \G2.1.un1_period_cnt_cry_12\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[12]_net_1\, B => period_cnt(12), 
        C => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_11, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt_cry_12);
    
    \psh_negedge_reg[3]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[3]\);
    
    \psh_period_reg[8]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[8]_net_1\);
    
    \period_reg[0]\ : SLE
      port map(D => \psh_period_reg[0]_net_1\, CLK => FAB_CCC_GL0, 
        EN => prescale_reg7, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_reg[0]_net_1\);
    
    psh_posedge_reg_0_sqmuxa_4_0_a2 : CFG4
      generic map(INIT => x"1000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => 
        psh_posedge_reg_0_sqmuxa_3_2_0_1, D => N_69, Y => 
        psh_posedge_reg_0_sqmuxa_4);
    
    \PRDATA_regif_0_iv_0_0[11]\ : CFG4
      generic map(INIT => x"EAC0")

      port map(A => \prescale_reg[11]_net_1\, B => 
        \period_reg[11]_net_1\, C => \un9_psel\, D => \un7_psel\, 
        Y => PRDATA_regif_0_iv_0_0(11));
    
    \PRDATA_generated_3_0_0_wmux[6]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_posedge_reg[7]\, 
        D => \pwm_posedge_reg[23]\, FCI => VCC_net_1, S => OPEN, 
        Y => \PRDATA_generated_3_0_0_y0[6]\, FCO => 
        \PRDATA_generated_3_0_0_co0[6]\);
    
    \PRDATA_generated_15_4_0_wmux_0[8]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0[8]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[41]\, D => \pwm_negedge_reg[57]\, FCI
         => \PRDATA_generated_15_4_0_co0[8]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y1[8]\, FCO => 
        \PRDATA_generated_15_4_0_co1[8]\);
    
    \PRDATA_generated_15_0_0_wmux_0[6]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_0_0_y0[6]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[39]\, D => \pwm_negedge_reg[55]\, FCI
         => \PRDATA_generated_15_0_0_co0[6]\, S => OPEN, Y => 
        \PRDATA_generated_15_0_0_wmux_0_Y[6]\, FCO => OPEN);
    
    \psh_posedge_reg[30]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[30]\);
    
    \psh_posedge_reg[28]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[28]\);
    
    \psh_prescale_reg[8]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[8]_net_1\);
    
    \PRDATA_generated_6_0_0_wmux[6]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[103]\, D => \pwm_posedge_reg[119]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[6]\, FCO => 
        \PRDATA_generated_6_0_0_co0[6]\);
    
    psh_posedge_reg_0_sqmuxa_3_2 : CFG3
      generic map(INIT => x"01")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), C => 
        CoreAPB3_0_APBmslave0_PADDR(3), Y => 
        \psh_posedge_reg_0_sqmuxa_3_2\);
    
    \psh_posedge_reg[99]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[99]\);
    
    \PRDATA_generated_15_0_0_wmux_0[5]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_0_0_y0[5]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[38]\, D => \pwm_negedge_reg[54]\, FCI
         => \PRDATA_generated_15_0_0_co0[5]\, S => OPEN, Y => 
        \PRDATA_generated_15_0_0_wmux_0_Y[5]\, FCO => OPEN);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \psh_posedge_reg[49]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[49]\);
    
    \psh_posedge_reg[25]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[25]\);
    
    \G2.1.un1_period_cnt_cry_15\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[15]_net_1\, B => period_cnt(15), 
        C => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_14, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt);
    
    \PRDATA_generated_17_1_0[11]\ : CFG4
      generic map(INIT => x"2075")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_786, D => N_738, Y
         => \PRDATA_generated_17_1_0[11]_net_1\);
    
    \psh_negedge_reg[96]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[96]\);
    
    \psh_negedge_reg[121]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[121]\);
    
    \prescale_reg[12]\ : SLE
      port map(D => \psh_prescale_reg[12]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \prescale_reg[12]_net_1\);
    
    psh_posedge_reg_0_sqmuxa_0_a2_0_0 : CFG4
      generic map(INIT => x"1000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => \N_60\, Y => 
        psh_posedge_reg_0_sqmuxa_0_a2_0);
    
    \psh_negedge_reg[108]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[108]\);
    
    \PRDATA_generated_6_0_0_wmux_0[8]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[8]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[105]\, D => \pwm_negedge_reg[121]\, FCI
         => \PRDATA_generated_6_0_0_co0[8]\, S => OPEN, Y => 
        N_783, FCO => OPEN);
    
    \psh_prescale_reg[12]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[12]_net_1\);
    
    \psh_posedge_reg[118]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[118]\);
    
    \psh_negedge_reg[52]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[52]\);
    
    \psh_negedge_reg[50]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[50]\);
    
    \PRDATA_regif_iv_0_m2_0[0]\ : CFG4
      generic map(INIT => x"FE0E")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), C => 
        CoreAPB3_0_APBmslave0_PADDR(5), D => N_54, Y => \N_62\);
    
    \PRDATA_generated_15_4_0_wmux_3[14]\ : ARI1
      generic map(INIT => x"0EC2C")

      port map(A => \PRDATA_generated_15_4_0_y3[14]\, B => 
        \PRDATA_generated_15_4_0_y1[14]\, C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => VCC_net_1, FCI => 
        \PRDATA_generated_15_4_0_co1_0[14]\, S => OPEN, Y => 
        N_933, FCO => OPEN);
    
    \psh_posedge_reg[6]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[6]\);
    
    \G2.1.un1_period_cnt_cry_0\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[0]_net_1\, B => period_cnt(0), C
         => GND_net_1, D => GND_net_1, FCI => GND_net_1, S => 
        OPEN, Y => OPEN, FCO => un1_period_cnt_cry_0);
    
    \psh_period_reg[2]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[2]_net_1\);
    
    \PRDATA_generated_15_4_0_wmux_0[9]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0[9]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[42]\, D => \pwm_negedge_reg[58]\, FCI
         => \PRDATA_generated_15_4_0_co0[9]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y1[9]\, FCO => 
        \PRDATA_generated_15_4_0_co1[9]\);
    
    \psh_negedge_reg[63]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[63]\);
    
    \PRDATA_generated_3_0_0_wmux_0[9]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[9]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[10]\, D => \pwm_negedge_reg[26]\, FCI
         => \PRDATA_generated_3_0_0_co0[9]\, S => OPEN, Y => 
        N_736, FCO => OPEN);
    
    \psh_posedge_reg[50]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[50]\);
    
    \psh_posedge_reg[37]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[37]\);
    
    \psh_negedge_reg[91]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[91]\);
    
    \psh_negedge_reg[89]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[89]\);
    
    \psh_posedge_reg[88]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[88]\);
    
    \PRDATA_generated_17[15]\ : CFG4
      generic map(INIT => x"0AC3")

      port map(A => N_934, B => 
        \PRDATA_generated_17_1_0[15]_net_1\, C => 
        CoreAPB3_0_APBmslave0_PADDR(6), D => 
        CoreAPB3_0_APBmslave0_PADDR(5), Y => N_966);
    
    un7_psel_0_a2 : CFG4
      generic map(INIT => x"0100")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => \N_60\, Y => 
        \un7_psel\);
    
    \psh_posedge_reg[64]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[64]\);
    
    \PRDATA_generated_15_4_0_wmux_2[13]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0_0[13]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[78]\, D => \pwm_negedge_reg[94]\, FCI
         => \PRDATA_generated_15_4_0_co0_0[13]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y3[13]\, FCO => 
        \PRDATA_generated_15_4_0_co1_0[13]\);
    
    \psh_posedge_reg[9]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[9]\);
    
    \PRDATA_generated_6_0_0_wmux_0[10]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[10]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[107]\, D => \pwm_negedge_reg[123]\, FCI
         => \PRDATA_generated_6_0_0_co0[10]\, S => OPEN, Y => 
        N_785, FCO => OPEN);
    
    \prescale_reg[4]\ : SLE
      port map(D => \psh_prescale_reg[4]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \prescale_reg[4]_net_1\);
    
    \psh_posedge_reg[13]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[13]\);
    
    \PRDATA_generated_17[10]\ : CFG4
      generic map(INIT => x"0AC3")

      port map(A => N_929, B => 
        \PRDATA_generated_17_1_0[10]_net_1\, C => 
        CoreAPB3_0_APBmslave0_PADDR(6), D => 
        CoreAPB3_0_APBmslave0_PADDR(5), Y => N_961);
    
    \psh_prescale_reg[2]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[2]_net_1\);
    
    \psh_period_reg[1]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[1]_net_1\);
    
    \psh_posedge_reg[85]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[85]\);
    
    \psh_negedge_reg[76]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[76]\);
    
    \psh_posedge_reg[124]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[124]\);
    
    un3_psel_0_a2_RNI865N : CFG2
      generic map(INIT => x"8")

      port map(A => \N_174\, B => \un9_psel\, Y => N_73_i);
    
    \psh_posedge_reg[32]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[32]\);
    
    \psh_posedge_reg[122]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[122]\);
    
    \psh_period_reg[10]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[10]_net_1\);
    
    \psh_negedge_reg[85]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[85]\);
    
    \psh_negedge_reg[36]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[36]\);
    
    \PRDATA_regif_0_iv_0_0[8]\ : CFG4
      generic map(INIT => x"EAC0")

      port map(A => \prescale_reg[8]_net_1\, B => 
        \period_reg[8]_net_1\, C => \un9_psel\, D => \un7_psel\, 
        Y => PRDATA_regif_0_iv_0_0(8));
    
    \PRDATA_generated_6_0_0_wmux_0[12]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[12]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[109]\, D => \pwm_negedge_reg[125]\, FCI
         => \PRDATA_generated_6_0_0_co0[12]\, S => OPEN, Y => 
        N_787, FCO => OPEN);
    
    \PRDATA_generated_17_1_0[13]\ : CFG4
      generic map(INIT => x"2075")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_788, D => N_740, Y
         => \PRDATA_generated_17_1_0[13]_net_1\);
    
    \PRDATA_generated_15_4_0_wmux_1[14]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[79]\, D => \pwm_posedge_reg[95]\, FCI
         => \PRDATA_generated_15_4_0_co1[14]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0_0[14]\, FCO => 
        \PRDATA_generated_15_4_0_co0_0[14]\);
    
    \psh_posedge_reg[66]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[66]\);
    
    \psh_negedge_reg[67]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[67]\);
    
    \PRDATA_generated_15_4_0_wmux[8]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[41]\, D => \pwm_posedge_reg[57]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0[8]\, FCO => 
        \PRDATA_generated_15_4_0_co0[8]\);
    
    \G2.1.un1_period_cnt_cry_14\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[14]_net_1\, B => period_cnt(14), 
        C => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_13, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt_cry_14);
    
    \psh_negedge_reg[26]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[26]\);
    
    \psh_posedge_reg[126]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[126]\);
    
    \PRDATA_generated_3_0_0_wmux_0[3]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[3]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_negedge_reg[4]\, 
        D => \pwm_negedge_reg[20]\, FCI => 
        \PRDATA_generated_3_0_0_co0[3]\, S => OPEN, Y => N_730, 
        FCO => OPEN);
    
    \PRDATA_generated_15_4_0_wmux_2[11]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0_0[11]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[76]\, D => \pwm_negedge_reg[92]\, FCI
         => \PRDATA_generated_15_4_0_co0_0[11]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y3[11]\, FCO => 
        \PRDATA_generated_15_4_0_co1_0[11]\);
    
    \psh_negedge_reg[71]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[71]\);
    
    \PRDATA_generated_15_0_0_wmux[7]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[40]\, D => \pwm_posedge_reg[56]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_0_0_y0[7]\, FCO => 
        \PRDATA_generated_15_0_0_co0[7]\);
    
    \psh_posedge_reg[57]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[57]\);
    
    \PRDATA_generated_15_0_0_wmux[0]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[33]\, D => \pwm_posedge_reg[49]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_0_0_y0[0]\, FCO => 
        \PRDATA_generated_15_0_0_co0[0]\);
    
    \psh_negedge_reg[31]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[31]\);
    
    \psh_negedge_reg[105]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[105]\);
    
    \psh_negedge_reg[16]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[16]\);
    
    \PRDATA_generated_6_0_0_wmux_0[5]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[5]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[102]\, D => \pwm_negedge_reg[118]\, FCI
         => \PRDATA_generated_6_0_0_co0[5]\, S => OPEN, Y => 
        N_780, FCO => OPEN);
    
    \psh_period_reg[0]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[0]_net_1\);
    
    \PRDATA_generated_15_4_0_wmux_3[10]\ : ARI1
      generic map(INIT => x"0EC2C")

      port map(A => \PRDATA_generated_15_4_0_y3[10]\, B => 
        \PRDATA_generated_15_4_0_y1[10]\, C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => VCC_net_1, FCI => 
        \PRDATA_generated_15_4_0_co1_0[10]\, S => OPEN, Y => 
        N_929, FCO => OPEN);
    
    \PRDATA_generated_15_4_0_wmux_2[9]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0_0[9]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[74]\, D => \pwm_negedge_reg[90]\, FCI
         => \PRDATA_generated_15_4_0_co0_0[9]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y3[9]\, FCO => 
        \PRDATA_generated_15_4_0_co1_0[9]\);
    
    psh_negedge_reg_1_sqmuxa_3_0_a2_1 : CFG4
      generic map(INIT => x"0400")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => \N_174\, Y => N_170);
    
    \psh_negedge_reg[21]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[21]\);
    
    \prescale_reg[6]\ : SLE
      port map(D => \psh_prescale_reg[6]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \prescale_reg[6]_net_1\);
    
    psh_posedge_reg_0_sqmuxa_3 : CFG4
      generic map(INIT => x"1000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => 
        psh_posedge_reg_0_sqmuxa_3_2_0_1, D => 
        \psh_posedge_reg_0_sqmuxa_3_2\, Y => 
        \psh_posedge_reg_0_sqmuxa_3\);
    
    \psh_posedge_reg[74]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[74]\);
    
    \psh_negedge_reg[64]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[64]\);
    
    \psh_negedge_reg[112]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[112]\);
    
    \psh_negedge_reg[107]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[107]\);
    
    \psh_posedge_reg[52]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[52]\);
    
    \psh_posedge_reg[101]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[101]\);
    
    \psh_posedge_reg[39]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[39]\);
    
    \psh_negedge_reg[42]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[42]\);
    
    \psh_negedge_reg[40]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[40]\);
    
    \PRDATA_generated_3_0_0_wmux[8]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_posedge_reg[9]\, 
        D => \pwm_posedge_reg[25]\, FCI => VCC_net_1, S => OPEN, 
        Y => \PRDATA_generated_3_0_0_y0[8]\, FCO => 
        \PRDATA_generated_3_0_0_co0[8]\);
    
    \psh_negedge_reg[11]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[11]\);
    
    \G2.1.un1_period_cnt_cry_3\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[3]_net_1\, B => period_cnt(3), C
         => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_2, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt_cry_3);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \PRDATA_generated_6_0_0_wmux[8]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[105]\, D => \pwm_posedge_reg[121]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[8]\, FCO => 
        \PRDATA_generated_6_0_0_co0[8]\);
    
    \psh_negedge_reg[2]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[2]\);
    
    \PRDATA_generated_15_0_0_wmux[1]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[34]\, D => \pwm_posedge_reg[50]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_0_0_y0[1]\, FCO => 
        \PRDATA_generated_15_0_0_co0[1]\);
    
    \psh_posedge_reg[76]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[76]\);
    
    \psh_posedge_reg[61]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[61]\);
    
    psh_negedge_reg_1_sqmuxa_6_0_a2_0_1 : CFG4
      generic map(INIT => x"0200")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => 
        CoreAPB3_0_APBmslave0_PADDR(5), D => 
        CoreAPB3_0_APBmslave0_PADDR(2), Y => 
        psh_negedge_reg_1_sqmuxa_6_0_a2_0);
    
    \period_reg[9]\ : SLE
      port map(D => \psh_period_reg[9]_net_1\, CLK => FAB_CCC_GL0, 
        EN => prescale_reg7, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_reg[9]_net_1\);
    
    \psh_posedge_reg[10]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[10]\);
    
    \PRDATA_generated_15_4_0_wmux_1[10]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[75]\, D => \pwm_posedge_reg[91]\, FCI
         => \PRDATA_generated_15_4_0_co1[10]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0_0[10]\, FCO => 
        \PRDATA_generated_15_4_0_co0_0[10]\);
    
    \prescale_reg[15]\ : SLE
      port map(D => \psh_prescale_reg[15]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \prescale_reg[15]_net_1\);
    
    \prescale_reg[9]\ : SLE
      port map(D => \psh_prescale_reg[9]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \prescale_reg[9]_net_1\);
    
    \PRDATA_generated_6_0_0_wmux_0[14]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[14]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[111]\, D => \pwm_negedge_reg[127]\, FCI
         => \PRDATA_generated_6_0_0_co0[14]\, S => OPEN, Y => 
        N_789, FCO => OPEN);
    
    \PRDATA_generated_6_0_0_wmux_0[0]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[0]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[97]\, D => \pwm_negedge_reg[113]\, FCI
         => \PRDATA_generated_6_0_0_co0[0]\, S => OPEN, Y => 
        N_10_1, FCO => OPEN);
    
    \period_reg[2]\ : SLE
      port map(D => \psh_period_reg[2]_net_1\, CLK => FAB_CCC_GL0, 
        EN => prescale_reg7, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_reg[2]_net_1\);
    
    \psh_negedge_reg[93]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[93]\);
    
    \psh_negedge_reg[59]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[59]\);
    
    psh_negedge_reg_1_sqmuxa_7_0_a2 : CFG4
      generic map(INIT => x"8000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => 
        psh_posedge_reg_0_sqmuxa_3_2_0_1, D => N_69, Y => 
        psh_negedge_reg_1_sqmuxa_7);
    
    psh_negedge_reg_1_sqmuxa_2_0_a2 : CFG4
      generic map(INIT => x"2000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => 
        psh_posedge_reg_0_sqmuxa_3_2_0_1, D => N_69, Y => 
        psh_negedge_reg_1_sqmuxa_2);
    
    \PRDATA_generated_16[4]\ : CFG4
      generic map(INIT => x"5140")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => 
        \PRDATA_generated_15_2_0_wmux_0_Y[4]\, D => 
        \PRDATA_generated_15_0_0_wmux_0_Y[4]\, Y => N_939);
    
    \PRDATA_generated_15_4_0_wmux_1[8]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[73]\, D => \pwm_posedge_reg[89]\, FCI
         => \PRDATA_generated_15_4_0_co1[8]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0_0[8]\, FCO => 
        \PRDATA_generated_15_4_0_co0_0[8]\);
    
    \psh_period_reg[13]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[13]_net_1\);
    
    \psh_negedge_reg[104]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[104]\);
    
    \PRDATA_generated_3_0_0_wmux[2]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_posedge_reg[3]\, 
        D => \pwm_posedge_reg[19]\, FCI => VCC_net_1, S => OPEN, 
        Y => \PRDATA_generated_3_0_0_y0[2]\, FCO => 
        \PRDATA_generated_3_0_0_co0[2]\);
    
    \psh_posedge_reg[59]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[59]\);
    
    \psh_posedge_reg[120]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[120]\);
    
    \psh_negedge_reg[5]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[5]\);
    
    \psh_negedge_reg[106]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[106]\);
    
    \psh_enable_reg1[8]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => N_75_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \pwm_enable_reg[8]\);
    
    \PRDATA_generated_6_0_0_wmux[2]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[99]\, D => \pwm_posedge_reg[115]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[2]\, FCO => 
        \PRDATA_generated_6_0_0_co0[2]\);
    
    \PRDATA_generated_6_0[3]\ : CFG4
      generic map(INIT => x"F0AC")

      port map(A => \pwm_posedge_reg[116]\, B => 
        \pwm_posedge_reg[100]\, C => 
        CoreAPB3_0_APBmslave0_PADDR(3), D => 
        CoreAPB3_0_APBmslave0_PADDR(2), Y => 
        PRDATA_generated_6_0_0);
    
    \PRDATA_generated_3_0_0_wmux_0[12]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[12]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[13]\, D => \pwm_negedge_reg[29]\, FCI
         => \PRDATA_generated_3_0_0_co0[12]\, S => OPEN, Y => 
        N_739, FCO => OPEN);
    
    \PRDATA_generated_17_1_0[9]\ : CFG4
      generic map(INIT => x"2075")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_784, D => N_736, Y
         => \PRDATA_generated_17_1_0[9]_net_1\);
    
    \psh_posedge_reg[125]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[125]\);
    
    \PRDATA_generated_6_0_0_wmux_0[9]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[9]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[106]\, D => \pwm_negedge_reg[122]\, FCI
         => \PRDATA_generated_6_0_0_co0[9]\, S => OPEN, Y => 
        N_784, FCO => OPEN);
    
    \PRDATA_generated_15_4_0_wmux_2[15]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0_0[15]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[80]\, D => \pwm_negedge_reg[96]\, FCI
         => \PRDATA_generated_15_4_0_co0_0[15]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y3[15]\, FCO => 
        \PRDATA_generated_15_4_0_co1_0[15]\);
    
    \PRDATA_generated_15_4_0_wmux_2[12]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0_0[12]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[77]\, D => \pwm_negedge_reg[93]\, FCI
         => \PRDATA_generated_15_4_0_co0_0[12]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y3[12]\, FCO => 
        \PRDATA_generated_15_4_0_co1_0[12]\);
    
    \psh_negedge_reg[68]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[68]\);
    
    \psh_negedge_reg[55]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[55]\);
    
    \G2.1.un1_period_cnt_cry_6\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[6]_net_1\, B => period_cnt(6), C
         => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_5, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt_cry_6);
    
    \psh_negedge_reg[103]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[103]\);
    
    \PRDATA_generated_3_0_0_wmux[1]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_posedge_reg[2]\, 
        D => \pwm_posedge_reg[18]\, FCI => VCC_net_1, S => OPEN, 
        Y => \PRDATA_generated_3_0_0_y0[1]\, FCO => 
        \PRDATA_generated_3_0_0_co0[1]\);
    
    \psh_posedge_reg[107]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[107]\);
    
    \PRDATA_generated_6_0_0_wmux_0[13]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[13]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[110]\, D => \pwm_negedge_reg[126]\, FCI
         => \PRDATA_generated_6_0_0_co0[13]\, S => OPEN, Y => 
        N_788, FCO => OPEN);
    
    \G2.1.un1_period_cnt_cry_9\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[9]_net_1\, B => period_cnt(9), C
         => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_8, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt_cry_9);
    
    \psh_posedge_reg[71]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[71]\);
    
    \PRDATA_generated_15_4_0_wmux[14]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[47]\, D => \pwm_posedge_reg[63]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0[14]\, FCO => 
        \PRDATA_generated_15_4_0_co0[14]\);
    
    \psh_posedge_reg[17]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => pwm_posedge_reg(17));
    
    \PRDATA_generated_6_0_0_wmux[1]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[98]\, D => \pwm_posedge_reg[114]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[1]\, FCO => 
        \PRDATA_generated_6_0_0_co0[1]\);
    
    \psh_negedge_reg[97]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[97]\);
    
    \psh_posedge_reg[23]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[23]\);
    
    \psh_period_reg[5]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[5]_net_1\);
    
    psh_negedge_reg_1_sqmuxa_0_a3_1 : CFG2
      generic map(INIT => x"2")

      port map(A => \N_174\, B => CoreAPB3_0_APBmslave0_PADDR(5), 
        Y => psh_negedge_reg_1_sqmuxa_1_0);
    
    \PRDATA_generated_15_2_0_wmux_0[3]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_2_0_y0[3]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[68]\, D => \pwm_negedge_reg[84]\, FCI
         => \PRDATA_generated_15_2_0_co0[3]\, S => OPEN, Y => 
        PRDATA_generated_15_2_0_wmux_0_Y_3, FCO => OPEN);
    
    \PRDATA_generated_15_4_0_wmux_0[14]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0[14]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[47]\, D => \pwm_negedge_reg[63]\, FCI
         => \PRDATA_generated_15_4_0_co0[14]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y1[14]\, FCO => 
        \PRDATA_generated_15_4_0_co1[14]\);
    
    un9_psel_0_a2 : CFG3
      generic map(INIT => x"40")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => N_167, Y => 
        \un9_psel\);
    
    \sync_update\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => sync_update_0_sqmuxa, ALn => MSS_READY, 
        ADn => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT
         => GND_net_1, Q => sync_update);
    
    \psh_negedge_reg[73]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[73]\);
    
    \PRDATA_generated_3_0_0_wmux_0[2]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[2]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_negedge_reg[3]\, 
        D => \pwm_negedge_reg[19]\, FCI => 
        \PRDATA_generated_3_0_0_co0[2]\, S => OPEN, Y => N_729, 
        FCO => OPEN);
    
    \psh_posedge_reg[5]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[5]\);
    
    \psh_negedge_reg[86]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[86]\);
    
    \psh_negedge_reg[33]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[33]\);
    
    \psh_negedge_reg[122]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[122]\);
    
    \psh_negedge_reg[7]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[7]\);
    
    \PRDATA_generated_17_1_0[12]\ : CFG4
      generic map(INIT => x"2075")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_787, D => N_739, Y
         => \PRDATA_generated_17_1_0[12]_net_1\);
    
    \psh_posedge_reg[12]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[12]\);
    
    \psh_posedge_reg[94]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[94]\);
    
    \PRDATA_generated_6_0_0_wmux[12]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[109]\, D => \pwm_posedge_reg[125]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[12]\, FCO => 
        \PRDATA_generated_6_0_0_co0[12]\);
    
    \period_reg[4]\ : SLE
      port map(D => \psh_period_reg[4]_net_1\, CLK => FAB_CCC_GL0, 
        EN => prescale_reg7, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_reg[4]_net_1\);
    
    \psh_negedge_reg[23]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[23]\);
    
    \PRDATA_generated_15_2_0_wmux[3]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[68]\, D => \pwm_posedge_reg[84]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_2_0_y0[3]\, FCO => 
        \PRDATA_generated_15_2_0_co0[3]\);
    
    \psh_posedge_reg[68]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[68]\);
    
    \psh_posedge_reg[44]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[44]\);
    
    \PRDATA_generated_3_0_0_wmux_0[13]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[13]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[14]\, D => \pwm_negedge_reg[30]\, FCI
         => \PRDATA_generated_3_0_0_co0[13]\, S => OPEN, Y => 
        N_740, FCO => OPEN);
    
    \PRDATA_regif_0_iv_0_0[9]\ : CFG4
      generic map(INIT => x"EAC0")

      port map(A => \prescale_reg[9]_net_1\, B => 
        \period_reg[9]_net_1\, C => \un9_psel\, D => \un7_psel\, 
        Y => PRDATA_regif_0_iv_0_0(9));
    
    \psh_posedge_reg[109]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[109]\);
    
    \psh_negedge_reg[94]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[94]\);
    
    \PRDATA_generated_6_0_0_wmux[0]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[97]\, D => \pwm_posedge_reg[113]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[0]\, FCO => 
        \PRDATA_generated_6_0_0_co0[0]\);
    
    \psh_negedge_reg[81]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[81]\);
    
    \psh_negedge_reg[77]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[77]\);
    
    \psh_negedge_reg[13]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[13]\);
    
    \psh_negedge_reg[100]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => pwm_negedge_reg(100));
    
    \psh_posedge_reg[96]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[96]\);
    
    \psh_posedge_reg[65]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[65]\);
    
    \PRDATA_generated_15_0_0_wmux_0[2]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_0_0_y0[2]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[35]\, D => \pwm_negedge_reg[51]\, FCI
         => \PRDATA_generated_15_0_0_co0[2]\, S => OPEN, Y => 
        \PRDATA_generated_15_0_0_wmux_0_Y[2]\, FCO => OPEN);
    
    \PRDATA_generated_3_0_0_wmux[10]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[11]\, D => \pwm_posedge_reg[27]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_3_0_0_y0[10]\, FCO => 
        \PRDATA_generated_3_0_0_co0[10]\);
    
    \psh_negedge_reg[37]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[37]\);
    
    \psh_posedge_reg[83]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[83]\);
    
    \psh_posedge_reg[46]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[46]\);
    
    \PRDATA_generated_6_0_0_wmux[11]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[108]\, D => \pwm_posedge_reg[124]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[11]\, FCO => 
        \PRDATA_generated_6_0_0_co0[11]\);
    
    psh_posedge_reg_0_sqmuxa_3_2_1_a3_1 : CFG4
      generic map(INIT => x"8000")

      port map(A => CoreAPB3_0_APBmslave0_PWRITE, B => 
        CoreAPB3_0_APBmslave0_PSELx, C => 
        CoreAPB3_0_APBmslave0_PADDR(5), D => 
        CoreAPB3_0_APBmslave0_PENABLE, Y => 
        psh_posedge_reg_0_sqmuxa_3_2_0_1);
    
    \psh_negedge_reg[1]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => pwm_negedge_reg(1));
    
    un9_psel_0_a2_RNO : CFG4
      generic map(INIT => x"0001")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), C => 
        CoreAPB3_0_APBmslave0_PADDR(5), D => 
        CoreAPB3_0_APBmslave0_PADDR(4), Y => N_167);
    
    \psh_negedge_reg[49]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[49]\);
    
    \psh_negedge_reg[27]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[27]\);
    
    \prescale_reg[11]\ : SLE
      port map(D => \psh_prescale_reg[11]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \prescale_reg[11]_net_1\);
    
    \PRDATA_generated_3_0_0_wmux[12]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[13]\, D => \pwm_posedge_reg[29]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_3_0_0_y0[12]\, FCO => 
        \PRDATA_generated_3_0_0_co0[12]\);
    
    \prescale_reg[0]\ : SLE
      port map(D => \psh_prescale_reg[0]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => prescale_reg(0));
    
    \PRDATA_generated_15_2_0_wmux_0[6]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_2_0_y0[6]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[71]\, D => \pwm_negedge_reg[87]\, FCI
         => \PRDATA_generated_15_2_0_co0[6]\, S => OPEN, Y => 
        \PRDATA_generated_15_2_0_wmux_0_Y[6]\, FCO => OPEN);
    
    \PRDATA_generated_15_4_0_wmux_3[13]\ : ARI1
      generic map(INIT => x"0EC2C")

      port map(A => \PRDATA_generated_15_4_0_y3[13]\, B => 
        \PRDATA_generated_15_4_0_y1[13]\, C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => VCC_net_1, FCI => 
        \PRDATA_generated_15_4_0_co1_0[13]\, S => OPEN, Y => 
        N_932, FCO => OPEN);
    
    \psh_posedge_reg[19]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[19]\);
    
    \PRDATA_generated_3_0_0_wmux[15]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[16]\, D => \pwm_posedge_reg[32]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_3_0_0_y0[15]\, FCO => 
        \PRDATA_generated_3_0_0_co0[15]\);
    
    \PRDATA_generated_3_0_0_wmux[7]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_posedge_reg[8]\, 
        D => \pwm_posedge_reg[24]\, FCI => VCC_net_1, S => OPEN, 
        Y => \PRDATA_generated_3_0_0_y0[7]\, FCO => 
        \PRDATA_generated_3_0_0_co0[7]\);
    
    \G2.1.un1_period_cnt_cry_2\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[2]_net_1\, B => period_cnt(2), C
         => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_1, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt_cry_2);
    
    \PRDATA_generated_15_2_0_wmux_0[5]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_2_0_y0[5]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[70]\, D => \pwm_negedge_reg[86]\, FCI
         => \PRDATA_generated_15_2_0_co0[5]\, S => OPEN, Y => 
        \PRDATA_generated_15_2_0_wmux_0_Y[5]\, FCO => OPEN);
    
    \PRDATA_generated_15_2_0_wmux[6]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[71]\, D => \pwm_posedge_reg[87]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_2_0_y0[6]\, FCO => 
        \PRDATA_generated_15_2_0_co0[6]\);
    
    \psh_negedge_reg[74]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[74]\);
    
    \psh_negedge_reg[17]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => pwm_negedge_reg(17));
    
    \PRDATA_generated_15_0_0_wmux_0[0]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_0_0_y0[0]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[33]\, D => \pwm_negedge_reg[49]\, FCI
         => \PRDATA_generated_15_0_0_co0[0]\, S => OPEN, Y => 
        PRDATA_generated_15_0_0_wmux_0_Y_0, FCO => OPEN);
    
    \PRDATA_generated_6_0_0_wmux[7]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[104]\, D => \pwm_posedge_reg[120]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[7]\, FCO => 
        \PRDATA_generated_6_0_0_co0[7]\);
    
    \PRDATA_generated_15_4_0_wmux_0[10]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0[10]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[43]\, D => \pwm_negedge_reg[59]\, FCI
         => \PRDATA_generated_15_4_0_co0[10]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y1[10]\, FCO => 
        \PRDATA_generated_15_4_0_co1[10]\);
    
    un7_psel_0_a2_0 : CFG3
      generic map(INIT => x"01")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(5), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        CoreAPB3_0_APBmslave0_PADDR(3), Y => \N_60\);
    
    un3_psel_0_a2 : CFG3
      generic map(INIT => x"80")

      port map(A => CoreAPB3_0_APBmslave0_PSELx, B => 
        CoreAPB3_0_APBmslave0_PENABLE, C => 
        CoreAPB3_0_APBmslave0_PWRITE, Y => \N_174\);
    
    \PRDATA_generated_15_2_0_wmux[5]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[70]\, D => \pwm_posedge_reg[86]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_2_0_y0[5]\, FCO => 
        \PRDATA_generated_15_2_0_co0[5]\);
    
    \psh_prescale_reg[3]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        GND_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[3]_net_1\);
    
    \psh_posedge_reg[20]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[20]\);
    
    \psh_negedge_reg[34]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[34]\);
    
    \psh_posedge_reg[78]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[78]\);
    
    \psh_negedge_reg[45]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[45]\);
    
    \G2.1.un1_period_cnt_cry_5\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[5]_net_1\, B => period_cnt(5), C
         => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_4, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt_cry_5);
    
    \psh_posedge_reg[111]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[111]\);
    
    \psh_posedge_reg[128]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[128]\);
    
    psh_negedge_reg_1_sqmuxa_4_0_a2_0 : CFG4
      generic map(INIT => x"0004")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => 
        psh_posedge_reg_0_sqmuxa_3_2_0_1, C => 
        CoreAPB3_0_APBmslave0_PADDR(7), D => 
        CoreAPB3_0_APBmslave0_PADDR(6), Y => N_171);
    
    \psh_negedge_reg[24]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[24]\);
    
    \psh_prescale_reg[13]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[13]_net_1\);
    
    \psh_posedge_reg[91]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[91]\);
    
    \psh_posedge_reg[75]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[75]\);
    
    \PRDATA_generated_15_4_0_wmux_3[11]\ : ARI1
      generic map(INIT => x"0EC2C")

      port map(A => \PRDATA_generated_15_4_0_y3[11]\, B => 
        \PRDATA_generated_15_4_0_y1[11]\, C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => VCC_net_1, FCI => 
        \PRDATA_generated_15_4_0_co1_0[11]\, S => OPEN, Y => 
        N_930, FCO => OPEN);
    
    \psh_negedge_reg[98]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[98]\);
    
    \psh_posedge_reg[41]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[41]\);
    
    \psh_period_reg[11]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[11]_net_1\);
    
    \PRDATA_generated_15_4_0_wmux_1[13]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[78]\, D => \pwm_posedge_reg[94]\, FCI
         => \PRDATA_generated_15_4_0_co1[13]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0_0[13]\, FCO => 
        \PRDATA_generated_15_4_0_co0_0[13]\);
    
    \G2.1.un1_period_cnt_cry_10\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[10]_net_1\, B => period_cnt(10), 
        C => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_9, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt_cry_10);
    
    \psh_negedge_reg[14]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[14]\);
    
    \PRDATA_generated_3_0_0_wmux_0[1]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[1]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_negedge_reg[2]\, 
        D => \pwm_negedge_reg[18]\, FCI => 
        \PRDATA_generated_3_0_0_co0[1]\, S => OPEN, Y => N_728, 
        FCO => OPEN);
    
    \prescale_reg[10]\ : SLE
      port map(D => \psh_prescale_reg[10]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \prescale_reg[10]_net_1\);
    
    \PRDATA_regif_0_iv_0_0[13]\ : CFG4
      generic map(INIT => x"EAC0")

      port map(A => \prescale_reg[13]_net_1\, B => 
        \period_reg[13]_net_1\, C => \un9_psel\, D => \un7_psel\, 
        Y => PRDATA_regif_0_iv_0_0(13));
    
    \psh_negedge_reg[101]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[101]\);
    
    \PRDATA_generated_6_0_0_wmux_0[11]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[11]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[108]\, D => \pwm_negedge_reg[124]\, FCI
         => \PRDATA_generated_6_0_0_co0[11]\, S => OPEN, Y => 
        N_786, FCO => OPEN);
    
    \PRDATA_generated_15_4_0_wmux[11]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[44]\, D => \pwm_posedge_reg[60]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0[11]\, FCO => 
        \PRDATA_generated_15_4_0_co0[11]\);
    
    \psh_prescale_reg[7]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[7]_net_1\);
    
    \PRDATA_generated_3_0_0_wmux_0[4]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[4]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_negedge_reg[5]\, 
        D => \pwm_negedge_reg[21]\, FCI => 
        \PRDATA_generated_3_0_0_co0[4]\, S => OPEN, Y => N_731, 
        FCO => OPEN);
    
    psh_posedge_reg_0_sqmuxa_5_0_a2 : CFG2
      generic map(INIT => x"8")

      port map(A => N_170, B => \N_60\, Y => 
        psh_posedge_reg_0_sqmuxa_5);
    
    \PRDATA_generated_15_4_0_wmux[10]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[43]\, D => \pwm_posedge_reg[59]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0[10]\, FCO => 
        \PRDATA_generated_15_4_0_co0[10]\);
    
    \psh_negedge_reg[6]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[6]\);
    
    \psh_negedge_reg[56]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[56]\);
    
    \psh_posedge_reg[103]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[103]\);
    
    \psh_posedge_reg[27]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[27]\);
    
    \PRDATA_generated_6_0_0_wmux[14]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[111]\, D => \pwm_posedge_reg[127]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[14]\, FCO => 
        \PRDATA_generated_6_0_0_co0[14]\);
    
    \PRDATA_generated_3_0_0_wmux_0[7]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[7]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_negedge_reg[8]\, 
        D => \pwm_negedge_reg[24]\, FCI => 
        \PRDATA_generated_3_0_0_co0[7]\, S => OPEN, Y => N_734, 
        FCO => OPEN);
    
    \psh_posedge_reg[80]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[80]\);
    
    \PRDATA_generated_3_0_0_wmux_0[15]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[15]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[16]\, D => \pwm_negedge_reg[32]\, FCI
         => \PRDATA_generated_3_0_0_co0[15]\, S => OPEN, Y => 
        N_742, FCO => OPEN);
    
    \psh_posedge_reg[34]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[34]\);
    
    \PRDATA_generated_17[14]\ : CFG4
      generic map(INIT => x"0AC3")

      port map(A => N_933, B => 
        \PRDATA_generated_17_1_0[14]_net_1\, C => 
        CoreAPB3_0_APBmslave0_PADDR(6), D => 
        CoreAPB3_0_APBmslave0_PADDR(5), Y => N_965);
    
    \PRDATA_generated_15_4_0_wmux_1[11]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[76]\, D => \pwm_posedge_reg[92]\, FCI
         => \PRDATA_generated_15_4_0_co1[11]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0_0[11]\, FCO => 
        \PRDATA_generated_15_4_0_co0_0[11]\);
    
    \PRDATA_generated_6_0_0_wmux_0[2]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[2]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[99]\, D => \pwm_negedge_reg[115]\, FCI
         => \PRDATA_generated_6_0_0_co0[2]\, S => OPEN, Y => 
        N_777, FCO => OPEN);
    
    \psh_negedge_reg[78]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[78]\);
    
    \PRDATA_regif_0_iv_0_0[14]\ : CFG4
      generic map(INIT => x"EAC0")

      port map(A => \prescale_reg[14]_net_1\, B => 
        \period_reg[14]_net_1\, C => \un9_psel\, D => \un7_psel\, 
        Y => PRDATA_regif_0_iv_0_0(14));
    
    \psh_negedge_reg[83]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[83]\);
    
    \psh_negedge_reg[51]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[51]\);
    
    \PRDATA_generated_16[7]\ : CFG4
      generic map(INIT => x"5140")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => 
        \PRDATA_generated_15_2_0_wmux_0_Y[7]\, D => 
        \PRDATA_generated_15_0_0_wmux_0_Y[7]\, Y => N_942);
    
    \psh_posedge_reg[22]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[22]\);
    
    \psh_negedge_reg[38]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[38]\);
    
    \prescale_reg[1]\ : SLE
      port map(D => \psh_prescale_reg[1]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => prescale_reg(1));
    
    \psh_negedge_reg[109]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[109]\);
    
    \psh_posedge_reg[36]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[36]\);
    
    \psh_posedge_reg[117]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[117]\);
    
    \psh_posedge_reg[7]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[7]\);
    
    \PRDATA_regif_iv_0_o2_0[0]\ : CFG4
      generic map(INIT => x"F7FF")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), C => 
        CoreAPB3_0_APBmslave0_PADDR(3), D => 
        CoreAPB3_0_APBmslave0_PADDR(2), Y => N_54);
    
    psh_negedge_reg_1_sqmuxa_1_0_a2 : CFG3
      generic map(INIT => x"80")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => N_171, Y => 
        psh_negedge_reg_1_sqmuxa_1);
    
    \psh_negedge_reg[28]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[28]\);
    
    \psh_enable_reg1[7]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => N_75_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \pwm_enable_reg[7]\);
    
    \PRDATA_generated_15_0_0_wmux_0[7]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_0_0_y0[7]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[40]\, D => \pwm_negedge_reg[56]\, FCI
         => \PRDATA_generated_15_0_0_co0[7]\, S => OPEN, Y => 
        \PRDATA_generated_15_0_0_wmux_0_Y[7]\, FCO => OPEN);
    
    \psh_period_reg[9]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[9]_net_1\);
    
    \psh_posedge_reg[87]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[87]\);
    
    \prescale_reg[13]\ : SLE
      port map(D => \psh_prescale_reg[13]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \prescale_reg[13]_net_1\);
    
    \PRDATA_generated_3_0_0_wmux_0[10]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[10]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[11]\, D => \pwm_negedge_reg[27]\, FCI
         => \PRDATA_generated_3_0_0_co0[10]\, S => OPEN, Y => 
        N_737, FCO => OPEN);
    
    \PRDATA_generated_16[5]\ : CFG4
      generic map(INIT => x"5140")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => 
        \PRDATA_generated_15_2_0_wmux_0_Y[5]\, D => 
        \PRDATA_generated_15_0_0_wmux_0_Y[5]\, Y => N_940);
    
    \psh_posedge_reg[54]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[54]\);
    
    \psh_negedge_reg[18]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[18]\);
    
    \psh_negedge_reg[87]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[87]\);
    
    psh_posedge_reg_0_sqmuxa_0_a2 : CFG2
      generic map(INIT => x"8")

      port map(A => \N_174\, B => psh_posedge_reg_0_sqmuxa_0_a2_0, 
        Y => psh_posedge_reg_0_sqmuxa);
    
    \PRDATA_generated_15_0_0_wmux_0[4]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_0_0_y0[4]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[37]\, D => \pwm_negedge_reg[53]\, FCI
         => \PRDATA_generated_15_0_0_co0[4]\, S => OPEN, Y => 
        \PRDATA_generated_15_0_0_wmux_0_Y[4]\, FCO => OPEN);
    
    \psh_posedge_reg[98]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[98]\);
    
    \PRDATA_regif_0_iv_0_0[15]\ : CFG4
      generic map(INIT => x"EAC0")

      port map(A => \prescale_reg[15]_net_1\, B => 
        \period_reg[15]_net_1\, C => \un9_psel\, D => \un7_psel\, 
        Y => PRDATA_regif_0_iv_0_0(15));
    
    \PRDATA_generated_15_4_0_wmux_3[15]\ : ARI1
      generic map(INIT => x"0EC2C")

      port map(A => \PRDATA_generated_15_4_0_y3[15]\, B => 
        \PRDATA_generated_15_4_0_y1[15]\, C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => VCC_net_1, FCI => 
        \PRDATA_generated_15_4_0_co1_0[15]\, S => OPEN, Y => 
        N_934, FCO => OPEN);
    
    \period_reg[1]\ : SLE
      port map(D => \psh_period_reg[1]_net_1\, CLK => FAB_CCC_GL0, 
        EN => prescale_reg7, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_reg[1]_net_1\);
    
    \PRDATA_generated_15_4_0_wmux_3[12]\ : ARI1
      generic map(INIT => x"0EC2C")

      port map(A => \PRDATA_generated_15_4_0_y3[12]\, B => 
        \PRDATA_generated_15_4_0_y1[12]\, C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => VCC_net_1, FCI => 
        \PRDATA_generated_15_4_0_co1_0[12]\, S => OPEN, Y => 
        N_931, FCO => OPEN);
    
    \period_reg[6]\ : SLE
      port map(D => \psh_period_reg[6]_net_1\, CLK => FAB_CCC_GL0, 
        EN => prescale_reg7, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_reg[6]_net_1\);
    
    \psh_enable_reg1[1]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => N_75_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => pwm_enable_reg(1));
    
    \PRDATA_generated_15_2_0_wmux[2]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[67]\, D => \pwm_posedge_reg[83]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_2_0_y0[2]\, FCO => 
        \PRDATA_generated_15_2_0_co0[2]\);
    
    \psh_posedge_reg[48]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[48]\);
    
    \psh_negedge_reg[62]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[62]\);
    
    \psh_negedge_reg[60]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[60]\);
    
    \psh_posedge_reg[119]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[119]\);
    
    \PRDATA_generated_17[13]\ : CFG4
      generic map(INIT => x"0AC3")

      port map(A => N_932, B => 
        \PRDATA_generated_17_1_0[13]_net_1\, C => 
        CoreAPB3_0_APBmslave0_PADDR(6), D => 
        CoreAPB3_0_APBmslave0_PADDR(5), Y => N_964);
    
    psh_negedge_reg_1_sqmuxa_0_a3_1_0 : CFG3
      generic map(INIT => x"08")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        CoreAPB3_0_APBmslave0_PADDR(3), Y => 
        \psh_negedge_reg_1_sqmuxa_0_a3_1\);
    
    \psh_posedge_reg[82]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[82]\);
    
    \psh_posedge_reg[56]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[56]\);
    
    \psh_posedge_reg[29]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[29]\);
    
    \psh_posedge_reg[95]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[95]\);
    
    \PRDATA_generated_15_4_0_wmux_1[9]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[74]\, D => \pwm_posedge_reg[90]\, FCI
         => \PRDATA_generated_15_4_0_co1[9]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0_0[9]\, FCO => 
        \PRDATA_generated_15_4_0_co0_0[9]\);
    
    \psh_enable_reg1[5]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => N_75_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \pwm_enable_reg[5]\);
    
    \psh_enable_reg1[3]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => N_75_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => pwm_enable_reg(3));
    
    \psh_posedge_reg[45]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[45]\);
    
    \psh_posedge_reg[31]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[31]\);
    
    \psh_enable_reg1[2]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => N_75_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => pwm_enable_reg(2));
    
    \psh_negedge_reg[84]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[84]\);
    
    \psh_negedge_reg[46]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[46]\);
    
    \psh_posedge_reg[63]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[63]\);
    
    \psh_posedge_reg[104]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[104]\);
    
    \psh_negedge_reg[118]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[118]\);
    
    \G2.1.un1_period_cnt_cry_7\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[7]_net_1\, B => period_cnt(7), C
         => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_6, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt_cry_7);
    
    \psh_posedge_reg[102]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[102]\);
    
    \PRDATA_generated_17[12]\ : CFG4
      generic map(INIT => x"0AC3")

      port map(A => N_931, B => 
        \PRDATA_generated_17_1_0[12]_net_1\, C => 
        CoreAPB3_0_APBmslave0_PADDR(6), D => 
        CoreAPB3_0_APBmslave0_PADDR(5), Y => N_963);
    
    \PRDATA_generated_15_4_0_wmux_1[15]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[80]\, D => \pwm_posedge_reg[96]\, FCI
         => \PRDATA_generated_15_4_0_co1[15]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0_0[15]\, FCO => 
        \PRDATA_generated_15_4_0_co0_0[15]\);
    
    \PRDATA_generated_15_4_0_wmux_1[12]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[77]\, D => \pwm_posedge_reg[93]\, FCI
         => \PRDATA_generated_15_4_0_co1[12]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0_0[12]\, FCO => 
        \PRDATA_generated_15_4_0_co0_0[12]\);
    
    \PRDATA_generated_15_4_0_wmux_0[13]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0[13]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[46]\, D => \pwm_negedge_reg[62]\, FCI
         => \PRDATA_generated_15_4_0_co0[13]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y1[13]\, FCO => 
        \PRDATA_generated_15_4_0_co1[13]\);
    
    \psh_posedge_reg[106]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[106]\);
    
    \PRDATA_generated_6_0_0_wmux[10]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[107]\, D => \pwm_posedge_reg[123]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[10]\, FCO => 
        \PRDATA_generated_6_0_0_co0[10]\);
    
    \psh_negedge_reg[41]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[41]\);
    
    \PRDATA_generated_6_0_0_wmux_0[1]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[1]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[98]\, D => \pwm_negedge_reg[114]\, FCI
         => \PRDATA_generated_6_0_0_co0[1]\, S => OPEN, Y => 
        N_776, FCO => OPEN);
    
    \psh_negedge_reg[9]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[9]\);
    
    \PRDATA_generated_16[6]\ : CFG4
      generic map(INIT => x"5140")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => 
        \PRDATA_generated_15_2_0_wmux_0_Y[6]\, D => 
        \PRDATA_generated_15_0_0_wmux_0_Y[6]\, Y => N_941);
    
    \PRDATA_generated_15_0_0_wmux_0[1]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_0_0_y0[1]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[34]\, D => \pwm_negedge_reg[50]\, FCI
         => \PRDATA_generated_15_0_0_co0[1]\, S => OPEN, Y => 
        \PRDATA_generated_15_0_0_wmux_0_Y[1]\, FCO => OPEN);
    
    \psh_posedge_reg[89]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[89]\);
    
    \PRDATA_generated_6_0_0_wmux_0[4]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[4]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[101]\, D => \pwm_negedge_reg[117]\, FCI
         => \PRDATA_generated_6_0_0_co0[4]\, S => OPEN, Y => 
        N_779, FCO => OPEN);
    
    \psh_posedge_reg[51]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[51]\);
    
    \psh_period_reg[3]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        GND_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[3]_net_1\);
    
    \psh_negedge_reg[53]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[53]\);
    
    \PRDATA_generated_15_0_0_wmux[3]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[36]\, D => \pwm_posedge_reg[52]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_0_0_y0[3]\, FCO => 
        \PRDATA_generated_15_0_0_co0[3]\);
    
    \PRDATA_generated_6_0_0_wmux_0[7]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_6_0_0_y0[7]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[104]\, D => \pwm_negedge_reg[120]\, FCI
         => \PRDATA_generated_6_0_0_co0[7]\, S => OPEN, Y => 
        N_782, FCO => OPEN);
    
    \psh_prescale_reg[5]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[5]_net_1\);
    
    \PRDATA_generated_15_4_0_wmux_0[11]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0[11]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[44]\, D => \pwm_negedge_reg[60]\, FCI
         => \PRDATA_generated_15_4_0_co0[11]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y1[11]\, FCO => 
        \PRDATA_generated_15_4_0_co1[11]\);
    
    psh_negedge_reg_1_sqmuxa_5_0_a2 : CFG4
      generic map(INIT => x"8000")

      port map(A => N_69, B => psh_negedge_reg_1_sqmuxa_1_0, C
         => CoreAPB3_0_APBmslave0_PADDR(3), D => 
        CoreAPB3_0_APBmslave0_PADDR(2), Y => 
        psh_negedge_reg_1_sqmuxa_5);
    
    \PRDATA_generated_3_0_0_wmux[14]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[15]\, D => \pwm_posedge_reg[31]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_3_0_0_y0[14]\, FCO => 
        \PRDATA_generated_3_0_0_co0[14]\);
    
    \psh_posedge_reg[73]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[73]\);
    
    \psh_posedge_reg[14]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[14]\);
    
    \PRDATA_regif_0_iv_0_0[10]\ : CFG4
      generic map(INIT => x"EAC0")

      port map(A => \prescale_reg[10]_net_1\, B => 
        \period_reg[10]_net_1\, C => \un9_psel\, D => \un7_psel\, 
        Y => PRDATA_regif_0_iv_0_0(10));
    
    \psh_period_reg[15]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[15]_net_1\);
    
    psh_negedge_reg_1_sqmuxa_3_0_a2 : CFG4
      generic map(INIT => x"4000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(5), B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => N_170, D => 
        CoreAPB3_0_APBmslave0_PADDR(2), Y => 
        psh_negedge_reg_1_sqmuxa_3);
    
    \prescale_reg[14]\ : SLE
      port map(D => \psh_prescale_reg[14]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \prescale_reg[14]_net_1\);
    
    \psh_prescale_reg[11]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[11]_net_1\);
    
    \psh_negedge_reg[88]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[88]\);
    
    \PRDATA_regif_iv_0_0[4]\ : CFG4
      generic map(INIT => x"ECA0")

      port map(A => \pwm_enable_reg[5]\, B => 
        \prescale_reg[4]_net_1\, C => \un11_psel\, D => 
        \un7_psel\, Y => PRDATA_regif_iv_0_0(4));
    
    \psh_posedge_reg[113]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[113]\);
    
    \psh_negedge_reg[57]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[57]\);
    
    \psh_negedge_reg[115]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[115]\);
    
    \PRDATA_generated_16[2]\ : CFG4
      generic map(INIT => x"5140")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => 
        \PRDATA_generated_15_2_0_wmux_0_Y[2]\, D => 
        \PRDATA_generated_15_0_0_wmux_0_Y[2]\, Y => N_937);
    
    \G2.1.un1_period_cnt_cry_4\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[4]_net_1\, B => period_cnt(4), C
         => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_3, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt_cry_4);
    
    \psh_posedge_reg[16]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[16]\);
    
    \psh_negedge_reg[102]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[102]\);
    
    \PRDATA_generated_15_2_0_wmux[4]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[69]\, D => \pwm_posedge_reg[85]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_2_0_y0[4]\, FCO => 
        \PRDATA_generated_15_2_0_co0[4]\);
    
    \psh_posedge_reg[38]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[38]\);
    
    \psh_posedge_reg[60]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[60]\);
    
    \PRDATA_generated_15_2_0_wmux_0[2]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_2_0_y0[2]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[67]\, D => \pwm_negedge_reg[83]\, FCI
         => \PRDATA_generated_15_2_0_co0[2]\, S => OPEN, Y => 
        \PRDATA_generated_15_2_0_wmux_0_Y[2]\, FCO => OPEN);
    
    \PRDATA_regif_iv_0_0[6]\ : CFG4
      generic map(INIT => x"ECA0")

      port map(A => \pwm_enable_reg[7]\, B => 
        \prescale_reg[6]_net_1\, C => \un11_psel\, D => 
        \un7_psel\, Y => PRDATA_regif_iv_0_0(6));
    
    \PRDATA_generated_3_0_0_wmux[5]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_posedge_reg[6]\, 
        D => \pwm_posedge_reg[22]\, FCI => VCC_net_1, S => OPEN, 
        Y => \PRDATA_generated_3_0_0_y0[5]\, FCO => 
        \PRDATA_generated_3_0_0_co0[5]\);
    
    \PRDATA_generated_15_0_0_wmux[6]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[39]\, D => \pwm_posedge_reg[55]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_0_0_y0[6]\, FCO => 
        \PRDATA_generated_15_0_0_co0[6]\);
    
    \psh_negedge_reg[92]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[92]\);
    
    \psh_negedge_reg[90]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[90]\);
    
    \psh_negedge_reg[117]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[117]\);
    
    \PRDATA_generated_6_0_0_wmux[5]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[102]\, D => \pwm_posedge_reg[118]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[5]\, FCO => 
        \PRDATA_generated_6_0_0_co0[5]\);
    
    \PRDATA_generated_15_0_0_wmux[5]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[38]\, D => \pwm_posedge_reg[54]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_0_0_y0[5]\, FCO => 
        \PRDATA_generated_15_0_0_co0[5]\);
    
    \psh_posedge_reg[35]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[35]\);
    
    \psh_negedge_reg[128]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[128]\);
    
    \psh_posedge_reg[100]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[100]\);
    
    \psh_prescale_reg[10]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[10]_net_1\);
    
    \psh_negedge_reg[69]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[69]\);
    
    \psh_posedge_reg[105]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[105]\);
    
    \psh_negedge_reg[54]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[54]\);
    
    \psh_prescale_reg[4]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[4]_net_1\);
    
    \PRDATA_generated_15_2_0_wmux_0[0]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_2_0_y0[0]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[65]\, D => \pwm_negedge_reg[81]\, FCI
         => \PRDATA_generated_15_2_0_co0[0]\, S => OPEN, Y => 
        PRDATA_generated_15_2_0_wmux_0_Y_0, FCO => OPEN);
    
    \psh_period_reg[4]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[4]_net_1\);
    
    \PRDATA_generated_3_0_0_wmux[11]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[12]\, D => \pwm_posedge_reg[28]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_3_0_0_y0[11]\, FCO => 
        \PRDATA_generated_3_0_0_co0[11]\);
    
    \PRDATA_generated_17_1_0[14]\ : CFG4
      generic map(INIT => x"2075")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_789, D => N_741, Y
         => \PRDATA_generated_17_1_0[14]_net_1\);
    
    psh_posedge_reg_0_sqmuxa_2_0_a2 : CFG4
      generic map(INIT => x"4000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => 
        psh_posedge_reg_0_sqmuxa_3_2_0_1, D => N_69, Y => 
        psh_posedge_reg_0_sqmuxa_2);
    
    \psh_posedge_reg[58]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[58]\);
    
    \psh_posedge_reg[121]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(8), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[121]\);
    
    \PRDATA_generated_6_0_0_wmux[13]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[110]\, D => \pwm_posedge_reg[126]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_6_0_0_y0[13]\, FCO => 
        \PRDATA_generated_6_0_0_co0[13]\);
    
    \psh_negedge_reg[65]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[65]\);
    
    \psh_posedge_reg[67]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[67]\);
    
    un3_psel_0_a2_RNI6IAK : CFG2
      generic map(INIT => x"8")

      port map(A => \N_174\, B => \un7_psel\, Y => N_71_i);
    
    \psh_negedge_reg[72]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[72]\);
    
    \psh_negedge_reg[70]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[70]\);
    
    \period_reg[7]\ : SLE
      port map(D => \psh_period_reg[7]_net_1\, CLK => FAB_CCC_GL0, 
        EN => prescale_reg7, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_reg[7]_net_1\);
    
    \psh_posedge_reg[11]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[11]\);
    
    \psh_negedge_reg[43]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[43]\);
    
    \psh_period_reg[7]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[7]_net_1\);
    
    \PRDATA_generated_15_4_0_wmux_0[15]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0[15]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[48]\, D => \pwm_negedge_reg[64]\, FCI
         => \PRDATA_generated_15_4_0_co0[15]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y1[15]\, FCO => 
        \PRDATA_generated_15_4_0_co1[15]\);
    
    \psh_posedge_reg[70]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[70]\);
    
    \psh_negedge_reg[32]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[32]\);
    
    \psh_negedge_reg[30]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[30]\);
    
    \PRDATA_regif_iv_0_0[5]\ : CFG4
      generic map(INIT => x"ECA0")

      port map(A => \pwm_enable_reg[6]\, B => 
        \prescale_reg[5]_net_1\, C => \un11_psel\, D => 
        \un7_psel\, Y => PRDATA_regif_iv_0_0(5));
    
    \PRDATA_generated_15_4_0_wmux_0[12]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0[12]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[45]\, D => \pwm_negedge_reg[61]\, FCI
         => \PRDATA_generated_15_4_0_co0[12]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y1[12]\, FCO => 
        \PRDATA_generated_15_4_0_co1[12]\);
    
    \psh_negedge_reg[114]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[114]\);
    
    \PRDATA_generated_16[1]\ : CFG4
      generic map(INIT => x"5140")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => 
        \PRDATA_generated_15_2_0_wmux_0_Y[1]\, D => 
        \PRDATA_generated_15_0_0_wmux_0_Y[1]\, Y => N_936);
    
    \psh_posedge_reg[55]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[55]\);
    
    \psh_posedge_reg[3]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[3]\);
    
    \psh_negedge_reg[116]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => pwm_negedge_reg(116));
    
    \PRDATA_generated_17_1_0[8]\ : CFG4
      generic map(INIT => x"2075")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_783, D => N_735, Y
         => \PRDATA_generated_17_1_0[8]_net_1\);
    
    \psh_negedge_reg[22]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[22]\);
    
    \psh_negedge_reg[20]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[20]\);
    
    \psh_prescale_reg[14]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[14]_net_1\);
    
    \psh_posedge_reg[62]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(13), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_7, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[62]\);
    
    \PRDATA_generated_17[9]\ : CFG4
      generic map(INIT => x"0AC3")

      port map(A => N_928, B => 
        \PRDATA_generated_17_1_0[9]_net_1\, C => 
        CoreAPB3_0_APBmslave0_PADDR(6), D => 
        CoreAPB3_0_APBmslave0_PADDR(5), Y => N_960);
    
    \G2.1.un1_period_cnt_cry_13\ : ARI1
      generic map(INIT => x"5AA55")

      port map(A => \period_reg[13]_net_1\, B => period_cnt(13), 
        C => GND_net_1, D => GND_net_1, FCI => 
        un1_period_cnt_cry_12, S => OPEN, Y => OPEN, FCO => 
        un1_period_cnt_cry_13);
    
    psh_negedge_reg_1_sqmuxa_6_0_a2 : CFG4
      generic map(INIT => x"0008")

      port map(A => psh_negedge_reg_1_sqmuxa_6_0_a2_0, B => 
        \N_174\, C => CoreAPB3_0_APBmslave0_PADDR(7), D => 
        CoreAPB3_0_APBmslave0_PADDR(4), Y => 
        psh_negedge_reg_1_sqmuxa_6);
    
    \psh_negedge_reg[113]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[113]\);
    
    \PRDATA_generated_17_1_0[15]\ : CFG4
      generic map(INIT => x"2075")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_790, D => N_742, Y
         => \PRDATA_generated_17_1_0[15]_net_1\);
    
    \period_reg[10]\ : SLE
      port map(D => \psh_period_reg[10]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \period_reg[10]_net_1\);
    
    \psh_posedge_reg[93]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_2, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[93]\);
    
    \psh_posedge_reg[114]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[114]\);
    
    \psh_negedge_reg[12]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[12]\);
    
    \psh_negedge_reg[10]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[10]\);
    
    \prescale_reg[8]\ : SLE
      port map(D => \psh_prescale_reg[8]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \prescale_reg[8]_net_1\);
    
    \PRDATA_regif_0_iv_0_a2[14]\ : CFG3
      generic map(INIT => x"54")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => \N_62\, Y => N_166);
    
    \PRDATA_generated_15_4_0_wmux[12]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[45]\, D => \pwm_posedge_reg[61]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0[12]\, FCO => 
        \PRDATA_generated_15_4_0_co0[12]\);
    
    \psh_posedge_reg[43]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(10), CLK => 
        FAB_CCC_GL0, EN => \psh_posedge_reg_0_sqmuxa_3\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[43]\);
    
    \psh_negedge_reg[47]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[47]\);
    
    \psh_negedge_reg[125]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[125]\);
    
    sync_update_0_sqmuxa_0_a2 : CFG3
      generic map(INIT => x"04")

      port map(A => N_54, B => psh_posedge_reg_0_sqmuxa_3_2_0_1, 
        C => CoreAPB3_0_APBmslave0_PADDR(4), Y => 
        sync_update_0_sqmuxa);
    
    \psh_posedge_reg[1]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => pwm_posedge_reg(1));
    
    \psh_posedge_reg[112]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_5, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[112]\);
    
    psh_negedge_reg_1_sqmuxa_4_0_a2 : CFG3
      generic map(INIT => x"40")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => N_171, Y => 
        psh_negedge_reg_1_sqmuxa_4);
    
    \psh_enable_reg1[6]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => N_75_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \pwm_enable_reg[6]\);
    
    \PRDATA_regif_iv_0_0[7]\ : CFG4
      generic map(INIT => x"ECA0")

      port map(A => \pwm_enable_reg[8]\, B => 
        \prescale_reg[7]_net_1\, C => \un11_psel\, D => 
        \un7_psel\, Y => PRDATA_regif_iv_0_0(7));
    
    \psh_negedge_reg[58]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(9), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[58]\);
    
    \PRDATA_generated_3_0_0_wmux_0[6]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[6]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => \pwm_negedge_reg[7]\, 
        D => \pwm_negedge_reg[23]\, FCI => 
        \PRDATA_generated_3_0_0_co0[6]\, S => OPEN, Y => N_733, 
        FCO => OPEN);
    
    \PRDATA_generated_15_4_0_wmux_2[14]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_4_0_y0_0[14]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[79]\, D => \pwm_negedge_reg[95]\, FCI
         => \PRDATA_generated_15_4_0_co0_0[14]\, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y3[14]\, FCO => 
        \PRDATA_generated_15_4_0_co1_0[14]\);
    
    psh_posedge_reg_0_sqmuxa_1_0_a2 : CFG2
      generic map(INIT => x"8")

      port map(A => N_170, B => N_119, Y => 
        psh_posedge_reg_0_sqmuxa_1);
    
    \psh_posedge_reg[116]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[116]\);
    
    \psh_negedge_reg[127]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_3, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[127]\);
    
    \psh_posedge_reg[77]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(12), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[77]\);
    
    \psh_prescale_reg[15]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(15), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[15]_net_1\);
    
    \psh_posedge_reg[24]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_6, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[24]\);
    
    \PRDATA_generated_17_1_0[10]\ : CFG4
      generic map(INIT => x"2075")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_785, D => N_737, Y
         => \PRDATA_generated_17_1_0[10]_net_1\);
    
    \psh_posedge_reg[127]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(14), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[127]\);
    
    psh_posedge_reg_0_sqmuxa_6_0_a2_0 : CFG3
      generic map(INIT => x"10")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), C => 
        CoreAPB3_0_APBmslave0_PADDR(4), Y => N_69);
    
    \psh_period_reg[6]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => N_73_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_period_reg[6]_net_1\);
    
    \PRDATA_generated_17[8]\ : CFG4
      generic map(INIT => x"0AC3")

      port map(A => N_927, B => 
        \PRDATA_generated_17_1_0[8]_net_1\, C => 
        CoreAPB3_0_APBmslave0_PADDR(6), D => 
        CoreAPB3_0_APBmslave0_PADDR(5), Y => N_959);
    
    \PRDATA_generated_15_4_0_wmux[13]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[46]\, D => \pwm_posedge_reg[62]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_4_0_y0[13]\, FCO => 
        \PRDATA_generated_15_4_0_co0[13]\);
    
    \psh_negedge_reg[44]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(11), CLK => 
        FAB_CCC_GL0, EN => psh_negedge_reg_1_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_negedge_reg[44]\);
    
    \psh_posedge_reg[69]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[69]\);
    
    \PRDATA_generated_15_2_0_wmux_0[7]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_15_2_0_y0[7]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[72]\, D => \pwm_negedge_reg[88]\, FCI
         => \PRDATA_generated_15_2_0_co0[7]\, S => OPEN, Y => 
        \PRDATA_generated_15_2_0_wmux_0_Y[7]\, FCO => OPEN);
    
    \psh_prescale_reg[6]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => N_71_i, ALn => MSS_READY, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \psh_prescale_reg[6]_net_1\);
    
    psh_posedge_reg_0_sqmuxa_1_0_a2_0 : CFG3
      generic map(INIT => x"10")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(5), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        CoreAPB3_0_APBmslave0_PADDR(3), Y => N_119);
    
    \PRDATA_generated_15_0_0_wmux[2]\ : ARI1
      generic map(INIT => x"0FA44")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(3), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_posedge_reg[35]\, D => \pwm_posedge_reg[51]\, FCI
         => VCC_net_1, S => OPEN, Y => 
        \PRDATA_generated_15_0_0_y0[2]\, FCO => 
        \PRDATA_generated_15_0_0_co0[2]\);
    
    \period_reg[15]\ : SLE
      port map(D => \psh_period_reg[15]_net_1\, CLK => 
        FAB_CCC_GL0, EN => prescale_reg7, ALn => MSS_READY, ADn
         => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \period_reg[15]_net_1\);
    
    \psh_posedge_reg[72]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => psh_posedge_reg_0_sqmuxa_4, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \pwm_posedge_reg[72]\);
    
    \PRDATA_generated_3_0_0_wmux_0[14]\ : ARI1
      generic map(INIT => x"0F588")

      port map(A => \PRDATA_generated_3_0_0_y0[14]\, B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \pwm_negedge_reg[15]\, D => \pwm_negedge_reg[31]\, FCI
         => \PRDATA_generated_3_0_0_co0[14]\, S => OPEN, Y => 
        N_741, FCO => OPEN);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity corepwm_timebase is

    port( period_reg   : in    std_logic_vector(15 downto 0);
          prescale_reg : in    std_logic_vector(15 downto 0);
          period_cnt   : out   std_logic_vector(15 downto 0);
          sync_pulse_1 : out   std_logic;
          CCC_0_GL1    : in    std_logic;
          MSS_READY    : in    std_logic
        );

end corepwm_timebase;

architecture DEF_ARCH of corepwm_timebase is 

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component ARI1
    generic (INIT:std_logic_vector(19 downto 0) := x"00000");

    port( A   : in    std_logic := 'U';
          B   : in    std_logic := 'U';
          C   : in    std_logic := 'U';
          D   : in    std_logic := 'U';
          FCI : in    std_logic := 'U';
          S   : out   std_logic;
          Y   : out   std_logic;
          FCO : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

    signal \period_cnt[0]\, VCC_net_1, \period_cnt_int_lm[0]\, 
        period_cnt_inte, GND_net_1, \period_cnt[1]\, 
        \period_cnt_int_lm[1]\, \period_cnt[2]\, 
        \period_cnt_int_lm[2]\, \period_cnt[3]\, 
        \period_cnt_int_lm[3]\, \period_cnt[4]\, 
        \period_cnt_int_lm[4]\, \period_cnt[5]\, 
        \period_cnt_int_lm[5]\, \period_cnt[6]\, 
        \period_cnt_int_lm[6]\, \period_cnt[7]\, 
        \period_cnt_int_lm[7]\, \period_cnt[8]\, 
        \period_cnt_int_lm[8]\, \period_cnt[9]\, 
        \period_cnt_int_lm[9]\, \period_cnt[10]\, 
        \period_cnt_int_lm[10]\, \period_cnt[11]\, 
        \period_cnt_int_lm[11]\, \period_cnt[12]\, 
        \period_cnt_int_lm[12]\, \period_cnt[13]\, 
        \period_cnt_int_lm[13]\, \period_cnt[14]\, 
        \period_cnt_int_lm[14]\, \period_cnt[15]\, 
        \period_cnt_int_lm[15]\, \prescale_cnt[0]_net_1\, 
        \prescale_cnt_lm[0]\, \prescale_cnt[1]_net_1\, 
        \prescale_cnt_lm[1]\, \prescale_cnt[2]_net_1\, 
        \prescale_cnt_lm[2]\, \prescale_cnt[3]_net_1\, 
        \prescale_cnt_lm[3]\, \prescale_cnt[4]_net_1\, 
        \prescale_cnt_lm[4]\, \prescale_cnt[5]_net_1\, 
        \prescale_cnt_lm[5]\, \prescale_cnt[6]_net_1\, 
        \prescale_cnt_lm[6]\, \prescale_cnt[7]_net_1\, 
        \prescale_cnt_lm[7]\, \prescale_cnt[8]_net_1\, 
        \prescale_cnt_lm[8]\, \prescale_cnt[9]_net_1\, 
        \prescale_cnt_lm[9]\, \prescale_cnt[10]_net_1\, 
        \prescale_cnt_lm[10]\, \prescale_cnt[11]_net_1\, 
        \prescale_cnt_lm[11]\, \prescale_cnt[12]_net_1\, 
        \prescale_cnt_lm[12]\, \prescale_cnt[13]_net_1\, 
        \prescale_cnt_lm[13]\, \prescale_cnt[14]_net_1\, 
        \prescale_cnt_lm[14]\, \prescale_cnt[15]_net_1\, 
        \prescale_cnt_lm[15]\, \sync_pulse_1_cry_0\, 
        \sync_pulse_1_cry_1\, \sync_pulse_1_cry_2\, 
        \sync_pulse_1_cry_3\, \sync_pulse_1_cry_4\, 
        \sync_pulse_1_cry_5\, \sync_pulse_1_cry_6\, 
        \sync_pulse_1_cry_7\, \sync_pulse_1_cry_8\, 
        \sync_pulse_1_cry_9\, \sync_pulse_1_cry_10\, 
        \sync_pulse_1_cry_11\, \sync_pulse_1_cry_12\, 
        \sync_pulse_1_cry_13\, \sync_pulse_1_cry_14\, 
        \sync_pulse_1\, \un1_period_cnt_int_cry_0\, 
        \un1_period_cnt_int_cry_1\, \un1_period_cnt_int_cry_2\, 
        \un1_period_cnt_int_cry_3\, \un1_period_cnt_int_cry_4\, 
        \un1_period_cnt_int_cry_5\, \un1_period_cnt_int_cry_6\, 
        \un1_period_cnt_int_cry_7\, \un1_period_cnt_int_cry_8\, 
        \un1_period_cnt_int_cry_9\, \un1_period_cnt_int_cry_10\, 
        \un1_period_cnt_int_cry_11\, \un1_period_cnt_int_cry_12\, 
        \un1_period_cnt_int_cry_13\, \un1_period_cnt_int_cry_14\, 
        \un1_period_cnt_int_cry_15\, 
        \un17_prescale_cnt_0_data_tmp[0]\, 
        \un17_prescale_cnt_0_data_tmp[1]\, 
        \un17_prescale_cnt_0_data_tmp[2]\, 
        \un17_prescale_cnt_0_data_tmp[3]\, 
        \un17_prescale_cnt_0_data_tmp[4]\, 
        \un17_prescale_cnt_0_data_tmp[5]\, 
        \un17_prescale_cnt_0_data_tmp[6]\, 
        \un17_prescale_cnt_0_data_tmp[7]\, prescale_cnt_s_200_FCO, 
        \prescale_cnt_cry[1]_net_1\, \prescale_cnt_s[1]\, 
        \prescale_cnt_cry[2]_net_1\, \prescale_cnt_s[2]\, 
        \prescale_cnt_cry[3]_net_1\, \prescale_cnt_s[3]\, 
        \prescale_cnt_cry[4]_net_1\, \prescale_cnt_s[4]\, 
        \prescale_cnt_cry[5]_net_1\, \prescale_cnt_s[5]\, 
        \prescale_cnt_cry[6]_net_1\, \prescale_cnt_s[6]\, 
        \prescale_cnt_cry[7]_net_1\, \prescale_cnt_s[7]\, 
        \prescale_cnt_cry[8]_net_1\, \prescale_cnt_s[8]\, 
        \prescale_cnt_cry[9]_net_1\, \prescale_cnt_s[9]\, 
        \prescale_cnt_cry[10]_net_1\, \prescale_cnt_s[10]\, 
        \prescale_cnt_cry[11]_net_1\, \prescale_cnt_s[11]\, 
        \prescale_cnt_cry[12]_net_1\, \prescale_cnt_s[12]\, 
        \prescale_cnt_cry[13]_net_1\, \prescale_cnt_s[13]\, 
        \prescale_cnt_s[15]_net_1\, \prescale_cnt_cry[14]_net_1\, 
        \prescale_cnt_s[14]\, period_cnt_int_s_201_FCO, 
        \period_cnt_int_cry[1]_net_1\, \period_cnt_int_s[1]\, 
        \period_cnt_int_cry[2]_net_1\, \period_cnt_int_s[2]\, 
        \period_cnt_int_cry[3]_net_1\, \period_cnt_int_s[3]\, 
        \period_cnt_int_cry[4]_net_1\, \period_cnt_int_s[4]\, 
        \period_cnt_int_cry[5]_net_1\, \period_cnt_int_s[5]\, 
        \period_cnt_int_cry[6]_net_1\, \period_cnt_int_s[6]\, 
        \period_cnt_int_cry[7]_net_1\, \period_cnt_int_s[7]\, 
        \period_cnt_int_cry[8]_net_1\, \period_cnt_int_s[8]\, 
        \period_cnt_int_cry[9]_net_1\, \period_cnt_int_s[9]\, 
        \period_cnt_int_cry[10]_net_1\, \period_cnt_int_s[10]\, 
        \period_cnt_int_cry[11]_net_1\, \period_cnt_int_s[11]\, 
        \period_cnt_int_cry[12]_net_1\, \period_cnt_int_s[12]\, 
        \period_cnt_int_cry[13]_net_1\, \period_cnt_int_s[13]\, 
        \period_cnt_int_s[15]_net_1\, 
        \period_cnt_int_cry[14]_net_1\, \period_cnt_int_s[14]\
         : std_logic;

begin 

    period_cnt(15) <= \period_cnt[15]\;
    period_cnt(14) <= \period_cnt[14]\;
    period_cnt(13) <= \period_cnt[13]\;
    period_cnt(12) <= \period_cnt[12]\;
    period_cnt(11) <= \period_cnt[11]\;
    period_cnt(10) <= \period_cnt[10]\;
    period_cnt(9) <= \period_cnt[9]\;
    period_cnt(8) <= \period_cnt[8]\;
    period_cnt(7) <= \period_cnt[7]\;
    period_cnt(6) <= \period_cnt[6]\;
    period_cnt(5) <= \period_cnt[5]\;
    period_cnt(4) <= \period_cnt[4]\;
    period_cnt(3) <= \period_cnt[3]\;
    period_cnt(2) <= \period_cnt[2]\;
    period_cnt(1) <= \period_cnt[1]\;
    period_cnt(0) <= \period_cnt[0]\;
    sync_pulse_1 <= \sync_pulse_1\;

    \period_cnt_int_lm_0[5]\ : CFG3
      generic map(INIT => x"A8")

      port map(A => \period_cnt_int_s[5]\, B => 
        \un1_period_cnt_int_cry_15\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[5]\);
    
    \period_cnt_int[2]\ : SLE
      port map(D => \period_cnt_int_lm[2]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[2]\);
    
    sync_pulse_1_cry_14 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(14), B => 
        \prescale_cnt[14]_net_1\, C => GND_net_1, D => GND_net_1, 
        FCI => \sync_pulse_1_cry_13\, S => OPEN, Y => OPEN, FCO
         => \sync_pulse_1_cry_14\);
    
    sync_pulse_1_cry_13 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(13), B => 
        \prescale_cnt[13]_net_1\, C => GND_net_1, D => GND_net_1, 
        FCI => \sync_pulse_1_cry_12\, S => OPEN, Y => OPEN, FCO
         => \sync_pulse_1_cry_13\);
    
    sync_pulse_1_cry_11 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(11), B => 
        \prescale_cnt[11]_net_1\, C => GND_net_1, D => GND_net_1, 
        FCI => \sync_pulse_1_cry_10\, S => OPEN, Y => OPEN, FCO
         => \sync_pulse_1_cry_11\);
    
    un1_period_cnt_int_cry_9 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(9), B => \period_cnt[9]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_8\, S => OPEN, Y => OPEN, FCO => 
        \un1_period_cnt_int_cry_9\);
    
    \period_cnt_int_lm_0[14]\ : CFG3
      generic map(INIT => x"C8")

      port map(A => \un1_period_cnt_int_cry_15\, B => 
        \period_cnt_int_s[14]\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[14]\);
    
    un1_period_cnt_int_cry_2 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(2), B => \period_cnt[2]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_1\, S => OPEN, Y => OPEN, FCO => 
        \un1_period_cnt_int_cry_2\);
    
    un17_prescale_cnt_0_I_9 : ARI1
      generic map(INIT => x"68421")

      port map(A => prescale_reg(3), B => \prescale_cnt[2]_net_1\, 
        C => \prescale_cnt[3]_net_1\, D => prescale_reg(2), FCI
         => \un17_prescale_cnt_0_data_tmp[0]\, S => OPEN, Y => 
        OPEN, FCO => \un17_prescale_cnt_0_data_tmp[1]\);
    
    sync_pulse_1_cry_9 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(9), B => \prescale_cnt[9]_net_1\, 
        C => GND_net_1, D => GND_net_1, FCI => 
        \sync_pulse_1_cry_8\, S => OPEN, Y => OPEN, FCO => 
        \sync_pulse_1_cry_9\);
    
    \prescale_cnt_lm_0[3]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \sync_pulse_1\, B => \prescale_cnt_s[3]\, Y
         => \prescale_cnt_lm[3]\);
    
    un1_period_cnt_int_cry_6 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(6), B => \period_cnt[6]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_5\, S => OPEN, Y => OPEN, FCO => 
        \un1_period_cnt_int_cry_6\);
    
    \period_cnt_int_cry[13]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[13]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \period_cnt_int_cry[12]_net_1\, S => 
        \period_cnt_int_s[13]\, Y => OPEN, FCO => 
        \period_cnt_int_cry[13]_net_1\);
    
    \prescale_cnt_lm_0[14]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \prescale_cnt_s[14]\, B => \sync_pulse_1\, Y
         => \prescale_cnt_lm[14]\);
    
    \prescale_cnt_cry[11]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[11]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        \prescale_cnt_cry[10]_net_1\, S => \prescale_cnt_s[11]\, 
        Y => OPEN, FCO => \prescale_cnt_cry[11]_net_1\);
    
    \period_cnt_int_cry[14]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[14]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \period_cnt_int_cry[13]_net_1\, S => 
        \period_cnt_int_s[14]\, Y => OPEN, FCO => 
        \period_cnt_int_cry[14]_net_1\);
    
    \prescale_cnt[0]\ : SLE
      port map(D => \prescale_cnt_lm[0]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[0]_net_1\);
    
    period_cnt_int_s_201 : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[0]\, C => 
        GND_net_1, D => GND_net_1, FCI => VCC_net_1, S => OPEN, Y
         => OPEN, FCO => period_cnt_int_s_201_FCO);
    
    sync_pulse_1_cry_3 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(3), B => \prescale_cnt[3]_net_1\, 
        C => GND_net_1, D => GND_net_1, FCI => 
        \sync_pulse_1_cry_2\, S => OPEN, Y => OPEN, FCO => 
        \sync_pulse_1_cry_3\);
    
    \prescale_cnt_cry[12]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[12]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        \prescale_cnt_cry[11]_net_1\, S => \prescale_cnt_s[12]\, 
        Y => OPEN, FCO => \prescale_cnt_cry[12]_net_1\);
    
    \period_cnt_int_cry[10]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[10]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \period_cnt_int_cry[9]_net_1\, S => 
        \period_cnt_int_s[10]\, Y => OPEN, FCO => 
        \period_cnt_int_cry[10]_net_1\);
    
    \period_cnt_int[10]\ : SLE
      port map(D => \period_cnt_int_lm[10]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[10]\);
    
    \period_cnt_int_cry[7]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[7]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \period_cnt_int_cry[6]_net_1\, S => \period_cnt_int_s[7]\, 
        Y => OPEN, FCO => \period_cnt_int_cry[7]_net_1\);
    
    \prescale_cnt_cry[4]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[4]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        \prescale_cnt_cry[3]_net_1\, S => \prescale_cnt_s[4]\, Y
         => OPEN, FCO => \prescale_cnt_cry[4]_net_1\);
    
    \period_cnt_int[0]\ : SLE
      port map(D => \period_cnt_int_lm[0]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[0]\);
    
    \prescale_cnt_cry[14]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[14]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        \prescale_cnt_cry[13]_net_1\, S => \prescale_cnt_s[14]\, 
        Y => OPEN, FCO => \prescale_cnt_cry[14]_net_1\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \prescale_cnt[11]\ : SLE
      port map(D => \prescale_cnt_lm[11]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[11]_net_1\);
    
    \prescale_cnt[3]\ : SLE
      port map(D => \prescale_cnt_lm[3]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[3]_net_1\);
    
    \period_cnt_int_lm_0[4]\ : CFG3
      generic map(INIT => x"A8")

      port map(A => \period_cnt_int_s[4]\, B => 
        \un1_period_cnt_int_cry_15\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[4]\);
    
    \prescale_cnt_cry[13]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[13]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        \prescale_cnt_cry[12]_net_1\, S => \prescale_cnt_s[13]\, 
        Y => OPEN, FCO => \prescale_cnt_cry[13]_net_1\);
    
    \period_cnt_int_lm_0[7]\ : CFG3
      generic map(INIT => x"C8")

      port map(A => \un1_period_cnt_int_cry_15\, B => 
        \period_cnt_int_s[7]\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[7]\);
    
    \period_cnt_int_lm_0[9]\ : CFG3
      generic map(INIT => x"C8")

      port map(A => \un1_period_cnt_int_cry_15\, B => 
        \period_cnt_int_s[9]\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[9]\);
    
    \period_cnt_int_cry[9]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[9]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \period_cnt_int_cry[8]_net_1\, S => \period_cnt_int_s[9]\, 
        Y => OPEN, FCO => \period_cnt_int_cry[9]_net_1\);
    
    \period_cnt_int_cry[6]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[6]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \period_cnt_int_cry[5]_net_1\, S => \period_cnt_int_s[6]\, 
        Y => OPEN, FCO => \period_cnt_int_cry[6]_net_1\);
    
    \prescale_cnt_cry[6]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[6]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        \prescale_cnt_cry[5]_net_1\, S => \prescale_cnt_s[6]\, Y
         => OPEN, FCO => \prescale_cnt_cry[6]_net_1\);
    
    \period_cnt_int_lm_0[8]\ : CFG3
      generic map(INIT => x"C8")

      port map(A => \un1_period_cnt_int_cry_15\, B => 
        \period_cnt_int_s[8]\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[8]\);
    
    \prescale_cnt_lm_0[11]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \prescale_cnt_s[11]\, B => \sync_pulse_1\, Y
         => \prescale_cnt_lm[11]\);
    
    un1_period_cnt_int_cry_4 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(4), B => \period_cnt[4]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_3\, S => OPEN, Y => OPEN, FCO => 
        \un1_period_cnt_int_cry_4\);
    
    \prescale_cnt_cry[8]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[8]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        \prescale_cnt_cry[7]_net_1\, S => \prescale_cnt_s[8]\, Y
         => OPEN, FCO => \prescale_cnt_cry[8]_net_1\);
    
    \prescale_cnt[6]\ : SLE
      port map(D => \prescale_cnt_lm[6]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[6]_net_1\);
    
    un1_period_cnt_int_cry_12 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(12), B => \period_cnt[12]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_11\, S => OPEN, Y => OPEN, FCO
         => \un1_period_cnt_int_cry_12\);
    
    un17_prescale_cnt_0_I_15 : ARI1
      generic map(INIT => x"68421")

      port map(A => prescale_reg(5), B => \prescale_cnt[4]_net_1\, 
        C => \prescale_cnt[5]_net_1\, D => prescale_reg(4), FCI
         => \un17_prescale_cnt_0_data_tmp[1]\, S => OPEN, Y => 
        OPEN, FCO => \un17_prescale_cnt_0_data_tmp[2]\);
    
    \prescale_cnt_lm_0[12]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \prescale_cnt_s[12]\, B => \sync_pulse_1\, Y
         => \prescale_cnt_lm[12]\);
    
    \period_cnt_int[13]\ : SLE
      port map(D => \period_cnt_int_lm[13]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[13]\);
    
    \prescale_cnt[14]\ : SLE
      port map(D => \prescale_cnt_lm[14]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[14]_net_1\);
    
    \prescale_cnt[5]\ : SLE
      port map(D => \prescale_cnt_lm[5]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[5]_net_1\);
    
    \period_cnt_int_s[15]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[15]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \period_cnt_int_cry[14]_net_1\, S => 
        \period_cnt_int_s[15]_net_1\, Y => OPEN, FCO => OPEN);
    
    \period_cnt_int[15]\ : SLE
      port map(D => \period_cnt_int_lm[15]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[15]\);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \period_cnt_int[9]\ : SLE
      port map(D => \period_cnt_int_lm[9]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[9]\);
    
    \period_cnt_int_cry[4]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[4]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \period_cnt_int_cry[3]_net_1\, S => \period_cnt_int_s[4]\, 
        Y => OPEN, FCO => \period_cnt_int_cry[4]_net_1\);
    
    \period_cnt_int_cry[11]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[11]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \period_cnt_int_cry[10]_net_1\, S => 
        \period_cnt_int_s[11]\, Y => OPEN, FCO => 
        \period_cnt_int_cry[11]_net_1\);
    
    \period_cnt_int_cry[12]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[12]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \period_cnt_int_cry[11]_net_1\, S => 
        \period_cnt_int_s[12]\, Y => OPEN, FCO => 
        \period_cnt_int_cry[12]_net_1\);
    
    un1_period_cnt_int_cry_5 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(5), B => \period_cnt[5]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_4\, S => OPEN, Y => OPEN, FCO => 
        \un1_period_cnt_int_cry_5\);
    
    \period_cnt_int_cry[1]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[1]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        period_cnt_int_s_201_FCO, S => \period_cnt_int_s[1]\, Y
         => OPEN, FCO => \period_cnt_int_cry[1]_net_1\);
    
    \period_cnt_int[14]\ : SLE
      port map(D => \period_cnt_int_lm[14]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[14]\);
    
    \period_cnt_int[12]\ : SLE
      port map(D => \period_cnt_int_lm[12]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[12]\);
    
    sync_pulse_1_cry_2 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(2), B => \prescale_cnt[2]_net_1\, 
        C => GND_net_1, D => GND_net_1, FCI => 
        \sync_pulse_1_cry_1\, S => OPEN, Y => OPEN, FCO => 
        \sync_pulse_1_cry_2\);
    
    \period_cnt_int_lm_0[3]\ : CFG3
      generic map(INIT => x"A8")

      port map(A => \period_cnt_int_s[3]\, B => 
        \un1_period_cnt_int_cry_15\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[3]\);
    
    \prescale_cnt_lm_0[10]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \prescale_cnt_s[10]\, B => \sync_pulse_1\, Y
         => \prescale_cnt_lm[10]\);
    
    \period_cnt_int[1]\ : SLE
      port map(D => \period_cnt_int_lm[1]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[1]\);
    
    un1_period_cnt_int_cry_15 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(15), B => \period_cnt[15]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_14\, S => OPEN, Y => OPEN, FCO
         => \un1_period_cnt_int_cry_15\);
    
    \period_cnt_int_lm_0[0]\ : CFG3
      generic map(INIT => x"32")

      port map(A => \un1_period_cnt_int_cry_15\, B => 
        \period_cnt[0]\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[0]\);
    
    un17_prescale_cnt_0_I_21 : ARI1
      generic map(INIT => x"68421")

      port map(A => prescale_reg(15), B => 
        \prescale_cnt[14]_net_1\, C => \prescale_cnt[15]_net_1\, 
        D => prescale_reg(14), FCI => 
        \un17_prescale_cnt_0_data_tmp[6]\, S => OPEN, Y => OPEN, 
        FCO => \un17_prescale_cnt_0_data_tmp[7]\);
    
    sync_pulse_1_cry_0 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(0), B => \prescale_cnt[0]_net_1\, 
        C => GND_net_1, D => GND_net_1, FCI => GND_net_1, S => 
        OPEN, Y => OPEN, FCO => \sync_pulse_1_cry_0\);
    
    un1_period_cnt_int_cry_8 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(8), B => \period_cnt[8]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_7\, S => OPEN, Y => OPEN, FCO => 
        \un1_period_cnt_int_cry_8\);
    
    un17_prescale_cnt_0_I_45 : ARI1
      generic map(INIT => x"68421")

      port map(A => prescale_reg(9), B => \prescale_cnt[8]_net_1\, 
        C => \prescale_cnt[9]_net_1\, D => prescale_reg(8), FCI
         => \un17_prescale_cnt_0_data_tmp[3]\, S => OPEN, Y => 
        OPEN, FCO => \un17_prescale_cnt_0_data_tmp[4]\);
    
    \prescale_cnt_lm_0[2]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \sync_pulse_1\, B => \prescale_cnt_s[2]\, Y
         => \prescale_cnt_lm[2]\);
    
    \prescale_cnt[9]\ : SLE
      port map(D => \prescale_cnt_lm[9]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[9]_net_1\);
    
    \period_cnt_int[3]\ : SLE
      port map(D => \period_cnt_int_lm[3]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[3]\);
    
    sync_pulse_1_cry_4 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(4), B => \prescale_cnt[4]_net_1\, 
        C => GND_net_1, D => GND_net_1, FCI => 
        \sync_pulse_1_cry_3\, S => OPEN, Y => OPEN, FCO => 
        \sync_pulse_1_cry_4\);
    
    \prescale_cnt_s[15]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[15]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        \prescale_cnt_cry[14]_net_1\, S => 
        \prescale_cnt_s[15]_net_1\, Y => OPEN, FCO => OPEN);
    
    \prescale_cnt_cry[10]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[10]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        \prescale_cnt_cry[9]_net_1\, S => \prescale_cnt_s[10]\, Y
         => OPEN, FCO => \prescale_cnt_cry[10]_net_1\);
    
    \prescale_cnt[13]\ : SLE
      port map(D => \prescale_cnt_lm[13]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[13]_net_1\);
    
    un1_period_cnt_int_cry_1 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(1), B => \period_cnt[1]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_0\, S => OPEN, Y => OPEN, FCO => 
        \un1_period_cnt_int_cry_1\);
    
    \prescale_cnt_lm_0[7]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \prescale_cnt_s[7]\, B => \sync_pulse_1\, Y
         => \prescale_cnt_lm[7]\);
    
    \period_cnt_int_lm_0[12]\ : CFG3
      generic map(INIT => x"C8")

      port map(A => \un1_period_cnt_int_cry_15\, B => 
        \period_cnt_int_s[12]\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[12]\);
    
    sync_pulse_1_cry_15 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(15), B => 
        \prescale_cnt[15]_net_1\, C => GND_net_1, D => GND_net_1, 
        FCI => \sync_pulse_1_cry_14\, S => OPEN, Y => OPEN, FCO
         => \sync_pulse_1\);
    
    \prescale_cnt_lm_0[1]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \sync_pulse_1\, B => \prescale_cnt_s[1]\, Y
         => \prescale_cnt_lm[1]\);
    
    \prescale_cnt_lm_0[15]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \prescale_cnt_s[15]_net_1\, B => 
        \sync_pulse_1\, Y => \prescale_cnt_lm[15]\);
    
    sync_pulse_1_cry_1 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(1), B => \prescale_cnt[1]_net_1\, 
        C => GND_net_1, D => GND_net_1, FCI => 
        \sync_pulse_1_cry_0\, S => OPEN, Y => OPEN, FCO => 
        \sync_pulse_1_cry_1\);
    
    \prescale_cnt_lm_0[0]\ : CFG2
      generic map(INIT => x"2")

      port map(A => \sync_pulse_1\, B => \prescale_cnt[0]_net_1\, 
        Y => \prescale_cnt_lm[0]\);
    
    \prescale_cnt_cry[5]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[5]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        \prescale_cnt_cry[4]_net_1\, S => \prescale_cnt_s[5]\, Y
         => OPEN, FCO => \prescale_cnt_cry[5]_net_1\);
    
    \period_cnt_int_lm_0[13]\ : CFG3
      generic map(INIT => x"C8")

      port map(A => \un1_period_cnt_int_cry_15\, B => 
        \period_cnt_int_s[13]\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[13]\);
    
    \period_cnt_int[5]\ : SLE
      port map(D => \period_cnt_int_lm[5]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[5]\);
    
    \prescale_cnt[1]\ : SLE
      port map(D => \prescale_cnt_lm[1]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[1]_net_1\);
    
    un17_prescale_cnt_0_I_39 : ARI1
      generic map(INIT => x"68421")

      port map(A => prescale_reg(13), B => 
        \prescale_cnt[12]_net_1\, C => \prescale_cnt[13]_net_1\, 
        D => prescale_reg(12), FCI => 
        \un17_prescale_cnt_0_data_tmp[5]\, S => OPEN, Y => OPEN, 
        FCO => \un17_prescale_cnt_0_data_tmp[6]\);
    
    sync_pulse_1_cry_5 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(5), B => \prescale_cnt[5]_net_1\, 
        C => GND_net_1, D => GND_net_1, FCI => 
        \sync_pulse_1_cry_4\, S => OPEN, Y => OPEN, FCO => 
        \sync_pulse_1_cry_5\);
    
    \period_cnt_int_lm_0[15]\ : CFG3
      generic map(INIT => x"C8")

      port map(A => \un1_period_cnt_int_cry_15\, B => 
        \period_cnt_int_s[15]_net_1\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[15]\);
    
    \prescale_cnt_lm_0[4]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \sync_pulse_1\, B => \prescale_cnt_s[4]\, Y
         => \prescale_cnt_lm[4]\);
    
    \prescale_cnt_cry[7]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[7]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        \prescale_cnt_cry[6]_net_1\, S => \prescale_cnt_s[7]\, Y
         => OPEN, FCO => \prescale_cnt_cry[7]_net_1\);
    
    \period_cnt_int_lm_0[1]\ : CFG3
      generic map(INIT => x"A8")

      port map(A => \period_cnt_int_s[1]\, B => 
        \un1_period_cnt_int_cry_15\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[1]\);
    
    \period_cnt_int[4]\ : SLE
      port map(D => \period_cnt_int_lm[4]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[4]\);
    
    \period_cnt_int[8]\ : SLE
      port map(D => \period_cnt_int_lm[8]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[8]\);
    
    \period_cnt_int[6]\ : SLE
      port map(D => \period_cnt_int_lm[6]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[6]\);
    
    \prescale_cnt_cry[1]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[1]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        prescale_cnt_s_200_FCO, S => \prescale_cnt_s[1]\, Y => 
        OPEN, FCO => \prescale_cnt_cry[1]_net_1\);
    
    \period_cnt_int_lm_0[6]\ : CFG3
      generic map(INIT => x"A8")

      port map(A => \period_cnt_int_s[6]\, B => 
        \un1_period_cnt_int_cry_15\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[6]\);
    
    \period_cnt_int_lm_0[10]\ : CFG3
      generic map(INIT => x"C8")

      port map(A => \un1_period_cnt_int_cry_15\, B => 
        \period_cnt_int_s[10]\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[10]\);
    
    un17_prescale_cnt_0_I_21_RNI6H0E : CFG3
      generic map(INIT => x"1F")

      port map(A => \sync_pulse_1\, B => 
        \un1_period_cnt_int_cry_15\, C => 
        \un17_prescale_cnt_0_data_tmp[7]\, Y => period_cnt_inte);
    
    \prescale_cnt_lm_0[9]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \prescale_cnt_s[9]\, B => \sync_pulse_1\, Y
         => \prescale_cnt_lm[9]\);
    
    un1_period_cnt_int_cry_14 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(14), B => \period_cnt[14]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_13\, S => OPEN, Y => OPEN, FCO
         => \un1_period_cnt_int_cry_14\);
    
    \prescale_cnt[12]\ : SLE
      port map(D => \prescale_cnt_lm[12]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[12]_net_1\);
    
    \period_cnt_int_cry[5]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[5]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \period_cnt_int_cry[4]_net_1\, S => \period_cnt_int_s[5]\, 
        Y => OPEN, FCO => \period_cnt_int_cry[5]_net_1\);
    
    \prescale_cnt_lm_0[6]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \sync_pulse_1\, B => \prescale_cnt_s[6]\, Y
         => \prescale_cnt_lm[6]\);
    
    un1_period_cnt_int_cry_7 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(7), B => \period_cnt[7]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_6\, S => OPEN, Y => OPEN, FCO => 
        \un1_period_cnt_int_cry_7\);
    
    \prescale_cnt[4]\ : SLE
      port map(D => \prescale_cnt_lm[4]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[4]_net_1\);
    
    un1_period_cnt_int_cry_13 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(13), B => \period_cnt[13]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_12\, S => OPEN, Y => OPEN, FCO
         => \un1_period_cnt_int_cry_13\);
    
    \prescale_cnt_cry[9]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[9]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        \prescale_cnt_cry[8]_net_1\, S => \prescale_cnt_s[9]\, Y
         => OPEN, FCO => \prescale_cnt_cry[9]_net_1\);
    
    un17_prescale_cnt_0_I_33 : ARI1
      generic map(INIT => x"68421")

      port map(A => prescale_reg(11), B => 
        \prescale_cnt[10]_net_1\, C => \prescale_cnt[11]_net_1\, 
        D => prescale_reg(10), FCI => 
        \un17_prescale_cnt_0_data_tmp[4]\, S => OPEN, Y => OPEN, 
        FCO => \un17_prescale_cnt_0_data_tmp[5]\);
    
    \period_cnt_int_lm_0[11]\ : CFG3
      generic map(INIT => x"C8")

      port map(A => \un1_period_cnt_int_cry_15\, B => 
        \period_cnt_int_s[11]\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[11]\);
    
    \prescale_cnt_cry[2]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[2]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        \prescale_cnt_cry[1]_net_1\, S => \prescale_cnt_s[2]\, Y
         => OPEN, FCO => \prescale_cnt_cry[2]_net_1\);
    
    \period_cnt_int_cry[8]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[8]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \period_cnt_int_cry[7]_net_1\, S => \period_cnt_int_s[8]\, 
        Y => OPEN, FCO => \period_cnt_int_cry[8]_net_1\);
    
    un17_prescale_cnt_0_I_1 : ARI1
      generic map(INIT => x"68421")

      port map(A => prescale_reg(1), B => \prescale_cnt[0]_net_1\, 
        C => \prescale_cnt[1]_net_1\, D => prescale_reg(0), FCI
         => GND_net_1, S => OPEN, Y => OPEN, FCO => 
        \un17_prescale_cnt_0_data_tmp[0]\);
    
    \prescale_cnt[8]\ : SLE
      port map(D => \prescale_cnt_lm[8]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[8]_net_1\);
    
    \prescale_cnt_lm_0[8]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \prescale_cnt_s[8]\, B => \sync_pulse_1\, Y
         => \prescale_cnt_lm[8]\);
    
    \prescale_cnt[2]\ : SLE
      port map(D => \prescale_cnt_lm[2]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[2]_net_1\);
    
    \prescale_cnt_lm_0[5]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \sync_pulse_1\, B => \prescale_cnt_s[5]\, Y
         => \prescale_cnt_lm[5]\);
    
    un1_period_cnt_int_cry_11 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(11), B => \period_cnt[11]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_10\, S => OPEN, Y => OPEN, FCO
         => \un1_period_cnt_int_cry_11\);
    
    sync_pulse_1_cry_7 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(7), B => \prescale_cnt[7]_net_1\, 
        C => GND_net_1, D => GND_net_1, FCI => 
        \sync_pulse_1_cry_6\, S => OPEN, Y => OPEN, FCO => 
        \sync_pulse_1_cry_7\);
    
    \prescale_cnt[7]\ : SLE
      port map(D => \prescale_cnt_lm[7]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[7]_net_1\);
    
    sync_pulse_1_cry_10 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(10), B => 
        \prescale_cnt[10]_net_1\, C => GND_net_1, D => GND_net_1, 
        FCI => \sync_pulse_1_cry_9\, S => OPEN, Y => OPEN, FCO
         => \sync_pulse_1_cry_10\);
    
    sync_pulse_1_cry_8 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(8), B => \prescale_cnt[8]_net_1\, 
        C => GND_net_1, D => GND_net_1, FCI => 
        \sync_pulse_1_cry_7\, S => OPEN, Y => OPEN, FCO => 
        \sync_pulse_1_cry_8\);
    
    \prescale_cnt_lm_0[13]\ : CFG2
      generic map(INIT => x"8")

      port map(A => \prescale_cnt_s[13]\, B => \sync_pulse_1\, Y
         => \prescale_cnt_lm[13]\);
    
    \period_cnt_int_cry[2]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[2]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \period_cnt_int_cry[1]_net_1\, S => \period_cnt_int_s[2]\, 
        Y => OPEN, FCO => \period_cnt_int_cry[2]_net_1\);
    
    sync_pulse_1_cry_6 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(6), B => \prescale_cnt[6]_net_1\, 
        C => GND_net_1, D => GND_net_1, FCI => 
        \sync_pulse_1_cry_5\, S => OPEN, Y => OPEN, FCO => 
        \sync_pulse_1_cry_6\);
    
    \prescale_cnt[15]\ : SLE
      port map(D => \prescale_cnt_lm[15]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[15]_net_1\);
    
    \period_cnt_int_cry[3]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \period_cnt[3]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \period_cnt_int_cry[2]_net_1\, S => \period_cnt_int_s[3]\, 
        Y => OPEN, FCO => \period_cnt_int_cry[3]_net_1\);
    
    sync_pulse_1_cry_12 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => prescale_reg(12), B => 
        \prescale_cnt[12]_net_1\, C => GND_net_1, D => GND_net_1, 
        FCI => \sync_pulse_1_cry_11\, S => OPEN, Y => OPEN, FCO
         => \sync_pulse_1_cry_12\);
    
    un1_period_cnt_int_cry_10 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(10), B => \period_cnt[10]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_9\, S => OPEN, Y => OPEN, FCO => 
        \un1_period_cnt_int_cry_10\);
    
    \prescale_cnt[10]\ : SLE
      port map(D => \prescale_cnt_lm[10]\, CLK => CCC_0_GL1, EN
         => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \prescale_cnt[10]_net_1\);
    
    un17_prescale_cnt_0_I_27 : ARI1
      generic map(INIT => x"68421")

      port map(A => prescale_reg(7), B => \prescale_cnt[6]_net_1\, 
        C => \prescale_cnt[7]_net_1\, D => prescale_reg(6), FCI
         => \un17_prescale_cnt_0_data_tmp[2]\, S => OPEN, Y => 
        OPEN, FCO => \un17_prescale_cnt_0_data_tmp[3]\);
    
    \period_cnt_int_lm_0[2]\ : CFG3
      generic map(INIT => x"A8")

      port map(A => \period_cnt_int_s[2]\, B => 
        \un1_period_cnt_int_cry_15\, C => \sync_pulse_1\, Y => 
        \period_cnt_int_lm[2]\);
    
    un1_period_cnt_int_cry_0 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(0), B => \period_cnt[0]\, C => 
        GND_net_1, D => GND_net_1, FCI => GND_net_1, S => OPEN, Y
         => OPEN, FCO => \un1_period_cnt_int_cry_0\);
    
    prescale_cnt_s_200 : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[0]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => VCC_net_1, S => 
        OPEN, Y => OPEN, FCO => prescale_cnt_s_200_FCO);
    
    \period_cnt_int[7]\ : SLE
      port map(D => \period_cnt_int_lm[7]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[7]\);
    
    \period_cnt_int[11]\ : SLE
      port map(D => \period_cnt_int_lm[11]\, CLK => CCC_0_GL1, EN
         => period_cnt_inte, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \period_cnt[11]\);
    
    un1_period_cnt_int_cry_3 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => period_reg(3), B => \period_cnt[3]\, C => 
        GND_net_1, D => GND_net_1, FCI => 
        \un1_period_cnt_int_cry_2\, S => OPEN, Y => OPEN, FCO => 
        \un1_period_cnt_int_cry_3\);
    
    \prescale_cnt_cry[3]\ : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \prescale_cnt[3]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => 
        \prescale_cnt_cry[2]_net_1\, S => \prescale_cnt_s[3]\, Y
         => OPEN, FCO => \prescale_cnt_cry[3]_net_1\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity corepwm is

    port( PWM_c                              : out   std_logic_vector(7 downto 0);
          CoreAPB3_0_APBmslave0_PWDATA       : in    std_logic_vector(15 downto 0);
          pwm_enable_reg                     : out   std_logic_vector(4 downto 1);
          prescale_reg                       : out   std_logic_vector(3 downto 0);
          period_reg                         : out   std_logic_vector(7 downto 0);
          PRDATA_regif_iv_0_0                : out   std_logic_vector(7 downto 4);
          PRDATA_regif_0_iv_0_0              : out   std_logic_vector(15 downto 8);
          CoreAPB3_0_APBmslave0_PADDR        : in    std_logic_vector(7 downto 2);
          PWM_STRETCH                        : out   std_logic_vector(7 downto 0);
          pwm_negedge_reg_0                  : out   std_logic;
          pwm_negedge_reg_16                 : out   std_logic;
          pwm_negedge_reg_99                 : out   std_logic;
          pwm_negedge_reg_115                : out   std_logic;
          pwm_posedge_reg_0                  : out   std_logic;
          pwm_posedge_reg_16                 : out   std_logic;
          PRDATA_generated_15_2_0_wmux_0_Y_3 : out   std_logic;
          PRDATA_generated_15_2_0_wmux_0_Y_0 : out   std_logic;
          PRDATA_generated_15_0_0_wmux_0_Y_3 : out   std_logic;
          PRDATA_generated_15_0_0_wmux_0_Y_0 : out   std_logic;
          PRDATA_generated_6_0_0             : out   std_logic;
          CCC_0_GL1                          : in    std_logic;
          sync_update                        : out   std_logic;
          N_728                              : out   std_logic;
          N_734                              : out   std_logic;
          N_776                              : out   std_logic;
          N_733                              : out   std_logic;
          N_729                              : out   std_logic;
          N_10_1                             : out   std_logic;
          N_777                              : out   std_logic;
          N_782                              : out   std_logic;
          N_730                              : out   std_logic;
          N_731                              : out   std_logic;
          N_732                              : out   std_logic;
          N_780                              : out   std_logic;
          N_779                              : out   std_logic;
          N_781                              : out   std_logic;
          CoreAPB3_0_APBmslave0_PWRITE       : in    std_logic;
          CoreAPB3_0_APBmslave0_PSELx        : in    std_logic;
          CoreAPB3_0_APBmslave0_PENABLE      : in    std_logic;
          N_937                              : out   std_logic;
          N_942                              : out   std_logic;
          N_939                              : out   std_logic;
          N_941                              : out   std_logic;
          N_940                              : out   std_logic;
          N_936                              : out   std_logic;
          N_965                              : out   std_logic;
          N_961                              : out   std_logic;
          N_964                              : out   std_logic;
          N_963                              : out   std_logic;
          N_966                              : out   std_logic;
          N_960                              : out   std_logic;
          N_959                              : out   std_logic;
          N_962                              : out   std_logic;
          N_60                               : out   std_logic;
          un11_psel                          : out   std_logic;
          un7_psel                           : out   std_logic;
          un9_psel                           : out   std_logic;
          N_62                               : out   std_logic;
          N_166                              : out   std_logic;
          FAB_CCC_GL0                        : in    std_logic;
          MSS_READY                          : in    std_logic
        );

end corepwm;

architecture DEF_ARCH of corepwm is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component corepwm_pwm_gen
    port( pwm_enable_reg  : in    std_logic_vector(8 downto 1) := (others => 'U');
          pwm_posedge_reg : in    std_logic_vector(128 downto 1) := (others => 'U');
          pwm_negedge_reg : in    std_logic_vector(128 downto 1) := (others => 'U');
          period_cnt      : in    std_logic_vector(15 downto 0) := (others => 'U');
          PWM_c           : out   std_logic_vector(7 downto 0);
          sync_pulse_1    : in    std_logic := 'U';
          CCC_0_GL1       : in    std_logic := 'U';
          MSS_READY       : in    std_logic := 'U'
        );
  end component;

  component corepwm_reg_if
    port( PRDATA_regif_0_iv_0_0              : out   std_logic_vector(15 downto 8);
          PRDATA_regif_iv_0_0                : out   std_logic_vector(7 downto 4);
          CoreAPB3_0_APBmslave0_PADDR        : in    std_logic_vector(7 downto 2) := (others => 'U');
          period_cnt                         : in    std_logic_vector(15 downto 0) := (others => 'U');
          period_reg                         : out   std_logic_vector(15 downto 0);
          prescale_reg                       : out   std_logic_vector(15 downto 0);
          pwm_posedge_reg                    : out   std_logic_vector(128 downto 1);
          pwm_enable_reg                     : out   std_logic_vector(8 downto 1);
          pwm_negedge_reg                    : out   std_logic_vector(128 downto 1);
          CoreAPB3_0_APBmslave0_PWDATA       : in    std_logic_vector(15 downto 0) := (others => 'U');
          PRDATA_generated_6_0_0             : out   std_logic;
          PRDATA_generated_15_0_0_wmux_0_Y_3 : out   std_logic;
          PRDATA_generated_15_0_0_wmux_0_Y_0 : out   std_logic;
          PRDATA_generated_15_2_0_wmux_0_Y_3 : out   std_logic;
          PRDATA_generated_15_2_0_wmux_0_Y_0 : out   std_logic;
          N_166                              : out   std_logic;
          N_62                               : out   std_logic;
          un9_psel                           : out   std_logic;
          un7_psel                           : out   std_logic;
          un11_psel                          : out   std_logic;
          N_60                               : out   std_logic;
          sync_pulse_1                       : in    std_logic := 'U';
          N_174                              : out   std_logic;
          N_962                              : out   std_logic;
          N_959                              : out   std_logic;
          N_960                              : out   std_logic;
          N_966                              : out   std_logic;
          N_963                              : out   std_logic;
          N_964                              : out   std_logic;
          N_961                              : out   std_logic;
          N_965                              : out   std_logic;
          N_936                              : out   std_logic;
          N_940                              : out   std_logic;
          N_941                              : out   std_logic;
          N_939                              : out   std_logic;
          N_942                              : out   std_logic;
          N_937                              : out   std_logic;
          CoreAPB3_0_APBmslave0_PENABLE      : in    std_logic := 'U';
          CoreAPB3_0_APBmslave0_PSELx        : in    std_logic := 'U';
          CoreAPB3_0_APBmslave0_PWRITE       : in    std_logic := 'U';
          N_781                              : out   std_logic;
          N_779                              : out   std_logic;
          N_780                              : out   std_logic;
          N_732                              : out   std_logic;
          N_731                              : out   std_logic;
          N_730                              : out   std_logic;
          N_782                              : out   std_logic;
          N_777                              : out   std_logic;
          N_10_1                             : out   std_logic;
          N_729                              : out   std_logic;
          N_733                              : out   std_logic;
          N_776                              : out   std_logic;
          N_734                              : out   std_logic;
          N_728                              : out   std_logic;
          sync_update                        : out   std_logic;
          FAB_CCC_GL0                        : in    std_logic := 'U';
          MSS_READY                          : in    std_logic := 'U'
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component corepwm_timebase
    port( period_reg   : in    std_logic_vector(15 downto 0) := (others => 'U');
          prescale_reg : in    std_logic_vector(15 downto 0) := (others => 'U');
          period_cnt   : out   std_logic_vector(15 downto 0);
          sync_pulse_1 : out   std_logic;
          CCC_0_GL1    : in    std_logic := 'U';
          MSS_READY    : in    std_logic := 'U'
        );
  end component;

    signal VCC_net_1, \PWM_STRETCH_0_sqmuxa\, GND_net_1, 
        \PWM_STRETCH_0_sqmuxa_3\, N_174, \period_cnt[0]\, 
        \period_cnt[1]\, \period_cnt[2]\, \period_cnt[3]\, 
        \period_cnt[4]\, \period_cnt[5]\, \period_cnt[6]\, 
        \period_cnt[7]\, \period_cnt[8]\, \period_cnt[9]\, 
        \period_cnt[10]\, \period_cnt[11]\, \period_cnt[12]\, 
        \period_cnt[13]\, \period_cnt[14]\, \period_cnt[15]\, 
        \period_reg[0]\, \period_reg[1]\, \period_reg[2]\, 
        \period_reg[3]\, \period_reg[4]\, \period_reg[5]\, 
        \period_reg[6]\, \period_reg[7]\, \period_reg[8]\, 
        \period_reg[9]\, \period_reg[10]\, \period_reg[11]\, 
        \period_reg[12]\, \period_reg[13]\, \period_reg[14]\, 
        \period_reg[15]\, \prescale_reg[0]\, \prescale_reg[1]\, 
        \prescale_reg[2]\, \prescale_reg[3]\, \prescale_reg[4]\, 
        \prescale_reg[5]\, \prescale_reg[6]\, \prescale_reg[7]\, 
        \prescale_reg[8]\, \prescale_reg[9]\, \prescale_reg[10]\, 
        \prescale_reg[11]\, \prescale_reg[12]\, 
        \prescale_reg[13]\, \prescale_reg[14]\, 
        \prescale_reg[15]\, \pwm_posedge_reg_0\, 
        \pwm_posedge_reg[2]\, \pwm_posedge_reg[3]\, 
        \pwm_posedge_reg[4]\, \pwm_posedge_reg[5]\, 
        \pwm_posedge_reg[6]\, \pwm_posedge_reg[7]\, 
        \pwm_posedge_reg[8]\, \pwm_posedge_reg[9]\, 
        \pwm_posedge_reg[10]\, \pwm_posedge_reg[11]\, 
        \pwm_posedge_reg[12]\, \pwm_posedge_reg[13]\, 
        \pwm_posedge_reg[14]\, \pwm_posedge_reg[15]\, 
        \pwm_posedge_reg[16]\, \pwm_posedge_reg_16\, 
        \pwm_posedge_reg[18]\, \pwm_posedge_reg[19]\, 
        \pwm_posedge_reg[20]\, \pwm_posedge_reg[21]\, 
        \pwm_posedge_reg[22]\, \pwm_posedge_reg[23]\, 
        \pwm_posedge_reg[24]\, \pwm_posedge_reg[25]\, 
        \pwm_posedge_reg[26]\, \pwm_posedge_reg[27]\, 
        \pwm_posedge_reg[28]\, \pwm_posedge_reg[29]\, 
        \pwm_posedge_reg[30]\, \pwm_posedge_reg[31]\, 
        \pwm_posedge_reg[32]\, \pwm_posedge_reg[33]\, 
        \pwm_posedge_reg[34]\, \pwm_posedge_reg[35]\, 
        \pwm_posedge_reg[36]\, \pwm_posedge_reg[37]\, 
        \pwm_posedge_reg[38]\, \pwm_posedge_reg[39]\, 
        \pwm_posedge_reg[40]\, \pwm_posedge_reg[41]\, 
        \pwm_posedge_reg[42]\, \pwm_posedge_reg[43]\, 
        \pwm_posedge_reg[44]\, \pwm_posedge_reg[45]\, 
        \pwm_posedge_reg[46]\, \pwm_posedge_reg[47]\, 
        \pwm_posedge_reg[48]\, \pwm_posedge_reg[49]\, 
        \pwm_posedge_reg[50]\, \pwm_posedge_reg[51]\, 
        \pwm_posedge_reg[52]\, \pwm_posedge_reg[53]\, 
        \pwm_posedge_reg[54]\, \pwm_posedge_reg[55]\, 
        \pwm_posedge_reg[56]\, \pwm_posedge_reg[57]\, 
        \pwm_posedge_reg[58]\, \pwm_posedge_reg[59]\, 
        \pwm_posedge_reg[60]\, \pwm_posedge_reg[61]\, 
        \pwm_posedge_reg[62]\, \pwm_posedge_reg[63]\, 
        \pwm_posedge_reg[64]\, \pwm_posedge_reg[65]\, 
        \pwm_posedge_reg[66]\, \pwm_posedge_reg[67]\, 
        \pwm_posedge_reg[68]\, \pwm_posedge_reg[69]\, 
        \pwm_posedge_reg[70]\, \pwm_posedge_reg[71]\, 
        \pwm_posedge_reg[72]\, \pwm_posedge_reg[73]\, 
        \pwm_posedge_reg[74]\, \pwm_posedge_reg[75]\, 
        \pwm_posedge_reg[76]\, \pwm_posedge_reg[77]\, 
        \pwm_posedge_reg[78]\, \pwm_posedge_reg[79]\, 
        \pwm_posedge_reg[80]\, \pwm_posedge_reg[81]\, 
        \pwm_posedge_reg[82]\, \pwm_posedge_reg[83]\, 
        \pwm_posedge_reg[84]\, \pwm_posedge_reg[85]\, 
        \pwm_posedge_reg[86]\, \pwm_posedge_reg[87]\, 
        \pwm_posedge_reg[88]\, \pwm_posedge_reg[89]\, 
        \pwm_posedge_reg[90]\, \pwm_posedge_reg[91]\, 
        \pwm_posedge_reg[92]\, \pwm_posedge_reg[93]\, 
        \pwm_posedge_reg[94]\, \pwm_posedge_reg[95]\, 
        \pwm_posedge_reg[96]\, \pwm_posedge_reg[97]\, 
        \pwm_posedge_reg[98]\, \pwm_posedge_reg[99]\, 
        \pwm_posedge_reg[100]\, \pwm_posedge_reg[101]\, 
        \pwm_posedge_reg[102]\, \pwm_posedge_reg[103]\, 
        \pwm_posedge_reg[104]\, \pwm_posedge_reg[105]\, 
        \pwm_posedge_reg[106]\, \pwm_posedge_reg[107]\, 
        \pwm_posedge_reg[108]\, \pwm_posedge_reg[109]\, 
        \pwm_posedge_reg[110]\, \pwm_posedge_reg[111]\, 
        \pwm_posedge_reg[112]\, \pwm_posedge_reg[113]\, 
        \pwm_posedge_reg[114]\, \pwm_posedge_reg[115]\, 
        \pwm_posedge_reg[116]\, \pwm_posedge_reg[117]\, 
        \pwm_posedge_reg[118]\, \pwm_posedge_reg[119]\, 
        \pwm_posedge_reg[120]\, \pwm_posedge_reg[121]\, 
        \pwm_posedge_reg[122]\, \pwm_posedge_reg[123]\, 
        \pwm_posedge_reg[124]\, \pwm_posedge_reg[125]\, 
        \pwm_posedge_reg[126]\, \pwm_posedge_reg[127]\, 
        \pwm_posedge_reg[128]\, \pwm_enable_reg[1]\, 
        \pwm_enable_reg[2]\, \pwm_enable_reg[3]\, 
        \pwm_enable_reg[4]\, \pwm_enable_reg[5]\, 
        \pwm_enable_reg[6]\, \pwm_enable_reg[7]\, 
        \pwm_enable_reg[8]\, \pwm_negedge_reg_0\, 
        \pwm_negedge_reg[2]\, \pwm_negedge_reg[3]\, 
        \pwm_negedge_reg[4]\, \pwm_negedge_reg[5]\, 
        \pwm_negedge_reg[6]\, \pwm_negedge_reg[7]\, 
        \pwm_negedge_reg[8]\, \pwm_negedge_reg[9]\, 
        \pwm_negedge_reg[10]\, \pwm_negedge_reg[11]\, 
        \pwm_negedge_reg[12]\, \pwm_negedge_reg[13]\, 
        \pwm_negedge_reg[14]\, \pwm_negedge_reg[15]\, 
        \pwm_negedge_reg[16]\, \pwm_negedge_reg_16\, 
        \pwm_negedge_reg[18]\, \pwm_negedge_reg[19]\, 
        \pwm_negedge_reg[20]\, \pwm_negedge_reg[21]\, 
        \pwm_negedge_reg[22]\, \pwm_negedge_reg[23]\, 
        \pwm_negedge_reg[24]\, \pwm_negedge_reg[25]\, 
        \pwm_negedge_reg[26]\, \pwm_negedge_reg[27]\, 
        \pwm_negedge_reg[28]\, \pwm_negedge_reg[29]\, 
        \pwm_negedge_reg[30]\, \pwm_negedge_reg[31]\, 
        \pwm_negedge_reg[32]\, \pwm_negedge_reg[33]\, 
        \pwm_negedge_reg[34]\, \pwm_negedge_reg[35]\, 
        \pwm_negedge_reg[36]\, \pwm_negedge_reg[37]\, 
        \pwm_negedge_reg[38]\, \pwm_negedge_reg[39]\, 
        \pwm_negedge_reg[40]\, \pwm_negedge_reg[41]\, 
        \pwm_negedge_reg[42]\, \pwm_negedge_reg[43]\, 
        \pwm_negedge_reg[44]\, \pwm_negedge_reg[45]\, 
        \pwm_negedge_reg[46]\, \pwm_negedge_reg[47]\, 
        \pwm_negedge_reg[48]\, \pwm_negedge_reg[49]\, 
        \pwm_negedge_reg[50]\, \pwm_negedge_reg[51]\, 
        \pwm_negedge_reg[52]\, \pwm_negedge_reg[53]\, 
        \pwm_negedge_reg[54]\, \pwm_negedge_reg[55]\, 
        \pwm_negedge_reg[56]\, \pwm_negedge_reg[57]\, 
        \pwm_negedge_reg[58]\, \pwm_negedge_reg[59]\, 
        \pwm_negedge_reg[60]\, \pwm_negedge_reg[61]\, 
        \pwm_negedge_reg[62]\, \pwm_negedge_reg[63]\, 
        \pwm_negedge_reg[64]\, \pwm_negedge_reg[65]\, 
        \pwm_negedge_reg[66]\, \pwm_negedge_reg[67]\, 
        \pwm_negedge_reg[68]\, \pwm_negedge_reg[69]\, 
        \pwm_negedge_reg[70]\, \pwm_negedge_reg[71]\, 
        \pwm_negedge_reg[72]\, \pwm_negedge_reg[73]\, 
        \pwm_negedge_reg[74]\, \pwm_negedge_reg[75]\, 
        \pwm_negedge_reg[76]\, \pwm_negedge_reg[77]\, 
        \pwm_negedge_reg[78]\, \pwm_negedge_reg[79]\, 
        \pwm_negedge_reg[80]\, \pwm_negedge_reg[81]\, 
        \pwm_negedge_reg[82]\, \pwm_negedge_reg[83]\, 
        \pwm_negedge_reg[84]\, \pwm_negedge_reg[85]\, 
        \pwm_negedge_reg[86]\, \pwm_negedge_reg[87]\, 
        \pwm_negedge_reg[88]\, \pwm_negedge_reg[89]\, 
        \pwm_negedge_reg[90]\, \pwm_negedge_reg[91]\, 
        \pwm_negedge_reg[92]\, \pwm_negedge_reg[93]\, 
        \pwm_negedge_reg[94]\, \pwm_negedge_reg[95]\, 
        \pwm_negedge_reg[96]\, \pwm_negedge_reg[97]\, 
        \pwm_negedge_reg[98]\, \pwm_negedge_reg[99]\, 
        \pwm_negedge_reg_99\, \pwm_negedge_reg[101]\, 
        \pwm_negedge_reg[102]\, \pwm_negedge_reg[103]\, 
        \pwm_negedge_reg[104]\, \pwm_negedge_reg[105]\, 
        \pwm_negedge_reg[106]\, \pwm_negedge_reg[107]\, 
        \pwm_negedge_reg[108]\, \pwm_negedge_reg[109]\, 
        \pwm_negedge_reg[110]\, \pwm_negedge_reg[111]\, 
        \pwm_negedge_reg[112]\, \pwm_negedge_reg[113]\, 
        \pwm_negedge_reg[114]\, \pwm_negedge_reg[115]\, 
        \pwm_negedge_reg_115\, \pwm_negedge_reg[117]\, 
        \pwm_negedge_reg[118]\, \pwm_negedge_reg[119]\, 
        \pwm_negedge_reg[120]\, \pwm_negedge_reg[121]\, 
        \pwm_negedge_reg[122]\, \pwm_negedge_reg[123]\, 
        \pwm_negedge_reg[124]\, \pwm_negedge_reg[125]\, 
        \pwm_negedge_reg[126]\, \pwm_negedge_reg[127]\, 
        \pwm_negedge_reg[128]\, sync_pulse_1 : std_logic;

    for all : corepwm_pwm_gen
	Use entity work.corepwm_pwm_gen(DEF_ARCH);
    for all : corepwm_reg_if
	Use entity work.corepwm_reg_if(DEF_ARCH);
    for all : corepwm_timebase
	Use entity work.corepwm_timebase(DEF_ARCH);
begin 

    pwm_enable_reg(4) <= \pwm_enable_reg[4]\;
    pwm_enable_reg(3) <= \pwm_enable_reg[3]\;
    pwm_enable_reg(2) <= \pwm_enable_reg[2]\;
    pwm_enable_reg(1) <= \pwm_enable_reg[1]\;
    prescale_reg(3) <= \prescale_reg[3]\;
    prescale_reg(2) <= \prescale_reg[2]\;
    prescale_reg(1) <= \prescale_reg[1]\;
    prescale_reg(0) <= \prescale_reg[0]\;
    period_reg(7) <= \period_reg[7]\;
    period_reg(6) <= \period_reg[6]\;
    period_reg(5) <= \period_reg[5]\;
    period_reg(4) <= \period_reg[4]\;
    period_reg(3) <= \period_reg[3]\;
    period_reg(2) <= \period_reg[2]\;
    period_reg(1) <= \period_reg[1]\;
    period_reg(0) <= \period_reg[0]\;
    pwm_negedge_reg_0 <= \pwm_negedge_reg_0\;
    pwm_negedge_reg_16 <= \pwm_negedge_reg_16\;
    pwm_negedge_reg_99 <= \pwm_negedge_reg_99\;
    pwm_negedge_reg_115 <= \pwm_negedge_reg_115\;
    pwm_posedge_reg_0 <= \pwm_posedge_reg_0\;
    pwm_posedge_reg_16 <= \pwm_posedge_reg_16\;

    \PWM_STRETCH[4]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(4), CLK => 
        FAB_CCC_GL0, EN => \PWM_STRETCH_0_sqmuxa\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => PWM_STRETCH(4));
    
    \PWM_STRETCH[1]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(1), CLK => 
        FAB_CCC_GL0, EN => \PWM_STRETCH_0_sqmuxa\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => PWM_STRETCH(1));
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \PWM_STRETCH[5]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(5), CLK => 
        FAB_CCC_GL0, EN => \PWM_STRETCH_0_sqmuxa\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => PWM_STRETCH(5));
    
    \PWM_STRETCH[0]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(0), CLK => 
        FAB_CCC_GL0, EN => \PWM_STRETCH_0_sqmuxa\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => PWM_STRETCH(0));
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \PWM_STRETCH[2]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(2), CLK => 
        FAB_CCC_GL0, EN => \PWM_STRETCH_0_sqmuxa\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => PWM_STRETCH(2));
    
    \xhdl63.pwm_gen_inst\ : corepwm_pwm_gen
      port map(pwm_enable_reg(8) => \pwm_enable_reg[8]\, 
        pwm_enable_reg(7) => \pwm_enable_reg[7]\, 
        pwm_enable_reg(6) => \pwm_enable_reg[6]\, 
        pwm_enable_reg(5) => \pwm_enable_reg[5]\, 
        pwm_enable_reg(4) => \pwm_enable_reg[4]\, 
        pwm_enable_reg(3) => \pwm_enable_reg[3]\, 
        pwm_enable_reg(2) => \pwm_enable_reg[2]\, 
        pwm_enable_reg(1) => \pwm_enable_reg[1]\, 
        pwm_posedge_reg(128) => \pwm_posedge_reg[128]\, 
        pwm_posedge_reg(127) => \pwm_posedge_reg[127]\, 
        pwm_posedge_reg(126) => \pwm_posedge_reg[126]\, 
        pwm_posedge_reg(125) => \pwm_posedge_reg[125]\, 
        pwm_posedge_reg(124) => \pwm_posedge_reg[124]\, 
        pwm_posedge_reg(123) => \pwm_posedge_reg[123]\, 
        pwm_posedge_reg(122) => \pwm_posedge_reg[122]\, 
        pwm_posedge_reg(121) => \pwm_posedge_reg[121]\, 
        pwm_posedge_reg(120) => \pwm_posedge_reg[120]\, 
        pwm_posedge_reg(119) => \pwm_posedge_reg[119]\, 
        pwm_posedge_reg(118) => \pwm_posedge_reg[118]\, 
        pwm_posedge_reg(117) => \pwm_posedge_reg[117]\, 
        pwm_posedge_reg(116) => \pwm_posedge_reg[116]\, 
        pwm_posedge_reg(115) => \pwm_posedge_reg[115]\, 
        pwm_posedge_reg(114) => \pwm_posedge_reg[114]\, 
        pwm_posedge_reg(113) => \pwm_posedge_reg[113]\, 
        pwm_posedge_reg(112) => \pwm_posedge_reg[112]\, 
        pwm_posedge_reg(111) => \pwm_posedge_reg[111]\, 
        pwm_posedge_reg(110) => \pwm_posedge_reg[110]\, 
        pwm_posedge_reg(109) => \pwm_posedge_reg[109]\, 
        pwm_posedge_reg(108) => \pwm_posedge_reg[108]\, 
        pwm_posedge_reg(107) => \pwm_posedge_reg[107]\, 
        pwm_posedge_reg(106) => \pwm_posedge_reg[106]\, 
        pwm_posedge_reg(105) => \pwm_posedge_reg[105]\, 
        pwm_posedge_reg(104) => \pwm_posedge_reg[104]\, 
        pwm_posedge_reg(103) => \pwm_posedge_reg[103]\, 
        pwm_posedge_reg(102) => \pwm_posedge_reg[102]\, 
        pwm_posedge_reg(101) => \pwm_posedge_reg[101]\, 
        pwm_posedge_reg(100) => \pwm_posedge_reg[100]\, 
        pwm_posedge_reg(99) => \pwm_posedge_reg[99]\, 
        pwm_posedge_reg(98) => \pwm_posedge_reg[98]\, 
        pwm_posedge_reg(97) => \pwm_posedge_reg[97]\, 
        pwm_posedge_reg(96) => \pwm_posedge_reg[96]\, 
        pwm_posedge_reg(95) => \pwm_posedge_reg[95]\, 
        pwm_posedge_reg(94) => \pwm_posedge_reg[94]\, 
        pwm_posedge_reg(93) => \pwm_posedge_reg[93]\, 
        pwm_posedge_reg(92) => \pwm_posedge_reg[92]\, 
        pwm_posedge_reg(91) => \pwm_posedge_reg[91]\, 
        pwm_posedge_reg(90) => \pwm_posedge_reg[90]\, 
        pwm_posedge_reg(89) => \pwm_posedge_reg[89]\, 
        pwm_posedge_reg(88) => \pwm_posedge_reg[88]\, 
        pwm_posedge_reg(87) => \pwm_posedge_reg[87]\, 
        pwm_posedge_reg(86) => \pwm_posedge_reg[86]\, 
        pwm_posedge_reg(85) => \pwm_posedge_reg[85]\, 
        pwm_posedge_reg(84) => \pwm_posedge_reg[84]\, 
        pwm_posedge_reg(83) => \pwm_posedge_reg[83]\, 
        pwm_posedge_reg(82) => \pwm_posedge_reg[82]\, 
        pwm_posedge_reg(81) => \pwm_posedge_reg[81]\, 
        pwm_posedge_reg(80) => \pwm_posedge_reg[80]\, 
        pwm_posedge_reg(79) => \pwm_posedge_reg[79]\, 
        pwm_posedge_reg(78) => \pwm_posedge_reg[78]\, 
        pwm_posedge_reg(77) => \pwm_posedge_reg[77]\, 
        pwm_posedge_reg(76) => \pwm_posedge_reg[76]\, 
        pwm_posedge_reg(75) => \pwm_posedge_reg[75]\, 
        pwm_posedge_reg(74) => \pwm_posedge_reg[74]\, 
        pwm_posedge_reg(73) => \pwm_posedge_reg[73]\, 
        pwm_posedge_reg(72) => \pwm_posedge_reg[72]\, 
        pwm_posedge_reg(71) => \pwm_posedge_reg[71]\, 
        pwm_posedge_reg(70) => \pwm_posedge_reg[70]\, 
        pwm_posedge_reg(69) => \pwm_posedge_reg[69]\, 
        pwm_posedge_reg(68) => \pwm_posedge_reg[68]\, 
        pwm_posedge_reg(67) => \pwm_posedge_reg[67]\, 
        pwm_posedge_reg(66) => \pwm_posedge_reg[66]\, 
        pwm_posedge_reg(65) => \pwm_posedge_reg[65]\, 
        pwm_posedge_reg(64) => \pwm_posedge_reg[64]\, 
        pwm_posedge_reg(63) => \pwm_posedge_reg[63]\, 
        pwm_posedge_reg(62) => \pwm_posedge_reg[62]\, 
        pwm_posedge_reg(61) => \pwm_posedge_reg[61]\, 
        pwm_posedge_reg(60) => \pwm_posedge_reg[60]\, 
        pwm_posedge_reg(59) => \pwm_posedge_reg[59]\, 
        pwm_posedge_reg(58) => \pwm_posedge_reg[58]\, 
        pwm_posedge_reg(57) => \pwm_posedge_reg[57]\, 
        pwm_posedge_reg(56) => \pwm_posedge_reg[56]\, 
        pwm_posedge_reg(55) => \pwm_posedge_reg[55]\, 
        pwm_posedge_reg(54) => \pwm_posedge_reg[54]\, 
        pwm_posedge_reg(53) => \pwm_posedge_reg[53]\, 
        pwm_posedge_reg(52) => \pwm_posedge_reg[52]\, 
        pwm_posedge_reg(51) => \pwm_posedge_reg[51]\, 
        pwm_posedge_reg(50) => \pwm_posedge_reg[50]\, 
        pwm_posedge_reg(49) => \pwm_posedge_reg[49]\, 
        pwm_posedge_reg(48) => \pwm_posedge_reg[48]\, 
        pwm_posedge_reg(47) => \pwm_posedge_reg[47]\, 
        pwm_posedge_reg(46) => \pwm_posedge_reg[46]\, 
        pwm_posedge_reg(45) => \pwm_posedge_reg[45]\, 
        pwm_posedge_reg(44) => \pwm_posedge_reg[44]\, 
        pwm_posedge_reg(43) => \pwm_posedge_reg[43]\, 
        pwm_posedge_reg(42) => \pwm_posedge_reg[42]\, 
        pwm_posedge_reg(41) => \pwm_posedge_reg[41]\, 
        pwm_posedge_reg(40) => \pwm_posedge_reg[40]\, 
        pwm_posedge_reg(39) => \pwm_posedge_reg[39]\, 
        pwm_posedge_reg(38) => \pwm_posedge_reg[38]\, 
        pwm_posedge_reg(37) => \pwm_posedge_reg[37]\, 
        pwm_posedge_reg(36) => \pwm_posedge_reg[36]\, 
        pwm_posedge_reg(35) => \pwm_posedge_reg[35]\, 
        pwm_posedge_reg(34) => \pwm_posedge_reg[34]\, 
        pwm_posedge_reg(33) => \pwm_posedge_reg[33]\, 
        pwm_posedge_reg(32) => \pwm_posedge_reg[32]\, 
        pwm_posedge_reg(31) => \pwm_posedge_reg[31]\, 
        pwm_posedge_reg(30) => \pwm_posedge_reg[30]\, 
        pwm_posedge_reg(29) => \pwm_posedge_reg[29]\, 
        pwm_posedge_reg(28) => \pwm_posedge_reg[28]\, 
        pwm_posedge_reg(27) => \pwm_posedge_reg[27]\, 
        pwm_posedge_reg(26) => \pwm_posedge_reg[26]\, 
        pwm_posedge_reg(25) => \pwm_posedge_reg[25]\, 
        pwm_posedge_reg(24) => \pwm_posedge_reg[24]\, 
        pwm_posedge_reg(23) => \pwm_posedge_reg[23]\, 
        pwm_posedge_reg(22) => \pwm_posedge_reg[22]\, 
        pwm_posedge_reg(21) => \pwm_posedge_reg[21]\, 
        pwm_posedge_reg(20) => \pwm_posedge_reg[20]\, 
        pwm_posedge_reg(19) => \pwm_posedge_reg[19]\, 
        pwm_posedge_reg(18) => \pwm_posedge_reg[18]\, 
        pwm_posedge_reg(17) => \pwm_posedge_reg_16\, 
        pwm_posedge_reg(16) => \pwm_posedge_reg[16]\, 
        pwm_posedge_reg(15) => \pwm_posedge_reg[15]\, 
        pwm_posedge_reg(14) => \pwm_posedge_reg[14]\, 
        pwm_posedge_reg(13) => \pwm_posedge_reg[13]\, 
        pwm_posedge_reg(12) => \pwm_posedge_reg[12]\, 
        pwm_posedge_reg(11) => \pwm_posedge_reg[11]\, 
        pwm_posedge_reg(10) => \pwm_posedge_reg[10]\, 
        pwm_posedge_reg(9) => \pwm_posedge_reg[9]\, 
        pwm_posedge_reg(8) => \pwm_posedge_reg[8]\, 
        pwm_posedge_reg(7) => \pwm_posedge_reg[7]\, 
        pwm_posedge_reg(6) => \pwm_posedge_reg[6]\, 
        pwm_posedge_reg(5) => \pwm_posedge_reg[5]\, 
        pwm_posedge_reg(4) => \pwm_posedge_reg[4]\, 
        pwm_posedge_reg(3) => \pwm_posedge_reg[3]\, 
        pwm_posedge_reg(2) => \pwm_posedge_reg[2]\, 
        pwm_posedge_reg(1) => \pwm_posedge_reg_0\, 
        pwm_negedge_reg(128) => \pwm_negedge_reg[128]\, 
        pwm_negedge_reg(127) => \pwm_negedge_reg[127]\, 
        pwm_negedge_reg(126) => \pwm_negedge_reg[126]\, 
        pwm_negedge_reg(125) => \pwm_negedge_reg[125]\, 
        pwm_negedge_reg(124) => \pwm_negedge_reg[124]\, 
        pwm_negedge_reg(123) => \pwm_negedge_reg[123]\, 
        pwm_negedge_reg(122) => \pwm_negedge_reg[122]\, 
        pwm_negedge_reg(121) => \pwm_negedge_reg[121]\, 
        pwm_negedge_reg(120) => \pwm_negedge_reg[120]\, 
        pwm_negedge_reg(119) => \pwm_negedge_reg[119]\, 
        pwm_negedge_reg(118) => \pwm_negedge_reg[118]\, 
        pwm_negedge_reg(117) => \pwm_negedge_reg[117]\, 
        pwm_negedge_reg(116) => \pwm_negedge_reg_115\, 
        pwm_negedge_reg(115) => \pwm_negedge_reg[115]\, 
        pwm_negedge_reg(114) => \pwm_negedge_reg[114]\, 
        pwm_negedge_reg(113) => \pwm_negedge_reg[113]\, 
        pwm_negedge_reg(112) => \pwm_negedge_reg[112]\, 
        pwm_negedge_reg(111) => \pwm_negedge_reg[111]\, 
        pwm_negedge_reg(110) => \pwm_negedge_reg[110]\, 
        pwm_negedge_reg(109) => \pwm_negedge_reg[109]\, 
        pwm_negedge_reg(108) => \pwm_negedge_reg[108]\, 
        pwm_negedge_reg(107) => \pwm_negedge_reg[107]\, 
        pwm_negedge_reg(106) => \pwm_negedge_reg[106]\, 
        pwm_negedge_reg(105) => \pwm_negedge_reg[105]\, 
        pwm_negedge_reg(104) => \pwm_negedge_reg[104]\, 
        pwm_negedge_reg(103) => \pwm_negedge_reg[103]\, 
        pwm_negedge_reg(102) => \pwm_negedge_reg[102]\, 
        pwm_negedge_reg(101) => \pwm_negedge_reg[101]\, 
        pwm_negedge_reg(100) => \pwm_negedge_reg_99\, 
        pwm_negedge_reg(99) => \pwm_negedge_reg[99]\, 
        pwm_negedge_reg(98) => \pwm_negedge_reg[98]\, 
        pwm_negedge_reg(97) => \pwm_negedge_reg[97]\, 
        pwm_negedge_reg(96) => \pwm_negedge_reg[96]\, 
        pwm_negedge_reg(95) => \pwm_negedge_reg[95]\, 
        pwm_negedge_reg(94) => \pwm_negedge_reg[94]\, 
        pwm_negedge_reg(93) => \pwm_negedge_reg[93]\, 
        pwm_negedge_reg(92) => \pwm_negedge_reg[92]\, 
        pwm_negedge_reg(91) => \pwm_negedge_reg[91]\, 
        pwm_negedge_reg(90) => \pwm_negedge_reg[90]\, 
        pwm_negedge_reg(89) => \pwm_negedge_reg[89]\, 
        pwm_negedge_reg(88) => \pwm_negedge_reg[88]\, 
        pwm_negedge_reg(87) => \pwm_negedge_reg[87]\, 
        pwm_negedge_reg(86) => \pwm_negedge_reg[86]\, 
        pwm_negedge_reg(85) => \pwm_negedge_reg[85]\, 
        pwm_negedge_reg(84) => \pwm_negedge_reg[84]\, 
        pwm_negedge_reg(83) => \pwm_negedge_reg[83]\, 
        pwm_negedge_reg(82) => \pwm_negedge_reg[82]\, 
        pwm_negedge_reg(81) => \pwm_negedge_reg[81]\, 
        pwm_negedge_reg(80) => \pwm_negedge_reg[80]\, 
        pwm_negedge_reg(79) => \pwm_negedge_reg[79]\, 
        pwm_negedge_reg(78) => \pwm_negedge_reg[78]\, 
        pwm_negedge_reg(77) => \pwm_negedge_reg[77]\, 
        pwm_negedge_reg(76) => \pwm_negedge_reg[76]\, 
        pwm_negedge_reg(75) => \pwm_negedge_reg[75]\, 
        pwm_negedge_reg(74) => \pwm_negedge_reg[74]\, 
        pwm_negedge_reg(73) => \pwm_negedge_reg[73]\, 
        pwm_negedge_reg(72) => \pwm_negedge_reg[72]\, 
        pwm_negedge_reg(71) => \pwm_negedge_reg[71]\, 
        pwm_negedge_reg(70) => \pwm_negedge_reg[70]\, 
        pwm_negedge_reg(69) => \pwm_negedge_reg[69]\, 
        pwm_negedge_reg(68) => \pwm_negedge_reg[68]\, 
        pwm_negedge_reg(67) => \pwm_negedge_reg[67]\, 
        pwm_negedge_reg(66) => \pwm_negedge_reg[66]\, 
        pwm_negedge_reg(65) => \pwm_negedge_reg[65]\, 
        pwm_negedge_reg(64) => \pwm_negedge_reg[64]\, 
        pwm_negedge_reg(63) => \pwm_negedge_reg[63]\, 
        pwm_negedge_reg(62) => \pwm_negedge_reg[62]\, 
        pwm_negedge_reg(61) => \pwm_negedge_reg[61]\, 
        pwm_negedge_reg(60) => \pwm_negedge_reg[60]\, 
        pwm_negedge_reg(59) => \pwm_negedge_reg[59]\, 
        pwm_negedge_reg(58) => \pwm_negedge_reg[58]\, 
        pwm_negedge_reg(57) => \pwm_negedge_reg[57]\, 
        pwm_negedge_reg(56) => \pwm_negedge_reg[56]\, 
        pwm_negedge_reg(55) => \pwm_negedge_reg[55]\, 
        pwm_negedge_reg(54) => \pwm_negedge_reg[54]\, 
        pwm_negedge_reg(53) => \pwm_negedge_reg[53]\, 
        pwm_negedge_reg(52) => \pwm_negedge_reg[52]\, 
        pwm_negedge_reg(51) => \pwm_negedge_reg[51]\, 
        pwm_negedge_reg(50) => \pwm_negedge_reg[50]\, 
        pwm_negedge_reg(49) => \pwm_negedge_reg[49]\, 
        pwm_negedge_reg(48) => \pwm_negedge_reg[48]\, 
        pwm_negedge_reg(47) => \pwm_negedge_reg[47]\, 
        pwm_negedge_reg(46) => \pwm_negedge_reg[46]\, 
        pwm_negedge_reg(45) => \pwm_negedge_reg[45]\, 
        pwm_negedge_reg(44) => \pwm_negedge_reg[44]\, 
        pwm_negedge_reg(43) => \pwm_negedge_reg[43]\, 
        pwm_negedge_reg(42) => \pwm_negedge_reg[42]\, 
        pwm_negedge_reg(41) => \pwm_negedge_reg[41]\, 
        pwm_negedge_reg(40) => \pwm_negedge_reg[40]\, 
        pwm_negedge_reg(39) => \pwm_negedge_reg[39]\, 
        pwm_negedge_reg(38) => \pwm_negedge_reg[38]\, 
        pwm_negedge_reg(37) => \pwm_negedge_reg[37]\, 
        pwm_negedge_reg(36) => \pwm_negedge_reg[36]\, 
        pwm_negedge_reg(35) => \pwm_negedge_reg[35]\, 
        pwm_negedge_reg(34) => \pwm_negedge_reg[34]\, 
        pwm_negedge_reg(33) => \pwm_negedge_reg[33]\, 
        pwm_negedge_reg(32) => \pwm_negedge_reg[32]\, 
        pwm_negedge_reg(31) => \pwm_negedge_reg[31]\, 
        pwm_negedge_reg(30) => \pwm_negedge_reg[30]\, 
        pwm_negedge_reg(29) => \pwm_negedge_reg[29]\, 
        pwm_negedge_reg(28) => \pwm_negedge_reg[28]\, 
        pwm_negedge_reg(27) => \pwm_negedge_reg[27]\, 
        pwm_negedge_reg(26) => \pwm_negedge_reg[26]\, 
        pwm_negedge_reg(25) => \pwm_negedge_reg[25]\, 
        pwm_negedge_reg(24) => \pwm_negedge_reg[24]\, 
        pwm_negedge_reg(23) => \pwm_negedge_reg[23]\, 
        pwm_negedge_reg(22) => \pwm_negedge_reg[22]\, 
        pwm_negedge_reg(21) => \pwm_negedge_reg[21]\, 
        pwm_negedge_reg(20) => \pwm_negedge_reg[20]\, 
        pwm_negedge_reg(19) => \pwm_negedge_reg[19]\, 
        pwm_negedge_reg(18) => \pwm_negedge_reg[18]\, 
        pwm_negedge_reg(17) => \pwm_negedge_reg_16\, 
        pwm_negedge_reg(16) => \pwm_negedge_reg[16]\, 
        pwm_negedge_reg(15) => \pwm_negedge_reg[15]\, 
        pwm_negedge_reg(14) => \pwm_negedge_reg[14]\, 
        pwm_negedge_reg(13) => \pwm_negedge_reg[13]\, 
        pwm_negedge_reg(12) => \pwm_negedge_reg[12]\, 
        pwm_negedge_reg(11) => \pwm_negedge_reg[11]\, 
        pwm_negedge_reg(10) => \pwm_negedge_reg[10]\, 
        pwm_negedge_reg(9) => \pwm_negedge_reg[9]\, 
        pwm_negedge_reg(8) => \pwm_negedge_reg[8]\, 
        pwm_negedge_reg(7) => \pwm_negedge_reg[7]\, 
        pwm_negedge_reg(6) => \pwm_negedge_reg[6]\, 
        pwm_negedge_reg(5) => \pwm_negedge_reg[5]\, 
        pwm_negedge_reg(4) => \pwm_negedge_reg[4]\, 
        pwm_negedge_reg(3) => \pwm_negedge_reg[3]\, 
        pwm_negedge_reg(2) => \pwm_negedge_reg[2]\, 
        pwm_negedge_reg(1) => \pwm_negedge_reg_0\, period_cnt(15)
         => \period_cnt[15]\, period_cnt(14) => \period_cnt[14]\, 
        period_cnt(13) => \period_cnt[13]\, period_cnt(12) => 
        \period_cnt[12]\, period_cnt(11) => \period_cnt[11]\, 
        period_cnt(10) => \period_cnt[10]\, period_cnt(9) => 
        \period_cnt[9]\, period_cnt(8) => \period_cnt[8]\, 
        period_cnt(7) => \period_cnt[7]\, period_cnt(6) => 
        \period_cnt[6]\, period_cnt(5) => \period_cnt[5]\, 
        period_cnt(4) => \period_cnt[4]\, period_cnt(3) => 
        \period_cnt[3]\, period_cnt(2) => \period_cnt[2]\, 
        period_cnt(1) => \period_cnt[1]\, period_cnt(0) => 
        \period_cnt[0]\, PWM_c(7) => PWM_c(7), PWM_c(6) => 
        PWM_c(6), PWM_c(5) => PWM_c(5), PWM_c(4) => PWM_c(4), 
        PWM_c(3) => PWM_c(3), PWM_c(2) => PWM_c(2), PWM_c(1) => 
        PWM_c(1), PWM_c(0) => PWM_c(0), sync_pulse_1 => 
        sync_pulse_1, CCC_0_GL1 => CCC_0_GL1, MSS_READY => 
        MSS_READY);
    
    \xhdl58.reg_if_inst\ : corepwm_reg_if
      port map(PRDATA_regif_0_iv_0_0(15) => 
        PRDATA_regif_0_iv_0_0(15), PRDATA_regif_0_iv_0_0(14) => 
        PRDATA_regif_0_iv_0_0(14), PRDATA_regif_0_iv_0_0(13) => 
        PRDATA_regif_0_iv_0_0(13), PRDATA_regif_0_iv_0_0(12) => 
        PRDATA_regif_0_iv_0_0(12), PRDATA_regif_0_iv_0_0(11) => 
        PRDATA_regif_0_iv_0_0(11), PRDATA_regif_0_iv_0_0(10) => 
        PRDATA_regif_0_iv_0_0(10), PRDATA_regif_0_iv_0_0(9) => 
        PRDATA_regif_0_iv_0_0(9), PRDATA_regif_0_iv_0_0(8) => 
        PRDATA_regif_0_iv_0_0(8), PRDATA_regif_iv_0_0(7) => 
        PRDATA_regif_iv_0_0(7), PRDATA_regif_iv_0_0(6) => 
        PRDATA_regif_iv_0_0(6), PRDATA_regif_iv_0_0(5) => 
        PRDATA_regif_iv_0_0(5), PRDATA_regif_iv_0_0(4) => 
        PRDATA_regif_iv_0_0(4), CoreAPB3_0_APBmslave0_PADDR(7)
         => CoreAPB3_0_APBmslave0_PADDR(7), 
        CoreAPB3_0_APBmslave0_PADDR(6) => 
        CoreAPB3_0_APBmslave0_PADDR(6), 
        CoreAPB3_0_APBmslave0_PADDR(5) => 
        CoreAPB3_0_APBmslave0_PADDR(5), 
        CoreAPB3_0_APBmslave0_PADDR(4) => 
        CoreAPB3_0_APBmslave0_PADDR(4), 
        CoreAPB3_0_APBmslave0_PADDR(3) => 
        CoreAPB3_0_APBmslave0_PADDR(3), 
        CoreAPB3_0_APBmslave0_PADDR(2) => 
        CoreAPB3_0_APBmslave0_PADDR(2), period_cnt(15) => 
        \period_cnt[15]\, period_cnt(14) => \period_cnt[14]\, 
        period_cnt(13) => \period_cnt[13]\, period_cnt(12) => 
        \period_cnt[12]\, period_cnt(11) => \period_cnt[11]\, 
        period_cnt(10) => \period_cnt[10]\, period_cnt(9) => 
        \period_cnt[9]\, period_cnt(8) => \period_cnt[8]\, 
        period_cnt(7) => \period_cnt[7]\, period_cnt(6) => 
        \period_cnt[6]\, period_cnt(5) => \period_cnt[5]\, 
        period_cnt(4) => \period_cnt[4]\, period_cnt(3) => 
        \period_cnt[3]\, period_cnt(2) => \period_cnt[2]\, 
        period_cnt(1) => \period_cnt[1]\, period_cnt(0) => 
        \period_cnt[0]\, period_reg(15) => \period_reg[15]\, 
        period_reg(14) => \period_reg[14]\, period_reg(13) => 
        \period_reg[13]\, period_reg(12) => \period_reg[12]\, 
        period_reg(11) => \period_reg[11]\, period_reg(10) => 
        \period_reg[10]\, period_reg(9) => \period_reg[9]\, 
        period_reg(8) => \period_reg[8]\, period_reg(7) => 
        \period_reg[7]\, period_reg(6) => \period_reg[6]\, 
        period_reg(5) => \period_reg[5]\, period_reg(4) => 
        \period_reg[4]\, period_reg(3) => \period_reg[3]\, 
        period_reg(2) => \period_reg[2]\, period_reg(1) => 
        \period_reg[1]\, period_reg(0) => \period_reg[0]\, 
        prescale_reg(15) => \prescale_reg[15]\, prescale_reg(14)
         => \prescale_reg[14]\, prescale_reg(13) => 
        \prescale_reg[13]\, prescale_reg(12) => 
        \prescale_reg[12]\, prescale_reg(11) => 
        \prescale_reg[11]\, prescale_reg(10) => 
        \prescale_reg[10]\, prescale_reg(9) => \prescale_reg[9]\, 
        prescale_reg(8) => \prescale_reg[8]\, prescale_reg(7) => 
        \prescale_reg[7]\, prescale_reg(6) => \prescale_reg[6]\, 
        prescale_reg(5) => \prescale_reg[5]\, prescale_reg(4) => 
        \prescale_reg[4]\, prescale_reg(3) => \prescale_reg[3]\, 
        prescale_reg(2) => \prescale_reg[2]\, prescale_reg(1) => 
        \prescale_reg[1]\, prescale_reg(0) => \prescale_reg[0]\, 
        pwm_posedge_reg(128) => \pwm_posedge_reg[128]\, 
        pwm_posedge_reg(127) => \pwm_posedge_reg[127]\, 
        pwm_posedge_reg(126) => \pwm_posedge_reg[126]\, 
        pwm_posedge_reg(125) => \pwm_posedge_reg[125]\, 
        pwm_posedge_reg(124) => \pwm_posedge_reg[124]\, 
        pwm_posedge_reg(123) => \pwm_posedge_reg[123]\, 
        pwm_posedge_reg(122) => \pwm_posedge_reg[122]\, 
        pwm_posedge_reg(121) => \pwm_posedge_reg[121]\, 
        pwm_posedge_reg(120) => \pwm_posedge_reg[120]\, 
        pwm_posedge_reg(119) => \pwm_posedge_reg[119]\, 
        pwm_posedge_reg(118) => \pwm_posedge_reg[118]\, 
        pwm_posedge_reg(117) => \pwm_posedge_reg[117]\, 
        pwm_posedge_reg(116) => \pwm_posedge_reg[116]\, 
        pwm_posedge_reg(115) => \pwm_posedge_reg[115]\, 
        pwm_posedge_reg(114) => \pwm_posedge_reg[114]\, 
        pwm_posedge_reg(113) => \pwm_posedge_reg[113]\, 
        pwm_posedge_reg(112) => \pwm_posedge_reg[112]\, 
        pwm_posedge_reg(111) => \pwm_posedge_reg[111]\, 
        pwm_posedge_reg(110) => \pwm_posedge_reg[110]\, 
        pwm_posedge_reg(109) => \pwm_posedge_reg[109]\, 
        pwm_posedge_reg(108) => \pwm_posedge_reg[108]\, 
        pwm_posedge_reg(107) => \pwm_posedge_reg[107]\, 
        pwm_posedge_reg(106) => \pwm_posedge_reg[106]\, 
        pwm_posedge_reg(105) => \pwm_posedge_reg[105]\, 
        pwm_posedge_reg(104) => \pwm_posedge_reg[104]\, 
        pwm_posedge_reg(103) => \pwm_posedge_reg[103]\, 
        pwm_posedge_reg(102) => \pwm_posedge_reg[102]\, 
        pwm_posedge_reg(101) => \pwm_posedge_reg[101]\, 
        pwm_posedge_reg(100) => \pwm_posedge_reg[100]\, 
        pwm_posedge_reg(99) => \pwm_posedge_reg[99]\, 
        pwm_posedge_reg(98) => \pwm_posedge_reg[98]\, 
        pwm_posedge_reg(97) => \pwm_posedge_reg[97]\, 
        pwm_posedge_reg(96) => \pwm_posedge_reg[96]\, 
        pwm_posedge_reg(95) => \pwm_posedge_reg[95]\, 
        pwm_posedge_reg(94) => \pwm_posedge_reg[94]\, 
        pwm_posedge_reg(93) => \pwm_posedge_reg[93]\, 
        pwm_posedge_reg(92) => \pwm_posedge_reg[92]\, 
        pwm_posedge_reg(91) => \pwm_posedge_reg[91]\, 
        pwm_posedge_reg(90) => \pwm_posedge_reg[90]\, 
        pwm_posedge_reg(89) => \pwm_posedge_reg[89]\, 
        pwm_posedge_reg(88) => \pwm_posedge_reg[88]\, 
        pwm_posedge_reg(87) => \pwm_posedge_reg[87]\, 
        pwm_posedge_reg(86) => \pwm_posedge_reg[86]\, 
        pwm_posedge_reg(85) => \pwm_posedge_reg[85]\, 
        pwm_posedge_reg(84) => \pwm_posedge_reg[84]\, 
        pwm_posedge_reg(83) => \pwm_posedge_reg[83]\, 
        pwm_posedge_reg(82) => \pwm_posedge_reg[82]\, 
        pwm_posedge_reg(81) => \pwm_posedge_reg[81]\, 
        pwm_posedge_reg(80) => \pwm_posedge_reg[80]\, 
        pwm_posedge_reg(79) => \pwm_posedge_reg[79]\, 
        pwm_posedge_reg(78) => \pwm_posedge_reg[78]\, 
        pwm_posedge_reg(77) => \pwm_posedge_reg[77]\, 
        pwm_posedge_reg(76) => \pwm_posedge_reg[76]\, 
        pwm_posedge_reg(75) => \pwm_posedge_reg[75]\, 
        pwm_posedge_reg(74) => \pwm_posedge_reg[74]\, 
        pwm_posedge_reg(73) => \pwm_posedge_reg[73]\, 
        pwm_posedge_reg(72) => \pwm_posedge_reg[72]\, 
        pwm_posedge_reg(71) => \pwm_posedge_reg[71]\, 
        pwm_posedge_reg(70) => \pwm_posedge_reg[70]\, 
        pwm_posedge_reg(69) => \pwm_posedge_reg[69]\, 
        pwm_posedge_reg(68) => \pwm_posedge_reg[68]\, 
        pwm_posedge_reg(67) => \pwm_posedge_reg[67]\, 
        pwm_posedge_reg(66) => \pwm_posedge_reg[66]\, 
        pwm_posedge_reg(65) => \pwm_posedge_reg[65]\, 
        pwm_posedge_reg(64) => \pwm_posedge_reg[64]\, 
        pwm_posedge_reg(63) => \pwm_posedge_reg[63]\, 
        pwm_posedge_reg(62) => \pwm_posedge_reg[62]\, 
        pwm_posedge_reg(61) => \pwm_posedge_reg[61]\, 
        pwm_posedge_reg(60) => \pwm_posedge_reg[60]\, 
        pwm_posedge_reg(59) => \pwm_posedge_reg[59]\, 
        pwm_posedge_reg(58) => \pwm_posedge_reg[58]\, 
        pwm_posedge_reg(57) => \pwm_posedge_reg[57]\, 
        pwm_posedge_reg(56) => \pwm_posedge_reg[56]\, 
        pwm_posedge_reg(55) => \pwm_posedge_reg[55]\, 
        pwm_posedge_reg(54) => \pwm_posedge_reg[54]\, 
        pwm_posedge_reg(53) => \pwm_posedge_reg[53]\, 
        pwm_posedge_reg(52) => \pwm_posedge_reg[52]\, 
        pwm_posedge_reg(51) => \pwm_posedge_reg[51]\, 
        pwm_posedge_reg(50) => \pwm_posedge_reg[50]\, 
        pwm_posedge_reg(49) => \pwm_posedge_reg[49]\, 
        pwm_posedge_reg(48) => \pwm_posedge_reg[48]\, 
        pwm_posedge_reg(47) => \pwm_posedge_reg[47]\, 
        pwm_posedge_reg(46) => \pwm_posedge_reg[46]\, 
        pwm_posedge_reg(45) => \pwm_posedge_reg[45]\, 
        pwm_posedge_reg(44) => \pwm_posedge_reg[44]\, 
        pwm_posedge_reg(43) => \pwm_posedge_reg[43]\, 
        pwm_posedge_reg(42) => \pwm_posedge_reg[42]\, 
        pwm_posedge_reg(41) => \pwm_posedge_reg[41]\, 
        pwm_posedge_reg(40) => \pwm_posedge_reg[40]\, 
        pwm_posedge_reg(39) => \pwm_posedge_reg[39]\, 
        pwm_posedge_reg(38) => \pwm_posedge_reg[38]\, 
        pwm_posedge_reg(37) => \pwm_posedge_reg[37]\, 
        pwm_posedge_reg(36) => \pwm_posedge_reg[36]\, 
        pwm_posedge_reg(35) => \pwm_posedge_reg[35]\, 
        pwm_posedge_reg(34) => \pwm_posedge_reg[34]\, 
        pwm_posedge_reg(33) => \pwm_posedge_reg[33]\, 
        pwm_posedge_reg(32) => \pwm_posedge_reg[32]\, 
        pwm_posedge_reg(31) => \pwm_posedge_reg[31]\, 
        pwm_posedge_reg(30) => \pwm_posedge_reg[30]\, 
        pwm_posedge_reg(29) => \pwm_posedge_reg[29]\, 
        pwm_posedge_reg(28) => \pwm_posedge_reg[28]\, 
        pwm_posedge_reg(27) => \pwm_posedge_reg[27]\, 
        pwm_posedge_reg(26) => \pwm_posedge_reg[26]\, 
        pwm_posedge_reg(25) => \pwm_posedge_reg[25]\, 
        pwm_posedge_reg(24) => \pwm_posedge_reg[24]\, 
        pwm_posedge_reg(23) => \pwm_posedge_reg[23]\, 
        pwm_posedge_reg(22) => \pwm_posedge_reg[22]\, 
        pwm_posedge_reg(21) => \pwm_posedge_reg[21]\, 
        pwm_posedge_reg(20) => \pwm_posedge_reg[20]\, 
        pwm_posedge_reg(19) => \pwm_posedge_reg[19]\, 
        pwm_posedge_reg(18) => \pwm_posedge_reg[18]\, 
        pwm_posedge_reg(17) => \pwm_posedge_reg_16\, 
        pwm_posedge_reg(16) => \pwm_posedge_reg[16]\, 
        pwm_posedge_reg(15) => \pwm_posedge_reg[15]\, 
        pwm_posedge_reg(14) => \pwm_posedge_reg[14]\, 
        pwm_posedge_reg(13) => \pwm_posedge_reg[13]\, 
        pwm_posedge_reg(12) => \pwm_posedge_reg[12]\, 
        pwm_posedge_reg(11) => \pwm_posedge_reg[11]\, 
        pwm_posedge_reg(10) => \pwm_posedge_reg[10]\, 
        pwm_posedge_reg(9) => \pwm_posedge_reg[9]\, 
        pwm_posedge_reg(8) => \pwm_posedge_reg[8]\, 
        pwm_posedge_reg(7) => \pwm_posedge_reg[7]\, 
        pwm_posedge_reg(6) => \pwm_posedge_reg[6]\, 
        pwm_posedge_reg(5) => \pwm_posedge_reg[5]\, 
        pwm_posedge_reg(4) => \pwm_posedge_reg[4]\, 
        pwm_posedge_reg(3) => \pwm_posedge_reg[3]\, 
        pwm_posedge_reg(2) => \pwm_posedge_reg[2]\, 
        pwm_posedge_reg(1) => \pwm_posedge_reg_0\, 
        pwm_enable_reg(8) => \pwm_enable_reg[8]\, 
        pwm_enable_reg(7) => \pwm_enable_reg[7]\, 
        pwm_enable_reg(6) => \pwm_enable_reg[6]\, 
        pwm_enable_reg(5) => \pwm_enable_reg[5]\, 
        pwm_enable_reg(4) => \pwm_enable_reg[4]\, 
        pwm_enable_reg(3) => \pwm_enable_reg[3]\, 
        pwm_enable_reg(2) => \pwm_enable_reg[2]\, 
        pwm_enable_reg(1) => \pwm_enable_reg[1]\, 
        pwm_negedge_reg(128) => \pwm_negedge_reg[128]\, 
        pwm_negedge_reg(127) => \pwm_negedge_reg[127]\, 
        pwm_negedge_reg(126) => \pwm_negedge_reg[126]\, 
        pwm_negedge_reg(125) => \pwm_negedge_reg[125]\, 
        pwm_negedge_reg(124) => \pwm_negedge_reg[124]\, 
        pwm_negedge_reg(123) => \pwm_negedge_reg[123]\, 
        pwm_negedge_reg(122) => \pwm_negedge_reg[122]\, 
        pwm_negedge_reg(121) => \pwm_negedge_reg[121]\, 
        pwm_negedge_reg(120) => \pwm_negedge_reg[120]\, 
        pwm_negedge_reg(119) => \pwm_negedge_reg[119]\, 
        pwm_negedge_reg(118) => \pwm_negedge_reg[118]\, 
        pwm_negedge_reg(117) => \pwm_negedge_reg[117]\, 
        pwm_negedge_reg(116) => \pwm_negedge_reg_115\, 
        pwm_negedge_reg(115) => \pwm_negedge_reg[115]\, 
        pwm_negedge_reg(114) => \pwm_negedge_reg[114]\, 
        pwm_negedge_reg(113) => \pwm_negedge_reg[113]\, 
        pwm_negedge_reg(112) => \pwm_negedge_reg[112]\, 
        pwm_negedge_reg(111) => \pwm_negedge_reg[111]\, 
        pwm_negedge_reg(110) => \pwm_negedge_reg[110]\, 
        pwm_negedge_reg(109) => \pwm_negedge_reg[109]\, 
        pwm_negedge_reg(108) => \pwm_negedge_reg[108]\, 
        pwm_negedge_reg(107) => \pwm_negedge_reg[107]\, 
        pwm_negedge_reg(106) => \pwm_negedge_reg[106]\, 
        pwm_negedge_reg(105) => \pwm_negedge_reg[105]\, 
        pwm_negedge_reg(104) => \pwm_negedge_reg[104]\, 
        pwm_negedge_reg(103) => \pwm_negedge_reg[103]\, 
        pwm_negedge_reg(102) => \pwm_negedge_reg[102]\, 
        pwm_negedge_reg(101) => \pwm_negedge_reg[101]\, 
        pwm_negedge_reg(100) => \pwm_negedge_reg_99\, 
        pwm_negedge_reg(99) => \pwm_negedge_reg[99]\, 
        pwm_negedge_reg(98) => \pwm_negedge_reg[98]\, 
        pwm_negedge_reg(97) => \pwm_negedge_reg[97]\, 
        pwm_negedge_reg(96) => \pwm_negedge_reg[96]\, 
        pwm_negedge_reg(95) => \pwm_negedge_reg[95]\, 
        pwm_negedge_reg(94) => \pwm_negedge_reg[94]\, 
        pwm_negedge_reg(93) => \pwm_negedge_reg[93]\, 
        pwm_negedge_reg(92) => \pwm_negedge_reg[92]\, 
        pwm_negedge_reg(91) => \pwm_negedge_reg[91]\, 
        pwm_negedge_reg(90) => \pwm_negedge_reg[90]\, 
        pwm_negedge_reg(89) => \pwm_negedge_reg[89]\, 
        pwm_negedge_reg(88) => \pwm_negedge_reg[88]\, 
        pwm_negedge_reg(87) => \pwm_negedge_reg[87]\, 
        pwm_negedge_reg(86) => \pwm_negedge_reg[86]\, 
        pwm_negedge_reg(85) => \pwm_negedge_reg[85]\, 
        pwm_negedge_reg(84) => \pwm_negedge_reg[84]\, 
        pwm_negedge_reg(83) => \pwm_negedge_reg[83]\, 
        pwm_negedge_reg(82) => \pwm_negedge_reg[82]\, 
        pwm_negedge_reg(81) => \pwm_negedge_reg[81]\, 
        pwm_negedge_reg(80) => \pwm_negedge_reg[80]\, 
        pwm_negedge_reg(79) => \pwm_negedge_reg[79]\, 
        pwm_negedge_reg(78) => \pwm_negedge_reg[78]\, 
        pwm_negedge_reg(77) => \pwm_negedge_reg[77]\, 
        pwm_negedge_reg(76) => \pwm_negedge_reg[76]\, 
        pwm_negedge_reg(75) => \pwm_negedge_reg[75]\, 
        pwm_negedge_reg(74) => \pwm_negedge_reg[74]\, 
        pwm_negedge_reg(73) => \pwm_negedge_reg[73]\, 
        pwm_negedge_reg(72) => \pwm_negedge_reg[72]\, 
        pwm_negedge_reg(71) => \pwm_negedge_reg[71]\, 
        pwm_negedge_reg(70) => \pwm_negedge_reg[70]\, 
        pwm_negedge_reg(69) => \pwm_negedge_reg[69]\, 
        pwm_negedge_reg(68) => \pwm_negedge_reg[68]\, 
        pwm_negedge_reg(67) => \pwm_negedge_reg[67]\, 
        pwm_negedge_reg(66) => \pwm_negedge_reg[66]\, 
        pwm_negedge_reg(65) => \pwm_negedge_reg[65]\, 
        pwm_negedge_reg(64) => \pwm_negedge_reg[64]\, 
        pwm_negedge_reg(63) => \pwm_negedge_reg[63]\, 
        pwm_negedge_reg(62) => \pwm_negedge_reg[62]\, 
        pwm_negedge_reg(61) => \pwm_negedge_reg[61]\, 
        pwm_negedge_reg(60) => \pwm_negedge_reg[60]\, 
        pwm_negedge_reg(59) => \pwm_negedge_reg[59]\, 
        pwm_negedge_reg(58) => \pwm_negedge_reg[58]\, 
        pwm_negedge_reg(57) => \pwm_negedge_reg[57]\, 
        pwm_negedge_reg(56) => \pwm_negedge_reg[56]\, 
        pwm_negedge_reg(55) => \pwm_negedge_reg[55]\, 
        pwm_negedge_reg(54) => \pwm_negedge_reg[54]\, 
        pwm_negedge_reg(53) => \pwm_negedge_reg[53]\, 
        pwm_negedge_reg(52) => \pwm_negedge_reg[52]\, 
        pwm_negedge_reg(51) => \pwm_negedge_reg[51]\, 
        pwm_negedge_reg(50) => \pwm_negedge_reg[50]\, 
        pwm_negedge_reg(49) => \pwm_negedge_reg[49]\, 
        pwm_negedge_reg(48) => \pwm_negedge_reg[48]\, 
        pwm_negedge_reg(47) => \pwm_negedge_reg[47]\, 
        pwm_negedge_reg(46) => \pwm_negedge_reg[46]\, 
        pwm_negedge_reg(45) => \pwm_negedge_reg[45]\, 
        pwm_negedge_reg(44) => \pwm_negedge_reg[44]\, 
        pwm_negedge_reg(43) => \pwm_negedge_reg[43]\, 
        pwm_negedge_reg(42) => \pwm_negedge_reg[42]\, 
        pwm_negedge_reg(41) => \pwm_negedge_reg[41]\, 
        pwm_negedge_reg(40) => \pwm_negedge_reg[40]\, 
        pwm_negedge_reg(39) => \pwm_negedge_reg[39]\, 
        pwm_negedge_reg(38) => \pwm_negedge_reg[38]\, 
        pwm_negedge_reg(37) => \pwm_negedge_reg[37]\, 
        pwm_negedge_reg(36) => \pwm_negedge_reg[36]\, 
        pwm_negedge_reg(35) => \pwm_negedge_reg[35]\, 
        pwm_negedge_reg(34) => \pwm_negedge_reg[34]\, 
        pwm_negedge_reg(33) => \pwm_negedge_reg[33]\, 
        pwm_negedge_reg(32) => \pwm_negedge_reg[32]\, 
        pwm_negedge_reg(31) => \pwm_negedge_reg[31]\, 
        pwm_negedge_reg(30) => \pwm_negedge_reg[30]\, 
        pwm_negedge_reg(29) => \pwm_negedge_reg[29]\, 
        pwm_negedge_reg(28) => \pwm_negedge_reg[28]\, 
        pwm_negedge_reg(27) => \pwm_negedge_reg[27]\, 
        pwm_negedge_reg(26) => \pwm_negedge_reg[26]\, 
        pwm_negedge_reg(25) => \pwm_negedge_reg[25]\, 
        pwm_negedge_reg(24) => \pwm_negedge_reg[24]\, 
        pwm_negedge_reg(23) => \pwm_negedge_reg[23]\, 
        pwm_negedge_reg(22) => \pwm_negedge_reg[22]\, 
        pwm_negedge_reg(21) => \pwm_negedge_reg[21]\, 
        pwm_negedge_reg(20) => \pwm_negedge_reg[20]\, 
        pwm_negedge_reg(19) => \pwm_negedge_reg[19]\, 
        pwm_negedge_reg(18) => \pwm_negedge_reg[18]\, 
        pwm_negedge_reg(17) => \pwm_negedge_reg_16\, 
        pwm_negedge_reg(16) => \pwm_negedge_reg[16]\, 
        pwm_negedge_reg(15) => \pwm_negedge_reg[15]\, 
        pwm_negedge_reg(14) => \pwm_negedge_reg[14]\, 
        pwm_negedge_reg(13) => \pwm_negedge_reg[13]\, 
        pwm_negedge_reg(12) => \pwm_negedge_reg[12]\, 
        pwm_negedge_reg(11) => \pwm_negedge_reg[11]\, 
        pwm_negedge_reg(10) => \pwm_negedge_reg[10]\, 
        pwm_negedge_reg(9) => \pwm_negedge_reg[9]\, 
        pwm_negedge_reg(8) => \pwm_negedge_reg[8]\, 
        pwm_negedge_reg(7) => \pwm_negedge_reg[7]\, 
        pwm_negedge_reg(6) => \pwm_negedge_reg[6]\, 
        pwm_negedge_reg(5) => \pwm_negedge_reg[5]\, 
        pwm_negedge_reg(4) => \pwm_negedge_reg[4]\, 
        pwm_negedge_reg(3) => \pwm_negedge_reg[3]\, 
        pwm_negedge_reg(2) => \pwm_negedge_reg[2]\, 
        pwm_negedge_reg(1) => \pwm_negedge_reg_0\, 
        CoreAPB3_0_APBmslave0_PWDATA(15) => 
        CoreAPB3_0_APBmslave0_PWDATA(15), 
        CoreAPB3_0_APBmslave0_PWDATA(14) => 
        CoreAPB3_0_APBmslave0_PWDATA(14), 
        CoreAPB3_0_APBmslave0_PWDATA(13) => 
        CoreAPB3_0_APBmslave0_PWDATA(13), 
        CoreAPB3_0_APBmslave0_PWDATA(12) => 
        CoreAPB3_0_APBmslave0_PWDATA(12), 
        CoreAPB3_0_APBmslave0_PWDATA(11) => 
        CoreAPB3_0_APBmslave0_PWDATA(11), 
        CoreAPB3_0_APBmslave0_PWDATA(10) => 
        CoreAPB3_0_APBmslave0_PWDATA(10), 
        CoreAPB3_0_APBmslave0_PWDATA(9) => 
        CoreAPB3_0_APBmslave0_PWDATA(9), 
        CoreAPB3_0_APBmslave0_PWDATA(8) => 
        CoreAPB3_0_APBmslave0_PWDATA(8), 
        CoreAPB3_0_APBmslave0_PWDATA(7) => 
        CoreAPB3_0_APBmslave0_PWDATA(7), 
        CoreAPB3_0_APBmslave0_PWDATA(6) => 
        CoreAPB3_0_APBmslave0_PWDATA(6), 
        CoreAPB3_0_APBmslave0_PWDATA(5) => 
        CoreAPB3_0_APBmslave0_PWDATA(5), 
        CoreAPB3_0_APBmslave0_PWDATA(4) => 
        CoreAPB3_0_APBmslave0_PWDATA(4), 
        CoreAPB3_0_APBmslave0_PWDATA(3) => 
        CoreAPB3_0_APBmslave0_PWDATA(3), 
        CoreAPB3_0_APBmslave0_PWDATA(2) => 
        CoreAPB3_0_APBmslave0_PWDATA(2), 
        CoreAPB3_0_APBmslave0_PWDATA(1) => 
        CoreAPB3_0_APBmslave0_PWDATA(1), 
        CoreAPB3_0_APBmslave0_PWDATA(0) => 
        CoreAPB3_0_APBmslave0_PWDATA(0), PRDATA_generated_6_0_0
         => PRDATA_generated_6_0_0, 
        PRDATA_generated_15_0_0_wmux_0_Y_3 => 
        PRDATA_generated_15_0_0_wmux_0_Y_3, 
        PRDATA_generated_15_0_0_wmux_0_Y_0 => 
        PRDATA_generated_15_0_0_wmux_0_Y_0, 
        PRDATA_generated_15_2_0_wmux_0_Y_3 => 
        PRDATA_generated_15_2_0_wmux_0_Y_3, 
        PRDATA_generated_15_2_0_wmux_0_Y_0 => 
        PRDATA_generated_15_2_0_wmux_0_Y_0, N_166 => N_166, N_62
         => N_62, un9_psel => un9_psel, un7_psel => un7_psel, 
        un11_psel => un11_psel, N_60 => N_60, sync_pulse_1 => 
        sync_pulse_1, N_174 => N_174, N_962 => N_962, N_959 => 
        N_959, N_960 => N_960, N_966 => N_966, N_963 => N_963, 
        N_964 => N_964, N_961 => N_961, N_965 => N_965, N_936 => 
        N_936, N_940 => N_940, N_941 => N_941, N_939 => N_939, 
        N_942 => N_942, N_937 => N_937, 
        CoreAPB3_0_APBmslave0_PENABLE => 
        CoreAPB3_0_APBmslave0_PENABLE, 
        CoreAPB3_0_APBmslave0_PSELx => 
        CoreAPB3_0_APBmslave0_PSELx, CoreAPB3_0_APBmslave0_PWRITE
         => CoreAPB3_0_APBmslave0_PWRITE, N_781 => N_781, N_779
         => N_779, N_780 => N_780, N_732 => N_732, N_731 => N_731, 
        N_730 => N_730, N_782 => N_782, N_777 => N_777, N_10_1
         => N_10_1, N_729 => N_729, N_733 => N_733, N_776 => 
        N_776, N_734 => N_734, N_728 => N_728, sync_update => 
        sync_update, FAB_CCC_GL0 => FAB_CCC_GL0, MSS_READY => 
        MSS_READY);
    
    \PWM_STRETCH[7]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(7), CLK => 
        FAB_CCC_GL0, EN => \PWM_STRETCH_0_sqmuxa\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => PWM_STRETCH(7));
    
    \PWM_STRETCH[3]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(3), CLK => 
        FAB_CCC_GL0, EN => \PWM_STRETCH_0_sqmuxa\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => PWM_STRETCH(3));
    
    PWM_STRETCH_0_sqmuxa_3 : CFG4
      generic map(INIT => x"0040")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => 
        CoreAPB3_0_APBmslave0_PADDR(3), Y => 
        \PWM_STRETCH_0_sqmuxa_3\);
    
    PWM_STRETCH_0_sqmuxa : CFG4
      generic map(INIT => x"1000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(5), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => 
        \PWM_STRETCH_0_sqmuxa_3\, D => N_174, Y => 
        \PWM_STRETCH_0_sqmuxa\);
    
    \PWM_STRETCH[6]\ : SLE
      port map(D => CoreAPB3_0_APBmslave0_PWDATA(6), CLK => 
        FAB_CCC_GL0, EN => \PWM_STRETCH_0_sqmuxa\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => PWM_STRETCH(6));
    
    \G0b.timebase_inst\ : corepwm_timebase
      port map(period_reg(15) => \period_reg[15]\, period_reg(14)
         => \period_reg[14]\, period_reg(13) => \period_reg[13]\, 
        period_reg(12) => \period_reg[12]\, period_reg(11) => 
        \period_reg[11]\, period_reg(10) => \period_reg[10]\, 
        period_reg(9) => \period_reg[9]\, period_reg(8) => 
        \period_reg[8]\, period_reg(7) => \period_reg[7]\, 
        period_reg(6) => \period_reg[6]\, period_reg(5) => 
        \period_reg[5]\, period_reg(4) => \period_reg[4]\, 
        period_reg(3) => \period_reg[3]\, period_reg(2) => 
        \period_reg[2]\, period_reg(1) => \period_reg[1]\, 
        period_reg(0) => \period_reg[0]\, prescale_reg(15) => 
        \prescale_reg[15]\, prescale_reg(14) => 
        \prescale_reg[14]\, prescale_reg(13) => 
        \prescale_reg[13]\, prescale_reg(12) => 
        \prescale_reg[12]\, prescale_reg(11) => 
        \prescale_reg[11]\, prescale_reg(10) => 
        \prescale_reg[10]\, prescale_reg(9) => \prescale_reg[9]\, 
        prescale_reg(8) => \prescale_reg[8]\, prescale_reg(7) => 
        \prescale_reg[7]\, prescale_reg(6) => \prescale_reg[6]\, 
        prescale_reg(5) => \prescale_reg[5]\, prescale_reg(4) => 
        \prescale_reg[4]\, prescale_reg(3) => \prescale_reg[3]\, 
        prescale_reg(2) => \prescale_reg[2]\, prescale_reg(1) => 
        \prescale_reg[1]\, prescale_reg(0) => \prescale_reg[0]\, 
        period_cnt(15) => \period_cnt[15]\, period_cnt(14) => 
        \period_cnt[14]\, period_cnt(13) => \period_cnt[13]\, 
        period_cnt(12) => \period_cnt[12]\, period_cnt(11) => 
        \period_cnt[11]\, period_cnt(10) => \period_cnt[10]\, 
        period_cnt(9) => \period_cnt[9]\, period_cnt(8) => 
        \period_cnt[8]\, period_cnt(7) => \period_cnt[7]\, 
        period_cnt(6) => \period_cnt[6]\, period_cnt(5) => 
        \period_cnt[5]\, period_cnt(4) => \period_cnt[4]\, 
        period_cnt(3) => \period_cnt[3]\, period_cnt(2) => 
        \period_cnt[2]\, period_cnt(1) => \period_cnt[1]\, 
        period_cnt(0) => \period_cnt[0]\, sync_pulse_1 => 
        sync_pulse_1, CCC_0_GL1 => CCC_0_GL1, MSS_READY => 
        MSS_READY);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity COREAPB3_MUXPTOB3 is

    port( PRDATA_regif_0_iv_0_0                               : in    std_logic_vector(15 downto 8);
          CoreAPB3_0_APBmslave0_PADDR                         : in    std_logic_vector(7 downto 2);
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_0  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_12 : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_11 : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_10 : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_9  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_8  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_7  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_6  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_5  : out   std_logic;
          CoreAPB3_0_APBmslave2_PRDATA_0                      : in    std_logic;
          PRDATA_generated_15_0_0_wmux_0_Y_0                  : in    std_logic;
          pwm_negedge_reg_16                                  : in    std_logic;
          pwm_negedge_reg_0                                   : in    std_logic;
          PRDATA_generated_6_0_0                              : in    std_logic;
          PRDATA_generated_15_2_0_wmux_0_Y_0                  : in    std_logic;
          prescale_reg_0                                      : in    std_logic;
          pwm_enable_reg_0                                    : in    std_logic;
          period_reg_0                                        : in    std_logic;
          PWM_STRETCH_0                                       : in    std_logic;
          CONFIG_regrx_0                                      : in    std_logic;
          N_959                                               : in    std_logic;
          N_960                                               : in    std_logic;
          N_961                                               : in    std_logic;
          N_962                                               : in    std_logic;
          N_963                                               : in    std_logic;
          N_964                                               : in    std_logic;
          N_965                                               : in    std_logic;
          N_966                                               : in    std_logic;
          N_166                                               : in    std_logic;
          CoreAPB3_0_APBmslave2_PSELx                         : in    std_logic;
          CoreAPB3_0_APBmslave1_PSELx                         : in    std_logic;
          CoreAPB3_0_APBmslave0_PSELx                         : in    std_logic;
          N_60                                                : in    std_logic;
          N_730                                               : in    std_logic;
          un7_psel                                            : in    std_logic;
          un11_psel                                           : in    std_logic;
          un9_psel                                            : in    std_logic;
          N_62                                                : in    std_logic;
          GEN_N_3_mux_0                                       : in    std_logic
        );

end COREAPB3_MUXPTOB3;

architecture DEF_ARCH of COREAPB3_MUXPTOB3 is 

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

    signal \PRDATA_N_3L3_1\, m7_0, m11_0, 
        \PRDATA_RNO_2[3]_net_1\, m15_e_1, N_10_0_0, o2, N_13_0_0, 
        N_4_0, N_6_0, N_14_2, \PRDATA_RNO[3]_net_1\, 
        \PRDATA_N_6L10_1\, \iPRDATA_0_sqmuxa\, GND_net_1, 
        VCC_net_1 : std_logic;

begin 


    \PRDATA_RNO_4[3]\ : CFG4
      generic map(INIT => x"BF8C")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(5), C => 
        PRDATA_generated_15_0_0_wmux_0_Y_0, D => N_4_0, Y => 
        N_6_0);
    
    \PRDATA_RNO[3]\ : CFG4
      generic map(INIT => x"0F8F")

      port map(A => m15_e_1, B => N_14_2, C => 
        CoreAPB3_0_APBmslave0_PSELx, D => \PRDATA_RNO_2[3]_net_1\, 
        Y => \PRDATA_RNO[3]_net_1\);
    
    iPRDATA_0_sqmuxa_RNIR5001 : CFG4
      generic map(INIT => x"F080")

      port map(A => N_166, B => N_962, C => \iPRDATA_0_sqmuxa\, D
         => PRDATA_regif_0_iv_0_0(11), Y => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_8);
    
    iPRDATA_0_sqmuxa_RNIP3001 : CFG4
      generic map(INIT => x"F080")

      port map(A => N_166, B => N_961, C => \iPRDATA_0_sqmuxa\, D
         => PRDATA_regif_0_iv_0_0(10), Y => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_7);
    
    iPRDATA_0_sqmuxa_RNI1C001 : CFG4
      generic map(INIT => x"F080")

      port map(A => N_166, B => N_965, C => \iPRDATA_0_sqmuxa\, D
         => PRDATA_regif_0_iv_0_0(14), Y => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_11);
    
    iPRDATA_0_sqmuxa_RNI3E001 : CFG4
      generic map(INIT => x"F080")

      port map(A => N_166, B => N_966, C => \iPRDATA_0_sqmuxa\, D
         => PRDATA_regif_0_iv_0_0(15), Y => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_12);
    
    iPRDATA_0_sqmuxa_RNI75001 : CFG4
      generic map(INIT => x"F080")

      port map(A => N_166, B => N_959, C => \iPRDATA_0_sqmuxa\, D
         => PRDATA_regif_0_iv_0_0(8), Y => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_5);
    
    \PRDATA_RNO_1[3]\ : CFG4
      generic map(INIT => x"FB51")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => m7_0, C
         => N_6_0, D => N_13_0_0, Y => N_14_2);
    
    iPRDATA_0_sqmuxa_RNIV9001 : CFG4
      generic map(INIT => x"F080")

      port map(A => N_166, B => N_964, C => \iPRDATA_0_sqmuxa\, D
         => PRDATA_regif_0_iv_0_0(13), Y => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_10);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    iPRDATA_0_sqmuxa_RNIT7001 : CFG4
      generic map(INIT => x"F080")

      port map(A => N_166, B => N_963, C => \iPRDATA_0_sqmuxa\, D
         => PRDATA_regif_0_iv_0_0(12), Y => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_9);
    
    iPRDATA_0_sqmuxa : CFG3
      generic map(INIT => x"02")

      port map(A => CoreAPB3_0_APBmslave0_PSELx, B => 
        CoreAPB3_0_APBmslave1_PSELx, C => 
        CoreAPB3_0_APBmslave2_PSELx, Y => \iPRDATA_0_sqmuxa\);
    
    \PRDATA_RNO_8[3]\ : CFG4
      generic map(INIT => x"CDEF")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(5), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), C => N_730, D => 
        PRDATA_generated_15_2_0_wmux_0_Y_0, Y => N_10_0_0);
    
    \PRDATA_RNO_2[3]\ : CFG2
      generic map(INIT => x"8")

      port map(A => un9_psel, B => period_reg_0, Y => 
        \PRDATA_RNO_2[3]_net_1\);
    
    \PRDATA_RNO_9[3]\ : CFG4
      generic map(INIT => x"193B")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => 
        PRDATA_generated_6_0_0, C => pwm_negedge_reg_16, D => 
        pwm_negedge_reg_0, Y => o2);
    
    \PRDATA_RNO_5[3]\ : CFG4
      generic map(INIT => x"74FC")

      port map(A => m11_0, B => CoreAPB3_0_APBmslave0_PADDR(7), C
         => N_10_0_0, D => N_60, Y => N_13_0_0);
    
    \PRDATA[3]\ : CFG4
      generic map(INIT => x"8A9B")

      port map(A => \PRDATA_N_6L10_1\, B => 
        CoreAPB3_0_APBmslave2_PSELx, C => \PRDATA_RNO[3]_net_1\, 
        D => \PRDATA_N_3L3_1\, Y => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_0);
    
    \PRDATA_RNO_7[3]\ : CFG2
      generic map(INIT => x"4")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        PWM_STRETCH_0, Y => m11_0);
    
    \PRDATA_RNO_6[3]\ : CFG3
      generic map(INIT => x"A3")

      port map(A => o2, B => N_730, C => 
        CoreAPB3_0_APBmslave0_PADDR(6), Y => N_4_0);
    
    \PRDATA_RNO_3[3]\ : CFG2
      generic map(INIT => x"2")

      port map(A => N_62, B => CoreAPB3_0_APBmslave0_PADDR(7), Y
         => m7_0);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \PRDATA_RNO_0[3]\ : CFG4
      generic map(INIT => x"135F")

      port map(A => pwm_enable_reg_0, B => prescale_reg_0, C => 
        un11_psel, D => un7_psel, Y => m15_e_1);
    
    iPRDATA_0_sqmuxa_RNI97001 : CFG4
      generic map(INIT => x"F080")

      port map(A => N_166, B => N_960, C => \iPRDATA_0_sqmuxa\, D
         => PRDATA_regif_0_iv_0_0(9), Y => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_6);
    
    PRDATA_N_6L10_1 : CFG3
      generic map(INIT => x"51")

      port map(A => CoreAPB3_0_APBmslave1_PSELx, B => 
        CoreAPB3_0_APBmslave2_PSELx, C => 
        CoreAPB3_0_APBmslave2_PRDATA_0, Y => \PRDATA_N_6L10_1\);
    
    PRDATA_N_3L3_1 : CFG3
      generic map(INIT => x"EF")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        GEN_N_3_mux_0, C => CONFIG_regrx_0, Y => \PRDATA_N_3L3_1\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity CoreAPB3 is

    port( CoreAPB3_0_APBmslave0_PADDR                         : in    std_logic_vector(7 downto 2);
          PRDATA_regif_0_iv_0_0                               : in    std_logic_vector(15 downto 8);
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR     : in    std_logic_vector(15 downto 12);
          CONFIG_regrx_0                                      : in    std_logic;
          PWM_STRETCH_0                                       : in    std_logic;
          period_reg_0                                        : in    std_logic;
          pwm_enable_reg_0                                    : in    std_logic;
          prescale_reg_0                                      : in    std_logic;
          PRDATA_generated_15_2_0_wmux_0_Y_0                  : in    std_logic;
          PRDATA_generated_6_0_0                              : in    std_logic;
          pwm_negedge_reg_16                                  : in    std_logic;
          pwm_negedge_reg_0                                   : in    std_logic;
          PRDATA_generated_15_0_0_wmux_0_Y_0                  : in    std_logic;
          CoreAPB3_0_APBmslave2_PRDATA_0                      : in    std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_0  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_12 : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_11 : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_10 : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_9  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_8  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_7  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_6  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_5  : out   std_logic;
          GEN_N_3_mux_0                                       : in    std_logic;
          N_62                                                : in    std_logic;
          un9_psel                                            : in    std_logic;
          un11_psel                                           : in    std_logic;
          un7_psel                                            : in    std_logic;
          N_730                                               : in    std_logic;
          N_60                                                : in    std_logic;
          N_166                                               : in    std_logic;
          N_966                                               : in    std_logic;
          N_965                                               : in    std_logic;
          N_964                                               : in    std_logic;
          N_963                                               : in    std_logic;
          N_962                                               : in    std_logic;
          N_961                                               : in    std_logic;
          N_960                                               : in    std_logic;
          N_959                                               : in    std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PSELx     : in    std_logic;
          N_21_1                                              : out   std_logic;
          N_21_2                                              : out   std_logic;
          CoreAPB3_0_APBmslave2_PSELx                         : out   std_logic;
          CoreAPB3_0_APBmslave1_PSELx                         : out   std_logic;
          CoreAPB3_0_APBmslave0_PSELx                         : out   std_logic
        );

end CoreAPB3;

architecture DEF_ARCH of CoreAPB3 is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component COREAPB3_MUXPTOB3
    port( PRDATA_regif_0_iv_0_0                               : in    std_logic_vector(15 downto 8) := (others => 'U');
          CoreAPB3_0_APBmslave0_PADDR                         : in    std_logic_vector(7 downto 2) := (others => 'U');
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_0  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_12 : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_11 : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_10 : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_9  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_8  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_7  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_6  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_5  : out   std_logic;
          CoreAPB3_0_APBmslave2_PRDATA_0                      : in    std_logic := 'U';
          PRDATA_generated_15_0_0_wmux_0_Y_0                  : in    std_logic := 'U';
          pwm_negedge_reg_16                                  : in    std_logic := 'U';
          pwm_negedge_reg_0                                   : in    std_logic := 'U';
          PRDATA_generated_6_0_0                              : in    std_logic := 'U';
          PRDATA_generated_15_2_0_wmux_0_Y_0                  : in    std_logic := 'U';
          prescale_reg_0                                      : in    std_logic := 'U';
          pwm_enable_reg_0                                    : in    std_logic := 'U';
          period_reg_0                                        : in    std_logic := 'U';
          PWM_STRETCH_0                                       : in    std_logic := 'U';
          CONFIG_regrx_0                                      : in    std_logic := 'U';
          N_959                                               : in    std_logic := 'U';
          N_960                                               : in    std_logic := 'U';
          N_961                                               : in    std_logic := 'U';
          N_962                                               : in    std_logic := 'U';
          N_963                                               : in    std_logic := 'U';
          N_964                                               : in    std_logic := 'U';
          N_965                                               : in    std_logic := 'U';
          N_966                                               : in    std_logic := 'U';
          N_166                                               : in    std_logic := 'U';
          CoreAPB3_0_APBmslave2_PSELx                         : in    std_logic := 'U';
          CoreAPB3_0_APBmslave1_PSELx                         : in    std_logic := 'U';
          CoreAPB3_0_APBmslave0_PSELx                         : in    std_logic := 'U';
          N_60                                                : in    std_logic := 'U';
          N_730                                               : in    std_logic := 'U';
          un7_psel                                            : in    std_logic := 'U';
          un11_psel                                           : in    std_logic := 'U';
          un9_psel                                            : in    std_logic := 'U';
          N_62                                                : in    std_logic := 'U';
          GEN_N_3_mux_0                                       : in    std_logic := 'U'
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \CoreAPB3_0_APBmslave0_PSELx\, 
        \CoreAPB3_0_APBmslave1_PSELx\, 
        \CoreAPB3_0_APBmslave2_PSELx\, 
        \iPSELS_raw_6_0_a2_0[0]_net_1\, GND_net_1, VCC_net_1
         : std_logic;
    signal nc1 : std_logic;

    for all : COREAPB3_MUXPTOB3
	Use entity work.COREAPB3_MUXPTOB3(DEF_ARCH);
begin 

    CoreAPB3_0_APBmslave2_PSELx <= \CoreAPB3_0_APBmslave2_PSELx\;
    CoreAPB3_0_APBmslave1_PSELx <= \CoreAPB3_0_APBmslave1_PSELx\;
    CoreAPB3_0_APBmslave0_PSELx <= \CoreAPB3_0_APBmslave0_PSELx\;

    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \iPSELS_raw_RNIEE8N_0[0]\ : CFG3
      generic map(INIT => x"02")

      port map(A => \CoreAPB3_0_APBmslave0_PSELx\, B => 
        \CoreAPB3_0_APBmslave1_PSELx\, C => 
        \CoreAPB3_0_APBmslave2_PSELx\, Y => N_21_2);
    
    \iPSELS_raw_6_0_a2_0[0]\ : CFG2
      generic map(INIT => x"1")

      port map(A => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(15), B
         => SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(14), 
        Y => \iPSELS_raw_6_0_a2_0[0]_net_1\);
    
    \iPSELS_raw[2]\ : CFG4
      generic map(INIT => x"0800")

      port map(A => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PSELx, B => 
        \iPSELS_raw_6_0_a2_0[0]_net_1\, C => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(12), D
         => SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(13), 
        Y => \CoreAPB3_0_APBmslave2_PSELx\);
    
    u_mux_p_to_b3 : COREAPB3_MUXPTOB3
      port map(PRDATA_regif_0_iv_0_0(15) => 
        PRDATA_regif_0_iv_0_0(15), PRDATA_regif_0_iv_0_0(14) => 
        PRDATA_regif_0_iv_0_0(14), PRDATA_regif_0_iv_0_0(13) => 
        PRDATA_regif_0_iv_0_0(13), PRDATA_regif_0_iv_0_0(12) => 
        PRDATA_regif_0_iv_0_0(12), PRDATA_regif_0_iv_0_0(11) => 
        PRDATA_regif_0_iv_0_0(11), PRDATA_regif_0_iv_0_0(10) => 
        PRDATA_regif_0_iv_0_0(10), PRDATA_regif_0_iv_0_0(9) => 
        PRDATA_regif_0_iv_0_0(9), PRDATA_regif_0_iv_0_0(8) => 
        PRDATA_regif_0_iv_0_0(8), CoreAPB3_0_APBmslave0_PADDR(7)
         => CoreAPB3_0_APBmslave0_PADDR(7), 
        CoreAPB3_0_APBmslave0_PADDR(6) => 
        CoreAPB3_0_APBmslave0_PADDR(6), 
        CoreAPB3_0_APBmslave0_PADDR(5) => 
        CoreAPB3_0_APBmslave0_PADDR(5), 
        CoreAPB3_0_APBmslave0_PADDR(4) => 
        CoreAPB3_0_APBmslave0_PADDR(4), 
        CoreAPB3_0_APBmslave0_PADDR(3) => nc1, 
        CoreAPB3_0_APBmslave0_PADDR(2) => 
        CoreAPB3_0_APBmslave0_PADDR(2), 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_0 => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_0, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_12 => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_12, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_11 => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_11, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_10 => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_10, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_9 => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_9, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_8 => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_8, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_7 => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_7, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_6 => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_6, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_5 => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_5, 
        CoreAPB3_0_APBmslave2_PRDATA_0 => 
        CoreAPB3_0_APBmslave2_PRDATA_0, 
        PRDATA_generated_15_0_0_wmux_0_Y_0 => 
        PRDATA_generated_15_0_0_wmux_0_Y_0, pwm_negedge_reg_16
         => pwm_negedge_reg_16, pwm_negedge_reg_0 => 
        pwm_negedge_reg_0, PRDATA_generated_6_0_0 => 
        PRDATA_generated_6_0_0, 
        PRDATA_generated_15_2_0_wmux_0_Y_0 => 
        PRDATA_generated_15_2_0_wmux_0_Y_0, prescale_reg_0 => 
        prescale_reg_0, pwm_enable_reg_0 => pwm_enable_reg_0, 
        period_reg_0 => period_reg_0, PWM_STRETCH_0 => 
        PWM_STRETCH_0, CONFIG_regrx_0 => CONFIG_regrx_0, N_959
         => N_959, N_960 => N_960, N_961 => N_961, N_962 => N_962, 
        N_963 => N_963, N_964 => N_964, N_965 => N_965, N_966 => 
        N_966, N_166 => N_166, CoreAPB3_0_APBmslave2_PSELx => 
        \CoreAPB3_0_APBmslave2_PSELx\, 
        CoreAPB3_0_APBmslave1_PSELx => 
        \CoreAPB3_0_APBmslave1_PSELx\, 
        CoreAPB3_0_APBmslave0_PSELx => 
        \CoreAPB3_0_APBmslave0_PSELx\, N_60 => N_60, N_730 => 
        N_730, un7_psel => un7_psel, un11_psel => un11_psel, 
        un9_psel => un9_psel, N_62 => N_62, GEN_N_3_mux_0 => 
        GEN_N_3_mux_0);
    
    \iPSELS_raw[1]\ : CFG4
      generic map(INIT => x"0080")

      port map(A => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PSELx, B => 
        \iPSELS_raw_6_0_a2_0[0]_net_1\, C => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(12), D
         => SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(13), 
        Y => \CoreAPB3_0_APBmslave1_PSELx\);
    
    \iPSELS_raw[0]\ : CFG4
      generic map(INIT => x"0008")

      port map(A => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PSELx, B => 
        \iPSELS_raw_6_0_a2_0[0]_net_1\, C => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(12), D
         => SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(13), 
        Y => \CoreAPB3_0_APBmslave0_PSELx\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \iPSELS_raw_RNIEE8N[0]\ : CFG3
      generic map(INIT => x"02")

      port map(A => \CoreAPB3_0_APBmslave0_PSELx\, B => 
        \CoreAPB3_0_APBmslave1_PSELx\, C => 
        \CoreAPB3_0_APBmslave2_PSELx\, Y => N_21_1);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity SF2_MSS_sys_sb_MSS is

    port( CoreAPB3_0_APBmslave0_PWDATA                        : out   std_logic_vector(15 downto 0);
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR     : out   std_logic_vector(15 downto 12);
          CoreAPB3_0_APBmslave0_PADDR                         : inout std_logic_vector(7 downto 0) := (others => 'Z');
          prescale_reg                                        : in    std_logic_vector(2 downto 0);
          PWM_STRETCH                                         : in    std_logic_vector(7 downto 0);
          period_reg                                          : in    std_logic_vector(7 downto 0);
          pwm_enable_reg                                      : in    std_logic_vector(3 downto 1);
          CoreAPB3_0_APBmslave2_PRDATA                        : in    std_logic_vector(7 downto 0);
          PRDATA_regif_iv_0_0                                 : in    std_logic_vector(7 downto 4);
          CONFIG_regrx                                        : in    std_logic_vector(7 downto 4);
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_0  : in    std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_5  : in    std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_6  : in    std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_7  : in    std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_8  : in    std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_9  : in    std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_10 : in    std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_11 : in    std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_12 : in    std_logic;
          PRDATA_generated_15_2_0_wmux_0_Y_0                  : in    std_logic;
          PRDATA_generated_15_0_0_wmux_0_Y_0                  : in    std_logic;
          PRDATA_o_2_bm_0                                     : in    std_logic;
          PRDATA_o_2_am_0                                     : in    std_logic;
          pwm_posedge_reg_0                                   : in    std_logic;
          pwm_posedge_reg_16                                  : in    std_logic;
          pwm_negedge_reg_0                                   : in    std_logic;
          pwm_negedge_reg_16                                  : in    std_logic;
          FAB_CCC_GL0                                         : in    std_logic;
          SPI_0_SS0_F2M_c                                     : in    std_logic;
          SPI_0_DI_F2M_c                                      : in    std_logic;
          SPI_0_CLK_F2M_c                                     : in    std_logic;
          FAB_CCC_LOCK                                        : in    std_logic;
          int_or_i                                            : in    std_logic;
          OR3_1_Y                                             : in    std_logic;
          SPI_0_SS4_M2F_c                                     : out   std_logic;
          SPI_0_SS3_M2F_c                                     : out   std_logic;
          SPI_0_SS2_M2F_c                                     : out   std_logic;
          SPI_0_SS1_M2F_c                                     : out   std_logic;
          SPI_0_SS0_M2F_OE_c                                  : out   std_logic;
          SPI_0_SS0_M2F_c                                     : out   std_logic;
          SPI_0_DO_M2F_c                                      : out   std_logic;
          SPI_0_CLK_M2F_c                                     : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_MSS_RESET_N_M2F            : out   std_logic;
          CoreAPB3_0_APBmslave0_PWRITE                        : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PSELx     : out   std_logic;
          CoreAPB3_0_APBmslave0_PENABLE                       : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N       : out   std_logic;
          N_936                                               : in    std_logic;
          un7_psel                                            : in    std_logic;
          N_937                                               : in    std_logic;
          N_45                                                : in    std_logic;
          N_780                                               : in    std_logic;
          N_21_1                                              : in    std_logic;
          N_732                                               : in    std_logic;
          N_940                                               : in    std_logic;
          N_86_mux_0                                          : in    std_logic;
          N_941                                               : in    std_logic;
          N_779                                               : in    std_logic;
          N_21_2                                              : in    std_logic;
          N_731                                               : in    std_logic;
          N_939                                               : in    std_logic;
          N_942                                               : in    std_logic;
          un9_psel                                            : in    std_logic;
          GEN_N_3_mux_0                                       : in    std_logic;
          N_10_1                                              : in    std_logic;
          un11_psel                                           : in    std_logic;
          N_62                                                : in    std_logic;
          N_60                                                : in    std_logic;
          CoreAPB3_0_APBmslave2_PSELx                         : in    std_logic;
          CoreAPB3_0_APBmslave0_PSELx                         : in    std_logic;
          CoreAPB3_0_APBmslave1_PSELx                         : in    std_logic;
          PRDATA_o_sn_N_6_mux                                 : in    std_logic;
          un3_prdata_o                                        : in    std_logic;
          un27_psel                                           : in    std_logic;
          sync_update                                         : in    std_logic;
          N_734                                               : in    std_logic;
          N_782                                               : in    std_logic;
          N_733                                               : in    std_logic;
          N_781                                               : in    std_logic;
          N_729                                               : in    std_logic;
          N_777                                               : in    std_logic;
          N_728                                               : in    std_logic;
          N_776                                               : in    std_logic
        );

end SF2_MSS_sys_sb_MSS;

architecture DEF_ARCH of SF2_MSS_sys_sb_MSS is 

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component MSS_025

            generic (INIT:std_logic_vector(1437 downto 0) := "00" & x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"; 
        ACT_UBITS:std_logic_vector(55 downto 0) := x"FFFFFFFFFFFFFF"; 
        MEMORYFILE:string := ""; RTC_MAIN_XTL_FREQ:real := 0.0; 
        RTC_MAIN_XTL_MODE:string := "1"; DDR_CLK_FREQ:real := 0.0
        );

    port( CAN_RXBUS_MGPIO3A_H2F_A                 : out   std_logic;
          CAN_RXBUS_MGPIO3A_H2F_B                 : out   std_logic;
          CAN_TX_EBL_MGPIO4A_H2F_A                : out   std_logic;
          CAN_TX_EBL_MGPIO4A_H2F_B                : out   std_logic;
          CAN_TXBUS_MGPIO2A_H2F_A                 : out   std_logic;
          CAN_TXBUS_MGPIO2A_H2F_B                 : out   std_logic;
          CLK_CONFIG_APB                          : out   std_logic;
          COMMS_INT                               : out   std_logic;
          CONFIG_PRESET_N                         : out   std_logic;
          EDAC_ERROR                              : out   std_logic_vector(7 downto 0);
          F_FM0_RDATA                             : out   std_logic_vector(31 downto 0);
          F_FM0_READYOUT                          : out   std_logic;
          F_FM0_RESP                              : out   std_logic;
          F_HM0_ADDR                              : out   std_logic_vector(31 downto 0);
          F_HM0_ENABLE                            : out   std_logic;
          F_HM0_SEL                               : out   std_logic;
          F_HM0_SIZE                              : out   std_logic_vector(1 downto 0);
          F_HM0_TRANS1                            : out   std_logic;
          F_HM0_WDATA                             : out   std_logic_vector(31 downto 0);
          F_HM0_WRITE                             : out   std_logic;
          FAB_CHRGVBUS                            : out   std_logic;
          FAB_DISCHRGVBUS                         : out   std_logic;
          FAB_DMPULLDOWN                          : out   std_logic;
          FAB_DPPULLDOWN                          : out   std_logic;
          FAB_DRVVBUS                             : out   std_logic;
          FAB_IDPULLUP                            : out   std_logic;
          FAB_OPMODE                              : out   std_logic_vector(1 downto 0);
          FAB_SUSPENDM                            : out   std_logic;
          FAB_TERMSEL                             : out   std_logic;
          FAB_TXVALID                             : out   std_logic;
          FAB_VCONTROL                            : out   std_logic_vector(3 downto 0);
          FAB_VCONTROLLOADM                       : out   std_logic;
          FAB_XCVRSEL                             : out   std_logic_vector(1 downto 0);
          FAB_XDATAOUT                            : out   std_logic_vector(7 downto 0);
          FACC_GLMUX_SEL                          : out   std_logic;
          FIC32_0_MASTER                          : out   std_logic_vector(1 downto 0);
          FIC32_1_MASTER                          : out   std_logic_vector(1 downto 0);
          FPGA_RESET_N                            : out   std_logic;
          GTX_CLK                                 : out   std_logic;
          H2F_INTERRUPT                           : out   std_logic_vector(15 downto 0);
          H2F_NMI                                 : out   std_logic;
          H2FCALIB                                : out   std_logic;
          I2C0_SCL_MGPIO31B_H2F_A                 : out   std_logic;
          I2C0_SCL_MGPIO31B_H2F_B                 : out   std_logic;
          I2C0_SDA_MGPIO30B_H2F_A                 : out   std_logic;
          I2C0_SDA_MGPIO30B_H2F_B                 : out   std_logic;
          I2C1_SCL_MGPIO1A_H2F_A                  : out   std_logic;
          I2C1_SCL_MGPIO1A_H2F_B                  : out   std_logic;
          I2C1_SDA_MGPIO0A_H2F_A                  : out   std_logic;
          I2C1_SDA_MGPIO0A_H2F_B                  : out   std_logic;
          MDCF                                    : out   std_logic;
          MDOENF                                  : out   std_logic;
          MDOF                                    : out   std_logic;
          MMUART0_CTS_MGPIO19B_H2F_A              : out   std_logic;
          MMUART0_CTS_MGPIO19B_H2F_B              : out   std_logic;
          MMUART0_DCD_MGPIO22B_H2F_A              : out   std_logic;
          MMUART0_DCD_MGPIO22B_H2F_B              : out   std_logic;
          MMUART0_DSR_MGPIO20B_H2F_A              : out   std_logic;
          MMUART0_DSR_MGPIO20B_H2F_B              : out   std_logic;
          MMUART0_DTR_MGPIO18B_H2F_A              : out   std_logic;
          MMUART0_DTR_MGPIO18B_H2F_B              : out   std_logic;
          MMUART0_RI_MGPIO21B_H2F_A               : out   std_logic;
          MMUART0_RI_MGPIO21B_H2F_B               : out   std_logic;
          MMUART0_RTS_MGPIO17B_H2F_A              : out   std_logic;
          MMUART0_RTS_MGPIO17B_H2F_B              : out   std_logic;
          MMUART0_RXD_MGPIO28B_H2F_A              : out   std_logic;
          MMUART0_RXD_MGPIO28B_H2F_B              : out   std_logic;
          MMUART0_SCK_MGPIO29B_H2F_A              : out   std_logic;
          MMUART0_SCK_MGPIO29B_H2F_B              : out   std_logic;
          MMUART0_TXD_MGPIO27B_H2F_A              : out   std_logic;
          MMUART0_TXD_MGPIO27B_H2F_B              : out   std_logic;
          MMUART1_DTR_MGPIO12B_H2F_A              : out   std_logic;
          MMUART1_RTS_MGPIO11B_H2F_A              : out   std_logic;
          MMUART1_RTS_MGPIO11B_H2F_B              : out   std_logic;
          MMUART1_RXD_MGPIO26B_H2F_A              : out   std_logic;
          MMUART1_RXD_MGPIO26B_H2F_B              : out   std_logic;
          MMUART1_SCK_MGPIO25B_H2F_A              : out   std_logic;
          MMUART1_SCK_MGPIO25B_H2F_B              : out   std_logic;
          MMUART1_TXD_MGPIO24B_H2F_A              : out   std_logic;
          MMUART1_TXD_MGPIO24B_H2F_B              : out   std_logic;
          MPLL_LOCK                               : out   std_logic;
          PER2_FABRIC_PADDR                       : out   std_logic_vector(15 downto 2);
          PER2_FABRIC_PENABLE                     : out   std_logic;
          PER2_FABRIC_PSEL                        : out   std_logic;
          PER2_FABRIC_PWDATA                      : out   std_logic_vector(31 downto 0);
          PER2_FABRIC_PWRITE                      : out   std_logic;
          RTC_MATCH                               : out   std_logic;
          SLEEPDEEP                               : out   std_logic;
          SLEEPHOLDACK                            : out   std_logic;
          SLEEPING                                : out   std_logic;
          SMBALERT_NO0                            : out   std_logic;
          SMBALERT_NO1                            : out   std_logic;
          SMBSUS_NO0                              : out   std_logic;
          SMBSUS_NO1                              : out   std_logic;
          SPI0_CLK_OUT                            : out   std_logic;
          SPI0_SDI_MGPIO5A_H2F_A                  : out   std_logic;
          SPI0_SDI_MGPIO5A_H2F_B                  : out   std_logic;
          SPI0_SDO_MGPIO6A_H2F_A                  : out   std_logic;
          SPI0_SDO_MGPIO6A_H2F_B                  : out   std_logic;
          SPI0_SS0_MGPIO7A_H2F_A                  : out   std_logic;
          SPI0_SS0_MGPIO7A_H2F_B                  : out   std_logic;
          SPI0_SS1_MGPIO8A_H2F_A                  : out   std_logic;
          SPI0_SS1_MGPIO8A_H2F_B                  : out   std_logic;
          SPI0_SS2_MGPIO9A_H2F_A                  : out   std_logic;
          SPI0_SS2_MGPIO9A_H2F_B                  : out   std_logic;
          SPI0_SS3_MGPIO10A_H2F_A                 : out   std_logic;
          SPI0_SS3_MGPIO10A_H2F_B                 : out   std_logic;
          SPI0_SS4_MGPIO19A_H2F_A                 : out   std_logic;
          SPI0_SS5_MGPIO20A_H2F_A                 : out   std_logic;
          SPI0_SS6_MGPIO21A_H2F_A                 : out   std_logic;
          SPI0_SS7_MGPIO22A_H2F_A                 : out   std_logic;
          SPI1_CLK_OUT                            : out   std_logic;
          SPI1_SDI_MGPIO11A_H2F_A                 : out   std_logic;
          SPI1_SDI_MGPIO11A_H2F_B                 : out   std_logic;
          SPI1_SDO_MGPIO12A_H2F_A                 : out   std_logic;
          SPI1_SDO_MGPIO12A_H2F_B                 : out   std_logic;
          SPI1_SS0_MGPIO13A_H2F_A                 : out   std_logic;
          SPI1_SS0_MGPIO13A_H2F_B                 : out   std_logic;
          SPI1_SS1_MGPIO14A_H2F_A                 : out   std_logic;
          SPI1_SS1_MGPIO14A_H2F_B                 : out   std_logic;
          SPI1_SS2_MGPIO15A_H2F_A                 : out   std_logic;
          SPI1_SS2_MGPIO15A_H2F_B                 : out   std_logic;
          SPI1_SS3_MGPIO16A_H2F_A                 : out   std_logic;
          SPI1_SS3_MGPIO16A_H2F_B                 : out   std_logic;
          SPI1_SS4_MGPIO17A_H2F_A                 : out   std_logic;
          SPI1_SS5_MGPIO18A_H2F_A                 : out   std_logic;
          SPI1_SS6_MGPIO23A_H2F_A                 : out   std_logic;
          SPI1_SS7_MGPIO24A_H2F_A                 : out   std_logic;
          TCGF                                    : out   std_logic_vector(9 downto 0);
          TRACECLK                                : out   std_logic;
          TRACEDATA                               : out   std_logic_vector(3 downto 0);
          TX_CLK                                  : out   std_logic;
          TX_ENF                                  : out   std_logic;
          TX_ERRF                                 : out   std_logic;
          TXCTL_EN_RIF                            : out   std_logic;
          TXD_RIF                                 : out   std_logic_vector(3 downto 0);
          TXDF                                    : out   std_logic_vector(7 downto 0);
          TXEV                                    : out   std_logic;
          WDOGTIMEOUT                             : out   std_logic;
          F_ARREADY_HREADYOUT1                    : out   std_logic;
          F_AWREADY_HREADYOUT0                    : out   std_logic;
          F_BID                                   : out   std_logic_vector(3 downto 0);
          F_BRESP_HRESP0                          : out   std_logic_vector(1 downto 0);
          F_BVALID                                : out   std_logic;
          F_RDATA_HRDATA01                        : out   std_logic_vector(63 downto 0);
          F_RID                                   : out   std_logic_vector(3 downto 0);
          F_RLAST                                 : out   std_logic;
          F_RRESP_HRESP1                          : out   std_logic_vector(1 downto 0);
          F_RVALID                                : out   std_logic;
          F_WREADY                                : out   std_logic;
          MDDR_FABRIC_PRDATA                      : out   std_logic_vector(15 downto 0);
          MDDR_FABRIC_PREADY                      : out   std_logic;
          MDDR_FABRIC_PSLVERR                     : out   std_logic;
          CAN_RXBUS_F2H_SCP                       : in    std_logic := 'U';
          CAN_TX_EBL_F2H_SCP                      : in    std_logic := 'U';
          CAN_TXBUS_F2H_SCP                       : in    std_logic := 'U';
          COLF                                    : in    std_logic := 'U';
          CRSF                                    : in    std_logic := 'U';
          F2_DMAREADY                             : in    std_logic_vector(1 downto 0) := (others => 'U');
          F2H_INTERRUPT                           : in    std_logic_vector(15 downto 0) := (others => 'U');
          F2HCALIB                                : in    std_logic := 'U';
          F_DMAREADY                              : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_FM0_ADDR                              : in    std_logic_vector(31 downto 0) := (others => 'U');
          F_FM0_ENABLE                            : in    std_logic := 'U';
          F_FM0_MASTLOCK                          : in    std_logic := 'U';
          F_FM0_READY                             : in    std_logic := 'U';
          F_FM0_SEL                               : in    std_logic := 'U';
          F_FM0_SIZE                              : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_FM0_TRANS1                            : in    std_logic := 'U';
          F_FM0_WDATA                             : in    std_logic_vector(31 downto 0) := (others => 'U');
          F_FM0_WRITE                             : in    std_logic := 'U';
          F_HM0_RDATA                             : in    std_logic_vector(31 downto 0) := (others => 'U');
          F_HM0_READY                             : in    std_logic := 'U';
          F_HM0_RESP                              : in    std_logic := 'U';
          FAB_AVALID                              : in    std_logic := 'U';
          FAB_HOSTDISCON                          : in    std_logic := 'U';
          FAB_IDDIG                               : in    std_logic := 'U';
          FAB_LINESTATE                           : in    std_logic_vector(1 downto 0) := (others => 'U');
          FAB_M3_RESET_N                          : in    std_logic := 'U';
          FAB_PLL_LOCK                            : in    std_logic := 'U';
          FAB_RXACTIVE                            : in    std_logic := 'U';
          FAB_RXERROR                             : in    std_logic := 'U';
          FAB_RXVALID                             : in    std_logic := 'U';
          FAB_RXVALIDH                            : in    std_logic := 'U';
          FAB_SESSEND                             : in    std_logic := 'U';
          FAB_TXREADY                             : in    std_logic := 'U';
          FAB_VBUSVALID                           : in    std_logic := 'U';
          FAB_VSTATUS                             : in    std_logic_vector(7 downto 0) := (others => 'U');
          FAB_XDATAIN                             : in    std_logic_vector(7 downto 0) := (others => 'U');
          GTX_CLKPF                               : in    std_logic := 'U';
          I2C0_BCLK                               : in    std_logic := 'U';
          I2C0_SCL_F2H_SCP                        : in    std_logic := 'U';
          I2C0_SDA_F2H_SCP                        : in    std_logic := 'U';
          I2C1_BCLK                               : in    std_logic := 'U';
          I2C1_SCL_F2H_SCP                        : in    std_logic := 'U';
          I2C1_SDA_F2H_SCP                        : in    std_logic := 'U';
          MDIF                                    : in    std_logic := 'U';
          MGPIO0A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO10A_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO11A_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO11B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO12A_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO13A_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO14A_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO15A_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO16A_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO17B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO18B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO19B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO1A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO20B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO21B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO22B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO24B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO25B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO26B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO27B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO28B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO29B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO2A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO30B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO31B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO3A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO4A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO5A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO6A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO7A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO8A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO9A_F2H_GPIN                        : in    std_logic := 'U';
          MMUART0_CTS_F2H_SCP                     : in    std_logic := 'U';
          MMUART0_DCD_F2H_SCP                     : in    std_logic := 'U';
          MMUART0_DSR_F2H_SCP                     : in    std_logic := 'U';
          MMUART0_DTR_F2H_SCP                     : in    std_logic := 'U';
          MMUART0_RI_F2H_SCP                      : in    std_logic := 'U';
          MMUART0_RTS_F2H_SCP                     : in    std_logic := 'U';
          MMUART0_RXD_F2H_SCP                     : in    std_logic := 'U';
          MMUART0_SCK_F2H_SCP                     : in    std_logic := 'U';
          MMUART0_TXD_F2H_SCP                     : in    std_logic := 'U';
          MMUART1_CTS_F2H_SCP                     : in    std_logic := 'U';
          MMUART1_DCD_F2H_SCP                     : in    std_logic := 'U';
          MMUART1_DSR_F2H_SCP                     : in    std_logic := 'U';
          MMUART1_RI_F2H_SCP                      : in    std_logic := 'U';
          MMUART1_RTS_F2H_SCP                     : in    std_logic := 'U';
          MMUART1_RXD_F2H_SCP                     : in    std_logic := 'U';
          MMUART1_SCK_F2H_SCP                     : in    std_logic := 'U';
          MMUART1_TXD_F2H_SCP                     : in    std_logic := 'U';
          PER2_FABRIC_PRDATA                      : in    std_logic_vector(31 downto 0) := (others => 'U');
          PER2_FABRIC_PREADY                      : in    std_logic := 'U';
          PER2_FABRIC_PSLVERR                     : in    std_logic := 'U';
          RCGF                                    : in    std_logic_vector(9 downto 0) := (others => 'U');
          RX_CLKPF                                : in    std_logic := 'U';
          RX_DVF                                  : in    std_logic := 'U';
          RX_ERRF                                 : in    std_logic := 'U';
          RX_EV                                   : in    std_logic := 'U';
          RXDF                                    : in    std_logic_vector(7 downto 0) := (others => 'U');
          SLEEPHOLDREQ                            : in    std_logic := 'U';
          SMBALERT_NI0                            : in    std_logic := 'U';
          SMBALERT_NI1                            : in    std_logic := 'U';
          SMBSUS_NI0                              : in    std_logic := 'U';
          SMBSUS_NI1                              : in    std_logic := 'U';
          SPI0_CLK_IN                             : in    std_logic := 'U';
          SPI0_SDI_F2H_SCP                        : in    std_logic := 'U';
          SPI0_SDO_F2H_SCP                        : in    std_logic := 'U';
          SPI0_SS0_F2H_SCP                        : in    std_logic := 'U';
          SPI0_SS1_F2H_SCP                        : in    std_logic := 'U';
          SPI0_SS2_F2H_SCP                        : in    std_logic := 'U';
          SPI0_SS3_F2H_SCP                        : in    std_logic := 'U';
          SPI1_CLK_IN                             : in    std_logic := 'U';
          SPI1_SDI_F2H_SCP                        : in    std_logic := 'U';
          SPI1_SDO_F2H_SCP                        : in    std_logic := 'U';
          SPI1_SS0_F2H_SCP                        : in    std_logic := 'U';
          SPI1_SS1_F2H_SCP                        : in    std_logic := 'U';
          SPI1_SS2_F2H_SCP                        : in    std_logic := 'U';
          SPI1_SS3_F2H_SCP                        : in    std_logic := 'U';
          TX_CLKPF                                : in    std_logic := 'U';
          USER_MSS_GPIO_RESET_N                   : in    std_logic := 'U';
          USER_MSS_RESET_N                        : in    std_logic := 'U';
          XCLK_FAB                                : in    std_logic := 'U';
          CLK_BASE                                : in    std_logic := 'U';
          CLK_MDDR_APB                            : in    std_logic := 'U';
          F_ARADDR_HADDR1                         : in    std_logic_vector(31 downto 0) := (others => 'U');
          F_ARBURST_HTRANS1                       : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_ARID_HSEL1                            : in    std_logic_vector(3 downto 0) := (others => 'U');
          F_ARLEN_HBURST1                         : in    std_logic_vector(3 downto 0) := (others => 'U');
          F_ARLOCK_HMASTLOCK1                     : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_ARSIZE_HSIZE1                         : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_ARVALID_HWRITE1                       : in    std_logic := 'U';
          F_AWADDR_HADDR0                         : in    std_logic_vector(31 downto 0) := (others => 'U');
          F_AWBURST_HTRANS0                       : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_AWID_HSEL0                            : in    std_logic_vector(3 downto 0) := (others => 'U');
          F_AWLEN_HBURST0                         : in    std_logic_vector(3 downto 0) := (others => 'U');
          F_AWLOCK_HMASTLOCK0                     : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_AWSIZE_HSIZE0                         : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_AWVALID_HWRITE0                       : in    std_logic := 'U';
          F_BREADY                                : in    std_logic := 'U';
          F_RMW_AXI                               : in    std_logic := 'U';
          F_RREADY                                : in    std_logic := 'U';
          F_WDATA_HWDATA01                        : in    std_logic_vector(63 downto 0) := (others => 'U');
          F_WID_HREADY01                          : in    std_logic_vector(3 downto 0) := (others => 'U');
          F_WLAST                                 : in    std_logic := 'U';
          F_WSTRB                                 : in    std_logic_vector(7 downto 0) := (others => 'U');
          F_WVALID                                : in    std_logic := 'U';
          FPGA_MDDR_ARESET_N                      : in    std_logic := 'U';
          MDDR_FABRIC_PADDR                       : in    std_logic_vector(10 downto 2) := (others => 'U');
          MDDR_FABRIC_PENABLE                     : in    std_logic := 'U';
          MDDR_FABRIC_PSEL                        : in    std_logic := 'U';
          MDDR_FABRIC_PWDATA                      : in    std_logic_vector(15 downto 0) := (others => 'U');
          MDDR_FABRIC_PWRITE                      : in    std_logic := 'U';
          PRESET_N                                : in    std_logic := 'U';
          CAN_RXBUS_USBA_DATA1_MGPIO3A_IN         : in    std_logic := 'U';
          CAN_TX_EBL_USBA_DATA2_MGPIO4A_IN        : in    std_logic := 'U';
          CAN_TXBUS_USBA_DATA0_MGPIO2A_IN         : in    std_logic := 'U';
          DM_IN                                   : in    std_logic_vector(2 downto 0) := (others => 'U');
          DRAM_DQ_IN                              : in    std_logic_vector(17 downto 0) := (others => 'U');
          DRAM_DQS_IN                             : in    std_logic_vector(2 downto 0) := (others => 'U');
          DRAM_FIFO_WE_IN                         : in    std_logic_vector(1 downto 0) := (others => 'U');
          I2C0_SCL_USBC_DATA1_MGPIO31B_IN         : in    std_logic := 'U';
          I2C0_SDA_USBC_DATA0_MGPIO30B_IN         : in    std_logic := 'U';
          I2C1_SCL_USBA_DATA4_MGPIO1A_IN          : in    std_logic := 'U';
          I2C1_SDA_USBA_DATA3_MGPIO0A_IN          : in    std_logic := 'U';
          MGPIO25A_IN                             : in    std_logic := 'U';
          MGPIO26A_IN                             : in    std_logic := 'U';
          MMUART0_CTS_USBC_DATA7_MGPIO19B_IN      : in    std_logic := 'U';
          MMUART0_DCD_MGPIO22B_IN                 : in    std_logic := 'U';
          MMUART0_DSR_MGPIO20B_IN                 : in    std_logic := 'U';
          MMUART0_DTR_USBC_DATA6_MGPIO18B_IN      : in    std_logic := 'U';
          MMUART0_RI_MGPIO21B_IN                  : in    std_logic := 'U';
          MMUART0_RTS_USBC_DATA5_MGPIO17B_IN      : in    std_logic := 'U';
          MMUART0_RXD_USBC_STP_MGPIO28B_IN        : in    std_logic := 'U';
          MMUART0_SCK_USBC_NXT_MGPIO29B_IN        : in    std_logic := 'U';
          MMUART0_TXD_USBC_DIR_MGPIO27B_IN        : in    std_logic := 'U';
          MMUART1_CTS_MGPIO13B_IN                 : in    std_logic := 'U';
          MMUART1_DCD_MGPIO16B_IN                 : in    std_logic := 'U';
          MMUART1_DSR_MGPIO14B_IN                 : in    std_logic := 'U';
          MMUART1_DTR_MGPIO12B_IN                 : in    std_logic := 'U';
          MMUART1_RI_MGPIO15B_IN                  : in    std_logic := 'U';
          MMUART1_RTS_MGPIO11B_IN                 : in    std_logic := 'U';
          MMUART1_RXD_USBC_DATA3_MGPIO26B_IN      : in    std_logic := 'U';
          MMUART1_SCK_USBC_DATA4_MGPIO25B_IN      : in    std_logic := 'U';
          MMUART1_TXD_USBC_DATA2_MGPIO24B_IN      : in    std_logic := 'U';
          RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_IN     : in    std_logic := 'U';
          RGMII_MDC_RMII_MDC_IN                   : in    std_logic := 'U';
          RGMII_MDIO_RMII_MDIO_USBB_DATA7_IN      : in    std_logic := 'U';
          RGMII_RX_CLK_IN                         : in    std_logic := 'U';
          RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_IN  : in    std_logic := 'U';
          RGMII_RXD0_RMII_RXD0_USBB_DATA0_IN      : in    std_logic := 'U';
          RGMII_RXD1_RMII_RXD1_USBB_DATA1_IN      : in    std_logic := 'U';
          RGMII_RXD2_RMII_RX_ER_USBB_DATA3_IN     : in    std_logic := 'U';
          RGMII_RXD3_USBB_DATA4_IN                : in    std_logic := 'U';
          RGMII_TX_CLK_IN                         : in    std_logic := 'U';
          RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_IN     : in    std_logic := 'U';
          RGMII_TXD0_RMII_TXD0_USBB_DIR_IN        : in    std_logic := 'U';
          RGMII_TXD1_RMII_TXD1_USBB_STP_IN        : in    std_logic := 'U';
          RGMII_TXD2_USBB_DATA5_IN                : in    std_logic := 'U';
          RGMII_TXD3_USBB_DATA6_IN                : in    std_logic := 'U';
          SPI0_SCK_USBA_XCLK_IN                   : in    std_logic := 'U';
          SPI0_SDI_USBA_DIR_MGPIO5A_IN            : in    std_logic := 'U';
          SPI0_SDO_USBA_STP_MGPIO6A_IN            : in    std_logic := 'U';
          SPI0_SS0_USBA_NXT_MGPIO7A_IN            : in    std_logic := 'U';
          SPI0_SS1_USBA_DATA5_MGPIO8A_IN          : in    std_logic := 'U';
          SPI0_SS2_USBA_DATA6_MGPIO9A_IN          : in    std_logic := 'U';
          SPI0_SS3_USBA_DATA7_MGPIO10A_IN         : in    std_logic := 'U';
          SPI0_SS4_MGPIO19A_IN                    : in    std_logic := 'U';
          SPI0_SS5_MGPIO20A_IN                    : in    std_logic := 'U';
          SPI0_SS6_MGPIO21A_IN                    : in    std_logic := 'U';
          SPI0_SS7_MGPIO22A_IN                    : in    std_logic := 'U';
          SPI1_SCK_IN                             : in    std_logic := 'U';
          SPI1_SDI_MGPIO11A_IN                    : in    std_logic := 'U';
          SPI1_SDO_MGPIO12A_IN                    : in    std_logic := 'U';
          SPI1_SS0_MGPIO13A_IN                    : in    std_logic := 'U';
          SPI1_SS1_MGPIO14A_IN                    : in    std_logic := 'U';
          SPI1_SS2_MGPIO15A_IN                    : in    std_logic := 'U';
          SPI1_SS3_MGPIO16A_IN                    : in    std_logic := 'U';
          SPI1_SS4_MGPIO17A_IN                    : in    std_logic := 'U';
          SPI1_SS5_MGPIO18A_IN                    : in    std_logic := 'U';
          SPI1_SS6_MGPIO23A_IN                    : in    std_logic := 'U';
          SPI1_SS7_MGPIO24A_IN                    : in    std_logic := 'U';
          USBC_XCLK_IN                            : in    std_logic := 'U';
          CAN_RXBUS_USBA_DATA1_MGPIO3A_OUT        : out   std_logic;
          CAN_TX_EBL_USBA_DATA2_MGPIO4A_OUT       : out   std_logic;
          CAN_TXBUS_USBA_DATA0_MGPIO2A_OUT        : out   std_logic;
          DRAM_ADDR                               : out   std_logic_vector(15 downto 0);
          DRAM_BA                                 : out   std_logic_vector(2 downto 0);
          DRAM_CASN                               : out   std_logic;
          DRAM_CKE                                : out   std_logic;
          DRAM_CLK                                : out   std_logic;
          DRAM_CSN                                : out   std_logic;
          DRAM_DM_RDQS_OUT                        : out   std_logic_vector(2 downto 0);
          DRAM_DQ_OUT                             : out   std_logic_vector(17 downto 0);
          DRAM_DQS_OUT                            : out   std_logic_vector(2 downto 0);
          DRAM_FIFO_WE_OUT                        : out   std_logic_vector(1 downto 0);
          DRAM_ODT                                : out   std_logic;
          DRAM_RASN                               : out   std_logic;
          DRAM_RSTN                               : out   std_logic;
          DRAM_WEN                                : out   std_logic;
          I2C0_SCL_USBC_DATA1_MGPIO31B_OUT        : out   std_logic;
          I2C0_SDA_USBC_DATA0_MGPIO30B_OUT        : out   std_logic;
          I2C1_SCL_USBA_DATA4_MGPIO1A_OUT         : out   std_logic;
          I2C1_SDA_USBA_DATA3_MGPIO0A_OUT         : out   std_logic;
          MGPIO25A_OUT                            : out   std_logic;
          MGPIO26A_OUT                            : out   std_logic;
          MMUART0_CTS_USBC_DATA7_MGPIO19B_OUT     : out   std_logic;
          MMUART0_DCD_MGPIO22B_OUT                : out   std_logic;
          MMUART0_DSR_MGPIO20B_OUT                : out   std_logic;
          MMUART0_DTR_USBC_DATA6_MGPIO18B_OUT     : out   std_logic;
          MMUART0_RI_MGPIO21B_OUT                 : out   std_logic;
          MMUART0_RTS_USBC_DATA5_MGPIO17B_OUT     : out   std_logic;
          MMUART0_RXD_USBC_STP_MGPIO28B_OUT       : out   std_logic;
          MMUART0_SCK_USBC_NXT_MGPIO29B_OUT       : out   std_logic;
          MMUART0_TXD_USBC_DIR_MGPIO27B_OUT       : out   std_logic;
          MMUART1_CTS_MGPIO13B_OUT                : out   std_logic;
          MMUART1_DCD_MGPIO16B_OUT                : out   std_logic;
          MMUART1_DSR_MGPIO14B_OUT                : out   std_logic;
          MMUART1_DTR_MGPIO12B_OUT                : out   std_logic;
          MMUART1_RI_MGPIO15B_OUT                 : out   std_logic;
          MMUART1_RTS_MGPIO11B_OUT                : out   std_logic;
          MMUART1_RXD_USBC_DATA3_MGPIO26B_OUT     : out   std_logic;
          MMUART1_SCK_USBC_DATA4_MGPIO25B_OUT     : out   std_logic;
          MMUART1_TXD_USBC_DATA2_MGPIO24B_OUT     : out   std_logic;
          RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OUT    : out   std_logic;
          RGMII_MDC_RMII_MDC_OUT                  : out   std_logic;
          RGMII_MDIO_RMII_MDIO_USBB_DATA7_OUT     : out   std_logic;
          RGMII_RX_CLK_OUT                        : out   std_logic;
          RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OUT : out   std_logic;
          RGMII_RXD0_RMII_RXD0_USBB_DATA0_OUT     : out   std_logic;
          RGMII_RXD1_RMII_RXD1_USBB_DATA1_OUT     : out   std_logic;
          RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OUT    : out   std_logic;
          RGMII_RXD3_USBB_DATA4_OUT               : out   std_logic;
          RGMII_TX_CLK_OUT                        : out   std_logic;
          RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OUT    : out   std_logic;
          RGMII_TXD0_RMII_TXD0_USBB_DIR_OUT       : out   std_logic;
          RGMII_TXD1_RMII_TXD1_USBB_STP_OUT       : out   std_logic;
          RGMII_TXD2_USBB_DATA5_OUT               : out   std_logic;
          RGMII_TXD3_USBB_DATA6_OUT               : out   std_logic;
          SPI0_SCK_USBA_XCLK_OUT                  : out   std_logic;
          SPI0_SDI_USBA_DIR_MGPIO5A_OUT           : out   std_logic;
          SPI0_SDO_USBA_STP_MGPIO6A_OUT           : out   std_logic;
          SPI0_SS0_USBA_NXT_MGPIO7A_OUT           : out   std_logic;
          SPI0_SS1_USBA_DATA5_MGPIO8A_OUT         : out   std_logic;
          SPI0_SS2_USBA_DATA6_MGPIO9A_OUT         : out   std_logic;
          SPI0_SS3_USBA_DATA7_MGPIO10A_OUT        : out   std_logic;
          SPI0_SS4_MGPIO19A_OUT                   : out   std_logic;
          SPI0_SS5_MGPIO20A_OUT                   : out   std_logic;
          SPI0_SS6_MGPIO21A_OUT                   : out   std_logic;
          SPI0_SS7_MGPIO22A_OUT                   : out   std_logic;
          SPI1_SCK_OUT                            : out   std_logic;
          SPI1_SDI_MGPIO11A_OUT                   : out   std_logic;
          SPI1_SDO_MGPIO12A_OUT                   : out   std_logic;
          SPI1_SS0_MGPIO13A_OUT                   : out   std_logic;
          SPI1_SS1_MGPIO14A_OUT                   : out   std_logic;
          SPI1_SS2_MGPIO15A_OUT                   : out   std_logic;
          SPI1_SS3_MGPIO16A_OUT                   : out   std_logic;
          SPI1_SS4_MGPIO17A_OUT                   : out   std_logic;
          SPI1_SS5_MGPIO18A_OUT                   : out   std_logic;
          SPI1_SS6_MGPIO23A_OUT                   : out   std_logic;
          SPI1_SS7_MGPIO24A_OUT                   : out   std_logic;
          USBC_XCLK_OUT                           : out   std_logic;
          CAN_RXBUS_USBA_DATA1_MGPIO3A_OE         : out   std_logic;
          CAN_TX_EBL_USBA_DATA2_MGPIO4A_OE        : out   std_logic;
          CAN_TXBUS_USBA_DATA0_MGPIO2A_OE         : out   std_logic;
          DM_OE                                   : out   std_logic_vector(2 downto 0);
          DRAM_DQ_OE                              : out   std_logic_vector(17 downto 0);
          DRAM_DQS_OE                             : out   std_logic_vector(2 downto 0);
          I2C0_SCL_USBC_DATA1_MGPIO31B_OE         : out   std_logic;
          I2C0_SDA_USBC_DATA0_MGPIO30B_OE         : out   std_logic;
          I2C1_SCL_USBA_DATA4_MGPIO1A_OE          : out   std_logic;
          I2C1_SDA_USBA_DATA3_MGPIO0A_OE          : out   std_logic;
          MGPIO25A_OE                             : out   std_logic;
          MGPIO26A_OE                             : out   std_logic;
          MMUART0_CTS_USBC_DATA7_MGPIO19B_OE      : out   std_logic;
          MMUART0_DCD_MGPIO22B_OE                 : out   std_logic;
          MMUART0_DSR_MGPIO20B_OE                 : out   std_logic;
          MMUART0_DTR_USBC_DATA6_MGPIO18B_OE      : out   std_logic;
          MMUART0_RI_MGPIO21B_OE                  : out   std_logic;
          MMUART0_RTS_USBC_DATA5_MGPIO17B_OE      : out   std_logic;
          MMUART0_RXD_USBC_STP_MGPIO28B_OE        : out   std_logic;
          MMUART0_SCK_USBC_NXT_MGPIO29B_OE        : out   std_logic;
          MMUART0_TXD_USBC_DIR_MGPIO27B_OE        : out   std_logic;
          MMUART1_CTS_MGPIO13B_OE                 : out   std_logic;
          MMUART1_DCD_MGPIO16B_OE                 : out   std_logic;
          MMUART1_DSR_MGPIO14B_OE                 : out   std_logic;
          MMUART1_DTR_MGPIO12B_OE                 : out   std_logic;
          MMUART1_RI_MGPIO15B_OE                  : out   std_logic;
          MMUART1_RTS_MGPIO11B_OE                 : out   std_logic;
          MMUART1_RXD_USBC_DATA3_MGPIO26B_OE      : out   std_logic;
          MMUART1_SCK_USBC_DATA4_MGPIO25B_OE      : out   std_logic;
          MMUART1_TXD_USBC_DATA2_MGPIO24B_OE      : out   std_logic;
          RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OE     : out   std_logic;
          RGMII_MDC_RMII_MDC_OE                   : out   std_logic;
          RGMII_MDIO_RMII_MDIO_USBB_DATA7_OE      : out   std_logic;
          RGMII_RX_CLK_OE                         : out   std_logic;
          RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OE  : out   std_logic;
          RGMII_RXD0_RMII_RXD0_USBB_DATA0_OE      : out   std_logic;
          RGMII_RXD1_RMII_RXD1_USBB_DATA1_OE      : out   std_logic;
          RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OE     : out   std_logic;
          RGMII_RXD3_USBB_DATA4_OE                : out   std_logic;
          RGMII_TX_CLK_OE                         : out   std_logic;
          RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OE     : out   std_logic;
          RGMII_TXD0_RMII_TXD0_USBB_DIR_OE        : out   std_logic;
          RGMII_TXD1_RMII_TXD1_USBB_STP_OE        : out   std_logic;
          RGMII_TXD2_USBB_DATA5_OE                : out   std_logic;
          RGMII_TXD3_USBB_DATA6_OE                : out   std_logic;
          SPI0_SCK_USBA_XCLK_OE                   : out   std_logic;
          SPI0_SDI_USBA_DIR_MGPIO5A_OE            : out   std_logic;
          SPI0_SDO_USBA_STP_MGPIO6A_OE            : out   std_logic;
          SPI0_SS0_USBA_NXT_MGPIO7A_OE            : out   std_logic;
          SPI0_SS1_USBA_DATA5_MGPIO8A_OE          : out   std_logic;
          SPI0_SS2_USBA_DATA6_MGPIO9A_OE          : out   std_logic;
          SPI0_SS3_USBA_DATA7_MGPIO10A_OE         : out   std_logic;
          SPI0_SS4_MGPIO19A_OE                    : out   std_logic;
          SPI0_SS5_MGPIO20A_OE                    : out   std_logic;
          SPI0_SS6_MGPIO21A_OE                    : out   std_logic;
          SPI0_SS7_MGPIO22A_OE                    : out   std_logic;
          SPI1_SCK_OE                             : out   std_logic;
          SPI1_SDI_MGPIO11A_OE                    : out   std_logic;
          SPI1_SDO_MGPIO12A_OE                    : out   std_logic;
          SPI1_SS0_MGPIO13A_OE                    : out   std_logic;
          SPI1_SS1_MGPIO14A_OE                    : out   std_logic;
          SPI1_SS2_MGPIO15A_OE                    : out   std_logic;
          SPI1_SS3_MGPIO16A_OE                    : out   std_logic;
          SPI1_SS4_MGPIO17A_OE                    : out   std_logic;
          SPI1_SS5_MGPIO18A_OE                    : out   std_logic;
          SPI1_SS6_MGPIO23A_OE                    : out   std_logic;
          SPI1_SS7_MGPIO24A_OE                    : out   std_logic;
          USBC_XCLK_OE                            : out   std_logic
        );
  end component;

    signal N_5, N_5_0, N_9_0, N_9_2, m10_e_0, 
        \MSS_ADLIB_INST_RNO_66\, N_6_0_0, N_3_0, G_8_0_a9_5_4, 
        N_24, m28_0_o3_0, N_7, N_17_mux, G_8_0_5, G_8_0_a9_1, 
        N_19_mux, N_13, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[0]\, 
        G_8_0_a9_4_0, G_8_0_a9_1_0, G_8_0_a9_2_1, N_31, N_6, 
        G_8_0_a9_0_2, G_8_0_a9_2_2, N_25, N_21_3, G_8_0_0, N_19_0, 
        G_24_0_a2_1_1, G_24_0_a3_0_0, G_24_0_a2_1_2, 
        G_24_0_a3_0_2, N_22_1, N_15_2, G_24_0_0_0, G_24_0_o2_1_0, 
        N_23_0, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[7]\, 
        G_21_0_a7_1_1, G_21_0_a7_3_0, G_21_0_a7_4_0, 
        G_21_0_a7_0_0, N_10_0, \MSS_ADLIB_INST_RNO_62\, N_11_0, 
        N_5_2, N_15_1, N_14_0, G_21_0_1_0, N_9_1, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[4]\, 
        G_24_0_a2_1_0, G_24_0_a3_0_1, G_24_0_a2_1, G_24_0_a3_0, 
        N_22_0, N_15_0, G_24_0_0, G_24_0_o2_1, N_23, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[6]\, 
        g0_0_0, g1, G_25_0_0, G_21_0_a7_1_0, G_21_0_a7_3_2, 
        G_21_0_a7_4_2, G_21_0_a7_0, N_10, \MSS_ADLIB_INST_RNO_65\, 
        N_11, N_5_1, N_15, N_14, G_21_0_1, N_9, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[5]\, 
        G_25_0_a3_0_0, G_25_0_a4_1_0, G_25_0_o4_0_0, 
        G_25_0_a3_0_2, N_20_0, N_13_0, G_25_0_0_0, N_21_0, 
        G_25_0_o4_2_0, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[2]\, 
        G_25_0_a3_0_1, G_25_0_a4_1, G_25_0_o4_0, G_25_0_a3_0, 
        N_20, N_21, G_25_0_o4_2, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[1]\, 
        VCC_net_1, GND_net_1 : std_logic;
    signal nc228, nc203, nc265, nc216, nc194, nc151, nc23, nc175, 
        nc250, nc58, nc116, nc74, nc133, nc238, nc167, nc84, nc39, 
        nc72, nc256, nc212, nc205, nc82, nc145, nc181, nc160, 
        nc57, nc156, nc280, nc125, nc211, nc73, nc107, nc329, 
        nc66, nc83, nc9, nc252, nc171, nc54, nc286, nc307, nc135, 
        nc41, nc100, nc270, nc339, nc52, nc251, nc186, nc29, 
        nc269, nc118, nc60, nc141, nc311, nc276, nc193, nc214, 
        nc298, nc282, nc240, nc45, nc53, nc121, nc176, nc220, 
        nc158, nc281, nc209, nc246, nc162, nc11, nc272, nc131, 
        nc254, nc267, nc96, nc79, nc226, nc146, nc230, nc89, 
        nc119, nc48, nc271, nc213, nc300, nc126, nc195, nc188, 
        nc242, nc15, nc308, nc236, nc102, nc304, nc3, nc207, nc47, 
        nc90, nc284, nc222, nc159, nc136, nc241, nc253, nc178, 
        nc306, nc215, nc59, nc221, nc232, nc274, nc18, nc44, 
        nc117, nc189, nc164, nc148, nc42, nc231, nc191, nc255, 
        nc283, nc341, nc317, nc290, nc17, nc2, nc302, nc110, 
        nc128, nc244, nc321, nc43, nc179, nc157, nc36, nc224, 
        nc296, nc273, nc61, nc104, nc138, nc14, nc285, nc303, 
        nc150, nc331, nc196, nc234, nc149, nc12, nc219, nc30, 
        nc243, nc187, nc65, nc7, nc292, nc129, nc275, nc8, nc223, 
        nc13, nc305, nc180, nc26, nc291, nc177, nc139, nc310, 
        nc259, nc245, nc233, nc163, nc318, nc268, nc112, nc68, 
        nc49, nc314, nc217, nc170, nc91, nc225, nc5, nc20, nc198, 
        nc147, nc316, nc67, nc289, nc294, nc152, nc127, nc103, 
        nc235, nc76, nc347, nc208, nc140, nc257, nc86, nc95, 
        nc327, nc120, nc165, nc279, nc137, nc64, nc19, nc312, 
        nc70, nc182, nc62, nc337, nc199, nc80, nc130, nc287, nc98, 
        nc293, nc249, nc114, nc56, nc105, nc63, nc313, nc309, 
        nc172, nc229, nc277, nc97, nc161, nc31, nc340, nc295, 
        nc154, nc50, nc260, nc239, nc142, nc320, nc344, nc315, 
        nc247, nc94, nc197, nc328, nc122, nc266, nc35, nc324, nc4, 
        nc227, nc92, nc101, nc346, nc330, nc184, nc200, nc190, 
        nc166, nc338, nc326, nc132, nc334, nc21, nc237, nc93, 
        nc262, nc69, nc206, nc174, nc38, nc113, nc336, nc218, 
        nc342, nc106, nc261, nc25, nc1, nc322, nc299, nc37, nc202, 
        nc144, nc153, nc46, nc258, nc343, nc71, nc124, nc332, 
        nc81, nc201, nc168, nc323, nc34, nc28, nc115, nc264, 
        nc192, nc319, nc134, nc32, nc40, nc297, nc99, nc75, nc183, 
        nc345, nc333, nc288, nc85, nc27, nc108, nc325, nc16, 
        nc155, nc51, nc301, nc33, nc204, nc173, nc278, nc169, 
        nc78, nc263, nc335, nc24, nc88, nc111, nc55, nc10, nc22, 
        nc210, nc185, nc143, nc248, nc77, nc6, nc109, nc87, nc123
         : std_logic;

begin 


    MSS_ADLIB_INST_RNO_88 : CFG2
      generic map(INIT => x"2")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), Y => G_8_0_a9_2_1);
    
    MSS_ADLIB_INST_RNO_68 : CFG4
      generic map(INIT => x"FFFE")

      port map(A => G_8_0_0, B => N_21_3, C => N_25, D => N_19_0, 
        Y => G_8_0_5);
    
    MSS_ADLIB_INST_RNO_20 : CFG3
      generic map(INIT => x"02")

      port map(A => CoreAPB3_0_APBmslave0_PSELx, B => 
        CoreAPB3_0_APBmslave1_PSELx, C => 
        CoreAPB3_0_APBmslave2_PSELx, Y => G_25_0_a4_1_0);
    
    MSS_ADLIB_INST_RNO_40 : CFG4
      generic map(INIT => x"0002")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), C => 
        CoreAPB3_0_APBmslave0_PADDR(5), D => 
        CoreAPB3_0_APBmslave0_PADDR(4), Y => G_21_0_a7_4_2);
    
    MSS_ADLIB_INST_RNO_23 : CFG3
      generic map(INIT => x"80")

      port map(A => N_5_2, B => N_21_2, C => G_21_0_a7_0_0, Y => 
        N_9_1);
    
    MSS_ADLIB_INST_RNO_35 : CFG4
      generic map(INIT => x"7520")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_781, D => N_733, Y
         => N_9_0);
    
    MSS_ADLIB_INST_RNIA523 : CFG2
      generic map(INIT => x"1")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), Y => N_31);
    
    MSS_ADLIB_INST_RNO_43 : CFG3
      generic map(INIT => x"40")

      port map(A => CoreAPB3_0_APBmslave1_PSELx, B => 
        CoreAPB3_0_APBmslave2_PSELx, C => 
        CoreAPB3_0_APBmslave2_PRDATA(1), Y => g1);
    
    MSS_ADLIB_INST_RNO_29 : CFG4
      generic map(INIT => x"FCFE")

      port map(A => N_21_2, B => N_10_0, C => N_11_0, D => 
        \MSS_ADLIB_INST_RNO_62\, Y => G_21_0_1_0);
    
    MSS_ADLIB_INST_RNO_34 : CFG3
      generic map(INIT => x"54")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_62, Y => 
        G_25_0_a3_0_2);
    
    MSS_ADLIB_INST_RNO_21 : CFG4
      generic map(INIT => x"CCEC")

      port map(A => CoreAPB3_0_APBmslave2_PSELx, B => N_15_0, C
         => CoreAPB3_0_APBmslave2_PRDATA(6), D => 
        CoreAPB3_0_APBmslave1_PSELx, Y => G_24_0_0);
    
    MSS_ADLIB_INST_RNO_70 : CFG4
      generic map(INIT => x"3020")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => 
        CoreAPB3_0_APBmslave0_PADDR(5), C => N_31, D => N_62, Y
         => G_8_0_a9_1);
    
    MSS_ADLIB_INST_RNO_49 : CFG4
      generic map(INIT => x"0400")

      port map(A => GEN_N_3_mux_0, B => 
        CoreAPB3_0_APBmslave1_PSELx, C => 
        CoreAPB3_0_APBmslave2_PSELx, D => G_24_0_a2_1_1, Y => 
        N_15_2);
    
    MSS_ADLIB_INST_RNO_41 : CFG4
      generic map(INIT => x"00E2")

      port map(A => PRDATA_o_2_am_0, B => \MSS_ADLIB_INST_RNO_66\, 
        C => PRDATA_o_2_bm_0, D => PRDATA_o_sn_N_6_mux, Y => 
        N_17_mux);
    
    MSS_ADLIB_INST_RNO_73 : CFG2
      generic map(INIT => x"2")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), Y => G_25_0_a3_0_1);
    
    MSS_ADLIB_INST_RNO : CFG4
      generic map(INIT => x"11B1")

      port map(A => CoreAPB3_0_APBmslave2_PSELx, B => N_13, C => 
        CoreAPB3_0_APBmslave2_PRDATA(0), D => 
        CoreAPB3_0_APBmslave1_PSELx, Y => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[0]\);
    
    MSS_ADLIB_INST_RNO_22 : CFG4
      generic map(INIT => x"CCEC")

      port map(A => CoreAPB3_0_APBmslave2_PSELx, B => N_15_2, C
         => CoreAPB3_0_APBmslave2_PRDATA(7), D => 
        CoreAPB3_0_APBmslave1_PSELx, Y => G_24_0_0_0);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    MSS_ADLIB_INST_RNO_36 : CFG3
      generic map(INIT => x"54")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_62, Y => 
        G_24_0_a3_0);
    
    MSS_ADLIB_INST_RNO_79 : CFG2
      generic map(INIT => x"8")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        sync_update, Y => m10_e_0);
    
    MSS_ADLIB_INST_RNO_50 : CFG4
      generic map(INIT => x"B1A0")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(5), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), C => N_939, D => N_731, Y
         => N_5_2);
    
    MSS_ADLIB_INST_RNO_42 : CFG4
      generic map(INIT => x"1011")

      port map(A => m28_0_o3_0, B => G_8_0_5, C => N_7, D => 
        G_8_0_a9_1, Y => N_19_mux);
    
    MSS_ADLIB_INST_RNO_71 : CFG2
      generic map(INIT => x"2")

      port map(A => CONFIG_regrx(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), Y => G_24_0_a2_1_0);
    
    MSS_ADLIB_INST_RNO_53 : CFG3
      generic map(INIT => x"54")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_62, Y => 
        G_21_0_a7_0);
    
    MSS_ADLIB_INST_RNO_27 : CFG4
      generic map(INIT => x"FFEC")

      port map(A => period_reg(6), B => N_22_0, C => un9_psel, D
         => PRDATA_regif_iv_0_0(6), Y => G_24_0_o2_1);
    
    MSS_ADLIB_INST_RNO_10 : CFG4
      generic map(INIT => x"8000")

      port map(A => N_62, B => N_21_2, C => G_21_0_a7_4_0, D => 
        N_779, Y => N_15_1);
    
    MSS_ADLIB_INST_RNO_38 : CFG3
      generic map(INIT => x"54")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_62, Y => 
        G_24_0_a3_0_2);
    
    MSS_ADLIB_INST_RNO_59 : CFG4
      generic map(INIT => x"8000")

      port map(A => PWM_STRETCH(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), C => G_24_0_a3_0_0, D => 
        N_60, Y => N_22_1);
    
    MSS_ADLIB_INST_RNO_72 : CFG2
      generic map(INIT => x"2")

      port map(A => CONFIG_regrx(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), Y => G_24_0_a2_1_1);
    
    MSS_ADLIB_INST_RNO_47 : CFG3
      generic map(INIT => x"80")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => N_60, C
         => PWM_STRETCH(5), Y => G_21_0_a7_3_2);
    
    MSS_ADLIB_INST_RNO_13 : CFG4
      generic map(INIT => x"AAAE")

      port map(A => g1, B => g0_0_0, C => N_86_mux_0, D => 
        PRDATA_o_sn_N_6_mux, Y => G_25_0_0);
    
    MSS_ADLIB_INST_RNO_51 : CFG3
      generic map(INIT => x"54")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_62, Y => 
        G_21_0_a7_0_0);
    
    MSS_ADLIB_INST_RNO_19 : CFG3
      generic map(INIT => x"02")

      port map(A => CoreAPB3_0_APBmslave0_PSELx, B => 
        CoreAPB3_0_APBmslave1_PSELx, C => 
        CoreAPB3_0_APBmslave2_PSELx, Y => G_25_0_a4_1);
    
    MSS_ADLIB_INST_RNO_80 : CFG4
      generic map(INIT => x"2000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => 
        CoreAPB3_0_APBmslave0_PADDR(5), D => 
        CoreAPB3_0_APBmslave0_PADDR(2), Y => G_8_0_a9_5_4);
    
    MSS_ADLIB_INST_RNO_60 : CFG3
      generic map(INIT => x"40")

      port map(A => CoreAPB3_0_APBmslave1_PSELx, B => 
        CoreAPB3_0_APBmslave2_PSELx, C => 
        CoreAPB3_0_APBmslave2_PRDATA(4), Y => N_10_0);
    
    MSS_ADLIB_INST_RNO_11 : CFG4
      generic map(INIT => x"8000")

      port map(A => N_62, B => N_21_1, C => G_21_0_a7_4_2, D => 
        N_780, Y => N_15);
    
    MSS_ADLIB_INST_RNO_77 : CFG2
      generic map(INIT => x"2")

      port map(A => CONFIG_regrx(4), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), Y => G_21_0_a7_1_1);
    
    MSS_ADLIB_INST_RNO_52 : CFG4
      generic map(INIT => x"B1A0")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(5), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), C => N_940, D => N_732, Y
         => N_5_1);
    
    MSS_ADLIB_INST_RNO_83 : CFG4
      generic map(INIT => x"0800")

      port map(A => N_6, B => N_31, C => 
        CoreAPB3_0_APBmslave0_PADDR(4), D => G_8_0_a9_1_0, Y => 
        N_21_3);
    
    MSS_ADLIB_INST_RNO_63 : CFG3
      generic map(INIT => x"40")

      port map(A => CoreAPB3_0_APBmslave1_PSELx, B => 
        CoreAPB3_0_APBmslave2_PSELx, C => 
        CoreAPB3_0_APBmslave2_PRDATA(5), Y => N_10);
    
    MSS_ADLIB_INST_RNO_12 : CFG4
      generic map(INIT => x"5F1B")

      port map(A => CoreAPB3_0_APBmslave1_PSELx, B => 
        CoreAPB3_0_APBmslave0_PSELx, C => N_17_mux, D => N_19_mux, 
        Y => N_13);
    
    MSS_ADLIB_INST_RNO_89 : CFG3
      generic map(INIT => x"80")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => N_60, C
         => PWM_STRETCH(0), Y => G_8_0_a9_2_2);
    
    MSS_ADLIB_INST_RNO_69 : CFG3
      generic map(INIT => x"D8")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(2), B => N_6_0_0, 
        C => N_3_0, Y => N_7);
    
    MSS_ADLIB_INST_RNO_2 : CFG4
      generic map(INIT => x"FFFE")

      port map(A => N_15_1, B => N_14_0, C => N_9_1, D => 
        G_21_0_1_0, Y => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[4]\);
    
    MSS_ADLIB_INST_RNO_90 : CFG3
      generic map(INIT => x"B8")

      port map(A => period_reg(0), B => 
        CoreAPB3_0_APBmslave0_PADDR(2), C => prescale_reg(0), Y
         => N_6);
    
    MSS_ADLIB_INST_RNO_57 : CFG4
      generic map(INIT => x"8000")

      port map(A => PWM_STRETCH(2), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), C => G_25_0_a3_0_0, D => 
        N_60, Y => N_20_0);
    
    MSS_ADLIB_INST_RNO_81 : CFG4
      generic map(INIT => x"8000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => 
        CoreAPB3_0_APBmslave0_PADDR(5), C => N_31, D => 
        PRDATA_generated_15_2_0_wmux_0_Y_0, Y => N_24);
    
    MSS_ADLIB_INST_RNO_61 : CFG4
      generic map(INIT => x"0400")

      port map(A => GEN_N_3_mux_0, B => 
        CoreAPB3_0_APBmslave1_PSELx, C => 
        CoreAPB3_0_APBmslave2_PSELx, D => G_21_0_a7_1_1, Y => 
        N_11_0);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    MSS_ADLIB_INST_RNO_4 : CFG4
      generic map(INIT => x"FCF8")

      port map(A => N_23, B => G_24_0_a2_1, C => G_24_0_0, D => 
        G_24_0_o2_1, Y => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[6]\);
    
    MSS_ADLIB_INST_RNO_93 : CFG4
      generic map(INIT => x"0002")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), C => 
        CoreAPB3_0_APBmslave0_PADDR(5), D => 
        CoreAPB3_0_APBmslave0_PADDR(4), Y => G_8_0_a9_0_2);
    
    MSS_ADLIB_INST_RNO_17 : CFG4
      generic map(INIT => x"2000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), C => N_21_2, D => 
        G_21_0_a7_3_0, Y => N_14_0);
    
    MSS_ADLIB_INST_RNO_82 : CFG4
      generic map(INIT => x"EAC0")

      port map(A => G_8_0_a9_2_1, B => pwm_enable_reg(1), C => 
        un11_psel, D => G_8_0_a9_2_2, Y => G_8_0_0);
    
    MSS_ADLIB_INST_RNO_62 : CFG3
      generic map(INIT => x"15")

      port map(A => PRDATA_regif_iv_0_0(4), B => period_reg(4), C
         => un9_psel, Y => \MSS_ADLIB_INST_RNO_62\);
    
    MSS_ADLIB_INST_RNO_91 : CFG2
      generic map(INIT => x"1")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(5), B => 
        CoreAPB3_0_APBmslave0_PADDR(3), Y => G_8_0_a9_1_0);
    
    MSS_ADLIB_INST_RNO_7 : CFG4
      generic map(INIT => x"8D00")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(5), B => N_937, C
         => N_5_0, D => G_25_0_a3_0_2, Y => N_21_0);
    
    MSS_ADLIB_INST_RNO_87 : CFG3
      generic map(INIT => x"1D")

      port map(A => pwm_posedge_reg_0, B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => pwm_posedge_reg_16, 
        Y => N_3_0);
    
    MSS_ADLIB_INST_RNO_67 : CFG4
      generic map(INIT => x"FF40")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => m10_e_0, 
        C => G_8_0_a9_5_4, D => N_24, Y => m28_0_o3_0);
    
    MSS_ADLIB_INST_RNO_92 : CFG2
      generic map(INIT => x"2")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(5), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), Y => G_8_0_a9_4_0);
    
    MSS_ADLIB_INST : MSS_025

              generic map(INIT => "00" & x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000C0300C0300C030000000000000000000000000000000000000000000F00000000F000000000000000000000000000000007FFFFFFFB000001007C33C80400000609080104003FFFFE400000000000410000000000F01C000001FEDF7C010842108421000001FE34001FF80000004000000000200D1007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
         ACT_UBITS => x"FFFFFFFFFFFFFF",
         MEMORYFILE => "ENVM_init.mem", RTC_MAIN_XTL_FREQ => 0.0,
         DDR_CLK_FREQ => 140.0)

      port map(CAN_RXBUS_MGPIO3A_H2F_A => OPEN, 
        CAN_RXBUS_MGPIO3A_H2F_B => OPEN, CAN_TX_EBL_MGPIO4A_H2F_A
         => OPEN, CAN_TX_EBL_MGPIO4A_H2F_B => OPEN, 
        CAN_TXBUS_MGPIO2A_H2F_A => OPEN, CAN_TXBUS_MGPIO2A_H2F_B
         => OPEN, CLK_CONFIG_APB => OPEN, COMMS_INT => OPEN, 
        CONFIG_PRESET_N => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N, 
        EDAC_ERROR(7) => nc228, EDAC_ERROR(6) => nc203, 
        EDAC_ERROR(5) => nc265, EDAC_ERROR(4) => nc216, 
        EDAC_ERROR(3) => nc194, EDAC_ERROR(2) => nc151, 
        EDAC_ERROR(1) => nc23, EDAC_ERROR(0) => nc175, 
        F_FM0_RDATA(31) => nc250, F_FM0_RDATA(30) => nc58, 
        F_FM0_RDATA(29) => nc116, F_FM0_RDATA(28) => nc74, 
        F_FM0_RDATA(27) => nc133, F_FM0_RDATA(26) => nc238, 
        F_FM0_RDATA(25) => nc167, F_FM0_RDATA(24) => nc84, 
        F_FM0_RDATA(23) => nc39, F_FM0_RDATA(22) => nc72, 
        F_FM0_RDATA(21) => nc256, F_FM0_RDATA(20) => nc212, 
        F_FM0_RDATA(19) => nc205, F_FM0_RDATA(18) => nc82, 
        F_FM0_RDATA(17) => nc145, F_FM0_RDATA(16) => nc181, 
        F_FM0_RDATA(15) => nc160, F_FM0_RDATA(14) => nc57, 
        F_FM0_RDATA(13) => nc156, F_FM0_RDATA(12) => nc280, 
        F_FM0_RDATA(11) => nc125, F_FM0_RDATA(10) => nc211, 
        F_FM0_RDATA(9) => nc73, F_FM0_RDATA(8) => nc107, 
        F_FM0_RDATA(7) => nc329, F_FM0_RDATA(6) => nc66, 
        F_FM0_RDATA(5) => nc83, F_FM0_RDATA(4) => nc9, 
        F_FM0_RDATA(3) => nc252, F_FM0_RDATA(2) => nc171, 
        F_FM0_RDATA(1) => nc54, F_FM0_RDATA(0) => nc286, 
        F_FM0_READYOUT => OPEN, F_FM0_RESP => OPEN, 
        F_HM0_ADDR(31) => nc307, F_HM0_ADDR(30) => nc135, 
        F_HM0_ADDR(29) => nc41, F_HM0_ADDR(28) => nc100, 
        F_HM0_ADDR(27) => nc270, F_HM0_ADDR(26) => nc339, 
        F_HM0_ADDR(25) => nc52, F_HM0_ADDR(24) => nc251, 
        F_HM0_ADDR(23) => nc186, F_HM0_ADDR(22) => nc29, 
        F_HM0_ADDR(21) => nc269, F_HM0_ADDR(20) => nc118, 
        F_HM0_ADDR(19) => nc60, F_HM0_ADDR(18) => nc141, 
        F_HM0_ADDR(17) => nc311, F_HM0_ADDR(16) => nc276, 
        F_HM0_ADDR(15) => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(15), 
        F_HM0_ADDR(14) => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(14), 
        F_HM0_ADDR(13) => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(13), 
        F_HM0_ADDR(12) => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(12), 
        F_HM0_ADDR(11) => nc193, F_HM0_ADDR(10) => nc214, 
        F_HM0_ADDR(9) => nc298, F_HM0_ADDR(8) => nc282, 
        F_HM0_ADDR(7) => CoreAPB3_0_APBmslave0_PADDR(7), 
        F_HM0_ADDR(6) => CoreAPB3_0_APBmslave0_PADDR(6), 
        F_HM0_ADDR(5) => CoreAPB3_0_APBmslave0_PADDR(5), 
        F_HM0_ADDR(4) => CoreAPB3_0_APBmslave0_PADDR(4), 
        F_HM0_ADDR(3) => CoreAPB3_0_APBmslave0_PADDR(3), 
        F_HM0_ADDR(2) => CoreAPB3_0_APBmslave0_PADDR(2), 
        F_HM0_ADDR(1) => CoreAPB3_0_APBmslave0_PADDR(1), 
        F_HM0_ADDR(0) => CoreAPB3_0_APBmslave0_PADDR(0), 
        F_HM0_ENABLE => CoreAPB3_0_APBmslave0_PENABLE, F_HM0_SEL
         => SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PSELx, 
        F_HM0_SIZE(1) => nc240, F_HM0_SIZE(0) => nc45, 
        F_HM0_TRANS1 => OPEN, F_HM0_WDATA(31) => nc53, 
        F_HM0_WDATA(30) => nc121, F_HM0_WDATA(29) => nc176, 
        F_HM0_WDATA(28) => nc220, F_HM0_WDATA(27) => nc158, 
        F_HM0_WDATA(26) => nc281, F_HM0_WDATA(25) => nc209, 
        F_HM0_WDATA(24) => nc246, F_HM0_WDATA(23) => nc162, 
        F_HM0_WDATA(22) => nc11, F_HM0_WDATA(21) => nc272, 
        F_HM0_WDATA(20) => nc131, F_HM0_WDATA(19) => nc254, 
        F_HM0_WDATA(18) => nc267, F_HM0_WDATA(17) => nc96, 
        F_HM0_WDATA(16) => nc79, F_HM0_WDATA(15) => 
        CoreAPB3_0_APBmslave0_PWDATA(15), F_HM0_WDATA(14) => 
        CoreAPB3_0_APBmslave0_PWDATA(14), F_HM0_WDATA(13) => 
        CoreAPB3_0_APBmslave0_PWDATA(13), F_HM0_WDATA(12) => 
        CoreAPB3_0_APBmslave0_PWDATA(12), F_HM0_WDATA(11) => 
        CoreAPB3_0_APBmslave0_PWDATA(11), F_HM0_WDATA(10) => 
        CoreAPB3_0_APBmslave0_PWDATA(10), F_HM0_WDATA(9) => 
        CoreAPB3_0_APBmslave0_PWDATA(9), F_HM0_WDATA(8) => 
        CoreAPB3_0_APBmslave0_PWDATA(8), F_HM0_WDATA(7) => 
        CoreAPB3_0_APBmslave0_PWDATA(7), F_HM0_WDATA(6) => 
        CoreAPB3_0_APBmslave0_PWDATA(6), F_HM0_WDATA(5) => 
        CoreAPB3_0_APBmslave0_PWDATA(5), F_HM0_WDATA(4) => 
        CoreAPB3_0_APBmslave0_PWDATA(4), F_HM0_WDATA(3) => 
        CoreAPB3_0_APBmslave0_PWDATA(3), F_HM0_WDATA(2) => 
        CoreAPB3_0_APBmslave0_PWDATA(2), F_HM0_WDATA(1) => 
        CoreAPB3_0_APBmslave0_PWDATA(1), F_HM0_WDATA(0) => 
        CoreAPB3_0_APBmslave0_PWDATA(0), F_HM0_WRITE => 
        CoreAPB3_0_APBmslave0_PWRITE, FAB_CHRGVBUS => OPEN, 
        FAB_DISCHRGVBUS => OPEN, FAB_DMPULLDOWN => OPEN, 
        FAB_DPPULLDOWN => OPEN, FAB_DRVVBUS => OPEN, FAB_IDPULLUP
         => OPEN, FAB_OPMODE(1) => nc226, FAB_OPMODE(0) => nc146, 
        FAB_SUSPENDM => OPEN, FAB_TERMSEL => OPEN, FAB_TXVALID
         => OPEN, FAB_VCONTROL(3) => nc230, FAB_VCONTROL(2) => 
        nc89, FAB_VCONTROL(1) => nc119, FAB_VCONTROL(0) => nc48, 
        FAB_VCONTROLLOADM => OPEN, FAB_XCVRSEL(1) => nc271, 
        FAB_XCVRSEL(0) => nc213, FAB_XDATAOUT(7) => nc300, 
        FAB_XDATAOUT(6) => nc126, FAB_XDATAOUT(5) => nc195, 
        FAB_XDATAOUT(4) => nc188, FAB_XDATAOUT(3) => nc242, 
        FAB_XDATAOUT(2) => nc15, FAB_XDATAOUT(1) => nc308, 
        FAB_XDATAOUT(0) => nc236, FACC_GLMUX_SEL => OPEN, 
        FIC32_0_MASTER(1) => nc102, FIC32_0_MASTER(0) => nc304, 
        FIC32_1_MASTER(1) => nc3, FIC32_1_MASTER(0) => nc207, 
        FPGA_RESET_N => SF2_MSS_sys_sb_MSS_TMP_0_MSS_RESET_N_M2F, 
        GTX_CLK => OPEN, H2F_INTERRUPT(15) => nc47, 
        H2F_INTERRUPT(14) => nc90, H2F_INTERRUPT(13) => nc284, 
        H2F_INTERRUPT(12) => nc222, H2F_INTERRUPT(11) => nc159, 
        H2F_INTERRUPT(10) => nc136, H2F_INTERRUPT(9) => nc241, 
        H2F_INTERRUPT(8) => nc253, H2F_INTERRUPT(7) => nc178, 
        H2F_INTERRUPT(6) => nc306, H2F_INTERRUPT(5) => nc215, 
        H2F_INTERRUPT(4) => nc59, H2F_INTERRUPT(3) => nc221, 
        H2F_INTERRUPT(2) => nc232, H2F_INTERRUPT(1) => nc274, 
        H2F_INTERRUPT(0) => nc18, H2F_NMI => OPEN, H2FCALIB => 
        OPEN, I2C0_SCL_MGPIO31B_H2F_A => OPEN, 
        I2C0_SCL_MGPIO31B_H2F_B => OPEN, I2C0_SDA_MGPIO30B_H2F_A
         => OPEN, I2C0_SDA_MGPIO30B_H2F_B => OPEN, 
        I2C1_SCL_MGPIO1A_H2F_A => OPEN, I2C1_SCL_MGPIO1A_H2F_B
         => OPEN, I2C1_SDA_MGPIO0A_H2F_A => OPEN, 
        I2C1_SDA_MGPIO0A_H2F_B => OPEN, MDCF => OPEN, MDOENF => 
        OPEN, MDOF => OPEN, MMUART0_CTS_MGPIO19B_H2F_A => OPEN, 
        MMUART0_CTS_MGPIO19B_H2F_B => OPEN, 
        MMUART0_DCD_MGPIO22B_H2F_A => OPEN, 
        MMUART0_DCD_MGPIO22B_H2F_B => OPEN, 
        MMUART0_DSR_MGPIO20B_H2F_A => OPEN, 
        MMUART0_DSR_MGPIO20B_H2F_B => OPEN, 
        MMUART0_DTR_MGPIO18B_H2F_A => OPEN, 
        MMUART0_DTR_MGPIO18B_H2F_B => OPEN, 
        MMUART0_RI_MGPIO21B_H2F_A => OPEN, 
        MMUART0_RI_MGPIO21B_H2F_B => OPEN, 
        MMUART0_RTS_MGPIO17B_H2F_A => OPEN, 
        MMUART0_RTS_MGPIO17B_H2F_B => OPEN, 
        MMUART0_RXD_MGPIO28B_H2F_A => OPEN, 
        MMUART0_RXD_MGPIO28B_H2F_B => OPEN, 
        MMUART0_SCK_MGPIO29B_H2F_A => OPEN, 
        MMUART0_SCK_MGPIO29B_H2F_B => OPEN, 
        MMUART0_TXD_MGPIO27B_H2F_A => OPEN, 
        MMUART0_TXD_MGPIO27B_H2F_B => OPEN, 
        MMUART1_DTR_MGPIO12B_H2F_A => OPEN, 
        MMUART1_RTS_MGPIO11B_H2F_A => OPEN, 
        MMUART1_RTS_MGPIO11B_H2F_B => OPEN, 
        MMUART1_RXD_MGPIO26B_H2F_A => OPEN, 
        MMUART1_RXD_MGPIO26B_H2F_B => OPEN, 
        MMUART1_SCK_MGPIO25B_H2F_A => OPEN, 
        MMUART1_SCK_MGPIO25B_H2F_B => OPEN, 
        MMUART1_TXD_MGPIO24B_H2F_A => OPEN, 
        MMUART1_TXD_MGPIO24B_H2F_B => OPEN, MPLL_LOCK => OPEN, 
        PER2_FABRIC_PADDR(15) => nc44, PER2_FABRIC_PADDR(14) => 
        nc117, PER2_FABRIC_PADDR(13) => nc189, 
        PER2_FABRIC_PADDR(12) => nc164, PER2_FABRIC_PADDR(11) => 
        nc148, PER2_FABRIC_PADDR(10) => nc42, 
        PER2_FABRIC_PADDR(9) => nc231, PER2_FABRIC_PADDR(8) => 
        nc191, PER2_FABRIC_PADDR(7) => nc255, 
        PER2_FABRIC_PADDR(6) => nc283, PER2_FABRIC_PADDR(5) => 
        nc341, PER2_FABRIC_PADDR(4) => nc317, 
        PER2_FABRIC_PADDR(3) => nc290, PER2_FABRIC_PADDR(2) => 
        nc17, PER2_FABRIC_PENABLE => OPEN, PER2_FABRIC_PSEL => 
        OPEN, PER2_FABRIC_PWDATA(31) => nc2, 
        PER2_FABRIC_PWDATA(30) => nc302, PER2_FABRIC_PWDATA(29)
         => nc110, PER2_FABRIC_PWDATA(28) => nc128, 
        PER2_FABRIC_PWDATA(27) => nc244, PER2_FABRIC_PWDATA(26)
         => nc321, PER2_FABRIC_PWDATA(25) => nc43, 
        PER2_FABRIC_PWDATA(24) => nc179, PER2_FABRIC_PWDATA(23)
         => nc157, PER2_FABRIC_PWDATA(22) => nc36, 
        PER2_FABRIC_PWDATA(21) => nc224, PER2_FABRIC_PWDATA(20)
         => nc296, PER2_FABRIC_PWDATA(19) => nc273, 
        PER2_FABRIC_PWDATA(18) => nc61, PER2_FABRIC_PWDATA(17)
         => nc104, PER2_FABRIC_PWDATA(16) => nc138, 
        PER2_FABRIC_PWDATA(15) => nc14, PER2_FABRIC_PWDATA(14)
         => nc285, PER2_FABRIC_PWDATA(13) => nc303, 
        PER2_FABRIC_PWDATA(12) => nc150, PER2_FABRIC_PWDATA(11)
         => nc331, PER2_FABRIC_PWDATA(10) => nc196, 
        PER2_FABRIC_PWDATA(9) => nc234, PER2_FABRIC_PWDATA(8) => 
        nc149, PER2_FABRIC_PWDATA(7) => nc12, 
        PER2_FABRIC_PWDATA(6) => nc219, PER2_FABRIC_PWDATA(5) => 
        nc30, PER2_FABRIC_PWDATA(4) => nc243, 
        PER2_FABRIC_PWDATA(3) => nc187, PER2_FABRIC_PWDATA(2) => 
        nc65, PER2_FABRIC_PWDATA(1) => nc7, PER2_FABRIC_PWDATA(0)
         => nc292, PER2_FABRIC_PWRITE => OPEN, RTC_MATCH => OPEN, 
        SLEEPDEEP => OPEN, SLEEPHOLDACK => OPEN, SLEEPING => OPEN, 
        SMBALERT_NO0 => OPEN, SMBALERT_NO1 => OPEN, SMBSUS_NO0
         => OPEN, SMBSUS_NO1 => OPEN, SPI0_CLK_OUT => 
        SPI_0_CLK_M2F_c, SPI0_SDI_MGPIO5A_H2F_A => OPEN, 
        SPI0_SDI_MGPIO5A_H2F_B => OPEN, SPI0_SDO_MGPIO6A_H2F_A
         => SPI_0_DO_M2F_c, SPI0_SDO_MGPIO6A_H2F_B => OPEN, 
        SPI0_SS0_MGPIO7A_H2F_A => SPI_0_SS0_M2F_c, 
        SPI0_SS0_MGPIO7A_H2F_B => SPI_0_SS0_M2F_OE_c, 
        SPI0_SS1_MGPIO8A_H2F_A => SPI_0_SS1_M2F_c, 
        SPI0_SS1_MGPIO8A_H2F_B => OPEN, SPI0_SS2_MGPIO9A_H2F_A
         => SPI_0_SS2_M2F_c, SPI0_SS2_MGPIO9A_H2F_B => OPEN, 
        SPI0_SS3_MGPIO10A_H2F_A => SPI_0_SS3_M2F_c, 
        SPI0_SS3_MGPIO10A_H2F_B => OPEN, SPI0_SS4_MGPIO19A_H2F_A
         => SPI_0_SS4_M2F_c, SPI0_SS5_MGPIO20A_H2F_A => OPEN, 
        SPI0_SS6_MGPIO21A_H2F_A => OPEN, SPI0_SS7_MGPIO22A_H2F_A
         => OPEN, SPI1_CLK_OUT => OPEN, SPI1_SDI_MGPIO11A_H2F_A
         => OPEN, SPI1_SDI_MGPIO11A_H2F_B => OPEN, 
        SPI1_SDO_MGPIO12A_H2F_A => OPEN, SPI1_SDO_MGPIO12A_H2F_B
         => OPEN, SPI1_SS0_MGPIO13A_H2F_A => OPEN, 
        SPI1_SS0_MGPIO13A_H2F_B => OPEN, SPI1_SS1_MGPIO14A_H2F_A
         => OPEN, SPI1_SS1_MGPIO14A_H2F_B => OPEN, 
        SPI1_SS2_MGPIO15A_H2F_A => OPEN, SPI1_SS2_MGPIO15A_H2F_B
         => OPEN, SPI1_SS3_MGPIO16A_H2F_A => OPEN, 
        SPI1_SS3_MGPIO16A_H2F_B => OPEN, SPI1_SS4_MGPIO17A_H2F_A
         => OPEN, SPI1_SS5_MGPIO18A_H2F_A => OPEN, 
        SPI1_SS6_MGPIO23A_H2F_A => OPEN, SPI1_SS7_MGPIO24A_H2F_A
         => OPEN, TCGF(9) => nc129, TCGF(8) => nc275, TCGF(7) => 
        nc8, TCGF(6) => nc223, TCGF(5) => nc13, TCGF(4) => nc305, 
        TCGF(3) => nc180, TCGF(2) => nc26, TCGF(1) => nc291, 
        TCGF(0) => nc177, TRACECLK => OPEN, TRACEDATA(3) => nc139, 
        TRACEDATA(2) => nc310, TRACEDATA(1) => nc259, 
        TRACEDATA(0) => nc245, TX_CLK => OPEN, TX_ENF => OPEN, 
        TX_ERRF => OPEN, TXCTL_EN_RIF => OPEN, TXD_RIF(3) => 
        nc233, TXD_RIF(2) => nc163, TXD_RIF(1) => nc318, 
        TXD_RIF(0) => nc268, TXDF(7) => nc112, TXDF(6) => nc68, 
        TXDF(5) => nc49, TXDF(4) => nc314, TXDF(3) => nc217, 
        TXDF(2) => nc170, TXDF(1) => nc91, TXDF(0) => nc225, TXEV
         => OPEN, WDOGTIMEOUT => OPEN, F_ARREADY_HREADYOUT1 => 
        OPEN, F_AWREADY_HREADYOUT0 => OPEN, F_BID(3) => nc5, 
        F_BID(2) => nc20, F_BID(1) => nc198, F_BID(0) => nc147, 
        F_BRESP_HRESP0(1) => nc316, F_BRESP_HRESP0(0) => nc67, 
        F_BVALID => OPEN, F_RDATA_HRDATA01(63) => nc289, 
        F_RDATA_HRDATA01(62) => nc294, F_RDATA_HRDATA01(61) => 
        nc152, F_RDATA_HRDATA01(60) => nc127, 
        F_RDATA_HRDATA01(59) => nc103, F_RDATA_HRDATA01(58) => 
        nc235, F_RDATA_HRDATA01(57) => nc76, F_RDATA_HRDATA01(56)
         => nc347, F_RDATA_HRDATA01(55) => nc208, 
        F_RDATA_HRDATA01(54) => nc140, F_RDATA_HRDATA01(53) => 
        nc257, F_RDATA_HRDATA01(52) => nc86, F_RDATA_HRDATA01(51)
         => nc95, F_RDATA_HRDATA01(50) => nc327, 
        F_RDATA_HRDATA01(49) => nc120, F_RDATA_HRDATA01(48) => 
        nc165, F_RDATA_HRDATA01(47) => nc279, 
        F_RDATA_HRDATA01(46) => nc137, F_RDATA_HRDATA01(45) => 
        nc64, F_RDATA_HRDATA01(44) => nc19, F_RDATA_HRDATA01(43)
         => nc312, F_RDATA_HRDATA01(42) => nc70, 
        F_RDATA_HRDATA01(41) => nc182, F_RDATA_HRDATA01(40) => 
        nc62, F_RDATA_HRDATA01(39) => nc337, F_RDATA_HRDATA01(38)
         => nc199, F_RDATA_HRDATA01(37) => nc80, 
        F_RDATA_HRDATA01(36) => nc130, F_RDATA_HRDATA01(35) => 
        nc287, F_RDATA_HRDATA01(34) => nc98, F_RDATA_HRDATA01(33)
         => nc293, F_RDATA_HRDATA01(32) => nc249, 
        F_RDATA_HRDATA01(31) => nc114, F_RDATA_HRDATA01(30) => 
        nc56, F_RDATA_HRDATA01(29) => nc105, F_RDATA_HRDATA01(28)
         => nc63, F_RDATA_HRDATA01(27) => nc313, 
        F_RDATA_HRDATA01(26) => nc309, F_RDATA_HRDATA01(25) => 
        nc172, F_RDATA_HRDATA01(24) => nc229, 
        F_RDATA_HRDATA01(23) => nc277, F_RDATA_HRDATA01(22) => 
        nc97, F_RDATA_HRDATA01(21) => nc161, F_RDATA_HRDATA01(20)
         => nc31, F_RDATA_HRDATA01(19) => nc340, 
        F_RDATA_HRDATA01(18) => nc295, F_RDATA_HRDATA01(17) => 
        nc154, F_RDATA_HRDATA01(16) => nc50, F_RDATA_HRDATA01(15)
         => nc260, F_RDATA_HRDATA01(14) => nc239, 
        F_RDATA_HRDATA01(13) => nc142, F_RDATA_HRDATA01(12) => 
        nc320, F_RDATA_HRDATA01(11) => nc344, 
        F_RDATA_HRDATA01(10) => nc315, F_RDATA_HRDATA01(9) => 
        nc247, F_RDATA_HRDATA01(8) => nc94, F_RDATA_HRDATA01(7)
         => nc197, F_RDATA_HRDATA01(6) => nc328, 
        F_RDATA_HRDATA01(5) => nc122, F_RDATA_HRDATA01(4) => 
        nc266, F_RDATA_HRDATA01(3) => nc35, F_RDATA_HRDATA01(2)
         => nc324, F_RDATA_HRDATA01(1) => nc4, 
        F_RDATA_HRDATA01(0) => nc227, F_RID(3) => nc92, F_RID(2)
         => nc101, F_RID(1) => nc346, F_RID(0) => nc330, F_RLAST
         => OPEN, F_RRESP_HRESP1(1) => nc184, F_RRESP_HRESP1(0)
         => nc200, F_RVALID => OPEN, F_WREADY => OPEN, 
        MDDR_FABRIC_PRDATA(15) => nc190, MDDR_FABRIC_PRDATA(14)
         => nc166, MDDR_FABRIC_PRDATA(13) => nc338, 
        MDDR_FABRIC_PRDATA(12) => nc326, MDDR_FABRIC_PRDATA(11)
         => nc132, MDDR_FABRIC_PRDATA(10) => nc334, 
        MDDR_FABRIC_PRDATA(9) => nc21, MDDR_FABRIC_PRDATA(8) => 
        nc237, MDDR_FABRIC_PRDATA(7) => nc93, 
        MDDR_FABRIC_PRDATA(6) => nc262, MDDR_FABRIC_PRDATA(5) => 
        nc69, MDDR_FABRIC_PRDATA(4) => nc206, 
        MDDR_FABRIC_PRDATA(3) => nc174, MDDR_FABRIC_PRDATA(2) => 
        nc38, MDDR_FABRIC_PRDATA(1) => nc113, 
        MDDR_FABRIC_PRDATA(0) => nc336, MDDR_FABRIC_PREADY => 
        OPEN, MDDR_FABRIC_PSLVERR => OPEN, CAN_RXBUS_F2H_SCP => 
        VCC_net_1, CAN_TX_EBL_F2H_SCP => VCC_net_1, 
        CAN_TXBUS_F2H_SCP => VCC_net_1, COLF => VCC_net_1, CRSF
         => VCC_net_1, F2_DMAREADY(1) => VCC_net_1, 
        F2_DMAREADY(0) => VCC_net_1, F2H_INTERRUPT(15) => 
        GND_net_1, F2H_INTERRUPT(14) => GND_net_1, 
        F2H_INTERRUPT(13) => GND_net_1, F2H_INTERRUPT(12) => 
        GND_net_1, F2H_INTERRUPT(11) => GND_net_1, 
        F2H_INTERRUPT(10) => GND_net_1, F2H_INTERRUPT(9) => 
        GND_net_1, F2H_INTERRUPT(8) => GND_net_1, 
        F2H_INTERRUPT(7) => GND_net_1, F2H_INTERRUPT(6) => 
        GND_net_1, F2H_INTERRUPT(5) => GND_net_1, 
        F2H_INTERRUPT(4) => GND_net_1, F2H_INTERRUPT(3) => 
        GND_net_1, F2H_INTERRUPT(2) => GND_net_1, 
        F2H_INTERRUPT(1) => int_or_i, F2H_INTERRUPT(0) => OR3_1_Y, 
        F2HCALIB => VCC_net_1, F_DMAREADY(1) => VCC_net_1, 
        F_DMAREADY(0) => VCC_net_1, F_FM0_ADDR(31) => GND_net_1, 
        F_FM0_ADDR(30) => GND_net_1, F_FM0_ADDR(29) => GND_net_1, 
        F_FM0_ADDR(28) => GND_net_1, F_FM0_ADDR(27) => GND_net_1, 
        F_FM0_ADDR(26) => GND_net_1, F_FM0_ADDR(25) => GND_net_1, 
        F_FM0_ADDR(24) => GND_net_1, F_FM0_ADDR(23) => GND_net_1, 
        F_FM0_ADDR(22) => GND_net_1, F_FM0_ADDR(21) => GND_net_1, 
        F_FM0_ADDR(20) => GND_net_1, F_FM0_ADDR(19) => GND_net_1, 
        F_FM0_ADDR(18) => GND_net_1, F_FM0_ADDR(17) => GND_net_1, 
        F_FM0_ADDR(16) => GND_net_1, F_FM0_ADDR(15) => GND_net_1, 
        F_FM0_ADDR(14) => GND_net_1, F_FM0_ADDR(13) => GND_net_1, 
        F_FM0_ADDR(12) => GND_net_1, F_FM0_ADDR(11) => GND_net_1, 
        F_FM0_ADDR(10) => GND_net_1, F_FM0_ADDR(9) => GND_net_1, 
        F_FM0_ADDR(8) => GND_net_1, F_FM0_ADDR(7) => GND_net_1, 
        F_FM0_ADDR(6) => GND_net_1, F_FM0_ADDR(5) => GND_net_1, 
        F_FM0_ADDR(4) => GND_net_1, F_FM0_ADDR(3) => GND_net_1, 
        F_FM0_ADDR(2) => GND_net_1, F_FM0_ADDR(1) => GND_net_1, 
        F_FM0_ADDR(0) => GND_net_1, F_FM0_ENABLE => GND_net_1, 
        F_FM0_MASTLOCK => GND_net_1, F_FM0_READY => VCC_net_1, 
        F_FM0_SEL => GND_net_1, F_FM0_SIZE(1) => GND_net_1, 
        F_FM0_SIZE(0) => GND_net_1, F_FM0_TRANS1 => GND_net_1, 
        F_FM0_WDATA(31) => GND_net_1, F_FM0_WDATA(30) => 
        GND_net_1, F_FM0_WDATA(29) => GND_net_1, F_FM0_WDATA(28)
         => GND_net_1, F_FM0_WDATA(27) => GND_net_1, 
        F_FM0_WDATA(26) => GND_net_1, F_FM0_WDATA(25) => 
        GND_net_1, F_FM0_WDATA(24) => GND_net_1, F_FM0_WDATA(23)
         => GND_net_1, F_FM0_WDATA(22) => GND_net_1, 
        F_FM0_WDATA(21) => GND_net_1, F_FM0_WDATA(20) => 
        GND_net_1, F_FM0_WDATA(19) => GND_net_1, F_FM0_WDATA(18)
         => GND_net_1, F_FM0_WDATA(17) => GND_net_1, 
        F_FM0_WDATA(16) => GND_net_1, F_FM0_WDATA(15) => 
        GND_net_1, F_FM0_WDATA(14) => GND_net_1, F_FM0_WDATA(13)
         => GND_net_1, F_FM0_WDATA(12) => GND_net_1, 
        F_FM0_WDATA(11) => GND_net_1, F_FM0_WDATA(10) => 
        GND_net_1, F_FM0_WDATA(9) => GND_net_1, F_FM0_WDATA(8)
         => GND_net_1, F_FM0_WDATA(7) => GND_net_1, 
        F_FM0_WDATA(6) => GND_net_1, F_FM0_WDATA(5) => GND_net_1, 
        F_FM0_WDATA(4) => GND_net_1, F_FM0_WDATA(3) => GND_net_1, 
        F_FM0_WDATA(2) => GND_net_1, F_FM0_WDATA(1) => GND_net_1, 
        F_FM0_WDATA(0) => GND_net_1, F_FM0_WRITE => GND_net_1, 
        F_HM0_RDATA(31) => GND_net_1, F_HM0_RDATA(30) => 
        GND_net_1, F_HM0_RDATA(29) => GND_net_1, F_HM0_RDATA(28)
         => GND_net_1, F_HM0_RDATA(27) => GND_net_1, 
        F_HM0_RDATA(26) => GND_net_1, F_HM0_RDATA(25) => 
        GND_net_1, F_HM0_RDATA(24) => GND_net_1, F_HM0_RDATA(23)
         => GND_net_1, F_HM0_RDATA(22) => GND_net_1, 
        F_HM0_RDATA(21) => GND_net_1, F_HM0_RDATA(20) => 
        GND_net_1, F_HM0_RDATA(19) => GND_net_1, F_HM0_RDATA(18)
         => GND_net_1, F_HM0_RDATA(17) => GND_net_1, 
        F_HM0_RDATA(16) => GND_net_1, F_HM0_RDATA(15) => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_12, 
        F_HM0_RDATA(14) => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_11, 
        F_HM0_RDATA(13) => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_10, 
        F_HM0_RDATA(12) => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_9, 
        F_HM0_RDATA(11) => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_8, 
        F_HM0_RDATA(10) => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_7, 
        F_HM0_RDATA(9) => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_6, 
        F_HM0_RDATA(8) => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_5, 
        F_HM0_RDATA(7) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[7]\, 
        F_HM0_RDATA(6) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[6]\, 
        F_HM0_RDATA(5) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[5]\, 
        F_HM0_RDATA(4) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[4]\, 
        F_HM0_RDATA(3) => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_0, 
        F_HM0_RDATA(2) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[2]\, 
        F_HM0_RDATA(1) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[1]\, 
        F_HM0_RDATA(0) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[0]\, 
        F_HM0_READY => VCC_net_1, F_HM0_RESP => GND_net_1, 
        FAB_AVALID => VCC_net_1, FAB_HOSTDISCON => VCC_net_1, 
        FAB_IDDIG => VCC_net_1, FAB_LINESTATE(1) => VCC_net_1, 
        FAB_LINESTATE(0) => VCC_net_1, FAB_M3_RESET_N => 
        VCC_net_1, FAB_PLL_LOCK => FAB_CCC_LOCK, FAB_RXACTIVE => 
        VCC_net_1, FAB_RXERROR => VCC_net_1, FAB_RXVALID => 
        VCC_net_1, FAB_RXVALIDH => GND_net_1, FAB_SESSEND => 
        VCC_net_1, FAB_TXREADY => VCC_net_1, FAB_VBUSVALID => 
        VCC_net_1, FAB_VSTATUS(7) => VCC_net_1, FAB_VSTATUS(6)
         => VCC_net_1, FAB_VSTATUS(5) => VCC_net_1, 
        FAB_VSTATUS(4) => VCC_net_1, FAB_VSTATUS(3) => VCC_net_1, 
        FAB_VSTATUS(2) => VCC_net_1, FAB_VSTATUS(1) => VCC_net_1, 
        FAB_VSTATUS(0) => VCC_net_1, FAB_XDATAIN(7) => VCC_net_1, 
        FAB_XDATAIN(6) => VCC_net_1, FAB_XDATAIN(5) => VCC_net_1, 
        FAB_XDATAIN(4) => VCC_net_1, FAB_XDATAIN(3) => VCC_net_1, 
        FAB_XDATAIN(2) => VCC_net_1, FAB_XDATAIN(1) => VCC_net_1, 
        FAB_XDATAIN(0) => VCC_net_1, GTX_CLKPF => VCC_net_1, 
        I2C0_BCLK => VCC_net_1, I2C0_SCL_F2H_SCP => VCC_net_1, 
        I2C0_SDA_F2H_SCP => VCC_net_1, I2C1_BCLK => VCC_net_1, 
        I2C1_SCL_F2H_SCP => VCC_net_1, I2C1_SDA_F2H_SCP => 
        VCC_net_1, MDIF => VCC_net_1, MGPIO0A_F2H_GPIN => 
        VCC_net_1, MGPIO10A_F2H_GPIN => VCC_net_1, 
        MGPIO11A_F2H_GPIN => VCC_net_1, MGPIO11B_F2H_GPIN => 
        VCC_net_1, MGPIO12A_F2H_GPIN => VCC_net_1, 
        MGPIO13A_F2H_GPIN => VCC_net_1, MGPIO14A_F2H_GPIN => 
        VCC_net_1, MGPIO15A_F2H_GPIN => VCC_net_1, 
        MGPIO16A_F2H_GPIN => VCC_net_1, MGPIO17B_F2H_GPIN => 
        VCC_net_1, MGPIO18B_F2H_GPIN => VCC_net_1, 
        MGPIO19B_F2H_GPIN => VCC_net_1, MGPIO1A_F2H_GPIN => 
        VCC_net_1, MGPIO20B_F2H_GPIN => VCC_net_1, 
        MGPIO21B_F2H_GPIN => VCC_net_1, MGPIO22B_F2H_GPIN => 
        VCC_net_1, MGPIO24B_F2H_GPIN => VCC_net_1, 
        MGPIO25B_F2H_GPIN => VCC_net_1, MGPIO26B_F2H_GPIN => 
        VCC_net_1, MGPIO27B_F2H_GPIN => VCC_net_1, 
        MGPIO28B_F2H_GPIN => VCC_net_1, MGPIO29B_F2H_GPIN => 
        VCC_net_1, MGPIO2A_F2H_GPIN => VCC_net_1, 
        MGPIO30B_F2H_GPIN => VCC_net_1, MGPIO31B_F2H_GPIN => 
        VCC_net_1, MGPIO3A_F2H_GPIN => VCC_net_1, 
        MGPIO4A_F2H_GPIN => VCC_net_1, MGPIO5A_F2H_GPIN => 
        VCC_net_1, MGPIO6A_F2H_GPIN => VCC_net_1, 
        MGPIO7A_F2H_GPIN => VCC_net_1, MGPIO8A_F2H_GPIN => 
        VCC_net_1, MGPIO9A_F2H_GPIN => VCC_net_1, 
        MMUART0_CTS_F2H_SCP => VCC_net_1, MMUART0_DCD_F2H_SCP => 
        VCC_net_1, MMUART0_DSR_F2H_SCP => VCC_net_1, 
        MMUART0_DTR_F2H_SCP => VCC_net_1, MMUART0_RI_F2H_SCP => 
        VCC_net_1, MMUART0_RTS_F2H_SCP => VCC_net_1, 
        MMUART0_RXD_F2H_SCP => VCC_net_1, MMUART0_SCK_F2H_SCP => 
        VCC_net_1, MMUART0_TXD_F2H_SCP => VCC_net_1, 
        MMUART1_CTS_F2H_SCP => VCC_net_1, MMUART1_DCD_F2H_SCP => 
        VCC_net_1, MMUART1_DSR_F2H_SCP => VCC_net_1, 
        MMUART1_RI_F2H_SCP => VCC_net_1, MMUART1_RTS_F2H_SCP => 
        VCC_net_1, MMUART1_RXD_F2H_SCP => VCC_net_1, 
        MMUART1_SCK_F2H_SCP => VCC_net_1, MMUART1_TXD_F2H_SCP => 
        VCC_net_1, PER2_FABRIC_PRDATA(31) => GND_net_1, 
        PER2_FABRIC_PRDATA(30) => GND_net_1, 
        PER2_FABRIC_PRDATA(29) => GND_net_1, 
        PER2_FABRIC_PRDATA(28) => GND_net_1, 
        PER2_FABRIC_PRDATA(27) => GND_net_1, 
        PER2_FABRIC_PRDATA(26) => GND_net_1, 
        PER2_FABRIC_PRDATA(25) => GND_net_1, 
        PER2_FABRIC_PRDATA(24) => GND_net_1, 
        PER2_FABRIC_PRDATA(23) => GND_net_1, 
        PER2_FABRIC_PRDATA(22) => GND_net_1, 
        PER2_FABRIC_PRDATA(21) => GND_net_1, 
        PER2_FABRIC_PRDATA(20) => GND_net_1, 
        PER2_FABRIC_PRDATA(19) => GND_net_1, 
        PER2_FABRIC_PRDATA(18) => GND_net_1, 
        PER2_FABRIC_PRDATA(17) => GND_net_1, 
        PER2_FABRIC_PRDATA(16) => GND_net_1, 
        PER2_FABRIC_PRDATA(15) => GND_net_1, 
        PER2_FABRIC_PRDATA(14) => GND_net_1, 
        PER2_FABRIC_PRDATA(13) => GND_net_1, 
        PER2_FABRIC_PRDATA(12) => GND_net_1, 
        PER2_FABRIC_PRDATA(11) => GND_net_1, 
        PER2_FABRIC_PRDATA(10) => GND_net_1, 
        PER2_FABRIC_PRDATA(9) => GND_net_1, PER2_FABRIC_PRDATA(8)
         => GND_net_1, PER2_FABRIC_PRDATA(7) => GND_net_1, 
        PER2_FABRIC_PRDATA(6) => GND_net_1, PER2_FABRIC_PRDATA(5)
         => GND_net_1, PER2_FABRIC_PRDATA(4) => GND_net_1, 
        PER2_FABRIC_PRDATA(3) => GND_net_1, PER2_FABRIC_PRDATA(2)
         => GND_net_1, PER2_FABRIC_PRDATA(1) => GND_net_1, 
        PER2_FABRIC_PRDATA(0) => GND_net_1, PER2_FABRIC_PREADY
         => VCC_net_1, PER2_FABRIC_PSLVERR => GND_net_1, RCGF(9)
         => VCC_net_1, RCGF(8) => VCC_net_1, RCGF(7) => VCC_net_1, 
        RCGF(6) => VCC_net_1, RCGF(5) => VCC_net_1, RCGF(4) => 
        VCC_net_1, RCGF(3) => VCC_net_1, RCGF(2) => VCC_net_1, 
        RCGF(1) => VCC_net_1, RCGF(0) => VCC_net_1, RX_CLKPF => 
        VCC_net_1, RX_DVF => VCC_net_1, RX_ERRF => VCC_net_1, 
        RX_EV => VCC_net_1, RXDF(7) => VCC_net_1, RXDF(6) => 
        VCC_net_1, RXDF(5) => VCC_net_1, RXDF(4) => VCC_net_1, 
        RXDF(3) => VCC_net_1, RXDF(2) => VCC_net_1, RXDF(1) => 
        VCC_net_1, RXDF(0) => VCC_net_1, SLEEPHOLDREQ => 
        GND_net_1, SMBALERT_NI0 => VCC_net_1, SMBALERT_NI1 => 
        VCC_net_1, SMBSUS_NI0 => VCC_net_1, SMBSUS_NI1 => 
        VCC_net_1, SPI0_CLK_IN => SPI_0_CLK_F2M_c, 
        SPI0_SDI_F2H_SCP => SPI_0_DI_F2M_c, SPI0_SDO_F2H_SCP => 
        VCC_net_1, SPI0_SS0_F2H_SCP => SPI_0_SS0_F2M_c, 
        SPI0_SS1_F2H_SCP => VCC_net_1, SPI0_SS2_F2H_SCP => 
        VCC_net_1, SPI0_SS3_F2H_SCP => VCC_net_1, SPI1_CLK_IN => 
        VCC_net_1, SPI1_SDI_F2H_SCP => VCC_net_1, 
        SPI1_SDO_F2H_SCP => VCC_net_1, SPI1_SS0_F2H_SCP => 
        VCC_net_1, SPI1_SS1_F2H_SCP => VCC_net_1, 
        SPI1_SS2_F2H_SCP => VCC_net_1, SPI1_SS3_F2H_SCP => 
        VCC_net_1, TX_CLKPF => VCC_net_1, USER_MSS_GPIO_RESET_N
         => VCC_net_1, USER_MSS_RESET_N => VCC_net_1, XCLK_FAB
         => VCC_net_1, CLK_BASE => FAB_CCC_GL0, CLK_MDDR_APB => 
        VCC_net_1, F_ARADDR_HADDR1(31) => VCC_net_1, 
        F_ARADDR_HADDR1(30) => VCC_net_1, F_ARADDR_HADDR1(29) => 
        VCC_net_1, F_ARADDR_HADDR1(28) => VCC_net_1, 
        F_ARADDR_HADDR1(27) => VCC_net_1, F_ARADDR_HADDR1(26) => 
        VCC_net_1, F_ARADDR_HADDR1(25) => VCC_net_1, 
        F_ARADDR_HADDR1(24) => VCC_net_1, F_ARADDR_HADDR1(23) => 
        VCC_net_1, F_ARADDR_HADDR1(22) => VCC_net_1, 
        F_ARADDR_HADDR1(21) => VCC_net_1, F_ARADDR_HADDR1(20) => 
        VCC_net_1, F_ARADDR_HADDR1(19) => VCC_net_1, 
        F_ARADDR_HADDR1(18) => VCC_net_1, F_ARADDR_HADDR1(17) => 
        VCC_net_1, F_ARADDR_HADDR1(16) => VCC_net_1, 
        F_ARADDR_HADDR1(15) => VCC_net_1, F_ARADDR_HADDR1(14) => 
        VCC_net_1, F_ARADDR_HADDR1(13) => VCC_net_1, 
        F_ARADDR_HADDR1(12) => VCC_net_1, F_ARADDR_HADDR1(11) => 
        VCC_net_1, F_ARADDR_HADDR1(10) => VCC_net_1, 
        F_ARADDR_HADDR1(9) => VCC_net_1, F_ARADDR_HADDR1(8) => 
        VCC_net_1, F_ARADDR_HADDR1(7) => VCC_net_1, 
        F_ARADDR_HADDR1(6) => VCC_net_1, F_ARADDR_HADDR1(5) => 
        VCC_net_1, F_ARADDR_HADDR1(4) => VCC_net_1, 
        F_ARADDR_HADDR1(3) => VCC_net_1, F_ARADDR_HADDR1(2) => 
        VCC_net_1, F_ARADDR_HADDR1(1) => VCC_net_1, 
        F_ARADDR_HADDR1(0) => VCC_net_1, F_ARBURST_HTRANS1(1) => 
        GND_net_1, F_ARBURST_HTRANS1(0) => GND_net_1, 
        F_ARID_HSEL1(3) => GND_net_1, F_ARID_HSEL1(2) => 
        GND_net_1, F_ARID_HSEL1(1) => GND_net_1, F_ARID_HSEL1(0)
         => GND_net_1, F_ARLEN_HBURST1(3) => GND_net_1, 
        F_ARLEN_HBURST1(2) => GND_net_1, F_ARLEN_HBURST1(1) => 
        GND_net_1, F_ARLEN_HBURST1(0) => GND_net_1, 
        F_ARLOCK_HMASTLOCK1(1) => GND_net_1, 
        F_ARLOCK_HMASTLOCK1(0) => GND_net_1, F_ARSIZE_HSIZE1(1)
         => GND_net_1, F_ARSIZE_HSIZE1(0) => GND_net_1, 
        F_ARVALID_HWRITE1 => GND_net_1, F_AWADDR_HADDR0(31) => 
        VCC_net_1, F_AWADDR_HADDR0(30) => VCC_net_1, 
        F_AWADDR_HADDR0(29) => VCC_net_1, F_AWADDR_HADDR0(28) => 
        VCC_net_1, F_AWADDR_HADDR0(27) => VCC_net_1, 
        F_AWADDR_HADDR0(26) => VCC_net_1, F_AWADDR_HADDR0(25) => 
        VCC_net_1, F_AWADDR_HADDR0(24) => VCC_net_1, 
        F_AWADDR_HADDR0(23) => VCC_net_1, F_AWADDR_HADDR0(22) => 
        VCC_net_1, F_AWADDR_HADDR0(21) => VCC_net_1, 
        F_AWADDR_HADDR0(20) => VCC_net_1, F_AWADDR_HADDR0(19) => 
        VCC_net_1, F_AWADDR_HADDR0(18) => VCC_net_1, 
        F_AWADDR_HADDR0(17) => VCC_net_1, F_AWADDR_HADDR0(16) => 
        VCC_net_1, F_AWADDR_HADDR0(15) => VCC_net_1, 
        F_AWADDR_HADDR0(14) => VCC_net_1, F_AWADDR_HADDR0(13) => 
        VCC_net_1, F_AWADDR_HADDR0(12) => VCC_net_1, 
        F_AWADDR_HADDR0(11) => VCC_net_1, F_AWADDR_HADDR0(10) => 
        VCC_net_1, F_AWADDR_HADDR0(9) => VCC_net_1, 
        F_AWADDR_HADDR0(8) => VCC_net_1, F_AWADDR_HADDR0(7) => 
        VCC_net_1, F_AWADDR_HADDR0(6) => VCC_net_1, 
        F_AWADDR_HADDR0(5) => VCC_net_1, F_AWADDR_HADDR0(4) => 
        VCC_net_1, F_AWADDR_HADDR0(3) => VCC_net_1, 
        F_AWADDR_HADDR0(2) => VCC_net_1, F_AWADDR_HADDR0(1) => 
        VCC_net_1, F_AWADDR_HADDR0(0) => VCC_net_1, 
        F_AWBURST_HTRANS0(1) => GND_net_1, F_AWBURST_HTRANS0(0)
         => GND_net_1, F_AWID_HSEL0(3) => GND_net_1, 
        F_AWID_HSEL0(2) => GND_net_1, F_AWID_HSEL0(1) => 
        GND_net_1, F_AWID_HSEL0(0) => GND_net_1, 
        F_AWLEN_HBURST0(3) => GND_net_1, F_AWLEN_HBURST0(2) => 
        GND_net_1, F_AWLEN_HBURST0(1) => GND_net_1, 
        F_AWLEN_HBURST0(0) => GND_net_1, F_AWLOCK_HMASTLOCK0(1)
         => GND_net_1, F_AWLOCK_HMASTLOCK0(0) => GND_net_1, 
        F_AWSIZE_HSIZE0(1) => GND_net_1, F_AWSIZE_HSIZE0(0) => 
        GND_net_1, F_AWVALID_HWRITE0 => GND_net_1, F_BREADY => 
        GND_net_1, F_RMW_AXI => GND_net_1, F_RREADY => GND_net_1, 
        F_WDATA_HWDATA01(63) => VCC_net_1, F_WDATA_HWDATA01(62)
         => VCC_net_1, F_WDATA_HWDATA01(61) => VCC_net_1, 
        F_WDATA_HWDATA01(60) => VCC_net_1, F_WDATA_HWDATA01(59)
         => VCC_net_1, F_WDATA_HWDATA01(58) => VCC_net_1, 
        F_WDATA_HWDATA01(57) => VCC_net_1, F_WDATA_HWDATA01(56)
         => VCC_net_1, F_WDATA_HWDATA01(55) => VCC_net_1, 
        F_WDATA_HWDATA01(54) => VCC_net_1, F_WDATA_HWDATA01(53)
         => VCC_net_1, F_WDATA_HWDATA01(52) => VCC_net_1, 
        F_WDATA_HWDATA01(51) => VCC_net_1, F_WDATA_HWDATA01(50)
         => VCC_net_1, F_WDATA_HWDATA01(49) => VCC_net_1, 
        F_WDATA_HWDATA01(48) => VCC_net_1, F_WDATA_HWDATA01(47)
         => VCC_net_1, F_WDATA_HWDATA01(46) => VCC_net_1, 
        F_WDATA_HWDATA01(45) => VCC_net_1, F_WDATA_HWDATA01(44)
         => VCC_net_1, F_WDATA_HWDATA01(43) => VCC_net_1, 
        F_WDATA_HWDATA01(42) => VCC_net_1, F_WDATA_HWDATA01(41)
         => VCC_net_1, F_WDATA_HWDATA01(40) => VCC_net_1, 
        F_WDATA_HWDATA01(39) => VCC_net_1, F_WDATA_HWDATA01(38)
         => VCC_net_1, F_WDATA_HWDATA01(37) => VCC_net_1, 
        F_WDATA_HWDATA01(36) => VCC_net_1, F_WDATA_HWDATA01(35)
         => VCC_net_1, F_WDATA_HWDATA01(34) => VCC_net_1, 
        F_WDATA_HWDATA01(33) => VCC_net_1, F_WDATA_HWDATA01(32)
         => VCC_net_1, F_WDATA_HWDATA01(31) => VCC_net_1, 
        F_WDATA_HWDATA01(30) => VCC_net_1, F_WDATA_HWDATA01(29)
         => VCC_net_1, F_WDATA_HWDATA01(28) => VCC_net_1, 
        F_WDATA_HWDATA01(27) => VCC_net_1, F_WDATA_HWDATA01(26)
         => VCC_net_1, F_WDATA_HWDATA01(25) => VCC_net_1, 
        F_WDATA_HWDATA01(24) => VCC_net_1, F_WDATA_HWDATA01(23)
         => VCC_net_1, F_WDATA_HWDATA01(22) => VCC_net_1, 
        F_WDATA_HWDATA01(21) => VCC_net_1, F_WDATA_HWDATA01(20)
         => VCC_net_1, F_WDATA_HWDATA01(19) => VCC_net_1, 
        F_WDATA_HWDATA01(18) => VCC_net_1, F_WDATA_HWDATA01(17)
         => VCC_net_1, F_WDATA_HWDATA01(16) => VCC_net_1, 
        F_WDATA_HWDATA01(15) => VCC_net_1, F_WDATA_HWDATA01(14)
         => VCC_net_1, F_WDATA_HWDATA01(13) => VCC_net_1, 
        F_WDATA_HWDATA01(12) => VCC_net_1, F_WDATA_HWDATA01(11)
         => VCC_net_1, F_WDATA_HWDATA01(10) => VCC_net_1, 
        F_WDATA_HWDATA01(9) => VCC_net_1, F_WDATA_HWDATA01(8) => 
        VCC_net_1, F_WDATA_HWDATA01(7) => VCC_net_1, 
        F_WDATA_HWDATA01(6) => VCC_net_1, F_WDATA_HWDATA01(5) => 
        VCC_net_1, F_WDATA_HWDATA01(4) => VCC_net_1, 
        F_WDATA_HWDATA01(3) => VCC_net_1, F_WDATA_HWDATA01(2) => 
        VCC_net_1, F_WDATA_HWDATA01(1) => VCC_net_1, 
        F_WDATA_HWDATA01(0) => VCC_net_1, F_WID_HREADY01(3) => 
        GND_net_1, F_WID_HREADY01(2) => GND_net_1, 
        F_WID_HREADY01(1) => GND_net_1, F_WID_HREADY01(0) => 
        GND_net_1, F_WLAST => GND_net_1, F_WSTRB(7) => GND_net_1, 
        F_WSTRB(6) => GND_net_1, F_WSTRB(5) => GND_net_1, 
        F_WSTRB(4) => GND_net_1, F_WSTRB(3) => GND_net_1, 
        F_WSTRB(2) => GND_net_1, F_WSTRB(1) => GND_net_1, 
        F_WSTRB(0) => GND_net_1, F_WVALID => GND_net_1, 
        FPGA_MDDR_ARESET_N => VCC_net_1, MDDR_FABRIC_PADDR(10)
         => VCC_net_1, MDDR_FABRIC_PADDR(9) => VCC_net_1, 
        MDDR_FABRIC_PADDR(8) => VCC_net_1, MDDR_FABRIC_PADDR(7)
         => VCC_net_1, MDDR_FABRIC_PADDR(6) => VCC_net_1, 
        MDDR_FABRIC_PADDR(5) => VCC_net_1, MDDR_FABRIC_PADDR(4)
         => VCC_net_1, MDDR_FABRIC_PADDR(3) => VCC_net_1, 
        MDDR_FABRIC_PADDR(2) => VCC_net_1, MDDR_FABRIC_PENABLE
         => VCC_net_1, MDDR_FABRIC_PSEL => VCC_net_1, 
        MDDR_FABRIC_PWDATA(15) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(14) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(13) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(12) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(11) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(10) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(9) => VCC_net_1, MDDR_FABRIC_PWDATA(8)
         => VCC_net_1, MDDR_FABRIC_PWDATA(7) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(6) => VCC_net_1, MDDR_FABRIC_PWDATA(5)
         => VCC_net_1, MDDR_FABRIC_PWDATA(4) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(3) => VCC_net_1, MDDR_FABRIC_PWDATA(2)
         => VCC_net_1, MDDR_FABRIC_PWDATA(1) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(0) => VCC_net_1, MDDR_FABRIC_PWRITE
         => VCC_net_1, PRESET_N => GND_net_1, 
        CAN_RXBUS_USBA_DATA1_MGPIO3A_IN => GND_net_1, 
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_IN => GND_net_1, 
        CAN_TXBUS_USBA_DATA0_MGPIO2A_IN => GND_net_1, DM_IN(2)
         => GND_net_1, DM_IN(1) => GND_net_1, DM_IN(0) => 
        GND_net_1, DRAM_DQ_IN(17) => GND_net_1, DRAM_DQ_IN(16)
         => GND_net_1, DRAM_DQ_IN(15) => GND_net_1, 
        DRAM_DQ_IN(14) => GND_net_1, DRAM_DQ_IN(13) => GND_net_1, 
        DRAM_DQ_IN(12) => GND_net_1, DRAM_DQ_IN(11) => GND_net_1, 
        DRAM_DQ_IN(10) => GND_net_1, DRAM_DQ_IN(9) => GND_net_1, 
        DRAM_DQ_IN(8) => GND_net_1, DRAM_DQ_IN(7) => GND_net_1, 
        DRAM_DQ_IN(6) => GND_net_1, DRAM_DQ_IN(5) => GND_net_1, 
        DRAM_DQ_IN(4) => GND_net_1, DRAM_DQ_IN(3) => GND_net_1, 
        DRAM_DQ_IN(2) => GND_net_1, DRAM_DQ_IN(1) => GND_net_1, 
        DRAM_DQ_IN(0) => GND_net_1, DRAM_DQS_IN(2) => GND_net_1, 
        DRAM_DQS_IN(1) => GND_net_1, DRAM_DQS_IN(0) => GND_net_1, 
        DRAM_FIFO_WE_IN(1) => GND_net_1, DRAM_FIFO_WE_IN(0) => 
        GND_net_1, I2C0_SCL_USBC_DATA1_MGPIO31B_IN => GND_net_1, 
        I2C0_SDA_USBC_DATA0_MGPIO30B_IN => GND_net_1, 
        I2C1_SCL_USBA_DATA4_MGPIO1A_IN => GND_net_1, 
        I2C1_SDA_USBA_DATA3_MGPIO0A_IN => GND_net_1, MGPIO25A_IN
         => GND_net_1, MGPIO26A_IN => GND_net_1, 
        MMUART0_CTS_USBC_DATA7_MGPIO19B_IN => GND_net_1, 
        MMUART0_DCD_MGPIO22B_IN => GND_net_1, 
        MMUART0_DSR_MGPIO20B_IN => GND_net_1, 
        MMUART0_DTR_USBC_DATA6_MGPIO18B_IN => GND_net_1, 
        MMUART0_RI_MGPIO21B_IN => GND_net_1, 
        MMUART0_RTS_USBC_DATA5_MGPIO17B_IN => GND_net_1, 
        MMUART0_RXD_USBC_STP_MGPIO28B_IN => GND_net_1, 
        MMUART0_SCK_USBC_NXT_MGPIO29B_IN => GND_net_1, 
        MMUART0_TXD_USBC_DIR_MGPIO27B_IN => GND_net_1, 
        MMUART1_CTS_MGPIO13B_IN => GND_net_1, 
        MMUART1_DCD_MGPIO16B_IN => GND_net_1, 
        MMUART1_DSR_MGPIO14B_IN => GND_net_1, 
        MMUART1_DTR_MGPIO12B_IN => GND_net_1, 
        MMUART1_RI_MGPIO15B_IN => GND_net_1, 
        MMUART1_RTS_MGPIO11B_IN => GND_net_1, 
        MMUART1_RXD_USBC_DATA3_MGPIO26B_IN => GND_net_1, 
        MMUART1_SCK_USBC_DATA4_MGPIO25B_IN => GND_net_1, 
        MMUART1_TXD_USBC_DATA2_MGPIO24B_IN => GND_net_1, 
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_IN => GND_net_1, 
        RGMII_MDC_RMII_MDC_IN => GND_net_1, 
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_IN => GND_net_1, 
        RGMII_RX_CLK_IN => GND_net_1, 
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_IN => GND_net_1, 
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_IN => GND_net_1, 
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_IN => GND_net_1, 
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_IN => GND_net_1, 
        RGMII_RXD3_USBB_DATA4_IN => GND_net_1, RGMII_TX_CLK_IN
         => GND_net_1, RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_IN => 
        GND_net_1, RGMII_TXD0_RMII_TXD0_USBB_DIR_IN => GND_net_1, 
        RGMII_TXD1_RMII_TXD1_USBB_STP_IN => GND_net_1, 
        RGMII_TXD2_USBB_DATA5_IN => GND_net_1, 
        RGMII_TXD3_USBB_DATA6_IN => GND_net_1, 
        SPI0_SCK_USBA_XCLK_IN => GND_net_1, 
        SPI0_SDI_USBA_DIR_MGPIO5A_IN => GND_net_1, 
        SPI0_SDO_USBA_STP_MGPIO6A_IN => GND_net_1, 
        SPI0_SS0_USBA_NXT_MGPIO7A_IN => GND_net_1, 
        SPI0_SS1_USBA_DATA5_MGPIO8A_IN => GND_net_1, 
        SPI0_SS2_USBA_DATA6_MGPIO9A_IN => GND_net_1, 
        SPI0_SS3_USBA_DATA7_MGPIO10A_IN => GND_net_1, 
        SPI0_SS4_MGPIO19A_IN => GND_net_1, SPI0_SS5_MGPIO20A_IN
         => GND_net_1, SPI0_SS6_MGPIO21A_IN => GND_net_1, 
        SPI0_SS7_MGPIO22A_IN => GND_net_1, SPI1_SCK_IN => 
        GND_net_1, SPI1_SDI_MGPIO11A_IN => GND_net_1, 
        SPI1_SDO_MGPIO12A_IN => GND_net_1, SPI1_SS0_MGPIO13A_IN
         => GND_net_1, SPI1_SS1_MGPIO14A_IN => GND_net_1, 
        SPI1_SS2_MGPIO15A_IN => GND_net_1, SPI1_SS3_MGPIO16A_IN
         => GND_net_1, SPI1_SS4_MGPIO17A_IN => GND_net_1, 
        SPI1_SS5_MGPIO18A_IN => GND_net_1, SPI1_SS6_MGPIO23A_IN
         => GND_net_1, SPI1_SS7_MGPIO24A_IN => GND_net_1, 
        USBC_XCLK_IN => GND_net_1, 
        CAN_RXBUS_USBA_DATA1_MGPIO3A_OUT => OPEN, 
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_OUT => OPEN, 
        CAN_TXBUS_USBA_DATA0_MGPIO2A_OUT => OPEN, DRAM_ADDR(15)
         => nc218, DRAM_ADDR(14) => nc342, DRAM_ADDR(13) => nc106, 
        DRAM_ADDR(12) => nc261, DRAM_ADDR(11) => nc25, 
        DRAM_ADDR(10) => nc1, DRAM_ADDR(9) => nc322, DRAM_ADDR(8)
         => nc299, DRAM_ADDR(7) => nc37, DRAM_ADDR(6) => nc202, 
        DRAM_ADDR(5) => nc144, DRAM_ADDR(4) => nc153, 
        DRAM_ADDR(3) => nc46, DRAM_ADDR(2) => nc258, DRAM_ADDR(1)
         => nc343, DRAM_ADDR(0) => nc71, DRAM_BA(2) => nc124, 
        DRAM_BA(1) => nc332, DRAM_BA(0) => nc81, DRAM_CASN => 
        OPEN, DRAM_CKE => OPEN, DRAM_CLK => OPEN, DRAM_CSN => 
        OPEN, DRAM_DM_RDQS_OUT(2) => nc201, DRAM_DM_RDQS_OUT(1)
         => nc168, DRAM_DM_RDQS_OUT(0) => nc323, DRAM_DQ_OUT(17)
         => nc34, DRAM_DQ_OUT(16) => nc28, DRAM_DQ_OUT(15) => 
        nc115, DRAM_DQ_OUT(14) => nc264, DRAM_DQ_OUT(13) => nc192, 
        DRAM_DQ_OUT(12) => nc319, DRAM_DQ_OUT(11) => nc134, 
        DRAM_DQ_OUT(10) => nc32, DRAM_DQ_OUT(9) => nc40, 
        DRAM_DQ_OUT(8) => nc297, DRAM_DQ_OUT(7) => nc99, 
        DRAM_DQ_OUT(6) => nc75, DRAM_DQ_OUT(5) => nc183, 
        DRAM_DQ_OUT(4) => nc345, DRAM_DQ_OUT(3) => nc333, 
        DRAM_DQ_OUT(2) => nc288, DRAM_DQ_OUT(1) => nc85, 
        DRAM_DQ_OUT(0) => nc27, DRAM_DQS_OUT(2) => nc108, 
        DRAM_DQS_OUT(1) => nc325, DRAM_DQS_OUT(0) => nc16, 
        DRAM_FIFO_WE_OUT(1) => nc155, DRAM_FIFO_WE_OUT(0) => nc51, 
        DRAM_ODT => OPEN, DRAM_RASN => OPEN, DRAM_RSTN => OPEN, 
        DRAM_WEN => OPEN, I2C0_SCL_USBC_DATA1_MGPIO31B_OUT => 
        OPEN, I2C0_SDA_USBC_DATA0_MGPIO30B_OUT => OPEN, 
        I2C1_SCL_USBA_DATA4_MGPIO1A_OUT => OPEN, 
        I2C1_SDA_USBA_DATA3_MGPIO0A_OUT => OPEN, MGPIO25A_OUT => 
        OPEN, MGPIO26A_OUT => OPEN, 
        MMUART0_CTS_USBC_DATA7_MGPIO19B_OUT => OPEN, 
        MMUART0_DCD_MGPIO22B_OUT => OPEN, 
        MMUART0_DSR_MGPIO20B_OUT => OPEN, 
        MMUART0_DTR_USBC_DATA6_MGPIO18B_OUT => OPEN, 
        MMUART0_RI_MGPIO21B_OUT => OPEN, 
        MMUART0_RTS_USBC_DATA5_MGPIO17B_OUT => OPEN, 
        MMUART0_RXD_USBC_STP_MGPIO28B_OUT => OPEN, 
        MMUART0_SCK_USBC_NXT_MGPIO29B_OUT => OPEN, 
        MMUART0_TXD_USBC_DIR_MGPIO27B_OUT => OPEN, 
        MMUART1_CTS_MGPIO13B_OUT => OPEN, 
        MMUART1_DCD_MGPIO16B_OUT => OPEN, 
        MMUART1_DSR_MGPIO14B_OUT => OPEN, 
        MMUART1_DTR_MGPIO12B_OUT => OPEN, MMUART1_RI_MGPIO15B_OUT
         => OPEN, MMUART1_RTS_MGPIO11B_OUT => OPEN, 
        MMUART1_RXD_USBC_DATA3_MGPIO26B_OUT => OPEN, 
        MMUART1_SCK_USBC_DATA4_MGPIO25B_OUT => OPEN, 
        MMUART1_TXD_USBC_DATA2_MGPIO24B_OUT => OPEN, 
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OUT => OPEN, 
        RGMII_MDC_RMII_MDC_OUT => OPEN, 
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_OUT => OPEN, 
        RGMII_RX_CLK_OUT => OPEN, 
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OUT => OPEN, 
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_OUT => OPEN, 
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_OUT => OPEN, 
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OUT => OPEN, 
        RGMII_RXD3_USBB_DATA4_OUT => OPEN, RGMII_TX_CLK_OUT => 
        OPEN, RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OUT => OPEN, 
        RGMII_TXD0_RMII_TXD0_USBB_DIR_OUT => OPEN, 
        RGMII_TXD1_RMII_TXD1_USBB_STP_OUT => OPEN, 
        RGMII_TXD2_USBB_DATA5_OUT => OPEN, 
        RGMII_TXD3_USBB_DATA6_OUT => OPEN, SPI0_SCK_USBA_XCLK_OUT
         => OPEN, SPI0_SDI_USBA_DIR_MGPIO5A_OUT => OPEN, 
        SPI0_SDO_USBA_STP_MGPIO6A_OUT => OPEN, 
        SPI0_SS0_USBA_NXT_MGPIO7A_OUT => OPEN, 
        SPI0_SS1_USBA_DATA5_MGPIO8A_OUT => OPEN, 
        SPI0_SS2_USBA_DATA6_MGPIO9A_OUT => OPEN, 
        SPI0_SS3_USBA_DATA7_MGPIO10A_OUT => OPEN, 
        SPI0_SS4_MGPIO19A_OUT => OPEN, SPI0_SS5_MGPIO20A_OUT => 
        OPEN, SPI0_SS6_MGPIO21A_OUT => OPEN, 
        SPI0_SS7_MGPIO22A_OUT => OPEN, SPI1_SCK_OUT => OPEN, 
        SPI1_SDI_MGPIO11A_OUT => OPEN, SPI1_SDO_MGPIO12A_OUT => 
        OPEN, SPI1_SS0_MGPIO13A_OUT => OPEN, 
        SPI1_SS1_MGPIO14A_OUT => OPEN, SPI1_SS2_MGPIO15A_OUT => 
        OPEN, SPI1_SS3_MGPIO16A_OUT => OPEN, 
        SPI1_SS4_MGPIO17A_OUT => OPEN, SPI1_SS5_MGPIO18A_OUT => 
        OPEN, SPI1_SS6_MGPIO23A_OUT => OPEN, 
        SPI1_SS7_MGPIO24A_OUT => OPEN, USBC_XCLK_OUT => OPEN, 
        CAN_RXBUS_USBA_DATA1_MGPIO3A_OE => OPEN, 
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_OE => OPEN, 
        CAN_TXBUS_USBA_DATA0_MGPIO2A_OE => OPEN, DM_OE(2) => 
        nc301, DM_OE(1) => nc33, DM_OE(0) => nc204, 
        DRAM_DQ_OE(17) => nc173, DRAM_DQ_OE(16) => nc278, 
        DRAM_DQ_OE(15) => nc169, DRAM_DQ_OE(14) => nc78, 
        DRAM_DQ_OE(13) => nc263, DRAM_DQ_OE(12) => nc335, 
        DRAM_DQ_OE(11) => nc24, DRAM_DQ_OE(10) => nc88, 
        DRAM_DQ_OE(9) => nc111, DRAM_DQ_OE(8) => nc55, 
        DRAM_DQ_OE(7) => nc10, DRAM_DQ_OE(6) => nc22, 
        DRAM_DQ_OE(5) => nc210, DRAM_DQ_OE(4) => nc185, 
        DRAM_DQ_OE(3) => nc143, DRAM_DQ_OE(2) => nc248, 
        DRAM_DQ_OE(1) => nc77, DRAM_DQ_OE(0) => nc6, 
        DRAM_DQS_OE(2) => nc109, DRAM_DQS_OE(1) => nc87, 
        DRAM_DQS_OE(0) => nc123, I2C0_SCL_USBC_DATA1_MGPIO31B_OE
         => OPEN, I2C0_SDA_USBC_DATA0_MGPIO30B_OE => OPEN, 
        I2C1_SCL_USBA_DATA4_MGPIO1A_OE => OPEN, 
        I2C1_SDA_USBA_DATA3_MGPIO0A_OE => OPEN, MGPIO25A_OE => 
        OPEN, MGPIO26A_OE => OPEN, 
        MMUART0_CTS_USBC_DATA7_MGPIO19B_OE => OPEN, 
        MMUART0_DCD_MGPIO22B_OE => OPEN, MMUART0_DSR_MGPIO20B_OE
         => OPEN, MMUART0_DTR_USBC_DATA6_MGPIO18B_OE => OPEN, 
        MMUART0_RI_MGPIO21B_OE => OPEN, 
        MMUART0_RTS_USBC_DATA5_MGPIO17B_OE => OPEN, 
        MMUART0_RXD_USBC_STP_MGPIO28B_OE => OPEN, 
        MMUART0_SCK_USBC_NXT_MGPIO29B_OE => OPEN, 
        MMUART0_TXD_USBC_DIR_MGPIO27B_OE => OPEN, 
        MMUART1_CTS_MGPIO13B_OE => OPEN, MMUART1_DCD_MGPIO16B_OE
         => OPEN, MMUART1_DSR_MGPIO14B_OE => OPEN, 
        MMUART1_DTR_MGPIO12B_OE => OPEN, MMUART1_RI_MGPIO15B_OE
         => OPEN, MMUART1_RTS_MGPIO11B_OE => OPEN, 
        MMUART1_RXD_USBC_DATA3_MGPIO26B_OE => OPEN, 
        MMUART1_SCK_USBC_DATA4_MGPIO25B_OE => OPEN, 
        MMUART1_TXD_USBC_DATA2_MGPIO24B_OE => OPEN, 
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OE => OPEN, 
        RGMII_MDC_RMII_MDC_OE => OPEN, 
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_OE => OPEN, 
        RGMII_RX_CLK_OE => OPEN, 
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OE => OPEN, 
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_OE => OPEN, 
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_OE => OPEN, 
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OE => OPEN, 
        RGMII_RXD3_USBB_DATA4_OE => OPEN, RGMII_TX_CLK_OE => OPEN, 
        RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OE => OPEN, 
        RGMII_TXD0_RMII_TXD0_USBB_DIR_OE => OPEN, 
        RGMII_TXD1_RMII_TXD1_USBB_STP_OE => OPEN, 
        RGMII_TXD2_USBB_DATA5_OE => OPEN, 
        RGMII_TXD3_USBB_DATA6_OE => OPEN, SPI0_SCK_USBA_XCLK_OE
         => OPEN, SPI0_SDI_USBA_DIR_MGPIO5A_OE => OPEN, 
        SPI0_SDO_USBA_STP_MGPIO6A_OE => OPEN, 
        SPI0_SS0_USBA_NXT_MGPIO7A_OE => OPEN, 
        SPI0_SS1_USBA_DATA5_MGPIO8A_OE => OPEN, 
        SPI0_SS2_USBA_DATA6_MGPIO9A_OE => OPEN, 
        SPI0_SS3_USBA_DATA7_MGPIO10A_OE => OPEN, 
        SPI0_SS4_MGPIO19A_OE => OPEN, SPI0_SS5_MGPIO20A_OE => 
        OPEN, SPI0_SS6_MGPIO21A_OE => OPEN, SPI0_SS7_MGPIO22A_OE
         => OPEN, SPI1_SCK_OE => OPEN, SPI1_SDI_MGPIO11A_OE => 
        OPEN, SPI1_SDO_MGPIO12A_OE => OPEN, SPI1_SS0_MGPIO13A_OE
         => OPEN, SPI1_SS1_MGPIO14A_OE => OPEN, 
        SPI1_SS2_MGPIO15A_OE => OPEN, SPI1_SS3_MGPIO16A_OE => 
        OPEN, SPI1_SS4_MGPIO17A_OE => OPEN, SPI1_SS5_MGPIO18A_OE
         => OPEN, SPI1_SS6_MGPIO23A_OE => OPEN, 
        SPI1_SS7_MGPIO24A_OE => OPEN, USBC_XCLK_OE => OPEN);
    
    MSS_ADLIB_INST_RNO_5 : CFG4
      generic map(INIT => x"FCF8")

      port map(A => N_23_0, B => G_24_0_a2_1_2, C => G_24_0_0_0, 
        D => G_24_0_o2_1_0, Y => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[7]\);
    
    MSS_ADLIB_INST_RNO_25 : CFG4
      generic map(INIT => x"FFEC")

      port map(A => un7_psel, B => G_25_0_o4_0, C => 
        prescale_reg(1), D => N_20, Y => G_25_0_o4_2);
    
    MSS_ADLIB_INST_RNO_24 : CFG3
      generic map(INIT => x"80")

      port map(A => N_5_1, B => N_21_1, C => G_21_0_a7_0, Y => 
        N_9);
    
    MSS_ADLIB_INST_RNO_45 : CFG4
      generic map(INIT => x"0010")

      port map(A => PRDATA_o_sn_N_6_mux, B => N_45, C => 
        CoreAPB3_0_APBmslave1_PSELx, D => 
        CoreAPB3_0_APBmslave2_PSELx, Y => N_13_0);
    
    MSS_ADLIB_INST_RNO_1 : CFG4
      generic map(INIT => x"FCEC")

      port map(A => N_21_0, B => G_25_0_0_0, C => G_25_0_a4_1_0, 
        D => G_25_0_o4_2_0, Y => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[2]\);
    
    MSS_ADLIB_INST_RNO_30 : CFG4
      generic map(INIT => x"FCFE")

      port map(A => N_21_1, B => N_10, C => N_11, D => 
        \MSS_ADLIB_INST_RNO_65\, Y => G_21_0_1);
    
    MSS_ADLIB_INST_RNO_44 : CFG2
      generic map(INIT => x"4")

      port map(A => CoreAPB3_0_APBmslave2_PSELx, B => 
        CoreAPB3_0_APBmslave1_PSELx, Y => g0_0_0);
    
    MSS_ADLIB_INST_RNO_33 : CFG4
      generic map(INIT => x"8ADF")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_777, D => N_729, Y
         => N_5_0);
    
    MSS_ADLIB_INST_RNO_75 : CFG2
      generic map(INIT => x"2")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), Y => G_24_0_a3_0_1);
    
    MSS_ADLIB_INST_RNO_26 : CFG4
      generic map(INIT => x"FFEC")

      port map(A => un7_psel, B => G_25_0_o4_0_0, C => 
        prescale_reg(2), D => N_20_0, Y => G_25_0_o4_2_0);
    
    MSS_ADLIB_INST_RNO_39 : CFG4
      generic map(INIT => x"0002")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), C => 
        CoreAPB3_0_APBmslave0_PADDR(5), D => 
        CoreAPB3_0_APBmslave0_PADDR(4), Y => G_21_0_a7_4_0);
    
    MSS_ADLIB_INST_RNO_8 : CFG4
      generic map(INIT => x"D800")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(5), B => N_941, C
         => N_9_0, D => G_24_0_a3_0, Y => N_23);
    
    MSS_ADLIB_INST_RNO_74 : CFG2
      generic map(INIT => x"2")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), Y => G_25_0_a3_0_0);
    
    MSS_ADLIB_INST_RNO_6 : CFG4
      generic map(INIT => x"8D00")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(5), B => N_936, C
         => N_5, D => G_25_0_a3_0, Y => N_21);
    
    MSS_ADLIB_INST_RNO_46 : CFG3
      generic map(INIT => x"80")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => N_60, C
         => PWM_STRETCH(4), Y => G_21_0_a7_3_0);
    
    MSS_ADLIB_INST_RNO_31 : CFG4
      generic map(INIT => x"8ADF")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_776, D => N_728, Y
         => N_5);
    
    MSS_ADLIB_INST_RNO_55 : CFG4
      generic map(INIT => x"8000")

      port map(A => PWM_STRETCH(1), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), C => G_25_0_a3_0_1, D => 
        N_60, Y => N_20);
    
    MSS_ADLIB_INST_RNO_28 : CFG4
      generic map(INIT => x"FFEC")

      port map(A => period_reg(7), B => N_22_1, C => un9_psel, D
         => PRDATA_regif_iv_0_0(7), Y => G_24_0_o2_1_0);
    
    MSS_ADLIB_INST_RNO_54 : CFG4
      generic map(INIT => x"ECA0")

      port map(A => pwm_enable_reg(2), B => period_reg(1), C => 
        un11_psel, D => un9_psel, Y => G_25_0_o4_0);
    
    MSS_ADLIB_INST_RNO_32 : CFG3
      generic map(INIT => x"54")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(7), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_62, Y => 
        G_25_0_a3_0);
    
    MSS_ADLIB_INST_RNO_9 : CFG4
      generic map(INIT => x"D800")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(5), B => N_942, C
         => N_9_2, D => G_24_0_a3_0_2, Y => N_23_0);
    
    MSS_ADLIB_INST_RNO_76 : CFG2
      generic map(INIT => x"2")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), Y => G_24_0_a3_0_0);
    
    MSS_ADLIB_INST_RNO_48 : CFG4
      generic map(INIT => x"0400")

      port map(A => GEN_N_3_mux_0, B => 
        CoreAPB3_0_APBmslave1_PSELx, C => 
        CoreAPB3_0_APBmslave2_PSELx, D => G_24_0_a2_1_0, Y => 
        N_15_0);
    
    MSS_ADLIB_INST_RNO_15 : CFG3
      generic map(INIT => x"02")

      port map(A => CoreAPB3_0_APBmslave0_PSELx, B => 
        CoreAPB3_0_APBmslave1_PSELx, C => 
        CoreAPB3_0_APBmslave2_PSELx, Y => G_24_0_a2_1);
    
    MSS_ADLIB_INST_RNO_0 : CFG4
      generic map(INIT => x"FCEC")

      port map(A => N_21, B => G_25_0_0, C => G_25_0_a4_1, D => 
        G_25_0_o4_2, Y => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[1]\);
    
    MSS_ADLIB_INST_RNO_14 : CFG4
      generic map(INIT => x"CCEC")

      port map(A => CoreAPB3_0_APBmslave2_PSELx, B => N_13_0, C
         => CoreAPB3_0_APBmslave2_PRDATA(2), D => 
        CoreAPB3_0_APBmslave1_PSELx, Y => G_25_0_0_0);
    
    MSS_ADLIB_INST_RNO_37 : CFG4
      generic map(INIT => x"7520")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(4), C => N_782, D => N_734, Y
         => N_9_2);
    
    MSS_ADLIB_INST_RNO_78 : CFG2
      generic map(INIT => x"2")

      port map(A => CONFIG_regrx(5), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), Y => G_21_0_a7_1_0);
    
    MSS_ADLIB_INST_RNO_56 : CFG4
      generic map(INIT => x"ECA0")

      port map(A => pwm_enable_reg(3), B => period_reg(2), C => 
        un11_psel, D => un9_psel, Y => G_25_0_o4_0_0);
    
    MSS_ADLIB_INST_RNO_85 : CFG3
      generic map(INIT => x"80")

      port map(A => G_8_0_a9_0_2, B => N_10_1, C => N_62, Y => 
        N_19_0);
    
    MSS_ADLIB_INST_RNO_65 : CFG3
      generic map(INIT => x"15")

      port map(A => PRDATA_regif_iv_0_0(5), B => period_reg(5), C
         => un9_psel, Y => \MSS_ADLIB_INST_RNO_65\);
    
    MSS_ADLIB_INST_RNO_16 : CFG3
      generic map(INIT => x"02")

      port map(A => CoreAPB3_0_APBmslave0_PSELx, B => 
        CoreAPB3_0_APBmslave1_PSELx, C => 
        CoreAPB3_0_APBmslave2_PSELx, Y => G_24_0_a2_1_2);
    
    MSS_ADLIB_INST_RNO_84 : CFG4
      generic map(INIT => x"8000")

      port map(A => G_8_0_a9_4_0, B => N_31, C => 
        PRDATA_generated_15_0_0_wmux_0_Y_0, D => N_62, Y => N_25);
    
    MSS_ADLIB_INST_RNO_64 : CFG4
      generic map(INIT => x"0400")

      port map(A => GEN_N_3_mux_0, B => 
        CoreAPB3_0_APBmslave1_PSELx, C => 
        CoreAPB3_0_APBmslave2_PSELx, D => G_21_0_a7_1_0, Y => 
        N_11);
    
    MSS_ADLIB_INST_RNO_58 : CFG4
      generic map(INIT => x"8000")

      port map(A => PWM_STRETCH(6), B => 
        CoreAPB3_0_APBmslave0_PADDR(7), C => G_24_0_a3_0_1, D => 
        N_60, Y => N_22_0);
    
    MSS_ADLIB_INST_RNO_18 : CFG4
      generic map(INIT => x"2000")

      port map(A => CoreAPB3_0_APBmslave0_PADDR(4), B => 
        CoreAPB3_0_APBmslave0_PADDR(6), C => N_21_1, D => 
        G_21_0_a7_3_2, Y => N_14);
    
    MSS_ADLIB_INST_RNO_86 : CFG3
      generic map(INIT => x"1D")

      port map(A => pwm_negedge_reg_0, B => 
        CoreAPB3_0_APBmslave0_PADDR(3), C => pwm_negedge_reg_16, 
        Y => N_6_0_0);
    
    MSS_ADLIB_INST_RNO_66 : CFG2
      generic map(INIT => x"1")

      port map(A => un27_psel, B => un3_prdata_o, Y => 
        \MSS_ADLIB_INST_RNO_66\);
    
    MSS_ADLIB_INST_RNO_3 : CFG4
      generic map(INIT => x"FFFE")

      port map(A => N_15, B => N_14, C => N_9, D => G_21_0_1, Y
         => \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[5]\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity SF2_MSS_sys_sb is

    port( PWM_c              : out   std_logic_vector(7 downto 0);
          GPIO_IN_c          : in    std_logic_vector(2 downto 0);
          GPIO_OUT_c         : out   std_logic_vector(2 downto 0);
          SPI_0_CLK_M2F_c    : out   std_logic;
          SPI_0_DO_M2F_c     : out   std_logic;
          SPI_0_SS0_M2F_c    : out   std_logic;
          SPI_0_SS0_M2F_OE_c : out   std_logic;
          SPI_0_SS1_M2F_c    : out   std_logic;
          SPI_0_SS2_M2F_c    : out   std_logic;
          SPI_0_SS3_M2F_c    : out   std_logic;
          SPI_0_SS4_M2F_c    : out   std_logic;
          SPI_0_CLK_F2M_c    : in    std_logic;
          SPI_0_DI_F2M_c     : in    std_logic;
          SPI_0_SS0_F2M_c    : in    std_logic;
          RX_c               : in    std_logic;
          TX_c               : out   std_logic;
          DEVRST_N           : in    std_logic
        );

end SF2_MSS_sys_sb;

architecture DEF_ARCH of SF2_MSS_sys_sb is 

  component SF2_MSS_sys_sb_CCC_0_FCCC
    port( FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC : in    std_logic := 'U';
          FAB_CCC_LOCK                                       : out   std_logic;
          CCC_0_GL1                                          : out   std_logic;
          FAB_CCC_GL0                                        : out   std_logic
        );
  end component;

  component SF2_MSS_sys_sb_CoreUARTapb_0_CoreUARTapb
    port( CoreAPB3_0_APBmslave0_PADDR   : in    std_logic_vector(4 downto 2) := (others => 'U');
          CoreAPB3_0_APBmslave2_PRDATA  : out   std_logic_vector(7 downto 0);
          CoreAPB3_0_APBmslave0_PWDATA  : in    std_logic_vector(7 downto 0) := (others => 'U');
          TX_c                          : out   std_logic;
          RX_c                          : in    std_logic := 'U';
          CoreUARTapb_0_OVERFLOW        : out   std_logic;
          CoreUARTapb_0_FRAMING_ERR     : out   std_logic;
          CoreAPB3_0_APBmslave2_PSELx   : in    std_logic := 'U';
          CoreAPB3_0_APBmslave0_PENABLE : in    std_logic := 'U';
          CoreAPB3_0_APBmslave0_PWRITE  : in    std_logic := 'U';
          CoreUARTapb_0_PARITY_ERR      : out   std_logic;
          CoreUARTapb_0_RXRDY           : out   std_logic;
          CoreUARTapb_0_TXRDY           : out   std_logic;
          FAB_CCC_GL0                   : in    std_logic := 'U';
          MSS_READY                     : in    std_logic := 'U'
        );
  end component;

  component CoreResetP
    port( SF2_MSS_sys_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N : in    std_logic := 'U';
          SF2_MSS_sys_sb_MSS_TMP_0_MSS_RESET_N_M2F      : in    std_logic := 'U';
          POWER_ON_RESET_N                              : in    std_logic := 'U';
          FAB_CCC_GL0                                   : in    std_logic := 'U';
          MSS_READY                                     : out   std_logic
        );
  end component;

  component SYSRESET
    port( POWER_ON_RESET_N : out   std_logic;
          DEVRST_N         : in    std_logic := 'U'
        );
  end component;

  component CoreGPIO
    port( GPIO_OUT_c                    : out   std_logic_vector(2 downto 0);
          CoreAPB3_0_APBmslave0_PADDR   : in    std_logic_vector(7 downto 0) := (others => 'U');
          CoreAPB3_0_APBmslave0_PWDATA  : in    std_logic_vector(7 downto 0) := (others => 'U');
          CONFIG_regrx                  : out   std_logic_vector(7 downto 3);
          GPIO_IN_c                     : in    std_logic_vector(2 downto 0) := (others => 'U');
          PRDATA_o_2_am_0               : out   std_logic;
          PRDATA_o_2_bm_0               : out   std_logic;
          int_or_i                      : out   std_logic;
          CoreAPB3_0_APBmslave0_PENABLE : in    std_logic := 'U';
          CoreAPB3_0_APBmslave1_PSELx   : in    std_logic := 'U';
          CoreAPB3_0_APBmslave0_PWRITE  : in    std_logic := 'U';
          N_45                          : out   std_logic;
          GEN_N_3_mux_0                 : out   std_logic;
          PRDATA_o_sn_N_6_mux           : out   std_logic;
          N_86_mux_0                    : out   std_logic;
          un3_prdata_o                  : out   std_logic;
          un27_psel                     : out   std_logic;
          FAB_CCC_GL0                   : in    std_logic := 'U';
          MSS_READY                     : in    std_logic := 'U'
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component SF2_MSS_sys_sb_FABOSC_0_OSC
    port( FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC : out   std_logic
        );
  end component;

  component corepwm
    port( PWM_c                              : out   std_logic_vector(7 downto 0);
          CoreAPB3_0_APBmslave0_PWDATA       : in    std_logic_vector(15 downto 0) := (others => 'U');
          pwm_enable_reg                     : out   std_logic_vector(4 downto 1);
          prescale_reg                       : out   std_logic_vector(3 downto 0);
          period_reg                         : out   std_logic_vector(7 downto 0);
          PRDATA_regif_iv_0_0                : out   std_logic_vector(7 downto 4);
          PRDATA_regif_0_iv_0_0              : out   std_logic_vector(15 downto 8);
          CoreAPB3_0_APBmslave0_PADDR        : in    std_logic_vector(7 downto 2) := (others => 'U');
          PWM_STRETCH                        : out   std_logic_vector(7 downto 0);
          pwm_negedge_reg_0                  : out   std_logic;
          pwm_negedge_reg_16                 : out   std_logic;
          pwm_negedge_reg_99                 : out   std_logic;
          pwm_negedge_reg_115                : out   std_logic;
          pwm_posedge_reg_0                  : out   std_logic;
          pwm_posedge_reg_16                 : out   std_logic;
          PRDATA_generated_15_2_0_wmux_0_Y_3 : out   std_logic;
          PRDATA_generated_15_2_0_wmux_0_Y_0 : out   std_logic;
          PRDATA_generated_15_0_0_wmux_0_Y_3 : out   std_logic;
          PRDATA_generated_15_0_0_wmux_0_Y_0 : out   std_logic;
          PRDATA_generated_6_0_0             : out   std_logic;
          CCC_0_GL1                          : in    std_logic := 'U';
          sync_update                        : out   std_logic;
          N_728                              : out   std_logic;
          N_734                              : out   std_logic;
          N_776                              : out   std_logic;
          N_733                              : out   std_logic;
          N_729                              : out   std_logic;
          N_10_1                             : out   std_logic;
          N_777                              : out   std_logic;
          N_782                              : out   std_logic;
          N_730                              : out   std_logic;
          N_731                              : out   std_logic;
          N_732                              : out   std_logic;
          N_780                              : out   std_logic;
          N_779                              : out   std_logic;
          N_781                              : out   std_logic;
          CoreAPB3_0_APBmslave0_PWRITE       : in    std_logic := 'U';
          CoreAPB3_0_APBmslave0_PSELx        : in    std_logic := 'U';
          CoreAPB3_0_APBmslave0_PENABLE      : in    std_logic := 'U';
          N_937                              : out   std_logic;
          N_942                              : out   std_logic;
          N_939                              : out   std_logic;
          N_941                              : out   std_logic;
          N_940                              : out   std_logic;
          N_936                              : out   std_logic;
          N_965                              : out   std_logic;
          N_961                              : out   std_logic;
          N_964                              : out   std_logic;
          N_963                              : out   std_logic;
          N_966                              : out   std_logic;
          N_960                              : out   std_logic;
          N_959                              : out   std_logic;
          N_962                              : out   std_logic;
          N_60                               : out   std_logic;
          un11_psel                          : out   std_logic;
          un7_psel                           : out   std_logic;
          un9_psel                           : out   std_logic;
          N_62                               : out   std_logic;
          N_166                              : out   std_logic;
          FAB_CCC_GL0                        : in    std_logic := 'U';
          MSS_READY                          : in    std_logic := 'U'
        );
  end component;

  component OR3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component CoreAPB3
    port( CoreAPB3_0_APBmslave0_PADDR                         : in    std_logic_vector(7 downto 2) := (others => 'U');
          PRDATA_regif_0_iv_0_0                               : in    std_logic_vector(15 downto 8) := (others => 'U');
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR     : in    std_logic_vector(15 downto 12) := (others => 'U');
          CONFIG_regrx_0                                      : in    std_logic := 'U';
          PWM_STRETCH_0                                       : in    std_logic := 'U';
          period_reg_0                                        : in    std_logic := 'U';
          pwm_enable_reg_0                                    : in    std_logic := 'U';
          prescale_reg_0                                      : in    std_logic := 'U';
          PRDATA_generated_15_2_0_wmux_0_Y_0                  : in    std_logic := 'U';
          PRDATA_generated_6_0_0                              : in    std_logic := 'U';
          pwm_negedge_reg_16                                  : in    std_logic := 'U';
          pwm_negedge_reg_0                                   : in    std_logic := 'U';
          PRDATA_generated_15_0_0_wmux_0_Y_0                  : in    std_logic := 'U';
          CoreAPB3_0_APBmslave2_PRDATA_0                      : in    std_logic := 'U';
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_0  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_12 : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_11 : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_10 : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_9  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_8  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_7  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_6  : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_5  : out   std_logic;
          GEN_N_3_mux_0                                       : in    std_logic := 'U';
          N_62                                                : in    std_logic := 'U';
          un9_psel                                            : in    std_logic := 'U';
          un11_psel                                           : in    std_logic := 'U';
          un7_psel                                            : in    std_logic := 'U';
          N_730                                               : in    std_logic := 'U';
          N_60                                                : in    std_logic := 'U';
          N_166                                               : in    std_logic := 'U';
          N_966                                               : in    std_logic := 'U';
          N_965                                               : in    std_logic := 'U';
          N_964                                               : in    std_logic := 'U';
          N_963                                               : in    std_logic := 'U';
          N_962                                               : in    std_logic := 'U';
          N_961                                               : in    std_logic := 'U';
          N_960                                               : in    std_logic := 'U';
          N_959                                               : in    std_logic := 'U';
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PSELx     : in    std_logic := 'U';
          N_21_1                                              : out   std_logic;
          N_21_2                                              : out   std_logic;
          CoreAPB3_0_APBmslave2_PSELx                         : out   std_logic;
          CoreAPB3_0_APBmslave1_PSELx                         : out   std_logic;
          CoreAPB3_0_APBmslave0_PSELx                         : out   std_logic
        );
  end component;

  component SF2_MSS_sys_sb_MSS
    port( CoreAPB3_0_APBmslave0_PWDATA                        : out   std_logic_vector(15 downto 0);
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR     : out   std_logic_vector(15 downto 12);
          CoreAPB3_0_APBmslave0_PADDR                         : inout   std_logic_vector(7 downto 0);
          prescale_reg                                        : in    std_logic_vector(2 downto 0) := (others => 'U');
          PWM_STRETCH                                         : in    std_logic_vector(7 downto 0) := (others => 'U');
          period_reg                                          : in    std_logic_vector(7 downto 0) := (others => 'U');
          pwm_enable_reg                                      : in    std_logic_vector(3 downto 1) := (others => 'U');
          CoreAPB3_0_APBmslave2_PRDATA                        : in    std_logic_vector(7 downto 0) := (others => 'U');
          PRDATA_regif_iv_0_0                                 : in    std_logic_vector(7 downto 4) := (others => 'U');
          CONFIG_regrx                                        : in    std_logic_vector(7 downto 4) := (others => 'U');
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_0  : in    std_logic := 'U';
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_5  : in    std_logic := 'U';
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_6  : in    std_logic := 'U';
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_7  : in    std_logic := 'U';
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_8  : in    std_logic := 'U';
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_9  : in    std_logic := 'U';
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_10 : in    std_logic := 'U';
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_11 : in    std_logic := 'U';
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_12 : in    std_logic := 'U';
          PRDATA_generated_15_2_0_wmux_0_Y_0                  : in    std_logic := 'U';
          PRDATA_generated_15_0_0_wmux_0_Y_0                  : in    std_logic := 'U';
          PRDATA_o_2_bm_0                                     : in    std_logic := 'U';
          PRDATA_o_2_am_0                                     : in    std_logic := 'U';
          pwm_posedge_reg_0                                   : in    std_logic := 'U';
          pwm_posedge_reg_16                                  : in    std_logic := 'U';
          pwm_negedge_reg_0                                   : in    std_logic := 'U';
          pwm_negedge_reg_16                                  : in    std_logic := 'U';
          FAB_CCC_GL0                                         : in    std_logic := 'U';
          SPI_0_SS0_F2M_c                                     : in    std_logic := 'U';
          SPI_0_DI_F2M_c                                      : in    std_logic := 'U';
          SPI_0_CLK_F2M_c                                     : in    std_logic := 'U';
          FAB_CCC_LOCK                                        : in    std_logic := 'U';
          int_or_i                                            : in    std_logic := 'U';
          OR3_1_Y                                             : in    std_logic := 'U';
          SPI_0_SS4_M2F_c                                     : out   std_logic;
          SPI_0_SS3_M2F_c                                     : out   std_logic;
          SPI_0_SS2_M2F_c                                     : out   std_logic;
          SPI_0_SS1_M2F_c                                     : out   std_logic;
          SPI_0_SS0_M2F_OE_c                                  : out   std_logic;
          SPI_0_SS0_M2F_c                                     : out   std_logic;
          SPI_0_DO_M2F_c                                      : out   std_logic;
          SPI_0_CLK_M2F_c                                     : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_MSS_RESET_N_M2F            : out   std_logic;
          CoreAPB3_0_APBmslave0_PWRITE                        : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PSELx     : out   std_logic;
          CoreAPB3_0_APBmslave0_PENABLE                       : out   std_logic;
          SF2_MSS_sys_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N       : out   std_logic;
          N_936                                               : in    std_logic := 'U';
          un7_psel                                            : in    std_logic := 'U';
          N_937                                               : in    std_logic := 'U';
          N_45                                                : in    std_logic := 'U';
          N_780                                               : in    std_logic := 'U';
          N_21_1                                              : in    std_logic := 'U';
          N_732                                               : in    std_logic := 'U';
          N_940                                               : in    std_logic := 'U';
          N_86_mux_0                                          : in    std_logic := 'U';
          N_941                                               : in    std_logic := 'U';
          N_779                                               : in    std_logic := 'U';
          N_21_2                                              : in    std_logic := 'U';
          N_731                                               : in    std_logic := 'U';
          N_939                                               : in    std_logic := 'U';
          N_942                                               : in    std_logic := 'U';
          un9_psel                                            : in    std_logic := 'U';
          GEN_N_3_mux_0                                       : in    std_logic := 'U';
          N_10_1                                              : in    std_logic := 'U';
          un11_psel                                           : in    std_logic := 'U';
          N_62                                                : in    std_logic := 'U';
          N_60                                                : in    std_logic := 'U';
          CoreAPB3_0_APBmslave2_PSELx                         : in    std_logic := 'U';
          CoreAPB3_0_APBmslave0_PSELx                         : in    std_logic := 'U';
          CoreAPB3_0_APBmslave1_PSELx                         : in    std_logic := 'U';
          PRDATA_o_sn_N_6_mux                                 : in    std_logic := 'U';
          un3_prdata_o                                        : in    std_logic := 'U';
          un27_psel                                           : in    std_logic := 'U';
          sync_update                                         : in    std_logic := 'U';
          N_734                                               : in    std_logic := 'U';
          N_782                                               : in    std_logic := 'U';
          N_733                                               : in    std_logic := 'U';
          N_781                                               : in    std_logic := 'U';
          N_729                                               : in    std_logic := 'U';
          N_777                                               : in    std_logic := 'U';
          N_728                                               : in    std_logic := 'U';
          N_776                                               : in    std_logic := 'U'
        );
  end component;

    signal POWER_ON_RESET_N, OR3_1_Y, OR3_0_Y, 
        CoreUARTapb_0_OVERFLOW, CoreUARTapb_0_FRAMING_ERR, 
        CoreUARTapb_0_TXRDY, CoreUARTapb_0_RXRDY, 
        CoreUARTapb_0_PARITY_ERR, 
        FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC, 
        FAB_CCC_LOCK, CCC_0_GL1, FAB_CCC_GL0, \CONFIG_regrx[3]\, 
        \PWM_STRETCH[3]\, \period_reg[3]\, \pwm_enable_reg[4]\, 
        \prescale_reg[3]\, \PRDATA_generated_15_2_0_wmux_0_Y[3]\, 
        \PRDATA_generated_6_0[3]\, \pwm_negedge_reg[116]\, 
        \pwm_negedge_reg[100]\, 
        \PRDATA_generated_15_0_0_wmux_0_Y[3]\, 
        \CoreAPB3_0_APBmslave0_PADDR[2]\, 
        \CoreAPB3_0_APBmslave0_PADDR[4]\, 
        \CoreAPB3_0_APBmslave0_PADDR[5]\, 
        \CoreAPB3_0_APBmslave0_PADDR[6]\, 
        \CoreAPB3_0_APBmslave0_PADDR[7]\, 
        \CoreAPB3_0_APBmslave2_PRDATA[3]\, 
        \PRDATA_regif_0_iv_0_0[8]\, \PRDATA_regif_0_iv_0_0[9]\, 
        \PRDATA_regif_0_iv_0_0[10]\, \PRDATA_regif_0_iv_0_0[11]\, 
        \PRDATA_regif_0_iv_0_0[12]\, \PRDATA_regif_0_iv_0_0[13]\, 
        \PRDATA_regif_0_iv_0_0[14]\, \PRDATA_regif_0_iv_0_0[15]\, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[3]\, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[15]\, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[14]\, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[13]\, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[12]\, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[11]\, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[10]\, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[9]\, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[8]\, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR[12]\, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR[13]\, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR[14]\, 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR[15]\, 
        GEN_N_3_mux_0, N_62, un9_psel, un11_psel, un7_psel, N_730, 
        N_60, N_166, N_966, N_965, N_964, N_963, N_962, N_961, 
        N_960, N_959, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PSELx, N_21_1, 
        N_21_2, CoreAPB3_0_APBmslave2_PSELx, 
        CoreAPB3_0_APBmslave1_PSELx, CoreAPB3_0_APBmslave0_PSELx, 
        \PRDATA_o_2_am[0]\, \PRDATA_o_2_bm[0]\, 
        \CoreAPB3_0_APBmslave0_PADDR[0]\, 
        \CoreAPB3_0_APBmslave0_PADDR[1]\, 
        \CoreAPB3_0_APBmslave0_PADDR[3]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[0]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[1]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[2]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[3]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[4]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[5]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[6]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[7]\, \CONFIG_regrx[4]\, 
        \CONFIG_regrx[5]\, \CONFIG_regrx[6]\, \CONFIG_regrx[7]\, 
        int_or_i, CoreAPB3_0_APBmslave0_PENABLE, 
        CoreAPB3_0_APBmslave0_PWRITE, N_45, PRDATA_o_sn_N_6_mux, 
        N_86_mux_0, un3_prdata_o, un27_psel, MSS_READY, 
        \CoreAPB3_0_APBmslave0_PWDATA[8]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[9]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[10]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[11]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[12]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[13]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[14]\, 
        \CoreAPB3_0_APBmslave0_PWDATA[15]\, \pwm_negedge_reg[1]\, 
        \pwm_negedge_reg[17]\, \pwm_enable_reg[1]\, 
        \pwm_enable_reg[2]\, \pwm_enable_reg[3]\, 
        \pwm_posedge_reg[1]\, \pwm_posedge_reg[17]\, 
        \prescale_reg[0]\, \prescale_reg[1]\, \prescale_reg[2]\, 
        \period_reg[0]\, \period_reg[1]\, \period_reg[2]\, 
        \period_reg[4]\, \period_reg[5]\, \period_reg[6]\, 
        \period_reg[7]\, \PRDATA_generated_15_2_0_wmux_0_Y[0]\, 
        \PRDATA_generated_15_0_0_wmux_0_Y[0]\, 
        \PRDATA_regif_iv_0_0[4]\, \PRDATA_regif_iv_0_0[5]\, 
        \PRDATA_regif_iv_0_0[6]\, \PRDATA_regif_iv_0_0[7]\, 
        \PWM_STRETCH[0]\, \PWM_STRETCH[1]\, \PWM_STRETCH[2]\, 
        \PWM_STRETCH[4]\, \PWM_STRETCH[5]\, \PWM_STRETCH[6]\, 
        \PWM_STRETCH[7]\, sync_update, N_728, N_734, N_776, N_733, 
        N_729, N_10_1, N_777, N_782, N_731, N_732, N_780, N_779, 
        N_781, N_937, N_942, N_939, N_941, N_940, N_936, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N, 
        SF2_MSS_sys_sb_MSS_TMP_0_MSS_RESET_N_M2F, 
        \CoreAPB3_0_APBmslave2_PRDATA[0]\, 
        \CoreAPB3_0_APBmslave2_PRDATA[1]\, 
        \CoreAPB3_0_APBmslave2_PRDATA[2]\, 
        \CoreAPB3_0_APBmslave2_PRDATA[4]\, 
        \CoreAPB3_0_APBmslave2_PRDATA[5]\, 
        \CoreAPB3_0_APBmslave2_PRDATA[6]\, 
        \CoreAPB3_0_APBmslave2_PRDATA[7]\, GND_net_1, VCC_net_1
         : std_logic;
    signal nc2, nc4, nc3, nc1 : std_logic;

    for all : SF2_MSS_sys_sb_CCC_0_FCCC
	Use entity work.SF2_MSS_sys_sb_CCC_0_FCCC(DEF_ARCH);
    for all : SF2_MSS_sys_sb_CoreUARTapb_0_CoreUARTapb
	Use entity work.
        SF2_MSS_sys_sb_CoreUARTapb_0_CoreUARTapb(DEF_ARCH);
    for all : CoreResetP
	Use entity work.CoreResetP(DEF_ARCH);
    for all : CoreGPIO
	Use entity work.CoreGPIO(DEF_ARCH);
    for all : SF2_MSS_sys_sb_FABOSC_0_OSC
	Use entity work.SF2_MSS_sys_sb_FABOSC_0_OSC(DEF_ARCH);
    for all : corepwm
	Use entity work.corepwm(DEF_ARCH);
    for all : CoreAPB3
	Use entity work.CoreAPB3(DEF_ARCH);
    for all : SF2_MSS_sys_sb_MSS
	Use entity work.SF2_MSS_sys_sb_MSS(DEF_ARCH);
begin 


    CCC_0 : SF2_MSS_sys_sb_CCC_0_FCCC
      port map(FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC
         => FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC, 
        FAB_CCC_LOCK => FAB_CCC_LOCK, CCC_0_GL1 => CCC_0_GL1, 
        FAB_CCC_GL0 => FAB_CCC_GL0);
    
    CoreUARTapb_0 : SF2_MSS_sys_sb_CoreUARTapb_0_CoreUARTapb
      port map(CoreAPB3_0_APBmslave0_PADDR(4) => 
        \CoreAPB3_0_APBmslave0_PADDR[4]\, 
        CoreAPB3_0_APBmslave0_PADDR(3) => 
        \CoreAPB3_0_APBmslave0_PADDR[3]\, 
        CoreAPB3_0_APBmslave0_PADDR(2) => 
        \CoreAPB3_0_APBmslave0_PADDR[2]\, 
        CoreAPB3_0_APBmslave2_PRDATA(7) => 
        \CoreAPB3_0_APBmslave2_PRDATA[7]\, 
        CoreAPB3_0_APBmslave2_PRDATA(6) => 
        \CoreAPB3_0_APBmslave2_PRDATA[6]\, 
        CoreAPB3_0_APBmslave2_PRDATA(5) => 
        \CoreAPB3_0_APBmslave2_PRDATA[5]\, 
        CoreAPB3_0_APBmslave2_PRDATA(4) => 
        \CoreAPB3_0_APBmslave2_PRDATA[4]\, 
        CoreAPB3_0_APBmslave2_PRDATA(3) => 
        \CoreAPB3_0_APBmslave2_PRDATA[3]\, 
        CoreAPB3_0_APBmslave2_PRDATA(2) => 
        \CoreAPB3_0_APBmslave2_PRDATA[2]\, 
        CoreAPB3_0_APBmslave2_PRDATA(1) => 
        \CoreAPB3_0_APBmslave2_PRDATA[1]\, 
        CoreAPB3_0_APBmslave2_PRDATA(0) => 
        \CoreAPB3_0_APBmslave2_PRDATA[0]\, 
        CoreAPB3_0_APBmslave0_PWDATA(7) => 
        \CoreAPB3_0_APBmslave0_PWDATA[7]\, 
        CoreAPB3_0_APBmslave0_PWDATA(6) => 
        \CoreAPB3_0_APBmslave0_PWDATA[6]\, 
        CoreAPB3_0_APBmslave0_PWDATA(5) => 
        \CoreAPB3_0_APBmslave0_PWDATA[5]\, 
        CoreAPB3_0_APBmslave0_PWDATA(4) => 
        \CoreAPB3_0_APBmslave0_PWDATA[4]\, 
        CoreAPB3_0_APBmslave0_PWDATA(3) => 
        \CoreAPB3_0_APBmslave0_PWDATA[3]\, 
        CoreAPB3_0_APBmslave0_PWDATA(2) => 
        \CoreAPB3_0_APBmslave0_PWDATA[2]\, 
        CoreAPB3_0_APBmslave0_PWDATA(1) => 
        \CoreAPB3_0_APBmslave0_PWDATA[1]\, 
        CoreAPB3_0_APBmslave0_PWDATA(0) => 
        \CoreAPB3_0_APBmslave0_PWDATA[0]\, TX_c => TX_c, RX_c => 
        RX_c, CoreUARTapb_0_OVERFLOW => CoreUARTapb_0_OVERFLOW, 
        CoreUARTapb_0_FRAMING_ERR => CoreUARTapb_0_FRAMING_ERR, 
        CoreAPB3_0_APBmslave2_PSELx => 
        CoreAPB3_0_APBmslave2_PSELx, 
        CoreAPB3_0_APBmslave0_PENABLE => 
        CoreAPB3_0_APBmslave0_PENABLE, 
        CoreAPB3_0_APBmslave0_PWRITE => 
        CoreAPB3_0_APBmslave0_PWRITE, CoreUARTapb_0_PARITY_ERR
         => CoreUARTapb_0_PARITY_ERR, CoreUARTapb_0_RXRDY => 
        CoreUARTapb_0_RXRDY, CoreUARTapb_0_TXRDY => 
        CoreUARTapb_0_TXRDY, FAB_CCC_GL0 => FAB_CCC_GL0, 
        MSS_READY => MSS_READY);
    
    CORERESETP_0 : CoreResetP
      port map(SF2_MSS_sys_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N, 
        SF2_MSS_sys_sb_MSS_TMP_0_MSS_RESET_N_M2F => 
        SF2_MSS_sys_sb_MSS_TMP_0_MSS_RESET_N_M2F, 
        POWER_ON_RESET_N => POWER_ON_RESET_N, FAB_CCC_GL0 => 
        FAB_CCC_GL0, MSS_READY => MSS_READY);
    
    SYSRESET_POR : SYSRESET
      port map(POWER_ON_RESET_N => POWER_ON_RESET_N, DEVRST_N => 
        DEVRST_N);
    
    CoreGPIO_0 : CoreGPIO
      port map(GPIO_OUT_c(2) => GPIO_OUT_c(2), GPIO_OUT_c(1) => 
        GPIO_OUT_c(1), GPIO_OUT_c(0) => GPIO_OUT_c(0), 
        CoreAPB3_0_APBmslave0_PADDR(7) => 
        \CoreAPB3_0_APBmslave0_PADDR[7]\, 
        CoreAPB3_0_APBmslave0_PADDR(6) => 
        \CoreAPB3_0_APBmslave0_PADDR[6]\, 
        CoreAPB3_0_APBmslave0_PADDR(5) => 
        \CoreAPB3_0_APBmslave0_PADDR[5]\, 
        CoreAPB3_0_APBmslave0_PADDR(4) => 
        \CoreAPB3_0_APBmslave0_PADDR[4]\, 
        CoreAPB3_0_APBmslave0_PADDR(3) => 
        \CoreAPB3_0_APBmslave0_PADDR[3]\, 
        CoreAPB3_0_APBmslave0_PADDR(2) => 
        \CoreAPB3_0_APBmslave0_PADDR[2]\, 
        CoreAPB3_0_APBmslave0_PADDR(1) => 
        \CoreAPB3_0_APBmslave0_PADDR[1]\, 
        CoreAPB3_0_APBmslave0_PADDR(0) => 
        \CoreAPB3_0_APBmslave0_PADDR[0]\, 
        CoreAPB3_0_APBmslave0_PWDATA(7) => 
        \CoreAPB3_0_APBmslave0_PWDATA[7]\, 
        CoreAPB3_0_APBmslave0_PWDATA(6) => 
        \CoreAPB3_0_APBmslave0_PWDATA[6]\, 
        CoreAPB3_0_APBmslave0_PWDATA(5) => 
        \CoreAPB3_0_APBmslave0_PWDATA[5]\, 
        CoreAPB3_0_APBmslave0_PWDATA(4) => 
        \CoreAPB3_0_APBmslave0_PWDATA[4]\, 
        CoreAPB3_0_APBmslave0_PWDATA(3) => 
        \CoreAPB3_0_APBmslave0_PWDATA[3]\, 
        CoreAPB3_0_APBmslave0_PWDATA(2) => 
        \CoreAPB3_0_APBmslave0_PWDATA[2]\, 
        CoreAPB3_0_APBmslave0_PWDATA(1) => 
        \CoreAPB3_0_APBmslave0_PWDATA[1]\, 
        CoreAPB3_0_APBmslave0_PWDATA(0) => 
        \CoreAPB3_0_APBmslave0_PWDATA[0]\, CONFIG_regrx(7) => 
        \CONFIG_regrx[7]\, CONFIG_regrx(6) => \CONFIG_regrx[6]\, 
        CONFIG_regrx(5) => \CONFIG_regrx[5]\, CONFIG_regrx(4) => 
        \CONFIG_regrx[4]\, CONFIG_regrx(3) => \CONFIG_regrx[3]\, 
        GPIO_IN_c(2) => GPIO_IN_c(2), GPIO_IN_c(1) => 
        GPIO_IN_c(1), GPIO_IN_c(0) => GPIO_IN_c(0), 
        PRDATA_o_2_am_0 => \PRDATA_o_2_am[0]\, PRDATA_o_2_bm_0
         => \PRDATA_o_2_bm[0]\, int_or_i => int_or_i, 
        CoreAPB3_0_APBmslave0_PENABLE => 
        CoreAPB3_0_APBmslave0_PENABLE, 
        CoreAPB3_0_APBmslave1_PSELx => 
        CoreAPB3_0_APBmslave1_PSELx, CoreAPB3_0_APBmslave0_PWRITE
         => CoreAPB3_0_APBmslave0_PWRITE, N_45 => N_45, 
        GEN_N_3_mux_0 => GEN_N_3_mux_0, PRDATA_o_sn_N_6_mux => 
        PRDATA_o_sn_N_6_mux, N_86_mux_0 => N_86_mux_0, 
        un3_prdata_o => un3_prdata_o, un27_psel => un27_psel, 
        FAB_CCC_GL0 => FAB_CCC_GL0, MSS_READY => MSS_READY);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    FABOSC_0 : SF2_MSS_sys_sb_FABOSC_0_OSC
      port map(FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC
         => FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC);
    
    corepwm_0_0 : corepwm
      port map(PWM_c(7) => PWM_c(7), PWM_c(6) => PWM_c(6), 
        PWM_c(5) => PWM_c(5), PWM_c(4) => PWM_c(4), PWM_c(3) => 
        PWM_c(3), PWM_c(2) => PWM_c(2), PWM_c(1) => PWM_c(1), 
        PWM_c(0) => PWM_c(0), CoreAPB3_0_APBmslave0_PWDATA(15)
         => \CoreAPB3_0_APBmslave0_PWDATA[15]\, 
        CoreAPB3_0_APBmslave0_PWDATA(14) => 
        \CoreAPB3_0_APBmslave0_PWDATA[14]\, 
        CoreAPB3_0_APBmslave0_PWDATA(13) => 
        \CoreAPB3_0_APBmslave0_PWDATA[13]\, 
        CoreAPB3_0_APBmslave0_PWDATA(12) => 
        \CoreAPB3_0_APBmslave0_PWDATA[12]\, 
        CoreAPB3_0_APBmslave0_PWDATA(11) => 
        \CoreAPB3_0_APBmslave0_PWDATA[11]\, 
        CoreAPB3_0_APBmslave0_PWDATA(10) => 
        \CoreAPB3_0_APBmslave0_PWDATA[10]\, 
        CoreAPB3_0_APBmslave0_PWDATA(9) => 
        \CoreAPB3_0_APBmslave0_PWDATA[9]\, 
        CoreAPB3_0_APBmslave0_PWDATA(8) => 
        \CoreAPB3_0_APBmslave0_PWDATA[8]\, 
        CoreAPB3_0_APBmslave0_PWDATA(7) => 
        \CoreAPB3_0_APBmslave0_PWDATA[7]\, 
        CoreAPB3_0_APBmslave0_PWDATA(6) => 
        \CoreAPB3_0_APBmslave0_PWDATA[6]\, 
        CoreAPB3_0_APBmslave0_PWDATA(5) => 
        \CoreAPB3_0_APBmslave0_PWDATA[5]\, 
        CoreAPB3_0_APBmslave0_PWDATA(4) => 
        \CoreAPB3_0_APBmslave0_PWDATA[4]\, 
        CoreAPB3_0_APBmslave0_PWDATA(3) => 
        \CoreAPB3_0_APBmslave0_PWDATA[3]\, 
        CoreAPB3_0_APBmslave0_PWDATA(2) => 
        \CoreAPB3_0_APBmslave0_PWDATA[2]\, 
        CoreAPB3_0_APBmslave0_PWDATA(1) => 
        \CoreAPB3_0_APBmslave0_PWDATA[1]\, 
        CoreAPB3_0_APBmslave0_PWDATA(0) => 
        \CoreAPB3_0_APBmslave0_PWDATA[0]\, pwm_enable_reg(4) => 
        \pwm_enable_reg[4]\, pwm_enable_reg(3) => 
        \pwm_enable_reg[3]\, pwm_enable_reg(2) => 
        \pwm_enable_reg[2]\, pwm_enable_reg(1) => 
        \pwm_enable_reg[1]\, prescale_reg(3) => \prescale_reg[3]\, 
        prescale_reg(2) => \prescale_reg[2]\, prescale_reg(1) => 
        \prescale_reg[1]\, prescale_reg(0) => \prescale_reg[0]\, 
        period_reg(7) => \period_reg[7]\, period_reg(6) => 
        \period_reg[6]\, period_reg(5) => \period_reg[5]\, 
        period_reg(4) => \period_reg[4]\, period_reg(3) => 
        \period_reg[3]\, period_reg(2) => \period_reg[2]\, 
        period_reg(1) => \period_reg[1]\, period_reg(0) => 
        \period_reg[0]\, PRDATA_regif_iv_0_0(7) => 
        \PRDATA_regif_iv_0_0[7]\, PRDATA_regif_iv_0_0(6) => 
        \PRDATA_regif_iv_0_0[6]\, PRDATA_regif_iv_0_0(5) => 
        \PRDATA_regif_iv_0_0[5]\, PRDATA_regif_iv_0_0(4) => 
        \PRDATA_regif_iv_0_0[4]\, PRDATA_regif_0_iv_0_0(15) => 
        \PRDATA_regif_0_iv_0_0[15]\, PRDATA_regif_0_iv_0_0(14)
         => \PRDATA_regif_0_iv_0_0[14]\, 
        PRDATA_regif_0_iv_0_0(13) => \PRDATA_regif_0_iv_0_0[13]\, 
        PRDATA_regif_0_iv_0_0(12) => \PRDATA_regif_0_iv_0_0[12]\, 
        PRDATA_regif_0_iv_0_0(11) => \PRDATA_regif_0_iv_0_0[11]\, 
        PRDATA_regif_0_iv_0_0(10) => \PRDATA_regif_0_iv_0_0[10]\, 
        PRDATA_regif_0_iv_0_0(9) => \PRDATA_regif_0_iv_0_0[9]\, 
        PRDATA_regif_0_iv_0_0(8) => \PRDATA_regif_0_iv_0_0[8]\, 
        CoreAPB3_0_APBmslave0_PADDR(7) => 
        \CoreAPB3_0_APBmslave0_PADDR[7]\, 
        CoreAPB3_0_APBmslave0_PADDR(6) => 
        \CoreAPB3_0_APBmslave0_PADDR[6]\, 
        CoreAPB3_0_APBmslave0_PADDR(5) => 
        \CoreAPB3_0_APBmslave0_PADDR[5]\, 
        CoreAPB3_0_APBmslave0_PADDR(4) => 
        \CoreAPB3_0_APBmslave0_PADDR[4]\, 
        CoreAPB3_0_APBmslave0_PADDR(3) => 
        \CoreAPB3_0_APBmslave0_PADDR[3]\, 
        CoreAPB3_0_APBmslave0_PADDR(2) => 
        \CoreAPB3_0_APBmslave0_PADDR[2]\, PWM_STRETCH(7) => 
        \PWM_STRETCH[7]\, PWM_STRETCH(6) => \PWM_STRETCH[6]\, 
        PWM_STRETCH(5) => \PWM_STRETCH[5]\, PWM_STRETCH(4) => 
        \PWM_STRETCH[4]\, PWM_STRETCH(3) => \PWM_STRETCH[3]\, 
        PWM_STRETCH(2) => \PWM_STRETCH[2]\, PWM_STRETCH(1) => 
        \PWM_STRETCH[1]\, PWM_STRETCH(0) => \PWM_STRETCH[0]\, 
        pwm_negedge_reg_0 => \pwm_negedge_reg[1]\, 
        pwm_negedge_reg_16 => \pwm_negedge_reg[17]\, 
        pwm_negedge_reg_99 => \pwm_negedge_reg[100]\, 
        pwm_negedge_reg_115 => \pwm_negedge_reg[116]\, 
        pwm_posedge_reg_0 => \pwm_posedge_reg[1]\, 
        pwm_posedge_reg_16 => \pwm_posedge_reg[17]\, 
        PRDATA_generated_15_2_0_wmux_0_Y_3 => 
        \PRDATA_generated_15_2_0_wmux_0_Y[3]\, 
        PRDATA_generated_15_2_0_wmux_0_Y_0 => 
        \PRDATA_generated_15_2_0_wmux_0_Y[0]\, 
        PRDATA_generated_15_0_0_wmux_0_Y_3 => 
        \PRDATA_generated_15_0_0_wmux_0_Y[3]\, 
        PRDATA_generated_15_0_0_wmux_0_Y_0 => 
        \PRDATA_generated_15_0_0_wmux_0_Y[0]\, 
        PRDATA_generated_6_0_0 => \PRDATA_generated_6_0[3]\, 
        CCC_0_GL1 => CCC_0_GL1, sync_update => sync_update, N_728
         => N_728, N_734 => N_734, N_776 => N_776, N_733 => N_733, 
        N_729 => N_729, N_10_1 => N_10_1, N_777 => N_777, N_782
         => N_782, N_730 => N_730, N_731 => N_731, N_732 => N_732, 
        N_780 => N_780, N_779 => N_779, N_781 => N_781, 
        CoreAPB3_0_APBmslave0_PWRITE => 
        CoreAPB3_0_APBmslave0_PWRITE, CoreAPB3_0_APBmslave0_PSELx
         => CoreAPB3_0_APBmslave0_PSELx, 
        CoreAPB3_0_APBmslave0_PENABLE => 
        CoreAPB3_0_APBmslave0_PENABLE, N_937 => N_937, N_942 => 
        N_942, N_939 => N_939, N_941 => N_941, N_940 => N_940, 
        N_936 => N_936, N_965 => N_965, N_961 => N_961, N_964 => 
        N_964, N_963 => N_963, N_966 => N_966, N_960 => N_960, 
        N_959 => N_959, N_962 => N_962, N_60 => N_60, un11_psel
         => un11_psel, un7_psel => un7_psel, un9_psel => un9_psel, 
        N_62 => N_62, N_166 => N_166, FAB_CCC_GL0 => FAB_CCC_GL0, 
        MSS_READY => MSS_READY);
    
    OR3_0 : OR3
      port map(A => CoreUARTapb_0_TXRDY, B => CoreUARTapb_0_RXRDY, 
        C => CoreUARTapb_0_PARITY_ERR, Y => OR3_0_Y);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    CoreAPB3_0 : CoreAPB3
      port map(CoreAPB3_0_APBmslave0_PADDR(7) => 
        \CoreAPB3_0_APBmslave0_PADDR[7]\, 
        CoreAPB3_0_APBmslave0_PADDR(6) => 
        \CoreAPB3_0_APBmslave0_PADDR[6]\, 
        CoreAPB3_0_APBmslave0_PADDR(5) => 
        \CoreAPB3_0_APBmslave0_PADDR[5]\, 
        CoreAPB3_0_APBmslave0_PADDR(4) => 
        \CoreAPB3_0_APBmslave0_PADDR[4]\, 
        CoreAPB3_0_APBmslave0_PADDR(3) => nc2, 
        CoreAPB3_0_APBmslave0_PADDR(2) => 
        \CoreAPB3_0_APBmslave0_PADDR[2]\, 
        PRDATA_regif_0_iv_0_0(15) => \PRDATA_regif_0_iv_0_0[15]\, 
        PRDATA_regif_0_iv_0_0(14) => \PRDATA_regif_0_iv_0_0[14]\, 
        PRDATA_regif_0_iv_0_0(13) => \PRDATA_regif_0_iv_0_0[13]\, 
        PRDATA_regif_0_iv_0_0(12) => \PRDATA_regif_0_iv_0_0[12]\, 
        PRDATA_regif_0_iv_0_0(11) => \PRDATA_regif_0_iv_0_0[11]\, 
        PRDATA_regif_0_iv_0_0(10) => \PRDATA_regif_0_iv_0_0[10]\, 
        PRDATA_regif_0_iv_0_0(9) => \PRDATA_regif_0_iv_0_0[9]\, 
        PRDATA_regif_0_iv_0_0(8) => \PRDATA_regif_0_iv_0_0[8]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(15) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR[15]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(14) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR[14]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(13) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR[13]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(12) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR[12]\, 
        CONFIG_regrx_0 => \CONFIG_regrx[3]\, PWM_STRETCH_0 => 
        \PWM_STRETCH[3]\, period_reg_0 => \period_reg[3]\, 
        pwm_enable_reg_0 => \pwm_enable_reg[4]\, prescale_reg_0
         => \prescale_reg[3]\, PRDATA_generated_15_2_0_wmux_0_Y_0
         => \PRDATA_generated_15_2_0_wmux_0_Y[3]\, 
        PRDATA_generated_6_0_0 => \PRDATA_generated_6_0[3]\, 
        pwm_negedge_reg_16 => \pwm_negedge_reg[116]\, 
        pwm_negedge_reg_0 => \pwm_negedge_reg[100]\, 
        PRDATA_generated_15_0_0_wmux_0_Y_0 => 
        \PRDATA_generated_15_0_0_wmux_0_Y[3]\, 
        CoreAPB3_0_APBmslave2_PRDATA_0 => 
        \CoreAPB3_0_APBmslave2_PRDATA[3]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_0 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[3]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_12 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[15]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_11 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[14]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_10 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[13]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_9 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[12]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_8 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[11]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_7 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[10]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_6 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[9]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_5 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[8]\, 
        GEN_N_3_mux_0 => GEN_N_3_mux_0, N_62 => N_62, un9_psel
         => un9_psel, un11_psel => un11_psel, un7_psel => 
        un7_psel, N_730 => N_730, N_60 => N_60, N_166 => N_166, 
        N_966 => N_966, N_965 => N_965, N_964 => N_964, N_963 => 
        N_963, N_962 => N_962, N_961 => N_961, N_960 => N_960, 
        N_959 => N_959, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PSELx => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PSELx, N_21_1
         => N_21_1, N_21_2 => N_21_2, CoreAPB3_0_APBmslave2_PSELx
         => CoreAPB3_0_APBmslave2_PSELx, 
        CoreAPB3_0_APBmslave1_PSELx => 
        CoreAPB3_0_APBmslave1_PSELx, CoreAPB3_0_APBmslave0_PSELx
         => CoreAPB3_0_APBmslave0_PSELx);
    
    SF2_MSS_sys_sb_MSS_0 : SF2_MSS_sys_sb_MSS
      port map(CoreAPB3_0_APBmslave0_PWDATA(15) => 
        \CoreAPB3_0_APBmslave0_PWDATA[15]\, 
        CoreAPB3_0_APBmslave0_PWDATA(14) => 
        \CoreAPB3_0_APBmslave0_PWDATA[14]\, 
        CoreAPB3_0_APBmslave0_PWDATA(13) => 
        \CoreAPB3_0_APBmslave0_PWDATA[13]\, 
        CoreAPB3_0_APBmslave0_PWDATA(12) => 
        \CoreAPB3_0_APBmslave0_PWDATA[12]\, 
        CoreAPB3_0_APBmslave0_PWDATA(11) => 
        \CoreAPB3_0_APBmslave0_PWDATA[11]\, 
        CoreAPB3_0_APBmslave0_PWDATA(10) => 
        \CoreAPB3_0_APBmslave0_PWDATA[10]\, 
        CoreAPB3_0_APBmslave0_PWDATA(9) => 
        \CoreAPB3_0_APBmslave0_PWDATA[9]\, 
        CoreAPB3_0_APBmslave0_PWDATA(8) => 
        \CoreAPB3_0_APBmslave0_PWDATA[8]\, 
        CoreAPB3_0_APBmslave0_PWDATA(7) => 
        \CoreAPB3_0_APBmslave0_PWDATA[7]\, 
        CoreAPB3_0_APBmslave0_PWDATA(6) => 
        \CoreAPB3_0_APBmslave0_PWDATA[6]\, 
        CoreAPB3_0_APBmslave0_PWDATA(5) => 
        \CoreAPB3_0_APBmslave0_PWDATA[5]\, 
        CoreAPB3_0_APBmslave0_PWDATA(4) => 
        \CoreAPB3_0_APBmslave0_PWDATA[4]\, 
        CoreAPB3_0_APBmslave0_PWDATA(3) => 
        \CoreAPB3_0_APBmslave0_PWDATA[3]\, 
        CoreAPB3_0_APBmslave0_PWDATA(2) => 
        \CoreAPB3_0_APBmslave0_PWDATA[2]\, 
        CoreAPB3_0_APBmslave0_PWDATA(1) => 
        \CoreAPB3_0_APBmslave0_PWDATA[1]\, 
        CoreAPB3_0_APBmslave0_PWDATA(0) => 
        \CoreAPB3_0_APBmslave0_PWDATA[0]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(15) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR[15]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(14) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR[14]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(13) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR[13]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR(12) => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PADDR[12]\, 
        CoreAPB3_0_APBmslave0_PADDR(7) => 
        \CoreAPB3_0_APBmslave0_PADDR[7]\, 
        CoreAPB3_0_APBmslave0_PADDR(6) => 
        \CoreAPB3_0_APBmslave0_PADDR[6]\, 
        CoreAPB3_0_APBmslave0_PADDR(5) => 
        \CoreAPB3_0_APBmslave0_PADDR[5]\, 
        CoreAPB3_0_APBmslave0_PADDR(4) => 
        \CoreAPB3_0_APBmslave0_PADDR[4]\, 
        CoreAPB3_0_APBmslave0_PADDR(3) => 
        \CoreAPB3_0_APBmslave0_PADDR[3]\, 
        CoreAPB3_0_APBmslave0_PADDR(2) => 
        \CoreAPB3_0_APBmslave0_PADDR[2]\, 
        CoreAPB3_0_APBmslave0_PADDR(1) => 
        \CoreAPB3_0_APBmslave0_PADDR[1]\, 
        CoreAPB3_0_APBmslave0_PADDR(0) => 
        \CoreAPB3_0_APBmslave0_PADDR[0]\, prescale_reg(2) => 
        \prescale_reg[2]\, prescale_reg(1) => \prescale_reg[1]\, 
        prescale_reg(0) => \prescale_reg[0]\, PWM_STRETCH(7) => 
        \PWM_STRETCH[7]\, PWM_STRETCH(6) => \PWM_STRETCH[6]\, 
        PWM_STRETCH(5) => \PWM_STRETCH[5]\, PWM_STRETCH(4) => 
        \PWM_STRETCH[4]\, PWM_STRETCH(3) => nc4, PWM_STRETCH(2)
         => \PWM_STRETCH[2]\, PWM_STRETCH(1) => \PWM_STRETCH[1]\, 
        PWM_STRETCH(0) => \PWM_STRETCH[0]\, period_reg(7) => 
        \period_reg[7]\, period_reg(6) => \period_reg[6]\, 
        period_reg(5) => \period_reg[5]\, period_reg(4) => 
        \period_reg[4]\, period_reg(3) => nc3, period_reg(2) => 
        \period_reg[2]\, period_reg(1) => \period_reg[1]\, 
        period_reg(0) => \period_reg[0]\, pwm_enable_reg(3) => 
        \pwm_enable_reg[3]\, pwm_enable_reg(2) => 
        \pwm_enable_reg[2]\, pwm_enable_reg(1) => 
        \pwm_enable_reg[1]\, CoreAPB3_0_APBmslave2_PRDATA(7) => 
        \CoreAPB3_0_APBmslave2_PRDATA[7]\, 
        CoreAPB3_0_APBmslave2_PRDATA(6) => 
        \CoreAPB3_0_APBmslave2_PRDATA[6]\, 
        CoreAPB3_0_APBmslave2_PRDATA(5) => 
        \CoreAPB3_0_APBmslave2_PRDATA[5]\, 
        CoreAPB3_0_APBmslave2_PRDATA(4) => 
        \CoreAPB3_0_APBmslave2_PRDATA[4]\, 
        CoreAPB3_0_APBmslave2_PRDATA(3) => nc1, 
        CoreAPB3_0_APBmslave2_PRDATA(2) => 
        \CoreAPB3_0_APBmslave2_PRDATA[2]\, 
        CoreAPB3_0_APBmslave2_PRDATA(1) => 
        \CoreAPB3_0_APBmslave2_PRDATA[1]\, 
        CoreAPB3_0_APBmslave2_PRDATA(0) => 
        \CoreAPB3_0_APBmslave2_PRDATA[0]\, PRDATA_regif_iv_0_0(7)
         => \PRDATA_regif_iv_0_0[7]\, PRDATA_regif_iv_0_0(6) => 
        \PRDATA_regif_iv_0_0[6]\, PRDATA_regif_iv_0_0(5) => 
        \PRDATA_regif_iv_0_0[5]\, PRDATA_regif_iv_0_0(4) => 
        \PRDATA_regif_iv_0_0[4]\, CONFIG_regrx(7) => 
        \CONFIG_regrx[7]\, CONFIG_regrx(6) => \CONFIG_regrx[6]\, 
        CONFIG_regrx(5) => \CONFIG_regrx[5]\, CONFIG_regrx(4) => 
        \CONFIG_regrx[4]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_0 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[3]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_5 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[8]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_6 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[9]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_7 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[10]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_8 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[11]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_9 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[12]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_10 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[13]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_11 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[14]\, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA_12 => 
        \SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PRDATA[15]\, 
        PRDATA_generated_15_2_0_wmux_0_Y_0 => 
        \PRDATA_generated_15_2_0_wmux_0_Y[0]\, 
        PRDATA_generated_15_0_0_wmux_0_Y_0 => 
        \PRDATA_generated_15_0_0_wmux_0_Y[0]\, PRDATA_o_2_bm_0
         => \PRDATA_o_2_bm[0]\, PRDATA_o_2_am_0 => 
        \PRDATA_o_2_am[0]\, pwm_posedge_reg_0 => 
        \pwm_posedge_reg[1]\, pwm_posedge_reg_16 => 
        \pwm_posedge_reg[17]\, pwm_negedge_reg_0 => 
        \pwm_negedge_reg[1]\, pwm_negedge_reg_16 => 
        \pwm_negedge_reg[17]\, FAB_CCC_GL0 => FAB_CCC_GL0, 
        SPI_0_SS0_F2M_c => SPI_0_SS0_F2M_c, SPI_0_DI_F2M_c => 
        SPI_0_DI_F2M_c, SPI_0_CLK_F2M_c => SPI_0_CLK_F2M_c, 
        FAB_CCC_LOCK => FAB_CCC_LOCK, int_or_i => int_or_i, 
        OR3_1_Y => OR3_1_Y, SPI_0_SS4_M2F_c => SPI_0_SS4_M2F_c, 
        SPI_0_SS3_M2F_c => SPI_0_SS3_M2F_c, SPI_0_SS2_M2F_c => 
        SPI_0_SS2_M2F_c, SPI_0_SS1_M2F_c => SPI_0_SS1_M2F_c, 
        SPI_0_SS0_M2F_OE_c => SPI_0_SS0_M2F_OE_c, SPI_0_SS0_M2F_c
         => SPI_0_SS0_M2F_c, SPI_0_DO_M2F_c => SPI_0_DO_M2F_c, 
        SPI_0_CLK_M2F_c => SPI_0_CLK_M2F_c, 
        SF2_MSS_sys_sb_MSS_TMP_0_MSS_RESET_N_M2F => 
        SF2_MSS_sys_sb_MSS_TMP_0_MSS_RESET_N_M2F, 
        CoreAPB3_0_APBmslave0_PWRITE => 
        CoreAPB3_0_APBmslave0_PWRITE, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PSELx => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_0_APB_MASTER_PSELx, 
        CoreAPB3_0_APBmslave0_PENABLE => 
        CoreAPB3_0_APBmslave0_PENABLE, 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N => 
        SF2_MSS_sys_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N, N_936 => 
        N_936, un7_psel => un7_psel, N_937 => N_937, N_45 => N_45, 
        N_780 => N_780, N_21_1 => N_21_1, N_732 => N_732, N_940
         => N_940, N_86_mux_0 => N_86_mux_0, N_941 => N_941, 
        N_779 => N_779, N_21_2 => N_21_2, N_731 => N_731, N_939
         => N_939, N_942 => N_942, un9_psel => un9_psel, 
        GEN_N_3_mux_0 => GEN_N_3_mux_0, N_10_1 => N_10_1, 
        un11_psel => un11_psel, N_62 => N_62, N_60 => N_60, 
        CoreAPB3_0_APBmslave2_PSELx => 
        CoreAPB3_0_APBmslave2_PSELx, CoreAPB3_0_APBmslave0_PSELx
         => CoreAPB3_0_APBmslave0_PSELx, 
        CoreAPB3_0_APBmslave1_PSELx => 
        CoreAPB3_0_APBmslave1_PSELx, PRDATA_o_sn_N_6_mux => 
        PRDATA_o_sn_N_6_mux, un3_prdata_o => un3_prdata_o, 
        un27_psel => un27_psel, sync_update => sync_update, N_734
         => N_734, N_782 => N_782, N_733 => N_733, N_781 => N_781, 
        N_729 => N_729, N_777 => N_777, N_728 => N_728, N_776 => 
        N_776);
    
    OR3_1 : OR3
      port map(A => OR3_0_Y, B => CoreUARTapb_0_OVERFLOW, C => 
        CoreUARTapb_0_FRAMING_ERR, Y => OR3_1_Y);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity SF2_MSS_sys is

    port( GPIO_IN          : in    std_logic_vector(2 downto 0);
          GPIO_OUT         : out   std_logic_vector(2 downto 0);
          PWM              : out   std_logic_vector(7 downto 0);
          DEVRST_N         : in    std_logic;
          RX               : in    std_logic;
          SPI_0_CLK_F2M    : in    std_logic;
          SPI_0_DI_F2M     : in    std_logic;
          SPI_0_SS0_F2M    : in    std_logic;
          SPI_0_CLK_M2F    : out   std_logic;
          SPI_0_DO_M2F     : out   std_logic;
          SPI_0_SS0_M2F    : out   std_logic;
          SPI_0_SS0_M2F_OE : out   std_logic;
          SPI_0_SS1_M2F    : out   std_logic;
          SPI_0_SS2_M2F    : out   std_logic;
          SPI_0_SS3_M2F    : out   std_logic;
          SPI_0_SS4_M2F    : out   std_logic;
          TX               : out   std_logic
        );

end SF2_MSS_sys;

architecture DEF_ARCH of SF2_MSS_sys is 

  component OUTBUF
    generic (IOSTD:string := "");

    port( D   : in    std_logic := 'U';
          PAD : out   std_logic
        );
  end component;

  component INBUF
    generic (IOSTD:string := "");

    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component SF2_MSS_sys_sb
    port( PWM_c              : out   std_logic_vector(7 downto 0);
          GPIO_IN_c          : in    std_logic_vector(2 downto 0) := (others => 'U');
          GPIO_OUT_c         : out   std_logic_vector(2 downto 0);
          SPI_0_CLK_M2F_c    : out   std_logic;
          SPI_0_DO_M2F_c     : out   std_logic;
          SPI_0_SS0_M2F_c    : out   std_logic;
          SPI_0_SS0_M2F_OE_c : out   std_logic;
          SPI_0_SS1_M2F_c    : out   std_logic;
          SPI_0_SS2_M2F_c    : out   std_logic;
          SPI_0_SS3_M2F_c    : out   std_logic;
          SPI_0_SS4_M2F_c    : out   std_logic;
          SPI_0_CLK_F2M_c    : in    std_logic := 'U';
          SPI_0_DI_F2M_c     : in    std_logic := 'U';
          SPI_0_SS0_F2M_c    : in    std_logic := 'U';
          RX_c               : in    std_logic := 'U';
          TX_c               : out   std_logic;
          DEVRST_N           : in    std_logic := 'U'
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

    signal VCC_net_1, GND_net_1, \GPIO_IN_c[0]\, \GPIO_IN_c[1]\, 
        \GPIO_IN_c[2]\, RX_c, SPI_0_CLK_F2M_c, SPI_0_DI_F2M_c, 
        SPI_0_SS0_F2M_c, \GPIO_OUT_c[0]\, \GPIO_OUT_c[1]\, 
        \GPIO_OUT_c[2]\, \PWM_c[0]\, \PWM_c[1]\, \PWM_c[2]\, 
        \PWM_c[3]\, \PWM_c[4]\, \PWM_c[5]\, \PWM_c[6]\, 
        \PWM_c[7]\, SPI_0_CLK_M2F_c, SPI_0_DO_M2F_c, 
        SPI_0_SS0_M2F_c, SPI_0_SS0_M2F_OE_c, SPI_0_SS1_M2F_c, 
        SPI_0_SS2_M2F_c, SPI_0_SS3_M2F_c, SPI_0_SS4_M2F_c, TX_c
         : std_logic;

    for all : SF2_MSS_sys_sb
	Use entity work.SF2_MSS_sys_sb(DEF_ARCH);
begin 


    SPI_0_SS4_M2F_obuf : OUTBUF
      port map(D => SPI_0_SS4_M2F_c, PAD => SPI_0_SS4_M2F);
    
    \PWM_obuf[3]\ : OUTBUF
      port map(D => \PWM_c[3]\, PAD => PWM(3));
    
    \GPIO_IN_ibuf[2]\ : INBUF
      port map(PAD => GPIO_IN(2), Y => \GPIO_IN_c[2]\);
    
    TX_obuf : OUTBUF
      port map(D => TX_c, PAD => TX);
    
    \GPIO_OUT_obuf[0]\ : OUTBUF
      port map(D => \GPIO_OUT_c[0]\, PAD => GPIO_OUT(0));
    
    \GPIO_IN_ibuf[1]\ : INBUF
      port map(PAD => GPIO_IN(1), Y => \GPIO_IN_c[1]\);
    
    SPI_0_DO_M2F_obuf : OUTBUF
      port map(D => SPI_0_DO_M2F_c, PAD => SPI_0_DO_M2F);
    
    SPI_0_CLK_M2F_obuf : OUTBUF
      port map(D => SPI_0_CLK_M2F_c, PAD => SPI_0_CLK_M2F);
    
    \GPIO_IN_ibuf[0]\ : INBUF
      port map(PAD => GPIO_IN(0), Y => \GPIO_IN_c[0]\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    SPI_0_SS0_F2M_ibuf : INBUF
      port map(PAD => SPI_0_SS0_F2M, Y => SPI_0_SS0_F2M_c);
    
    \PWM_obuf[0]\ : OUTBUF
      port map(D => \PWM_c[0]\, PAD => PWM(0));
    
    \PWM_obuf[7]\ : OUTBUF
      port map(D => \PWM_c[7]\, PAD => PWM(7));
    
    SPI_0_SS0_M2F_obuf : OUTBUF
      port map(D => SPI_0_SS0_M2F_c, PAD => SPI_0_SS0_M2F);
    
    \PWM_obuf[1]\ : OUTBUF
      port map(D => \PWM_c[1]\, PAD => PWM(1));
    
    \PWM_obuf[2]\ : OUTBUF
      port map(D => \PWM_c[2]\, PAD => PWM(2));
    
    \GPIO_OUT_obuf[2]\ : OUTBUF
      port map(D => \GPIO_OUT_c[2]\, PAD => GPIO_OUT(2));
    
    \GPIO_OUT_obuf[1]\ : OUTBUF
      port map(D => \GPIO_OUT_c[1]\, PAD => GPIO_OUT(1));
    
    RX_ibuf : INBUF
      port map(PAD => RX, Y => RX_c);
    
    \PWM_obuf[6]\ : OUTBUF
      port map(D => \PWM_c[6]\, PAD => PWM(6));
    
    SPI_0_SS0_M2F_OE_obuf : OUTBUF
      port map(D => SPI_0_SS0_M2F_OE_c, PAD => SPI_0_SS0_M2F_OE);
    
    SPI_0_DI_F2M_ibuf : INBUF
      port map(PAD => SPI_0_DI_F2M, Y => SPI_0_DI_F2M_c);
    
    SPI_0_SS1_M2F_obuf : OUTBUF
      port map(D => SPI_0_SS1_M2F_c, PAD => SPI_0_SS1_M2F);
    
    SF2_MSS_sys_sb_0 : SF2_MSS_sys_sb
      port map(PWM_c(7) => \PWM_c[7]\, PWM_c(6) => \PWM_c[6]\, 
        PWM_c(5) => \PWM_c[5]\, PWM_c(4) => \PWM_c[4]\, PWM_c(3)
         => \PWM_c[3]\, PWM_c(2) => \PWM_c[2]\, PWM_c(1) => 
        \PWM_c[1]\, PWM_c(0) => \PWM_c[0]\, GPIO_IN_c(2) => 
        \GPIO_IN_c[2]\, GPIO_IN_c(1) => \GPIO_IN_c[1]\, 
        GPIO_IN_c(0) => \GPIO_IN_c[0]\, GPIO_OUT_c(2) => 
        \GPIO_OUT_c[2]\, GPIO_OUT_c(1) => \GPIO_OUT_c[1]\, 
        GPIO_OUT_c(0) => \GPIO_OUT_c[0]\, SPI_0_CLK_M2F_c => 
        SPI_0_CLK_M2F_c, SPI_0_DO_M2F_c => SPI_0_DO_M2F_c, 
        SPI_0_SS0_M2F_c => SPI_0_SS0_M2F_c, SPI_0_SS0_M2F_OE_c
         => SPI_0_SS0_M2F_OE_c, SPI_0_SS1_M2F_c => 
        SPI_0_SS1_M2F_c, SPI_0_SS2_M2F_c => SPI_0_SS2_M2F_c, 
        SPI_0_SS3_M2F_c => SPI_0_SS3_M2F_c, SPI_0_SS4_M2F_c => 
        SPI_0_SS4_M2F_c, SPI_0_CLK_F2M_c => SPI_0_CLK_F2M_c, 
        SPI_0_DI_F2M_c => SPI_0_DI_F2M_c, SPI_0_SS0_F2M_c => 
        SPI_0_SS0_F2M_c, RX_c => RX_c, TX_c => TX_c, DEVRST_N => 
        DEVRST_N);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    SPI_0_SS2_M2F_obuf : OUTBUF
      port map(D => SPI_0_SS2_M2F_c, PAD => SPI_0_SS2_M2F);
    
    SPI_0_CLK_F2M_ibuf : INBUF
      port map(PAD => SPI_0_CLK_F2M, Y => SPI_0_CLK_F2M_c);
    
    \PWM_obuf[4]\ : OUTBUF
      port map(D => \PWM_c[4]\, PAD => PWM(4));
    
    SPI_0_SS3_M2F_obuf : OUTBUF
      port map(D => SPI_0_SS3_M2F_c, PAD => SPI_0_SS3_M2F);
    
    \PWM_obuf[5]\ : OUTBUF
      port map(D => \PWM_c[5]\, PAD => PWM(5));
    

end DEF_ARCH; 
