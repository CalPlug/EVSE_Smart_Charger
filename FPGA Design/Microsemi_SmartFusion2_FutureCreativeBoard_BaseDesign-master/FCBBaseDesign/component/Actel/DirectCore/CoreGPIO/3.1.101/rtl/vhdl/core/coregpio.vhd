-- ********************************************************************/ 
-- Actel Corporation Proprietary and Confidential
-- Copyright 2007 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
--  
-- Description: CoreGPIO
--                      
--
-- Revision Information:
-- Date     Description
-- Mar09  Initial Release 
--
-- SVN Revision Information:
-- SVN $Revision:  $
-- SVN $Date $
--

LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;
   
LIBRARY work;
   USE work.coregpio_pkg.all;

ENTITY CoreGPIO IS
  GENERIC (
    FAMILY    : INTEGER RANGE 0 TO 63:= 17;
    IO_NUM    : INTEGER RANGE 1 TO 32 := 32;
    APB_WIDTH : INTEGER RANGE 8 TO 32 := 32;
    OE_TYPE : INTEGER RANGE 0 TO 1 := 0;
    INT_BUS : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_0 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_1 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_2 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_3 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_4 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_5 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_6 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_7 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_8 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_9 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_10 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_11 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_12 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_13 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_14 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_15 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_16 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_17 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_18 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_19 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_20 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_21 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_22 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_23 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_24 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_25 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_26 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_27 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_28 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_29 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_30 : INTEGER RANGE 0 TO 1 := 0;
    FIXED_CONFIG_31 : INTEGER RANGE 0 TO 1 := 0;
    IO_TYPE_0 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_1 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_2 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_3 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_4 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_5 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_6 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_7 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_8 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_9 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_10 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_11 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_12 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_13 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_14 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_15 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_16 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_17 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_18 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_19 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_20 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_21 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_22 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_23 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_24 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_25 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_26 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_27 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_28 : INTEGER RANGE 0 TO 2 := 0;  
    IO_TYPE_29 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_30 : INTEGER RANGE 0 TO 2 := 0;
    IO_TYPE_31 : INTEGER RANGE 0 TO 2 := 0;
    IO_INT_TYPE_0 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_1 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_2 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_3 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_4 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_5 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_6 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_7 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_8 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_9 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_10 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_11 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_12 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_13 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_14 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_15 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_16 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_17 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_18 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_19 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_20 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_21 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_22 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_23 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_24 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_25 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_26 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_27 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_28 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_29 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_30 : INTEGER RANGE 0 TO 7 := 0;
    IO_INT_TYPE_31 : INTEGER RANGE 0 TO 7 := 0;
    IO_VAL_0  : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_1  : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_2  : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_3  : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_4  : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_5  : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_6  : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_7  : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_8  : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_9  : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_10 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_11 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_12 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_13 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_14 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_15 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_16 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_17 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_18 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_19 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_20 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_21 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_22 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_23 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_24 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_25 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_26 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_27 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_28 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_29 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_30 : INTEGER RANGE 0 TO 1 := 0;
    IO_VAL_31 : INTEGER RANGE 0 TO 1 := 0
  );
  PORT (
    PRESETN   : IN STD_LOGIC;
    PCLK      : IN STD_LOGIC;
    PSEL      : IN STD_LOGIC;
    PENABLE   : IN STD_LOGIC;
    PWRITE    : IN STD_LOGIC;
    PSLVERR   : OUT STD_LOGIC;
    PREADY    : OUT STD_LOGIC;
    PADDR     : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    PWDATA    : IN STD_LOGIC_VECTOR(APB_WIDTH-1 DOWNTO 0);
    PRDATA    : OUT STD_LOGIC_VECTOR(APB_WIDTH-1 DOWNTO 0);
    INT       : OUT STD_LOGIC_VECTOR(IO_NUM-1 DOWNTO 0);
    INT_OR    : OUT STD_LOGIC;
    GPIO_IN   : IN STD_LOGIC_VECTOR(IO_NUM-1 DOWNTO 0);
    GPIO_OUT  : OUT STD_LOGIC_VECTOR(IO_NUM-1 DOWNTO 0);
    GPIO_OE   : OUT STD_LOGIC_VECTOR(IO_NUM-1 DOWNTO 0)
  );
END ENTITY CoreGPIO;

