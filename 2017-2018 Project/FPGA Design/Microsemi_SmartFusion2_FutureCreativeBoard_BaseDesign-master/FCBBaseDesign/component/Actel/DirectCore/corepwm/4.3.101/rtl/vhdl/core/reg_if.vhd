--/******************************************************************************
--
--    File Name:  corepwm_reg_if.vhd
--      Version:  4.0
--         Date:  Jul 19th, 2009
--  Description:  Register Interface
--
--
-- SVN Revision Information:
-- SVN $Revision: 22653 $
-- SVN $Date: 2014-05-19 11:07:07 +0100 (Mon, 19 May 2014) $
--
--
--
-- COPYRIGHT 2009 BY ACTEL
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS
-- FROM ACTEL CORP.  IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM
-- ACTEL FOR USE OF THIS FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND
-- NO BACK-UP OF THE FILE SHOULD BE MADE.
--
--FUNCTIONAL DESCRIPTION:
--Refer to the CorePWM Handbook.
--******************************************************************************/

LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY corepwm_reg_if IS
   GENERIC ( SYNC_RESET            : INTEGER := 0;
             PWM_NUM               : INTEGER := 8;
             APB_DWIDTH            : INTEGER := 8;
             FIXED_PRESCALE_EN     : INTEGER := 0;
             FIXED_PRESCALE        : INTEGER := 8;
             FIXED_PERIOD_EN       : INTEGER := 0;
             FIXED_PERIOD          : INTEGER := 8;
             DAC_MODE              : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
             SHADOW_REG_EN         : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
             FIXED_PWM_POS_EN      : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
             FIXED_PWM_POSEDGE     : STD_LOGIC_VECTOR(511 DOWNTO 0):= (others => '0');
             FIXED_PWM_NEG_EN      : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
             FIXED_PWM_NEGEDGE     : STD_LOGIC_VECTOR(511 DOWNTO 0):= (others => '0')
      );
   PORT (
      PCLK                  : IN STD_LOGIC;
      PRESETN               : IN STD_LOGIC;
      PSEL                  : IN STD_LOGIC;
      PENABLE               : IN STD_LOGIC;
      PWRITE                : IN STD_LOGIC;
      PADDR                 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      PWDATA                : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      PWM_STRETCH           : IN STD_LOGIC_VECTOR(PWM_NUM - 1 DOWNTO 0);
      PRDATA_regif          : OUT STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      period_cnt            : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      sync_pulse            : IN STD_LOGIC;
      period_out_wire_o       : OUT STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      prescale_out_wire_o     : OUT STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      pwm_enable_out_wire_o   : OUT STD_LOGIC_VECTOR(PWM_NUM DOWNTO 1);
      pwm_posedge_out_wire_o  : OUT STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1);
      pwm_negedge_out_wire_o  : OUT STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1)
   );
END corepwm_reg_if;

ARCHITECTURE trans OF corepwm_reg_if IS

   CONSTANT all_ones      : STD_LOGIC_VECTOR(256 DOWNTO 0) := (others => '1');
   CONSTANT all_zeros     : STD_LOGIC_VECTOR(256 DOWNTO 0) := (others => '0');
   CONSTANT PREPEND       : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO PWM_NUM) := (others => '0');

   SIGNAL prescale_wire    : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL period_wire      : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);

   SIGNAL pwm_posedge_wire : STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1);
   SIGNAL pwm_negedge_wire : STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1);
   
   SIGNAL psh_prescale_reg        : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL psh_period_reg          : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL period_reg              : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL prescale_reg            : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL psh_enable_reg1         : STD_LOGIC_VECTOR(8 DOWNTO 1);
   SIGNAL psh_enable_reg2         : STD_LOGIC_VECTOR(16 DOWNTO 9);
   SIGNAL pwm_enable_reg          : STD_LOGIC_VECTOR(16 DOWNTO 1);
   SIGNAL psh_posedge_reg         : STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1);
   SIGNAL psh_negedge_reg         : STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1);
   SIGNAL pwm_posedge_reg         : STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1);
   SIGNAL pwm_negedge_reg         : STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1);
   SIGNAL period_out_wire         : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL prescale_out_wire       : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL pwm_enable_pre_out_wire : STD_LOGIC_VECTOR(16 DOWNTO 1);
   SIGNAL pwm_enable_out_wire     : STD_LOGIC_VECTOR(16 DOWNTO 1);
   SIGNAL pwm_posedge_out_wire    : STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1);
   SIGNAL pwm_negedge_out_wire    : STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1);
   SIGNAL PRDATA_typ              : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL PRDATA_generated        : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL sync_update             : STD_LOGIC;
   SIGNAL aresetn                 : STD_LOGIC;
   SIGNAL sresetn                 : STD_LOGIC;

