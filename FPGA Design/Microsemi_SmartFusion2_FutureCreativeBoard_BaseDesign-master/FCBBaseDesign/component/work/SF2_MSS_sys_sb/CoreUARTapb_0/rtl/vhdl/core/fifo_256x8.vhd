-- ********************************************************************
-- Actel Corporation Proprietary and Confidential
--  Copyright 2008 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description: COREUART/ CoreUARTapb UART core
--
--
--  Revision Information:
-- Date     Description
-- Jun09    Revision 4.1
-- Aug10    Revision 4.2

-- SVN Revision Information:
-- SVN $Revision: 8508 $
-- SVN $Date: 2009-06-15 16:49:49 -0700 (Mon, 15 Jun 2009) $
--
-- Resolved SARs
-- SAR      Date     Who   Description
-- 20741    2Sep10   AS    Increased baud rate by ensuring fifo ctrl runs off
--                         sys clk (not baud clock).  See note below.

-- Notes:
-- best viewed with tabstops set to "4"
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

ENTITY SF2_MSS_sys_sb_CoreUARTapb_0_fifo_256x8 IS
    GENERIC(SYNC_RESET: INTEGER := 0);
   PORT (
      DO                      : OUT std_logic_vector(7 DOWNTO 0);   
      RCLOCK                  : IN std_logic;   
      WCLOCK                  : IN std_logic;   
      DI                      : IN std_logic_vector(7 DOWNTO 0);   
      WRB                     : IN std_logic;   
      RDB                     : IN std_logic;   
      RESET                   : IN std_logic;   
      FULL                    : OUT std_logic;   
      EMPTY                   : OUT std_logic);   
END ENTITY SF2_MSS_sys_sb_CoreUARTapb_0_fifo_256x8;

ARCHITECTURE translated OF SF2_MSS_sys_sb_CoreUARTapb_0_fifo_256x8 IS

COMPONENT SF2_MSS_sys_sb_CoreUARTapb_0_fifo_ctrl_256 IS
   GENERIC (
      FIFO_DEPTH                     :  integer := 16;   --  Depth of FIFO (number of bytes)
      FIFO_BITS                      :  integer := 4;    --  Number of bits required to
      FIFO_WIDTH                     :  integer := 8;    --  Width of FIFO data
	  SYNC_RESET                     :  integer := 0);    
   PORT (
      -- INPUTS

      clock                   : IN std_logic;   --  Clock input
      reset_n                 : IN std_logic;   --  Active low reset
      data_in                 : IN std_logic_vector(FIFO_WIDTH - 1 DOWNTO 0);   --  Data input to FIFO
      read_n                  : IN std_logic;   --  Read FIFO (active low)
      write_n                 : IN std_logic;   --  Write FIFO (active low)
      LEVEL                   : IN std_logic_vector(7 DOWNTO 0);   
      -- OUTPUTS

      data_out                : OUT std_logic_vector(FIFO_WIDTH - 1 DOWNTO 0);   --  FIFO output data
      full                    : OUT std_logic;   --  FIFO is full
      empty                   : OUT std_logic;   --  FIFO is empty
      half                    : OUT std_logic);   --  FIFO is half full
END COMPONENT;
   CONSTANT  LEVEL                 :  std_logic_vector(7 DOWNTO 0) := "01000000";
   SIGNAL DO_xhdl1                 :  std_logic_vector(7 DOWNTO 0);   
   SIGNAL FULL_xhdl2               :  std_logic;   
   SIGNAL EMPTY_xhdl3              :  std_logic;   
   SIGNAL EQTH_xhdl4               :  std_logic;   
   SIGNAL GEQTH_xhdl5              :  std_logic;   

BEGIN
   DO <= DO_xhdl1;
   FULL <= FULL_xhdl2;
   EMPTY <= EMPTY_xhdl3;

   fifo_ctrl_256_xhdl9 : SF2_MSS_sys_sb_CoreUARTapb_0_fifo_ctrl_256 
      GENERIC MAP (SYNC_RESET => SYNC_RESET)
      PORT MAP (
         data_in => DI,
         data_out => DO_xhdl1,
         write_n => WRB,
         read_n => RDB,
         clock => WCLOCK,
         full => FULL_xhdl2,
         empty => EMPTY_xhdl3,
         half => GEQTH_xhdl5,
         reset_n => RESET,
         LEVEL => LEVEL);   
   

