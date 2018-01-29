-- Version: v11.8 SP2 11.8.2.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity SF2_MSS_sys_sb_CCC_0_FCCC is

    port( RCOSC_25_50MHZ : in    std_logic;
          LOCK           : out   std_logic;
          GL0            : out   std_logic;
          GL1            : out   std_logic;
          GL2            : out   std_logic
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

    signal gnd_net, vcc_net, GL0_net, GL1_net, GL2_net
         : std_logic;
    signal nc8, nc7, nc6, nc2, nc5, nc4, nc3, nc1 : std_logic;

begin 


    GL1_INST : CLKINT
      port map(A => GL1_net, Y => GL1);
    
    vcc_inst : VCC
      port map(Y => vcc_net);
    
    gnd_inst : GND
      port map(Y => gnd_net);
    
    GL2_INST : CLKINT
      port map(A => GL2_net, Y => GL2);
    
    GL0_INST : CLKINT
      port map(A => GL0_net, Y => GL0);
    
    CCC_INST : CCC

              generic map(INIT => "00" & x"000007FA8000044974001F18C2B09C230739DEC048E300800D04",
         VCOFREQUENCY => 560.000)

      port map(Y0 => OPEN, Y1 => OPEN, Y2 => OPEN, Y3 => OPEN, 
        PRDATA(7) => nc8, PRDATA(6) => nc7, PRDATA(5) => nc6, 
        PRDATA(4) => nc2, PRDATA(3) => nc5, PRDATA(2) => nc4, 
        PRDATA(1) => nc3, PRDATA(0) => nc1, LOCK => LOCK, BUSY
         => OPEN, CLK0 => vcc_net, CLK1 => vcc_net, CLK2 => 
        vcc_net, CLK3 => vcc_net, NGMUX0_SEL => gnd_net, 
        NGMUX1_SEL => gnd_net, NGMUX2_SEL => gnd_net, NGMUX3_SEL
         => gnd_net, NGMUX0_HOLD_N => vcc_net, NGMUX1_HOLD_N => 
        vcc_net, NGMUX2_HOLD_N => vcc_net, NGMUX3_HOLD_N => 
        vcc_net, NGMUX0_ARST_N => vcc_net, NGMUX1_ARST_N => 
        vcc_net, NGMUX2_ARST_N => vcc_net, NGMUX3_ARST_N => 
        vcc_net, PLL_BYPASS_N => vcc_net, PLL_ARST_N => vcc_net, 
        PLL_POWERDOWN_N => vcc_net, GPD0_ARST_N => vcc_net, 
        GPD1_ARST_N => vcc_net, GPD2_ARST_N => vcc_net, 
        GPD3_ARST_N => vcc_net, PRESET_N => gnd_net, PCLK => 
        vcc_net, PSEL => vcc_net, PENABLE => vcc_net, PWRITE => 
        vcc_net, PADDR(7) => vcc_net, PADDR(6) => vcc_net, 
        PADDR(5) => vcc_net, PADDR(4) => vcc_net, PADDR(3) => 
        vcc_net, PADDR(2) => vcc_net, PWDATA(7) => vcc_net, 
        PWDATA(6) => vcc_net, PWDATA(5) => vcc_net, PWDATA(4) => 
        vcc_net, PWDATA(3) => vcc_net, PWDATA(2) => vcc_net, 
        PWDATA(1) => vcc_net, PWDATA(0) => vcc_net, CLK0_PAD => 
        gnd_net, CLK1_PAD => gnd_net, CLK2_PAD => gnd_net, 
        CLK3_PAD => gnd_net, GL0 => GL0_net, GL1 => GL1_net, GL2
         => GL2_net, GL3 => OPEN, RCOSC_25_50MHZ => 
        RCOSC_25_50MHZ, RCOSC_1MHZ => gnd_net, XTLOSC => gnd_net);
    

end DEF_ARCH; 
