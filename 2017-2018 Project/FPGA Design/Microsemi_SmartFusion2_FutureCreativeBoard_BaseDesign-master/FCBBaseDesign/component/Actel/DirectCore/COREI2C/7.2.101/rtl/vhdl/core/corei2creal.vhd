-- ********************************************************************/
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2014 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Project name         : CoreI2C
-- Project description  : Inter-Integrated Circuit Bus Interface (I2C)
--
-- File name            : corei2creal.vhd
-- File contents        : Module CoreI2C
-- Purpose              : CoreI2C Serial Channel
--
-- Destination library  : COREI2C_LIB 
-- 
-- SVN Revision Information:
-- SVN $Revision: 29395 $
-- SVN $Date: 2017-03-23 18:27:57 +0530 (Thu, 23 Mar 2017) $  
-- 
-- 
-------------------------------------------------------------------------

--*******************************************************************--
library IEEE;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
   use IEEE.STD_LOGIC_1164.all;
   use IEEE.STD_LOGIC_UNSIGNED."+";
   use IEEE.STD_LOGIC_UNSIGNED."-";
   use IEEE.NUMERIC_STD.all;
library COREI2C_LIB;

--*******************************************************************--
entity COREI2C_COREI2CREAL is
 generic (
      --FAMILY                     : INTEGER := 17;
      OPERATING_MODE             : INTEGER := 0;
      BAUD_RATE_FIXED            : INTEGER := 0;
      BAUD_RATE_VALUE            : INTEGER := 0;
      BCLK_ENABLED               : INTEGER := 1;
      GLITCHREG_NUM              : INTEGER := 3;
      SMB_EN                     : INTEGER := 0;
      IPMI_EN                    : INTEGER := 1;
      FREQUENCY                  : INTEGER := 30;
      FIXED_SLAVE0_ADDR_EN       : INTEGER := 0;
      FIXED_SLAVE0_ADDR_VALUE    : INTEGER := 0;
      ADD_SLAVE1_ADDRESS_EN      : INTEGER := 1;
      FIXED_SLAVE1_ADDR_EN       : INTEGER := 0;
      FIXED_SLAVE1_ADDR_VALUE    : INTEGER := 0
	);
 port (
 	-- system globals
 	PCLK   		: in  STD_LOGIC;  -- Global clock input
 	aresetn		: in  STD_LOGIC;
    sresetn		: in  STD_LOGIC;
 	BCLKe  		: in  STD_LOGIC;  -- Baud Clk
 	
 	-- common logic signals for multiple channels
 	pulse_215us : in  STD_LOGIC;
 	seradr0		: in  STD_LOGIC_VECTOR(7 downto 0);
 	seradr1		: in  STD_LOGIC_VECTOR(7 downto 0);
 	seradr1apb0	: in  STD_LOGIC;

 	-- Serial inputs
 	SCLI     	: in  STD_LOGIC;  -- serial clock input
 	SDAI     	: in  STD_LOGIC;  -- serial data input

 	-- APB register interface
 	PSEL      	: in  STD_LOGIC;
 	PENABLE    	: in  STD_LOGIC;
 	PWRITE    	: in  STD_LOGIC;
 	PADDR      	: in  STD_LOGIC_VECTOR(4 downto 0); -- data address
 	PWDATA     	: in  STD_LOGIC_VECTOR(7 downto 0); -- data input

 	-- Serial outputs
 	SCLO      	: out STD_LOGIC;  -- serial clock output - registered
 	SDAO      	: out STD_LOGIC;  -- serial data output  - registered

 	-- Interrupt flags
 	INT        	: out STD_LOGIC;  -- INT flag          - registered
    SMBA_INT   	: out STD_LOGIC;
    SMBS_INT   	: out STD_LOGIC;

 	-- APB register interface read
 	PRDATA     	: out STD_LOGIC_VECTOR(7 downto 0);  -- data output
 	-- SMBus Optional Signals
 	SMBALERT_NI	: in  STD_LOGIC;
 	SMBALERT_NO	: out STD_LOGIC;
 	SMBSUS_NI	: in  STD_LOGIC;
 	SMBSUS_NO	: out STD_LOGIC
           );
end COREI2C_COREI2CREAL;

--*******************************************************************--


architecture RTL of COREI2C_COREI2CREAL is


FUNCTION or_br (
      val : std_logic_vector) RETURN std_logic IS
      VARIABLE rtn : std_logic := '0';
   BEGIN
      FOR index IN val'RANGE LOOP
         rtn := rtn OR val(index);
      END LOOP;
      RETURN(rtn);
   END or_br;

   FUNCTION and_br (
      val : std_logic_vector) RETURN std_logic IS
      VARIABLE rtn : std_logic := '1';
   BEGIN
      FOR index IN val'RANGE LOOP
         rtn := rtn AND val(index);
      END LOOP;
      RETURN(rtn);
   END and_br;

--  Operating_Mode[1:0]:
--   00 = Master and Slave
--   01 = Slave Only (TX and RX)
--   10 = Master TX, Slave Receive
--   11 = Slave Only RX
CONSTANT   OPERATING_MODE_V    : STD_LOGIC_VECTOR(1 DOWNTO 0) := std_logic_vector(to_unsigned(OPERATING_MODE,2));
CONSTANT      MST_TX_SLV_RX    : STD_LOGIC := OPERATING_MODE_V(1);
CONSTANT      SLAVE_ONLY_EN    : STD_LOGIC := OPERATING_MODE_V(0);

CONSTANT    DELLONGINX		   : INTEGER := 4;
CONSTANT    INFILTERDELAY 	   : INTEGER := GLITCHREG_NUM + 2;



CONSTANT      serCON_ID        : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
CONSTANT      serCON_RV        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
CONSTANT      serSTA_ID        : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00100";
CONSTANT      serSTA_RV        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "11111000";
CONSTANT      serDAT_ID        : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01000";
CONSTANT      serDAT_RV        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
CONSTANT      serSMB_ID        : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10000";
CONSTANT      serSMB_RV        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01X1X000";
CONSTANT      serADR0_ID       : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01100";
CONSTANT      serADR0_RV       : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
CONSTANT      serADR1_ID       : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11100";
CONSTANT      serADR1_RV       : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";

-----------------------------------------------------------------
-- FSM STATUS enumeration type
-----------------------------------------------------------------
type FSMSTA_TYPE is (FSMSTA08, FSMSTA10, FSMSTA18, FSMSTA20,
                     FSMSTA28, FSMSTA30, FSMSTA38, FSMSTA40,
                     FSMSTA48, FSMSTA50, FSMSTA58, FSMSTA60,
                     FSMSTA68, FSMSTA70, FSMSTA78, FSMSTA80,
                     FSMSTA88, FSMSTA90, FSMSTA98, FSMSTAA0,
                     FSMSTAA8, FSMSTAB0, FSMSTAB8, FSMSTAC0,
                     FSMSTAC8, FSMSTAF8, FSMSTA00, FSMSTAD0,
                     FSMSTAD8, FSMSTAE0);
--attribute syn_enum_encoding : string;
--attribute syn_enum_encoding of FSMSTA_TYPE : type is "gray";

-----------------------------------------------------------------
-- FSM DETECT enumeration type
-----------------------------------------------------------------
type FSMDET_TYPE is (FSMDET0, FSMDET1, FSMDET2, FSMDET3,
                     FSMDET4, FSMDET5, FSMDET6);
--attribute syn_enum_encoding : string;
--attribute syn_enum_encoding of FSMDET_TYPE : type is "gray";

-----------------------------------------------------------------
-- FSM SYNCHRONIZATION enumeration type
-----------------------------------------------------------------
type FSMSYNC_TYPE is (FSMSYNC0, FSMSYNC1, FSMSYNC2, FSMSYNC3,
                      FSMSYNC4, FSMSYNC5, FSMSYNC6, FSMSYNC7);
--attribute syn_enum_encoding : string;
--attribute syn_enum_encoding of FSMSYNC_TYPE : type is "gray";

-----------------------------------------------------------------
-- FSM MODE enumeration type
-----------------------------------------------------------------
type FSMMOD_TYPE is (FSMMOD0, FSMMOD1, FSMMOD2, FSMMOD3,
                     FSMMOD4, FSMMOD5, FSMMOD6);
--attribute syn_enum_encoding : string;
--attribute syn_enum_encoding of FSMMOD_TYPE : type is "gray";

-----------------------------------------------------------------
-- Timeout Counter Calibrations based on FREQUENCY
-----------------------------------------------------------------

--  using 215us free running pulses to increment a >35ms 8-bit counter,
--              flag with stick between 35.045 and 35.260.
CONSTANT term_cnt_35ms : INTEGER :=  164;
SIGNAL   term_cnt_35ms_reg :STD_LOGIC_VECTOR(7 downto 0);
SIGNAL   term_cnt_35ms_flag:STD_LOGIC;--flag for 35 ms timeout

--  using 215us free running pulses to increment a >25ms 7-bit counter,
--              flag with stick between 25.155 and 25.370.
CONSTANT term_cnt_25ms : INTEGER :=  118;
SIGNAL   term_cnt_25ms_reg :STD_LOGIC_VECTOR(6 downto 0);
SIGNAL   term_cnt_25ms_flag:STD_LOGIC;--flag for 25 ms timeout

--  using 215us free running pulses to increment a >3ms 4-bit counter,
--              flag with stick between 3.010 and 3.225.
CONSTANT term_cnt_3ms : INTEGER :=  15;
SIGNAL   term_cnt_3ms_reg :STD_LOGIC_VECTOR(3 downto 0);
SIGNAL   term_cnt_3ms_flag:STD_LOGIC;--flag for 3 ms timeout

-----------------------------------------------------------------
-- FSM registers and SIGNALs
-----------------------------------------------------------------
SIGNAL fsmmod          	: FSMMOD_TYPE;
-- Master/slave mode detection FSM state
SIGNAL fsmmod_nxt      	: FSMMOD_TYPE;
-- Master/slave mode detection FSM next state

SIGNAL fsmsync         	: FSMSYNC_TYPE;
-- Clock synchronization FSM
SIGNAL fsmsync_nxt     	: FSMSYNC_TYPE;
-- Clock synchronization FSM next state

SIGNAL fsmdet          	: FSMDET_TYPE;
-- stop/start detector FSM
SIGNAL fsmdet_nxt      	: FSMDET_TYPE;
-- stop/start detector FSM next state

SIGNAL fsmsta          	: FSMSTA_TYPE;
attribute syn_state_machine : boolean;
attribute syn_state_machine of fsmsta : SIGNAL is false;
-- status FSM
SIGNAL fsmsta_nxt      	: FSMSTA_TYPE;
-- serial status FSM next state


-----------------------------------------------------------------
-- sercon bits
-----------------------------------------------------------------
SIGNAL cr210           	: STD_LOGIC_VECTOR(2 downto 0);
-- cr2, cr1, cr0 bits
SIGNAL ens1            	: STD_LOGIC;
-- "enable serial 1" bit
SIGNAL sta             	: STD_LOGIC;
-- start bit
SIGNAL sto             	: STD_LOGIC;
-- stop bit
SIGNAL aa              	: STD_LOGIC;
-- acknowledge bit

