--******************************************************************************/
-- Copyright (c) 2009 Actel Corporation.  All rights reserved.
--******************************************************************************/
--
--    File Name:  tb_user_corei2c.vhd
--      Version:  5.0
--         Date:  Aug 20th, 2009
--  Description:  Top level test module
--
--      Company:  Actel
--
--   SVN Revision Information:
--   SVN $Revision: 29417 $
--   SVN $Date: 2017-03-24 13:11:44 +0530 (Fri, 24 Mar 2017) $
--
--
-- REVISION HISTORY:
-- COPYRIGHT 2009 BY ACTEL
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS
-- FROM ACTEL CORP.  IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM
-- ACTEL FOR USE OF THIS FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND
-- NO BACK-UP OF THE FILE SHOULD BE MADE.
--
-- FUNCTIONAL DESCRIPTION:
-- Parameters marked with "user values" may be modified to check a given
--	  application.  Other parameter modifications may or may not break the TB.
-- Refer to the CoreI2C Handbook.
--******************************************************************************/


library std;
use std.textio.all;

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library COREI2C_LIB;
use     COREI2C_LIB.corei2c_tb_pkg.all;


entity testbench is
end testbench;


architecture behav of testbench is

CONSTANT      serCON_ID        : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
CONSTANT      serCON_RV        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
CONSTANT      serSTA_ID        : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00100";
CONSTANT      serSTA_RV        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "11111000";
CONSTANT      serDAT_ID        : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01000";
CONSTANT      serDAT_RV        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
CONSTANT      serADR0_ID       : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01100";
CONSTANT      serADR0_RV       : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
CONSTANT      serSMB_ID        : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10000";
CONSTANT      serSMB_RV        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "0111H000";
CONSTANT      serADR1_ID       : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11100";
CONSTANT      serADR1_RV       : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
CONSTANT      APB_DWIDTH       : INTEGER := 8;
CONSTANT      SYS_CLK_CYCLE    : INTEGER := 50;
CONSTANT      TIMEOUT		   : INTEGER := 1000000;
CONSTANT	  PERIOD_ADR           : INTEGER := 4;


--CoreI2C Instance0 configuration
--The User SHOULD NOT MODIFY any Instance 0 Parameters, else Testbench may fail.
--CONSTANT      FAMILY_0         			:INTEGER := 17;
CONSTANT      OPERATING_MODE_0 			:INTEGER := 0;
CONSTANT      BAUD_RATE_FIXED_0			:INTEGER := 0;
CONSTANT      BAUD_RATE_VALUE_0			:INTEGER := 0;
CONSTANT      BCLK_ENABLED_0			:INTEGER := 1;
CONSTANT      GLITCHREG_NUM_0			:INTEGER := 3;
CONSTANT      SMB_EN_0         			:INTEGER := 1;
CONSTANT      IPMI_EN_0					:INTEGER := 0;
CONSTANT      FREQUENCY_0      			:INTEGER := 20;
CONSTANT      FIXED_SLAVE0_ADDR_EN_0	:INTEGER := 0;
CONSTANT      FIXED_SLAVE0_ADDR_VALUE_0	:INTEGER := 0;
CONSTANT      ADD_SLAVE1_ADDRESS_EN_0	:INTEGER := 0;
CONSTANT      FIXED_SLAVE1_ADDR_EN_0	:INTEGER := 0;
CONSTANT      FIXED_SLAVE1_ADDR_VALUE_0	:INTEGER := 0;
CONSTANT	  I2C_NUM_0					:INTEGER := 1;

--CoreI2C Instance1 configuration
--The User CAN modify some Instance 1 Parameters noted to check a given app.
--CONSTANT      FAMILY_1         			:INTEGER := 17;
CONSTANT      OPERATING_MODE_1 			:INTEGER := 3; --user values: 0,1,2,3
CONSTANT      BAUD_RATE_FIXED_1			:INTEGER := 0;
CONSTANT      BAUD_RATE_VALUE_1			:INTEGER := 0;
CONSTANT      BCLK_ENABLED_1			:INTEGER := 1;
CONSTANT      GLITCHREG_NUM_1			:INTEGER := 3; --user values: 3-15
CONSTANT      SMB_EN_1         			:INTEGER := 1; --user values: 0,1
CONSTANT      IPMI_EN_1					:INTEGER := 0; --user values: 0,1
CONSTANT      FREQUENCY_1      			:INTEGER := 20;
CONSTANT      FIXED_SLAVE0_ADDR_EN_1	:INTEGER := 0; --user values: 0,1
CONSTANT      FIXED_SLAVE0_ADDR_VALUE_1	:INTEGER := 0; --user values: 0,127
CONSTANT      ADD_SLAVE1_ADDRESS_EN_1	:INTEGER := 0; --user values: 0,1
CONSTANT      FIXED_SLAVE1_ADDR_EN_1	:INTEGER := 0; --user values: 0,1
CONSTANT      FIXED_SLAVE1_ADDR_VALUE_1	:INTEGER := 0; --user values: 0,127
CONSTANT	  I2C_NUM_1					:INTEGER := 13;
--to acheive roughly 100 kbps speed, either approximate with the 7
--clock division values (cr210 bits in CON reg), or use a BCLK input
--to match exactly.
--using the cr210 bit values:
-- 	x = Fpclk / 100khz;  x -> 200, choose cr210 = 192 ~ 104kbps
CONSTANT      cr210                     :STD_LOGIC_VECTOR(2 DOWNTO 0) := "010"; --divide by 192 value
CONSTANT      ens1                      :STD_LOGIC:= '1';
CONSTANT      sta                       :STD_LOGIC:= '1';
CONSTANT      sto                       :STD_LOGIC:= '1';
CONSTANT      si                        :STD_LOGIC:= '1';
CONSTANT      aa                        :STD_LOGIC:= '1';
CONSTANT      R_nW	                    :STD_LOGIC:= '1';

