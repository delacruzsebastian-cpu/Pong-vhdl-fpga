LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------------
ENTITY control_paleta_2 IS
	PORT	(	clk		:	IN		 STD_LOGIC;
				rst		:	IN		 STD_LOGIC;
				Arriba_2	:	IN		 STD_LOGIC;
				Abajo_2	:	IN		 STD_LOGIC;
				vsync		:	OUT	 STD_LOGIC;
				hsync		:	OUT 	 STD_LOGIC;
				R			:	OUT 	 STD_LOGIC_VECTOR (3 DOWNTO 0);
				G			:	OUT	 STD_LOGIC_VECTOR (3 DOWNTO 0);
				B			:	OUT	 STD_LOGIC_VECTOR (3 DOWNTO 0);
				pos1   :	OUT	STD_LOGIC;
				pos2   :	OUT	STD_LOGIC;
				pos3   :	OUT	STD_LOGIC;
				pos4   :	OUT	STD_LOGIC;
				pos5	:	OUT	STD_LOGIC;
				pos6   :	OUT	STD_LOGIC;
				pos7  	:	OUT	STD_LOGIC;
				pos8   :	OUT	STD_LOGIC;
				pos9   :	OUT	STD_LOGIC;
				pos10	:	OUT	STD_LOGIC;
				pos11  :	OUT	STD_LOGIC
				
	);
END ENTITY control_paleta_2;
----------------------------------------------------------------