-----------------------------------------------------------------
-- serial data bit 7
-----------------------------------------------------------------
SIGNAL bsd7            	: STD_LOGIC;
-- serial data bit 7
SIGNAL bsd7_tmp        	: STD_LOGIC;
-- serial data temporary bit 7

SIGNAL sercon			: STD_LOGIC_VECTOR(7 downto 0);
SIGNAL serdat     		: STD_LOGIC_VECTOR(7 downto 0);
SIGNAL sersta     		: STD_LOGIC_VECTOR(4 downto 0);

-----------------------------------------------------------------
-- SMBUS serial channel APB registers
-----------------------------------------------------------------
SIGNAL sersmb7          : STD_LOGIC;
SIGNAL sersmb6          : STD_LOGIC;
SIGNAL sersmb5          : STD_LOGIC;
SIGNAL sersmb4          : STD_LOGIC;
SIGNAL sersmb3          : STD_LOGIC;
SIGNAL sersmb2          : STD_LOGIC;
SIGNAL sersmb1          : STD_LOGIC;
SIGNAL sersmb0          : STD_LOGIC;

-----------------------------------------------------------------
-- internal sersmb bits; others come from ports.
-----------------------------------------------------------------
SIGNAL smbus_mst_reset			: STD_LOGIC;
SIGNAL smbus_mst_reset_posedge	: STD_LOGIC;
SIGNAL smbus_mst_reset_ff0		: STD_LOGIC;
SIGNAL smbus_mst_reset_ff1		: STD_LOGIC;
SIGNAL smbus_mst_reset_ff2		: STD_LOGIC;
SIGNAL set_int					: STD_LOGIC;
--^interrupt set for slave reset sequence.
SIGNAL ens1_pre					: STD_LOGIC;
--^internal reset of s.machines based on timeouts.

SIGNAL SMB_EN_int				: STD_LOGIC;
SIGNAL IPMI_EN_int              : STD_LOGIC;
SIGNAL SMBSUS_NI_d              : STD_LOGIC;
SIGNAL SMBSUS_NI_d2             : STD_LOGIC;
SIGNAL SMBALERT_NI_d            : STD_LOGIC;
SIGNAL SMBALERT_NI_d2           : STD_LOGIC;
-----------------------------------------------------------------
-- acknowledge bit
-----------------------------------------------------------------
SIGNAL ack             : STD_LOGIC;
-- acknowledge bit
SIGNAL ack_bit         : STD_LOGIC;
-- acknowledge temporary bit

-----------------------------------------------------------------
-- input filters
-----------------------------------------------------------------
SIGNAL SDAI_ff_reg: STD_LOGIC_VECTOR(GLITCHREG_NUM - 1 DOWNTO 0);
SIGNAL SDAInt     : STD_LOGIC;
SIGNAL SCLI_ff_reg: STD_LOGIC_VECTOR(GLITCHREG_NUM - 1 DOWNTO 0);
SIGNAL SCLInt     : STD_LOGIC;

-----------------------------------------------------------------
-- address comparator
-----------------------------------------------------------------
SIGNAL adrcomp         : STD_LOGIC; -- address comparator output
SIGNAL adrcompen       : STD_LOGIC; -- address comparator enable

-----------------------------------------------------------------
-- SCL edge detector
-----------------------------------------------------------------
SIGNAL nedetect        : STD_LOGIC; -- SCLInt negative edge det.
SIGNAL pedetect        : STD_LOGIC; -- SCLInt positive edge det.

-----------------------------------------------------------------
-- clock generator SIGNALs
-----------------------------------------------------------------
SIGNAL PCLK_count1      : STD_LOGIC_VECTOR(3 downto 0);
-- clock counter 1
SIGNAL PCLK_count1_ov   : STD_LOGIC;
-- PCLK_count1 overflow

SIGNAL PCLK_count2      : STD_LOGIC_VECTOR(3 downto 0);
-- clock counter 2
SIGNAL PCLK_count2_ov   : STD_LOGIC; -- PCLK_count2 overflow

SIGNAL PCLKint          : STD_LOGIC; -- internal PCLK generator
SIGNAL PCLKint_ff       : STD_LOGIC; -- int. PCLK gen. flip-flop

SIGNAL PCLKint_p1       : STD_LOGIC; -- positive edge PCLKint det.
SIGNAL PCLKint_p2       : STD_LOGIC; -- negative edge PCLKint det.

-----------------------------------------------------------------
-- clock counter reset
-----------------------------------------------------------------
SIGNAL counter_rst     : STD_LOGIC;

-----------------------------------------------------------------
-- frame synchronization counter
-----------------------------------------------------------------
SIGNAL framesync       : STD_LOGIC_VECTOR(3 downto 0);

-----------------------------------------------------------------
-- master mode indicator
-----------------------------------------------------------------
SIGNAL mst             : STD_LOGIC;

-----------------------------------------------------------------
-- input filter delay counter
-----------------------------------------------------------------
SIGNAL indelay         : STD_LOGIC_VECTOR(DELLONGINX - 1 downto 0);

-----------------------------------------------------------------
-----------------------------------------------------------------
SIGNAL busfree         : STD_LOGIC; -- bus free detector
SIGNAL SDAO_int        : STD_LOGIC; -- serial data output reg
SIGNAL SCLO_int        : STD_LOGIC; -- serial clock output reg
SIGNAL si_int          : STD_LOGIC; -- interrupt flag output
SIGNAL SCLSCL          : STD_LOGIC; -- two cycles SCL
SIGNAL starto_en       : STD_LOGIC; -- transmit START condition en

   begin



   --------------------------------------------------------------------
   -- Serial data output driver
   -- Registered output
   --------------------------------------------------------------------
   SDAO_DRV:
   --------------------------------------------------------------------
      SDAO <= SDAO_int;

   --------------------------------------------------------------------
   -- Serial clock output driver
   -- Registered output
   --------------------------------------------------------------------
   SCLO_DRV:
   --------------------------------------------------------------------
--      SCLO <= SCLO_int;
      SCLO <= '0' when smbus_mst_reset ='1' else SCLO_int;

   --------------------------------------------------------------------
   -- Interrupt flag output
   -- Registered output
   --------------------------------------------------------------------
   SI_DRV:
   --------------------------------------------------------------------
