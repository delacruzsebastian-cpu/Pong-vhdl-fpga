LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------------
ENTITY posiciones IS
	PORT	(	clk		:	IN		STD_LOGIC;
				rst		:	IN		STD_LOGIC;
				Arriba_1	:	IN		 STD_LOGIC;
				Abajo_1	:	IN		 STD_LOGIC;
				posc_1	:	OUT	STD_LOGIC;
				posc_2	:	OUT	STD_LOGIC;
				posc_3	:	OUT	STD_LOGIC;
				posc_4	:	OUT	STD_LOGIC;
				posc_5	:	OUT	STD_LOGIC;
				posc_6	:	OUT	STD_LOGIC;
				posc_7	:	OUT	STD_LOGIC;
				posc_8	:	OUT	STD_LOGIC;
				posc_9	:	OUT	STD_LOGIC;
				posc_10	:	OUT	STD_LOGIC;
				posc_11	:	OUT	STD_LOGIC
		
	);
END ENTITY posiciones;
----------------------------------------------------------------

ARCHITECTURE fsm OF posiciones IS
	TYPE state IS(posicion1, posicion2, posicion3, posicion4, posicion5, posicion6, posicion7, posicion8, posicion9, posicion10,
					posicion11 
						);					
	SIGNAL pr_state	:	state;
	SIGNAL max_tickestados : STD_LOGIC;
	
BEGIN
combinational: 
	PROCESS(pr_state, Arriba_1 , Abajo_1 , rst, clk )
	
