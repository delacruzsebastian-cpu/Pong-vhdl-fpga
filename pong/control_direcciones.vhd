LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
----------------------------------------------------------------
ENTITY control_direcciones IS
	PORT	(	clk			:	IN		STD_LOGIC;
				rst			:	IN		STD_LOGIC;
				actual_regx	:	IN		STD_LOGIC_VECTOR(10 DOWNTO 0);
				actual_regy :	IN		STD_LOGIC_VECTOR(9 DOWNTO 0);
				dir_1			:	OUT	STD_LOGIC;
				dir_2			:	OUT	STD_LOGIC;
				dir_3			:	OUT	STD_LOGIC;
				dir_4			:	OUT	STD_LOGIC
				);
END ENTITY control_direcciones;
----------------------------------------------------------------

ARCHITECTURE fsm OF control_direcciones IS

	SIGNAL actualregx_s		: INTEGER RANGE 1586 DOWNTO 0;
	SIGNAL actualregy_s		: INTEGER RANGE 524 DOWNTO 0;

	TYPE state IS(direccion1, direccion2, direccion3, direccion4);					
	SIGNAL pr_state	:	state;
	SIGNAL max_tickestados : STD_LOGIC;
	
BEGIN

 actualregx_s <= CONV_INTEGER (actual_regx); 
 actualregy_s <= CONV_INTEGER (actual_regy);

combinational: 
	PROCESS(pr_state, actualregx_s, actualregy_s , rst, clk )
	
BEGIN
	IF (rst = '1') THEN
		pr_state <= direccion1;

	ELSIF (clk'EVENT and clk = '1') THEN

CASE pr_state IS

WHEN direccion1 =>
	IF (pr_state = direccion1) THEN
		IF (actualregy_s> 52 AND actualregx_s>49  AND actualregx_s<1209) THEN
				pr_state	<=	direccion1; 
				ELSIF (actualregy_s= 52 AND actualregx_s>49  AND actualregx_s<1209) THEN
					pr_state <= direccion2;
					ELSIF (actualregy_s> 52 AND actualregx_s=1209) THEN
						pr_state <= direccion4;
		ELSE pr_state <= direccion1;
		END IF;
	END IF;
	
WHEN direccion2 =>
	IF (pr_state = direccion2) THEN
		IF (actualregy_s<470 AND actualregx_s>49  AND actualregx_s<1209) THEN
				pr_state	<=	direccion2;
				ELSIF (actualregy_s<470 AND actualregx_s=1209) THEN
					pr_state <= direccion3;
					ELSIF (actualregy_s=470 AND actualregx_s>49  AND actualregx_s<1209) THEN
						pr_state <= direccion1;
		ELSE pr_state <= direccion2;
		END IF;
	END IF;
	
WHEN direccion3 =>

	IF (pr_state = direccion3) THEN
		IF (actualregy_s<470 AND actualregx_s>49  AND actualregx_s<1209) THEN
				pr_state	<=	direccion3;
				ELSIF (actualregy_s= 470 AND actualregx_s>49  AND actualregx_s<1209) THEN
					pr_state <= direccion4;
					ELSIF (actualregy_s<470 AND actualregx_s=49) THEN
						pr_state <= direccion2;
		ELSE pr_state <= direccion3;
		END IF;
	END IF;
	
WHEN direccion4 =>

	IF (pr_state = direccion4) THEN
		IF (actualregy_s> 52 AND actualregx_s>49  AND actualregx_s<1209) THEN
				pr_state	<=	direccion4;
				ELSIF (actualregy_s= 52 AND actualregx_s>49  AND actualregx_s<1209) THEN
					pr_state <= direccion3;
					ELSIF (actualregy_s> 52 AND actualregx_s=49) THEN
						pr_state <= direccion1;
		ELSE pr_state <= direccion4;
		END IF;
	END IF;	
	
END CASE;
END IF;
END PROCESS; 

--LOGICA DE SALIDA 

PROCESS(pr_state)
BEGIN 
	
	case pr_state is

		WHEN direccion1 =>
					dir_1	<=	'1';
					dir_2	<=	'0';
					dir_3	<=	'0';
					dir_4	<=	'0';

		WHEN direccion2 =>
					dir_1	<=	'0';
					dir_2	<=	'1';
					dir_3	<=	'0';
					dir_4	<=	'0';
		
		WHEN direccion3 =>  
					dir_1	<=	'0';
					dir_2	<=	'0';
					dir_3	<=	'1';
					dir_4	<=	'0';
					
		WHEN direccion4 =>
					dir_1	<=	'0';
					dir_2	<=	'0';
					dir_3	<=	'0';
					dir_4	<=	'1';
									
	END CASE;
	END PROCESS;
	END ARCHITECTURE ;