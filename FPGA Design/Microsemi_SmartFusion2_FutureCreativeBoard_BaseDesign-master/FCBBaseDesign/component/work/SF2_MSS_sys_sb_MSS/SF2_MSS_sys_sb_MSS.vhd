----------------------------------------------------------------------
-- Created by SmartDesign Sun Feb 19 14:15:30 2017
-- Version: v11.7 SP2 11.7.2.2
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion2;
use smartfusion2.all;
----------------------------------------------------------------------
-- SF2_MSS_sys_sb_MSS entity declaration
----------------------------------------------------------------------
entity SF2_MSS_sys_sb_MSS is
    -- Port list
    port(
        -- Inputs
        FIC_0_APB_M_PRDATA     : in  std_logic_vector(31 downto 0);
        FIC_0_APB_M_PREADY     : in  std_logic;
        FIC_0_APB_M_PSLVERR    : in  std_logic;
        FIC_2_APB_M_PRDATA     : in  std_logic_vector(31 downto 0);
        FIC_2_APB_M_PREADY     : in  std_logic;
        FIC_2_APB_M_PSLVERR    : in  std_logic;
        MCCC_CLK_BASE          : in  std_logic;
        MCCC_CLK_BASE_PLL_LOCK : in  std_logic;
        MSS_INT_F2M            : in  std_logic_vector(15 downto 0);
        MSS_RESET_N_F2M        : in  std_logic;
        SPI_0_CLK_F2M          : in  std_logic;
        SPI_0_DI_F2M           : in  std_logic;
        SPI_0_SS0_F2M          : in  std_logic;
        -- Outputs
        FIC_0_APB_M_PADDR      : out std_logic_vector(31 downto 0);
        FIC_0_APB_M_PENABLE    : out std_logic;
        FIC_0_APB_M_PSEL       : out std_logic;
        FIC_0_APB_M_PWDATA     : out std_logic_vector(31 downto 0);
        FIC_0_APB_M_PWRITE     : out std_logic;
        FIC_2_APB_M_PADDR      : out std_logic_vector(15 downto 2);
        FIC_2_APB_M_PCLK       : out std_logic;
        FIC_2_APB_M_PENABLE    : out std_logic;
        FIC_2_APB_M_PRESET_N   : out std_logic;
        FIC_2_APB_M_PSEL       : out std_logic;
        FIC_2_APB_M_PWDATA     : out std_logic_vector(31 downto 0);
        FIC_2_APB_M_PWRITE     : out std_logic;
        MSS_RESET_N_M2F        : out std_logic;
        SPI_0_CLK_M2F          : out std_logic;
        SPI_0_DO_M2F           : out std_logic;
        SPI_0_SS0_M2F          : out std_logic;
        SPI_0_SS0_M2F_OE       : out std_logic;
        SPI_0_SS1_M2F          : out std_logic;
        SPI_0_SS2_M2F          : out std_logic;
        SPI_0_SS3_M2F          : out std_logic;
        SPI_0_SS4_M2F          : out std_logic
        );