ARCHITECTURE fsm OF control_paleta_2 IS
	SIGNAL	h_sync		:	STD_LOGIC;
	SIGNAL	v_sync		:	STD_LOGIC;
	SIGNAL	h_sync_1		:	STD_LOGIC;
	SIGNAL	v_sync_1		:	STD_LOGIC;
	SIGNAL	h_sync_2		:	STD_LOGIC;
	SIGNAL	v_sync_2		:	STD_LOGIC;
	SIGNAL	h_sync_3		:	STD_LOGIC;
	SIGNAL	v_sync_3		:	STD_LOGIC;
	SIGNAL	h_sync_4		:	STD_LOGIC;
	SIGNAL	v_sync_4		:	STD_LOGIC;
	SIGNAL	h_sync_5		:	STD_LOGIC;
	SIGNAL	v_sync_5		:	STD_LOGIC;
	SIGNAL	h_sync_6		:	STD_LOGIC;
	SIGNAL	v_sync_6		:	STD_LOGIC;
	SIGNAL	h_sync_7		:	STD_LOGIC;
	SIGNAL	v_sync_7		:	STD_LOGIC;
	SIGNAL	h_sync_8		:	STD_LOGIC;
	SIGNAL	v_sync_8		:	STD_LOGIC;
	SIGNAL	h_sync_9		:	STD_LOGIC;
	SIGNAL	v_sync_9		:	STD_LOGIC;
	SIGNAL	h_sync_10	:	STD_LOGIC;
	SIGNAL	v_sync_10	:	STD_LOGIC;
	SIGNAL	h_sync_11	:	STD_LOGIC;
	SIGNAL	v_sync_11	:	STD_LOGIC;
	SIGNAL	R1				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	G1				:  STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	B1				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	R2				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	G2				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	B2				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	R3				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	G3				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	B3				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	R4				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	G4				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	B4				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	R5				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	G5				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	B5				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	R6				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	G6				:  STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	B6				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	R7				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	G7				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	B7				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	R8				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	G8				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	B8				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	R9				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	G9				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	B9				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	R10			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	G10			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	B10			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	R11			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	G11			:  STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	B11			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	blank_s		:	STD_LOGIC;
	SIGNAL	posc_1   	:	STD_LOGIC;
	SIGNAL	posc_2   	:	STD_LOGIC;
	SIGNAL	posc_3   	:	STD_LOGIC;
	SIGNAL	posc_4   	:	STD_LOGIC;
	SIGNAL	posc_5		:	STD_LOGIC;
	SIGNAL	posc_6   	:	STD_LOGIC;
	SIGNAL	posc_7   	:	STD_LOGIC;
	SIGNAL	posc_8   	:	STD_LOGIC;
	SIGNAL	posc_9   	:	STD_LOGIC;
	SIGNAL	posc_10		:	STD_LOGIC;
	SIGNAL	posc_11  	:	STD_LOGIC;

	SIGNAL   clk_estados : STD_LOGIC;
	SIGNAL   h_cuenta 	: STD_LOGIC_VECTOR(10 DOWNTO 0);

	TYPE state IS(posicion1, posicion2, posicion3, posicion4, posicion5, posicion6, posicion7, posicion8, posicion9, posicion10,
					posicion11);					
	SIGNAL pr_state	:	state;
	SIGNAL max_tickestados : STD_LOGIC;
	
	BEGIN
				 
	clkestados: ENTITY work.digital_clock_top
	PORT MAP (
				clk50mhz 	=>  clk,
	         clk   		=>  clk_estados
	);
	
	posc: ENTITY work.posiciones
	PORT MAP (
				clk		=>	clk_estados, 
				rst		=>	rst,
				Arriba_1	=>	Arriba_2,
				Abajo_1	=> Abajo_2,	
				posc_1	=> posc_1,
				posc_2	=> posc_2,
				posc_3	=> posc_3,
				posc_4	=> posc_4,
				posc_5	=> posc_5,
				posc_6	=> posc_6,
				posc_7	=> posc_7,
				posc_8	=> posc_8,
				posc_9	=> posc_9,
				posc_10	=> posc_10,
				posc_11	=> posc_11
				 );
	posc1: ENTITY work.visualizacion_VGA
	PORT MAP (
				clk		=>	clk, 
				rst		=>	rst,
				vsync		=>	v_sync_1,
				hsync		=> h_sync_1,
				R		   => R1,
				G	   	=> G1,
				B	   	=> B1, 
				blank		=> blank_s
				 ); 
	posc2: ENTITY work.visualizacion_VGA_12
	PORT MAP (
				clk		=>	clk, 
				rst		=>	rst,
				vsync		=>	v_sync_2,
				hsync		=> h_sync_2,
				R(0)	   	=> R2(0),
				R(1)	   	=> R2(1),
				R(2)	   	=> R2(2),
		      R(3)	   	=> R2(3),
			   G(0)		   => G2(0) ,
			   G(1)		   => G2(1) ,
			   G(2)		   => G2(2) ,
			   G(3)		   => G2(3) ,
			   B(0)			=> B2(0) ,
			   B(1)			=> B2(1) ,
			   B(2)			=> B2(2) ,
			   B(3)			=> B2(3) ,
				blank		=> blank_s
				 );
	posc3: ENTITY work.visualizacion_VGA_13
	PORT MAP (
				clk		=>	clk, 
				rst		=>	rst,
				vsync		=>	v_sync_3,
				hsync		=> h_sync_3,
				R(0)	   	=> R3(0),
				 R(1)	   	=> R3(1),
				 R(2)	   	=> R3(2),
		       R(3)	   	=> R3(3),
				 G(0)		   => G3(0) ,
				 G(1)		   => G3(1) ,
				 G(2)		   => G3(2) ,
				 G(3)		   => G3(3) ,
				 B(0)			=> B3(0) ,
				 B(1)			=> B3(1) ,
				 B(2)			=> B3(2) ,
				 B(3)			=> B3(3) ,
				blank		=> blank_s
				 );
	posc4: ENTITY work.visualizacion_VGA_14
	PORT MAP (
				clk		=>	clk, 
				rst		=>	rst,
				vsync		=>	v_sync_4,
				hsync		=> h_sync_4,
		     	 R(0)	  	   => R4(0),
				 R(1)	   	=> R4(1),
				 R(2)	   	=> R4(2),
		       R(3)	   	=> R4(3),
				 G(0)		   => G4(0) ,
				 G(1)		   => G4(1) ,
				 G(2)		   => G4(2) ,
				 G(3)		   => G4(3) ,
				 B(0)			=> B4(0) ,
				 B(1)			=> B4(1) ,
				 B(2)			=> B4(2) ,
				 B(3)			=> B4(3) ,
				blank		=> blank_s
				 );
	posc5: ENTITY work.visualizacion_VGA_15
	PORT MAP (
				clk		=>	clk, 
				rst		=>	rst,
				vsync		=>	v_sync_5,
				hsync		=> h_sync_5,
				R(0)	   	=> R5(0),
			   R(1)	   	=> R5(1),
			   R(2)	   	=> R5(2),
		      R(3)	   	=> R5(3),
		   	G(0)		   => G5(0) ,
				G(1)		   => G5(1) ,
				G(2)		   => G5(2) ,
				G(3)		   => G5(3) ,
				B(0)			=> B5(0) ,
				B(1)			=> B5(1) ,
				B(2)			=> B5(2) ,
				B(3)			=> B5(3) ,
				blank		=> blank_s
				 );
	posc6: ENTITY work.visualizacion_VGA_16
	PORT MAP (
				clk		=>	clk, 
				rst		=>	rst,
				vsync		=>	v_sync_6,
				hsync		=> h_sync_6,
				R			=>	R6,
				G			=>	G6,
				B			=>	B6,
				blank			=> blank_s
				 );
	posc7: ENTITY work.visualizacion_VGA_17
	PORT MAP (
				clk		=>	clk, 
				rst		=>	rst,
				vsync		=>	v_sync_7,
				hsync		=> h_sync_7,
				R			=>	R7,
				G			=>	G7,
				B			=>	B7,
				blank			=> blank_s
				 );
	posc8: ENTITY work.visualizacion_VGA_18
	PORT MAP (
				clk		=>	clk, 
				rst		=>	rst,
				vsync		=>	v_sync_8,
				hsync		=> h_sync_8,
				R			=>	R8,
				G			=>	G8,
				B			=>	B8,
				blank			=> blank_s
				 );			 
	posc9: ENTITY work.visualizacion_VGA_19
	PORT MAP (
				clk		=>	clk, 
				rst		=>	rst,
				vsync		=>	v_sync_9,
				hsync		=> h_sync_9,
				R			=>	R9,
				G			=>	G9,
				B			=>	B9,
				blank			=> blank_s
				 ); 
   posc10: ENTITY work.visualizacion_VGA_20
	PORT MAP (
				clk		=>	clk, 
				rst		=>	rst,
				vsync		=>	v_sync_10,
				hsync		=> h_sync_10,
				R			=>	R10,
				G			=>	G10,
				B			=>	B10,
				blank			=> blank_s
				 );
				 
	posc11: ENTITY work.visualizacion_VGA_21
	PORT MAP (
				clk		=>	clk, 
				rst		=>	rst,
				vsync		=>	v_sync_11,
				hsync		=> h_sync_11,
				R			=>	R11,
				G			=>	G11,
				B			=>	B11,
				blank			=> blank_s
				 );
	
	combinational: 
	PROCESS(pr_state, posc_1, posc_2, posc_3, posc_4, posc_5, posc_6, posc_7, posc_8, posc_9, posc_10, posc_11,rst, clk )

	BEGIN

	IF (rst = '1') THEN
		pr_state <= posicion1;
	ELSIF (clk'EVENT and clk = '1') THEN

		IF (posc_1 = '1') THEN
			pr_state <= posicion1;
			ELSIF (posc_2 = '1') THEN
				pr_state <= posicion2;
				ELSIF (posc_3 = '1') THEN
					pr_state <= posicion3;
					ELSIF (posc_4 = '1') THEN
						pr_state <= posicion4;
						ELSIF (posc_5 = '1') THEN	
							pr_state <= posicion5;
							ELSIF (posc_6 = '1') THEN
								pr_state <= posicion6;
								ELSIF (posc_7 = '1') THEN
									pr_state <= posicion7;
									ELSIF (posc_8 = '1') THEN
										pr_state <= posicion8;
										ELSIF (posc_9 = '1') THEN
											pr_state <= posicion9;
											ELSIF (posc_10 = '1') THEN	
												pr_state <= posicion10;
												ELSIF (posc_11 = '1') THEN
												pr_state <= posicion11;

		ELSE
			pr_state <= posicion1;
		END IF;
END IF; 
END PROCESS; 

--LOGICA DE SALIDA 

PROCESS(pr_state)
BEGIN 
	
	CASE pr_state IS
			WHEN posicion1 =>
					vsync	<=	v_sync_1;
					hsync	<=	h_sync_1;
					R		<=	R1;
					G		<=	G1;
					B		<=	B1;
					
		WHEN posicion2 =>
					vsync	<=	v_sync_1;
					hsync	<=	h_sync_1;
					R		<=	R2;
					G		<=	G2;
					B		<=	B2;
					
		WHEN posicion3 =>    
					vsync	<=	v_sync_1;
					hsync	<=	h_sync_1;
					R		<=	R3;
					G		<=	G3;
					B		<=	B3;
					
		WHEN posicion4 =>
					vsync	<=	v_sync_1;
					hsync	<=	h_sync_1;
					R		<=	R4;
					G		<=	G4;
					B		<=	B4;
					
		WHEN posicion5 =>
					vsync	<=	v_sync_1;
					hsync	<=	h_sync_1;
					R		<=	R5;
					G		<=	G5;
					B		<=	B5;
		WHEN posicion6 =>
					vsync	<=	v_sync_1;
					hsync	<=	h_sync_1;
					R		<=	R6;
					G		<=	G6;
					B		<=	B6;
					
		WHEN posicion7 =>
					vsync	<=	v_sync_1;
					hsync	<=	h_sync_1;
					R		<=	R7;
					G		<=	G7;
					B		<=	B7;
					
		WHEN posicion8 =>    
					vsync	<=	v_sync_1;
					hsync	<=	h_sync_1;
					R		<=	R8;
					G		<=	G8;
					B		<=	B8;
					
		WHEN posicion9=>
					vsync	<=	v_sync_1;
					hsync	<=	h_sync_1;
					R		<=	R9;
					G		<=	G9;
					B		<=	B9;
					
		WHEN posicion10 =>
					vsync	<=	v_sync_1;
					hsync	<=	h_sync_1;
					R		<=	R10;
					G		<=	G10;
					B		<=	B10;

		WHEN posicion11 =>
					vsync	<=	v_sync_1;
					hsync	<=	h_sync_1;
					R		<=	R11;
					G		<=	G11;
					B		<=	B11;
					
					
	END CASE;
	END PROCESS;
	
	pos1 <= posc_1;
	pos2 <= posc_2;
	pos3 <= posc_3;
	pos4 <= posc_4;
	pos5 <= posc_5;
	pos6 <= posc_6;
	pos7 <= posc_7;
	pos8 <= posc_8;
	pos9 <= posc_9;
	pos10 <= posc_10;
	pos11 <= posc_11;
	
	END ARCHITECTURE ;