CONSTANT      I0_adr                    :STD_LOGIC_VECTOR(6 DOWNTO 0) := "1011001";
CONSTANT      I1_adr0                   :STD_LOGIC_VECTOR(6 DOWNTO 0) := "1100000";
CONSTANT      I1_adr1                   :STD_LOGIC_VECTOR(6 DOWNTO 0) := "1100001";
CONSTANT      GC	                    :STD_LOGIC                    := '1';

--Generated Spike Width In Clock Cycles:
CONSTANT	  SPIKE_CYCLE_WIDTH			:INTEGER:=0; --user values: 0-16

COMPONENT i2c_spk IS
 GENERIC (
      SPIKE_CYCLE_WIDTH     : INTEGER := 0
	);
 PORT (
      PCLK                       : IN STD_LOGIC;
      PRESETN                    : IN STD_LOGIC;
      scl                        : INOUT STD_LOGIC;
      sda                        : INOUT STD_LOGIC
   );
END COMPONENT;


COMPONENT SF2_MSS_sys_sb_COREI2C_0_COREI2C
 GENERIC (
      --FAMILY                     : INTEGER := 17;
      OPERATING_MODE             : INTEGER := 0;
      BAUD_RATE_FIXED            : INTEGER := 0;
      BAUD_RATE_VALUE            : INTEGER := 0;
      BCLK_ENABLED               : INTEGER := 1;
      GLITCHREG_NUM              : INTEGER := 3;
      SMB_EN                     : INTEGER := 0;
      IPMI_EN                    : INTEGER := 0;
      FREQUENCY                  : INTEGER := 30;
      FIXED_SLAVE0_ADDR_EN       : INTEGER := 0;
      FIXED_SLAVE0_ADDR_VALUE    : INTEGER := 0;
      ADD_SLAVE1_ADDRESS_EN      : INTEGER := 0;
      FIXED_SLAVE1_ADDR_EN       : INTEGER := 0;
      FIXED_SLAVE1_ADDR_VALUE    : INTEGER := 0;
      I2C_NUM					 : INTEGER := 1
	);
 PORT (
 	-- system globals
 	PCLK   		: IN  STD_LOGIC;  -- Global clock input
 	PRESETN		: IN  STD_LOGIC;  -- Global reset input
 	BCLK   		: IN  STD_LOGIC;  --

 	-- Serial inputs
 	SCLI     	: IN  STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);  -- serial clock input
 	SDAI     	: IN  STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);  -- serial data input

 	-- APB register interface
 	PSEL      	: IN  STD_LOGIC;
 	PENABLE    	: IN  STD_LOGIC;
 	PWRITE    	: IN  STD_LOGIC;
 	PADDR      	: IN  STD_LOGIC_VECTOR(8 DOWNTO 0); -- data address
 	PWDATA     	: IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- data input

 	-- Serial outputs
 	SCLO      	: OUT STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);  -- serial clock output - registered
 	SDAO      	: OUT STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);  -- serial data output  - registered

 	-- Interrupt flags
 	INT        	: OUT STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);  -- INT flag          - registered
    SMBA_INT   	: OUT STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);
    SMBS_INT   	: OUT STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);

 	-- APB register interface read
 	PRDATA     	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- data output
 	-- SMBus Optional Signals
 	SMBALERT_NI	: IN  STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);
 	SMBALERT_NO	: OUT STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);
 	SMBSUS_NI	: IN  STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);
 	SMBSUS_NO	: OUT STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0)
           );
END COMPONENT;

SIGNAL PCLK                    : STD_LOGIC;
SIGNAL PRESETN                 : STD_LOGIC;
SIGNAL PSEL_0                  : STD_LOGIC;
SIGNAL PSEL_1                  : STD_LOGIC;
SIGNAL PENABLE                 : STD_LOGIC;
SIGNAL PWRITE                  : STD_LOGIC;

