-- ********************************************************************/
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2014 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Project name         : COREI2C
-- Project description  : Inter-Integrated Circuit Bus Interface
--
-- File name            : corei2c.vhd
-- File contents        : wrapper for corei2creal
-- Purpose              : I2C Serial Channel
--
-- SVN Revision Information:
-- SVN $Revision: 29416 $
-- SVN $Date: 2017-03-24 13:10:59 +0530 (Fri, 24 Mar 2017) $  
-- 
--*******************************************************************--

--*******************************************************************--
library IEEE;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
   use IEEE.STD_LOGIC_1164.all;
   use IEEE.STD_LOGIC_UNSIGNED."+";
   use IEEE.STD_LOGIC_UNSIGNED."-";
   use IEEE.NUMERIC_STD.all;
   --use work.corei2c_pkg.all;
library COREI2C_LIB;


--*******************************************************************--
entity SF2_MSS_sys_sb_COREI2C_0_COREI2C is
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
      FIXED_SLAVE1_ADDR_VALUE    : INTEGER := 0;
      I2C_NUM					 : INTEGER := 1
	);
 port (
 	-- system globals
 	PCLK   		: in  STD_LOGIC;  -- Global clock input
 	PRESETN		: in  STD_LOGIC;  -- Global reset input
 	BCLK   		: in  STD_LOGIC;  --

 	-- Serial inputs
 	SCLI     	: in  STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);  -- serial clock input
 	SDAI     	: in  STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);  -- serial data input

 	-- APB register interface
 	PSEL      	: in  STD_LOGIC;
 	PENABLE    	: in  STD_LOGIC;
 	PWRITE    	: in  STD_LOGIC;
 	PADDR      	: in  STD_LOGIC_VECTOR(8 downto 0); -- data address
 	PWDATA     	: in  STD_LOGIC_VECTOR(7 downto 0); -- data input

 	-- Serial outputs
 	SCLO      	: out STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);  -- serial clock output - registered
 	SDAO      	: out STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);  -- serial data output  - registered

 	-- Interrupt flags
 	INT        	: out STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);  -- INT flag          - registered
    SMBA_INT   	: out STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);
    SMBS_INT   	: out STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);

 	-- APB register interface read
 	PRDATA     	: out STD_LOGIC_VECTOR(7 downto 0);  -- data output
 	-- SMBus Optional Signals
 	SMBALERT_NI	: in  STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);
 	SMBALERT_NO	: out STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);
 	SMBSUS_NI	: in  STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0);
 	SMBSUS_NO	: out STD_LOGIC_VECTOR(I2C_NUM-1 DOWNTO 0)
           );
end SF2_MSS_sys_sb_COREI2C_0_COREI2C;

--*******************************************************************--

architecture RTL of SF2_MSS_sys_sb_COREI2C_0_COREI2C is

  --CONSTANT SYNC_RESET : INTEGER := SYNC_MODE_SEL(FAMILY);
  
-- Log2
  function ceil_log2 (N : positive) return natural is
    variable tmp, res : integer;
  begin
    tmp:=1 ;
    res:=0;
    WHILE tmp < N LOOP
      tmp := tmp*2;
      res := res+1;
    END LOOP;
    return res;
  end ceil_log2;