END ARCHITECTURE translated;


--*******************************************************-- MODULE:		Synchronous FIFO
--
-- FILE NAME:	fifo_ctl.v
-- 
-- CODE TYPE:	Register Transfer Level
--
-- DESCRIPTION:	This module defines a Synchronous FIFO. The
-- FIFO memory is implemented as a ring buffer. The read
-- pointer points to the beginning of the buffer, while the
-- write pointer points to the end of the buffer. Note that
-- in this RTL version, the memory has one more location than
-- the FIFO needs in order to calculate the FIFO count
-- correctly.
--
--*******************************************************-- fifo control logic 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

ENTITY SF2_MSS_sys_sb_CoreUARTapb_0_fifo_ctrl_256 IS
   GENERIC (
      FIFO_DEPTH                     :  integer := 16;   --  Depth of FIFO (number of bytes)
      FIFO_BITS                      :  integer := 4;    --  Number of bits required to
      FIFO_WIDTH                     :  integer := 8;    --  Width of FIFO data
	  SYNC_RESET                     :  integer := 0); 
   PORT (
      -- INPUTS

      clock                   : IN std_logic;   --  Clock input
      reset_n                 : IN std_logic;   --  Active low reset
      data_in                 : IN std_logic_vector(FIFO_WIDTH - 1 DOWNTO 0);   --  Data input to FIFO
      read_n                  : IN std_logic;   --  Read FIFO (active low)
      write_n                 : IN std_logic;   --  Write FIFO (active low)
      LEVEL                   : IN std_logic_vector(7 DOWNTO 0);   
      -- OUTPUTS

      data_out                : OUT std_logic_vector(FIFO_WIDTH - 1 DOWNTO 0);   --  FIFO output data
      full                    : OUT std_logic;   --  FIFO is full
      empty                   : OUT std_logic;   --  FIFO is empty
      half                    : OUT std_logic);   --  FIFO is half full
END ENTITY SF2_MSS_sys_sb_CoreUARTapb_0_fifo_ctrl_256;

ARCHITECTURE translated OF SF2_MSS_sys_sb_CoreUARTapb_0_fifo_ctrl_256 IS

COMPONENT SF2_MSS_sys_sb_CoreUARTapb_0_ram16x8 IS
   GENERIC (
      -- PARAMETERS
      RAM_WIDTH                      :  integer := 8;    --  Width of RAM (number of bits)
      RAM_DEPTH                      :  integer := 16;    --  Depth of RAM (number of bytes)
      ADDR_SZ                        :  integer := 4);    --  Number of bits required to
   PORT (
      -- represent the RAM address
-- INPUTS

      clk                     : IN std_logic;   --  clock signal 
      data_in                 : IN std_logic_vector(RAM_WIDTH - 1 DOWNTO 0);   --  RAM data in
      read_address            : IN std_logic_vector(ADDR_SZ - 1 DOWNTO 0);   --  Read address
      write_address           : IN std_logic_vector(ADDR_SZ - 1 DOWNTO 0);   --  Write address
      write_n                 : IN std_logic;   --  Write strobe (active low)
      read_n                  : IN std_logic;   --  Output enable (active low)
      -- OUTPUTS

      data_out                : OUT std_logic_vector(RAM_WIDTH - 1 DOWNTO 0));   --  RAM data out
