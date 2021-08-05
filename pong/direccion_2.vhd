LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
----------------------------------------------------------------
ENTITY direccion_2 IS
	PORT ( actual_regx		: IN  STD_LOGIC_VECTOR (10 DOWNTO 0);
			 actual_regy		: IN  STD_LOGIC_VECTOR (9 DOWNTO 0);
			 siguiente_regx	: OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
			 siguiente_regy	: OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
			);
END ENTITY direccion_2;
----------------------------------------------------------------

ARCHITECTURE fsm OF direccion_2 IS
	SIGNAL siguienteregx_s	: INTEGER RANGE 1586 DOWNTO 0;
	SIGNAL siguienteregy_s	: INTEGER RANGE 524 DOWNTO 0;
	SIGNAL siguienteregx_ss	: INTEGER RANGE 1586 DOWNTO 0;
	SIGNAL siguienteregy_ss	: INTEGER RANGE 524 DOWNTO 0;
	
	BEGIN
	siguienteregx_s	 <= CONV_INTEGER (actual_regx);
	siguienteregy_s	 <= CONV_INTEGER (actual_regy);
	
		PROCESS(siguienteregx_s,siguienteregy_s)
BEGIN	
	IF (siguienteregx_s > 0 AND siguienteregx_s < 1586 AND siguienteregy_s > 0 AND siguienteregy_s < 514) THEN
				siguienteregx_ss <= siguienteregx_s +1;
				siguienteregy_ss <= siguienteregy_s +1;
		ELSE 
				siguienteregx_ss <= siguienteregx_s;
				siguienteregy_ss <= siguienteregy_s;
	END IF;
	END PROCESS;
		  siguiente_regx	<= STD_LOGIC_VECTOR(TO_UNSIGNED (siguienteregx_ss,11));
		  siguiente_regy	<= STD_LOGIC_VECTOR(TO_UNSIGNED (siguienteregy_ss,10));

END ARCHITECTURE ;