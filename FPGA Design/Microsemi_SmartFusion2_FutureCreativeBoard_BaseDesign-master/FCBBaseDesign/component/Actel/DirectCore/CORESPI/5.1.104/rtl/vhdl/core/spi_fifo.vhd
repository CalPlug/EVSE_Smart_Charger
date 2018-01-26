-- ********************************************************************/ 
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2014 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
--  
--
-- SPI Synchronous FIFO
--
--
-- SVN Revision Information:
-- SVN $Revision: 28016 $
-- SVN $Date: 2016-11-24 20:45:51 +0530 (Thu, 24 Nov 2016) $
--
-- Resolved SARs
-- SAR      Date     Who   Description
--
-- Notes:
--
-- *********************************************************************/ 

LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;

LIBRARY work;
    USE work.corespi_pkg.all;

ENTITY spi_fifo IS
   GENERIC (     
      CFG_FRAME_SIZE        : INTEGER := 4;		-- 4-32
      CFG_FIFO_DEPTH            : INTEGER := 4		-- 2,4,8,16,32
   );
   PORT (
      
      pclk                  : IN STD_LOGIC;
      aresetn               : IN STD_LOGIC;
      sresetn               : IN STD_LOGIC;
      fiforst               : IN STD_LOGIC; 
      data_in               : IN STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
      flag_in               : IN STD_LOGIC;
      
      data_out              : OUT STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
      flag_out              : OUT STD_LOGIC;
      read_in               : IN STD_LOGIC;
      write_in              : IN STD_LOGIC;
      full_out              : OUT STD_LOGIC;
      empty_out             : OUT STD_LOGIC;
      full_next_out         : OUT STD_LOGIC;
      empty_next_out        : OUT STD_LOGIC;
      overflow_out          : OUT STD_LOGIC;
      fifo_count            : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
   );
END spi_fifo;

ARCHITECTURE trans OF spi_fifo IS
   TYPE type_xhdl0 IS ARRAY (0 TO CFG_FIFO_DEPTH - 1) OF STD_LOGIC_VECTOR(CFG_FRAME_SIZE DOWNTO 0);
   
   CONSTANT PTR_WIDTH : NATURAL := log2(CFG_FIFO_DEPTH);
   
   SIGNAL rd_pointer_d         : STD_LOGIC_VECTOR(PTR_WIDTH - 1 DOWNTO 0);
   SIGNAL rd_pointer_q         : STD_LOGIC_VECTOR(PTR_WIDTH - 1 DOWNTO 0);		--read pointer address
   SIGNAL wr_pointer_d         : STD_LOGIC_VECTOR(PTR_WIDTH - 1 DOWNTO 0);
   SIGNAL wr_pointer_q         : STD_LOGIC_VECTOR(PTR_WIDTH - 1 DOWNTO 0);		--write pointer address
   SIGNAL counter_d            : STD_LOGIC_VECTOR(5 DOWNTO 0);
   SIGNAL counter_q            : STD_LOGIC_VECTOR(5 DOWNTO 0);		--counter 5 bits
   
   SIGNAL fifo_mem_d           : type_xhdl0;		--FIFO has extra flag bit (CFG_FRAME_SIZE + 1)
   SIGNAL fifo_mem_q           : type_xhdl0;
   SIGNAL data_out_dx          : STD_LOGIC_VECTOR(CFG_FRAME_SIZE DOWNTO 0);
   SIGNAL data_out_d           : STD_LOGIC_VECTOR(CFG_FRAME_SIZE DOWNTO 0);