SIGNAL PADDR                   : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL PWDATA                  : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
SIGNAL PRDATA_0                : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
SIGNAL PRDATA_1                : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
SIGNAL INT_0                   : STD_LOGIC_VECTOR(I2C_NUM_0-1 DOWNTO 0);
SIGNAL INT_1                   : STD_LOGIC_VECTOR(I2C_NUM_1-1 DOWNTO 0);
SIGNAL SMBA_INT_0			  : STD_LOGIC_VECTOR(I2C_NUM_0-1 DOWNTO 0);
SIGNAL SMBA_INT_1			  : STD_LOGIC_VECTOR(I2C_NUM_1-1 DOWNTO 0);
SIGNAL SMBS_INT_0			  : STD_LOGIC_VECTOR(I2C_NUM_0-1 DOWNTO 0);
SIGNAL SMBS_INT_1			  : STD_LOGIC_VECTOR(I2C_NUM_1-1 DOWNTO 0);
SIGNAL BCLK                    : STD_LOGIC;
SIGNAL scl                     : STD_LOGIC;
SIGNAL SCLI_0                  : STD_LOGIC_VECTOR(I2C_NUM_0-1 DOWNTO 0);
SIGNAL SCLI_1                  : STD_LOGIC_VECTOR(I2C_NUM_1-1 DOWNTO 0);
SIGNAL SCLO_0                  : STD_LOGIC_VECTOR(I2C_NUM_0-1 DOWNTO 0);
SIGNAL SCLO_1                  : STD_LOGIC_VECTOR(I2C_NUM_1-1 DOWNTO 0);
SIGNAL sda                     : STD_LOGIC;
SIGNAL SDAI_0                  : STD_LOGIC_VECTOR(I2C_NUM_0-1 DOWNTO 0);
SIGNAL SDAI_1                  : STD_LOGIC_VECTOR(I2C_NUM_1-1 DOWNTO 0);
SIGNAL SDAO_0                  : STD_LOGIC_VECTOR(I2C_NUM_0-1 DOWNTO 0);
SIGNAL SDAO_1                  : STD_LOGIC_VECTOR(I2C_NUM_1-1 DOWNTO 0);
SIGNAL SMBALERT_NO_0           : STD_LOGIC_VECTOR(I2C_NUM_0-1 DOWNTO 0);
SIGNAL SMBALERT_NO_1           : STD_LOGIC_VECTOR(I2C_NUM_1-1 DOWNTO 0);
SIGNAL SMBALERT_NI_0           : STD_LOGIC_VECTOR(I2C_NUM_0-1 DOWNTO 0);
SIGNAL SMBALERT_NI_1           : STD_LOGIC_VECTOR(I2C_NUM_1-1 DOWNTO 0);
SIGNAL SMBALERT_N              : STD_LOGIC;
SIGNAL SMBSUS_NO_0             : STD_LOGIC_VECTOR(I2C_NUM_0-1 DOWNTO 0);
SIGNAL SMBSUS_NO_1             : STD_LOGIC_VECTOR(I2C_NUM_1-1 DOWNTO 0);
SIGNAL SMBSUS_NI_0			   : STD_LOGIC_VECTOR(I2C_NUM_0-1 DOWNTO 0);
SIGNAL SMBSUS_NI_1			   : STD_LOGIC_VECTOR(I2C_NUM_1-1 DOWNTO 0);
SIGNAL simerrors               : INTEGER;
SIGNAL count_high              : INTEGER;
SIGNAL count_low               : INTEGER;
SIGNAL real_error              : INTEGER;
SIGNAL tnow					   : INTEGER;

SIGNAL sum                     : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL sum_count               : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL diff                 :  std_logic;
SIGNAL stopsim				:boolean;
SIGNAL stopsim2				:boolean;
SIGNAL my_scale_tmp			: unsigned (7 downto 0);

constant dash_str			:string(1 to 77)	:=
"-----------------------------------------------------------------------------";
constant uline_str			:string(1 to 77)	:=
"_____________________________________________________________________________";
constant pound_str			:string(1 to 77)	:=
"#############################################################################";
constant space77_str		:string(1 to 77)	:=
"                                                                             ";
constant copyright_str		:string(1 to 77)	:=
"(c) Copyright Microsemi Corporation. All rights reserved.                    ";
constant tb_name_str		:string(1 to 77)	:=
"Testbench for: CoreI2C (Two Instance Master/Slave Bus Configuration)         ";
constant tb_ver_str			:string(1 to 77)	:=
"Version: 7.2                                                                 ";
constant lsb_str			:string(1 to 3)		:= "LSB";
constant msb_str			:string(1 to 3)		:= "MSB";

type STR_ARRAY1 is array (integer range 0 to 11) of string (1 to 77);

-- initialization of testbench string
constant init_str_mem		:STR_ARRAY1			:= (
space77_str,space77_str,uline_str,space77_str,copyright_str,space77_str,
tb_name_str,tb_ver_str,uline_str,space77_str,space77_str,space77_str
);

-- Run simulation for given number of clock cycles
procedure cyc(
	constant	c:			in	integer range 0 to 65536) is
begin
	cloop: for i in 1 to c loop
		wait for SYS_CLK_CYCLE * 1 ns ;
	end loop cloop;
end cyc;


BEGIN

-- ser bus signal pullup
SCL <= 'H';
SDA <= 'H';
scl <= '0' WHEN SCLO_0(0) = '0' ELSE
       'Z';
scl <= '0' WHEN SCLO_1(I2C_NUM_1-1) = '0' ELSE
       'Z';
SCLI_0(0) <= scl;
SCLI_1(I2C_NUM_1-1) <= scl;
sda <= '0' WHEN SDAO_0(0) = '0' ELSE
       'Z';
sda <= '0' WHEN SDAO_1(I2C_NUM_1-1) = '0' ELSE
       'Z';
SDAI_0(0) <= sda;
SDAI_1(I2C_NUM_1-1) <= sda;

SMBALERT_N <= 'H';
SMBALERT_N <= '0' WHEN SMBALERT_NO_0(0) = '0' ELSE
              'Z';
SMBALERT_N <= '0' WHEN SMBALERT_NO_1(I2C_NUM_1-1) = '0' ELSE
              'Z';
SMBALERT_NI_0(0) <= SMBALERT_N;
SMBALERT_NI_1(I2C_NUM_1-1) <= SMBALERT_N;

SMBSUS_NI_0(0) <= SMBSUS_NO_1(I2C_NUM_1-1);
SMBSUS_NI_1 <= SMBSUS_NO_0(I2C_NUM_0-1) & (std_logic_vector(to_unsigned(0,I2C_NUM_1-1)));

-- generate the system clock
PCLK_proc: process
begin
	if ((stopsim = true) or (stopsim2 = true)) then
		wait;	-- end simulation
	else
		PCLK <= '0';
		wait for ((SYS_CLK_CYCLE * 1 ns)/2);
		PCLK <= '1';
		wait for ((SYS_CLK_CYCLE * 1 ns)/2);
	end if;
end process;

TIMEOUT_proc:  process
begin
 	    tloop: for t in 1 to TIMEOUT loop
        wait for SYS_CLK_CYCLE * 1 ns ;
            IF (t = TIMEOUT) THEN
          	  printf("\n*** Error: Timed Out Waiting For Change.  \n     Spike Cycle Width Value May Be Too High, or Test Bench Configuration Wrong...\n");
              ASSERT (FALSE) REPORT ".........Ending simulation" SEVERITY FAILURE;
            ELSIF (stopsim = true) THEN
              wait;
              exit tloop;
            END IF;
         END LOOP tloop;