component COREI2C_COREI2CREAL
   generic (
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
      FIXED_SLAVE1_ADDR_VALUE    : INTEGER := 0
              );
    port (
 	-- system globals
 	PCLK          : in  STD_LOGIC;  -- Global clock input
 	BCLKe         : in  STD_LOGIC;  --
    
    -- Internal reset signals
    aresetn		: in  STD_LOGIC;
    sresetn		: in  STD_LOGIC;

 	-- common logic signals for multiple channels
 	pulse_215us : in  STD_LOGIC;
 	seradr0		: in  STD_LOGIC_VECTOR(7 downto 0);
 	seradr1		: in  STD_LOGIC_VECTOR(7 downto 0);
 	seradr1apb0	: in  STD_LOGIC;

 	-- Serial inputs
 	SCLI         : in  STD_LOGIC;  -- serial clock input
 	SDAI         : in  STD_LOGIC;  -- serial data input

 	-- APB register interface
 	PSEL        : in  STD_LOGIC;
 	PENABLE        : in  STD_LOGIC;
 	PWRITE        : in  STD_LOGIC;
 	PADDR      : in  STD_LOGIC_VECTOR(4 downto 0); -- data address
 	PWDATA     : in  STD_LOGIC_VECTOR(7 downto 0); -- data input

 	-- Serial outputs
 	SCLO         : out STD_LOGIC;  -- serial clock output - registered
 	SDAO         : out STD_LOGIC;  -- serial data output  - registered

 	-- Interrupt flags
 	INT           : out STD_LOGIC;  -- INT flag          - registered
    SMBA_INT      : out STD_LOGIC;
    SMBS_INT      : out STD_LOGIC;

 	-- APB register interface read
 	PRDATA     : out STD_LOGIC_VECTOR(7 downto 0);  -- data output
 	-- SMBus Optional Signals
 	SMBALERT_NI: in  STD_LOGIC;
 	SMBALERT_NO: out STD_LOGIC;
 	SMBSUS_NI:   in  STD_LOGIC;
 	SMBSUS_NO:   out STD_LOGIC
           );
end component;

CONSTANT      serADR0_ID       : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01100";
CONSTANT      serADR0_RV       : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
CONSTANT      serADR1_ID       : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11100";
CONSTANT      serADR1_RV       : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";

CONSTANT term_cnt_215us : STD_LOGIC_VECTOR(ceil_log2(FREQUENCY * 215)-1 DOWNTO 0) :=  (std_logic_vector(to_unsigned((FREQUENCY * 215), ceil_log2(FREQUENCY * 215))));
SIGNAL term_cnt_215us_reg : STD_LOGIC_VECTOR(ceil_log2(FREQUENCY * 215)-1 DOWNTO 0);
SIGNAL pulse_215us	   : STD_LOGIC;
SIGNAL bclk_ff0        : STD_LOGIC; -- baud rate clock flip flop 0
SIGNAL bclk_ff         : STD_LOGIC; -- baud rate clock flip flop
SIGNAL bclke           : STD_LOGIC; -- baud rate clk edge detect
SIGNAL seradr0apb       : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL seradr0          : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL seradr1apb       : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL seradr1          : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL seradr1apb0		: STD_LOGIC;
type PRDATAi_ARRAY is ARRAY(0 TO I2C_NUM-1) of STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL PRDATAi          : PRDATAi_ARRAY;
type PSELi_ARRAY is ARRAY(0 TO I2C_NUM-1) of STD_LOGIC;
SIGNAL PSELi          : PSELi_ARRAY;

SIGNAL aresetn          : STD_LOGIC; -- Asynchronous reset signal   
SIGNAL sresetn          : STD_LOGIC; -- Synchronous reset signal  

begin

aresetn <= PRESETN;   --'1' WHEN (SYNC_RESET=1) ELSE PRESETN;
sresetn <= '1';       --PRESETN WHEN (SYNC_RESET=1) ELSE '1';

seradr1apb0 <= seradr1apb(0) WHEN ADD_SLAVE1_ADDRESS_EN = 1 ELSE
               '0';

