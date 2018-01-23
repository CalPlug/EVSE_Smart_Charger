LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;


ENTITY corepwm_tach_if IS
   GENERIC ( SYNC_RESET: INTEGER := 0;
             TACH_NUM  : INTEGER := 1
      --microcontroller IF
      -- TACH IF  
   );
   PORT (
      PCLK           : IN STD_LOGIC;
      PRESETN        : IN STD_LOGIC;
      TACHIN         : IN STD_LOGIC;
      TACHMODE       : IN STD_LOGIC;
      TACH_EDGE      : IN STD_LOGIC;
      TACHSTATUS     : IN STD_LOGIC;
      status_clear   : IN STD_LOGIC;
      tach_cnt_clk   : IN STD_LOGIC;
      TACHPULSEDUR   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      update_status  : OUT STD_LOGIC
   );
END ENTITY corepwm_tach_if;

ARCHITECTURE trans OF corepwm_tach_if IS
  
   CONSTANT cnt0	  : STD_LOGIC := '0';
   CONSTANT cnt1	  : STD_LOGIC := '1';	

   --reg declarations
   
   SIGNAL tach_cnt             : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL tach_cnt_next        : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL tach_cnt_overflow    : STD_LOGIC;
   SIGNAL tach_cnt_overflow_en : STD_LOGIC;
   SIGNAL tach_cnt_store       : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL tach_cnt_store_next  : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL update_status_next   : STD_LOGIC;
   SIGNAL present_state        : STD_LOGIC;
   SIGNAL next_state           : STD_LOGIC;
   SIGNAL tachin_edge_det      : STD_LOGIC;
   SIGNAL tachin_sync0         : STD_LOGIC;
   SIGNAL tachin_sync1         : STD_LOGIC;
   SIGNAL tachin_sync2         : STD_LOGIC;
   SIGNAL TACHPULSEDUR_int     : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL update_status_int    : STD_LOGIC;
   SIGNAL aresetn              : STD_LOGIC;
   SIGNAL sresetn              : STD_LOGIC;

BEGIN
   
   --////main//////
   aresetn <= '1' WHEN (SYNC_RESET=1) ELSE PRESETN;
   sresetn <= PRESETN WHEN (SYNC_RESET=1) ELSE '1';
   
   -- store tach pulse duration
   PROCESS (aresetn, PCLK)
   BEGIN
      IF ((NOT(aresetn)) = '1') THEN
         TACHPULSEDUR_int <= "0000000000000000";
      ELSIF (PCLK'EVENT AND PCLK = '1') THEN
         IF ((NOT(sresetn)) = '1') THEN
            TACHPULSEDUR_int <= "0000000000000000";
	     ELSE
            TACHPULSEDUR_int <= tach_cnt_store;
         END IF;
      END IF;
   END PROCESS;
   
   
   TACHPULSEDUR <= TACHPULSEDUR_int;
   update_status <= update_status_int;
   
   -- generate tachin edge detect signal
   PROCESS (aresetn, PCLK)
   BEGIN
      IF ((NOT(aresetn)) = '1') THEN
          tach_cnt <= "0000000000000000";
          tach_cnt_store <= "0000000000000000";
          tachin_sync0 <= '0';
          tachin_sync1 <= '0';
          tachin_sync2 <= '0';
          tachin_edge_det <= '0';
          tach_cnt_overflow <= '0';
          update_status_int <= '0';
          present_state <= '0';
      ELSIF (PCLK'EVENT AND PCLK = '1') THEN
          IF ((NOT(sresetn)) = '1') THEN
             tach_cnt <= "0000000000000000";
             tach_cnt_store <= "0000000000000000";
             tachin_sync0 <= '0';
             tachin_sync1 <= '0';
             tachin_sync2 <= '0';
             tachin_edge_det <= '0';
             tach_cnt_overflow <= '0';
             update_status_int <= '0';
             present_state <= '0';
	      ELSE
             IF (tach_cnt_clk = '1') THEN
                present_state <= next_state;
                tachin_sync0 <= TACHIN;
                tachin_sync1 <= tachin_sync0;
                tachin_sync2 <= tachin_sync1;
                tach_cnt_store <= tach_cnt_store_next;
                update_status_int <= update_status_next;
                tach_cnt <= tach_cnt_next;
                IF (tach_cnt_overflow_en = '1') THEN
                   tach_cnt_overflow <= '1';
                ELSIF (tachin_edge_det = '1') THEN
                   tach_cnt_overflow <= '0';
                END IF;
		    	
		    	IF(TACHMODE='0') THEN  
		    		IF(TACH_EDGE='1') THEN
		    			tachin_edge_det <= ((tachin_sync1) AND (NOT(tachin_sync2)));
		    		ELSE 
		    			tachin_edge_det <= ((NOT(tachin_sync1)) AND (tachin_sync2));
		    		END IF;
		    	ELSE -- TACHMODE=1
		    		IF(TACHSTATUS='0') THEN
		    			IF(TACH_EDGE='1') THEN
		    				tachin_edge_det <= ((tachin_sync1) AND (NOT(tachin_sync2)));
		    			ELSE 
		    				tachin_edge_det <= ((NOT(tachin_sync1)) AND (tachin_sync2));
		    			END IF;
		    		END IF;
		    	END IF;
		    	
             END IF;
          END IF;
      END IF;
   END PROCESS;
   
   
   -- State machine to generate tach counter
   PROCESS (tach_cnt_store, present_state, tachin_edge_det, tach_cnt_overflow, status_clear, TACHMODE, tach_cnt)
   BEGIN
      tach_cnt_store_next <= tach_cnt_store;
      tach_cnt_next <= "0000000000000000";
      update_status_next <= '0';
      next_state <= present_state;
      tach_cnt_overflow_en <= '0';
      CASE present_state IS
         
         WHEN cnt0 =>
            next_state <= cnt0;
            tach_cnt_overflow_en <= '0';
            IF (tachin_edge_det = '1') THEN
               tach_cnt_next <= "0000000000000000";
               next_state <= cnt1;
            END IF;
         
         WHEN cnt1 =>
            tach_cnt_store_next <= tach_cnt_store;
            update_status_next <= '0';
	    next_state <= cnt1;
            tach_cnt_overflow_en <= '0';
            IF (tachin_edge_det = '1') THEN
               tach_cnt_next <= "0000000000000000";
               tach_cnt_overflow_en <= '0';
               IF ((tach_cnt_overflow = '1') AND (status_clear = '1')) THEN
                  tach_cnt_store_next <= "0000000000000000";
               ELSE
                  IF ((TACHMODE = '1') AND (status_clear = '1')) THEN
                     tach_cnt_store_next <= tach_cnt + "0000000000000001";
                  ELSIF (TACHMODE = '0') THEN
                     IF (tach_cnt_overflow = '1') THEN
                        tach_cnt_store_next <= "0000000000000000";
                     ELSE
                        tach_cnt_store_next <= tach_cnt + "0000000000000001";
                     END IF;
                  END IF;
                  IF (status_clear = '1') THEN
                     update_status_next <= '1';
                  END IF;
               END IF;
            ELSE
               IF (tach_cnt_overflow = '0') THEN
                  tach_cnt_next <= tach_cnt + "0000000000000001";
                  IF (tach_cnt = "1111111111111111") THEN
                     tach_cnt_overflow_en <= '1';
                  END IF;
               END IF;
            END IF;
	  WHEN OTHERS  =>
            next_state <= cnt0;
      END CASE;
   END PROCESS;
   
   
END ARCHITECTURE trans;