end process;
	
ui2c0 : SF2_MSS_sys_sb_COREI2C_0_COREI2C
            generic map (
      		--FAMILY                  => FAMILY_0                 ,
      		OPERATING_MODE          => OPERATING_MODE_0         ,
      		BAUD_RATE_FIXED         => BAUD_RATE_FIXED_0        ,
      		BAUD_RATE_VALUE         => BAUD_RATE_VALUE_0        ,
      		BCLK_ENABLED            => BCLK_ENABLED_0           ,
      		GLITCHREG_NUM           => GLITCHREG_NUM_0          ,
      		SMB_EN                  => SMB_EN_0                 ,
      		IPMI_EN                 => IPMI_EN_0                ,
      		FREQUENCY               => FREQUENCY_0              ,
      		FIXED_SLAVE0_ADDR_EN    => FIXED_SLAVE0_ADDR_EN_0   ,
      		FIXED_SLAVE0_ADDR_VALUE => FIXED_SLAVE0_ADDR_VALUE_0,
      		ADD_SLAVE1_ADDRESS_EN   => ADD_SLAVE1_ADDRESS_EN_0  ,
      		FIXED_SLAVE1_ADDR_EN    => FIXED_SLAVE1_ADDR_EN_0   ,
      		FIXED_SLAVE1_ADDR_VALUE => FIXED_SLAVE1_ADDR_VALUE_0,
      		I2C_NUM					=> I2C_NUM_0
			                        )
            port map    (
            PCLK      	=> PCLK,
            PRESETN   	=> PRESETN,
            BCLK      	=> BCLK,
            SCLI       	=> SCLI_0,
            SDAI       	=> SDAI_0,
			SCLO       	=> SCLO_0,
            SDAO       	=> SDAO_0,
            INT       	=> INT_0,
    		SMBA_INT   	=> SMBA_INT_0,
    		SMBS_INT   	=> SMBS_INT_0,
            PWDATA      => PWDATA,
            PRDATA      => PRDATA_0,
            PADDR       => PADDR,
            PSEL        => PSEL_0, 
            PENABLE     => PENABLE,
            PWRITE      => PWRITE,
     		SMBALERT_NI => SMBALERT_NI_0,
	  		SMBALERT_NO => SMBALERT_NO_0,
	  		SMBSUS_NI   => SMBSUS_NI_0,
	  		SMBSUS_NO   => SMBSUS_NO_0
            );



