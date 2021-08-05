LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
----------------------------------------------------------------
ENTITY direccion_bolay IS
	PORT ( y						: IN  STD_LOGIC_VECTOR (9 DOWNTO 0);
			 direccion_1		: OUT STD_LOGIC;
			 direccion_2		: OUT STD_LOGIC;
			 direccion_3		: OUT STD_LOGIC;
			 direccion_4		: OUT STD_LOGIC;
			 direccion_5		: OUT STD_LOGIC;
			 direccion_6		: OUT STD_LOGIC;
			 direccion_7		: OUT STD_LOGIC;
			 direccion_8		: OUT STD_LOGIC;
			 direccion_9		: OUT STD_LOGIC;
			 direccion_10		: OUT STD_LOGIC;
			 direccion_11		: OUT STD_LOGIC);
			 
END ENTITY direccion_bolay;
----------------------------------------------------------------

ARCHITECTURE fsm OF direccion_bolay IS
	SIGNAL y_s		: STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL y_ss		: INTEGER RANGE 524 DOWNTO 0;
	
	BEGIN
	y_ss	 <= CONV_INTEGER (y);
	
	PROCESS(y_ss)
		BEGIN	
		
			IF (y_ss<297 AND y_ss>227) THEN
				y_s(0) <= '1';
				
			ELSE
				y_s(0) <= '0';
			
		END IF; 
			IF (y_ss<332 AND y_ss>262) THEN
				y_s(1) <= '1';
				
			ELSE
				y_s(1) <= '0';
			
		END IF; 
			IF (y_ss<367 AND y_ss>297) THEN
				y_s(2) <= '1';
				
			ELSE
				y_s(2) <= '0';
			
		END IF; 
			IF (y_ss<402 AND y_ss>332) THEN
				y_s(3) <= '1';
				
			ELSE
				y_s(3) <= '0';
			
		END IF; 
			IF (y_ss<437 AND y_ss>367) THEN
				y_s(4) <= '1';
				
			ELSE
				y_s(4) <= '0';
			
		END IF; 
			IF (y_ss<472 AND y_ss>402) THEN
				y_s(5) <= '1';
				
			ELSE
				y_s(5) <= '0';
			
		END IF; 
			IF (y_ss<262 AND y_ss>192) THEN
				y_s(6) <= '1';
				
			ELSE
				y_s(6) <= '0';
			
		END IF; 
			IF (y_ss<227  AND y_ss>157) THEN
				y_s(7) <= '1';
				
			ELSE
				y_s(7) <= '0';
			
		END IF; 
			IF (y_ss<192 AND y_ss>122) THEN
				y_s(8) <= '1';
				
			ELSE
				y_s(8) <= '0';
			
		END IF; 
			IF (y_ss<157 AND y_ss>87) THEN
				y_s(9) <= '1';
				
			ELSE
				y_s(9) <= '0';
			
		END IF; 
			IF (y_ss<122 AND y_ss>52) THEN
				y_s(10) <= '1';
				
			ELSE
				y_s(10) <= '0';
			
		END IF; 



	END PROCESS;	
	
		  direccion_1	<= y_s(0);
		  direccion_2	<= y_s(1);
		  direccion_3	<= y_s(2);
		  direccion_4	<= y_s(3);
		  direccion_5	<= y_s(4);
		  direccion_6	<= y_s(5);
		  direccion_7	<= y_s(6);
		  direccion_8	<= y_s(7);
		  direccion_9	<= y_s(8);
		  direccion_10	<= y_s(9);
		  direccion_11	<= y_s(10);

END ARCHITECTURE ;