BEGIN
	IF (rst = '1') THEN
		pr_state <= posicion1;

	ELSIF (clk'EVENT and clk = '1') THEN

CASE pr_state IS

WHEN posicion1 =>
	IF (pr_state = posicion1) THEN
		IF (Abajo_1 = '1' AND	Arriba_1 = '1') THEN
			pr_state <= posicion2;
			ELSIF (Abajo_1 = '0' AND Arriba_1 = '0') THEN
			pr_state <= posicion7;
			ELSE
			pr_state <= posicion1;
			END IF;
	END IF;
	
WHEN posicion2 =>
	IF (pr_state = posicion2) THEN
		IF (Abajo_1 = '1' AND Arriba_1 = '1') THEN
			pr_state <= posicion3;
		ELSIF (Abajo_1 = '0' AND Arriba_1 = '0') THEN
				pr_state <= posicion1;
		ELSE
			pr_state <= posicion2;
		END IF;
	END IF;
	
WHEN posicion3 =>

	IF (pr_state = posicion3) THEN
		IF (Abajo_1 = '1' AND Arriba_1 = '1') THEN
			pr_state <= posicion4;
		ELSIF (Abajo_1 = '0' AND Arriba_1 = '0') THEN
			pr_state <= posicion2;
		ELSE
		pr_state <= posicion3;
		END IF;
	END IF;
	
WHEN posicion4 =>

	IF (pr_state = posicion4) THEN
		IF (Abajo_1 = '1' AND Arriba_1 = '1') THEN
			pr_state <= posicion5;
		ELSIF (Abajo_1 = '0' AND Arriba_1 = '0') THEN
				pr_state <= posicion3;
		ELSE
			pr_state <= posicion4;
		END IF;
	END IF;	

WHEN posicion5 =>

	IF (pr_state = posicion5) THEN
		IF (Abajo_1 = '1' AND Arriba_1 = '1') THEN
			pr_state <= posicion6;
		ELSIF (Abajo_1 = '0' AND Arriba_1 = '0') THEN
				pr_state <= posicion4;
		ELSE
			pr_state <= posicion5;
		END IF;
	END IF;
	
WHEN posicion6 =>
	IF (pr_state = posicion6) THEN
		IF (Abajo_1 = '1' AND Arriba_1 = '1') THEN
			pr_state <= posicion6;
		ELSIF (Abajo_1 = '0' AND Arriba_1 = '0') THEN
				pr_state <= posicion5;
		ELSE
			pr_state <= posicion6;
		END IF;
	END IF;
	
WHEN posicion7 =>
	IF (pr_state = posicion7) THEN
		IF (Abajo_1 = '1' AND Arriba_1 = '1') THEN
			pr_state <= posicion1;
		ELSIF (Abajo_1 = '0' AND Arriba_1 = '0') THEN
				pr_state <= posicion8;
		ELSE
			pr_state <= posicion7;
		END IF;
	END IF;
	
WHEN posicion8 =>

	IF (pr_state = posicion8) THEN
		IF (Abajo_1 = '1' AND Arriba_1 = '1') THEN
		pr_state <= posicion7;
		ELSIF (Abajo_1 = '0' AND Arriba_1 = '0') THEN
			pr_state <= posicion9;
		ELSE
			pr_state <= posicion8;
		END IF;
	END IF;
	
WHEN posicion9 =>

	IF (pr_state = posicion9) THEN
		IF (Abajo_1 = '1' AND Arriba_1 = '1') THEN
			pr_state <= posicion8;
		ELSIF (Abajo_1 = '0' AND Arriba_1 = '0') THEN
				pr_state <= posicion10;
		ELSE
			pr_state <= posicion9;
		END IF;
	END IF;	

WHEN posicion10 =>

	IF (pr_state = posicion10) THEN
		IF (Abajo_1 = '1' AND Arriba_1 = '1') THEN
			pr_state <= posicion9;
		ELSIF (Abajo_1 = '0' AND Arriba_1 = '0') THEN
				pr_state <= posicion11;
		ELSE
			pr_state <= posicion10;
		END IF;
	END IF;

WHEN posicion11 =>
	IF (pr_state = posicion11) THEN
		IF (Abajo_1 = '1' AND Arriba_1 = '1') THEN
			pr_state <= posicion10;
		ELSIF (Abajo_1 = '0' AND Arriba_1 = '0') THEN
				pr_state <= posicion11;
		ELSE
			pr_state <= posicion11;
		END IF;
	END IF;
	
END CASE;
END IF;
END PROCESS; 

--LOGICA DE SALIDA 

PROCESS(pr_state)
BEGIN 
	
	case pr_state is
			WHEN posicion1 =>
					posc_1	<=	'1';
					posc_2	<=	'0';
					posc_3	<=	'0';
					posc_4	<=	'0';
					posc_5	<=	'0';
					posc_6	<=	'0';
					posc_7	<=	'0';
					posc_8	<=	'0';
					posc_9	<=	'0';
					posc_10	<=	'0';
					posc_11	<=	'0';

		WHEN posicion2 =>
					posc_1	<=	'0';
					posc_2	<=	'1';
					posc_3	<=	'0';
					posc_4	<=	'0';
					posc_5	<=	'0';
					posc_6	<=	'0';
					posc_7	<=	'0';
					posc_8	<=	'0';
					posc_9	<=	'0';
					posc_10	<=	'0';
					posc_11	<=	'0';
		
		WHEN posicion3 =>    
					posc_1	<=	'0';
					posc_2	<=	'0';
					posc_3	<=	'1';
					posc_4	<=	'0';
					posc_5	<=	'0';
					posc_6	<=	'0';
					posc_7	<=	'0';
					posc_8	<=	'0';
					posc_9	<=	'0';
					posc_10	<=	'0';
					posc_11	<=	'0';

					
		WHEN posicion4 =>
					posc_1	<=	'0';
					posc_2	<=	'0';
					posc_3	<=	'0';
					posc_4	<=	'1';
					posc_5	<=	'0';
					posc_6	<=	'0';
					posc_7	<=	'0';
					posc_8	<=	'0';
					posc_9	<=	'0';
					posc_10	<=	'0';
					posc_11	<=	'0';

					
		WHEN posicion5 =>
					posc_1	<=	'0';
					posc_2	<=	'0';
					posc_3	<=	'0';
					posc_4	<=	'0';
					posc_5	<=	'1';
					posc_6	<=	'0';
					posc_7	<=	'0';
					posc_8	<=	'0';
					posc_9	<=	'0';
					posc_10	<=	'0';
					posc_11	<=	'0';

					
		WHEN posicion6 =>
					posc_1	<=	'0';
					posc_2	<=	'0';
					posc_3	<=	'0';
					posc_4	<=	'0';
					posc_5	<=	'0';
					posc_6	<=	'1';
					posc_7	<=	'0';
					posc_8	<=	'0';
					posc_9	<=	'0';
					posc_10	<=	'0';
					posc_11	<=	'0';
	
		
		WHEN posicion7 =>
					posc_1	<=	'0';
					posc_2	<=	'0';
					posc_3	<=	'0';
					posc_4	<=	'0';
					posc_5	<=	'0';
					posc_6	<=	'0';
					posc_7	<=	'1';
					posc_8	<=	'0';
					posc_9	<=	'0';
					posc_10	<=	'0';
					posc_11	<=	'0';

		
		WHEN posicion8 =>    
					posc_1	<=	'0';
					posc_2	<=	'0';
					posc_3	<=	'0';
					posc_4	<=	'0';
					posc_5	<=	'0';
					posc_6	<=	'0';
					posc_7	<=	'0';
					posc_8	<=	'1';
					posc_9	<=	'0';
					posc_10	<=	'0';
					posc_11	<=	'0';

					
		WHEN posicion9 =>
					posc_1	<=	'0';
					posc_2	<=	'0';
					posc_3	<=	'0';
					posc_4	<=	'0';
					posc_5	<=	'0';
					posc_6	<=	'0';
					posc_7	<=	'0';
					posc_8	<=	'0';
					posc_9	<=	'1';
					posc_10	<=	'0';
					posc_11	<=	'0';
					
		WHEN posicion10 =>
					posc_1	<=	'0';
					posc_2	<=	'0';
					posc_3	<=	'0';
					posc_4	<=	'0';
					posc_5	<=	'0';
					posc_6	<=	'0';
					posc_7	<=	'0';
					posc_8	<=	'0';
					posc_9	<=	'0';
					posc_10	<=	'1';
					posc_11	<=	'0';
				
		WHEN posicion11 =>
					posc_1	<=	'0';
					posc_2	<=	'0';
					posc_3	<=	'0';
					posc_4	<=	'0';
					posc_5	<=	'0';
					posc_6	<=	'0';
					posc_7	<=	'0';
					posc_8	<=	'0';
					posc_9	<=	'0';
					posc_10	<=	'0';
					posc_11	<=	'1';
					
		
					
	END CASE;
	END PROCESS;
	END ARCHITECTURE ;