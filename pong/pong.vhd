LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
----------------------------------------------------------------
ENTITY pong IS
	PORT	(	clk		:	IN		 STD_LOGIC;
				rst		:	IN		 STD_LOGIC;
				start    :  IN		 STD_LOGIC;
				Arriba_1	:	IN		 STD_LOGIC;
				Abajo_1	:	IN		 STD_LOGIC;
				Arriba_2	:	IN		 STD_LOGIC;
				Abajo_2	:	IN		 STD_LOGIC;
				vsync		:	OUT	 STD_LOGIC;
				hsync		:	OUT 	 STD_LOGIC;
				siete_segmentos1	:	OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				siete_segmentos2	:	OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				R			:	OUT 	 STD_LOGIC_VECTOR (3 DOWNTO 0);
				G			:	OUT	 STD_LOGIC_VECTOR (3 DOWNTO 0);
				B			:	OUT	 STD_LOGIC_VECTOR (3 DOWNTO 0)
				
	);
END ENTITY  pong;

ARCHITECTURE fsm OF pong IS
	
	SIGNAL	R_paleta1				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	G_paleta1				:  STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	B_paleta1				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	R_paleta2				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	G_paleta2				:  STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	B_paleta2				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	R_bola	            :	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	G_bola		   		:  STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	B_bola      			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL   v_sync_2             :  STD_LOGIC;
	SIGNAL   h_sync_2             :  STD_LOGIC;
	SIGNAL   v_sync_1             :  STD_LOGIC;
	SIGNAL   h_sync_1             :  STD_LOGIC;
	SIGNAL   vsync_0              :  STD_LOGIC;
	SIGNAL   hsync_0              :  STD_LOGIC;
	SIGNAL   blank_1              :  STD_LOGIC;
	SIGNAL   max_tickestados      :  STD_LOGIC;
	SIGNAL   blank_s              :  STD_LOGIC;
	SIGNAL	p1_1						:	STD_LOGIC;
	SIGNAL	p1_2						: 	STD_LOGIC;
	SIGNAL	p1_3						:	STD_LOGIC;
	SIGNAL	p1_4						: 	STD_LOGIC;
	SIGNAL	p1_5						:	STD_LOGIC;
	SIGNAL	p1_6						: 	STD_LOGIC;
	SIGNAL	p1_7						:	STD_LOGIC;
	SIGNAL	p1_8						: 	STD_LOGIC;
	SIGNAL	p1_9						: 	STD_LOGIC;
	SIGNAL	p1_10						:	STD_LOGIC;
	SIGNAL	p1_11						: 	STD_LOGIC;
	SIGNAL	p2_1						:	STD_LOGIC;
	SIGNAL	p2_2						: 	STD_LOGIC;
	SIGNAL	p2_3						:	STD_LOGIC;
	SIGNAL	p2_4						: 	STD_LOGIC;
	SIGNAL	p2_5						:	STD_LOGIC;
	SIGNAL	p2_6						: 	STD_LOGIC;
	SIGNAL	p2_7						:	STD_LOGIC;
	SIGNAL	p2_8						: 	STD_LOGIC;
	SIGNAL	p2_9						: 	STD_LOGIC;
	SIGNAL	p2_10						:	STD_LOGIC;
	SIGNAL	p2_11						: 	STD_LOGIC;
	SIGNAL	x_s						: 	STD_LOGIC_VECTOR	(10 DOWNTO 0);
	SIGNAL	y_s						: 	STD_LOGIC_VECTOR	(9 DOWNTO 0);
	SIGNAL 	xs							: INTEGER RANGE 1586 DOWNTO 0;
	SIGNAL 	ys							: INTEGER RANGE 524 DOWNTO 0;	
	SIGNAL  perdio1 , perdio2 , rst_b, min_tick_s  : STD_LOGIC;
	SIGNAL	numero1, numero2		:	STD_LOGIC_VECTOR	(2 DOWNTO 0);
	SIGNAL	rst_f_1, rst_f_2	:	STD_LOGIC;
	
	TYPE state IS (st1, st2, st3);
	SIGNAL pr_state, nx_state	:	state;
   
	