end SF2_MSS_sys_sb_MSS;
----------------------------------------------------------------------
-- SF2_MSS_sys_sb_MSS architecture body
----------------------------------------------------------------------
architecture RTL of SF2_MSS_sys_sb_MSS is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- MSS_025
component MSS_025
    generic( 
        INIT              : std_logic_vector(1437 downto 0) := "00" & x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
        ACT_UBITS         : std_logic_vector(55 downto 0)   := x"FFFFFFFFFFFFFF" ;
        MEMORYFILE        : string                          := "" ;
        RTC_MAIN_XTL_FREQ : real                            := 0.0 ;
        RTC_MAIN_XTL_MODE : string                          := "1" ;
        DDR_CLK_FREQ      : real                            := 0.0 
        );
    -- Port list
    port(
        -- Inputs
        CAN_RXBUS_F2H_SCP                       : in  std_logic;
        CAN_RXBUS_USBA_DATA1_MGPIO3A_IN         : in  std_logic;
        CAN_TXBUS_F2H_SCP                       : in  std_logic;
        CAN_TXBUS_USBA_DATA0_MGPIO2A_IN         : in  std_logic;
        CAN_TX_EBL_F2H_SCP                      : in  std_logic;
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_IN        : in  std_logic;
        CLK_BASE                                : in  std_logic;
        CLK_MDDR_APB                            : in  std_logic;
        COLF                                    : in  std_logic;
        CRSF                                    : in  std_logic;
        DM_IN                                   : in  std_logic_vector(2 downto 0);
        DRAM_DQS_IN                             : in  std_logic_vector(2 downto 0);
        DRAM_DQ_IN                              : in  std_logic_vector(17 downto 0);
        DRAM_FIFO_WE_IN                         : in  std_logic_vector(1 downto 0);
        F2HCALIB                                : in  std_logic;
        F2H_INTERRUPT                           : in  std_logic_vector(15 downto 0);
        F2_DMAREADY                             : in  std_logic_vector(1 downto 0);
        FAB_AVALID                              : in  std_logic;
        FAB_HOSTDISCON                          : in  std_logic;
        FAB_IDDIG                               : in  std_logic;
        FAB_LINESTATE                           : in  std_logic_vector(1 downto 0);
        FAB_M3_RESET_N                          : in  std_logic;
        FAB_PLL_LOCK                            : in  std_logic;
        FAB_RXACTIVE                            : in  std_logic;
        FAB_RXERROR                             : in  std_logic;
        FAB_RXVALID                             : in  std_logic;
        FAB_RXVALIDH                            : in  std_logic;
        FAB_SESSEND                             : in  std_logic;
        FAB_TXREADY                             : in  std_logic;
        FAB_VBUSVALID                           : in  std_logic;
        FAB_VSTATUS                             : in  std_logic_vector(7 downto 0);
        FAB_XDATAIN                             : in  std_logic_vector(7 downto 0);
        FPGA_MDDR_ARESET_N                      : in  std_logic;
        F_ARADDR_HADDR1                         : in  std_logic_vector(31 downto 0);
        F_ARBURST_HTRANS1                       : in  std_logic_vector(1 downto 0);
        F_ARID_HSEL1                            : in  std_logic_vector(3 downto 0);
        F_ARLEN_HBURST1                         : in  std_logic_vector(3 downto 0);
        F_ARLOCK_HMASTLOCK1                     : in  std_logic_vector(1 downto 0);
        F_ARSIZE_HSIZE1                         : in  std_logic_vector(1 downto 0);
        F_ARVALID_HWRITE1                       : in  std_logic;
        F_AWADDR_HADDR0                         : in  std_logic_vector(31 downto 0);
        F_AWBURST_HTRANS0                       : in  std_logic_vector(1 downto 0);
        F_AWID_HSEL0                            : in  std_logic_vector(3 downto 0);
        F_AWLEN_HBURST0                         : in  std_logic_vector(3 downto 0);
        F_AWLOCK_HMASTLOCK0                     : in  std_logic_vector(1 downto 0);
        F_AWSIZE_HSIZE0                         : in  std_logic_vector(1 downto 0);
        F_AWVALID_HWRITE0                       : in  std_logic;
        F_BREADY                                : in  std_logic;
        F_DMAREADY                              : in  std_logic_vector(1 downto 0);
        F_FM0_ADDR                              : in  std_logic_vector(31 downto 0);
        F_FM0_ENABLE                            : in  std_logic;
        F_FM0_MASTLOCK                          : in  std_logic;
        F_FM0_READY                             : in  std_logic;
        F_FM0_SEL                               : in  std_logic;
        F_FM0_SIZE                              : in  std_logic_vector(1 downto 0);
        F_FM0_TRANS1                            : in  std_logic;
        F_FM0_WDATA                             : in  std_logic_vector(31 downto 0);
        F_FM0_WRITE                             : in  std_logic;
        F_HM0_RDATA                             : in  std_logic_vector(31 downto 0);
        F_HM0_READY                             : in  std_logic;
        F_HM0_RESP                              : in  std_logic;
        F_RMW_AXI                               : in  std_logic;
        F_RREADY                                : in  std_logic;
        F_WDATA_HWDATA01                        : in  std_logic_vector(63 downto 0);
        F_WID_HREADY01                          : in  std_logic_vector(3 downto 0);
        F_WLAST                                 : in  std_logic;
        F_WSTRB                                 : in  std_logic_vector(7 downto 0);
        F_WVALID                                : in  std_logic;
        GTX_CLKPF                               : in  std_logic;
        I2C0_BCLK                               : in  std_logic;
        I2C0_SCL_F2H_SCP                        : in  std_logic;
        I2C0_SCL_USBC_DATA1_MGPIO31B_IN         : in  std_logic;
        I2C0_SDA_F2H_SCP                        : in  std_logic;
        I2C0_SDA_USBC_DATA0_MGPIO30B_IN         : in  std_logic;
        I2C1_BCLK                               : in  std_logic;
        I2C1_SCL_F2H_SCP                        : in  std_logic;
        I2C1_SCL_USBA_DATA4_MGPIO1A_IN          : in  std_logic;
        I2C1_SDA_F2H_SCP                        : in  std_logic;
        I2C1_SDA_USBA_DATA3_MGPIO0A_IN          : in  std_logic;
        MDDR_FABRIC_PADDR                       : in  std_logic_vector(10 downto 2);
        MDDR_FABRIC_PENABLE                     : in  std_logic;
        MDDR_FABRIC_PSEL                        : in  std_logic;
        MDDR_FABRIC_PWDATA                      : in  std_logic_vector(15 downto 0);
        MDDR_FABRIC_PWRITE                      : in  std_logic;
        MDIF                                    : in  std_logic;
        MGPIO0A_F2H_GPIN                        : in  std_logic;
        MGPIO10A_F2H_GPIN                       : in  std_logic;
        MGPIO11A_F2H_GPIN                       : in  std_logic;
        MGPIO11B_F2H_GPIN                       : in  std_logic;
        MGPIO12A_F2H_GPIN                       : in  std_logic;
        MGPIO13A_F2H_GPIN                       : in  std_logic;
        MGPIO14A_F2H_GPIN                       : in  std_logic;
        MGPIO15A_F2H_GPIN                       : in  std_logic;
        MGPIO16A_F2H_GPIN                       : in  std_logic;
        MGPIO17B_F2H_GPIN                       : in  std_logic;
        MGPIO18B_F2H_GPIN                       : in  std_logic;
        MGPIO19B_F2H_GPIN                       : in  std_logic;
        MGPIO1A_F2H_GPIN                        : in  std_logic;
        MGPIO20B_F2H_GPIN                       : in  std_logic;
        MGPIO21B_F2H_GPIN                       : in  std_logic;
        MGPIO22B_F2H_GPIN                       : in  std_logic;
        MGPIO24B_F2H_GPIN                       : in  std_logic;
        MGPIO25A_IN                             : in  std_logic;
        MGPIO25B_F2H_GPIN                       : in  std_logic;
        MGPIO26A_IN                             : in  std_logic;
        MGPIO26B_F2H_GPIN                       : in  std_logic;
        MGPIO27B_F2H_GPIN                       : in  std_logic;
        MGPIO28B_F2H_GPIN                       : in  std_logic;
        MGPIO29B_F2H_GPIN                       : in  std_logic;
        MGPIO2A_F2H_GPIN                        : in  std_logic;
        MGPIO30B_F2H_GPIN                       : in  std_logic;
        MGPIO31B_F2H_GPIN                       : in  std_logic;
        MGPIO3A_F2H_GPIN                        : in  std_logic;
        MGPIO4A_F2H_GPIN                        : in  std_logic;
        MGPIO5A_F2H_GPIN                        : in  std_logic;
        MGPIO6A_F2H_GPIN                        : in  std_logic;
        MGPIO7A_F2H_GPIN                        : in  std_logic;
        MGPIO8A_F2H_GPIN                        : in  std_logic;
        MGPIO9A_F2H_GPIN                        : in  std_logic;
        MMUART0_CTS_F2H_SCP                     : in  std_logic;
        MMUART0_CTS_USBC_DATA7_MGPIO19B_IN      : in  std_logic;
        MMUART0_DCD_F2H_SCP                     : in  std_logic;
        MMUART0_DCD_MGPIO22B_IN                 : in  std_logic;
        MMUART0_DSR_F2H_SCP                     : in  std_logic;
        MMUART0_DSR_MGPIO20B_IN                 : in  std_logic;
        MMUART0_DTR_F2H_SCP                     : in  std_logic;
        MMUART0_DTR_USBC_DATA6_MGPIO18B_IN      : in  std_logic;
        MMUART0_RI_F2H_SCP                      : in  std_logic;
        MMUART0_RI_MGPIO21B_IN                  : in  std_logic;
        MMUART0_RTS_F2H_SCP                     : in  std_logic;
        MMUART0_RTS_USBC_DATA5_MGPIO17B_IN      : in  std_logic;
        MMUART0_RXD_F2H_SCP                     : in  std_logic;
        MMUART0_RXD_USBC_STP_MGPIO28B_IN        : in  std_logic;
        MMUART0_SCK_F2H_SCP                     : in  std_logic;
        MMUART0_SCK_USBC_NXT_MGPIO29B_IN        : in  std_logic;
        MMUART0_TXD_F2H_SCP                     : in  std_logic;
        MMUART0_TXD_USBC_DIR_MGPIO27B_IN        : in  std_logic;
        MMUART1_CTS_F2H_SCP                     : in  std_logic;
        MMUART1_CTS_MGPIO13B_IN                 : in  std_logic;
        MMUART1_DCD_F2H_SCP                     : in  std_logic;
        MMUART1_DCD_MGPIO16B_IN                 : in  std_logic;
        MMUART1_DSR_F2H_SCP                     : in  std_logic;
        MMUART1_DSR_MGPIO14B_IN                 : in  std_logic;
        MMUART1_DTR_MGPIO12B_IN                 : in  std_logic;
        MMUART1_RI_F2H_SCP                      : in  std_logic;
        MMUART1_RI_MGPIO15B_IN                  : in  std_logic;
        MMUART1_RTS_F2H_SCP                     : in  std_logic;
        MMUART1_RTS_MGPIO11B_IN                 : in  std_logic;
        MMUART1_RXD_F2H_SCP                     : in  std_logic;
        MMUART1_RXD_USBC_DATA3_MGPIO26B_IN      : in  std_logic;
        MMUART1_SCK_F2H_SCP                     : in  std_logic;
        MMUART1_SCK_USBC_DATA4_MGPIO25B_IN      : in  std_logic;
        MMUART1_TXD_F2H_SCP                     : in  std_logic;
        MMUART1_TXD_USBC_DATA2_MGPIO24B_IN      : in  std_logic;
        PER2_FABRIC_PRDATA                      : in  std_logic_vector(31 downto 0);
        PER2_FABRIC_PREADY                      : in  std_logic;
        PER2_FABRIC_PSLVERR                     : in  std_logic;
        PRESET_N                                : in  std_logic;
        RCGF                                    : in  std_logic_vector(9 downto 0);
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_IN     : in  std_logic;
        RGMII_MDC_RMII_MDC_IN                   : in  std_logic;
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_IN      : in  std_logic;
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_IN      : in  std_logic;
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_IN      : in  std_logic;
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_IN     : in  std_logic;
        RGMII_RXD3_USBB_DATA4_IN                : in  std_logic;
        RGMII_RX_CLK_IN                         : in  std_logic;
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_IN  : in  std_logic;
        RGMII_TXD0_RMII_TXD0_USBB_DIR_IN        : in  std_logic;
        RGMII_TXD1_RMII_TXD1_USBB_STP_IN        : in  std_logic;
        RGMII_TXD2_USBB_DATA5_IN                : in  std_logic;
        RGMII_TXD3_USBB_DATA6_IN                : in  std_logic;
        RGMII_TX_CLK_IN                         : in  std_logic;
        RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_IN     : in  std_logic;
        RXDF                                    : in  std_logic_vector(7 downto 0);
        RX_CLKPF                                : in  std_logic;
        RX_DVF                                  : in  std_logic;
        RX_ERRF                                 : in  std_logic;
        RX_EV                                   : in  std_logic;
        SLEEPHOLDREQ                            : in  std_logic;
        SMBALERT_NI0                            : in  std_logic;
        SMBALERT_NI1                            : in  std_logic;
        SMBSUS_NI0                              : in  std_logic;
        SMBSUS_NI1                              : in  std_logic;
        SPI0_CLK_IN                             : in  std_logic;
        SPI0_SCK_USBA_XCLK_IN                   : in  std_logic;
        SPI0_SDI_F2H_SCP                        : in  std_logic;
        SPI0_SDI_USBA_DIR_MGPIO5A_IN            : in  std_logic;
        SPI0_SDO_F2H_SCP                        : in  std_logic;
        SPI0_SDO_USBA_STP_MGPIO6A_IN            : in  std_logic;
        SPI0_SS0_F2H_SCP                        : in  std_logic;
        SPI0_SS0_USBA_NXT_MGPIO7A_IN            : in  std_logic;
        SPI0_SS1_F2H_SCP                        : in  std_logic;
        SPI0_SS1_USBA_DATA5_MGPIO8A_IN          : in  std_logic;
        SPI0_SS2_F2H_SCP                        : in  std_logic;
        SPI0_SS2_USBA_DATA6_MGPIO9A_IN          : in  std_logic;
        SPI0_SS3_F2H_SCP                        : in  std_logic;
        SPI0_SS3_USBA_DATA7_MGPIO10A_IN         : in  std_logic;
        SPI0_SS4_MGPIO19A_IN                    : in  std_logic;
        SPI0_SS5_MGPIO20A_IN                    : in  std_logic;
        SPI0_SS6_MGPIO21A_IN                    : in  std_logic;
        SPI0_SS7_MGPIO22A_IN                    : in  std_logic;
        SPI1_CLK_IN                             : in  std_logic;
        SPI1_SCK_IN                             : in  std_logic;
        SPI1_SDI_F2H_SCP                        : in  std_logic;
        SPI1_SDI_MGPIO11A_IN                    : in  std_logic;
        SPI1_SDO_F2H_SCP                        : in  std_logic;
        SPI1_SDO_MGPIO12A_IN                    : in  std_logic;
        SPI1_SS0_F2H_SCP                        : in  std_logic;
        SPI1_SS0_MGPIO13A_IN                    : in  std_logic;
        SPI1_SS1_F2H_SCP                        : in  std_logic;
        SPI1_SS1_MGPIO14A_IN                    : in  std_logic;
        SPI1_SS2_F2H_SCP                        : in  std_logic;
        SPI1_SS2_MGPIO15A_IN                    : in  std_logic;
        SPI1_SS3_F2H_SCP                        : in  std_logic;
        SPI1_SS3_MGPIO16A_IN                    : in  std_logic;
        SPI1_SS4_MGPIO17A_IN                    : in  std_logic;
        SPI1_SS5_MGPIO18A_IN                    : in  std_logic;
        SPI1_SS6_MGPIO23A_IN                    : in  std_logic;
        SPI1_SS7_MGPIO24A_IN                    : in  std_logic;
        TX_CLKPF                                : in  std_logic;
        USBC_XCLK_IN                            : in  std_logic;
        USER_MSS_GPIO_RESET_N                   : in  std_logic;
        USER_MSS_RESET_N                        : in  std_logic;
        XCLK_FAB                                : in  std_logic;
        -- Outputs
        CAN_RXBUS_MGPIO3A_H2F_A                 : out std_logic;
        CAN_RXBUS_MGPIO3A_H2F_B                 : out std_logic;
        CAN_RXBUS_USBA_DATA1_MGPIO3A_OE         : out std_logic;
        CAN_RXBUS_USBA_DATA1_MGPIO3A_OUT        : out std_logic;
        CAN_TXBUS_MGPIO2A_H2F_A                 : out std_logic;
        CAN_TXBUS_MGPIO2A_H2F_B                 : out std_logic;
        CAN_TXBUS_USBA_DATA0_MGPIO2A_OE         : out std_logic;
        CAN_TXBUS_USBA_DATA0_MGPIO2A_OUT        : out std_logic;
        CAN_TX_EBL_MGPIO4A_H2F_A                : out std_logic;
        CAN_TX_EBL_MGPIO4A_H2F_B                : out std_logic;
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_OE        : out std_logic;
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_OUT       : out std_logic;
        CLK_CONFIG_APB                          : out std_logic;
        COMMS_INT                               : out std_logic;
        CONFIG_PRESET_N                         : out std_logic;
        DM_OE                                   : out std_logic_vector(2 downto 0);
        DRAM_ADDR                               : out std_logic_vector(15 downto 0);
        DRAM_BA                                 : out std_logic_vector(2 downto 0);
        DRAM_CASN                               : out std_logic;
        DRAM_CKE                                : out std_logic;
        DRAM_CLK                                : out std_logic;
        DRAM_CSN                                : out std_logic;
        DRAM_DM_RDQS_OUT                        : out std_logic_vector(2 downto 0);
        DRAM_DQS_OE                             : out std_logic_vector(2 downto 0);
        DRAM_DQS_OUT                            : out std_logic_vector(2 downto 0);
        DRAM_DQ_OE                              : out std_logic_vector(17 downto 0);
        DRAM_DQ_OUT                             : out std_logic_vector(17 downto 0);
        DRAM_FIFO_WE_OUT                        : out std_logic_vector(1 downto 0);
        DRAM_ODT                                : out std_logic;
        DRAM_RASN                               : out std_logic;
        DRAM_RSTN                               : out std_logic;
        DRAM_WEN                                : out std_logic;
        EDAC_ERROR                              : out std_logic_vector(7 downto 0);
        FAB_CHRGVBUS                            : out std_logic;
        FAB_DISCHRGVBUS                         : out std_logic;
        FAB_DMPULLDOWN                          : out std_logic;
        FAB_DPPULLDOWN                          : out std_logic;
        FAB_DRVVBUS                             : out std_logic;
        FAB_IDPULLUP                            : out std_logic;
        FAB_OPMODE                              : out std_logic_vector(1 downto 0);
        FAB_SUSPENDM                            : out std_logic;
        FAB_TERMSEL                             : out std_logic;
        FAB_TXVALID                             : out std_logic;
        FAB_VCONTROL                            : out std_logic_vector(3 downto 0);
        FAB_VCONTROLLOADM                       : out std_logic;
        FAB_XCVRSEL                             : out std_logic_vector(1 downto 0);
        FAB_XDATAOUT                            : out std_logic_vector(7 downto 0);
        FACC_GLMUX_SEL                          : out std_logic;
        FIC32_0_MASTER                          : out std_logic_vector(1 downto 0);
        FIC32_1_MASTER                          : out std_logic_vector(1 downto 0);
        FPGA_RESET_N                            : out std_logic;
        F_ARREADY_HREADYOUT1                    : out std_logic;
        F_AWREADY_HREADYOUT0                    : out std_logic;
        F_BID                                   : out std_logic_vector(3 downto 0);
        F_BRESP_HRESP0                          : out std_logic_vector(1 downto 0);
        F_BVALID                                : out std_logic;
        F_FM0_RDATA                             : out std_logic_vector(31 downto 0);
        F_FM0_READYOUT                          : out std_logic;
        F_FM0_RESP                              : out std_logic;
        F_HM0_ADDR                              : out std_logic_vector(31 downto 0);
        F_HM0_ENABLE                            : out std_logic;
        F_HM0_SEL                               : out std_logic;
        F_HM0_SIZE                              : out std_logic_vector(1 downto 0);
        F_HM0_TRANS1                            : out std_logic;
        F_HM0_WDATA                             : out std_logic_vector(31 downto 0);
        F_HM0_WRITE                             : out std_logic;
        F_RDATA_HRDATA01                        : out std_logic_vector(63 downto 0);
        F_RID                                   : out std_logic_vector(3 downto 0);
        F_RLAST                                 : out std_logic;
        F_RRESP_HRESP1                          : out std_logic_vector(1 downto 0);
        F_RVALID                                : out std_logic;
        F_WREADY                                : out std_logic;
        GTX_CLK                                 : out std_logic;
        H2FCALIB                                : out std_logic;
        H2F_INTERRUPT                           : out std_logic_vector(15 downto 0);
        H2F_NMI                                 : out std_logic;
        I2C0_SCL_MGPIO31B_H2F_A                 : out std_logic;
        I2C0_SCL_MGPIO31B_H2F_B                 : out std_logic;
        I2C0_SCL_USBC_DATA1_MGPIO31B_OE         : out std_logic;
        I2C0_SCL_USBC_DATA1_MGPIO31B_OUT        : out std_logic;
        I2C0_SDA_MGPIO30B_H2F_A                 : out std_logic;
        I2C0_SDA_MGPIO30B_H2F_B                 : out std_logic;
        I2C0_SDA_USBC_DATA0_MGPIO30B_OE         : out std_logic;
        I2C0_SDA_USBC_DATA0_MGPIO30B_OUT        : out std_logic;
        I2C1_SCL_MGPIO1A_H2F_A                  : out std_logic;
        I2C1_SCL_MGPIO1A_H2F_B                  : out std_logic;
        I2C1_SCL_USBA_DATA4_MGPIO1A_OE          : out std_logic;
        I2C1_SCL_USBA_DATA4_MGPIO1A_OUT         : out std_logic;
        I2C1_SDA_MGPIO0A_H2F_A                  : out std_logic;
        I2C1_SDA_MGPIO0A_H2F_B                  : out std_logic;
        I2C1_SDA_USBA_DATA3_MGPIO0A_OE          : out std_logic;
        I2C1_SDA_USBA_DATA3_MGPIO0A_OUT         : out std_logic;
        MDCF                                    : out std_logic;
        MDDR_FABRIC_PRDATA                      : out std_logic_vector(15 downto 0);
        MDDR_FABRIC_PREADY                      : out std_logic;
        MDDR_FABRIC_PSLVERR                     : out std_logic;
        MDOENF                                  : out std_logic;
        MDOF                                    : out std_logic;
        MGPIO25A_OE                             : out std_logic;
        MGPIO25A_OUT                            : out std_logic;
        MGPIO26A_OE                             : out std_logic;
        MGPIO26A_OUT                            : out std_logic;
        MMUART0_CTS_MGPIO19B_H2F_A              : out std_logic;
        MMUART0_CTS_MGPIO19B_H2F_B              : out std_logic;
        MMUART0_CTS_USBC_DATA7_MGPIO19B_OE      : out std_logic;
        MMUART0_CTS_USBC_DATA7_MGPIO19B_OUT     : out std_logic;
        MMUART0_DCD_MGPIO22B_H2F_A              : out std_logic;
        MMUART0_DCD_MGPIO22B_H2F_B              : out std_logic;
        MMUART0_DCD_MGPIO22B_OE                 : out std_logic;
        MMUART0_DCD_MGPIO22B_OUT                : out std_logic;
        MMUART0_DSR_MGPIO20B_H2F_A              : out std_logic;
        MMUART0_DSR_MGPIO20B_H2F_B              : out std_logic;
        MMUART0_DSR_MGPIO20B_OE                 : out std_logic;
        MMUART0_DSR_MGPIO20B_OUT                : out std_logic;
        MMUART0_DTR_MGPIO18B_H2F_A              : out std_logic;
        MMUART0_DTR_MGPIO18B_H2F_B              : out std_logic;
        MMUART0_DTR_USBC_DATA6_MGPIO18B_OE      : out std_logic;
        MMUART0_DTR_USBC_DATA6_MGPIO18B_OUT     : out std_logic;
        MMUART0_RI_MGPIO21B_H2F_A               : out std_logic;
        MMUART0_RI_MGPIO21B_H2F_B               : out std_logic;
        MMUART0_RI_MGPIO21B_OE                  : out std_logic;
        MMUART0_RI_MGPIO21B_OUT                 : out std_logic;
        MMUART0_RTS_MGPIO17B_H2F_A              : out std_logic;
        MMUART0_RTS_MGPIO17B_H2F_B              : out std_logic;
        MMUART0_RTS_USBC_DATA5_MGPIO17B_OE      : out std_logic;
        MMUART0_RTS_USBC_DATA5_MGPIO17B_OUT     : out std_logic;
        MMUART0_RXD_MGPIO28B_H2F_A              : out std_logic;
        MMUART0_RXD_MGPIO28B_H2F_B              : out std_logic;
        MMUART0_RXD_USBC_STP_MGPIO28B_OE        : out std_logic;
        MMUART0_RXD_USBC_STP_MGPIO28B_OUT       : out std_logic;
        MMUART0_SCK_MGPIO29B_H2F_A              : out std_logic;
        MMUART0_SCK_MGPIO29B_H2F_B              : out std_logic;
        MMUART0_SCK_USBC_NXT_MGPIO29B_OE        : out std_logic;
        MMUART0_SCK_USBC_NXT_MGPIO29B_OUT       : out std_logic;
        MMUART0_TXD_MGPIO27B_H2F_A              : out std_logic;
        MMUART0_TXD_MGPIO27B_H2F_B              : out std_logic;
        MMUART0_TXD_USBC_DIR_MGPIO27B_OE        : out std_logic;
        MMUART0_TXD_USBC_DIR_MGPIO27B_OUT       : out std_logic;
        MMUART1_CTS_MGPIO13B_OE                 : out std_logic;
        MMUART1_CTS_MGPIO13B_OUT                : out std_logic;
        MMUART1_DCD_MGPIO16B_OE                 : out std_logic;
        MMUART1_DCD_MGPIO16B_OUT                : out std_logic;
        MMUART1_DSR_MGPIO14B_OE                 : out std_logic;
        MMUART1_DSR_MGPIO14B_OUT                : out std_logic;
        MMUART1_DTR_MGPIO12B_H2F_A              : out std_logic;
        MMUART1_DTR_MGPIO12B_OE                 : out std_logic;
        MMUART1_DTR_MGPIO12B_OUT                : out std_logic;
        MMUART1_RI_MGPIO15B_OE                  : out std_logic;
        MMUART1_RI_MGPIO15B_OUT                 : out std_logic;
        MMUART1_RTS_MGPIO11B_H2F_A              : out std_logic;
        MMUART1_RTS_MGPIO11B_H2F_B              : out std_logic;
        MMUART1_RTS_MGPIO11B_OE                 : out std_logic;
        MMUART1_RTS_MGPIO11B_OUT                : out std_logic;
        MMUART1_RXD_MGPIO26B_H2F_A              : out std_logic;
        MMUART1_RXD_MGPIO26B_H2F_B              : out std_logic;
        MMUART1_RXD_USBC_DATA3_MGPIO26B_OE      : out std_logic;
        MMUART1_RXD_USBC_DATA3_MGPIO26B_OUT     : out std_logic;
        MMUART1_SCK_MGPIO25B_H2F_A              : out std_logic;
        MMUART1_SCK_MGPIO25B_H2F_B              : out std_logic;
        MMUART1_SCK_USBC_DATA4_MGPIO25B_OE      : out std_logic;
        MMUART1_SCK_USBC_DATA4_MGPIO25B_OUT     : out std_logic;
        MMUART1_TXD_MGPIO24B_H2F_A              : out std_logic;
        MMUART1_TXD_MGPIO24B_H2F_B              : out std_logic;
        MMUART1_TXD_USBC_DATA2_MGPIO24B_OE      : out std_logic;
        MMUART1_TXD_USBC_DATA2_MGPIO24B_OUT     : out std_logic;
        MPLL_LOCK                               : out std_logic;
        PER2_FABRIC_PADDR                       : out std_logic_vector(15 downto 2);
        PER2_FABRIC_PENABLE                     : out std_logic;
        PER2_FABRIC_PSEL                        : out std_logic;
        PER2_FABRIC_PWDATA                      : out std_logic_vector(31 downto 0);
        PER2_FABRIC_PWRITE                      : out std_logic;
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OE     : out std_logic;
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OUT    : out std_logic;
        RGMII_MDC_RMII_MDC_OE                   : out std_logic;
        RGMII_MDC_RMII_MDC_OUT                  : out std_logic;
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_OE      : out std_logic;
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_OUT     : out std_logic;
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_OE      : out std_logic;
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_OUT     : out std_logic;
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_OE      : out std_logic;
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_OUT     : out std_logic;
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OE     : out std_logic;
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OUT    : out std_logic;
        RGMII_RXD3_USBB_DATA4_OE                : out std_logic;
        RGMII_RXD3_USBB_DATA4_OUT               : out std_logic;
        RGMII_RX_CLK_OE                         : out std_logic;
        RGMII_RX_CLK_OUT                        : out std_logic;
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OE  : out std_logic;
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OUT : out std_logic;
        RGMII_TXD0_RMII_TXD0_USBB_DIR_OE        : out std_logic;
        RGMII_TXD0_RMII_TXD0_USBB_DIR_OUT       : out std_logic;
        RGMII_TXD1_RMII_TXD1_USBB_STP_OE        : out std_logic;
        RGMII_TXD1_RMII_TXD1_USBB_STP_OUT       : out std_logic;
        RGMII_TXD2_USBB_DATA5_OE                : out std_logic;
        RGMII_TXD2_USBB_DATA5_OUT               : out std_logic;
        RGMII_TXD3_USBB_DATA6_OE                : out std_logic;
        RGMII_TXD3_USBB_DATA6_OUT               : out std_logic;
        RGMII_TX_CLK_OE                         : out std_logic;
        RGMII_TX_CLK_OUT                        : out std_logic;
        RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OE     : out std_logic;
        RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OUT    : out std_logic;
        RTC_MATCH                               : out std_logic;
        SLEEPDEEP                               : out std_logic;
        SLEEPHOLDACK                            : out std_logic;
        SLEEPING                                : out std_logic;
        SMBALERT_NO0                            : out std_logic;
        SMBALERT_NO1                            : out std_logic;
        SMBSUS_NO0                              : out std_logic;
        SMBSUS_NO1                              : out std_logic;
        SPI0_CLK_OUT                            : out std_logic;
        SPI0_SCK_USBA_XCLK_OE                   : out std_logic;
        SPI0_SCK_USBA_XCLK_OUT                  : out std_logic;
        SPI0_SDI_MGPIO5A_H2F_A                  : out std_logic;
        SPI0_SDI_MGPIO5A_H2F_B                  : out std_logic;
        SPI0_SDI_USBA_DIR_MGPIO5A_OE            : out std_logic;
        SPI0_SDI_USBA_DIR_MGPIO5A_OUT           : out std_logic;
        SPI0_SDO_MGPIO6A_H2F_A                  : out std_logic;
        SPI0_SDO_MGPIO6A_H2F_B                  : out std_logic;
        SPI0_SDO_USBA_STP_MGPIO6A_OE            : out std_logic;
        SPI0_SDO_USBA_STP_MGPIO6A_OUT           : out std_logic;
        SPI0_SS0_MGPIO7A_H2F_A                  : out std_logic;
        SPI0_SS0_MGPIO7A_H2F_B                  : out std_logic;
        SPI0_SS0_USBA_NXT_MGPIO7A_OE            : out std_logic;
        SPI0_SS0_USBA_NXT_MGPIO7A_OUT           : out std_logic;
        SPI0_SS1_MGPIO8A_H2F_A                  : out std_logic;
        SPI0_SS1_MGPIO8A_H2F_B                  : out std_logic;
        SPI0_SS1_USBA_DATA5_MGPIO8A_OE          : out std_logic;
        SPI0_SS1_USBA_DATA5_MGPIO8A_OUT         : out std_logic;
        SPI0_SS2_MGPIO9A_H2F_A                  : out std_logic;
        SPI0_SS2_MGPIO9A_H2F_B                  : out std_logic;
        SPI0_SS2_USBA_DATA6_MGPIO9A_OE          : out std_logic;
        SPI0_SS2_USBA_DATA6_MGPIO9A_OUT         : out std_logic;
        SPI0_SS3_MGPIO10A_H2F_A                 : out std_logic;
        SPI0_SS3_MGPIO10A_H2F_B                 : out std_logic;
        SPI0_SS3_USBA_DATA7_MGPIO10A_OE         : out std_logic;
        SPI0_SS3_USBA_DATA7_MGPIO10A_OUT        : out std_logic;
        SPI0_SS4_MGPIO19A_H2F_A                 : out std_logic;
        SPI0_SS4_MGPIO19A_OE                    : out std_logic;
        SPI0_SS4_MGPIO19A_OUT                   : out std_logic;
        SPI0_SS5_MGPIO20A_H2F_A                 : out std_logic;
        SPI0_SS5_MGPIO20A_OE                    : out std_logic;
        SPI0_SS5_MGPIO20A_OUT                   : out std_logic;
        SPI0_SS6_MGPIO21A_H2F_A                 : out std_logic;
        SPI0_SS6_MGPIO21A_OE                    : out std_logic;
        SPI0_SS6_MGPIO21A_OUT                   : out std_logic;
        SPI0_SS7_MGPIO22A_H2F_A                 : out std_logic;
        SPI0_SS7_MGPIO22A_OE                    : out std_logic;
        SPI0_SS7_MGPIO22A_OUT                   : out std_logic;
        SPI1_CLK_OUT                            : out std_logic;
        SPI1_SCK_OE                             : out std_logic;
        SPI1_SCK_OUT                            : out std_logic;
        SPI1_SDI_MGPIO11A_H2F_A                 : out std_logic;
        SPI1_SDI_MGPIO11A_H2F_B                 : out std_logic;
        SPI1_SDI_MGPIO11A_OE                    : out std_logic;
        SPI1_SDI_MGPIO11A_OUT                   : out std_logic;
        SPI1_SDO_MGPIO12A_H2F_A                 : out std_logic;
        SPI1_SDO_MGPIO12A_H2F_B                 : out std_logic;
        SPI1_SDO_MGPIO12A_OE                    : out std_logic;
        SPI1_SDO_MGPIO12A_OUT                   : out std_logic;
        SPI1_SS0_MGPIO13A_H2F_A                 : out std_logic;
        SPI1_SS0_MGPIO13A_H2F_B                 : out std_logic;
        SPI1_SS0_MGPIO13A_OE                    : out std_logic;
        SPI1_SS0_MGPIO13A_OUT                   : out std_logic;
        SPI1_SS1_MGPIO14A_H2F_A                 : out std_logic;
        SPI1_SS1_MGPIO14A_H2F_B                 : out std_logic;
        SPI1_SS1_MGPIO14A_OE                    : out std_logic;
        SPI1_SS1_MGPIO14A_OUT                   : out std_logic;
        SPI1_SS2_MGPIO15A_H2F_A                 : out std_logic;
        SPI1_SS2_MGPIO15A_H2F_B                 : out std_logic;
        SPI1_SS2_MGPIO15A_OE                    : out std_logic;
        SPI1_SS2_MGPIO15A_OUT                   : out std_logic;
        SPI1_SS3_MGPIO16A_H2F_A                 : out std_logic;
        SPI1_SS3_MGPIO16A_H2F_B                 : out std_logic;
        SPI1_SS3_MGPIO16A_OE                    : out std_logic;
        SPI1_SS3_MGPIO16A_OUT                   : out std_logic;
        SPI1_SS4_MGPIO17A_H2F_A                 : out std_logic;
        SPI1_SS4_MGPIO17A_OE                    : out std_logic;
        SPI1_SS4_MGPIO17A_OUT                   : out std_logic;
        SPI1_SS5_MGPIO18A_H2F_A                 : out std_logic;
        SPI1_SS5_MGPIO18A_OE                    : out std_logic;
        SPI1_SS5_MGPIO18A_OUT                   : out std_logic;
        SPI1_SS6_MGPIO23A_H2F_A                 : out std_logic;
        SPI1_SS6_MGPIO23A_OE                    : out std_logic;
        SPI1_SS6_MGPIO23A_OUT                   : out std_logic;
        SPI1_SS7_MGPIO24A_H2F_A                 : out std_logic;
        SPI1_SS7_MGPIO24A_OE                    : out std_logic;
        SPI1_SS7_MGPIO24A_OUT                   : out std_logic;
        TCGF                                    : out std_logic_vector(9 downto 0);
        TRACECLK                                : out std_logic;
        TRACEDATA                               : out std_logic_vector(3 downto 0);
        TXCTL_EN_RIF                            : out std_logic;
        TXDF                                    : out std_logic_vector(7 downto 0);
        TXD_RIF                                 : out std_logic_vector(3 downto 0);
        TXEV                                    : out std_logic;
        TX_CLK                                  : out std_logic;
        TX_ENF                                  : out std_logic;
        TX_ERRF                                 : out std_logic;
        USBC_XCLK_OE                            : out std_logic;
        USBC_XCLK_OUT                           : out std_logic;
        WDOGTIMEOUT                             : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal FIC_0_APB_MASTER_PADDR           : std_logic_vector(31 downto 0);
signal FIC_0_APB_MASTER_PENABLE         : std_logic;
signal FIC_0_APB_MASTER_PSELx           : std_logic;
signal FIC_0_APB_MASTER_PWDATA          : std_logic_vector(31 downto 0);
signal FIC_0_APB_MASTER_PWRITE          : std_logic;
signal FIC_2_APB_M_PCLK_0               : std_logic;
signal FIC_2_APB_M_PRESET_N_0           : std_logic;
signal FIC_2_APB_MASTER_0_PADDR         : std_logic_vector(15 downto 2);
signal FIC_2_APB_MASTER_0_PENABLE       : std_logic;
signal FIC_2_APB_MASTER_0_PSELx         : std_logic;
signal FIC_2_APB_MASTER_0_PWDATA        : std_logic_vector(31 downto 0);
signal FIC_2_APB_MASTER_0_PWRITE        : std_logic;
signal MSS_RESET_N_M2F_net_0            : std_logic;
signal SPI_0_CLK_M2F_net_0              : std_logic;
signal SPI_0_DO_M2F_net_0               : std_logic;
signal SPI_0_SS0_M2F_net_0              : std_logic;
signal SPI_0_SS0_M2F_OE_net_0           : std_logic;
signal SPI_0_SS1_M2F_net_0              : std_logic;
signal SPI_0_SS2_M2F_net_0              : std_logic;
signal SPI_0_SS3_M2F_net_0              : std_logic;
signal SPI_0_SS4_M2F_net_0              : std_logic;
signal MSS_RESET_N_M2F_net_1            : std_logic;
signal SPI_0_DO_M2F_net_1               : std_logic;
signal SPI_0_CLK_M2F_net_1              : std_logic;
signal SPI_0_SS0_M2F_net_1              : std_logic;
signal SPI_0_SS0_M2F_OE_net_1           : std_logic;
signal SPI_0_SS1_M2F_net_1              : std_logic;
signal SPI_0_SS2_M2F_net_1              : std_logic;
signal SPI_0_SS3_M2F_net_1              : std_logic;
signal SPI_0_SS4_M2F_net_1              : std_logic;
signal FIC_0_APB_MASTER_PSELx_net_0     : std_logic;
signal FIC_0_APB_MASTER_PWRITE_net_0    : std_logic;
signal FIC_0_APB_MASTER_PENABLE_net_0   : std_logic;
signal FIC_2_APB_M_PRESET_N_0_net_0     : std_logic;
signal FIC_2_APB_M_PCLK_0_net_0         : std_logic;
signal FIC_2_APB_MASTER_0_PWRITE_net_0  : std_logic;
signal FIC_2_APB_MASTER_0_PENABLE_net_0 : std_logic;
signal FIC_2_APB_MASTER_0_PSELx_net_0   : std_logic;
signal FIC_0_APB_MASTER_PADDR_net_0     : std_logic_vector(31 downto 0);
signal FIC_0_APB_MASTER_PWDATA_net_0    : std_logic_vector(31 downto 0);
signal FIC_2_APB_MASTER_0_PADDR_net_0   : std_logic_vector(15 downto 2);
signal FIC_2_APB_MASTER_0_PWDATA_net_0  : std_logic_vector(31 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                          : std_logic;
signal DM_IN_const_net_0                : std_logic_vector(2 downto 0);
signal DRAM_DQ_IN_const_net_0           : std_logic_vector(17 downto 0);
signal DRAM_DQS_IN_const_net_0          : std_logic_vector(2 downto 0);
signal DRAM_FIFO_WE_IN_const_net_0      : std_logic_vector(1 downto 0);
signal VCC_net                          : std_logic;
signal F2_DMAREADY_const_net_0          : std_logic_vector(1 downto 0);
signal F_DMAREADY_const_net_0           : std_logic_vector(1 downto 0);
signal F_FM0_ADDR_const_net_0           : std_logic_vector(31 downto 0);
signal F_FM0_SIZE_const_net_0           : std_logic_vector(1 downto 0);
signal F_FM0_WDATA_const_net_0          : std_logic_vector(31 downto 0);
signal FAB_LINESTATE_const_net_0        : std_logic_vector(1 downto 0);
signal FAB_VSTATUS_const_net_0          : std_logic_vector(7 downto 0);
signal FAB_XDATAIN_const_net_0          : std_logic_vector(7 downto 0);
signal RCGF_const_net_0                 : std_logic_vector(9 downto 0);
signal RXDF_const_net_0                 : std_logic_vector(7 downto 0);
signal F_ARADDR_HADDR1_const_net_0      : std_logic_vector(31 downto 0);
signal F_ARBURST_HTRANS1_const_net_0    : std_logic_vector(1 downto 0);
signal F_ARID_HSEL1_const_net_0         : std_logic_vector(3 downto 0);
signal F_ARLEN_HBURST1_const_net_0      : std_logic_vector(3 downto 0);
signal F_ARLOCK_HMASTLOCK1_const_net_0  : std_logic_vector(1 downto 0);
signal F_ARSIZE_HSIZE1_const_net_0      : std_logic_vector(1 downto 0);
signal F_AWADDR_HADDR0_const_net_0      : std_logic_vector(31 downto 0);
signal F_AWBURST_HTRANS0_const_net_0    : std_logic_vector(1 downto 0);
signal F_AWID_HSEL0_const_net_0         : std_logic_vector(3 downto 0);
signal F_AWLEN_HBURST0_const_net_0      : std_logic_vector(3 downto 0);
signal F_AWLOCK_HMASTLOCK0_const_net_0  : std_logic_vector(1 downto 0);
signal F_AWSIZE_HSIZE0_const_net_0      : std_logic_vector(1 downto 0);
signal F_WDATA_HWDATA01_const_net_0     : std_logic_vector(63 downto 0);
signal F_WID_HREADY01_const_net_0       : std_logic_vector(3 downto 0);
signal F_WSTRB_const_net_0              : std_logic_vector(7 downto 0);
signal MDDR_FABRIC_PADDR_const_net_0    : std_logic_vector(10 downto 2);
signal MDDR_FABRIC_PWDATA_const_net_0   : std_logic_vector(15 downto 0);

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net                         <= '0';
 DM_IN_const_net_0               <= B"000";
 DRAM_DQ_IN_const_net_0          <= B"000000000000000000";
 DRAM_DQS_IN_const_net_0         <= B"000";
 DRAM_FIFO_WE_IN_const_net_0     <= B"00";
 VCC_net                         <= '1';
 F2_DMAREADY_const_net_0         <= B"11";
 F_DMAREADY_const_net_0          <= B"11";
 F_FM0_ADDR_const_net_0          <= B"00000000000000000000000000000000";
 F_FM0_SIZE_const_net_0          <= B"00";
 F_FM0_WDATA_const_net_0         <= B"00000000000000000000000000000000";
 FAB_LINESTATE_const_net_0       <= B"11";
 FAB_VSTATUS_const_net_0         <= B"11111111";
 FAB_XDATAIN_const_net_0         <= B"11111111";
 RCGF_const_net_0                <= B"1111111111";
 RXDF_const_net_0                <= B"11111111";
 F_ARADDR_HADDR1_const_net_0     <= B"11111111111111111111111111111111";
 F_ARBURST_HTRANS1_const_net_0   <= B"00";
 F_ARID_HSEL1_const_net_0        <= B"0000";
 F_ARLEN_HBURST1_const_net_0     <= B"0000";
 F_ARLOCK_HMASTLOCK1_const_net_0 <= B"00";
 F_ARSIZE_HSIZE1_const_net_0     <= B"00";
 F_AWADDR_HADDR0_const_net_0     <= B"11111111111111111111111111111111";
 F_AWBURST_HTRANS0_const_net_0   <= B"00";
 F_AWID_HSEL0_const_net_0        <= B"0000";
 F_AWLEN_HBURST0_const_net_0     <= B"0000";
 F_AWLOCK_HMASTLOCK0_const_net_0 <= B"00";
 F_AWSIZE_HSIZE0_const_net_0     <= B"00";
 F_WDATA_HWDATA01_const_net_0    <= B"1111111111111111111111111111111111111111111111111111111111111111";
 F_WID_HREADY01_const_net_0      <= B"0000";
 F_WSTRB_const_net_0             <= B"00000000";
 MDDR_FABRIC_PADDR_const_net_0   <= B"111111111";
 MDDR_FABRIC_PWDATA_const_net_0  <= B"1111111111111111";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 MSS_RESET_N_M2F_net_1            <= MSS_RESET_N_M2F_net_0;
 MSS_RESET_N_M2F                  <= MSS_RESET_N_M2F_net_1;
 SPI_0_DO_M2F_net_1               <= SPI_0_DO_M2F_net_0;
 SPI_0_DO_M2F                     <= SPI_0_DO_M2F_net_1;
 SPI_0_CLK_M2F_net_1              <= SPI_0_CLK_M2F_net_0;
 SPI_0_CLK_M2F                    <= SPI_0_CLK_M2F_net_1;
 SPI_0_SS0_M2F_net_1              <= SPI_0_SS0_M2F_net_0;
 SPI_0_SS0_M2F                    <= SPI_0_SS0_M2F_net_1;
 SPI_0_SS0_M2F_OE_net_1           <= SPI_0_SS0_M2F_OE_net_0;
 SPI_0_SS0_M2F_OE                 <= SPI_0_SS0_M2F_OE_net_1;
 SPI_0_SS1_M2F_net_1              <= SPI_0_SS1_M2F_net_0;
 SPI_0_SS1_M2F                    <= SPI_0_SS1_M2F_net_1;
 SPI_0_SS2_M2F_net_1              <= SPI_0_SS2_M2F_net_0;
 SPI_0_SS2_M2F                    <= SPI_0_SS2_M2F_net_1;
 SPI_0_SS3_M2F_net_1              <= SPI_0_SS3_M2F_net_0;
 SPI_0_SS3_M2F                    <= SPI_0_SS3_M2F_net_1;
 SPI_0_SS4_M2F_net_1              <= SPI_0_SS4_M2F_net_0;
 SPI_0_SS4_M2F                    <= SPI_0_SS4_M2F_net_1;
 FIC_0_APB_MASTER_PSELx_net_0     <= FIC_0_APB_MASTER_PSELx;
 FIC_0_APB_M_PSEL                 <= FIC_0_APB_MASTER_PSELx_net_0;
 FIC_0_APB_MASTER_PWRITE_net_0    <= FIC_0_APB_MASTER_PWRITE;
 FIC_0_APB_M_PWRITE               <= FIC_0_APB_MASTER_PWRITE_net_0;
 FIC_0_APB_MASTER_PENABLE_net_0   <= FIC_0_APB_MASTER_PENABLE;
 FIC_0_APB_M_PENABLE              <= FIC_0_APB_MASTER_PENABLE_net_0;
 FIC_2_APB_M_PRESET_N_0_net_0     <= FIC_2_APB_M_PRESET_N_0;
 FIC_2_APB_M_PRESET_N             <= FIC_2_APB_M_PRESET_N_0_net_0;
 FIC_2_APB_M_PCLK_0_net_0         <= FIC_2_APB_M_PCLK_0;
 FIC_2_APB_M_PCLK                 <= FIC_2_APB_M_PCLK_0_net_0;
 FIC_2_APB_MASTER_0_PWRITE_net_0  <= FIC_2_APB_MASTER_0_PWRITE;
 FIC_2_APB_M_PWRITE               <= FIC_2_APB_MASTER_0_PWRITE_net_0;
 FIC_2_APB_MASTER_0_PENABLE_net_0 <= FIC_2_APB_MASTER_0_PENABLE;
 FIC_2_APB_M_PENABLE              <= FIC_2_APB_MASTER_0_PENABLE_net_0;
 FIC_2_APB_MASTER_0_PSELx_net_0   <= FIC_2_APB_MASTER_0_PSELx;
 FIC_2_APB_M_PSEL                 <= FIC_2_APB_MASTER_0_PSELx_net_0;
 FIC_0_APB_MASTER_PADDR_net_0     <= FIC_0_APB_MASTER_PADDR;
 FIC_0_APB_M_PADDR(31 downto 0)   <= FIC_0_APB_MASTER_PADDR_net_0;
 FIC_0_APB_MASTER_PWDATA_net_0    <= FIC_0_APB_MASTER_PWDATA;
 FIC_0_APB_M_PWDATA(31 downto 0)  <= FIC_0_APB_MASTER_PWDATA_net_0;
 FIC_2_APB_MASTER_0_PADDR_net_0   <= FIC_2_APB_MASTER_0_PADDR;
 FIC_2_APB_M_PADDR(15 downto 2)   <= FIC_2_APB_MASTER_0_PADDR_net_0;
 FIC_2_APB_MASTER_0_PWDATA_net_0  <= FIC_2_APB_MASTER_0_PWDATA;
 FIC_2_APB_M_PWDATA(31 downto 0)  <= FIC_2_APB_MASTER_0_PWDATA_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- MSS_ADLIB_INST
MSS_ADLIB_INST : MSS_025
    generic map( 
        ACT_UBITS         => ( x"FFFFFFFFFFFFFF" ),
        DDR_CLK_FREQ      => ( 140.0 ),
        INIT              => ( "00" & x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000C0300C0300C030000000000000000000000000000000000000000000F00000000F000000000000000000000000000000007FFFFFFFB000001007C33C80400000609080104003FFFFE400000000000410000000000F01C000001FEDF7C010842108421000001FE34001FF80000004000000000200D1007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF" ),
        MEMORYFILE        => ( "ENVM_init.mem" ),
        RTC_MAIN_XTL_FREQ => ( 0.0 ),
        RTC_MAIN_XTL_MODE => ( "" )
        )
    port map( 
        -- Inputs
        CAN_RXBUS_F2H_SCP                       => VCC_net, -- tied to '1' from definition
        CAN_TX_EBL_F2H_SCP                      => VCC_net, -- tied to '1' from definition
        CAN_TXBUS_F2H_SCP                       => VCC_net, -- tied to '1' from definition
        COLF                                    => VCC_net, -- tied to '1' from definition
        CRSF                                    => VCC_net, -- tied to '1' from definition
        F2_DMAREADY                             => F2_DMAREADY_const_net_0, -- tied to X"1" from definition
        F2H_INTERRUPT                           => MSS_INT_F2M,
        F2HCALIB                                => VCC_net, -- tied to '1' from definition
        F_DMAREADY                              => F_DMAREADY_const_net_0, -- tied to X"1" from definition
        F_FM0_ADDR                              => F_FM0_ADDR_const_net_0, -- tied to X"0" from definition
        F_FM0_ENABLE                            => GND_net, -- tied to '0' from definition
        F_FM0_MASTLOCK                          => GND_net, -- tied to '0' from definition
        F_FM0_READY                             => VCC_net, -- tied to '1' from definition
        F_FM0_SEL                               => GND_net, -- tied to '0' from definition
        F_FM0_SIZE                              => F_FM0_SIZE_const_net_0, -- tied to X"0" from definition
        F_FM0_TRANS1                            => GND_net, -- tied to '0' from definition
        F_FM0_WDATA                             => F_FM0_WDATA_const_net_0, -- tied to X"0" from definition
        F_FM0_WRITE                             => GND_net, -- tied to '0' from definition
        F_HM0_RDATA                             => FIC_0_APB_M_PRDATA,
        F_HM0_READY                             => FIC_0_APB_M_PREADY,
        F_HM0_RESP                              => FIC_0_APB_M_PSLVERR,
        FAB_AVALID                              => VCC_net, -- tied to '1' from definition
        FAB_HOSTDISCON                          => VCC_net, -- tied to '1' from definition
        FAB_IDDIG                               => VCC_net, -- tied to '1' from definition
        FAB_LINESTATE                           => FAB_LINESTATE_const_net_0, -- tied to X"1" from definition
        FAB_M3_RESET_N                          => VCC_net, -- tied to '1' from definition
        FAB_PLL_LOCK                            => MCCC_CLK_BASE_PLL_LOCK,
        FAB_RXACTIVE                            => VCC_net, -- tied to '1' from definition
        FAB_RXERROR                             => VCC_net, -- tied to '1' from definition
        FAB_RXVALID                             => VCC_net, -- tied to '1' from definition
        FAB_RXVALIDH                            => GND_net, -- tied to '0' from definition
        FAB_SESSEND                             => VCC_net, -- tied to '1' from definition
        FAB_TXREADY                             => VCC_net, -- tied to '1' from definition
        FAB_VBUSVALID                           => VCC_net, -- tied to '1' from definition
        FAB_VSTATUS                             => FAB_VSTATUS_const_net_0, -- tied to X"1" from definition
        FAB_XDATAIN                             => FAB_XDATAIN_const_net_0, -- tied to X"1" from definition
        GTX_CLKPF                               => VCC_net, -- tied to '1' from definition
        I2C0_BCLK                               => VCC_net, -- tied to '1' from definition
        I2C0_SCL_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        I2C0_SDA_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        I2C1_BCLK                               => VCC_net, -- tied to '1' from definition
        I2C1_SCL_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        I2C1_SDA_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        MDIF                                    => VCC_net, -- tied to '1' from definition
        MGPIO0A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MGPIO10A_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO11A_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO11B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO12A_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO13A_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO14A_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO15A_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO16A_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO17B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO18B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO19B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO1A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MGPIO20B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO21B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO22B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO24B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO25B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO26B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO27B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO28B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO29B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO2A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MGPIO30B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO31B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO3A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MGPIO4A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MGPIO5A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MGPIO6A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MGPIO7A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MGPIO8A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MGPIO9A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MMUART0_CTS_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART0_DCD_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART0_DSR_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART0_DTR_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART0_RI_F2H_SCP                      => VCC_net, -- tied to '1' from definition
        MMUART0_RTS_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART0_RXD_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART0_SCK_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART0_TXD_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART1_CTS_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART1_DCD_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART1_DSR_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART1_RI_F2H_SCP                      => VCC_net, -- tied to '1' from definition
        MMUART1_RTS_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART1_RXD_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART1_SCK_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART1_TXD_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        PER2_FABRIC_PRDATA                      => FIC_2_APB_M_PRDATA,
        PER2_FABRIC_PREADY                      => FIC_2_APB_M_PREADY,
        PER2_FABRIC_PSLVERR                     => FIC_2_APB_M_PSLVERR,
        RCGF                                    => RCGF_const_net_0, -- tied to X"1" from definition
        RX_CLKPF                                => VCC_net, -- tied to '1' from definition
        RX_DVF                                  => VCC_net, -- tied to '1' from definition
        RX_ERRF                                 => VCC_net, -- tied to '1' from definition
        RX_EV                                   => VCC_net, -- tied to '1' from definition
        RXDF                                    => RXDF_const_net_0, -- tied to X"1" from definition
        SLEEPHOLDREQ                            => GND_net, -- tied to '0' from definition
        SMBALERT_NI0                            => VCC_net, -- tied to '1' from definition
        SMBALERT_NI1                            => VCC_net, -- tied to '1' from definition
        SMBSUS_NI0                              => VCC_net, -- tied to '1' from definition
        SMBSUS_NI1                              => VCC_net, -- tied to '1' from definition
        SPI0_CLK_IN                             => SPI_0_CLK_F2M,
        SPI0_SDI_F2H_SCP                        => SPI_0_DI_F2M,
        SPI0_SDO_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI0_SS0_F2H_SCP                        => SPI_0_SS0_F2M,
        SPI0_SS1_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI0_SS2_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI0_SS3_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI1_CLK_IN                             => VCC_net, -- tied to '1' from definition
        SPI1_SDI_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI1_SDO_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI1_SS0_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI1_SS1_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI1_SS2_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI1_SS3_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        TX_CLKPF                                => VCC_net, -- tied to '1' from definition
        USER_MSS_GPIO_RESET_N                   => VCC_net, -- tied to '1' from definition
        USER_MSS_RESET_N                        => MSS_RESET_N_F2M,
        XCLK_FAB                                => VCC_net, -- tied to '1' from definition
        CLK_BASE                                => MCCC_CLK_BASE,
        CLK_MDDR_APB                            => VCC_net, -- tied to '1' from definition
        F_ARADDR_HADDR1                         => F_ARADDR_HADDR1_const_net_0, -- tied to X"1" from definition
        F_ARBURST_HTRANS1                       => F_ARBURST_HTRANS1_const_net_0, -- tied to X"0" from definition
        F_ARID_HSEL1                            => F_ARID_HSEL1_const_net_0, -- tied to X"0" from definition
        F_ARLEN_HBURST1                         => F_ARLEN_HBURST1_const_net_0, -- tied to X"0" from definition
        F_ARLOCK_HMASTLOCK1                     => F_ARLOCK_HMASTLOCK1_const_net_0, -- tied to X"0" from definition
        F_ARSIZE_HSIZE1                         => F_ARSIZE_HSIZE1_const_net_0, -- tied to X"0" from definition
        F_ARVALID_HWRITE1                       => GND_net, -- tied to '0' from definition
        F_AWADDR_HADDR0                         => F_AWADDR_HADDR0_const_net_0, -- tied to X"1" from definition
        F_AWBURST_HTRANS0                       => F_AWBURST_HTRANS0_const_net_0, -- tied to X"0" from definition
        F_AWID_HSEL0                            => F_AWID_HSEL0_const_net_0, -- tied to X"0" from definition
        F_AWLEN_HBURST0                         => F_AWLEN_HBURST0_const_net_0, -- tied to X"0" from definition
        F_AWLOCK_HMASTLOCK0                     => F_AWLOCK_HMASTLOCK0_const_net_0, -- tied to X"0" from definition
        F_AWSIZE_HSIZE0                         => F_AWSIZE_HSIZE0_const_net_0, -- tied to X"0" from definition
        F_AWVALID_HWRITE0                       => GND_net, -- tied to '0' from definition
        F_BREADY                                => GND_net, -- tied to '0' from definition
        F_RMW_AXI                               => GND_net, -- tied to '0' from definition
        F_RREADY                                => GND_net, -- tied to '0' from definition
        F_WDATA_HWDATA01                        => F_WDATA_HWDATA01_const_net_0, -- tied to X"1" from definition
        F_WID_HREADY01                          => F_WID_HREADY01_const_net_0, -- tied to X"0" from definition
        F_WLAST                                 => GND_net, -- tied to '0' from definition
        F_WSTRB                                 => F_WSTRB_const_net_0, -- tied to X"0" from definition
        F_WVALID                                => GND_net, -- tied to '0' from definition
        FPGA_MDDR_ARESET_N                      => VCC_net, -- tied to '1' from definition
        MDDR_FABRIC_PADDR                       => MDDR_FABRIC_PADDR_const_net_0, -- tied to X"1" from definition
        MDDR_FABRIC_PENABLE                     => VCC_net, -- tied to '1' from definition
        MDDR_FABRIC_PSEL                        => VCC_net, -- tied to '1' from definition
        MDDR_FABRIC_PWDATA                      => MDDR_FABRIC_PWDATA_const_net_0, -- tied to X"1" from definition
        MDDR_FABRIC_PWRITE                      => VCC_net, -- tied to '1' from definition
        PRESET_N                                => GND_net, -- tied to '0' from definition
        CAN_RXBUS_USBA_DATA1_MGPIO3A_IN         => GND_net,
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_IN        => GND_net,
        CAN_TXBUS_USBA_DATA0_MGPIO2A_IN         => GND_net,
        DM_IN                                   => DM_IN_const_net_0,
        DRAM_DQ_IN                              => DRAM_DQ_IN_const_net_0,
        DRAM_DQS_IN                             => DRAM_DQS_IN_const_net_0,
        DRAM_FIFO_WE_IN                         => DRAM_FIFO_WE_IN_const_net_0,
        I2C0_SCL_USBC_DATA1_MGPIO31B_IN         => GND_net,
        I2C0_SDA_USBC_DATA0_MGPIO30B_IN         => GND_net,
        I2C1_SCL_USBA_DATA4_MGPIO1A_IN          => GND_net,
        I2C1_SDA_USBA_DATA3_MGPIO0A_IN          => GND_net,
        MGPIO25A_IN                             => GND_net,
        MGPIO26A_IN                             => GND_net,
        MMUART0_CTS_USBC_DATA7_MGPIO19B_IN      => GND_net,
        MMUART0_DCD_MGPIO22B_IN                 => GND_net,
        MMUART0_DSR_MGPIO20B_IN                 => GND_net,
        MMUART0_DTR_USBC_DATA6_MGPIO18B_IN      => GND_net,
        MMUART0_RI_MGPIO21B_IN                  => GND_net,
        MMUART0_RTS_USBC_DATA5_MGPIO17B_IN      => GND_net,
        MMUART0_RXD_USBC_STP_MGPIO28B_IN        => GND_net,
        MMUART0_SCK_USBC_NXT_MGPIO29B_IN        => GND_net,
        MMUART0_TXD_USBC_DIR_MGPIO27B_IN        => GND_net,
        MMUART1_CTS_MGPIO13B_IN                 => GND_net,
        MMUART1_DCD_MGPIO16B_IN                 => GND_net,
        MMUART1_DSR_MGPIO14B_IN                 => GND_net,
        MMUART1_DTR_MGPIO12B_IN                 => GND_net,
        MMUART1_RI_MGPIO15B_IN                  => GND_net,
        MMUART1_RTS_MGPIO11B_IN                 => GND_net,
        MMUART1_RXD_USBC_DATA3_MGPIO26B_IN      => GND_net,
        MMUART1_SCK_USBC_DATA4_MGPIO25B_IN      => GND_net,
        MMUART1_TXD_USBC_DATA2_MGPIO24B_IN      => GND_net,
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_IN     => GND_net,
        RGMII_MDC_RMII_MDC_IN                   => GND_net,
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_IN      => GND_net,
        RGMII_RX_CLK_IN                         => GND_net,
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_IN  => GND_net,
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_IN      => GND_net,
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_IN      => GND_net,
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_IN     => GND_net,
        RGMII_RXD3_USBB_DATA4_IN                => GND_net,
        RGMII_TX_CLK_IN                         => GND_net,
        RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_IN     => GND_net,
        RGMII_TXD0_RMII_TXD0_USBB_DIR_IN        => GND_net,
        RGMII_TXD1_RMII_TXD1_USBB_STP_IN        => GND_net,
        RGMII_TXD2_USBB_DATA5_IN                => GND_net,
        RGMII_TXD3_USBB_DATA6_IN                => GND_net,
        SPI0_SCK_USBA_XCLK_IN                   => GND_net,
        SPI0_SDI_USBA_DIR_MGPIO5A_IN            => GND_net,
        SPI0_SDO_USBA_STP_MGPIO6A_IN            => GND_net,
        SPI0_SS0_USBA_NXT_MGPIO7A_IN            => GND_net,
        SPI0_SS1_USBA_DATA5_MGPIO8A_IN          => GND_net,
        SPI0_SS2_USBA_DATA6_MGPIO9A_IN          => GND_net,
        SPI0_SS3_USBA_DATA7_MGPIO10A_IN         => GND_net,
        SPI0_SS4_MGPIO19A_IN                    => GND_net,
        SPI0_SS5_MGPIO20A_IN                    => GND_net,
        SPI0_SS6_MGPIO21A_IN                    => GND_net,
        SPI0_SS7_MGPIO22A_IN                    => GND_net,
        SPI1_SCK_IN                             => GND_net,
        SPI1_SDI_MGPIO11A_IN                    => GND_net,
        SPI1_SDO_MGPIO12A_IN                    => GND_net,
        SPI1_SS0_MGPIO13A_IN                    => GND_net,
        SPI1_SS1_MGPIO14A_IN                    => GND_net,
        SPI1_SS2_MGPIO15A_IN                    => GND_net,
        SPI1_SS3_MGPIO16A_IN                    => GND_net,
        SPI1_SS4_MGPIO17A_IN                    => GND_net,
        SPI1_SS5_MGPIO18A_IN                    => GND_net,
        SPI1_SS6_MGPIO23A_IN                    => GND_net,
        SPI1_SS7_MGPIO24A_IN                    => GND_net,
        USBC_XCLK_IN                            => GND_net,
        -- Outputs
        CAN_RXBUS_MGPIO3A_H2F_A                 => OPEN,
        CAN_RXBUS_MGPIO3A_H2F_B                 => OPEN,
        CAN_TX_EBL_MGPIO4A_H2F_A                => OPEN,
        CAN_TX_EBL_MGPIO4A_H2F_B                => OPEN,
        CAN_TXBUS_MGPIO2A_H2F_A                 => OPEN,
        CAN_TXBUS_MGPIO2A_H2F_B                 => OPEN,
        CLK_CONFIG_APB                          => FIC_2_APB_M_PCLK_0,
        COMMS_INT                               => OPEN,
        CONFIG_PRESET_N                         => FIC_2_APB_M_PRESET_N_0,
        EDAC_ERROR                              => OPEN,
        F_FM0_RDATA                             => OPEN,
        F_FM0_READYOUT                          => OPEN,
        F_FM0_RESP                              => OPEN,
        F_HM0_ADDR                              => FIC_0_APB_MASTER_PADDR,
        F_HM0_ENABLE                            => FIC_0_APB_MASTER_PENABLE,
        F_HM0_SEL                               => FIC_0_APB_MASTER_PSELx,
        F_HM0_SIZE                              => OPEN,
        F_HM0_TRANS1                            => OPEN,
        F_HM0_WDATA                             => FIC_0_APB_MASTER_PWDATA,
        F_HM0_WRITE                             => FIC_0_APB_MASTER_PWRITE,
        FAB_CHRGVBUS                            => OPEN,
        FAB_DISCHRGVBUS                         => OPEN,
        FAB_DMPULLDOWN                          => OPEN,
        FAB_DPPULLDOWN                          => OPEN,
        FAB_DRVVBUS                             => OPEN,
        FAB_IDPULLUP                            => OPEN,
        FAB_OPMODE                              => OPEN,
        FAB_SUSPENDM                            => OPEN,
        FAB_TERMSEL                             => OPEN,
        FAB_TXVALID                             => OPEN,
        FAB_VCONTROL                            => OPEN,
        FAB_VCONTROLLOADM                       => OPEN,
        FAB_XCVRSEL                             => OPEN,
        FAB_XDATAOUT                            => OPEN,
        FACC_GLMUX_SEL                          => OPEN,
        FIC32_0_MASTER                          => OPEN,
        FIC32_1_MASTER                          => OPEN,
        FPGA_RESET_N                            => MSS_RESET_N_M2F_net_0,
        GTX_CLK                                 => OPEN,
        H2F_INTERRUPT                           => OPEN,
        H2F_NMI                                 => OPEN,
        H2FCALIB                                => OPEN,
        I2C0_SCL_MGPIO31B_H2F_A                 => OPEN,
        I2C0_SCL_MGPIO31B_H2F_B                 => OPEN,
        I2C0_SDA_MGPIO30B_H2F_A                 => OPEN,
        I2C0_SDA_MGPIO30B_H2F_B                 => OPEN,
        I2C1_SCL_MGPIO1A_H2F_A                  => OPEN,
        I2C1_SCL_MGPIO1A_H2F_B                  => OPEN,
        I2C1_SDA_MGPIO0A_H2F_A                  => OPEN,
        I2C1_SDA_MGPIO0A_H2F_B                  => OPEN,
        MDCF                                    => OPEN,
        MDOENF                                  => OPEN,
        MDOF                                    => OPEN,
        MMUART0_CTS_MGPIO19B_H2F_A              => OPEN,
        MMUART0_CTS_MGPIO19B_H2F_B              => OPEN,
        MMUART0_DCD_MGPIO22B_H2F_A              => OPEN,
        MMUART0_DCD_MGPIO22B_H2F_B              => OPEN,
        MMUART0_DSR_MGPIO20B_H2F_A              => OPEN,
        MMUART0_DSR_MGPIO20B_H2F_B              => OPEN,
        MMUART0_DTR_MGPIO18B_H2F_A              => OPEN,
        MMUART0_DTR_MGPIO18B_H2F_B              => OPEN,
        MMUART0_RI_MGPIO21B_H2F_A               => OPEN,
        MMUART0_RI_MGPIO21B_H2F_B               => OPEN,
        MMUART0_RTS_MGPIO17B_H2F_A              => OPEN,
        MMUART0_RTS_MGPIO17B_H2F_B              => OPEN,
        MMUART0_RXD_MGPIO28B_H2F_A              => OPEN,
        MMUART0_RXD_MGPIO28B_H2F_B              => OPEN,
        MMUART0_SCK_MGPIO29B_H2F_A              => OPEN,
        MMUART0_SCK_MGPIO29B_H2F_B              => OPEN,
        MMUART0_TXD_MGPIO27B_H2F_A              => OPEN,
        MMUART0_TXD_MGPIO27B_H2F_B              => OPEN,
        MMUART1_DTR_MGPIO12B_H2F_A              => OPEN,
        MMUART1_RTS_MGPIO11B_H2F_A              => OPEN,
        MMUART1_RTS_MGPIO11B_H2F_B              => OPEN,
        MMUART1_RXD_MGPIO26B_H2F_A              => OPEN,
        MMUART1_RXD_MGPIO26B_H2F_B              => OPEN,
        MMUART1_SCK_MGPIO25B_H2F_A              => OPEN,
        MMUART1_SCK_MGPIO25B_H2F_B              => OPEN,
        MMUART1_TXD_MGPIO24B_H2F_A              => OPEN,
        MMUART1_TXD_MGPIO24B_H2F_B              => OPEN,
        MPLL_LOCK                               => OPEN,
        PER2_FABRIC_PADDR                       => FIC_2_APB_MASTER_0_PADDR,
        PER2_FABRIC_PENABLE                     => FIC_2_APB_MASTER_0_PENABLE,
        PER2_FABRIC_PSEL                        => FIC_2_APB_MASTER_0_PSELx,
        PER2_FABRIC_PWDATA                      => FIC_2_APB_MASTER_0_PWDATA,
        PER2_FABRIC_PWRITE                      => FIC_2_APB_MASTER_0_PWRITE,
        RTC_MATCH                               => OPEN,
        SLEEPDEEP                               => OPEN,
        SLEEPHOLDACK                            => OPEN,
        SLEEPING                                => OPEN,
        SMBALERT_NO0                            => OPEN,
        SMBALERT_NO1                            => OPEN,
        SMBSUS_NO0                              => OPEN,
        SMBSUS_NO1                              => OPEN,
        SPI0_CLK_OUT                            => SPI_0_CLK_M2F_net_0,
        SPI0_SDI_MGPIO5A_H2F_A                  => OPEN,
        SPI0_SDI_MGPIO5A_H2F_B                  => OPEN,
        SPI0_SDO_MGPIO6A_H2F_A                  => SPI_0_DO_M2F_net_0,
        SPI0_SDO_MGPIO6A_H2F_B                  => OPEN,
        SPI0_SS0_MGPIO7A_H2F_A                  => SPI_0_SS0_M2F_net_0,
        SPI0_SS0_MGPIO7A_H2F_B                  => SPI_0_SS0_M2F_OE_net_0,
        SPI0_SS1_MGPIO8A_H2F_A                  => SPI_0_SS1_M2F_net_0,
        SPI0_SS1_MGPIO8A_H2F_B                  => OPEN,
        SPI0_SS2_MGPIO9A_H2F_A                  => SPI_0_SS2_M2F_net_0,
        SPI0_SS2_MGPIO9A_H2F_B                  => OPEN,
        SPI0_SS3_MGPIO10A_H2F_A                 => SPI_0_SS3_M2F_net_0,
        SPI0_SS3_MGPIO10A_H2F_B                 => OPEN,
        SPI0_SS4_MGPIO19A_H2F_A                 => SPI_0_SS4_M2F_net_0,
        SPI0_SS5_MGPIO20A_H2F_A                 => OPEN,
        SPI0_SS6_MGPIO21A_H2F_A                 => OPEN,
        SPI0_SS7_MGPIO22A_H2F_A                 => OPEN,
        SPI1_CLK_OUT                            => OPEN,
        SPI1_SDI_MGPIO11A_H2F_A                 => OPEN,
        SPI1_SDI_MGPIO11A_H2F_B                 => OPEN,
        SPI1_SDO_MGPIO12A_H2F_A                 => OPEN,
        SPI1_SDO_MGPIO12A_H2F_B                 => OPEN,
        SPI1_SS0_MGPIO13A_H2F_A                 => OPEN,
        SPI1_SS0_MGPIO13A_H2F_B                 => OPEN,
        SPI1_SS1_MGPIO14A_H2F_A                 => OPEN,
        SPI1_SS1_MGPIO14A_H2F_B                 => OPEN,
        SPI1_SS2_MGPIO15A_H2F_A                 => OPEN,
        SPI1_SS2_MGPIO15A_H2F_B                 => OPEN,
        SPI1_SS3_MGPIO16A_H2F_A                 => OPEN,
        SPI1_SS3_MGPIO16A_H2F_B                 => OPEN,
        SPI1_SS4_MGPIO17A_H2F_A                 => OPEN,
        SPI1_SS5_MGPIO18A_H2F_A                 => OPEN,
        SPI1_SS6_MGPIO23A_H2F_A                 => OPEN,
        SPI1_SS7_MGPIO24A_H2F_A                 => OPEN,
        TCGF                                    => OPEN,
        TRACECLK                                => OPEN,
        TRACEDATA                               => OPEN,
        TX_CLK                                  => OPEN,
        TX_ENF                                  => OPEN,
        TX_ERRF                                 => OPEN,
        TXCTL_EN_RIF                            => OPEN,
        TXD_RIF                                 => OPEN,
        TXDF                                    => OPEN,
        TXEV                                    => OPEN,
        WDOGTIMEOUT                             => OPEN,
        F_ARREADY_HREADYOUT1                    => OPEN,
        F_AWREADY_HREADYOUT0                    => OPEN,
        F_BID                                   => OPEN,
        F_BRESP_HRESP0                          => OPEN,
        F_BVALID                                => OPEN,
        F_RDATA_HRDATA01                        => OPEN,
        F_RID                                   => OPEN,
        F_RLAST                                 => OPEN,
        F_RRESP_HRESP1                          => OPEN,
        F_RVALID                                => OPEN,
        F_WREADY                                => OPEN,
        MDDR_FABRIC_PRDATA                      => OPEN,
        MDDR_FABRIC_PREADY                      => OPEN,
        MDDR_FABRIC_PSLVERR                     => OPEN,
        CAN_RXBUS_USBA_DATA1_MGPIO3A_OUT        => OPEN,
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_OUT       => OPEN,
        CAN_TXBUS_USBA_DATA0_MGPIO2A_OUT        => OPEN,
        DRAM_ADDR                               => OPEN,
        DRAM_BA                                 => OPEN,
        DRAM_CASN                               => OPEN,
        DRAM_CKE                                => OPEN,
        DRAM_CLK                                => OPEN,
        DRAM_CSN                                => OPEN,
        DRAM_DM_RDQS_OUT                        => OPEN,
        DRAM_DQ_OUT                             => OPEN,
        DRAM_DQS_OUT                            => OPEN,
        DRAM_FIFO_WE_OUT                        => OPEN,
        DRAM_ODT                                => OPEN,
        DRAM_RASN                               => OPEN,
        DRAM_RSTN                               => OPEN,
        DRAM_WEN                                => OPEN,
        I2C0_SCL_USBC_DATA1_MGPIO31B_OUT        => OPEN,
        I2C0_SDA_USBC_DATA0_MGPIO30B_OUT        => OPEN,
        I2C1_SCL_USBA_DATA4_MGPIO1A_OUT         => OPEN,
        I2C1_SDA_USBA_DATA3_MGPIO0A_OUT         => OPEN,
        MGPIO25A_OUT                            => OPEN,
        MGPIO26A_OUT                            => OPEN,
        MMUART0_CTS_USBC_DATA7_MGPIO19B_OUT     => OPEN,
        MMUART0_DCD_MGPIO22B_OUT                => OPEN,
        MMUART0_DSR_MGPIO20B_OUT                => OPEN,
        MMUART0_DTR_USBC_DATA6_MGPIO18B_OUT     => OPEN,
        MMUART0_RI_MGPIO21B_OUT                 => OPEN,
        MMUART0_RTS_USBC_DATA5_MGPIO17B_OUT     => OPEN,
        MMUART0_RXD_USBC_STP_MGPIO28B_OUT       => OPEN,
        MMUART0_SCK_USBC_NXT_MGPIO29B_OUT       => OPEN,
        MMUART0_TXD_USBC_DIR_MGPIO27B_OUT       => OPEN,
        MMUART1_CTS_MGPIO13B_OUT                => OPEN,
        MMUART1_DCD_MGPIO16B_OUT                => OPEN,
        MMUART1_DSR_MGPIO14B_OUT                => OPEN,
        MMUART1_DTR_MGPIO12B_OUT                => OPEN,
        MMUART1_RI_MGPIO15B_OUT                 => OPEN,
        MMUART1_RTS_MGPIO11B_OUT                => OPEN,
        MMUART1_RXD_USBC_DATA3_MGPIO26B_OUT     => OPEN,
        MMUART1_SCK_USBC_DATA4_MGPIO25B_OUT     => OPEN,
        MMUART1_TXD_USBC_DATA2_MGPIO24B_OUT     => OPEN,
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OUT    => OPEN,
        RGMII_MDC_RMII_MDC_OUT                  => OPEN,
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_OUT     => OPEN,
        RGMII_RX_CLK_OUT                        => OPEN,
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OUT => OPEN,
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_OUT     => OPEN,
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_OUT     => OPEN,
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OUT    => OPEN,
        RGMII_RXD3_USBB_DATA4_OUT               => OPEN,
        RGMII_TX_CLK_OUT                        => OPEN,
        RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OUT    => OPEN,
        RGMII_TXD0_RMII_TXD0_USBB_DIR_OUT       => OPEN,
        RGMII_TXD1_RMII_TXD1_USBB_STP_OUT       => OPEN,
        RGMII_TXD2_USBB_DATA5_OUT               => OPEN,
        RGMII_TXD3_USBB_DATA6_OUT               => OPEN,
        SPI0_SCK_USBA_XCLK_OUT                  => OPEN,
        SPI0_SDI_USBA_DIR_MGPIO5A_OUT           => OPEN,
        SPI0_SDO_USBA_STP_MGPIO6A_OUT           => OPEN,
        SPI0_SS0_USBA_NXT_MGPIO7A_OUT           => OPEN,
        SPI0_SS1_USBA_DATA5_MGPIO8A_OUT         => OPEN,
        SPI0_SS2_USBA_DATA6_MGPIO9A_OUT         => OPEN,
        SPI0_SS3_USBA_DATA7_MGPIO10A_OUT        => OPEN,
        SPI0_SS4_MGPIO19A_OUT                   => OPEN,
        SPI0_SS5_MGPIO20A_OUT                   => OPEN,
        SPI0_SS6_MGPIO21A_OUT                   => OPEN,
        SPI0_SS7_MGPIO22A_OUT                   => OPEN,
        SPI1_SCK_OUT                            => OPEN,
        SPI1_SDI_MGPIO11A_OUT                   => OPEN,
        SPI1_SDO_MGPIO12A_OUT                   => OPEN,
        SPI1_SS0_MGPIO13A_OUT                   => OPEN,
        SPI1_SS1_MGPIO14A_OUT                   => OPEN,
        SPI1_SS2_MGPIO15A_OUT                   => OPEN,
        SPI1_SS3_MGPIO16A_OUT                   => OPEN,
        SPI1_SS4_MGPIO17A_OUT                   => OPEN,
        SPI1_SS5_MGPIO18A_OUT                   => OPEN,
        SPI1_SS6_MGPIO23A_OUT                   => OPEN,
        SPI1_SS7_MGPIO24A_OUT                   => OPEN,
        USBC_XCLK_OUT                           => OPEN,
        CAN_RXBUS_USBA_DATA1_MGPIO3A_OE         => OPEN,
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_OE        => OPEN,
        CAN_TXBUS_USBA_DATA0_MGPIO2A_OE         => OPEN,
        DM_OE                                   => OPEN,
        DRAM_DQ_OE                              => OPEN,
        DRAM_DQS_OE                             => OPEN,
        I2C0_SCL_USBC_DATA1_MGPIO31B_OE         => OPEN,
        I2C0_SDA_USBC_DATA0_MGPIO30B_OE         => OPEN,
        I2C1_SCL_USBA_DATA4_MGPIO1A_OE          => OPEN,
        I2C1_SDA_USBA_DATA3_MGPIO0A_OE          => OPEN,
        MGPIO25A_OE                             => OPEN,
        MGPIO26A_OE                             => OPEN,
        MMUART0_CTS_USBC_DATA7_MGPIO19B_OE      => OPEN,
        MMUART0_DCD_MGPIO22B_OE                 => OPEN,
        MMUART0_DSR_MGPIO20B_OE                 => OPEN,
        MMUART0_DTR_USBC_DATA6_MGPIO18B_OE      => OPEN,
        MMUART0_RI_MGPIO21B_OE                  => OPEN,
        MMUART0_RTS_USBC_DATA5_MGPIO17B_OE      => OPEN,
        MMUART0_RXD_USBC_STP_MGPIO28B_OE        => OPEN,
        MMUART0_SCK_USBC_NXT_MGPIO29B_OE        => OPEN,
        MMUART0_TXD_USBC_DIR_MGPIO27B_OE        => OPEN,
        MMUART1_CTS_MGPIO13B_OE                 => OPEN,
        MMUART1_DCD_MGPIO16B_OE                 => OPEN,
        MMUART1_DSR_MGPIO14B_OE                 => OPEN,
        MMUART1_DTR_MGPIO12B_OE                 => OPEN,
        MMUART1_RI_MGPIO15B_OE                  => OPEN,
        MMUART1_RTS_MGPIO11B_OE                 => OPEN,
        MMUART1_RXD_USBC_DATA3_MGPIO26B_OE      => OPEN,
        MMUART1_SCK_USBC_DATA4_MGPIO25B_OE      => OPEN,
        MMUART1_TXD_USBC_DATA2_MGPIO24B_OE      => OPEN,
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OE     => OPEN,
        RGMII_MDC_RMII_MDC_OE                   => OPEN,
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_OE      => OPEN,
        RGMII_RX_CLK_OE                         => OPEN,
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OE  => OPEN,
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_OE      => OPEN,
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_OE      => OPEN,
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OE     => OPEN,
        RGMII_RXD3_USBB_DATA4_OE                => OPEN,
        RGMII_TX_CLK_OE                         => OPEN,
        RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OE     => OPEN,
        RGMII_TXD0_RMII_TXD0_USBB_DIR_OE        => OPEN,
        RGMII_TXD1_RMII_TXD1_USBB_STP_OE        => OPEN,
        RGMII_TXD2_USBB_DATA5_OE                => OPEN,
        RGMII_TXD3_USBB_DATA6_OE                => OPEN,
        SPI0_SCK_USBA_XCLK_OE                   => OPEN,
        SPI0_SDI_USBA_DIR_MGPIO5A_OE            => OPEN,
        SPI0_SDO_USBA_STP_MGPIO6A_OE            => OPEN,
        SPI0_SS0_USBA_NXT_MGPIO7A_OE            => OPEN,
        SPI0_SS1_USBA_DATA5_MGPIO8A_OE          => OPEN,
        SPI0_SS2_USBA_DATA6_MGPIO9A_OE          => OPEN,
        SPI0_SS3_USBA_DATA7_MGPIO10A_OE         => OPEN,
        SPI0_SS4_MGPIO19A_OE                    => OPEN,
        SPI0_SS5_MGPIO20A_OE                    => OPEN,
        SPI0_SS6_MGPIO21A_OE                    => OPEN,
        SPI0_SS7_MGPIO22A_OE                    => OPEN,
        SPI1_SCK_OE                             => OPEN,
        SPI1_SDI_MGPIO11A_OE                    => OPEN,
        SPI1_SDO_MGPIO12A_OE                    => OPEN,
        SPI1_SS0_MGPIO13A_OE                    => OPEN,
        SPI1_SS1_MGPIO14A_OE                    => OPEN,
        SPI1_SS2_MGPIO15A_OE                    => OPEN,
        SPI1_SS3_MGPIO16A_OE                    => OPEN,
        SPI1_SS4_MGPIO17A_OE                    => OPEN,
        SPI1_SS5_MGPIO18A_OE                    => OPEN,
        SPI1_SS6_MGPIO23A_OE                    => OPEN,
        SPI1_SS7_MGPIO24A_OE                    => OPEN,
        USBC_XCLK_OE                            => OPEN 
        );

end RTL;