BEGIN
   data_out <= data_out_d(CFG_FRAME_SIZE - 1 DOWNTO 0);
   flag_out <= data_out_d(CFG_FRAME_SIZE);
   overflow_out <= '1' WHEN (write_in = '1' AND (counter_q = std_logic_vector(to_unsigned(CFG_FIFO_DEPTH, 6)))) ELSE '0';

   
   GEN_MEM: FOR i IN 0 TO  CFG_FIFO_DEPTH - 1 GENERATE
     PROCESS (pclk)
     BEGIN
        IF (pclk'EVENT AND pclk = '1') THEN
             fifo_mem_q(i) <= fifo_mem_d(i);
        END IF;
     END PROCESS;
   END GENERATE;

    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            rd_pointer_q <= (OTHERS => '0');
            wr_pointer_q <= (OTHERS => '0');
            counter_q <= "000000";
            full_out <= '0';
            empty_out <= '1';
            full_next_out <= '0';
            empty_next_out <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                rd_pointer_q <= (OTHERS => '0');
                wr_pointer_q <= (OTHERS => '0');
                counter_q <= "000000";
                full_out <= '0';
                empty_out <= '1';
                full_next_out <= '0';
                empty_next_out <= '0';
            ELSE
                rd_pointer_q <= rd_pointer_d;
                wr_pointer_q <= wr_pointer_d;
                counter_q <= counter_d;
                --full
                IF (counter_d = std_logic_vector(to_unsigned(CFG_FIFO_DEPTH, 6))) THEN
                    full_out <= '1';
                ELSE
                    full_out <= '0';
                END IF;
                --empty
                IF (counter_d = "000000") THEN
                    empty_out <= '1';
                ELSE
                    empty_out <= '0';
                END IF;
                --next full
                IF (counter_q = std_logic_vector(to_unsigned(CFG_FIFO_DEPTH-1,6))) THEN
                    full_next_out <= '1';
                ELSE
                    full_next_out <= '0';
                END IF;
                --empty next
                IF (counter_q = "000001") THEN
                    empty_next_out <= '1';
                ELSE
                    empty_next_out <= '0';
                END IF;
            END IF;
        END IF;
    END PROCESS;
   
   PROCESS (fifo_mem_q, write_in, counter_q, data_in, flag_in, wr_pointer_q, rd_pointer_q)
   BEGIN
      FOR j IN 0 TO  CFG_FIFO_DEPTH - 1 LOOP		-- Hold old values
         fifo_mem_d(j) <= fifo_mem_q(j);
      END LOOP;
      
      IF (write_in = '1') THEN
         IF (counter_q /= std_logic_vector(to_unsigned(CFG_FIFO_DEPTH, 6))) THEN
            fifo_mem_d(to_integer(unsigned(wr_pointer_q(PTR_WIDTH - 1 DOWNTO 0))))(CFG_FRAME_SIZE - 1 DOWNTO 0) <= data_in(CFG_FRAME_SIZE - 1 DOWNTO 0);
            fifo_mem_d(to_integer(unsigned(wr_pointer_q(PTR_WIDTH - 1 DOWNTO 0))))(CFG_FRAME_SIZE) <= flag_in;
         ELSE
           fifo_mem_d(0 TO CFG_FIFO_DEPTH-1) <= fifo_mem_q(0 TO CFG_FIFO_DEPTH-1);
         END IF;
      END IF;
      data_out_dx <= fifo_mem_q(to_integer(unsigned(rd_pointer_q(PTR_WIDTH - 1 DOWNTO 0))));
   END PROCESS;
   
   
   -- Perform extra read mux on Byte/Half wide reads
   PROCESS (data_out_dx, counter_q)
   BEGIN
      data_out_d <= data_out_dx(CFG_FRAME_SIZE DOWNTO 0);
      IF (counter_q = "000000") THEN
         data_out_d(CFG_FRAME_SIZE) <= '0';
      END IF;
   END PROCESS;
   
   
   -- Pointers and Flags
   
   PROCESS (counter_q, rd_pointer_q, wr_pointer_q, read_in, write_in, fiforst)
   BEGIN
      IF (fiforst = '1') THEN
         wr_pointer_d <= (OTHERS => '0');
         rd_pointer_d <= (OTHERS => '0');
         counter_d <= "000000";
      ELSE

      --defaults
      counter_d <= counter_q;
      rd_pointer_d <= rd_pointer_q;
      
      wr_pointer_d <= wr_pointer_q;
      IF (read_in = '1') THEN
         IF (counter_q /= "000000") THEN		-- ignore read when empty
            IF ((NOT(write_in)) = '1') THEN		--if not writing decrement count of the number of objects in fifo else count stays the same
               counter_d <= counter_q - "000001";
            END IF;
            IF (rd_pointer_q = std_logic_vector(to_unsigned(CFG_FIFO_DEPTH - 1, 5))) THEN
               rd_pointer_d <= (OTHERS => '0');
            ELSE
               rd_pointer_d <= rd_pointer_q + 1;
            END IF;
         END IF;
      END IF;
      
      --~read_n
      IF (write_in = '1') THEN
         IF (counter_q /= std_logic_vector(to_unsigned(CFG_FIFO_DEPTH, 6))) THEN		-- ignore write when full
            IF ((NOT(read_in)) = '1') THEN
               counter_d <= counter_q + "000001";
            END IF;
            IF (wr_pointer_q = std_logic_vector(to_unsigned(CFG_FIFO_DEPTH - 1, 5))) THEN
               wr_pointer_d <= (OTHERS => '0');
            ELSE
               
               wr_pointer_d <= wr_pointer_q + 1;		--~write_n
            END IF;
         END IF;
      END IF;
    END IF;
     

   END PROCESS;
   
   
   fifo_count <= counter_q;
   
END trans;