END COMPONENT;

   -- SIGNAL DECLARATIONS
   SIGNAL data_out_0               :  std_logic_vector(FIFO_WIDTH - 1 DOWNTO 0);   
   SIGNAL read_n_hold              :  std_logic;   
   -- How many locations in the FIFO
   -- are occupied?
   SIGNAL counter                  :  std_logic_vector(FIFO_BITS - 1 DOWNTO 0);   
   -- FIFO read pointer points to
   -- the location in the FIFO to
   -- read from next
   SIGNAL rd_pointer               :  std_logic_vector(FIFO_BITS - 1 DOWNTO 0);   
   -- FIFO write pointer points to
   -- the location in the FIFO to
   -- write to next
   SIGNAL wr_pointer               :  std_logic_vector(FIFO_BITS - 1 DOWNTO 0);   
   -- PARAMETERS
   -- ASSIGN STATEMENTS
   SIGNAL temp_xhdl5               :  std_logic;   
   SIGNAL temp_xhdl6               :  std_logic;   
   SIGNAL temp_xhdl7               :  std_logic;   
   SIGNAL data_out_xhdl1           :  std_logic_vector(FIFO_WIDTH - 1 DOWNTO 0);   
   SIGNAL full_xhdl2               :  std_logic;   
   SIGNAL empty_xhdl3              :  std_logic;   
   SIGNAL half_xhdl4               :  std_logic;   
   SIGNAL aresetn                  :  std_logic;
   SIGNAL sresetn                  :  std_logic;
   
