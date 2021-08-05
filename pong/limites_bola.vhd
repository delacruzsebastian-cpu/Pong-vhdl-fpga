LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
----------------------------------------------------------------
ENTITY limites_bola IS
	PORT	(	
				clk		:	IN	STD_LOGIC;
				rst		:	IN STD_LOGIC;
				
				x_s		:  IN	STD_LOGIC_VECTOR	(10 DOWNTO 0);
				y_s		: 	IN STD_LOGIC_VECTOR	(9 DOWNTO 0);
				
				p1_1		:	IN STD_LOGIC;
				p1_2		: 	IN STD_LOGIC;
				p1_3		:	IN STD_LOGIC;
				p1_4		: 	IN STD_LOGIC;	
				p1_5		:	IN STD_LOGIC;
				p1_6		: 	IN STD_LOGIC;
				p1_7		:	IN STD_LOGIC;			
				p1_8		: 	IN STD_LOGIC;
				p1_9		: 	IN STD_LOGIC;
				p1_10		:	IN STD_LOGIC;
				p1_11		: 	IN STD_LOGIC;
				
				p2_1		:	IN STD_LOGIC;
				p2_2		: 	IN STD_LOGIC;
				p2_3		:	IN STD_LOGIC;
				p2_4		: 	IN STD_LOGIC;
				p2_5		:	IN STD_LOGIC;
				p2_6		: 	IN STD_LOGIC;
				p2_7		:	IN STD_LOGIC;
				p2_8		: 	IN STD_LOGIC;
				p2_9		: 	IN STD_LOGIC;
				p2_10		:	IN STD_LOGIC;
				p2_11		: 	IN STD_LOGIC;
				
			   perdio1	:	OUT	 STD_LOGIC;
				perdio2	:	OUT	 STD_LOGIC;
				rst_b		:	BUFFER	 STD_LOGIC
				
	);
END ENTITY  limites_bola;

ARCHITECTURE fsm OF limites_bola IS
		
	SIGNAL 	xs					: INTEGER RANGE 1586 DOWNTO 0;
	SIGNAL 	ys					: INTEGER RANGE 524 DOWNTO 0;	
	SIGNAL	p1					:	STD_LOGIC;
	SIGNAL	p2					: 	STD_LOGIC;
	SIGNAL	p3					:	STD_LOGIC;
	SIGNAL	p4					: 	STD_LOGIC;
	SIGNAL	p5					:	STD_LOGIC;
	SIGNAL	p6					: 	STD_LOGIC;
	SIGNAL	p7					:	STD_LOGIC;
	SIGNAL	p8					: 	STD_LOGIC;
	SIGNAL	p9					: 	STD_LOGIC;
	SIGNAL	p10				:	STD_LOGIC;
	SIGNAL	p11				: 	STD_LOGIC;
	SIGNAL	paleta1			:	STD_LOGIC;
	SIGNAL	paleta2			: 	STD_LOGIC;
	
	TYPE state_b IS(per1 ,per2 ,r1 , rinicial);					
	SIGNAL pr_state_b	:	state_b;	

BEGIN	

--	xs	 <= CONV_INTEGER (x_s);
--	ys	 <= CONV_INTEGER (y_s);
	
	
	comp_x: ENTITY work.comparador_1
	PORT MAP (
				x 			=>  x_s,
	         paleta_1	=>  paleta1,
	         paleta_2	=>  paleta2				
				);	

	 posc_bola:ENTITY work.direccion_bolay  
		PORT MAP(
		       y		   		=>  y_s,
				 direccion_1	=>	 p1,
				 direccion_2	=>	 p2,
				 direccion_3	=>	 p3,
				 direccion_4	=>	 p4,
				 direccion_5	=>	 p5,
				 direccion_6	=>	 p6,
				 direccion_7	=>	 p7,
				 direccion_8	=>	 p8,
				 direccion_9	=>	 p9,
				 direccion_10	=>	 p10,
				 direccion_11	=>	 p11
			);	
	 
	combinational: 
	PROCESS(pr_state_b, xs,ys , rst, clk, paleta1, paleta2,	
				p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11,
				p1_1, p1_2, p1_3, p1_4, p1_5, p1_6, p1_7, p1_8, p1_9, p1_10, p1_11,
				p2_1, p2_2, p2_3, p2_4, p2_5, p2_6, p2_7, p2_8, p2_9, p2_10, p2_11)
	
BEGIN
	IF (rst = '1') THEN
		pr_state_b <= rinicial;

	ELSIF (rising_edge(clk)) THEN
			pr_state_b <= r1;
			
   IF (paleta1 = '1') THEN
		IF ((p1 ='1' AND p1_1 = '1') OR (p2 = '1' AND  p1_2 = '1') OR (p3 = '1' AND  p1_3 = '1') OR (p4 = '1' AND  p1_4 = '1') OR (p5 = '1' AND  p1_5 = '1') OR (p6 = '1' AND  p1_6 = '1') OR (p7 = '1' AND  p1_7 = '1') OR (p8 = '1' AND  p1_8 = '1') OR (p9 = '1' AND  p1_9 = '1') OR (p10 = '1' AND  p1_10 = '1')OR (p11 = '1' AND  p1_11 = '1')) THEN
			pr_state_b <= r1;
			ELSE 
			pr_state_b <= per1;
			END IF;
	ELSIF(paleta2 = '1') THEN 
	   IF ((p1 ='1' AND p2_1 = '1') OR (p2 = '1' AND  p2_2 = '1') OR (p3 = '1' AND  p2_3 = '1') OR (p4 = '1' AND  p2_4 = '1') OR (p5 = '1' AND  p2_5 = '1') OR (p6 = '1' AND  p2_6 = '1') OR (p7 = '1' AND  p2_7 = '1') OR (p8 = '1' AND  p2_8 = '1') OR (p9 = '1' AND  p2_9 = '1') OR (p10 = '1' AND  p2_10 = '1')OR (p11 = '1' AND  p2_11 = '1')) THEN
					pr_state_b <= r1;
			ELSE 
			pr_state_b <= per2;
			END IF;
		ELSE pr_state_b <= r1;	
	END IF;
END IF;
END PROCESS; 

--LOGICA DE SALIDA 

PROCESS(pr_state_b)
BEGIN	
	case pr_state_b is
		WHEN per1 =>
					perdio1	<=	'1';
					perdio2	<=	'0';
					rst_b		<=	'1';

		WHEN per2 =>
					perdio1	<=	'0';
					perdio2	<=	'1';
					rst_b		<=	'1';
					
		WHEN r1 =>
					perdio1	<=	'0';
					perdio2	<=	'0';
					rst_b		<=	'0';
		WHEN rinicial =>
					perdio1	<=	'0';
					perdio2	<=	'0';
					rst_b		<=	'1';

		END CASE;
	END PROCESS;	
END ARCHITECTURE fsm;