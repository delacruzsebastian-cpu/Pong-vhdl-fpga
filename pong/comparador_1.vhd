LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
----------------------------------------------------------------
ENTITY comparador_1 IS
	PORT ( x						: IN  STD_LOGIC_VECTOR (10 DOWNTO 0);
			 paleta_1			: OUT  STD_LOGIC;
			 paleta_2			: OUT STD_LOGIC);
			 
END ENTITY comparador_1;
----------------------------------------------------------------

ARCHITECTURE fsm OF comparador_1 IS
	SIGNAL x_s		: STD_LOGIC;
	SIGNAL x_ss		: INTEGER RANGE 1586 DOWNTO 0;
	SIGNAL x2_s		: STD_LOGIC;
	
	BEGIN
	x_ss	 <= CONV_INTEGER (x);
	
	PROCESS(x)
		BEGIN	
		
			IF (x_ss<49) THEN
				x_s <= '1';
				
			ELSE
				x_s <= '0';
			
		END IF; 
			IF (x_ss>1208) THEN
				x2_s <= '1';
				
			ELSE
				x2_s <= '0';
			
		END IF; 
	END PROCESS;	
		  paleta_1	<=  x_s;
		  paleta_2  <=  x2_s;

END ARCHITECTURE ;