BEGIN
   aresetn <= '1' WHEN (SYNC_RESET=1) ELSE reset_n;
   sresetn <= reset_n WHEN (SYNC_RESET=1) ELSE '1';
   data_out <= data_out_xhdl1;
   full <= full_xhdl2;
   empty <= empty_xhdl3;
   half <= half_xhdl4;
   temp_xhdl5 <= '1' WHEN (counter = CONV_STD_LOGIC_VECTOR(FIFO_DEPTH - 1, 4)) ELSE '0';
   full_xhdl2 <= temp_xhdl5 ;
   temp_xhdl6 <= '1' WHEN (counter = "0000") ELSE '0';
   empty_xhdl3 <= temp_xhdl6 ;
   temp_xhdl7 <= '1' WHEN (counter >= LEVEL) ELSE '0';
   half_xhdl4 <= temp_xhdl7 ;

   -- MAIN CODE
   -- This block contains all devices affected by the clock 
   -- and reset inputs
   
   PROCESS (clock, aresetn)
   BEGIN
      IF (NOT aresetn = '1') THEN
         -- Reset the FIFO pointer
         
         rd_pointer <= (OTHERS => '0');    
         wr_pointer <= (OTHERS => '0');    
         counter <= (OTHERS => '0');    
      ELSIF (clock'EVENT AND clock = '1') THEN
         IF (NOT sresetn = '1') THEN
            -- Reset the FIFO pointer
            
            rd_pointer <= (OTHERS => '0');    
            wr_pointer <= (OTHERS => '0');    
            counter <= (OTHERS => '0');    
	     ELSE
            IF (NOT read_n = '1') THEN
               -- Check for FIFO underflow
               --
               -- 			if (counter == 0) begin
               -- 				$display("\nERROR at time %0t:", $time);
               -- 				$display("FIFO Underflow\n");
               -- 				// Use $stop for debugging
               -- 				$stop;
               -- 			end
               --                        
               -- If we are doing a simultaneous read and write,
               -- there is no change to the counter
               
               IF (write_n = '1') THEN
                  -- Decrement the FIFO counter
                  
                  counter <= counter - "0001";    
               END IF;
               -- Increment the read pointer
               -- Check if the read pointer has gone beyond the
               -- depth of the FIFO. If so, set it back to the
               -- beginning of the FIFO
               
               IF (rd_pointer = CONV_STD_LOGIC_VECTOR(FIFO_DEPTH - 1, 4)) THEN
                  rd_pointer <= (OTHERS => '0');    
               ELSE
                  rd_pointer <= rd_pointer + "0001";    
               END IF;
            END IF;
            IF (NOT write_n = '1') THEN
               -- If we are doing a simultaneous read and write,
               -- there is no change to the counter
               
               IF (read_n = '1') THEN
                  -- Increment the FIFO counter
                  
                  counter <= counter + "0001";    
               END IF;
               -- Increment the write pointer
               -- Check if the write pointer has gone beyond the
               -- depth of the FIFO. If so, set it back to the
               -- beginning of the FIFO
               
               IF (wr_pointer = CONV_STD_LOGIC_VECTOR(FIFO_DEPTH - 1, 4)) THEN
                  wr_pointer <= (OTHERS => '0');    
               ELSE
                  wr_pointer <= wr_pointer + "0001";    
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   PROCESS (clock, aresetn)
   BEGIN
      IF (NOT aresetn = '1') THEN
         read_n_hold <= '0';    
      ELSIF (clock'EVENT AND clock = '1') THEN
          IF (NOT sresetn = '1') THEN
             read_n_hold <= '0';  
	      ELSE
             read_n_hold <= read_n;    
             IF (read_n_hold = '0') THEN
                data_out_xhdl1 <= data_out_0;    
             ELSE
                data_out_xhdl1 <= data_out_xhdl1;    
             END IF;
          END IF;
      END IF;
   END PROCESS;
   
   ram16x8_xhdl12 : SF2_MSS_sys_sb_CoreUARTapb_0_ram16x8 
      PORT MAP (
         clk => clock,
         data_in => data_in,
         data_out => data_out_0,
         write_address => wr_pointer,
         read_address => rd_pointer,
         write_n => write_n,
         read_n => read_n);   
   

END ARCHITECTURE translated;


LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;
ENTITY SF2_MSS_sys_sb_CoreUARTapb_0_ram16x8 IS
   GENERIC (
      -- PARAMETERS
      RAM_WIDTH                      :  integer := 8;    --  Width of RAM (number of bits)
      RAM_DEPTH                      :  integer := 16;    --  Depth of RAM (number of bytes)
      ADDR_SZ                        :  integer := 4);    --  Number of bits required to
   PORT (
      -- represent the RAM address
-- INPUTS

      clk                     : IN std_logic;   --  clock signal 
      data_in                 : IN std_logic_vector(RAM_WIDTH - 1 DOWNTO 0);   --  RAM data in
      read_address            : IN std_logic_vector(ADDR_SZ - 1 DOWNTO 0);   --  Read address
      write_address           : IN std_logic_vector(ADDR_SZ - 1 DOWNTO 0);   --  Write address
      write_n                 : IN std_logic;   --  Write strobe (active low)
      read_n                  : IN std_logic;   --  Output enable (active low)
      -- OUTPUTS

      data_out                : OUT std_logic_vector(RAM_WIDTH - 1 DOWNTO 0));   --  RAM data out
END ENTITY SF2_MSS_sys_sb_CoreUARTapb_0_ram16x8;

ARCHITECTURE translated OF SF2_MSS_sys_sb_CoreUARTapb_0_ram16x8 IS

   TYPE xhdl_2 IS ARRAY (RAM_DEPTH - 1 DOWNTO 0) OF std_logic_vector(RAM_WIDTH - 1 DOWNTO 0);

   -- SIGNAL DECLARATIONS
   -- The RAM
   SIGNAL memory                   :  xhdl_2;   
   SIGNAL data_out_xhdl1           :  std_logic_vector(RAM_WIDTH - 1 DOWNTO 0);   

     FUNCTION to_integer (
      val      : std_logic_vector) RETURN integer IS

      CONSTANT vec      : std_logic_vector(val'high-val'low DOWNTO 0) := val;      
      VARIABLE rtn      : integer := 0;
   BEGIN
      FOR index IN vec'RANGE LOOP
         IF (vec(index) = '1') THEN
            rtn := rtn + (2**index);
         END IF;
      END LOOP;
      RETURN(rtn);
   END to_integer;
                  
BEGIN
   data_out <= data_out_xhdl1;

   -- Write to the RAM 
   
   PROCESS (clk)
      VARIABLE memory_xhdl3  : xhdl_2;
   BEGIN
      IF (clk'EVENT AND clk = '1') THEN
         IF (write_n = '0') THEN
            memory_xhdl3(to_integer(write_address)) := data_in;    
         END IF;
      END IF;
      memory <= memory_xhdl3;
   END PROCESS;

   -- Read from the RAM 
   
   PROCESS (clk)
      VARIABLE data_out_xhdl1_xhdl4  : std_logic_vector(RAM_WIDTH - 1 DOWNTO 0);
   BEGIN
      IF (clk'EVENT AND clk = '1') THEN
         IF (read_n = '0') THEN
            data_out_xhdl1_xhdl4 := memory(to_integer(read_address));    
         END IF;
      END IF;
      data_out_xhdl1 <= data_out_xhdl1_xhdl4;
   END PROCESS;

END ARCHITECTURE translated;