ARCHITECTURE RTL OF CoreGPIO IS
  -- ----------------------------------------------------------------------
  -- CONSTANTS
  -- ----------------------------------------------------------------------
  -- FIXED_CONFIG
  -- 1 = FIXED
  -- 0 = REGISTER-CONTROLLED
  CONSTANT FIXED_CONFIG : STD_LOGIC_VECTOR(0 TO 31) := (
    int2slv(FIXED_CONFIG_0 ,1) &
    int2slv(FIXED_CONFIG_1 ,1) &
    int2slv(FIXED_CONFIG_2 ,1) &
    int2slv(FIXED_CONFIG_3 ,1) &
    int2slv(FIXED_CONFIG_4 ,1) &
    int2slv(FIXED_CONFIG_5 ,1) &
    int2slv(FIXED_CONFIG_6 ,1) &
    int2slv(FIXED_CONFIG_7 ,1) &
    int2slv(FIXED_CONFIG_8 ,1) &
    int2slv(FIXED_CONFIG_9 ,1) &
    int2slv(FIXED_CONFIG_10,1) &
    int2slv(FIXED_CONFIG_11,1) &
    int2slv(FIXED_CONFIG_12,1) &
    int2slv(FIXED_CONFIG_13,1) &
    int2slv(FIXED_CONFIG_14,1) &
    int2slv(FIXED_CONFIG_15,1) &
    int2slv(FIXED_CONFIG_16,1) &
    int2slv(FIXED_CONFIG_17,1) &
    int2slv(FIXED_CONFIG_18,1) &
    int2slv(FIXED_CONFIG_19,1) &
    int2slv(FIXED_CONFIG_20,1) &
    int2slv(FIXED_CONFIG_21,1) &
    int2slv(FIXED_CONFIG_22,1) &
    int2slv(FIXED_CONFIG_23,1) &
    int2slv(FIXED_CONFIG_24,1) &
    int2slv(FIXED_CONFIG_25,1) &
    int2slv(FIXED_CONFIG_26,1) &
    int2slv(FIXED_CONFIG_27,1) &
    int2slv(FIXED_CONFIG_28,1) &
    int2slv(FIXED_CONFIG_29,1) &
    int2slv(FIXED_CONFIG_30,1) &
    int2slv(FIXED_CONFIG_31,1));

  -- IO_INT_TYPE
  -- 3'b000 = LEVEL HIGH
  -- 3'b001 = LEVEL LOW
  -- 3'b010 = EDGE POS
  -- 3'b011 = EDGE_NEG
  -- 3'b100 = EDGE_BOTH
  -- 3'b111 = DISABLED
  CONSTANT IO_INT_TYPE : STD_LOGIC_VECTOR(0 TO 95) := (
    int2slv(IO_INT_TYPE_0 ,3) &
    int2slv(IO_INT_TYPE_1 ,3) &
    int2slv(IO_INT_TYPE_2 ,3) &
    int2slv(IO_INT_TYPE_3 ,3) &
    int2slv(IO_INT_TYPE_4 ,3) &
    int2slv(IO_INT_TYPE_5 ,3) &
    int2slv(IO_INT_TYPE_6 ,3) &
    int2slv(IO_INT_TYPE_7 ,3) &
    int2slv(IO_INT_TYPE_8 ,3) &
    int2slv(IO_INT_TYPE_9 ,3) &
    int2slv(IO_INT_TYPE_10,3) &
    int2slv(IO_INT_TYPE_11,3) &
    int2slv(IO_INT_TYPE_12,3) &
    int2slv(IO_INT_TYPE_13,3) &
    int2slv(IO_INT_TYPE_14,3) &
    int2slv(IO_INT_TYPE_15,3) &
    int2slv(IO_INT_TYPE_16,3) &
    int2slv(IO_INT_TYPE_17,3) &
    int2slv(IO_INT_TYPE_18,3) &
    int2slv(IO_INT_TYPE_19,3) &
    int2slv(IO_INT_TYPE_20,3) &
    int2slv(IO_INT_TYPE_21,3) &
    int2slv(IO_INT_TYPE_22,3) &
    int2slv(IO_INT_TYPE_23,3) &
    int2slv(IO_INT_TYPE_24,3) &
    int2slv(IO_INT_TYPE_25,3) &
    int2slv(IO_INT_TYPE_26,3) &
    int2slv(IO_INT_TYPE_27,3) &
    int2slv(IO_INT_TYPE_28,3) &
    int2slv(IO_INT_TYPE_29,3) &
    int2slv(IO_INT_TYPE_30,3) &
    int2slv(IO_INT_TYPE_31,3));

    
  -- IO_TYPE
  -- 2'b00 = Input
  -- 2'b01 = Output
  -- 2'b10 = Both  
  CONSTANT IO_TYPE : STD_LOGIC_VECTOR(0 TO 63) := (
    int2slv(IO_TYPE_0 ,2) &
    int2slv(IO_TYPE_1 ,2) &
    int2slv(IO_TYPE_2 ,2) &
    int2slv(IO_TYPE_3 ,2) &
    int2slv(IO_TYPE_4 ,2) &
    int2slv(IO_TYPE_5 ,2) &
    int2slv(IO_TYPE_6 ,2) &
    int2slv(IO_TYPE_7 ,2) &
    int2slv(IO_TYPE_8 ,2) &
    int2slv(IO_TYPE_9 ,2) &
    int2slv(IO_TYPE_10,2) &
    int2slv(IO_TYPE_11,2) &
    int2slv(IO_TYPE_12,2) &
    int2slv(IO_TYPE_13,2) &
    int2slv(IO_TYPE_14,2) &
    int2slv(IO_TYPE_15,2) &
    int2slv(IO_TYPE_16,2) &
    int2slv(IO_TYPE_17,2) &
    int2slv(IO_TYPE_18,2) &
    int2slv(IO_TYPE_19,2) &
    int2slv(IO_TYPE_20,2) &
    int2slv(IO_TYPE_21,2) &
    int2slv(IO_TYPE_22,2) &
    int2slv(IO_TYPE_23,2) &
    int2slv(IO_TYPE_24,2) &
    int2slv(IO_TYPE_25,2) &
    int2slv(IO_TYPE_26,2) &
    int2slv(IO_TYPE_27,2) &
    int2slv(IO_TYPE_28,2) &
    int2slv(IO_TYPE_29,2) &
    int2slv(IO_TYPE_30,2) &
    int2slv(IO_TYPE_31,2));
  
  -- IO_VAL
  -- Bit value each bit at reset, 1 or 0
  CONSTANT IO_VAL : STD_LOGIC_VECTOR(0 TO 31) := (
    int2slv(IO_VAL_0 ,1) &
    int2slv(IO_VAL_1 ,1) &
    int2slv(IO_VAL_2 ,1) &
    int2slv(IO_VAL_3 ,1) &
    int2slv(IO_VAL_4 ,1) &
    int2slv(IO_VAL_5 ,1) &
    int2slv(IO_VAL_6 ,1) &
    int2slv(IO_VAL_7 ,1) &
    int2slv(IO_VAL_8 ,1) &
    int2slv(IO_VAL_9 ,1) &
    int2slv(IO_VAL_10,1) &
    int2slv(IO_VAL_11,1) &
    int2slv(IO_VAL_12,1) &
    int2slv(IO_VAL_13,1) &
    int2slv(IO_VAL_14,1) &
    int2slv(IO_VAL_15,1) &
    int2slv(IO_VAL_16,1) &
    int2slv(IO_VAL_17,1) &
    int2slv(IO_VAL_18,1) &
    int2slv(IO_VAL_19,1) &
    int2slv(IO_VAL_20,1) &
    int2slv(IO_VAL_21,1) &
    int2slv(IO_VAL_22,1) &
    int2slv(IO_VAL_23,1) &
    int2slv(IO_VAL_24,1) &
    int2slv(IO_VAL_25,1) &
    int2slv(IO_VAL_26,1) &
    int2slv(IO_VAL_27,1) &
    int2slv(IO_VAL_28,1) &
    int2slv(IO_VAL_29,1) &
    int2slv(IO_VAL_30,1) &
    int2slv(IO_VAL_31,1));
	
  -- Sync/Async Reset Select
  CONSTANT SYNC_RESET : INTEGER := SYNC_MODE_SEL(FAMILY);       
  
  TYPE REG_ARRAY IS ARRAY (0 TO IO_NUM - 1) OF STD_LOGIC_VECTOR(7 DOWNTO 0);

  SIGNAL CONFIG_reg : REG_ARRAY;
  SIGNAL CONFIG_reg_o : STD_LOGIC_VECTOR(APB_WIDTH - 1 DOWNTO 0);
  SIGNAL INTR_reg   : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
  SIGNAL GPOUT_reg  : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
  SIGNAL GPIN_reg   : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
  SIGNAL GPIO_OUT_i : STD_LOGIC_VECTOR(IO_NUM - 1 DOWNTO 0);
  SIGNAL GPIO_OE_i  : STD_LOGIC_VECTOR(IO_NUM - 1 DOWNTO 0);
  SIGNAL PRDATA_o   : STD_LOGIC_VECTOR(APB_WIDTH - 1 DOWNTO 0);
  
  SIGNAL gpin1      : STD_LOGIC_VECTOR(IO_NUM - 1 DOWNTO 0);
  SIGNAL gpin2      : STD_LOGIC_VECTOR(IO_NUM - 1 DOWNTO 0);
  SIGNAL gpin3      : STD_LOGIC_VECTOR(IO_NUM - 1 DOWNTO 0);
  SIGNAL edge_pos   : STD_LOGIC_VECTOR(IO_NUM - 1 DOWNTO 0);
  SIGNAL edge_both  : STD_LOGIC_VECTOR(IO_NUM - 1 DOWNTO 0);
  SIGNAL edge_neg   : STD_LOGIC_VECTOR(IO_NUM - 1 DOWNTO 0);
  SIGNAL gpin2m     : STD_LOGIC_VECTOR(IO_NUM - 1 DOWNTO 0);
  SIGNAL level_low  : STD_LOGIC_VECTOR(IO_NUM - 1 DOWNTO 0);
  SIGNAL level_high : STD_LOGIC_VECTOR(IO_NUM - 1 DOWNTO 0);
  SIGNAL intr       : STD_LOGIC_VECTOR(IO_NUM - 1 DOWNTO 0);
  SIGNAL intp       : STD_LOGIC_VECTOR(IO_NUM - 1 DOWNTO 0);
  
  SIGNAL PADDR_INT  : INTEGER;
  SIGNAL PADDR_TOP  : STD_LOGIC_VECTOR(5 DOWNTO 0);

  SIGNAL aresetn          : STD_LOGIC;
  SIGNAL sresetn          : STD_LOGIC;