--      si <= si_int;
      INT <= si_int;

   --------------------------------------------------------------------
   -- serial data output write
   --------------------------------------------------------------------
   SDAO_INT_WRITE_PROC:
   --------------------------------------------------------------------
    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
           SDAO_int <= '1';
        elsif (PCLK'event and PCLK = '1') then
            if (sresetn = '0') then
                SDAO_int <= '1';
            else 
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                if (
                    (ens1='0') or        -- core disable
                    (fsmmod=FSMMOD3) or  -- repeated START transmit
                    (fsmmod=FSMMOD0 and adrcomp='0') --or -- n.a.slave
                    --(fsmsta=fsmsta38)
                )
                then -- arbit lost
                SDAO_int <= '1';
                elsif (
                        (fsmmod=FSMMOD1 or fsmmod=FSMMOD4 or
                        fsmmod=FSMMOD6
                        ) or  -- START / STOP transmit
                        (adrcomp='1' and adrcompen='1')
                    )
                then
                SDAO_int <= '0';
                elsif
                fsmsta=fsmsta38
                then
                SDAO_int <= '1';
                elsif (
                        (-------------------------------------
                        -- data ack
                        -------------------------------------
                        -- master receiver
                        -------------------------------------
                        ((fsmsta=FSMSTA40 OR fsmsta=FSMSTA50) AND (MST_TX_SLV_RX='0')) or
                        -------------------------------------
                        -- slave receiver
                        -------------------------------------
                        fsmsta=FSMSTA60 or fsmsta=FSMSTA68 or
                        fsmsta=FSMSTA80 or fsmsta=FSMSTA70 or
                        fsmsta=FSMSTA78 or fsmsta=FSMSTA90
                        ) and
                        (framesync="0111" or
                        framesync="1000")
                    )
                then
                    if (framesync = "0111" and nedetect = '1') then
                        SDAO_int <= not ack_bit; --serdat(7); -- data ACK
                    end if;
                elsif (-------------------------------------
                    -- transmit data
                    -------------------------------------
                    -- master transmitter
                    -------------------------------------
                    fsmsta=FSMSTA08 or fsmsta=FSMSTA10 or
                    fsmsta=FSMSTA18 or fsmsta=FSMSTA20 or
                    fsmsta=FSMSTA28 or fsmsta=FSMSTA30 or
                    -------------------------------------
                    -- slave transmitter
                    -------------------------------------
                    ((fsmsta = FSMSTAA8 OR fsmsta = FSMSTAB0 OR fsmsta = FSMSTAB8) AND (MST_TX_SLV_RX = '0'))
                    )
                then
                    if (framesync<"1000" or framesync="1001") then
                        SDAO_int <= bsd7;
                    else
                        SDAO_int <= '1';
                    end if;
                else
                    SDAO_int <= '1';
                end if;
            end if;
        end if;
    end process;


   --------------------------------------------------------------------
   -- sercon bits
   --------------------------------------------------------------------
   CR210_HAND:
   --------------------------------------------------------------------
      cr210 <= std_logic_vector(to_unsigned(BAUD_RATE_VALUE,3)) WHEN BAUD_RATE_FIXED = 1 ELSE (sercon(7) & sercon(1 DOWNTO 0)) ;

   --------------------------------------------------------------------
   ENS1_HAND:
   --------------------------------------------------------------------
      ens1 <= sercon(6) and ens1_pre; --enable or 1 clock disable

   --------------------------------------------------------------------
   STA_HAND0:
   --------------------------------------------------------------------
	if (SLAVE_ONLY_EN = '0') GENERATE
      sta <= sercon(5) AND (NOT(sto));
    END GENERATE;
   --------------------------------------------------------------------
   STA_HAND1:
   --------------------------------------------------------------------
	if (SLAVE_ONLY_EN = '1') GENERATE
	sta <= '0';
    END GENERATE;


   --------------------------------------------------------------------
   STO_HAND0:
   --------------------------------------------------------------------
	if (SLAVE_ONLY_EN = '0') GENERATE
      sto <= sercon(4);
    END GENERATE;
   --------------------------------------------------------------------
   STO_HAND1:
   --------------------------------------------------------------------
	if (SLAVE_ONLY_EN = '1') GENERATE
      sto <= '0';
    END GENERATE;


   --------------------------------------------------------------------
   SI_HAND:
   --------------------------------------------------------------------
      si_int <= sercon(3);


   --------------------------------------------------------------------
   AA_HAND:
   --------------------------------------------------------------------
      aa <= sercon(2);

   --------------------------------------------------------------------
   -- sercon APB register
   --------------------------------------------------------------------
   serCON_WRITE_PROC:
   --------------------------------------------------------------------
    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            sercon  <= serCON_RV;
        elsif (PCLK'event and PCLK = '1') then
            if (sresetn = '0') then
                sercon  <= serCON_RV;
            else
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                -- APB register write
                ----------------------------------
                if ((PENABLE='1' and PWRITE='1' and PSEL='1') and PADDR=serCON_ID) then
                    sercon <= PWDATA;
                else
                    -------------------------------
                    -- setting si flag
                    -------------------------------
                    if (ens1='1') and
                        (
                            (
                            (fsmmod=FSMMOD1 or fsmmod=FSMMOD6) and
                            (fsmdet=FSMDET3)
                            ) or                        -- transmitted START or Sr condition
                            (
                            (framesync="1000" and pedetect='1') and
                            (mst='1' or adrcomp='1') -- master operation, slave operation or own addr received
                            ) or
                            (
                            (framesync="0000" or framesync="1001") and
                            (fsmdet=FSMDET3 or fsmdet=FSMDET5) and -- received START or STOP
                            (adrcomp='1')                          -- addressed slave switched to FSMSTAA0
                            ) or
                            (
                            (framesync="0001" or framesync="0010" or
                                framesync="0011" or framesync="0100" or
                                framesync="0101" or framesync="0110" or
                                framesync="0111" or framesync="1000") and
                            (fsmdet=FSMDET3 or fsmdet=FSMDET5) and -- received START or STOP
                            (mst='1' or adrcomp='1')               -- bus ERROR
                            ) or
                            (
                            (smbus_mst_reset_posedge = '1') and (SMB_EN_int = '1')
                            -- begin 35ms clk low bus reset
                            ) or
                            (
                            (term_cnt_35ms_flag = '1') and (SMB_EN_int = '1')
                            -- mst reset, 35ms clk low
                            ) or
                            (
                            (term_cnt_25ms_flag = '1') and (SMB_EN_int = '1') and (fsmsta /= FSMSTAD0)
                            -- slave resetting status, 25ms clk low
                            ) or
                            (
                            (term_cnt_3ms_flag = '1') and (IPMI_EN_int = '1') 
                            -- slave resetting status, 25ms clk low
                            ) or
                            (
                            (set_int = '1') and (SMB_EN_int = '1')
                            -- slave has reset
                            ) or
                            (   
                            (fsmmod=FSMMOD4 and PCLKint_p1='1' and SCLInt='1') -- transmitted STOP SAR 29537  
                            ) 
                        )
                    then
                        sercon(3) <= '1';
                    end if;
                    -------------------------------
                    -- clearing sto flag
                    -------------------------------
                    if (fsmmod=FSMMOD4 and PCLKint_p2='1') or -- transmitted STOP
                        (fsmdet=FSMDET5) or                   -- received STOP
                        (mst='0' and sto='1') or              -- internal stop
                        (ens1='0')                            -- ENS1='0'
                    then
                        sercon(4) <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process;

   --------------------------------------------------------------------
   -- serdat APB register
   --------------------------------------------------------------------
   serDAT_WRITE_PROC:
   --------------------------------------------------------------------

    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
                serdat   <= serDAT_RV;
                ack      <= '1';
                ack_bit  <= '1';
                bsd7     <= '1';
                bsd7_tmp <= '1';
        elsif PCLK'event and PCLK='1' then
            if (sresetn = '0') then
                serdat   <= serDAT_RV;
                ack      <= '1';
                ack_bit  <= '1';
                bsd7     <= '1';
                bsd7_tmp <= '1';
            else
    
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                if ens1='0' then
                    if ((PENABLE='1' and PWRITE='1' and PSEL='1') and PADDR=serDAT_ID) then -- load data byte
                        serdat <= PWDATA;
                    end if;
                else  -- enable core
                    if fsmdet=FSMDET3 then -- START
                        if ((PENABLE='1' and PWRITE='1' and PSEL='1') and PADDR=serDAT_ID) then -- load data byte
                            serdat <= PWDATA;
                        end if;
                        bsd7 <= '0';
                        bsd7_tmp <= '0';
                    elsif (
                            -------------------------------------
                            -- master transmitter
                            -------------------------------------
                            fsmsta=FSMSTA08 or fsmsta=FSMSTA10 or
                            fsmsta=FSMSTA18 or fsmsta=FSMSTA20 or
                            fsmsta=FSMSTA28 or fsmsta=FSMSTA30 or
                            -------------------------------------
                            -- slave transmitter
                            -------------------------------------
                            ((fsmsta=FSMSTAA8 or fsmsta=FSMSTAB0 or
                            fsmsta=FSMSTAB8) and (MST_TX_SLV_RX = '0'))
                            )
                    then
                        if si_int='1' then     -- interrupt process
                            ack <= '1'; -- high Z on serial bus after transmitted byte
                            ----------------------------------
                            -- APB register write
                            ----------------------------------
                            if ((PENABLE='1' and PWRITE='1' and PSEL='1') and PADDR=serDAT_ID) then -- load data byte
                                serdat <= PWDATA;
                                bsd7_tmp <= PWDATA(7);
                            else
                                if SCLInt='0' then
                                    bsd7 <= bsd7_tmp;
                                else
                                    bsd7 <= '1';
                                end if;
                            end if;
                        else                   -- transmit data byte
                            if ((PENABLE='1' and PWRITE='1' and PSEL='1') and PADDR=serDAT_ID) then -- load data byte
                                serdat <= PWDATA;
                                bsd7 <= PWDATA(7);
                            else
                                if pedetect='1' then
                                    serdat <= serdat(6 downto 0) & ack;
                                    ack <= SDAInt;
                                end if;
                                if nedetect='1' then
                                    bsd7 <= serdat(7);
                                    bsd7_tmp <= '1';
                                end if;
                            end if;
                        end if;
                    elsif (
                            -------------------------------------
                            -- master receiver
                            -------------------------------------
                            ((fsmsta=FSMSTA40 or fsmsta=FSMSTA50) and
                            (MST_TX_SLV_RX = '0')) or
                            -------------------------------------
                            -- slave receiver
                            -------------------------------------
                            fsmsta=FSMSTA60 or fsmsta=FSMSTA68 or
                            fsmsta=FSMSTA80 or fsmsta=FSMSTA70 or
                            fsmsta=FSMSTA78 or fsmsta=FSMSTA90
                            )
                    then
                        if si_int='1' then     -- intrrupt process
                            if ((PENABLE='1' and PWRITE='1' and PSEL='1') and PADDR=serCON_ID) then
                            ack_bit <= PWDATA(2); --aa
                            end if;
                            if ((PENABLE='1' and PWRITE='1' and PSEL='1') and PADDR=serDAT_ID) then -- load data byte
                            serdat <= PWDATA;
                            end if;
                        else                   -- receiving data byte
                            if ((PENABLE='1' and PWRITE='1' and PSEL='1') and PADDR=serDAT_ID) then -- load data byte
                            serdat <= PWDATA;
                            elsif pedetect='1' then
                            serdat <= serdat(6 downto 0) & ack;
                            ack <= SDAInt;
                            end if;
                        end if;
                        bsd7 <= '1';
                    else                      -- not addressed slave
                        if ((PENABLE='1' and PWRITE='1' and PSEL='1') and PADDR=serDAT_ID) then    -- load data byte
                            serdat <= PWDATA;
                        elsif pedetect='1' then
                            serdat <= serdat(6 downto 0) & ack;
                            ack <= SDAInt;
                        end if;
                        bsd7 <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;


   --------------------------------------------------------------------
   -- sersta APB register
   --------------------------------------------------------------------
   serSTA_WRITE_PROC:
   --------------------------------------------------------------------
    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            sersta(4 downto 0) <= serSTA_RV(4 downto 0);
        elsif (PCLK'event and PCLK = '1') then
            if (sresetn = '0') then
                sersta(4 downto 0) <= serSTA_RV(4 downto 0);
            else
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                -- APB register read-only
                ----------------------------------
                if si_int='1' then
                    case fsmsta is
                        when FSMSTA08 =>
                            sersta <= "00001"; --08H -- start has been trx/rcv
                        when FSMSTA10 =>
                            sersta <= "00010"; --10H  -- repeated start has been trx/rcv
                        when FSMSTA18 =>
                            sersta <= "00011";
                        when FSMSTA20 =>
                            sersta <= "00100";
                        when FSMSTA28 =>
                            sersta <= "00101";
                        when FSMSTA30 =>
                            sersta <= "00110";
                        when FSMSTA38 =>
                            sersta <= "00111";
                        when FSMSTA40 =>
                            sersta <= "01000";
                        when FSMSTA48 =>
                            sersta <= "01001";
                        when FSMSTA50 =>
                            sersta <= "01010";
                        when FSMSTA58 =>
                            sersta <= "01011";
                        when FSMSTA60 =>
                            sersta <= "01100";
                        when FSMSTA68 =>
                            sersta <= "01101";
                        when FSMSTA70 =>
                            sersta <= "01110";
                        when FSMSTA78 =>
                            sersta <= "01111";
                        when FSMSTA80 =>
                            sersta <= "10000";
                        when FSMSTA88 =>
                            sersta <= "10001";
                        when FSMSTA90 =>
                            sersta <= "10010";
                        when FSMSTA98 =>
                            sersta <= "10011";
                        when FSMSTAA0 =>
                            sersta <= "10100";
                        when FSMSTAA8 =>
                            sersta <= "10101";
                        when FSMSTAB0 =>
                            sersta <= "10110";
                        when FSMSTAB8 =>
                            sersta <= "10111";
                        when FSMSTAC0 =>
                            sersta <= "11000";
                        when FSMSTAC8 =>
                            sersta <= "11001";
                        when FSMSTA00 =>
                            sersta <= "00000";
                        when FSMSTAD0 =>
                            sersta <= "11010";
                        when FSMSTAD8 =>
                            sersta <= "11011";
                        when FSMSTAE0 =>
                            sersta <= "11100";
                        when others => -- when FSMSTAF8
                            sersta <= "11111";
                    end case;
                else
                    sersta <= "11111";
                end if;
            end if;
        end if;
    end process;

   --------------------------------------------------------------------
   SMB_GEN1a:
   --------------------------------------------------------------------
   IF (SMB_EN = 1) GENERATE
      PROCESS (PCLK, aresetn)
      BEGIN
         IF (aresetn = '0') THEN
            sersmb7 <= serSMB_RV(7);
            sersmb6 <= serSMB_RV(6);
            sersmb4 <= serSMB_RV(4);
            sersmb2 <= serSMB_RV(2);
            sersmb1 <= serSMB_RV(1);
            sersmb0 <= serSMB_RV(0);
         ELSIF (PCLK'EVENT AND PCLK = '1') THEN
            IF (((PENABLE AND PWRITE AND PSEL)) = '1' AND (PADDR = serSMB_ID)) THEN
               sersmb7 <= PWDATA(7);
               sersmb6 <= PWDATA(6);
               sersmb4 <= PWDATA(4);
               sersmb2 <= PWDATA(2);
               sersmb1 <= PWDATA(1);
               sersmb0 <= PWDATA(0);
            ELSIF ((sersmb7 = '1') AND (term_cnt_35ms_flag = '1')) THEN
               sersmb7 <= '0';
            END IF;
         END IF;
      END PROCESS;
      PROCESS (PCLK, aresetn)
      BEGIN
         IF (aresetn = '0') THEN
            SMBSUS_NI_d <= '1';
            SMBALERT_NI_d <= '1';
            SMBSUS_NI_d2 <= '1';
            SMBALERT_NI_d2 <= '1';
         ELSIF (PCLK'EVENT AND PCLK = '1') THEN
            SMBSUS_NI_d <= SMBSUS_NI;
            SMBALERT_NI_d <= SMBALERT_NI;
            SMBSUS_NI_d2 <= SMBSUS_NI_d;
            SMBALERT_NI_d2 <= SMBALERT_NI_d;
         END IF;
      END PROCESS;
      IPMI_EN_int <= '0';
      smbus_mst_reset <= sersmb7;
      SMBSUS_NO <= sersmb6;
      sersmb5 <= SMBSUS_NI_d2;
      SMBALERT_NO <= sersmb4;
      sersmb3 <= SMBALERT_NI_d2;
      SMB_EN_int <= sersmb2;
      SMBS_INT <= NOT(SMBSUS_NI_d2) WHEN sersmb1 = '1' ELSE
                  '0';
      SMBA_INT <= NOT(SMBALERT_NI_d2) WHEN sersmb0 = '1' ELSE
                  '0';
   END GENERATE;
   SMB_GEN1b:
   IF (IPMI_EN = 1) GENERATE
         PROCESS (PCLK, aresetn)
         BEGIN
            IF (aresetn = '0') THEN
               sersmb2 <= serSMB_RV(2);
            ELSIF (PCLK'EVENT AND PCLK = '1') THEN
               IF (((PENABLE AND PWRITE AND PSEL)) = '1' AND (PADDR = serSMB_ID)) THEN
                  sersmb2 <= PWDATA(2);
               END IF;
            END IF;
         END PROCESS;
         
         IPMI_EN_int <= sersmb2;
         smbus_mst_reset <= '0';
         SMBSUS_NO <= '1';
         sersmb5 <= '1';
         SMBALERT_NO <= '1';
         sersmb3 <= '1';
         SMB_EN_int <= '0';
         SMBS_INT <= '0';
         SMBA_INT <= '0';
   END GENERATE;
   SMB_GEN1c:
   IF ((SMB_EN = 0) AND (IPMI_EN = 0)) GENERATE
         IPMI_EN_int <= '0';
         smbus_mst_reset <= '0';
         SMBSUS_NO <= '1';
         sersmb5 <= '1';
         SMBALERT_NO <= '1';
         sersmb3 <= '1';
         SMB_EN_int <= '0';
         SMBS_INT <= '0';
         SMBA_INT <= '0';
   END GENERATE;

    smbus_mst_reset_posedge_proc:process(PCLK, aresetn)
    begin
        if (aresetn = '0') then
            smbus_mst_reset_ff0 <= '0';
            smbus_mst_reset_ff1 <= '0';
            smbus_mst_reset_ff2 <= '0';
        elsif PCLK'event and PCLK='1' then
            if (sresetn = '0') then
                smbus_mst_reset_ff0 <= '0';
                smbus_mst_reset_ff1 <= '0';
                smbus_mst_reset_ff2 <= '0';
            else
                smbus_mst_reset_ff0 <= smbus_mst_reset;
                smbus_mst_reset_ff1 <= smbus_mst_reset_ff0;
                smbus_mst_reset_ff2 <= smbus_mst_reset_ff1;
            end if;
        end if;
    end process;

   smbus_mst_reset_posedge <= '1' when ((smbus_mst_reset_ff1 = '1') and
                                    (smbus_mst_reset_ff2 = '0')) else '0';

   --------------------------------------------------------------------
   -- SCL input filter
   --------------------------------------------------------------------
   SCLINT_WRITE_PROC:
   --------------------------------------------------------------------

    PROCESS (PCLK, aresetn)
    BEGIN
        IF (aresetn = '0') THEN
            SCLI_ff_reg <= (others => '1');
        ELSIF (PCLK'EVENT AND PCLK = '1') THEN
            IF (sresetn = '0') THEN
                SCLI_ff_reg <= (others => '1');
            ELSE
                IF (ens1 = '1') THEN
                    SCLI_ff_reg <= (SCLI_ff_reg(GLITCHREG_NUM - 2 DOWNTO 0) & SCLI);
                ELSE
                    SCLI_ff_reg <= (others => '1');
                END IF;
            END IF;
        END IF;
    END PROCESS;

    PROCESS (PCLK, aresetn)
    BEGIN
        IF (aresetn = '0') THEN
            SCLInt <= '1';
            nedetect <= '0';
            pedetect <= '0';
        ELSIF (PCLK'EVENT AND PCLK = '1') THEN
            IF (sresetn = '0') THEN
                SCLInt <= '1';
                nedetect <= '0';
                pedetect <= '0';
            ELSE
                IF (ens1 = '0') THEN
                    SCLInt <= '1';
                ELSIF (or_br(SCLI_ff_reg) = '0') THEN
                    SCLInt <= '0';
                    IF (SCLInt = '1') THEN
                        nedetect <= '1';
                    ELSE
                        nedetect <= '0';
                    END IF;
                ELSIF (and_br(SCLI_ff_reg) = '1') THEN
                    SCLInt <= '1';
                    IF ((NOT(SCLInt)) = '1') THEN
                        pedetect <= '1';
                    ELSE
                        pedetect <= '0';
                    END IF;
                ELSE
                    pedetect <= '0';
                    nedetect <= '0';
                END IF;
            END IF;
        END IF;
    END PROCESS;


   --------------------------------------------------------------------
   -- SDA input filter
   --------------------------------------------------------------------
   SDAINT_WRITE_PROC:
   --------------------------------------------------------------------

    PROCESS (PCLK, aresetn)
    BEGIN
        IF (aresetn = '0') THEN
            SDAI_ff_reg <= (others => '1');
        ELSIF (PCLK'EVENT AND PCLK = '1') THEN
            IF (sresetn = '0') THEN
                SDAI_ff_reg <= (others => '1');
            ELSE
                IF (ens1 = '1') THEN
                    SDAI_ff_reg <= (SDAI_ff_reg(GLITCHREG_NUM - 2 DOWNTO 0) & SDAI);
                ELSE
                    SDAI_ff_reg <= (others => '0');
                END IF;
            END IF;
        END IF;
    END PROCESS;
    
    PROCESS (PCLK, aresetn)
    BEGIN
        IF (aresetn = '0') THEN
            SDAInt <= '1';
        ELSIF (PCLK'EVENT AND PCLK = '1') THEN
            IF (sresetn = '0') THEN
                SDAInt <= '1';
            ELSE
                IF (or_br(SDAI_ff_reg) = '0') THEN
                    SDAInt <= '0';
                ELSIF (and_br(SDAI_ff_reg) = '1') THEN
                    SDAInt <= '1';
                END IF;
            END IF;
        END IF;
    END PROCESS;


   --------------------------------------------------------------------
   -- address comparator
   --------------------------------------------------------------------
   ADRCOMP_WRITE_PROC:
   --------------------------------------------------------------------
    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            adrcomp   <= '0'; -- address comparator output
            adrcompen <= '0'; -- address comparator enable
        elsif (PCLK'event and PCLK = '1') then
            IF (sresetn = '0') THEN
                adrcomp   <= '0'; -- address comparator output
                adrcompen <= '0'; -- address comparator enable
            ELSE
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                if (mst='0' and sto='1') then -- intstop /internal stop condition/
                    adrcomp   <= '0';
                    adrcompen <= '0';
                elsif (ens1_pre='0') then -- intstop /internal stop condition/
                    adrcomp   <= '0';
                    adrcompen <= '0';
                else
                    ------------------------------------
                    -- adrcompen write
                    ------------------------------------
                    if fsmdet=FSMDET3 then                   -- START condition detected
                        adrcompen <= '1';
                    elsif framesync="1000" and nedetect='1' then
                        adrcompen <= '0';
                    end if;
                    ------------------------------------
                    -- adrcomp write
                    ------------------------------------
                    if (fsmdet=FSMDET3 or fsmdet=FSMDET5
                        ) or -- START or STOP
                        (
                            (fsmsta=FSMSTA88 or fsmsta=FSMSTA98 or
                            fsmsta=FSMSTAC8 or fsmsta=FSMSTAC0 or
                            fsmsta=FSMSTA38 or fsmsta=FSMSTAA0 or
                            fsmsta=FSMSTA00
                            ) and
                            (si_int='1')                        -- switched to n.a.slave
                        )
                    then
                        adrcomp <= '0';
                    elsif ((adrcompen = '1' AND 
                            framesync = "0111" AND 
                            nedetect = '1' AND aa = '1') AND 
                            (NOT((serdat(6 DOWNTO 0) = "0000000" AND ack = '1'))
                            ) AND 
                            (
                            ((serdat(6 DOWNTO 0) = seradr0(7 DOWNTO 1)) OR 
                            (serdat(6 DOWNTO 0) = "0000000" AND 
                            ((seradr0(0))) = '1')) 
                            OR 
                            (
                            (((ADD_SLAVE1_ADDRESS_EN = 1) AND (seradr1apb0 = '1')) AND 
                            (serdat(6 DOWNTO 0) = seradr1(7 DOWNTO 1)) AND (FIXED_SLAVE1_ADDR_EN = 1)) OR 
                            ((ADD_SLAVE1_ADDRESS_EN = 1) AND 
                            (serdat(6 DOWNTO 0) = seradr1(7 DOWNTO 1)) AND (FIXED_SLAVE1_ADDR_EN = 0)) OR 
                            ((((ADD_SLAVE1_ADDRESS_EN = 1) AND (seradr1apb0 = '1')) AND (serdat(6 DOWNTO 0) = "0000000") AND 
                            (FIXED_SLAVE1_ADDR_EN = 0))))) 
                            AND 
                            ((NOT(mst)) = '1' OR fsmsta = FSMSTA38)) THEN
                        adrcomp <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;


   --------------------------------------------------------------------
   -- input filter delay
   -- count 4*fosc after each positive edge SCL
   --------------------------------------------------------------------
   INDELAY_WRITE_PROC:
   --------------------------------------------------------------------
    PROCESS (PCLK, aresetn)
    BEGIN
        IF (aresetn = '0') THEN
            indelay <= ("000" & '0');
        ELSIF (PCLK'EVENT AND PCLK = '1') THEN
            IF (sresetn = '0') THEN
                indelay <= ("000" & '0');
            ELSE
                IF (fsmsync = FSMSYNC3) THEN
                    IF (NOT((indelay = std_logic_vector(to_unsigned(INFILTERDELAY,4))))) THEN
                        indelay <= indelay + "0001";
                    END IF;
                ELSE
                    indelay <= ("000" & '0');
                END IF;
            END IF;
        END IF;
    END PROCESS;


    --------------------------------------------------------------------
    -- frame synchronization counter
    --------------------------------------------------------------------
    FRAMESYNC_WRITE_PROC:
    --------------------------------------------------------------------

    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            framesync  <= "1111";
        elsif (PCLK'event and PCLK = '1') then
            if (sresetn = '0') then
                framesync  <= "1111";
            else
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                if fsmdet=FSMDET3 then                -- START condition
                    framesync <= "1111";
                elsif (
                            (fsmdet=FSMDET5) or          -- STOP condition
                            (si_int='1' and SCLInt='0')
                        )
                then  -- interrupt process
                    framesync <= "1001";
                elsif framesync="1001" then
                    if (fsmsta=FSMSTAA0 or fsmsta=FSMSTA88 or
                        fsmsta=FSMSTAC8 or fsmsta=FSMSTA98 or
                        fsmsta=FSMSTAC0)
                    then
                        framesync <= "0000";
                    else
                        if (si_int='0') and
                            (sto='0') and
                            (sta='0' or fsmsta=FSMSTA08 or fsmsta=FSMSTA10)
                        then
                            framesync <= "0000";
                        else                             -- START / repeated START / STOP
                            framesync <= "1001";
                        end if;
                    end if;
                elsif nedetect='1' then
                    if framesync="1000" then
                        if (si_int='0') and
                            (sto='0') and
                            (sta='0' or fsmsta=FSMSTA08 or fsmsta=FSMSTA10)
                        then
                            framesync <= "0000";
                        else                             -- START / repeated START / STOP
                            framesync <= "1001";
                        end if;
                    else
                        framesync <= framesync+'1';
                    end if;
                end if;
            end if;
        end if;
    end process;


    --------------------------------------------------------------------
    -- reset counters SIGNAL
    --------------------------------------------------------------------
    COUNTER_RST_WRITE:
    --------------------------------------------------------------------
      counter_rst <=
         '1' when (
                     (fsmsync=FSMSYNC1  or
                      fsmsync=FSMSYNC4  or
                      fsmsync=FSMSYNC5) or    -- SCL synchronization
                     (mst='0' and sto='1') or -- internal stop
                     (fsmdet=FSMDET5) or

                     (fsmdet=FSMDET3) or      -- STOP, START condition
                     (fsmmod=FSMMOD4 and
                      SCLInt='0' and
                      SCLO_int='1') or        -- transmit START condition
                     (busfree='1' and
                      SCLInt='0' and          -- impossible (?)
                      not(fsmmod=FSMMOD5)
                     )
                  )
         else
         '0';

    --------------------------------------------------------------------
    -- clock counter
    --------------------------------------------------------------------
    CLK_COUNTER1_PROC:
    --------------------------------------------------------------------

    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            PCLK_count1 <= "0000";
            PCLK_count1_ov <= '0';
        elsif PCLK'event and PCLK='1' then
            if (sresetn = '0') then
                PCLK_count1 <= "0000";
                PCLK_count1_ov <= '0';
            else
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                if counter_rst='1' then    -- SCL synchronization
                    PCLK_count1 <= "0000";   -- counter reset
                    PCLK_count1_ov <= '0';
                else                       -- normal operation
                    case cr210 is
                        when "000" =>                          -- 1/256
                            if PCLK_count1 < "1111" then         -- 1/16
                            PCLK_count1 <= PCLK_count1 + '1';
                            PCLK_count1_ov <= '0';
                            else
                            PCLK_count1 <= "0000";
                            PCLK_count1_ov <= '1';
                            end if;
                        when "001" =>                          -- 1/224
                            if PCLK_count1 < "1101" then         -- 1/14
                            PCLK_count1 <= PCLK_count1 + '1';
                            PCLK_count1_ov <= '0';
                            else
                            PCLK_count1 <= "0000";
                            PCLK_count1_ov <= '1';
                            end if;
                        when "010" =>                          -- 1/192
                            if PCLK_count1 < "1011" then         -- 1/12
                            PCLK_count1 <= PCLK_count1 + '1';
                            PCLK_count1_ov <= '0';
                            else
                            PCLK_count1 <= "0000";
                            PCLK_count1_ov <= '1';
                            end if;
                        when "011" =>                          -- 1/160
                            if PCLK_count1 < "1001" then         -- 1/10
                            PCLK_count1 <= PCLK_count1 + '1';
                            PCLK_count1_ov <= '0';
                            else
                            PCLK_count1 <= "0000";
                            PCLK_count1_ov <= '1';
                            end if;
                        when "100" =>                          -- 1/960
                            if PCLK_count1 < "1110" then         -- 1/15
                            PCLK_count1 <= PCLK_count1 + '1';
                            PCLK_count1_ov <= '0';
                            else
                            PCLK_count1 <= "0000";
                            PCLK_count1_ov <= '1';
                            end if;
                        when "101" =>                          -- 1/120
                            if PCLK_count1 < "1110" then         -- 1/15
                            PCLK_count1 <= PCLK_count1 + '1';
                            PCLK_count1_ov <= '0';
                            else
                            PCLK_count1 <= "0000";
                            PCLK_count1_ov <= '1';
                            end if;
                        when "110" =>                          -- 1/60
                            if PCLK_count1 < "1110" then         -- 1/15
                            PCLK_count1 <= PCLK_count1 + '1';
                            PCLK_count1_ov <= '0';
                            else
                            PCLK_count1 <= "0000";
                            PCLK_count1_ov <= '1';
                            end if;
                        when others =>       -- 1/8 -- baud rate clock
                            if bclke = '1' then                  -- 1/2
                            if PCLK_count1 < "0001" then
                                PCLK_count1 <= PCLK_count1 + '1';
                                PCLK_count1_ov <= '0';
                            else
                                PCLK_count1 <= "0000";
                                PCLK_count1_ov <= '1';
                            end if;
                            else
                            PCLK_count1_ov <= '0';
                            end if;
                    end case;
                end if;
            end if;
        end if;
    end process;


    --------------------------------------------------------------------
    -- clock counter
    --------------------------------------------------------------------
    CLK_COUNT2_WRITE_PROC:
    --------------------------------------------------------------------

    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            PCLK_count2 <= "0000";
            PCLK_count2_ov <= '0';
        elsif PCLK'event and PCLK='1' then
            if (sresetn = '0') then
                PCLK_count2 <= "0000";
                PCLK_count2_ov <= '0';
            else
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                if counter_rst='1' then    -- SCL synchronization
                    PCLK_count2 <= "0000";   -- counter reset
                    PCLK_count2_ov <= '0';
                else                       -- normal operation
                    if PCLK_count1_ov = '1' then
                        PCLK_count2 <= PCLK_count2 + '1';
                        case cr210 is
                            when "101" =>       -- 1/2
                            if PCLK_count2(0)='1' then
                                PCLK_count2_ov <= '1';
                            else
                                PCLK_count2_ov <= '0';
                            end if;
                            when "000" | "001" |
                            "010" | "011" =>       -- 1/4
                            if PCLK_count2(1 downto 0) = "11" then
                                PCLK_count2_ov <= '1';
                            else
                                PCLK_count2_ov <= '0';
                            end if;
                            when "100" =>               -- 1/16
                            if PCLK_count2 = "1111" then
                                PCLK_count2_ov <= '1';
                            else
                                PCLK_count2_ov <= '0';
                            end if;
                            when others =>   -- PCLK_count2_ov <= PCLK_count1_ov
                            PCLK_count2_ov <= '1';
                        end case;
                    else
                        PCLK_count2_ov <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process;


    --------------------------------------------------------------------
    -- internal clock generator
    --------------------------------------------------------------------
    CLKINT_WRITE_PROC:
    --------------------------------------------------------------------

    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            PCLKint    <= '1';
            PCLKint_ff <= '1';
        elsif (PCLK'event and PCLK = '1') then
            if (sresetn = '0') then
                PCLKint    <= '1';
                PCLKint_ff <= '1';
            else
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                if counter_rst='1' then    -- SCL synchronization
                    PCLKint    <= '1';
                    PCLKint_ff <= '1';
                else                       -- normal operation
                    if PCLK_count2_ov='1' then
                        PCLKint <= not PCLKint;
                    end if;
                    PCLKint_ff <= PCLKint;
                end if;
            end if;
        end if;
    end process;


   --------------------------------------------------------------------
   -- internal clock generator PCLKint_p1
   --------------------------------------------------------------------
   clkint_p1_write:
   --------------------------------------------------------------------
      PCLKint_p1 <= (not PCLKint_ff) and PCLKint; -- positive edge


   --------------------------------------------------------------------
   -- internal clock generator PCLKint_p2
   --------------------------------------------------------------------
   CLKINT_P2_WRITE:
   --------------------------------------------------------------------
      PCLKint_p2 <= PCLKint_ff and (not PCLKint); -- negative edge


   --------------------------------------------------------------------
   -- SCL synchronization
   --------------------------------------------------------------------
   FSMSYNC_COMB_PROC:
   --------------------------------------------------------------------
      process (fsmsync, SCLInt, PCLKint_p1, indelay, si_int,
               SDAInt, sto, framesync, fsmmod)
      begin
         -------------------------------
         -- Initial value
         -------------------------------
         fsmsync_nxt <= FSMSYNC7;

         -------------------------------
         -- Combinational value
         -------------------------------
         case fsmsync is
            -------------------------------
            when FSMSYNC0 =>
            -------------------------------

               if SCLInt='0' then
                  fsmsync_nxt <= FSMSYNC1;
               else
                  if PCLKint_p1='1' and
                  not (fsmmod=FSMMOD3 or fsmmod=FSMMOD4) then
                     fsmsync_nxt <= FSMSYNC2;
                  else
                     fsmsync_nxt <= FSMSYNC0;
                  end if;
               end if;

            -------------------------------
            when FSMSYNC1 =>
            -------------------------------
               fsmsync_nxt <= FSMSYNC2;

            -------------------------------
            when FSMSYNC2 =>
            -------------------------------
               if PCLKint_p1='1' then
                  if si_int='1' then
                     fsmsync_nxt <= FSMSYNC5;
                  else
                     if sto='1' and framesync="1001" then
                        fsmsync_nxt <= FSMSYNC6;
                     else
                        fsmsync_nxt <= FSMSYNC3;
                     end if;
                  end if;
               else
                  fsmsync_nxt <= FSMSYNC2;
               end if;

            -------------------------------
            when FSMSYNC3 =>
            -------------------------------
               if (indelay=std_logic_vector(to_unsigned(INFILTERDELAY,4))) then
                  if SCLInt='1' then
                     fsmsync_nxt <= FSMSYNC0;
                  else
                     fsmsync_nxt <= FSMSYNC4;
                  end if;
               else
                  fsmsync_nxt <= FSMSYNC3;
               end if;

            -------------------------------
            when FSMSYNC4 =>
            -------------------------------
               if SCLInt='1' then
                  fsmsync_nxt <= FSMSYNC0;
               else
                  fsmsync_nxt <= FSMSYNC4;
               end if;

            -------------------------------
            when FSMSYNC5 =>
            -------------------------------
               if si_int='0' then
                  if sto='1' then
                     fsmsync_nxt <= FSMSYNC6;
                  else
                     fsmsync_nxt <= FSMSYNC3;
                  end if;
               else
                  fsmsync_nxt <= FSMSYNC5;
               end if;

            -------------------------------
            when FSMSYNC6 =>
            -------------------------------
               if SDAInt='0' then
                  fsmsync_nxt <= FSMSYNC7;
               else
                  fsmsync_nxt <= FSMSYNC6;
               end if;

            -------------------------------
            when others => -- when FSMSYNC7
            -------------------------------
               fsmsync_nxt <= FSMSYNC7;

         end case;

      end process;


   --------------------------------------------------------------------
   -- Registered SCLO output
   --------------------------------------------------------------------
   FSMSYNC_SYNC_PROC:
   --------------------------------------------------------------------

    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            fsmsync <= FSMSYNC0;
            SCLO_int <= '1';
        elsif (PCLK'event and PCLK = '1') then
            if (sresetn = '0') then
                fsmsync <= FSMSYNC0;
                SCLO_int <= '1';
            else
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                if fsmmod=FSMMOD0 then      -- slave mode
                    fsmsync <= FSMSYNC0;
                else
                    fsmsync <= fsmsync_nxt;
                end if;
    
                if (ens1='1') and -- core enable
                    (  ---------------------------------------
                        -- master clock generator
                        ---------------------------------------
                        (fsmsync=FSMSYNC1 or fsmsync=FSMSYNC2 or
                        fsmsync=FSMSYNC5 or fsmsync=FSMSYNC6
                        ) or
                        ---------------------------------------
                        -- slave stretch when interrupt process
                        ---------------------------------------
                        (
                            (-- slave transmitter
                            ((fsmsta=FSMSTAA8 or fsmsta=FSMSTAB0 or
                            fsmsta=FSMSTAC0 or fsmsta=FSMSTAC8 or
                            fsmsta=FSMSTAB8 ) and (MST_TX_SLV_RX = '0'))or
                            -- slave receiver
                            fsmsta=FSMSTA60 or fsmsta=FSMSTA68 or
                            fsmsta=FSMSTA80 or fsmsta=FSMSTA88 or
                            fsmsta=FSMSTA70 or fsmsta=FSMSTA78 or
                            fsmsta=FSMSTA90 or fsmsta=FSMSTA98 or
                            fsmsta=FSMSTAA0
                            ) and
                            (SCLInt='0') and
                            (si_int='1')
                        )
                    )
                then
                    SCLO_int <= '0';
                else
                    SCLO_int <= '1';
                end if;
            end if;
        end if;
    end process;


   --------------------------------------------------------------------
   -- serial status FSM
   --------------------------------------------------------------------
   FSMSTA_COMB_PROC:
   --------------------------------------------------------------------
      process (fsmsta, pedetect, ack, SDAInt, SDAO_int, framesync, aa,
               adrcomp, adrcompen, serdat, seradr0, seradr1)
      begin
         -------------------------------
         -- Initial value
         -------------------------------
         fsmsta_nxt <= FSMSTAF8;

         -------------------------------
         -- Combinational value
         -------------------------------
         case fsmsta is
   --==========================================--
   -- MASTER Mode both RX | TX
   --==========================================--
   			-------------------------------
   			when FSMSTAD0 =>
   			-------------------------------
      			fsmsta_nxt <= FSMSTAD0 ;
         --==========================================--
         -- MASTER TRANSMITTER
         --==========================================--
            -------------------------------
            when FSMSTA08 =>
            -------------------------------
               if framesync="1000" then          -- ACK receiving
                  if ack='0' then                -- R/nW='0' --master transmitter
                     if SDAInt='1' then          -- not ACK
                        fsmsta_nxt <= FSMSTA20;
                     else                        -- ACK
                        fsmsta_nxt <= FSMSTA18;
                     end if;
               ELSIF (MST_TX_SLV_RX = '0') THEN	 -- R/nW='1'  --master receiver
                     if SDAInt='1' then          -- not ACK
                        fsmsta_nxt <= FSMSTA48;
                     else                        -- ACK
                        fsmsta_nxt <= FSMSTA40;
                     end if;
                  end if;
               else
                  if (SDAO_int='1' and
                      SDAInt='0' and
                      pedetect='1')
                  then                           -- arbitration lost
                     fsmsta_nxt <= FSMSTA38;
                  else
                     fsmsta_nxt <= FSMSTA08;
                  end if;
               end if;

            -------------------------------
            when FSMSTA10 =>
            -------------------------------
               if framesync="1000" then          -- ACK receiving
                  if ack='0' then                -- R/nW='0' --master transmitter
                     if SDAInt='1' then          -- not ACK
                        fsmsta_nxt <= FSMSTA20;
                     else                        -- ACK
                        fsmsta_nxt <= FSMSTA18;
                     end if;
               ELSIF (MST_TX_SLV_RX = '0') THEN	 -- R/nW='1' --master receiver
                     if SDAInt='1' then          -- not ACK
                        fsmsta_nxt <= FSMSTA48;
                     else                        -- ACK
                        fsmsta_nxt <= FSMSTA40;
                     end if;
                  end if;
               else
                  if (SDAO_int='1' and
                      SDAInt='0' and
                      pedetect='1')
                  then                           -- arbitration lost
                     fsmsta_nxt <= FSMSTA38;
                  else
                     fsmsta_nxt <= FSMSTA10;
                  end if;
               end if;

            -------------------------------
            when FSMSTA18 =>
            -------------------------------
               if framesync="1000" then          -- ACK receiving
                  if SDAInt='1' then             -- not ACK
                     fsmsta_nxt <= FSMSTA30;
                  else                           -- ACK
                     fsmsta_nxt <= FSMSTA28;
                  end if;
               else
                  if (SDAO_int='1' and
                      SDAInt='0' and
                      pedetect='1')
                  then                           -- arbitration lost
                     fsmsta_nxt <= FSMSTA38;
                  else
                     fsmsta_nxt <= FSMSTA18;
                  end if;
               end if;

            -------------------------------
            when FSMSTA20 =>
            -------------------------------
               if framesync="1000" then         -- ACK receiving
                  if SDAInt='1' then            -- not ACK
                     fsmsta_nxt <= FSMSTA30;
                  else                          -- ACK
                     fsmsta_nxt <= FSMSTA28;
                  end if;
               else
                  if SDAO_int='1' and SDAInt='0' and pedetect='1' then --arbitration lost
                     fsmsta_nxt <= FSMSTA38;
                  else
                     fsmsta_nxt <= FSMSTA20;
                  end if;
               end if;

            -------------------------------
            when FSMSTA28 =>
            -------------------------------
               if framesync="1000" then         -- ACK receiving
                  if SDAInt='1' then            -- not ACK
                     fsmsta_nxt <= FSMSTA30;
                  else                          -- ACK
                     fsmsta_nxt <= FSMSTA28;
                  end if;
               else
                  if (SDAO_int='1' and
                      SDAInt='0' and
                      pedetect='1')
                  then                          -- arbitration lost
                     fsmsta_nxt <= FSMSTA38;
                  else
                     fsmsta_nxt <= FSMSTA28;
                  end if;
               end if;

            -------------------------------
            when FSMSTA30 =>
            -------------------------------
               if framesync="1000" then          -- ACK receiving
                  if SDAInt='1' then             -- not ACK
                     fsmsta_nxt <= FSMSTA30;
                  else                           -- ACK
                     fsmsta_nxt <= FSMSTA28;
                  end if;
               else
                  if (SDAO_int='1' and
                      SDAInt='0' and
                      pedetect='1')
                  then                           -- arbitration lost
                     fsmsta_nxt <= FSMSTA38;
                  else
                     fsmsta_nxt <= FSMSTA30;
                  end if;
               end if;

            -------------------------------
            when FSMSTA38 =>
            ------------------------------
               if adrcomp='1' and adrcompen='1' and
               framesync="1000" then -- ACK receiving
                  if ((ack='1') and (MST_TX_SLV_RX = '0')) then -- SLA+R
                     fsmsta_nxt <= FSMSTAB0;
                  else            -- SLA+W
                     IF (serdat(6 DOWNTO 0) = "0000000" AND ((seradr0(0))) = '1') THEN
                        fsmsta_nxt <= FSMSTA78;
                     ELSIF ((serdat(6 DOWNTO 0) = "0000000") AND (seradr1(0) = '1') AND (ADD_SLAVE1_ADDRESS_EN = 1)) THEN
                        fsmsta_nxt <= FSMSTA78;
                     else
                        fsmsta_nxt <= FSMSTA68;
                     end if;
                  end if;
               else
                  fsmsta_nxt <= FSMSTA38;
               end if;

         --==========================================--
         -- MASTER RECEIVER
         --==========================================--

            -------------------------------
            when FSMSTA40 =>
            -------------------------------
               if ((framesync="1000") and (MST_TX_SLV_RX = '0'))then          -- ACK transmitting
                  if (SDAO_int='1' and
                      SDAInt='0' and
                      pedetect='1')
                  then                           -- arbitration lost in not ACK
                     fsmsta_nxt <= FSMSTA38;
                  else
                     if SDAO_int='0' then        -- ACK transmitting
                        fsmsta_nxt <= FSMSTA50;
                     else                        -- not ACK transmitting
                        fsmsta_nxt <= FSMSTA58;
                     end if;
                  end if;
               else                               -- receiving data
                  fsmsta_nxt <= FSMSTA40;
               end if;

            -------------------------------
            when FSMSTA48 =>
            -------------------------------
               fsmsta_nxt <= FSMSTA48;

            -------------------------------
            when FSMSTA50 =>
            -------------------------------
              if ((framesync="1000") and (MST_TX_SLV_RX = '0'))then -- ACK transmitting
                  if (SDAO_int='1' and
                      SDAInt='0' and
                      pedetect='1')
                  then                            -- arbitration lost in not ACK
                     fsmsta_nxt <= FSMSTA38;
                  else
                     if SDAO_int='0' then         -- ACK transmitting
                        fsmsta_nxt <= FSMSTA50;
                     else                         -- not ACK transmitting
                        fsmsta_nxt <= FSMSTA58;
                     end if;
                  end if;
               else                               -- receiving data
                  fsmsta_nxt <= FSMSTA50;
               end if;

            -------------------------------
            when FSMSTA58 =>
            -------------------------------
               fsmsta_nxt <= FSMSTA58;


   --==========================================--
   -- SLAVE xmt or rcv
   --==========================================--
   			-------------------------------
   			when FSMSTAD8 =>
   			-------------------------------
      			fsmsta_nxt <= FSMSTAD8 ;
         --==========================================--
         -- SLAVE RECEIVER
         --==========================================--

            -------------------------------
            when FSMSTA60 =>
            -------------------------------
               if framesync="1000" then           -- ACK transmitting
                  if SDAO_int='0' then            -- ACK transmitting
                     fsmsta_nxt <= FSMSTA80;
                  else                            -- not ACK transmitting
                     fsmsta_nxt <= FSMSTA88;
                  end if;
               else                               -- receiving data
                  fsmsta_nxt <= FSMSTA60;
               end if;

            -------------------------------
            when FSMSTA68 =>
            -------------------------------
               if framesync="1000" then           -- ACK transmitting
                  if SDAO_int='0' then            -- ACK transmitting
                     fsmsta_nxt <= FSMSTA80;
                  else                            -- not ACK transmitting
                     fsmsta_nxt <= FSMSTA88;
                  end if;
               else                               -- receiving data
                  fsmsta_nxt <= FSMSTA68;
               end if;

            -------------------------------
            when FSMSTA80 =>
            -------------------------------
               if framesync="1000" then          -- ACK transmitting
                  if SDAO_int='0' then           -- ACK transmitting
                     fsmsta_nxt <= FSMSTA80;
                  else                            -- not ACK transmitting
                     fsmsta_nxt <= FSMSTA88;
                  end if;
               else                               -- receiving data
                  fsmsta_nxt <= FSMSTA80;
               end if;

            -------------------------------
            when FSMSTA88 =>
            -------------------------------
               fsmsta_nxt <= FSMSTA88;            -- go to n.a. slv

            -------------------------------
            when FSMSTA70 =>
            -------------------------------
               if framesync="1000" then          -- ACK transmitting
                  if SDAO_int='0' then           -- ACK transmitting
                     fsmsta_nxt <= FSMSTA90;
                  else                           -- not ACK transmitting
                     fsmsta_nxt <= FSMSTA98;
                  end if;
               else                              -- receiving data
                  fsmsta_nxt <= FSMSTA70;
               end if;

            -------------------------------
            when FSMSTA78 =>
            -------------------------------
               if framesync="1000" then           -- ACK transmitting
                  if SDAO_int='0' then            -- ACK transmitting
                     fsmsta_nxt <= FSMSTA90;
                  else                            -- not ACK transmitting
                     fsmsta_nxt <= FSMSTA98;
                  end if;
               else                               -- receiving data
                  fsmsta_nxt <= FSMSTA78;
               end if;

            -------------------------------
            when FSMSTA90 =>
            -------------------------------
               if framesync="1000" then           -- ACK transmitting
                  if SDAO_int='0' then            -- ACK transmitting
                     fsmsta_nxt <= FSMSTA90;
                  else                            -- not ACK transmitting
                     fsmsta_nxt <= FSMSTA98;
                  end if;
               else                               -- receiving data
                  fsmsta_nxt <= FSMSTA90;
               end if;

            -------------------------------
            when FSMSTA98 =>
            -------------------------------
               fsmsta_nxt <= FSMSTA98;          -- go to n.a. slv

            -------------------------------
            when FSMSTAA0 =>
            -------------------------------
               fsmsta_nxt <= FSMSTAA0;          -- go to n.a. slv


         --==========================================--
         -- SLAVE TRANSMITTER
         --==========================================--

            -------------------------------
            when FSMSTAA8 =>
            -------------------------------
             if ((framesync="1000") and (MST_TX_SLV_RX = '0'))then -- ACK receiving
                  if SDAInt='1' then              -- not ACK
                     fsmsta_nxt <= FSMSTAC0;
                  else                            -- ACK
                     if aa='0' then               -- transmit last data
                        fsmsta_nxt <= FSMSTAC8;
                     else
                        fsmsta_nxt <= FSMSTAB8;
                     end if;
                  end if;
               else
               IF (((SDAO_int AND NOT(SDAInt) AND pedetect)) = '1' AND (MST_TX_SLV_RX = '0'))
                  then                            -- arbitration lost
                     fsmsta_nxt <= FSMSTA38;
                  else
                     fsmsta_nxt <= FSMSTAA8;
                  end if;
               end if;

            -------------------------------
            when FSMSTAB0 =>
            -------------------------------
             if ((framesync="1000") and (MST_TX_SLV_RX = '0'))then -- ACK receiving
                  if SDAInt='1' then            -- not ACK
                     fsmsta_nxt <= FSMSTAC0;
                  else                          -- ACK
                     if aa='0' then             -- transmit last data
                        fsmsta_nxt <= FSMSTAC8;
                     else
                        fsmsta_nxt <= FSMSTAB8;
                     end if;
                  end if;
               else
               IF (((SDAO_int AND NOT(SDAInt) AND pedetect)) = '1' AND (MST_TX_SLV_RX = '0'))
                  then                          -- arbitration lost
                     fsmsta_nxt <= FSMSTA38;
                  else
                     fsmsta_nxt <= FSMSTAB0;
                  end if;
               end if;

            -------------------------------
            when FSMSTAB8 =>
            -------------------------------

             if ((framesync="1000") and (MST_TX_SLV_RX = '0'))then -- ACK receiving
                  if SDAInt='1' then              -- not ACK
                     fsmsta_nxt <= FSMSTAC0;
                  else                            -- ACK
                     if aa='0' then               -- transmit last data
                        fsmsta_nxt <= FSMSTAC8;
                     else
                        fsmsta_nxt <= FSMSTAB8;
                     end if;
                  end if;
               else
               IF (((SDAO_int AND NOT(SDAInt) AND pedetect)) = '1' AND (MST_TX_SLV_RX = '0'))
                  then                             --arbitration lost
                     fsmsta_nxt <= FSMSTA38;
                  else
                     fsmsta_nxt <= FSMSTAB8;
                  end if;
               end if;

            -------------------------------
            when FSMSTAC0 =>
            -------------------------------
               fsmsta_nxt <= FSMSTAC0;          -- go to n.a. slv

            -------------------------------
            when FSMSTAC8 =>
            -------------------------------
               fsmsta_nxt <= FSMSTAC8;          -- go to n.a. slv


         --==========================================--
         -- BUS ERROR
         --==========================================--

            -------------------------------
            when FSMSTA00 =>
            -------------------------------
               fsmsta_nxt <= FSMSTA00;          -- go to n.a. slv

            -------------------------------
            when FSMSTAE0 =>
            -------------------------------
               fsmsta_nxt <= FSMSTAE0;


            -------------------------------
            when others =>
            ------------------------------
               fsmsta_nxt <= FSMSTAF8;          -- go to n.a. slv

         end case;
      end process;


   --------------------------------------------------------------------
   FSMSTA_SYNC_PROC:
   --------------------------------------------------------------------

    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            fsmsta <= FSMSTAF8;
            set_int <= '0';  -- <- for slave mode reset only.
            ens1_pre <= '1'; -- disable (i.e. reset device state machines)
        elsif (PCLK'event and PCLK = '1') then
            if (sresetn = '0') then
                fsmsta <= FSMSTAF8;
                set_int <= '0';  -- <- for slave mode reset only.
                ens1_pre <= '1'; -- disable (i.e. reset device state machines)
            else
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                if ((smbus_mst_reset_posedge = '1') and (SMB_EN_int = '1'))    then
                        set_int <= '0';  -- <- for slave mode reset only.
                        ens1_pre <= '1'; -- disable (i.e. reset device state machines)
                        fsmsta <= FSMSTAD0 ;  -- wait until SCL is low for 35ms
                elsif ((term_cnt_35ms_flag = '1') and (SMB_EN_int = '1')) then
                        set_int <= '0';  -- <- for slave mode reset only.
                        ens1_pre <= '0';    --disable (i.e. reset device state machines)
                        fsmsta <= FSMSTAF8 ;
                elsif ((term_cnt_25ms_flag = '1') and (SMB_EN_int = '1') and (fsmsta /= FSMSTAD0) and (mst /= '1')) then
                        set_int <= '0';  -- <- for slave mode reset only.
                        ens1_pre <= '1'; -- disable (i.e. reset device state machines)
                        fsmsta <= FSMSTAD8 ;  -- gen interrupt based on forced slave reset.
                elsif ((term_cnt_3ms_flag = '1') AND (IPMI_EN_int = '1')) then
                        set_int <= '0';  -- <- for slave mode reset only.
                        ens1_pre <= '1'; -- disable (i.e. reset device state machines)
                        fsmsta <= FSMSTAD8;
                elsif ((fsmsta = FSMSTAD8) and (si_int /= '1') and (SMB_EN_int = '1')) then
                        set_int <= '1';
                        ens1_pre <= '0';     --disable (i.e. reset device state machines)
                        fsmsta <= FSMSTAF8 ;
                elsif fsmdet=FSMDET3 and fsmmod=FSMMOD1 then
                        set_int <= '0';
                        ens1_pre <= '1';
                        fsmsta <= FSMSTA08;                       -- START has been trx
                elsif fsmdet=FSMDET3 and fsmmod=FSMMOD6 then
                        set_int <= '0';
                        ens1_pre <= '1';
                        fsmsta <= FSMSTA10;                       -- repeated START has been trx
                elsif fsmmod=FSMMOD4 and PCLKint_p2='1' then
                        fsmsta <= FSMSTAE0;                       -- STOP has been trx
                elsif fsmdet=FSMDET3 or fsmdet=FSMDET5 then  -- START or STOP has been rcv
                    if (framesync="0000" or framesync="1001") and
                        (si_int='0')
                    then
                        if adrcomp='1' then                    -- addressed slave
                            set_int <= '0';
                            ens1_pre <= '1';
                            fsmsta <= FSMSTAA0;                 -- switched to n.a.slv. mode
                        else
                            set_int <= '0';
                            ens1_pre <= '1';
                            fsmsta <= FSMSTAF8;
                        end if;
                    elsif (
                            (framesync="0001" or framesync="0010" or
                                framesync="0011" or framesync="0100" or
                                framesync="0101" or framesync="0110" or
                                framesync="0111" or framesync="1000"
                            ) and
                            (adrcomp='1' or mst='1')
                            )
                    then
                        set_int <= '0';
                        ens1_pre <= '1';
                        fsmsta <= FSMSTA00;                    -- frame error
                    end if;
                elsif (framesync="1000" and
                        pedetect='1' and
                        adrcomp='1' and
                        adrcompen='1' and
                        not (fsmsta=FSMSTA38)
                        )
                then                                         -- switched to addressed slv. mode
                    if ack='0' then -- R/nW = 0
                        if serdat(6 downto 0)="0000000" then
                            set_int <= '0';
                            ens1_pre <= '1';
                            fsmsta <= FSMSTA70;                 -- GC Address
                        else
                            set_int <= '0';
                            ens1_pre <= '1';
                            fsmsta <= FSMSTA60;                 -- slave address
                        end if;
                        ELSIF (MST_TX_SLV_RX = '0') THEN	  -- R/nW = 1
                            set_int <= '0';
                            ens1_pre <= '1';
                            fsmsta <= FSMSTAA8;                    -- slave address (R/nW = 1)
                    end if;
                else
                    if pedetect='1' then
                            set_int <= '0';
                            ens1_pre <= '1';
                            fsmsta <= fsmsta_nxt;
                    end if;
                end if;
            end if;
        end if;
    end process;


   --------------------------------------------------------------------
   -- stop/start condition detector
   --------------------------------------------------------------------
   FSMDET_COMB_PROC:
   --------------------------------------------------------------------
  process (fsmdet, SDAInt)
  begin
     -------------------------------
     -- Initial value
     -------------------------------
     fsmdet_nxt <= FSMDET6;

     -------------------------------
     -- Combinational value
     -------------------------------
     case fsmdet is
        -------------------------------
        when FSMDET0 =>
        -------------------------------
           if SDAInt='0' then
              fsmdet_nxt <= FSMDET2;
           else
              fsmdet_nxt <= FSMDET1;
           end if;

        -------------------------------
        when FSMDET1 =>
        -------------------------------
           if SDAInt='0' then
              fsmdet_nxt <= FSMDET3;
           else
              fsmdet_nxt <= FSMDET1;
           end if;

        -------------------------------
        when FSMDET2 =>
        -------------------------------
           if SDAInt='0' then
              fsmdet_nxt <= FSMDET2;
           else
              fsmdet_nxt <= FSMDET5;
           end if;

        -------------------------------
        when FSMDET3 =>
        -------------------------------
           fsmdet_nxt <= FSMDET4;

        -------------------------------
        when FSMDET4 =>
        -------------------------------
           if SDAInt='0' then
              fsmdet_nxt <= FSMDET4;
           else
              fsmdet_nxt <= FSMDET5;
           end if;

        -------------------------------
        when FSMDET5 =>
        -------------------------------
           fsmdet_nxt <= FSMDET6;

        -------------------------------
        when others => -- when FSMDET6
        -------------------------------
           if SDAInt='0' then
              fsmdet_nxt <= FSMDET3;
           else
              fsmdet_nxt <= FSMDET6;
           end if;

     end case;

  end process;

   --------------------------------------------------------------------
   FSMDET_SYNC_PROC:
   --------------------------------------------------------------------

    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            fsmdet <= FSMDET0;
        elsif (PCLK'event and PCLK = '1') then
            if (sresetn = '0') then
                fsmdet <= FSMDET0;
            else
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                if SCLInt='0' then --or
                    fsmdet <= FSMDET0;
                else
                    fsmdet <= fsmdet_nxt;
                end if;
            end if;
        end if;
    end process;


   --------------------------------------------------------------------
   -- bus free detector
   --------------------------------------------------------------------
   BUSFREE_WRITE_PROC:
   --------------------------------------------------------------------

    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            busfree <= '1';
        elsif (PCLK'event and PCLK = '1') then
            if (sresetn = '0') then
                busfree <= '1';
            else
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                if fsmdet=FSMDET3 then          -- START condition
                    busfree <= '0';
                elsif (
                            (fsmdet=FSMDET5) or         -- STOP condition rcv
                            (fsmmod=FSMMOD4 and PCLKint_p1='1' and
                            SCLInt='1') or            -- STOP transmitted
                            (mst='0' and sto='1') or   -- internal stop
                            (ens1='0')
                        )
                then
                    busfree <= '1';
                end if;
            end if;
        end if;
    end process;


   --------------------------------------------------------------------
   -- two cycles SCL
   --------------------------------------------------------------------
   SCLSCL_WRITE_PROC:
   --------------------------------------------------------------------

    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            SCLSCL <= '0';
        elsif PCLK'event and PCLK='1' then
            if (sresetn = '0') then
                SCLSCL <= '0';
            else
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                if fsmmod=FSMMOD5 then
                    if pedetect='1' then
                        SCLSCL <= '1';
                    end if;
                else
                    SCLSCL <= '0';
                end if;
            end if;
        end if;
    end process;


   --------------------------------------------------------------------
   -- transmit START condition enable
   --------------------------------------------------------------------
   STARTO_EN_WRITE_PROC:
   --------------------------------------------------------------------

    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            starto_en <= '0';
        elsif (PCLK'event and PCLK = '1') then
            if (sresetn = '0') then
                starto_en <= '0';
            else
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                if (busfree='1' and
                    SCLInt='1' and
                    not (fsmmod=FSMMOD5) )
                then
                    if PCLKint_p1='1' then
                        starto_en <= '1';
                    end if;
                else
                    starto_en <= '0';
                end if;
            end if;
        end if;
    end process;


   --------------------------------------------------------------------
   -- master/slave mode detector
   --------------------------------------------------------------------
   FSMMOD_COMB_PROC:
   --------------------------------------------------------------------
      process (fsmmod, SDAInt, SCLInt, PCLKint_p2,
               PCLKint_p1, sto, sta, nedetect, framesync, starto_en,
               si_int, fsmsta, pedetect, SCLSCL)
      begin
         -------------------------------
         -- Initial value
         -------------------------------
         mst <= '1';
         fsmmod_nxt <= FSMMOD6;

         -------------------------------
         -- Combinational value
         -------------------------------
         case fsmmod is
            -------------------------------
            when FSMMOD0 =>
            -------------------------------
               mst <= '0';

               if (starto_en='1' and
                   sta='1' and
                   si_int='0' and PCLKint_p1='1')
               then
                  if SDAInt='0' then
                     fsmmod_nxt <= FSMMOD5;    -- transmit 2*SCL
                  else
                     fsmmod_nxt <= FSMMOD1; -- transmit START
                  end if;
               else
                  fsmmod_nxt <= FSMMOD0;
               end if;

            -------------------------------
            when FSMMOD1 =>
            -------------------------------
               mst <= '1';

               if nedetect='1' then              -- SCLInt neg. edge deteted
                  fsmmod_nxt <= FSMMOD2;
               else
                  fsmmod_nxt <= FSMMOD1;
               end if;

            -------------------------------
            when FSMMOD2 =>
            -------------------------------
               mst <= '1';
               if framesync="1001" and si_int='0' then
                  if sto='1' then
                     --if SCLInt='0' then
                     fsmmod_nxt <= FSMMOD4;         -- transmit STOP
                     --end if;
                  elsif (sta='1' and
                         not (fsmsta=FSMSTA08 or fsmsta=FSMSTA10) and
                         PCLKint_p2='1')
                  then
                     fsmmod_nxt <= FSMMOD3;         -- transmit repeated START (Sr)
                  else
                     fsmmod_nxt <= FSMMOD2;
                  end if;
               else
                  fsmmod_nxt <= FSMMOD2;
               end if;

            -------------------------------
            when FSMMOD3 =>
            -------------------------------
               mst <= '1';
               if (PCLKint_p1='1' or PCLKint_p2='1') and SCLInt='1' then
                  fsmmod_nxt <= FSMMOD6;
               else
                  fsmmod_nxt <= FSMMOD3;
               end if;

            -------------------------------
            when FSMMOD4 =>
            -------------------------------
               mst <= '1';
               if SCLInt='1' and PCLKint_p1='1' then
                  fsmmod_nxt <= FSMMOD0;
               else
                  fsmmod_nxt <= FSMMOD4;
               end if;

            -------------------------------
            when FSMMOD5 =>
            -------------------------------
               mst <= '0';
               if SCLSCL='1' and pedetect='1' then   -- two cycles SCLO
                  fsmmod_nxt <= FSMMOD0;
               else
                  fsmmod_nxt <= FSMMOD5;
               end if;

            -------------------------------
            when others => --when FSMMOD6 =>
            -------------------------------
               mst <= '1';
               if nedetect='1' then   -- Sr
                  fsmmod_nxt <= FSMMOD2;
               else
                  fsmmod_nxt <= FSMMOD6;
               end if;

         end case;

      end process;


   --------------------------------------------------------------------
   FSMMOD_SYNC_PROC:
   --------------------------------------------------------------------

    process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            fsmmod <= FSMMOD0;
        elsif (PCLK'event and PCLK = '1') then
            if (sresetn = '0') then
                fsmmod <= FSMMOD0;
            else
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                if (
                        (fsmdet=FSMDET5) or   -- STOP
                        (fsmsta=FSMSTA38 and
                        framesync="1000" and
                        pedetect='1') or
                        (ens1='0')            -- core disable
                    )
                then
                    fsmmod <= FSMMOD0;
                else
                    fsmmod <= fsmmod_nxt;
                end if;
            end if;
        end if;
    end process;


   --------------------------------------------------------------------
   -- APB registers read
   --------------------------------------------------------------------
   APB_read :
   --------------------------------------------------------------------

   PRDATA <=
 		sercon 					WHEN PADDR = serCON_ID ELSE
--  ('0'&sercon(6 DOWNTO 2)&"00") WHEN PADDR = serCON_ID ELSE

        serdat 					WHEN PADDR = serDAT_ID ELSE
        (sersta & "000") 		WHEN PADDR = serSTA_ID ELSE
        seradr0 				WHEN PADDR = serADR0_ID ELSE
        seradr1 				WHEN PADDR = serADR1_ID ELSE
        (sersmb7 & sersmb6 & sersmb5 & sersmb4 & sersmb3 & sersmb2 & sersmb1 & sersmb0)
        						WHEN (PADDR = serSMB_ID) AND (SMB_EN = 1) ELSE
        ("00000" & sersmb2 & "00")
        						WHEN (PADDR = serSMB_ID) AND (IPMI_EN = 1) ELSE
        "00000000";
   --------------------------------------------------------------------
   -- timeout counters for SMBus
   --------------------------------------------------------------------

   --Counter to hold clock low for 35 ms when in master mode.
    term_cnt_35ms_proc:  process(PCLK,aresetn) 
    begin
        if (aresetn = '0') then
            term_cnt_35ms_reg <= (others => '0');
        elsif (PCLK'event and PCLK = '1') then
            if (sresetn = '0') then
                term_cnt_35ms_reg <= (others => '0');
            else
                if (SMB_EN_int = '1') then
                    if (smbus_mst_reset_posedge = '1') then
                        term_cnt_35ms_reg <= (others => '0');  -- reset counter if smbus_mst_reset
                    elsif (smbus_mst_reset = '0') then
                        term_cnt_35ms_reg <= (others => '0');  -- reset counter if smbus_mst_reset
                    elsif ((term_cnt_35ms_reg /= std_logic_vector(to_unsigned(term_cnt_35ms,8))) AND (pulse_215us='1')) then
                        term_cnt_35ms_reg <= term_cnt_35ms_reg + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    term_cnt_35ms_flag <= '1' when (((term_cnt_35ms_reg >= std_logic_vector(to_unsigned(term_cnt_35ms,8))) and
                                  (smbus_mst_reset = '1'))
                                 or (SMB_EN_int = '0')) else '0';

   --Counter to hold clock low for 25 ms when in slave mode.
    term_cnt_25ms_proc:process(PCLK,aresetn)
    begin
        if (aresetn = '0') then
            term_cnt_25ms_reg <= (others => '0');
        elsif PCLK'event and PCLK='1' then
            if (sresetn = '0') then
                term_cnt_25ms_reg <= (others => '0');
            else
                if (SMB_EN_int = '1') then
                    if (SCLInt = '1')   then
                        term_cnt_25ms_reg <= (others => '0'); -- reset counter if slave mode and clk is high
                    elsif ((term_cnt_25ms_reg /= std_logic_vector(to_unsigned(term_cnt_25ms,7))) AND (pulse_215us='1')) then
                        term_cnt_25ms_reg <= term_cnt_25ms_reg + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

  term_cnt_25ms_flag <= '1' when (((term_cnt_25ms_reg = std_logic_vector(to_unsigned(term_cnt_25ms,7)) - 1) AND (pulse_215us='1'))
                                 or (SMB_EN_int = '0')) else '0';  --pulse

    -- IPMI Counter to hold clock low for 3 ms.
    PROCESS (PCLK, aresetn)
    BEGIN
        IF (aresetn = '0') THEN
            term_cnt_3ms_reg <= "0000";
        ELSIF (PCLK'EVENT AND PCLK = '1') THEN
            IF (sresetn = '0') THEN
                term_cnt_3ms_reg <= "0000";
            ELSE
                IF (IPMI_EN_int = '1') THEN
                    IF (SCLInt = '1') THEN
                        term_cnt_3ms_reg <= "0000";
                    ELSIF ((term_cnt_3ms_reg /= std_logic_vector(to_unsigned(term_cnt_3ms,4)))  AND (pulse_215us='1')) then
                        term_cnt_3ms_reg <= term_cnt_3ms_reg + "0001";
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;

   term_cnt_3ms_flag <= '1' WHEN ((term_cnt_3ms_reg = (std_logic_vector(to_unsigned(term_cnt_3ms,4)) - "0001"))AND (pulse_215us = '1')) OR (IPMI_EN_int = '0') ELSE
                        '0';
   
end RTL;
--*******************************************************************--