ui2c1 : SF2_MSS_sys_sb_COREI2C_0_COREI2C
            generic map (
      		--FAMILY                  => FAMILY_1                 ,
      		OPERATING_MODE          => OPERATING_MODE_1         ,
      		BAUD_RATE_FIXED         => BAUD_RATE_FIXED_1        ,
      		BAUD_RATE_VALUE         => BAUD_RATE_VALUE_1        ,
      		BCLK_ENABLED            => BCLK_ENABLED_1           ,
      		GLITCHREG_NUM           => GLITCHREG_NUM_1          ,
      		SMB_EN                  => SMB_EN_1                 ,
      		IPMI_EN                 => IPMI_EN_1                ,
      		FREQUENCY               => FREQUENCY_1              ,
      		FIXED_SLAVE0_ADDR_EN    => FIXED_SLAVE0_ADDR_EN_1   ,
      		FIXED_SLAVE0_ADDR_VALUE => FIXED_SLAVE0_ADDR_VALUE_1,
      		ADD_SLAVE1_ADDRESS_EN   => ADD_SLAVE1_ADDRESS_EN_1  ,
      		FIXED_SLAVE1_ADDR_EN    => FIXED_SLAVE1_ADDR_EN_1   ,
      		FIXED_SLAVE1_ADDR_VALUE => FIXED_SLAVE1_ADDR_VALUE_1,
      		I2C_NUM					=> I2C_NUM_1
			                        )
            port map    (
            PCLK       	=> PCLK,
            PRESETN    	=> PRESETN,
            BCLK      	=> BCLK,
            SCLI       	=> SCLI_1,
            SDAI       	=> SDAI_1,
			SCLO       	=> SCLO_1,
            SDAO       	=> SDAO_1,
            INT       	=> INT_1,
    		SMBA_INT   	=> SMBA_INT_1,
    		SMBS_INT  	=> SMBS_INT_1,
            PWDATA     	=> PWDATA,
            PRDATA     	=> PRDATA_1,
            PADDR      	=> PADDR,
            PSEL       	=> PSEL_1, 
            PENABLE    	=> PENABLE,
            PWRITE     	=> PWRITE,
     		SMBALERT_NI	=> SMBALERT_NI_1,
	  		SMBALERT_NO	=> SMBALERT_NO_1,
	  		SMBSUS_NI  	=> SMBSUS_NI_1,
	  		SMBSUS_NO  	=> SMBSUS_NO_1
            );


   uspk : i2c_spk
            generic map (
      		SPIKE_CYCLE_WIDTH => SPIKE_CYCLE_WIDTH
      		)
      		port map (
         	PCLK     => PCLK,
         	PRESETN  => PRESETN,
         	scl      => scl,
         	sda      => sda
      		);


   testing : PROCESS
      VARIABLE i2                     :  integer;
      VARIABLE i                      :  integer;
      VARIABLE j                      :  integer;
      VARIABLE k                      :  integer;
      VARIABLE l                      :  integer;
      VARIABLE t                      :  integer;
      VARIABLE lmsb_str               :  std_logic_vector(8 * 79 DOWNTO 1);
      VARIABLE dtmp                   :  std_logic_vector(7 DOWNTO 0);
      VARIABLE fixed_enable_var       :  std_logic_vector(7 DOWNTO 0);
      VARIABLE fixed_int_mask_var     :  std_logic_vector(7 DOWNTO 0);
      variable simerrorsv			  :  natural range 0 to 2047;
      variable sum_count			  :  natural range 0 to 2047;
      variable scale_tmp              :  unsigned (7 downto 0);
   	  variable nowv 				  :  integer ;




   BEGIN
         i := 0;
         j := 0;
         k := 0;
         l := 0;
         t := 0;
         dtmp := "00000000";
         fixed_enable_var := "00000000";
         fixed_int_mask_var := "00000000";
         simerrors <= simerrorsv;
         simerrorsv := 0;
         sum <= "00000000";
         sum_count := 0;
         diff <= '0';
         count_high <= 0;
         count_low <= 0;
         real_error <= 0;
         scale_tmp := "00000000";
         my_scale_tmp <= "00000000";
         i := 0;
         nowv := NOW / 1 ns;

         WHILE (i < 12) LOOP
            printf( init_str_mem(i));
            i := i + 1;
         END LOOP;
         PRESETN <= '0';
         PSEL_0 <= '0';
         PSEL_1 <= '0';
         PWDATA <= (others => '0');
         PADDR <= (others => '0');
         PWRITE <= '0';
         PENABLE <= '0';
         BCLK <= '0';
         WAIT UNTIL (PCLK'EVENT AND PCLK = '1');
         PRESETN <= '1';

printf("\n\nCheck Instance0 Initial Register Values:");
printf(" ");
cpu_rd(PRDATA_0,PSEL_0,"0000" & serCON_ID , serCON_RV ,PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
cpu_rd(PRDATA_0,PSEL_0,"0000" & serSTA_ID , serSTA_RV ,PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
cpu_rd(PRDATA_0,PSEL_0,"0000" & serDAT_ID , serDAT_RV ,PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
cpu_rd(PRDATA_0,PSEL_0,"0000" & serADR0_ID, serADR0_RV,PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSMB_ID, serSMB_RV ,PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
cpu_rd(PRDATA_0,PSEL_0,"0000" & serADR1_ID, serADR1_RV,PCLK,PADDR,PWRITE,PENABLE,simerrorsv);

printf("\n\nCheck Instance1 Initial Register Values:\n");
cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) & serCON_ID , serCON_RV ,PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) & serSTA_ID , serSTA_RV ,PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) & serDAT_ID , serDAT_RV ,PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
IF (FIXED_SLAVE0_ADDR_EN_1 = 1) THEN
   cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serADR0_ID, (std_logic_vector(to_unsigned(FIXED_SLAVE0_ADDR_VALUE_1,7)) & '0'),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
ELSE
   cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serADR0_ID, serADR0_RV,PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
END IF;
IF (IPMI_EN_1 = 1) THEN
   cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSMB_ID, "00000000",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
ELSIF (SMB_EN_1 = 1) THEN
   cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSMB_ID, serSMB_RV,PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
END IF;
IF ((FIXED_SLAVE1_ADDR_EN_1 = 1) AND (ADD_SLAVE1_ADDRESS_EN_1 = 1)) THEN
   cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serADR1_ID, (std_logic_vector(to_unsigned(FIXED_SLAVE1_ADDR_VALUE_1,7)) & '0'),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
ELSE
   cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serADR1_ID, serADR1_RV,PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
END IF;

printf("\nEnable and Configure Addresses:\n");
cpu_wr(         PSEL_0,"0000" & serCON_ID, (cr210(2) & ens1 & not(sta) & not(sto) & not(si) & aa & cr210(1 downto 0)),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
cpu_rd(PRDATA_0,PSEL_0,"0000" & serCON_ID, (cr210(2) & ens1 & not(sta) & not(sto) & not(si) & aa & cr210(1 downto 0)) ,PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
--
cpu_wr(         PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) & serCON_ID, (cr210(2) & ens1 & not(sta) & not(sto) & not(si) & aa & cr210(1 downto 0)),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) & serCON_ID, (cr210(2) & ens1 & not(sta) & not(sto) & not(si) & aa & cr210(1 downto 0)) ,PCLK,PADDR,PWRITE,PENABLE,simerrorsv);

cpu_wr(         PSEL_0,"0000" & serADR0_ID, (I0_adr & not(GC)),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
--cpu_rd(PRDATA_0,PSEL_0,"0000" & serADR0_ID, (I0_adr & not(GC)),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);

IF (FIXED_SLAVE0_ADDR_EN_1 /= 1) THEN
   cpu_wr(         PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serADR0_ID, (I1_adr0 & NOT(GC)),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
--   cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serADR0_ID, (I1_adr0 & NOT(GC)),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
END IF;
--IF (FIXED_SLAVE0_ADDR_EN_1 = 1) THEN
--   cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serADR0_ID, (std_logic_vector(to_unsigned(FIXED_SLAVE0_ADDR_VALUE_1, 7)) & NOT(R_nW)),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
--END IF;
IF ((FIXED_SLAVE1_ADDR_EN_1 /= 1) AND (ADD_SLAVE1_ADDRESS_EN_1 = 1)) THEN
   cpu_wr(         PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serADR1_ID, (I1_adr1 & NOT(GC)),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
--   cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serADR1_ID, (I1_adr1 & NOT(GC)),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
END IF;
--IF ((FIXED_SLAVE1_ADDR_EN_1 = 1) AND (ADD_SLAVE1_ADDRESS_EN_1 = 1)) THEN
--   cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serADR1_ID, (std_logic_vector(to_unsigned(FIXED_SLAVE1_ADDR_VALUE_1, 7)) & NOT(R_nW)),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
--END IF;

--  first 8-bits to serDAT = Instance1 slave address value and R_nW bit.
IF (FIXED_SLAVE0_ADDR_EN_1 = 1) THEN
   cpu_wr(         PSEL_0,"0000" &  serDAT_ID, (std_logic_vector(to_unsigned(FIXED_SLAVE0_ADDR_VALUE_1, 7)) & NOT(R_nW)),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
   cpu_rd(PRDATA_0,PSEL_0,"0000" &  serDAT_ID, (std_logic_vector(to_unsigned(FIXED_SLAVE0_ADDR_VALUE_1,7)) & NOT(R_nW)),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
END IF;
IF (FIXED_SLAVE0_ADDR_EN_1 = 0) THEN
   cpu_wr(         PSEL_0,"0000" &  serDAT_ID, (I1_adr0 & NOT(R_nW)),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
   cpu_rd(PRDATA_0,PSEL_0,"0000" &  serDAT_ID, (I1_adr0 & NOT(R_nW)),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
END IF;

printf("\nInstance 0 MASTER:");
printf("     SEND START BIT: Wait For Interrupt...");
cpu_wr(         PSEL_0,"0000" &  serCON_ID, ((cr210(2)) & (ens1) & (sta) & (NOT(sto)) & (NOT(si)) & (aa) & cr210(1 DOWNTO 0)),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
      WHILE (INT_0(0) = '0') LOOP
         wait for ((SYS_CLK_CYCLE * 1 ns));
      END LOOP;

printf("\nInstance 0 MASTER:");
printf("     READ STATUS REGISTER AFTER INTERRUPT:  Check that Start Bit Has Been Sent (08)...");
      cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSTA_ID, x"08",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
printf("     CLEAR INTERRUPT:  Triggering Transmission of Instance1 SLAVE Write Request:");
      cpu_wr(         PSEL_0,"0000" &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
      WHILE (INT_0(0) = '0') LOOP
          wait for ((SYS_CLK_CYCLE * 1 ns));
      END LOOP;
printf("\nInstance 0 MASTER:");
printf("     READ STATUS REGISTER AFTER INTERRUPT:  Check that Instance0 Slave has been Addressed and ACK Returned (18)...");
      cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSTA_ID, x"18",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
printf("     WRITE DATA REGISTER:  Data Register contains byte to be Transmitted to Instance1 Slave...");
      cpu_wr(         PSEL_0,"0000" &  serDAT_ID, x"AE",PCLK,PADDR,PWDATA,PWRITE,PENABLE);
      cpu_rd(PRDATA_0,PSEL_0,"0000" &  serDAT_ID, x"AE",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
printf("     CLEAR INTERRUPT:  Triggering Transmission of 8-bit data to Instance1 WHEN Instance1 is Ready:");
      cpu_wr(         PSEL_0,"0000" &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
printf("\nInstance 1 SLAVE:");
printf("     READ STATUS REGISTER AFTER INTERRUPT:  Check that it has been Addressed for Writing to (60)...");
      WHILE (INT_1(I2C_NUM_1-1) = '0') LOOP
          wait for ((SYS_CLK_CYCLE * 1 ns));
      END LOOP;
      cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSTA_ID, x"60",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
      IF (FIXED_SLAVE0_ADDR_EN_1 = 1) THEN
         cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serDAT_ID, (std_logic_vector(to_unsigned(FIXED_SLAVE0_ADDR_VALUE_1, 7)) & (NOT(GC))),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
      END IF;
      IF (FIXED_SLAVE0_ADDR_EN_1 = 0) THEN
         cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serDAT_ID, ((I1_adr0) & (NOT(GC))),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
      END IF;
printf("     CLEAR INTERRUPT:  Triggering Transmission of 8-bit data from Instance0 now that Instance1 is Ready:");
      cpu_wr(         PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
printf("     READ STATUS REGISTER AFTER INTERRUPT:  Check that 8-bits of Data has been Received (80)...");
      WHILE (INT_1(I2C_NUM_1-1) = '0') LOOP
          wait for ((SYS_CLK_CYCLE * 1 ns));
      END LOOP;
      cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSTA_ID, x"80",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
printf("     READ DATA REGISTER:  Check the 8-bits of Received Data...");
      cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serDAT_ID, x"AE",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
printf("     CLEAR INTERRUPT:  Go to IDLE State:");
      cpu_wr(         PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
      WHILE (INT_0(0) = '0') LOOP
          wait for ((SYS_CLK_CYCLE * 1 ns));
      END LOOP;
printf("\nInstance 0 MASTER:");
printf("     READ STATUS REGISTER AFTER INTERRUPT:  Check that Data has been Sent (28):");
      cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSTA_ID, x"28",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
printf("     CLEAR INTERRUPT AND SEND STOP BIT:  Go to IDLE State:");
      cpu_wr(         PSEL_0,"0000" &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (sto) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
printf("     READ STATUS REGISTER:  Check that IDLE State has been Reached (F8)...");
      cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSTA_ID, x"F8",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
printf("\nInstance 1 SLAVE:");
printf("     READ STATUS REGISTER AFTER INTERRUPT:  Check that Stop Condition has been Detected (A0)...");
      WHILE (INT_1(I2C_NUM_1-1) = '0') LOOP
          wait for ((SYS_CLK_CYCLE * 1 ns));
      END LOOP;
      cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSTA_ID, x"a0",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
printf("     CLEAR INTERRUPT:  Go to IDLE State:");
      cpu_wr(         PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
printf("     READ STATUS REGISTER:  Check that IDLE State has been Reached (F8)...");
      cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSTA_ID, x"F8",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
      wait for ((SYS_CLK_CYCLE * 500 ns));

      
      
      IF ((IPMI_EN_1 = 1) OR (SMB_EN_1 = 1)) THEN
   printf("\nEnabling SMBus or IPMI...");
         cpu_wr(         PSEL_0,"0000" &  serSMB_ID, "10000111",PCLK,PADDR,PWDATA,PWRITE,PENABLE);
         --cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSMB_ID, "10100111",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
         cpu_wr(         PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSMB_ID, "00000111",PCLK,PADDR,PWDATA,PWRITE,PENABLE);
         IF (IPMI_EN_1 = 1) THEN
           cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSMB_ID, "00000100",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
         ELSIF (SMB_EN_1 = 1) THEN
           cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSMB_ID, "10000111",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
           cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSMB_ID, "00000111",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
           WHILE (SMBA_INT_0(0) = '0') LOOP
               wait for ((SYS_CLK_CYCLE * 1 ns));
           END LOOP;
           WHILE (SMBA_INT_1(I2C_NUM_1-1) = '0') LOOP
               wait for ((SYS_CLK_CYCLE * 1 ns));
           END LOOP;
           WHILE (SMBS_INT_0(0) = '0') LOOP
               wait for ((SYS_CLK_CYCLE * 1 ns));
           END LOOP;
           WHILE (SMBS_INT_1(I2C_NUM_1-1) = '0') LOOP
               wait for ((SYS_CLK_CYCLE * 1 ns));
           END LOOP;
           cpu_wr(         PSEL_0,"0000" &  serSMB_ID, "11111111",PCLK,PADDR,PWDATA,PWRITE,PENABLE);
           cpu_wr(         PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSMB_ID, "01111111",PCLK,PADDR,PWDATA,PWRITE,PENABLE);
           cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSMB_ID, "1111H111",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
           cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSMB_ID, "0111H111",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
           WHILE (SMBA_INT_0(0) = '1') LOOP
               wait for ((SYS_CLK_CYCLE * 1 ns));
           END LOOP;
           WHILE (SMBA_INT_1(I2C_NUM_1-1) = '1') LOOP
               wait for ((SYS_CLK_CYCLE * 1 ns));
           END LOOP;
           WHILE (SMBS_INT_0(0) = '1') LOOP
               wait for ((SYS_CLK_CYCLE * 1 ns));
           END LOOP;
           WHILE (SMBS_INT_1(I2C_NUM_1-1) = '1') LOOP
               wait for ((SYS_CLK_CYCLE * 1 ns));
           END LOOP;
         END IF;
   printf("     Checking Master Resetting Status...and Clear Interrupt");
         cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSTA_ID, x"d0",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
         cpu_wr(         PSEL_0,"0000" &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
         WHILE (INT_1(I2C_NUM_1-1) = '0') LOOP
             wait for ((SYS_CLK_CYCLE * 1 ns));
         END LOOP;
         IF (IPMI_EN_1 = 1) THEN
         nowv := NOW / 1 ns;
		 printf("\n     Time Check: %0d ns --> Using default TB values, time should be slightly greater than 3 ms for IPMI mode of Instance1\n",fmt(nowv));
            cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSTA_ID, x"d8",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
         ELSIF (SMB_EN_1 = 1) THEN
         nowv := NOW / 1 ns;
		 printf("\n     Time Check: %0d ns --> Using default TB Values, time Should be slightly greater than 25 ms for SMBus mode of Instance1\n",fmt(nowv));
            cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSTA_ID, x"d8",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
         END IF;
   printf("\nWait while INSTANCE0 SMBus Master holds SCL low for 35ms, automatically resetting INSTANCE1 SLAVE...");
         WHILE (INT_0(0) = '0') LOOP
             wait for ((SYS_CLK_CYCLE * 1 ns));
         END LOOP;
   printf("     Check Error Status has gone to Idle...");
         cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSTA_ID, x"f8",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
         cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSTA_ID, x"d8",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
   printf("     Clear Interrupts...");
         cpu_wr(         PSEL_0,"0000" &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
         cpu_wr(         PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
   printf("     Check Idle Status...");
         cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSTA_ID, x"f8",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
         cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSTA_ID, x"f8",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
      END IF;
      IF (ADD_SLAVE1_ADDRESS_EN_1 = 1) THEN
   printf("\n\n\nChecking 2nd Address Capability:");
         cpu_wr(         PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
         IF (FIXED_SLAVE1_ADDR_EN_1 = 1) THEN
            cpu_wr(         PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serADR1_ID, x"01",PCLK,PADDR,PWDATA,PWRITE,PENABLE);
            cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serADR1_ID, (std_logic_vector(to_unsigned(FIXED_SLAVE1_ADDR_VALUE_1,7)) & '1'),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
            cpu_wr(         PSEL_0,"0000" &  serDAT_ID, (std_logic_vector(to_unsigned(FIXED_SLAVE1_ADDR_VALUE_1,7)) & (NOT(R_nW))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
            cpu_rd(PRDATA_0,PSEL_0,"0000" &  serDAT_ID, (std_logic_vector(to_unsigned(FIXED_SLAVE1_ADDR_VALUE_1,7)) & (NOT(R_nW))),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
         END IF;
         IF (FIXED_SLAVE1_ADDR_EN_1 = 0) THEN
            cpu_wr(         PSEL_0,"0000" &  serDAT_ID, ((I1_adr1) & (NOT(R_nW))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
            cpu_rd(PRDATA_0,PSEL_0,"0000" &  serDAT_ID, ((I1_adr1) & (NOT(R_nW))),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
         END IF;
   printf("\nInstance 0 MASTER:");
   printf("     SEND START BIT: Wait For Interrupt...");
         cpu_wr(         PSEL_0,"0000" &  serCON_ID, ((cr210(2)) & (ens1) & (sta) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
--   printf("\n\tTime Check: %t DEBUG1\n", NOW);
         WHILE (INT_0(0) = '0') LOOP
             wait for ((SYS_CLK_CYCLE * 1 ns));
         END LOOP;
   printf("\nInstance 0 MASTER:");
   printf("     READ STATUS REGISTER AFTER INTERRUPT:  Check that Start Bit Has Been Sent (08)...");
         cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSTA_ID, x"08",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
   printf("     CLEAR INTERRUPT:  Triggering Transmission of Instance1 SLAVE Write Request:");
         cpu_wr(         PSEL_0,"0000" &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
         WHILE (INT_0(0) = '0') LOOP
             wait for ((SYS_CLK_CYCLE * 1 ns));
         END LOOP;
   printf("\nInstance 0 MASTER:");
   printf("     READ STATUS REGISTER AFTER INTERRUPT:  Check that Instance0 Slave has been Addressed and ACK Returned (18)...");
         cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSTA_ID, x"18",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
   printf("     WRITE DATA REGISTER:  Data Register contains byte to be Transmitted to Instance1 Slave...");
         cpu_wr(         PSEL_0,"0000" &  serDAT_ID, x"AE",PCLK,PADDR,PWDATA,PWRITE,PENABLE);
         cpu_rd(PRDATA_0,PSEL_0,"0000" &  serDAT_ID, x"AE",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
   printf("     CLEAR INTERRUPT:  Triggering Transmission of 8-bit data to Instance1 WHEN Instance1 is Ready:");
         cpu_wr(         PSEL_0,"0000" &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
   printf("\nInstance 1 SLAVE:");
   printf("     READ STATUS REGISTER AFTER INTERRUPT:  Check that it has been Addressed for Writing to (60)...");
         WHILE (INT_1(I2C_NUM_1-1) = '0') LOOP
             wait for ((SYS_CLK_CYCLE * 1 ns));
         END LOOP;
         cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSTA_ID, x"60",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
         IF (FIXED_SLAVE1_ADDR_EN_1 = 1) THEN
            cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serDAT_ID, (std_logic_vector(to_unsigned(FIXED_SLAVE1_ADDR_VALUE_1,7)) & (NOT(GC))),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
         END IF;
         IF (FIXED_SLAVE0_ADDR_EN_1 = 0) THEN
            cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serDAT_ID, ((I1_adr1) & (NOT(GC))),PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
         END IF;
   printf("     CLEAR INTERRUPT:  Triggering Transmission of 8-bit data from Instance0 now that Instance1 is Ready:");
         cpu_wr(         PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
   printf("     READ STATUS REGISTER AFTER INTERRUPT:  Check that 8-bits of Data has been Received (80)...");
         WHILE (INT_1(I2C_NUM_1-1) = '0') LOOP
             wait for ((SYS_CLK_CYCLE * 1 ns));
         END LOOP;
         cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSTA_ID, x"80",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
   printf("     READ DATA REGISTER:  Check the 8-bits of Received Data...");
         cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serDAT_ID, x"AE",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
   printf("     CLEAR INTERRUPT:  Go to IDLE State:");
         cpu_wr(         PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
         WHILE (INT_0(0) = '0') LOOP
             wait for ((SYS_CLK_CYCLE * 1 ns));
         END LOOP;
   printf("\nInstance 0 MASTER:");
   printf("     READ STATUS REGISTER AFTER INTERRUPT:  Check that Data has been Sent (28):");
         cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSTA_ID, x"28",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
   printf("     CLEAR INTERRUPT AND SEND STOP BIT:  Go to IDLE State:");
         cpu_wr(         PSEL_0,"0000" &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (sto) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
   printf("     READ STATUS REGISTER:  Check that IDLE State has been Reached (F8)...");
         cpu_rd(PRDATA_0,PSEL_0,"0000" &  serSTA_ID, x"F8",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
   printf("\nInstance 1 SLAVE:");
   printf("     READ STATUS REGISTER AFTER INTERRUPT:  Check that Stop Condition has been Detected (A0)...");
         WHILE (INT_1(I2C_NUM_1-1) = '0') LOOP
             wait for ((SYS_CLK_CYCLE * 1 ns));
         END LOOP;
         cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSTA_ID, x"a0",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
   printf("     CLEAR INTERRUPT:  Go to IDLE State:");
         cpu_wr(         PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serCON_ID, ((cr210(2)) & (ens1) & (NOT(sta)) & (NOT(sto)) & (NOT(si)) & (aa) & (cr210(1 DOWNTO 0))),PCLK,PADDR,PWDATA,PWRITE,PENABLE);
   printf("     READ STATUS REGISTER:  Check that IDLE State has been Reached (F8)...");
         cpu_rd(PRDATA_1,PSEL_1,(std_logic_vector(to_unsigned(I2C_NUM_1-1,4))) &  serSTA_ID, x"F8",PCLK,PADDR,PWRITE,PENABLE,simerrorsv);
         WAIT for ((SYS_CLK_CYCLE * 500 ns));
      END IF;
printf(" ");
printf(" ");
       wait for ((SYS_CLK_CYCLE * 100 ns));


simerrors <= simerrorsv;
WAIT UNTIL (PCLK'EVENT AND PCLK = '1');
printf(" ");

nowv := NOW / 1 ns;
printf("All tests complete at time %0d ns with:",fmt(nowv));
printf("%0d Errors.", fmt(simerrors));
printf(" ");
         ASSERT (FALSE) REPORT "ending simulation" SEVERITY WARNING;
	stopsim	<= true;
	wait;
   END PROCESS;


end behav;
