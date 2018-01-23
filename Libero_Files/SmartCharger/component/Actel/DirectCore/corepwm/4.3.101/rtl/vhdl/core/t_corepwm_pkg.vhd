package t_corepwm_pkg is
function SYNC_MODE_SEL( FAMILY: INTEGER) return INTEGER;
end t_corepwm_pkg;

package body t_corepwm_pkg is

	FUNCTION SYNC_MODE_SEL (FAMILY: INTEGER) RETURN INTEGER IS
        VARIABLE return_val : INTEGER := 0;
        BEGIN
		IF(FAMILY = 25) THEN
		    return_val := 1;
		ELSE
		    return_val := 0;
		END IF;
		RETURN return_val; 
	END SYNC_MODE_SEL;
		
end t_corepwm_pkg;