--COMMON COUNTER LOGIC
   PROCESS (PCLK, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         term_cnt_215us_reg <= (others => '0');
      ELSIF (PCLK'EVENT AND PCLK = '1') THEN
        IF (sresetn = '0') THEN
            term_cnt_215us_reg <= (others => '0');
        ELSE
             IF (term_cnt_215us_reg = (std_logic_vector(to_unsigned(0,ceil_log2(FREQUENCY * 215))))) THEN
                term_cnt_215us_reg <= term_cnt_215us;
             ELSE
                term_cnt_215us_reg <= term_cnt_215us_reg - 1;
             END IF;
        END IF;
      END IF;
   END PROCESS;
   
   pulse_215us <= '1' WHEN (term_cnt_215us_reg = (std_logic_vector(to_unsigned(0,ceil_log2(FREQUENCY * 215))))) AND ((IPMI_EN = 1) OR (SMB_EN) = 1) ELSE
                  '0';


-----COMMON BCLK LOGIC
   --------------------------------------------------------------------
   -- BCLK edge detector
   --------------------------------------------------------------------
   BCLK_FF_PROC:
   --------------------------------------------------------------------
    PROCESS(PCLK,aresetn)
    BEGIN
        IF (aresetn = '0') THEN
            bclk_ff0 <= '1';
            bclk_ff  <= '1';
        ELSIF(PCLK'event and PCLK='1') THEN
            IF (sresetn = '0') THEN
                bclk_ff0 <= '1';
                bclk_ff  <= '1';
            ELSE
                -------------------------------------
                -- Synchronous write
                -------------------------------------
                bclk_ff0 <= BCLK;
                bclk_ff  <= bclk_ff0;
            END IF;
        END IF;
    END PROCESS;

   --------------------------------------------------------------------
   -- BCLK edge detector
   --------------------------------------------------------------------
   BCLKE_WRITE:
   --------------------------------------------------------------------
   BCLKe <= BCLK_ff0 AND NOT(BCLK_ff) WHEN BCLK_ENABLED = 1 ELSE
            '0'; -- rise edge

   --------------------------------------------------------------------
   -- seradr0 APB register
   --------------------------------------------------------------------
   serADR0_WRITE_PROCa:
   --------------------------------------------------------------------
   IF (FIXED_SLAVE0_ADDR_EN = 0) GENERATE
      PROCESS (PCLK, aresetn)
      BEGIN
         IF (aresetn = '0') THEN
            seradr0apb <= serADR0_RV;
         ELSIF (PCLK'EVENT AND PCLK = '1') THEN
            IF (sresetn = '0') THEN
                seradr0apb <= serADR0_RV;
            ELSE
                IF (((PENABLE AND PWRITE AND PSEL)) = '1' AND (PADDR(4 DOWNTO 0) = serADR0_ID)) THEN
                seradr0apb <= PWDATA;
                END IF;
            END IF;
         END IF;
      END PROCESS;
      seradr0 <= seradr0apb;
   END GENERATE;
   serADR0_WRITE_PROCb:
   IF (NOT(FIXED_SLAVE0_ADDR_EN = 0)) GENERATE
      seradr0 <= (std_logic_vector(to_unsigned(FIXED_SLAVE0_ADDR_VALUE, 7)) & '0');
   END GENERATE;

   --------------------------------------------------------------------
   -- seradr1 APB register
   --------------------------------------------------------------------
   serADR1_WRITE_PROCa:
   --------------------------------------------------------------------
   IF ((FIXED_SLAVE1_ADDR_EN = 0) AND (ADD_SLAVE1_ADDRESS_EN = 1)) GENERATE
      PROCESS (PCLK, aresetn)
      BEGIN
         IF (aresetn = '0') THEN
            seradr1apb <= serADR1_RV;
         ELSIF (PCLK'EVENT AND PCLK = '1') THEN
            IF (sresetn = '0') THEN
                seradr1apb <= serADR1_RV;
            ELSE
                IF (((PENABLE AND PWRITE AND PSEL)) = '1' AND (PADDR(4 DOWNTO 0) = serADR1_ID)) THEN
                    seradr1apb <= PWDATA;
                END IF;
            END IF;
         END IF;
      END PROCESS;
      seradr1 <= seradr1apb;
   END GENERATE;
   serADR1_WRITE_PROCb:
   IF ((FIXED_SLAVE1_ADDR_EN = 1) AND (ADD_SLAVE1_ADDRESS_EN = 1)) GENERATE
         PROCESS (PCLK, aresetn)
         BEGIN
            IF (aresetn = '0') THEN
               seradr1apb <= ("0000000" & serADR1_RV(0));
            ELSIF (PCLK'EVENT AND PCLK = '1') THEN
                IF (sresetn = '0') THEN
                    seradr1apb <= ("0000000" & serADR1_RV(0));
                ELSE
                    IF (((PENABLE AND PWRITE AND PSEL)) = '1' AND (PADDR(4 DOWNTO 0) = serADR1_ID)) THEN
                        seradr1apb <= ("0000000" & PWDATA(0));
                    END IF;
                END IF;
            END IF;
         END PROCESS;
         seradr1 <= (std_logic_vector(to_unsigned(FIXED_SLAVE1_ADDR_VALUE, 7)) & seradr1apb(0));
      END GENERATE;
   serADR1_WRITE_PROCc:
   IF (ADD_SLAVE1_ADDRESS_EN = 0) GENERATE
         seradr1 <= "00000000";
      END GENERATE;
            
G0a: FOR z IN 0 TO  (I2C_NUM - 1) GENERATE
ui2c : COREI2C_COREI2CREAL
            generic map (
      		--FAMILY                  => FAMILY                 ,
      		OPERATING_MODE          => OPERATING_MODE         ,
      		BAUD_RATE_FIXED         => BAUD_RATE_FIXED        ,
      		BAUD_RATE_VALUE         => BAUD_RATE_VALUE        ,
      		BCLK_ENABLED            => BCLK_ENABLED           ,
      		GLITCHREG_NUM           => GLITCHREG_NUM          ,
      		SMB_EN                  => SMB_EN                 ,
      		IPMI_EN                 => IPMI_EN                ,
      		FREQUENCY               => FREQUENCY              ,
      		FIXED_SLAVE0_ADDR_EN    => FIXED_SLAVE0_ADDR_EN   ,
      		FIXED_SLAVE0_ADDR_VALUE => FIXED_SLAVE0_ADDR_VALUE,
      		ADD_SLAVE1_ADDRESS_EN   => ADD_SLAVE1_ADDRESS_EN  ,
      		FIXED_SLAVE1_ADDR_EN    => FIXED_SLAVE1_ADDR_EN   ,
      		FIXED_SLAVE1_ADDR_VALUE => FIXED_SLAVE1_ADDR_VALUE
			                        )
            port map    (
            pulse_215us  => pulse_215us,
            seradr0      => seradr0,
            seradr1apb0  => seradr1apb0,
            seradr1      => seradr1,
            pclk         => PCLK,
            aresetn      => aresetn,
            sresetn      => sresetn,
            bclke        => BCLKe,
            scli         => SCLI(z),
            sdai         => SDAI(z),
            sclo         => SCLO(z),
            sdao         => SDAO(z),
            int          => INT(z),
            pwdata       => PWDATA,
            prdata       => PRDATAi(z),
            paddr        => PADDR(4 DOWNTO 0),
            psel         => PSELi(z),
            penable      => PENABLE,
            pwrite       => PWRITE,
            smbalert_ni  => SMBALERT_NI(z),
            smbalert_no  => SMBALERT_NO(z),
            smba_int     => SMBA_INT(z),
            smbsus_ni    => SMBSUS_NI(z),
            smbsus_no    => SMBSUS_NO(z),
            smbs_int     => SMBS_INT(z)
         );
   END GENERATE;
   
   
G0b:  FOR x IN 0 TO  (I2C_NUM - 1) GENERATE
      PSELi(x) <= '1' WHEN ((PSEL='1') AND (PADDR(8 DOWNTO 5) = (std_logic_vector(to_unsigned(x, 4))))) ELSE '0';
   END GENERATE;

G0c:  IF (I2C_NUM = 1) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
      
G0d:  IF (I2C_NUM = 2) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
      
G0e:  IF (I2C_NUM = 3) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN "0010" =>
               PRDATA <= PRDATAi(2);
            WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
      
G0f:  IF (I2C_NUM = 4) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN "0010" =>
               PRDATA <= PRDATAi(2);
            WHEN "0011" =>
               PRDATA <= PRDATAi(3);
            WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
      
G0g:  IF (I2C_NUM = 5) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN "0010" =>
               PRDATA <= PRDATAi(2);
            WHEN "0011" =>
               PRDATA <= PRDATAi(3);
            WHEN "0100" =>
               PRDATA <= PRDATAi(4);
            WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
      
G0h:  IF (I2C_NUM = 6) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN "0010" =>
               PRDATA <= PRDATAi(2);
            WHEN "0011" =>
               PRDATA <= PRDATAi(3);
            WHEN "0100" =>
               PRDATA <= PRDATAi(4);
            WHEN "0101" =>
               PRDATA <= PRDATAi(5);
             WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
      
G0i:  IF (I2C_NUM = 7) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN "0010" =>
               PRDATA <= PRDATAi(2);
            WHEN "0011" =>
               PRDATA <= PRDATAi(3);
            WHEN "0100" =>
               PRDATA <= PRDATAi(4);
            WHEN "0101" =>
               PRDATA <= PRDATAi(5);
            WHEN "0110" =>
               PRDATA <= PRDATAi(6);
           WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
      
G0j:  IF (I2C_NUM = 8) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN "0010" =>
               PRDATA <= PRDATAi(2);
            WHEN "0011" =>
               PRDATA <= PRDATAi(3);
            WHEN "0100" =>
               PRDATA <= PRDATAi(4);
            WHEN "0101" =>
               PRDATA <= PRDATAi(5);
            WHEN "0110" =>
               PRDATA <= PRDATAi(6);
            WHEN "0111" =>
               PRDATA <= PRDATAi(7);
            WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
      
G0k:  IF (I2C_NUM = 9) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN "0010" =>
               PRDATA <= PRDATAi(2);
            WHEN "0011" =>
               PRDATA <= PRDATAi(3);
            WHEN "0100" =>
               PRDATA <= PRDATAi(4);
            WHEN "0101" =>
               PRDATA <= PRDATAi(5);
            WHEN "0110" =>
               PRDATA <= PRDATAi(6);
            WHEN "0111" =>
               PRDATA <= PRDATAi(7);
            WHEN "1000" =>
               PRDATA <= PRDATAi(8);
            WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
      
G0l:  IF (I2C_NUM = 10) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN "0010" =>
               PRDATA <= PRDATAi(2);
            WHEN "0011" =>
               PRDATA <= PRDATAi(3);
            WHEN "0100" =>
               PRDATA <= PRDATAi(4);
            WHEN "0101" =>
               PRDATA <= PRDATAi(5);
            WHEN "0110" =>
               PRDATA <= PRDATAi(6);
            WHEN "0111" =>
               PRDATA <= PRDATAi(7);
            WHEN "1000" =>
               PRDATA <= PRDATAi(8);
            WHEN "1001" =>
               PRDATA <= PRDATAi(9);
            WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
      
G0m:  IF (I2C_NUM = 11) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN "0010" =>
               PRDATA <= PRDATAi(2);
            WHEN "0011" =>
               PRDATA <= PRDATAi(3);
            WHEN "0100" =>
               PRDATA <= PRDATAi(4);
            WHEN "0101" =>
               PRDATA <= PRDATAi(5);
            WHEN "0110" =>
               PRDATA <= PRDATAi(6);
            WHEN "0111" =>
               PRDATA <= PRDATAi(7);
            WHEN "1000" =>
               PRDATA <= PRDATAi(8);
            WHEN "1001" =>
               PRDATA <= PRDATAi(9);
            WHEN "1010" =>
               PRDATA <= PRDATAi(10);
            WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
     
G0n:  IF (I2C_NUM = 12) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN "0010" =>
               PRDATA <= PRDATAi(2);
            WHEN "0011" =>
               PRDATA <= PRDATAi(3);
            WHEN "0100" =>
               PRDATA <= PRDATAi(4);
            WHEN "0101" =>
               PRDATA <= PRDATAi(5);
            WHEN "0110" =>
               PRDATA <= PRDATAi(6);
            WHEN "0111" =>
               PRDATA <= PRDATAi(7);
            WHEN "1000" =>
               PRDATA <= PRDATAi(8);
            WHEN "1001" =>
               PRDATA <= PRDATAi(9);
            WHEN "1010" =>
               PRDATA <= PRDATAi(10);
            WHEN "1011" =>
               PRDATA <= PRDATAi(11);
            WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
      
G0o:  IF (I2C_NUM = 13) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN "0010" =>
               PRDATA <= PRDATAi(2);
            WHEN "0011" =>
               PRDATA <= PRDATAi(3);
            WHEN "0100" =>
               PRDATA <= PRDATAi(4);
            WHEN "0101" =>
               PRDATA <= PRDATAi(5);
            WHEN "0110" =>
               PRDATA <= PRDATAi(6);
            WHEN "0111" =>
               PRDATA <= PRDATAi(7);
            WHEN "1000" =>
               PRDATA <= PRDATAi(8);
            WHEN "1001" =>
               PRDATA <= PRDATAi(9);
            WHEN "1010" =>
               PRDATA <= PRDATAi(10);
            WHEN "1011" =>
               PRDATA <= PRDATAi(11);
            WHEN "1100" =>
               PRDATA <= PRDATAi(12);
            WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
      
G0p:  IF (I2C_NUM = 14) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN "0010" =>
               PRDATA <= PRDATAi(2);
            WHEN "0011" =>
               PRDATA <= PRDATAi(3);
            WHEN "0100" =>
               PRDATA <= PRDATAi(4);
            WHEN "0101" =>
               PRDATA <= PRDATAi(5);
            WHEN "0110" =>
               PRDATA <= PRDATAi(6);
            WHEN "0111" =>
               PRDATA <= PRDATAi(7);
            WHEN "1000" =>
               PRDATA <= PRDATAi(8);
            WHEN "1001" =>
               PRDATA <= PRDATAi(9);
            WHEN "1010" =>
               PRDATA <= PRDATAi(10);
            WHEN "1011" =>
               PRDATA <= PRDATAi(11);
            WHEN "1100" =>
               PRDATA <= PRDATAi(12);
            WHEN "1101" =>
               PRDATA <= PRDATAi(13);
            WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
      
G0q:  IF (I2C_NUM = 15) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN "0010" =>
               PRDATA <= PRDATAi(2);
            WHEN "0011" =>
               PRDATA <= PRDATAi(3);
            WHEN "0100" =>
               PRDATA <= PRDATAi(4);
            WHEN "0101" =>
               PRDATA <= PRDATAi(5);
            WHEN "0110" =>
               PRDATA <= PRDATAi(6);
            WHEN "0111" =>
               PRDATA <= PRDATAi(7);
            WHEN "1000" =>
               PRDATA <= PRDATAi(8);
            WHEN "1001" =>
               PRDATA <= PRDATAi(9);
            WHEN "1010" =>
               PRDATA <= PRDATAi(10);
            WHEN "1011" =>
               PRDATA <= PRDATAi(11);
            WHEN "1100" =>
               PRDATA <= PRDATAi(12);
            WHEN "1101" =>
               PRDATA <= PRDATAi(13);
            WHEN "1110" =>
               PRDATA <= PRDATAi(14);
            WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
      
G0r:  IF (I2C_NUM = 16) GENERATE
   PROCESS (PADDR(8 DOWNTO 5), PRDATAi)
      BEGIN
         CASE (PADDR(8 DOWNTO 5)) IS
            WHEN "0000" =>
               PRDATA <= PRDATAi(0);
            WHEN "0001" =>
               PRDATA <= PRDATAi(1);
            WHEN "0010" =>
               PRDATA <= PRDATAi(2);
            WHEN "0011" =>
               PRDATA <= PRDATAi(3);
            WHEN "0100" =>
               PRDATA <= PRDATAi(4);
            WHEN "0101" =>
               PRDATA <= PRDATAi(5);
            WHEN "0110" =>
               PRDATA <= PRDATAi(6);
            WHEN "0111" =>
               PRDATA <= PRDATAi(7);
            WHEN "1000" =>
               PRDATA <= PRDATAi(8);
            WHEN "1001" =>
               PRDATA <= PRDATAi(9);
            WHEN "1010" =>
               PRDATA <= PRDATAi(10);
            WHEN "1011" =>
               PRDATA <= PRDATAi(11);
            WHEN "1100" =>
               PRDATA <= PRDATAi(12);
            WHEN "1101" =>
               PRDATA <= PRDATAi(13);
            WHEN "1110" =>
               PRDATA <= PRDATAi(14);
            WHEN "1111" =>
               PRDATA <= PRDATAi(15);
            WHEN OTHERS =>
               PRDATA <= "00000000";
         END CASE;
      END PROCESS;
   END GENERATE;
   
   
end RTL;
--*******************************************************************--





