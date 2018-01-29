-- ********************************************************************
-- Actel Corporation Proprietary and Confidential
--  Copyright 2008 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description: CoreUART/ CoreUARTapb UART core
--
--
--  Revision Information:
-- Date     Description
-- Jun09    Revision 4.1
-- Aug10    Revision 4.2
-- 

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

entity SF2_MSS_sys_sb_CoreUARTapb_0_Clock_gen is 
             GENERIC (BAUD_VAL_FRCTN_EN :  integer := 0;
                      SYNC_RESET        :  integer := 0);
             port ( clk               : in   std_logic;                     -- system clock
                    reset_n           : in   std_logic;                     -- active low async reset
                    baud_val          : in   std_logic_vector(12 downto 0); -- value loaded into cntr  
                    BAUD_VAL_FRACTION : in   std_logic_vector(2 downto 0);  -- fractional part of baud value 
                    baud_clock        : out  std_logic;                     -- 16x baud clock pulse
                    xmit_pulse        : out  std_logic                      -- transmit pulse
             );
end entity SF2_MSS_sys_sb_CoreUARTapb_0_Clock_gen;

architecture rtl of SF2_MSS_sys_sb_CoreUARTapb_0_Clock_gen is


signal baud_cntr        : std_logic_vector(12 downto 0);             -- 16x clock division counter reg.
signal baud_clock_int   : std_logic;                                -- internal 16x baud clock pulse
signal xmit_clock       : std_logic;                                
signal xmit_cntr        : std_logic_vector(3 downto 0);              -- baud tx counter reg.
signal baud_cntr_one    : std_logic;
signal aresetn          : std_logic;
signal sresetn          : std_logic;

begin
aresetn <= '1' WHEN (SYNC_RESET=1) ELSE reset_n;
sresetn <= reset_n WHEN (SYNC_RESET=1) ELSE '1';
  --------------------------------------------------
  -- generate a x16 baud clock pulse
  --------------------------------------------------