BEGIN
  aresetn <= '1' WHEN (SYNC_RESET=1) ELSE PRESETN;
  sresetn <= PRESETN WHEN (SYNC_RESET=1) ELSE '1';

  PSLVERR <= '0';
  PREADY <= '1';
  PRDATA(APB_WIDTH-1 downto 0) <= PRDATA_o(APB_WIDTH-1 downto 0);
  
  INT_BUS_GEN: IF (INT_BUS = 1) GENERATE
  CONSTANT ZFILL : STD_LOGIC_VECTOR(IO_NUM - 1 DOWNTO 0) := (OTHERS => '0');
  BEGIN
    INT_OR <= '0' when (intr = ZFILL) else
              '1';
  END GENERATE;

  NOT_INT_BUS_GEN: IF (INT_BUS = 0) GENERATE
  BEGIN
    INT_OR <= '0';
  END GENERATE;
  
  COND_GEN_NON_BITS: IF (IO_NUM < 32) GENERATE
  BEGIN
    LOOP_GEN_NON_BITS: FOR J IN IO_NUM TO 31 GENERATE
    BEGIN
      GPIN_reg(j) <= '0';
      GPOUT_reg(j) <= '0';
      INTR_reg(j) <= '0';
    END GENERATE;
  END GENERATE;

  GEN_BITS: FOR I IN 0 TO (IO_NUM-1) GENERATE
  begin
  
    -- ---------------------------------------------------
    -- width-independent code
    -- ---------------------------------------------------
  
    -- combinatorial assignments
    gpin2m(i) <= gpin2(i);
    level_high(i) <= gpin3(i);
    level_low(i)  <= NOT gpin3(i);
    INT(i) <= intr(i);
    GPIO_OE <= GPIO_OE_i;
    
  
    -- 2-wide input buffer
    process (PCLK, aresetn)
    begin
      if (aresetn = '0') then
        gpin1(i) <= '0';
        gpin2(i) <= '0';
      elsif rising_edge(PCLK) then
        if (sresetn = '0') then
          gpin1(i) <= '0';
          gpin2(i) <= '0';
	    else
          gpin1(i) <= GPIO_IN(i);
          gpin2(i) <= gpin1(i);
        end if;
      end if;
    end process;
    
    process (PCLK, aresetn)
    begin
      if (aresetn = '0') then
        gpin3(i) <= '0';
      elsif rising_edge(PCLK) then
        if (sresetn = '0') then
          gpin3(i) <= '0';
	    else
          gpin3(i) <= gpin2m(i);
        end if;
      end if;
    end process;
    
    -- interrupt register assignment
    REG_INT: if (FIXED_CONFIG(i) = '0') generate
    begin
      intp(i) <=  level_high(i)   when (CONFIG_reg(i)(7 downto 5) = "000") else
                  level_low(i)    when (CONFIG_reg(i)(7 downto 5) = "001") else
                  edge_pos(i)     when (CONFIG_reg(i)(7 downto 5) = "010") else 
                  edge_neg(i)     when (CONFIG_reg(i)(7 downto 5) = "011") else
                  edge_both(i)    when (CONFIG_reg(i)(7 downto 5) = "100") else
                  '0';
      intr(i) <= intp(i) when (CONFIG_reg(i)(3) = '1') else '0';
      
    end generate;
    
    FIXED_INT: if (FIXED_CONFIG(i) = '1') generate
    begin
      intp(i) <=  level_high(i)   when (IO_INT_TYPE(3*i to 3*i+2) = "000") else
                  level_low(i)    when (IO_INT_TYPE(3*i to 3*i+2) = "001") else
                  edge_pos(i)     when (IO_INT_TYPE(3*i to 3*i+2) = "010") else 
                  edge_neg(i)     when (IO_INT_TYPE(3*i to 3*i+2) = "011") else
                  edge_both(i)    when (IO_INT_TYPE(3*i to 3*i+2) = "100") else
                  '0';
      intr(i) <= intp(i) when (IO_INT_TYPE(3*i to 3*i+2) /= "111") else '0';
    end generate;
    
    
    REG_GPIN: if (FIXED_CONFIG(i) = '0') generate
    begin
      GPIN_reg(i) <= gpin3(i) when (CONFIG_reg(i)(1) = '1') else
                    '0';
    end generate;
    
    FIXED_GPIN: if (FIXED_CONFIG(i) = '1') generate
    begin
      GPIN_reg(i) <= gpin3(i) when (IO_TYPE(2*i to 2*i+1) /= "01") else
                    '0';
    end generate;

    -- AS: 20Jul09, added output register condition for OE signal
    REG_GPOUT: if (FIXED_CONFIG(i) = '0') generate
    begin
      GPIO_OUT_i(i) <= GPOUT_reg(i) when (CONFIG_reg(i)(0) = '1') else
                    '0';
      GPIO_OE_i(i) <=  '1' when ((CONFIG_reg(i)(2) = '1') and (CONFIG_reg(i)(0) = '1')) else
                  '0';
    end generate;
    
    FIXED_GPOUT: if (FIXED_CONFIG(i) = '1') generate
    begin
      GPIO_OUT_i(i) <= GPOUT_reg(i) when (IO_TYPE(2*i to 2*i+1) /= "00") else
                    '0';
      GPIO_OE_i(i) <=  '1';
    end generate;
    
    
    OE_EXT: if (OE_TYPE = 0) generate
    begin
      GPIO_OUT(i) <= GPIO_OUT_i(i);
    end generate;
    
    OE_INT: if (OE_TYPE = 1) generate
    begin
      GPIO_OUT(i) <= GPIO_OUT_i(i) when (GPIO_OE_i(i) = '1') else
                     'Z';
    end generate;
    
    
    -- APB Config registers
    -- only generated if fixed config for
    -- 'i' is disabled
    REG_GEN: if (FIXED_CONFIG(i) = '0') generate
    begin
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          CONFIG_reg(i)(7 downto 0) <= (others => '0');
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            CONFIG_reg(i)(7 downto 0) <= (others => '0');
		  else
            if ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = int2slv(i*4,8))) then
              CONFIG_reg(i)(7 downto 0) <= PWDATA(7 downto 0);
            else
              CONFIG_reg(i)(7 downto 0) <= CONFIG_reg(i)(7 downto 0);
            end if;
          end if;
        end if;
      end process;
    end generate;
    
    FIXED_GEN: if (FIXED_CONFIG(i) = '1') generate
    begin
      CONFIG_reg(i)(7 downto 0) <= X"00";
    end generate;
    -- ---------------------------------------------------
    -- width-dependent code
    -- ---------------------------------------------------
      
    -- 32-bit APB width 
    APB_32: IF (APB_WIDTH = 32) generate
    begin
      -- positive edge
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          edge_pos(i) <= '0';
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            edge_pos(i) <= '0';
		  else
            if (
              ((FIXED_CONFIG(i) = '1') AND (IO_INT_TYPE((3*i) TO (3*i+2)) = "010")) OR
              ((FIXED_CONFIG(i) = '0') AND (CONFIG_reg(i)(3) = '1'))
            ) then
              if ((gpin2m(i) = '1') AND (NOT gpin3(i) = '1')) then
                edge_pos(i) <= '1';
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"80")) then
                edge_pos(i) <= edge_pos(i) AND (NOT PWDATA(i));
              else
                edge_pos(i) <= edge_pos(i);
              end if;
            else
              edge_pos(i) <= '0';
            end if;
          end if;
        end if;
      end process;
      
      -- negative edge
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          edge_neg(i) <= '0';
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            edge_neg(i) <= '0';
		  else
            if (
              ((FIXED_CONFIG(i) = '1') AND (IO_INT_TYPE((3*i) TO (3*i+2)) = "011")) OR
              ((FIXED_CONFIG(i) = '0') AND (CONFIG_reg(i)(3) = '1'))
            ) then
              if ((NOT gpin2m(i) = '1') AND (gpin3(i) = '1')) then
                edge_neg(i) <= '1';
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"80")) then
                edge_neg(i) <= edge_neg(i) AND (NOT PWDATA(i));
              else
                edge_neg(i) <= edge_neg(i);
              end if;
            else
              edge_neg(i) <= '0';
            end if;
          end if;
        end if;
      end process;
      
      -- both edges
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          edge_both(i) <= '0';
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            edge_both(i) <= '0';
		  else
            if (
              ((FIXED_CONFIG(i) = '1') AND (IO_INT_TYPE((3*i) TO (3*i+2)) = "100")) OR
              ((FIXED_CONFIG(i) = '0') AND (CONFIG_reg(i)(3) = '1'))
            ) then
              if ((gpin2m(i) = '1') XOR (gpin3(i) = '1')) then
                edge_both(i) <= '1';
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"80")) then
                edge_both(i) <= edge_both(i) AND (NOT PWDATA(i));
              else
                edge_both(i) <= edge_both(i);
              end if;
            else
              edge_both(i) <= '0';
            end if;
          end if;
        end if;
      end process;
    
      -- interrupt register sequential logic
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          INTR_reg(i) <= '0';  
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            INTR_reg(i) <= '0';  
		  else
            if ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1')) then
              case (PADDR(7 downto 0)) IS
                when X"80" =>
                  INTR_reg(i) <= INTR_reg(i) AND (NOT PWDATA(i));
                when others =>
                  INTR_reg(i) <= intr(i);
              end case;
            else
              INTR_reg(i) <= intr(i);
            end if;
          end if;
        end if;
      end process;
      
      -- GPOUT registers
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          GPOUT_reg(i) <= IO_VAL(i);
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            GPOUT_reg(i) <= IO_VAL(i);
		  else
            if ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1')) then
              case (PADDR(7 downto 0)) IS
                when X"A0" =>
                  GPOUT_reg(i) <= PWDATA(i);
                when others =>
                  GPOUT_reg(i) <= GPOUT_reg(i);
              end case;
            else
              GPOUT_reg(i) <= GPOUT_reg(i);
            end if;
          end if;
        end if;
      end process;

    END GENERATE; -- APB_WIDTH = 32

    
    -- 16-bit APB width 
    APB_16: IF (APB_WIDTH = 16) generate
    begin
      -- positive edge
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          edge_pos(i) <= '0';
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            edge_pos(i) <= '0';
		  else
            if (
              ((FIXED_CONFIG(i) = '1') AND (IO_INT_TYPE((3*i) TO (3*i+2)) = "010")) OR
              ((FIXED_CONFIG(i) = '0') AND (CONFIG_reg(i)(3) = '1'))
            ) then
              if ((gpin2m(i) = '1') AND (NOT gpin3(i) = '1')) then
                edge_pos(i) <= '1';
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"80") AND (i < 16)) then
                edge_pos(i) <= edge_pos(i) AND (NOT PWDATA(i));
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"84") AND (i >= 16)) then
                edge_pos(i) <= edge_pos(i) AND (NOT PWDATA(i-16));
              else
                edge_pos(i) <= edge_pos(i);
              end if;
            else
              edge_pos(i) <= '0';
            end if;
          end if;
        end if;
      end process;
      
      -- negative edge
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          edge_neg(i) <= '0';
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            edge_neg(i) <= '0';
		  else
            if (
              ((FIXED_CONFIG(i) = '1') AND (IO_INT_TYPE((3*i) TO (3*i+2)) = "011")) OR
              ((FIXED_CONFIG(i) = '0') AND (CONFIG_reg(i)(3) = '1'))
            ) then
              if ((NOT gpin2m(i) = '1') AND (gpin3(i) = '1')) then
                edge_neg(i) <= '1';
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"80") AND (i < 16)) then
                edge_neg(i) <= edge_neg(i) AND (NOT PWDATA(i));
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"84") AND (i >= 16)) then
                edge_neg(i) <= edge_neg(i) AND (NOT PWDATA(i-16));
              else
                edge_neg(i) <= edge_neg(i);
              end if;
            else
              edge_neg(i) <= '0';
            end if;
          end if;
        end if;
      end process;
      
      -- both edges
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          edge_both(i) <= '0';
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            edge_both(i) <= '0';
		  else
            if (
              ((FIXED_CONFIG(i) = '1') AND (IO_INT_TYPE((3*i) TO (3*i+2)) = "100")) OR
              ((FIXED_CONFIG(i) = '0') AND (CONFIG_reg(i)(3) = '1'))
            ) then
              if ((gpin2m(i) = '1') XOR (gpin3(i) = '1')) then
                edge_both(i) <= '1';
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"80") AND (i < 16)) then
                edge_both(i) <= edge_both(i) AND (NOT PWDATA(i));
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"84") AND (i >= 16)) then
                edge_both(i) <= edge_both(i) AND (NOT PWDATA(i-16));
              else
                edge_both(i) <= edge_both(i);
              end if;
            else
              edge_both(i) <= '0';
            end if;
          end if;
        end if;
      end process;
    
      -- interrupt register sequential logic
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          INTR_reg(i) <= '0';  
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            INTR_reg(i) <= '0';  
		  else
            if ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"80") AND (i < 16)) then
              INTR_reg(i) <= INTR_reg(i) AND (NOT PWDATA(i));
            elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"84") AND (i >= 16)) then
              INTR_reg(i) <= INTR_reg(i) AND (NOT PWDATA(i-16));
            else
              INTR_reg(i) <= intr(i);
            end if;
          end if;
        end if;
      end process;
      
      -- GPOUT registers
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          GPOUT_reg(i) <= IO_VAL(i);
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            GPOUT_reg(i) <= IO_VAL(i);
		  else
            if ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"A0") AND (i < 16)) then
              GPOUT_reg(i) <= PWDATA(i);
            elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"A4") AND (i >= 16)) then
              GPOUT_reg(i) <= PWDATA(i-16);
            else
              GPOUT_reg(i) <= GPOUT_reg(i);
            end if;
          end if;
        end if;
      end process;

    END GENERATE; -- APB_WIDTH = 16

    
    -- 8-bit APB width 
    APB_8: IF (APB_WIDTH = 8) generate
    begin
      -- positive edge
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          edge_pos(i) <= '0';
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            edge_pos(i) <= '0';
		  else
            if (
              ((FIXED_CONFIG(i) = '1') AND (IO_INT_TYPE((3*i) TO (3*i+2)) = "010")) OR
              ((FIXED_CONFIG(i) = '0') AND (CONFIG_reg(i)(3) = '1'))
            ) then
              if ((gpin2m(i) = '1') AND (NOT gpin3(i) = '1')) then
                edge_pos(i) <= '1';
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"80") AND (i < 8)) then
                edge_pos(i) <= edge_pos(i) AND (NOT PWDATA(i));
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"84") AND (i >= 8) AND (i < 16)) then
                edge_pos(i) <= edge_pos(i) AND (NOT PWDATA(i-8));
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"88") AND (i >= 16) AND (i < 24)) then
                edge_pos(i) <= edge_pos(i) AND (NOT PWDATA(i-16));
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"8C") AND (i >= 24)) then
                edge_pos(i) <= edge_pos(i) AND (NOT PWDATA(i-24));
              else
                edge_pos(i) <= edge_pos(i);
              end if;
            else
              edge_pos(i) <= '0';
            end if;
          end if;
        end if;
      end process;
      
      -- negative edge
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          edge_neg(i) <= '0';
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            edge_neg(i) <= '0';
		  else
            if (
              ((FIXED_CONFIG(i) = '1') AND (IO_INT_TYPE((3*i) TO (3*i+2)) = "011")) OR
              ((FIXED_CONFIG(i) = '0') AND (CONFIG_reg(i)(3) = '1'))
            ) then
              if ((NOT gpin2m(i) = '1') AND (gpin3(i) = '1')) then
                edge_neg(i) <= '1';
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"80") AND (i < 8)) then
                edge_neg(i) <= edge_neg(i) AND (NOT PWDATA(i));
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"84") AND (i >= 8) AND (i < 16)) then
                edge_neg(i) <= edge_neg(i) AND (NOT PWDATA(i-8));
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"88") AND (i >= 16) AND (i < 24)) then
                edge_neg(i) <= edge_neg(i) AND (NOT PWDATA(i-16));
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"8C") AND (i >= 24)) then
                edge_neg(i) <= edge_neg(i) AND (NOT PWDATA(i-24));
              else
                edge_neg(i) <= edge_neg(i);
              end if;
            else
              edge_neg(i) <= '0';
            end if;
          end if;
        end if;
      end process;
      
      -- both edges
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          edge_both(i) <= '0';
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            edge_both(i) <= '0';
		  else
            if (
              ((FIXED_CONFIG(i) = '1') AND (IO_INT_TYPE((3*i) TO (3*i+2)) = "100")) OR
              ((FIXED_CONFIG(i) = '0') AND (CONFIG_reg(i)(3) = '1'))
            ) then
              if ((gpin2m(i) = '1') XOR (gpin3(i) = '1')) then
                edge_both(i) <= '1';
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"80") AND (i < 8)) then
                edge_both(i) <= edge_both(i) AND (NOT PWDATA(i));
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"84") AND (i >= 8) AND (i < 16)) then
                edge_both(i) <= edge_both(i) AND (NOT PWDATA(i-8));
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"88") AND (i >= 16) AND (i < 24)) then
                edge_both(i) <= edge_both(i) AND (NOT PWDATA(i-16));
              elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"8C") AND (i >= 24)) then
                edge_both(i) <= edge_both(i) AND (NOT PWDATA(i-24));
              else
                edge_both(i) <= edge_both(i);
              end if;
            else
              edge_both(i) <= '0';
            end if;
          end if;
        end if;
      end process;
    
      -- interrupt register sequential logic
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          INTR_reg(i) <= '0';  
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            INTR_reg(i) <= '0';  
		  else
            if ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"80") AND (i < 8)) then
              INTR_reg(i) <= INTR_reg(i) AND (NOT PWDATA(i));
            elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"84") AND (i >= 8) AND (i < 16)) then
              INTR_reg(i) <= INTR_reg(i) AND (NOT PWDATA(i-8));
            elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"88") AND (i >= 16) AND (i < 24)) then
              INTR_reg(i) <= INTR_reg(i) AND (NOT PWDATA(i-16));
            elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"8C") AND (i >= 24)) then
              INTR_reg(i) <= INTR_reg(i) AND (NOT PWDATA(i-24));
            else
              INTR_reg(i) <= intr(i);
            end if;
          end if;
        end if;
      end process;
      
      -- GPOUT registers
      process (PCLK, aresetn)
      begin
        if (aresetn = '0') then
          GPOUT_reg(i) <= IO_VAL(i);
        elsif rising_edge(PCLK) then
          if (sresetn = '0') then
            GPOUT_reg(i) <= IO_VAL(i);
		  else
            if ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"A0") AND (i < 8)) then
              GPOUT_reg(i) <= PWDATA(i);
            elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"A4") AND (i >= 8) AND (i < 16)) then
              GPOUT_reg(i) <= PWDATA(i-8);
            elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"A8") AND (i >= 16) AND (i < 24)) then
              GPOUT_reg(i) <= PWDATA(i-16);
            elsif ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 downto 0) = X"AC") AND (i >= 24)) then
              GPOUT_reg(i) <= PWDATA(i-24);
            else
              GPOUT_reg(i) <= GPOUT_reg(i);
            end if;
          end if;
        end if;
      end process;

    END GENERATE; -- APB_WIDTH = 8
    
  END GENERATE; -- bit i
  
  
  PADDR_TOP(5 downto 0) <= PADDR(7 downto 2);
  PADDR_INT <= sl2int(PADDR_TOP);
  process (CONFIG_reg, PADDR, PADDR_INT)
  begin
    case (PADDR_INT) IS
      when 0 to 31 =>
        CONFIG_reg_o(7 downto 0) <= CONFIG_reg(PADDR_INT)(7 downto 0);
      when others => 
        CONFIG_reg_o(7 downto 0) <= X"00";
    end case;
  end process;
  
  -- Asynchronous APB read data (32-bit)
  RDATA_32: if (APB_WIDTH = 32) generate
  begin
    
    CONFIG_reg_o(31 downto 8) <= X"000000";
    PRDATA_o(31 downto 0) <=  CONFIG_reg_o(31 downto 0)  when  (PADDR(7 downto 0) < X"80") else
                              INTR_reg(31 downto 0)      when  (PADDR(7 downto 0) = X"80") else
                              GPIN_reg(31 downto 0)      when  (PADDR(7 downto 0) = X"90") else
                              GPOUT_reg(31 downto 0)     when  (PADDR(7 downto 0) = X"A0") else
                              X"00000000";
  end generate;

  -- Asynchronous APB read data (16-bit)
  RDATA_16: if (APB_WIDTH = 16) generate
  begin
    CONFIG_reg_o(15 downto 8) <= X"00";
    PRDATA_o(15 downto 0) <=  CONFIG_reg_o(15 downto 0)  when  (PADDR(7 downto 0) < X"80") else
                              INTR_reg(15 downto 0)      when  (PADDR(7 downto 0) = X"80") else
                              INTR_reg(31 downto 16)     when  (PADDR(7 downto 0) = X"84") else
                              GPIN_reg(15 downto 0)      when  (PADDR(7 downto 0) = X"90") else
                              GPIN_reg(31 downto 16)     when  (PADDR(7 downto 0) = X"94") else
                              GPOUT_reg(15 downto 0)     when  (PADDR(7 downto 0) = X"A0") else
                              GPOUT_reg(31 downto 16)    when  (PADDR(7 downto 0) = X"A4") else
                              X"0000";
  end generate;
  
  -- Asynchronous APB read data (8-bit)
  RDATA_8: if (APB_WIDTH = 8) generate
  begin
    PRDATA_o(7 downto 0) <=   CONFIG_reg_o(7 downto 0)   when  (PADDR(7 downto 0) < X"80") else
                              INTR_reg(7 downto 0)       when  (PADDR(7 downto 0) = X"80") else
                              INTR_reg(15 downto 8)      when  (PADDR(7 downto 0) = X"84") else
                              INTR_reg(23 downto 16)     when  (PADDR(7 downto 0) = X"88") else
                              INTR_reg(31 downto 24)     when  (PADDR(7 downto 0) = X"8C") else
                              GPIN_reg(7 downto 0)       when  (PADDR(7 downto 0) = X"90") else
                              GPIN_reg(15 downto 8)      when  (PADDR(7 downto 0) = X"94") else
                              GPIN_reg(23 downto 16)     when  (PADDR(7 downto 0) = X"98") else
                              GPIN_reg(31 downto 24)     when  (PADDR(7 downto 0) = X"9C") else
                              GPOUT_reg(7 downto 0)      when  (PADDR(7 downto 0) = X"A0") else
                              GPOUT_reg(15 downto 8)     when  (PADDR(7 downto 0) = X"A4") else
                              GPOUT_reg(23 downto 16)    when  (PADDR(7 downto 0) = X"A8") else
                              GPOUT_reg(31 downto 24)    when  (PADDR(7 downto 0) = X"AC") else
                              X"00";
  end generate;
  
   
END RTL;