BEGIN	

	xs	 <= CONV_INTEGER (x_s);
	ys	 <= CONV_INTEGER (y_s);
  
  limites_bola :ENTITY work.limites_bola  
		PORT MAP(
		      clk		=> clk,
				rst		=> rst OR rst_f_1 OR rst_f_2,
			
				x_s      => x_s,
				y_s		=> y_s,
				
				p1_1   		=>	p1_1,
				p1_2   		=>	p1_2,
				p1_3   		=>	p1_3,
				p1_4  		=>	p1_4,
				p1_5			=>	p1_5,
				p1_6   		=>	p1_6,
				p1_7  		=>	p1_7,
				p1_8   		=>	p1_8,
				p1_9   		=>	p1_9,
				p1_10			=>	p1_10,
				p1_11  		=>	p1_11,
				
				p2_1   		=>	p2_1,
				p2_2   		=>	p2_2,
				p2_3   		=>	p2_3,
				p2_4  		=>	p2_4,
				p2_5			=>	p2_5,
				p2_6   		=>	p2_6,
				p2_7  		=>	p2_7,
				p2_8   		=>	p2_8,
				p2_9   		=>	p2_9,
				p2_10			=>	p2_10,
				p2_11  		=>	p2_11,
				
				perdio1	=> perdio1,
				perdio2	=> perdio2,
				rst_b		=> rst_b
			);	

 paleta1 :ENTITY work.control_paleta  
		PORT MAP(
		      clk		   =>  clk,
				rst		   =>  rst OR rst_f_1 OR rst_f_2,
				Arriba_1	   =>  Arriba_1,
				Abajo_1	   =>  Abajo_1 ,
			   vsync		   =>  vsync_0,
				hsync		   =>  hsync_0,
				R				=>	 R_paleta1,
				G			   =>  G_paleta1,
				B			   =>  B_paleta1,
				
				pos1   		=>	p1_1,
				pos2   		=>	p1_2,
				pos3   		=>	p1_3,
				pos4  		=>	p1_4,
				pos5			=>	p1_5,
				pos6   		=>	p1_6,
				pos7  		=>	p1_7,
				pos8   		=>	p1_8,
				pos9   		=>	p1_9,
				pos10			=>	p1_10,
				pos11  		=>	p1_11,
				
				blank		   =>  blank_1
			);	
			
	 paleta2 :ENTITY work.control_paleta_2  
		PORT MAP(
		      clk		   =>  clk,
				rst		   =>  rst OR rst_f_1 OR rst_f_2,
				Arriba_2	   =>  Abajo_2,
				Abajo_2	   =>  Arriba_2,
			   vsync		   =>  v_sync_1,
				hsync		   =>  h_sync_1,
				R				=>	 R_paleta2,
				G			   =>  G_paleta2,
				B			   =>  B_paleta2,
				pos1   		=>	p2_1,
				pos2   		=>	p2_2,
				pos3   		=>	p2_3,
				pos4  		=>	p2_4,
				pos5			=>	p2_5,
				pos6   		=>	p2_6,
				pos7  		=>	p2_7,
				pos8   		=>	p2_8,
				pos9   		=>	p2_9,
				pos10			=>	p2_10,
				pos11  		=>	p2_11
			);	
			
	 bola :ENTITY work.visualizacion_VGA_b  
		PORT MAP(
		      clk		   =>  clk,
				rst		   =>  rst OR rst_f_1 OR rst_f_2,
				rst_b			=>  rst_b OR start,
			   vsync		   =>  v_sync_2,
				hsync		   =>  h_sync_2,
				R				=>	 R_bola,
				G			   =>  G_bola,
				B			   =>  B_bola,
				x				=>	 x_s,
				y				=>  y_s,				
				blank		   =>  blank_1
			);	
			
	 puntaje_1 :ENTITY work.puntaje  
		PORT MAP(
		      clk		   =>  clk,
				rst		   =>  rst OR rst_f_2 OR rst_f_1,
				en				=>	 perdio1,	
				syn_clr		=>  '0',
				load			=>  '0',
				up				=>  '1',
				d				=>  "000",
				max_tick		=>  rst_f_1,
				min_tick		=>  min_tick_s,
				counter		=>  numero1
			);	

	 puntaje_2 :ENTITY work.puntaje  
		PORT MAP(
		      clk		   =>  clk,
				rst		   =>  rst OR rst_f_1 OR rst_f_2,
				en				=>	 perdio2,	
				syn_clr		=>  '0',
				load			=>  '0',
				up				=>  '1',
				d				=>  "000",
				max_tick		=>  rst_f_2,
				min_tick		=>  min_tick_s,
				counter		=>  numero2
			);	

		jugador1:ENTITY work.segmentos      
		PORT MAP(
			dit					=> numero1,
			salida_multi_seg	=> siete_segmentos1
					);

		jugador2:ENTITY work.segmentos      
		PORT MAP(
			dit					=> numero2,
			salida_multi_seg	=> siete_segmentos2	
					);

	clkestados: ENTITY work.digital_clock_top_multiplex
	PORT MAP (
			clk50mhz 	=>  clk,
	      clk   		=>  max_tickestados
				);
			

	sequential: PROCESS(rst,rst_f_1,rst_f_2,max_tickestados )
	BEGIN
		IF (rst='1' OR rst_f_1 = '1' OR rst_f_2 = '1') THEN
			pr_state	<=	st1;
		ELSIF (rising_edge(max_tickestados)) THEN
			pr_state	<=	nx_state;
		END IF;
	END PROCESS sequential;
	
	
	combinational: PROCESS(pr_state )
	
	BEGIN
		CASE pr_state IS
			WHEN st1 =>
            vsync		<= vsync_0;
				hsync		<= hsync_0;
				R			<= R_paleta1;
				G			<= G_paleta1;
				B			<= B_paleta1;
				nx_state <= st2;

			WHEN st2 =>
            vsync		<= vsync_0;
				hsync		<= hsync_0;
				R			<= R_paleta2;
				G			<= G_paleta2;
				B			<= B_paleta2;				
				nx_state <= st3;
			
			WHEN st3 =>
            vsync		<= vsync_0;
				hsync		<= hsync_0;
				R			<= R_bola;
				G			<= G_bola;
				B			<= B_bola;				
				nx_state <= st1;	   	
				
 END CASE;
	END PROCESS combinational;
	
END ARCHITECTURE fsm;