UG09:IF(BAUD_VAL_FRCTN_EN = 1) GENERATE

    -- Add one cycle 1/8, 2/8, 3/8, 4/8, 5/8, 6/8, 7/8 of the time by freezing 
    -- baud_cntr for one cycle when count reaches 0 for certain xmit_cntr values.
    -- xmit_cntr values are identifed by looking for bits of this counter
    -- being certain combinations.
    
    make_baud_cntr_one: process(clk,aresetn)
    begin
        if (aresetn = '0') then
            baud_cntr_one <= '0';
        elsif(clk'event and clk='1') then
            if (sresetn = '0') then
                baud_cntr_one <= '0';
		    else
                if (baud_cntr = "0000000000001") then
                    baud_cntr_one <= '1';
                else
                    baud_cntr_one <= '0';
                end if;
            end if;
        end if;
    end process make_baud_cntr_one;

     make_baud_cntr1: process(clk, aresetn)
         begin 
           if (aresetn = '0') then
                baud_cntr <= "0000000000000";
                baud_clock_int <= '0';
           elsif(clk'event and clk='1') then
                if (sresetn = '0') then
                    baud_cntr <= "0000000000000";
                    baud_clock_int <= '0';
			    else
                     case BAUD_VAL_FRACTION is
                        when "000" => if (baud_cntr = "0000000000000") then      --0
                                         baud_cntr <= baud_val;
                                         baud_clock_int <= '1';
                                      else
                                          baud_cntr <= baud_cntr - '1';
                                          baud_clock_int <= '0';
                                      end if;
                
                        when "001" => if (baud_cntr = "0000000000000") then
                                        if (xmit_cntr(2 downto 0) = "111" and baud_cntr_one = '1') then  --0.125
                                           baud_cntr <= baud_cntr;
                                           baud_clock_int <= '0';
                                        else
                                             baud_cntr <= baud_val;
                                             baud_clock_int <= '1';
                                        end if;
                                      else
                                          baud_cntr <= baud_cntr - '1';
                                          baud_clock_int <= '0';
                                      end if;
                
                        when "010" =>  if (baud_cntr = "0000000000000") then
                                        if (xmit_cntr(1 downto 0) = "11" and baud_cntr_one = '1') then --0.25
                                          baud_cntr <= baud_cntr;
                                          baud_clock_int <= '0';
                                        else
                                          baud_cntr <= baud_val;
                                          baud_clock_int <= '1';
                                         end if;
                                      else
                                        baud_cntr <= baud_cntr - '1';
                                        baud_clock_int <= '0';
                                      end if;                
                                          
                        when "011" => if (baud_cntr = "0000000000000") then
                                        if ((((xmit_cntr(2) = '1') or (xmit_cntr(1) = '1')) and xmit_cntr(0) ='1') and (baud_cntr_one = '1')) then --0.375
                                          baud_cntr <= baud_cntr;
                                          baud_clock_int <= '0';
                                        else
                                          baud_cntr <= baud_val;
                                          baud_clock_int <= '1';
                                         end if;
                                      else
                                         baud_cntr <= baud_cntr - '1';
                                         baud_clock_int <= '0';
                                   end if;
                
                        when "100" => if (baud_cntr = "0000000000000") then
                                        if (xmit_cntr(0) = '1' and baud_cntr_one = '1') then --0.5
                                          baud_cntr <= baud_cntr;
                                          baud_clock_int <= '0';
                                        else
                                          baud_cntr <= baud_val;
                                          baud_clock_int <= '1';
                                        end if;
                                      else
                                        baud_cntr <= baud_cntr - '1';
                                        baud_clock_int <= '0';
                                     end if;
                
                       when "101" => if (baud_cntr = "0000000000000") then
                                       if (((xmit_cntr(2) = '1' and xmit_cntr(1) = '1') or xmit_cntr(0) = '1') and baud_cntr_one = '1') then --0.625  
                                          baud_cntr <= baud_cntr;
                                          baud_clock_int <= '0';
                                       else
                                          baud_cntr <= baud_val;
                                          baud_clock_int <= '1';
                                       end if;
                                     else
                                      baud_cntr <= baud_cntr - '1';
                                      baud_clock_int <= '0';
                                     end if;
                
                       when "110" => if (baud_cntr = "0000000000000") then
                                       if ((xmit_cntr(1) = '1' or xmit_cntr(0) = '1') and baud_cntr_one = '1') then -- 0.75
                                          baud_cntr <= baud_cntr;
                                          baud_clock_int <= '0';
                                       else
                                          baud_cntr <= baud_val;
                                          baud_clock_int <= '1';
                                       end if;
                                     else
                                      baud_cntr <= baud_cntr - '1';
                                      baud_clock_int <= '0';
                                     end if;
                
                        when "111" => if (baud_cntr = "0000000000000") then
                                     if (((xmit_cntr(1) = '1' or xmit_cntr(0) = '1') or xmit_cntr(2 downto 0) = "100") and baud_cntr_one = '1') then --  0.875
                                          baud_cntr <= baud_cntr;
                                          baud_clock_int <= '0';
                                       else
                                          baud_cntr <= baud_val;
                                          baud_clock_int <= '1';
                                       end if;
                                     else
                                      baud_cntr <= baud_cntr - '1';
                                      baud_clock_int <= '0';
                                     end if;
                
                        when others => if (baud_cntr = "0000000000000") then      --0
                                         baud_cntr <= baud_val;
                                         baud_clock_int <= '1';
                                       else
                                          baud_cntr <= baud_cntr - '1';
                                          baud_clock_int <= '0';
                                       end if;
                     end case;
                end if;
            end if;
    end process make_baud_cntr1;
END GENERATE;
 
UG10:IF(BAUD_VAL_FRCTN_EN= 0) GENERATE
      make_baud_cntr2:process(clk,aresetn)
       begin 
           if (aresetn = '0') then
                baud_cntr <= "0000000000000";
                baud_clock_int <= '0';
           elsif(clk'event and clk='1') then
                if (sresetn = '0') then
                    baud_cntr <= "0000000000000";
                    baud_clock_int <= '0';
			    else
                     if (baud_cntr = "0000000000000") then      
                         baud_cntr <= baud_val;
                         baud_clock_int <= '1';
                     else
                         baud_cntr <= baud_cntr - '1';
                         baud_clock_int <= '0';
                     end if;
                end if;
            end if;
         end process make_baud_cntr2;
END GENERATE;
                  
  --baud_clock_int <= '1' when baud_cntr = "00000000" else
  --                  '0';                       

  ----------------------------------------------------
  -- generate a transmit clock pulse
  ----------------------------------------------------

  make_xmit_clock: process(clk,aresetn)
                   begin
                       if(aresetn = '0') then
                           xmit_cntr <= "0000";
                           xmit_clock <= '0';
                       elsif(clk'event and clk='1') then
                           if(sresetn = '0') then
                               xmit_cntr <= "0000";
                               xmit_clock <= '0';
                           else
                               if(baud_clock_int = '1') then
                                   xmit_cntr <= xmit_cntr + '1';
                                   if(xmit_cntr = "1111") then
                                       xmit_clock <= '1';
                                   else
                                       xmit_clock <= '0';
                                   end if;
                               end if;
                           end if;
                       end if;
                   end process;

xmit_pulse <= xmit_clock and baud_clock_int;
baud_clock <= baud_clock_int;


end rtl;