BEGIN
aresetn <= '1' WHEN (SYNC_RESET=1) ELSE PRESETN;
sresetn <= PRESETN WHEN (SYNC_RESET=1) ELSE '1';
period_out_wire_o      <=period_out_wire     ;
prescale_out_wire_o    <=prescale_out_wire   ;
pwm_enable_pre_out_wire(16 DOWNTO 1)  <= (psh_enable_reg2 & psh_enable_reg1);
pwm_enable_out_wire_o(PWM_NUM DOWNTO 1)  <=pwm_enable_out_wire(PWM_NUM DOWNTO 1) ;
pwm_posedge_out_wire_o <=pwm_posedge_out_wire;
pwm_negedge_out_wire_o <=pwm_negedge_out_wire;
   PROCESS (aresetn, PCLK)
   BEGIN
      IF ((NOT(aresetn)) = '1') THEN
         psh_prescale_reg(3 downto 0) <= "1000";
         psh_prescale_reg((APB_DWIDTH-1) downto 4) <= (others => '0');
         psh_period_reg(3 downto 0) <= "1000";
         psh_period_reg((APB_DWIDTH-1) downto 4) <= (others => '0');
--         psh_prescale_reg <= (0 => '0', 1 => '0', 2 => '0', 3 => '1', others => '0');
--         psh_period_reg <= (0 => '0', 1 => '0', 2 => '0', 3 => '1', others => '0');
         psh_enable_reg1 <= (others => '0');
         psh_enable_reg2 <= (others => '0');
      ELSIF (PCLK'EVENT AND PCLK = '1') THEN
         IF ((NOT(sresetn)) = '1') THEN
            psh_prescale_reg(3 downto 0) <= "1000";
            psh_prescale_reg((APB_DWIDTH-1) downto 4) <= (others => '0');
            psh_period_reg(3 downto 0) <= "1000";
            psh_period_reg((APB_DWIDTH-1) downto 4) <= (others => '0');
--            psh_prescale_reg <= (0 => '0', 1 => '0', 2 => '0', 3 => '1', others => '0');
--            psh_period_reg <= (0 => '0', 1 => '0', 2 => '0', 3 => '1', others => '0');
            psh_enable_reg1 <= (others => '0');
            psh_enable_reg2 <= (others => '0');
	     ELSE
            IF ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1')) THEN
               CASE (PADDR) IS
                  WHEN "000000" =>
                     psh_prescale_reg <= PWDATA;
                  WHEN "000001" =>
                     psh_period_reg <= PWDATA;
                  WHEN "000010" =>
                     psh_enable_reg1 <= PWDATA(7 DOWNTO 0);
                  WHEN "000011" =>
                     psh_enable_reg2 <= PWDATA(7 DOWNTO 0);
                  WHEN OTHERS =>
                     NULL;
               END CASE;
            END IF;
         END IF;
      END IF;
   END PROCESS;

  -- Generate sync update for deadbanding
   PROCESS (aresetn, PCLK)
   BEGIN
      IF ((NOT(aresetn)) = '1') THEN
         sync_update <= '0';
      ELSIF (PCLK'EVENT AND PCLK = '1') THEN
         IF ((NOT(sresetn)) = '1') THEN
            sync_update <= '0';
         ELSE
            IF ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1')) THEN
               CASE PADDR IS
                  WHEN "111001" =>
                     sync_update <= PWDATA(0);
	          WHEN OTHERS =>
                     sync_update <= sync_update;
               END CASE;
            END IF;
         END IF;
      END IF;
   END PROCESS;


   G1: FOR h IN 1 TO  (PWM_NUM) GENERATE
      PROCESS (aresetn, PCLK)
      BEGIN
         IF ((NOT(aresetn)) = '1') THEN
            psh_posedge_reg(h * APB_DWIDTH DOWNTO (h - 1) * APB_DWIDTH + 1) <= (others => '0');
            psh_negedge_reg(h * APB_DWIDTH DOWNTO (h - 1) * APB_DWIDTH + 1) <= (others => '0');
         ELSIF (PCLK'EVENT AND PCLK = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN
               psh_posedge_reg(h * APB_DWIDTH DOWNTO (h - 1) * APB_DWIDTH + 1) <= (others => '0');
               psh_negedge_reg(h * APB_DWIDTH DOWNTO (h - 1) * APB_DWIDTH + 1) <= (others => '0');
		    ELSE
               IF ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1')) THEN
                 IF     (PADDR = std_logic_vector(to_unsigned(2+h*2, 6))) THEN
                              				psh_posedge_reg(h * APB_DWIDTH DOWNTO (h - 1) * APB_DWIDTH + 1) <= PWDATA(APB_DWIDTH-1 DOWNTO 0);
                 ELSIF  (PADDR = std_logic_vector(to_unsigned(3+h*2, 6))) THEN
                              				psh_negedge_reg(h * APB_DWIDTH DOWNTO (h - 1) * APB_DWIDTH + 1) <= PWDATA(APB_DWIDTH-1 DOWNTO 0);
                 END IF;
               END IF;
            END IF;
         END IF;
      END PROCESS;
   END GENERATE;

   G2: FOR i IN 1 TO  (PWM_NUM) GENERATE
      PROCESS (aresetn, PCLK)
      BEGIN
         IF ((NOT(aresetn)) = '1') THEN
            pwm_posedge_reg(i * APB_DWIDTH DOWNTO (i - 1) * APB_DWIDTH + 1) <= (others => '0');
            pwm_negedge_reg(i * APB_DWIDTH DOWNTO (i - 1) * APB_DWIDTH + 1) <= (others => '0');
         ELSIF (PCLK'EVENT AND PCLK = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN
               pwm_posedge_reg(i * APB_DWIDTH DOWNTO (i - 1) * APB_DWIDTH + 1) <= (others => '0');
               pwm_negedge_reg(i * APB_DWIDTH DOWNTO (i - 1) * APB_DWIDTH + 1) <= (others => '0');
		    ELSE
               IF ((period_cnt >= period_out_wire) AND (sync_pulse = '1') AND (sync_update = '1')) THEN
                  pwm_posedge_reg(i * APB_DWIDTH DOWNTO (i - 1) * APB_DWIDTH + 1) <= psh_posedge_reg(i * APB_DWIDTH DOWNTO (i - 1) * APB_DWIDTH + 1);
                  pwm_negedge_reg(i * APB_DWIDTH DOWNTO (i - 1) * APB_DWIDTH + 1) <= psh_negedge_reg(i * APB_DWIDTH DOWNTO (i - 1) * APB_DWIDTH + 1);
               END IF;
            END IF;
         END IF;
      END PROCESS;
   END GENERATE;

   G3: FOR j IN 1 TO  (PWM_NUM) GENERATE
		 G3a: IF (SHADOW_REG_EN(j - 1) = '1') GENERATE
            pwm_posedge_wire(j * APB_DWIDTH DOWNTO (j - 1) * APB_DWIDTH + 1) <= pwm_posedge_reg(j * APB_DWIDTH DOWNTO (j - 1) * APB_DWIDTH + 1);
            pwm_negedge_wire(j * APB_DWIDTH DOWNTO (j - 1) * APB_DWIDTH + 1) <= pwm_negedge_reg(j * APB_DWIDTH DOWNTO (j - 1) * APB_DWIDTH + 1);
         END GENERATE;
         G3b: IF (SHADOW_REG_EN(j - 1) = '0') GENERATE
            pwm_posedge_wire(j * APB_DWIDTH DOWNTO (j - 1) * APB_DWIDTH + 1) <= psh_posedge_reg(j * APB_DWIDTH DOWNTO (j - 1) * APB_DWIDTH + 1);
            pwm_negedge_wire(j * APB_DWIDTH DOWNTO (j - 1) * APB_DWIDTH + 1) <= psh_negedge_reg(j * APB_DWIDTH DOWNTO (j - 1) * APB_DWIDTH + 1);
         END GENERATE;
   END GENERATE;

   G4: FOR l IN 1 TO  (PWM_NUM) GENERATE
      G4a: IF (FIXED_PWM_POS_EN(l - 1) = '1') GENERATE
         pwm_posedge_out_wire(l * APB_DWIDTH DOWNTO (l - 1) * APB_DWIDTH + 1) <= FIXED_PWM_POSEDGE(l * APB_DWIDTH - 1 DOWNTO (l - 1) * APB_DWIDTH);
      END GENERATE;
      G4b: IF (FIXED_PWM_POS_EN(l - 1) = '0') GENERATE
         pwm_posedge_out_wire(l * APB_DWIDTH DOWNTO (l - 1) * APB_DWIDTH + 1) <= pwm_posedge_wire(l * APB_DWIDTH DOWNTO (l - 1) * APB_DWIDTH + 1);
      END GENERATE;
   END GENERATE;

   G5: FOR m IN 1 TO  (PWM_NUM) GENERATE
      G5a: IF (FIXED_PWM_NEG_EN(m - 1) = '1') GENERATE
         pwm_negedge_out_wire(m * APB_DWIDTH DOWNTO (m - 1) * APB_DWIDTH + 1) <= FIXED_PWM_NEGEDGE(m * APB_DWIDTH - 1 DOWNTO (m - 1) * APB_DWIDTH);
      END GENERATE;
      G5b: IF (FIXED_PWM_NEG_EN(m - 1) = '0') GENERATE
         pwm_negedge_out_wire(m * APB_DWIDTH DOWNTO (m - 1) * APB_DWIDTH + 1) <= pwm_negedge_wire(m * APB_DWIDTH DOWNTO (m - 1) * APB_DWIDTH + 1);
      END GENERATE;
   END GENERATE;

   PROCESS (aresetn, PCLK)
   BEGIN
      IF ((NOT(aresetn)) = '1') THEN
         prescale_reg(3 downto 0) <= "1000";
         prescale_reg((APB_DWIDTH-1) downto 4) <= (others => '0');
         period_reg(3 downto 0) <= "1000";
         period_reg((APB_DWIDTH-1) downto 4) <= (others => '0');
         pwm_enable_reg <= (others => '0');
      ELSIF (PCLK'EVENT AND PCLK = '1') THEN
         IF ((NOT(sresetn)) = '1') THEN
            prescale_reg(3 downto 0) <= "1000";
            prescale_reg((APB_DWIDTH-1) downto 4) <= (others => '0');
            period_reg(3 downto 0) <= "1000";
            period_reg((APB_DWIDTH-1) downto 4) <= (others => '0');
            pwm_enable_reg <= (others => '0');
	     ELSE
            IF ((period_cnt >= period_out_wire) AND ((sync_pulse)) = '1') THEN
               prescale_reg <= psh_prescale_reg;
               period_reg <= psh_period_reg;
               pwm_enable_reg <= (psh_enable_reg2 & psh_enable_reg1);
            END IF;
         END IF;
      END IF;
   END PROCESS;

   G7: FOR n IN 1 TO  (PWM_NUM) GENERATE
      G7a: IF (SHADOW_REG_EN(n - 1) = '1') GENERATE
  		pwm_enable_out_wire(n) <= pwm_enable_reg(n);
      END GENERATE;
      G7b: IF (SHADOW_REG_EN(n - 1) = '0') GENERATE
  		pwm_enable_out_wire(n) <= pwm_enable_pre_out_wire(n);
      END GENERATE;
   END GENERATE;
--   pwm_enable_out_wire <= pwm_enable_reg;
   prescale_wire <= prescale_reg;
   period_wire <= period_reg;

   prescale_out_wire <= std_logic_vector(to_unsigned(FIXED_PRESCALE, APB_DWIDTH)) WHEN std_logic_vector(to_unsigned(FIXED_PRESCALE_EN, 2)) = "01" ELSE
                        prescale_wire;
   period_out_wire <= std_logic_vector(to_unsigned(FIXED_PERIOD, APB_DWIDTH)) WHEN std_logic_vector(to_unsigned(FIXED_PERIOD_EN, 2)) = "01" ELSE
                      period_wire;



G60a: IF (APB_DWIDTH = 8) GENERATE
   PROCESS (PADDR, prescale_out_wire, period_out_wire, pwm_enable_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000000" =>
            PRDATA_typ <= prescale_out_wire;
         WHEN "000001" =>
            PRDATA_typ <= period_out_wire;
         WHEN "000010" =>
            PRDATA_typ(7 downto 0) <= pwm_enable_out_wire(8 downto 1);
         WHEN "000011" =>
            PRDATA_typ(7 downto 0) <= pwm_enable_out_wire(16 downto 9);
         WHEN OTHERS =>
            PRDATA_typ <= (others => '0');
      END CASE;
   END PROCESS;
END GENERATE;

G60b: IF (APB_DWIDTH > 8) GENERATE
   PROCESS (PADDR, prescale_out_wire, period_out_wire, pwm_enable_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000000" =>
            PRDATA_typ <= prescale_out_wire;
         WHEN "000001" =>
            PRDATA_typ <= period_out_wire;
         WHEN "000010" =>
            PRDATA_typ <= (all_zeros(APB_DWIDTH -1 DOWNTO 8) & pwm_enable_out_wire( 8 DOWNTO 1) );
         WHEN "000011" =>
            PRDATA_typ <= (all_zeros(APB_DWIDTH -1 DOWNTO 8) & pwm_enable_out_wire( 16 DOWNTO 9) );
         WHEN OTHERS =>
            PRDATA_typ <= (others => '0');
      END CASE;
   END PROCESS;
END GENERATE;

G61: IF (PWM_NUM <= 1) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
         WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;
      
G62: IF (PWM_NUM = 2) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
         WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

G63: IF (PWM_NUM = 3) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "001000" =>
            PRDATA_generated <= pwm_posedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001001" =>
            PRDATA_generated <= pwm_negedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
         WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

G64: IF (PWM_NUM = 4) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "001000" =>
            PRDATA_generated <= pwm_posedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001001" =>
            PRDATA_generated <= pwm_negedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001010" =>
            PRDATA_generated <= pwm_posedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001011" =>
            PRDATA_generated <= pwm_negedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
         WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

G65: IF (PWM_NUM = 5) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "001000" =>
            PRDATA_generated <= pwm_posedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001001" =>
            PRDATA_generated <= pwm_negedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001010" =>
            PRDATA_generated <= pwm_posedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001011" =>
            PRDATA_generated <= pwm_negedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001100" =>
            PRDATA_generated <= pwm_posedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001101" =>
            PRDATA_generated <= pwm_negedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
         WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

G66: IF (PWM_NUM = 6) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "001000" =>
            PRDATA_generated <= pwm_posedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001001" =>
            PRDATA_generated <= pwm_negedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001010" =>
            PRDATA_generated <= pwm_posedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001011" =>
            PRDATA_generated <= pwm_negedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001100" =>
            PRDATA_generated <= pwm_posedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001101" =>
            PRDATA_generated <= pwm_negedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001110" =>
            PRDATA_generated <= pwm_posedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "001111" =>
            PRDATA_generated <= pwm_negedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
         WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

G67: IF (PWM_NUM = 7) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "001000" =>
            PRDATA_generated <= pwm_posedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001001" =>
            PRDATA_generated <= pwm_negedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001010" =>
            PRDATA_generated <= pwm_posedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001011" =>
            PRDATA_generated <= pwm_negedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001100" =>
            PRDATA_generated <= pwm_posedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001101" =>
            PRDATA_generated <= pwm_negedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001110" =>
            PRDATA_generated <= pwm_posedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "001111" =>
            PRDATA_generated <= pwm_negedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "010000" =>
            PRDATA_generated <= pwm_posedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010001" =>
            PRDATA_generated <= pwm_negedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
        WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

G68: IF (PWM_NUM = 8) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "001000" =>
            PRDATA_generated <= pwm_posedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001001" =>
            PRDATA_generated <= pwm_negedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001010" =>
            PRDATA_generated <= pwm_posedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001011" =>
            PRDATA_generated <= pwm_negedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001100" =>
            PRDATA_generated <= pwm_posedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001101" =>
            PRDATA_generated <= pwm_negedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001110" =>
            PRDATA_generated <= pwm_posedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "001111" =>
            PRDATA_generated <= pwm_negedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "010000" =>
            PRDATA_generated <= pwm_posedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010001" =>
            PRDATA_generated <= pwm_negedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010010" =>
            PRDATA_generated <= pwm_posedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010011" =>
            PRDATA_generated <= pwm_negedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
         WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

G69: IF (PWM_NUM = 9) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "001000" =>
            PRDATA_generated <= pwm_posedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001001" =>
            PRDATA_generated <= pwm_negedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001010" =>
            PRDATA_generated <= pwm_posedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001011" =>
            PRDATA_generated <= pwm_negedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001100" =>
            PRDATA_generated <= pwm_posedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001101" =>
            PRDATA_generated <= pwm_negedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001110" =>
            PRDATA_generated <= pwm_posedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "001111" =>
            PRDATA_generated <= pwm_negedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "010000" =>
            PRDATA_generated <= pwm_posedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010001" =>
            PRDATA_generated <= pwm_negedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010010" =>
            PRDATA_generated <= pwm_posedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010011" =>
            PRDATA_generated <= pwm_negedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010100" =>
            PRDATA_generated <= pwm_posedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010101" =>
            PRDATA_generated <= pwm_negedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
         WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

G6a: IF (PWM_NUM = 10) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "001000" =>
            PRDATA_generated <= pwm_posedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001001" =>
            PRDATA_generated <= pwm_negedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001010" =>
            PRDATA_generated <= pwm_posedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001011" =>
            PRDATA_generated <= pwm_negedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001100" =>
            PRDATA_generated <= pwm_posedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001101" =>
            PRDATA_generated <= pwm_negedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001110" =>
            PRDATA_generated <= pwm_posedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "001111" =>
            PRDATA_generated <= pwm_negedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "010000" =>
            PRDATA_generated <= pwm_posedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010001" =>
            PRDATA_generated <= pwm_negedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010010" =>
            PRDATA_generated <= pwm_posedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010011" =>
            PRDATA_generated <= pwm_negedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010100" =>
            PRDATA_generated <= pwm_posedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010101" =>
            PRDATA_generated <= pwm_negedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010110" =>
            PRDATA_generated <= pwm_posedge_out_wire(10 * APB_DWIDTH DOWNTO 9 * APB_DWIDTH + 1);
         WHEN "010111" =>
            PRDATA_generated <= pwm_negedge_out_wire(10 * APB_DWIDTH DOWNTO 9 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
         WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

G6b: IF (PWM_NUM = 11) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "001000" =>
            PRDATA_generated <= pwm_posedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001001" =>
            PRDATA_generated <= pwm_negedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001010" =>
            PRDATA_generated <= pwm_posedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001011" =>
            PRDATA_generated <= pwm_negedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001100" =>
            PRDATA_generated <= pwm_posedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001101" =>
            PRDATA_generated <= pwm_negedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001110" =>
            PRDATA_generated <= pwm_posedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "001111" =>
            PRDATA_generated <= pwm_negedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "010000" =>
            PRDATA_generated <= pwm_posedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010001" =>
            PRDATA_generated <= pwm_negedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010010" =>
            PRDATA_generated <= pwm_posedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010011" =>
            PRDATA_generated <= pwm_negedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010100" =>
            PRDATA_generated <= pwm_posedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010101" =>
            PRDATA_generated <= pwm_negedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010110" =>
            PRDATA_generated <= pwm_posedge_out_wire(10 * APB_DWIDTH DOWNTO 9 * APB_DWIDTH + 1);
         WHEN "010111" =>
            PRDATA_generated <= pwm_negedge_out_wire(10 * APB_DWIDTH DOWNTO 9 * APB_DWIDTH + 1);
         WHEN "011000" =>
            PRDATA_generated <= pwm_posedge_out_wire(11 * APB_DWIDTH DOWNTO 10 * APB_DWIDTH + 1);
         WHEN "011001" =>
            PRDATA_generated <= pwm_negedge_out_wire(11 * APB_DWIDTH DOWNTO 10 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
         WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

G6c: IF (PWM_NUM = 12) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "001000" =>
            PRDATA_generated <= pwm_posedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001001" =>
            PRDATA_generated <= pwm_negedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001010" =>
            PRDATA_generated <= pwm_posedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001011" =>
            PRDATA_generated <= pwm_negedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001100" =>
            PRDATA_generated <= pwm_posedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001101" =>
            PRDATA_generated <= pwm_negedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001110" =>
            PRDATA_generated <= pwm_posedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "001111" =>
            PRDATA_generated <= pwm_negedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "010000" =>
            PRDATA_generated <= pwm_posedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010001" =>
            PRDATA_generated <= pwm_negedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010010" =>
            PRDATA_generated <= pwm_posedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010011" =>
            PRDATA_generated <= pwm_negedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010100" =>
            PRDATA_generated <= pwm_posedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010101" =>
            PRDATA_generated <= pwm_negedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010110" =>
            PRDATA_generated <= pwm_posedge_out_wire(10 * APB_DWIDTH DOWNTO 9 * APB_DWIDTH + 1);
         WHEN "010111" =>
            PRDATA_generated <= pwm_negedge_out_wire(10 * APB_DWIDTH DOWNTO 9 * APB_DWIDTH + 1);
         WHEN "011000" =>
            PRDATA_generated <= pwm_posedge_out_wire(11 * APB_DWIDTH DOWNTO 10 * APB_DWIDTH + 1);
         WHEN "011001" =>
            PRDATA_generated <= pwm_negedge_out_wire(11 * APB_DWIDTH DOWNTO 10 * APB_DWIDTH + 1);
         WHEN "011010" =>
            PRDATA_generated <= pwm_posedge_out_wire(12 * APB_DWIDTH DOWNTO 11 * APB_DWIDTH + 1);
         WHEN "011011" =>
            PRDATA_generated <= pwm_negedge_out_wire(12 * APB_DWIDTH DOWNTO 11 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
        WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

G6d: IF (PWM_NUM = 13) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "001000" =>
            PRDATA_generated <= pwm_posedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001001" =>
            PRDATA_generated <= pwm_negedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001010" =>
            PRDATA_generated <= pwm_posedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001011" =>
            PRDATA_generated <= pwm_negedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001100" =>
            PRDATA_generated <= pwm_posedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001101" =>
            PRDATA_generated <= pwm_negedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001110" =>
            PRDATA_generated <= pwm_posedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "001111" =>
            PRDATA_generated <= pwm_negedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "010000" =>
            PRDATA_generated <= pwm_posedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010001" =>
            PRDATA_generated <= pwm_negedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010010" =>
            PRDATA_generated <= pwm_posedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010011" =>
            PRDATA_generated <= pwm_negedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010100" =>
            PRDATA_generated <= pwm_posedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010101" =>
            PRDATA_generated <= pwm_negedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010110" =>
            PRDATA_generated <= pwm_posedge_out_wire(10 * APB_DWIDTH DOWNTO 9 * APB_DWIDTH + 1);
         WHEN "010111" =>
            PRDATA_generated <= pwm_negedge_out_wire(10 * APB_DWIDTH DOWNTO 9 * APB_DWIDTH + 1);
         WHEN "011000" =>
            PRDATA_generated <= pwm_posedge_out_wire(11 * APB_DWIDTH DOWNTO 10 * APB_DWIDTH + 1);
         WHEN "011001" =>
            PRDATA_generated <= pwm_negedge_out_wire(11 * APB_DWIDTH DOWNTO 10 * APB_DWIDTH + 1);
         WHEN "011010" =>
            PRDATA_generated <= pwm_posedge_out_wire(12 * APB_DWIDTH DOWNTO 11 * APB_DWIDTH + 1);
         WHEN "011011" =>
            PRDATA_generated <= pwm_negedge_out_wire(12 * APB_DWIDTH DOWNTO 11 * APB_DWIDTH + 1);
         WHEN "011100" =>
            PRDATA_generated <= pwm_posedge_out_wire(13 * APB_DWIDTH DOWNTO 12 * APB_DWIDTH + 1);
         WHEN "011101" =>
            PRDATA_generated <= pwm_negedge_out_wire(13 * APB_DWIDTH DOWNTO 12 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
         WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

G6e: IF (PWM_NUM = 14) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "001000" =>
            PRDATA_generated <= pwm_posedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001001" =>
            PRDATA_generated <= pwm_negedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001010" =>
            PRDATA_generated <= pwm_posedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001011" =>
            PRDATA_generated <= pwm_negedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001100" =>
            PRDATA_generated <= pwm_posedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001101" =>
            PRDATA_generated <= pwm_negedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001110" =>
            PRDATA_generated <= pwm_posedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "001111" =>
            PRDATA_generated <= pwm_negedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "010000" =>
            PRDATA_generated <= pwm_posedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010001" =>
            PRDATA_generated <= pwm_negedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010010" =>
            PRDATA_generated <= pwm_posedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010011" =>
            PRDATA_generated <= pwm_negedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010100" =>
            PRDATA_generated <= pwm_posedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010101" =>
            PRDATA_generated <= pwm_negedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010110" =>
            PRDATA_generated <= pwm_posedge_out_wire(10 * APB_DWIDTH DOWNTO 9 * APB_DWIDTH + 1);
         WHEN "010111" =>
            PRDATA_generated <= pwm_negedge_out_wire(10 * APB_DWIDTH DOWNTO 9 * APB_DWIDTH + 1);
         WHEN "011000" =>
            PRDATA_generated <= pwm_posedge_out_wire(11 * APB_DWIDTH DOWNTO 10 * APB_DWIDTH + 1);
         WHEN "011001" =>
            PRDATA_generated <= pwm_negedge_out_wire(11 * APB_DWIDTH DOWNTO 10 * APB_DWIDTH + 1);
         WHEN "011010" =>
            PRDATA_generated <= pwm_posedge_out_wire(12 * APB_DWIDTH DOWNTO 11 * APB_DWIDTH + 1);
         WHEN "011011" =>
            PRDATA_generated <= pwm_negedge_out_wire(12 * APB_DWIDTH DOWNTO 11 * APB_DWIDTH + 1);
         WHEN "011100" =>
            PRDATA_generated <= pwm_posedge_out_wire(13 * APB_DWIDTH DOWNTO 12 * APB_DWIDTH + 1);
         WHEN "011101" =>
            PRDATA_generated <= pwm_negedge_out_wire(13 * APB_DWIDTH DOWNTO 12 * APB_DWIDTH + 1);
         WHEN "011110" =>
            PRDATA_generated <= pwm_posedge_out_wire(14 * APB_DWIDTH DOWNTO 13 * APB_DWIDTH + 1);
         WHEN "011111" =>
            PRDATA_generated <= pwm_negedge_out_wire(14 * APB_DWIDTH DOWNTO 13 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
         WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

G6f: IF (PWM_NUM = 15) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "001000" =>
            PRDATA_generated <= pwm_posedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001001" =>
            PRDATA_generated <= pwm_negedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001010" =>
            PRDATA_generated <= pwm_posedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001011" =>
            PRDATA_generated <= pwm_negedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001100" =>
            PRDATA_generated <= pwm_posedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001101" =>
            PRDATA_generated <= pwm_negedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001110" =>
            PRDATA_generated <= pwm_posedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "001111" =>
            PRDATA_generated <= pwm_negedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "010000" =>
            PRDATA_generated <= pwm_posedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010001" =>
            PRDATA_generated <= pwm_negedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010010" =>
            PRDATA_generated <= pwm_posedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010011" =>
            PRDATA_generated <= pwm_negedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010100" =>
            PRDATA_generated <= pwm_posedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010101" =>
            PRDATA_generated <= pwm_negedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010110" =>
            PRDATA_generated <= pwm_posedge_out_wire(10 * APB_DWIDTH DOWNTO 9 * APB_DWIDTH + 1);
         WHEN "010111" =>
            PRDATA_generated <= pwm_negedge_out_wire(10 * APB_DWIDTH DOWNTO 9 * APB_DWIDTH + 1);
         WHEN "011000" =>
            PRDATA_generated <= pwm_posedge_out_wire(11 * APB_DWIDTH DOWNTO 10 * APB_DWIDTH + 1);
         WHEN "011001" =>
            PRDATA_generated <= pwm_negedge_out_wire(11 * APB_DWIDTH DOWNTO 10 * APB_DWIDTH + 1);
         WHEN "011010" =>
            PRDATA_generated <= pwm_posedge_out_wire(12 * APB_DWIDTH DOWNTO 11 * APB_DWIDTH + 1);
         WHEN "011011" =>
            PRDATA_generated <= pwm_negedge_out_wire(12 * APB_DWIDTH DOWNTO 11 * APB_DWIDTH + 1);
         WHEN "011100" =>
            PRDATA_generated <= pwm_posedge_out_wire(13 * APB_DWIDTH DOWNTO 12 * APB_DWIDTH + 1);
         WHEN "011101" =>
            PRDATA_generated <= pwm_negedge_out_wire(13 * APB_DWIDTH DOWNTO 12 * APB_DWIDTH + 1);
         WHEN "011110" =>
            PRDATA_generated <= pwm_posedge_out_wire(14 * APB_DWIDTH DOWNTO 13 * APB_DWIDTH + 1);
         WHEN "011111" =>
            PRDATA_generated <= pwm_negedge_out_wire(14 * APB_DWIDTH DOWNTO 13 * APB_DWIDTH + 1);
         WHEN "100000" =>
            PRDATA_generated <= pwm_posedge_out_wire(15 * APB_DWIDTH DOWNTO 14 * APB_DWIDTH + 1);
         WHEN "100001" =>
            PRDATA_generated <= pwm_negedge_out_wire(15 * APB_DWIDTH DOWNTO 14 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
         WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

G610: IF (PWM_NUM >= 16) GENERATE
   PROCESS (PADDR, pwm_posedge_out_wire, pwm_negedge_out_wire)
   BEGIN
      CASE (PADDR) IS
         WHEN "000100" =>
            PRDATA_generated <= pwm_posedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000101" =>
            PRDATA_generated <= pwm_negedge_out_wire(1 * APB_DWIDTH DOWNTO 0 * APB_DWIDTH + 1);
         WHEN "000110" =>
            PRDATA_generated <= pwm_posedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "000111" =>
            PRDATA_generated <= pwm_negedge_out_wire(2 * APB_DWIDTH DOWNTO 1 * APB_DWIDTH + 1);
         WHEN "001000" =>
            PRDATA_generated <= pwm_posedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001001" =>
            PRDATA_generated <= pwm_negedge_out_wire(3 * APB_DWIDTH DOWNTO 2 * APB_DWIDTH + 1);
         WHEN "001010" =>
            PRDATA_generated <= pwm_posedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001011" =>
            PRDATA_generated <= pwm_negedge_out_wire(4 * APB_DWIDTH DOWNTO 3 * APB_DWIDTH + 1);
         WHEN "001100" =>
            PRDATA_generated <= pwm_posedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001101" =>
            PRDATA_generated <= pwm_negedge_out_wire(5 * APB_DWIDTH DOWNTO 4 * APB_DWIDTH + 1);
         WHEN "001110" =>
            PRDATA_generated <= pwm_posedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "001111" =>
            PRDATA_generated <= pwm_negedge_out_wire(6 * APB_DWIDTH DOWNTO 5 * APB_DWIDTH + 1);
         WHEN "010000" =>
            PRDATA_generated <= pwm_posedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010001" =>
            PRDATA_generated <= pwm_negedge_out_wire(7 * APB_DWIDTH DOWNTO 6 * APB_DWIDTH + 1);
         WHEN "010010" =>
            PRDATA_generated <= pwm_posedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010011" =>
            PRDATA_generated <= pwm_negedge_out_wire(8 * APB_DWIDTH DOWNTO 7 * APB_DWIDTH + 1);
         WHEN "010100" =>
            PRDATA_generated <= pwm_posedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010101" =>
            PRDATA_generated <= pwm_negedge_out_wire(9 * APB_DWIDTH DOWNTO 8 * APB_DWIDTH + 1);
         WHEN "010110" =>
            PRDATA_generated <= pwm_posedge_out_wire(10 * APB_DWIDTH DOWNTO 9 * APB_DWIDTH + 1);
         WHEN "010111" =>
            PRDATA_generated <= pwm_negedge_out_wire(10 * APB_DWIDTH DOWNTO 9 * APB_DWIDTH + 1);
         WHEN "011000" =>
            PRDATA_generated <= pwm_posedge_out_wire(11 * APB_DWIDTH DOWNTO 10 * APB_DWIDTH + 1);
         WHEN "011001" =>
            PRDATA_generated <= pwm_negedge_out_wire(11 * APB_DWIDTH DOWNTO 10 * APB_DWIDTH + 1);
         WHEN "011010" =>
            PRDATA_generated <= pwm_posedge_out_wire(12 * APB_DWIDTH DOWNTO 11 * APB_DWIDTH + 1);
         WHEN "011011" =>
            PRDATA_generated <= pwm_negedge_out_wire(12 * APB_DWIDTH DOWNTO 11 * APB_DWIDTH + 1);
         WHEN "011100" =>
            PRDATA_generated <= pwm_posedge_out_wire(13 * APB_DWIDTH DOWNTO 12 * APB_DWIDTH + 1);
         WHEN "011101" =>
            PRDATA_generated <= pwm_negedge_out_wire(13 * APB_DWIDTH DOWNTO 12 * APB_DWIDTH + 1);
         WHEN "011110" =>
            PRDATA_generated <= pwm_posedge_out_wire(14 * APB_DWIDTH DOWNTO 13 * APB_DWIDTH + 1);
         WHEN "011111" =>
            PRDATA_generated <= pwm_negedge_out_wire(14 * APB_DWIDTH DOWNTO 13 * APB_DWIDTH + 1);
         WHEN "100000" =>
            PRDATA_generated <= pwm_posedge_out_wire(15 * APB_DWIDTH DOWNTO 14 * APB_DWIDTH + 1);
         WHEN "100001" =>
            PRDATA_generated <= pwm_negedge_out_wire(15 * APB_DWIDTH DOWNTO 14 * APB_DWIDTH + 1);
         WHEN "100010" =>
            PRDATA_generated <= pwm_posedge_out_wire(16 * APB_DWIDTH DOWNTO 15 * APB_DWIDTH + 1);
         WHEN "100011" =>
            PRDATA_generated <= pwm_negedge_out_wire(16 * APB_DWIDTH DOWNTO 15 * APB_DWIDTH + 1);
	 WHEN "100100" =>
               PRDATA_generated <= (PREPEND & PWM_STRETCH(PWM_NUM - 1 DOWNTO 0));
         WHEN OTHERS =>
            PRDATA_generated <= (others => '0');
      END CASE;
   END PROCESS;
      END GENERATE;

   -- APB Read data for sync update register
   xhdl27 : IF (APB_DWIDTH = 32) GENERATE
      PRDATA_regif <= PRDATA_typ WHEN (PADDR <= "000011") ELSE
                      ("0000000000000000000000000000000" & sync_update) WHEN (PADDR = "111001") ELSE
                      PRDATA_generated;
   END GENERATE;
   xhdl28 : IF (NOT(APB_DWIDTH = 32)) GENERATE
      xhdl29 : IF (APB_DWIDTH = 16) GENERATE
         PRDATA_regif <= PRDATA_typ WHEN (PADDR <= "000011") ELSE
                         ("000000000000000" & sync_update) WHEN (PADDR = "111001") ELSE
                         PRDATA_generated;
      END GENERATE;
      xhdl30 : IF ((NOT(APB_DWIDTH = 16)) AND (NOT(APB_DWIDTH = 32))) GENERATE
         PRDATA_regif <= PRDATA_typ WHEN (PADDR <= "000011") ELSE
                         ("0000000" & sync_update) WHEN (PADDR = "111001") ELSE
                         PRDATA_generated;
      END GENERATE;
   END GENERATE;
   

END trans;


