LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
----------------------------------------------------------------
ENTITY control_bola IS
	PORT	(	clk					:	IN		STD_LOGIC;
				rst					:	IN		STD_LOGIC;
				actual_regx		   :	IN		STD_LOGIC_VECTOR(10 DOWNTO 0);
				actual_regy    	:	IN		STD_LOGIC_VECTOR(9 DOWNTO 0);
				siguiente_x			:	OUT	STD_LOGIC_VECTOR(10 DOWNTO 0);
				siguiente_y			:	OUT	STD_LOGIC_VECTOR(9 DOWNTO 0)
				);
END ENTITY control_bola;
----------------------------------------------------------------

ARCHITECTURE fsm OF control_bola IS

	SIGNAL direccion1_x		: STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL direccion1_y		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL direccion2_x		: STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL direccion2_y		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL direccion3_x		: STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL direccion3_y		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL direccion4_x		: STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL direccion4_y		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL movimiento_1     : STD_LOGIC;
	SIGNAL movimiento_1_10b : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL movimiento_1_9b : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL movimiento_2     : STD_LOGIC;
	SIGNAL movimiento_2_10b : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL movimiento_2_9b : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL movimiento_3     : STD_LOGIC;
	SIGNAL movimiento_3_10b : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL movimiento_3_9b : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL movimiento_4     : STD_LOGIC;
	SIGNAL movimiento_4_10b : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL movimiento_4_9b : STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	TYPE state IS(direccion1, direccion2, direccion3, direccion4);					
	SIGNAL pr_state	:	state;
	SIGNAL max_tickestados : STD_LOGIC;
	
BEGIN
	movimiento_1_10b(0) <= movimiento_1; 
   movimiento_1_10b(1) <= movimiento_1;
	movimiento_1_10b(2) <= movimiento_1;
	movimiento_1_10b(3) <= movimiento_1;
	movimiento_1_10b(4) <= movimiento_1;
	movimiento_1_10b(5) <= movimiento_1;
	movimiento_1_10b(6) <= movimiento_1;
	movimiento_1_10b(7) <= movimiento_1;
	movimiento_1_10b(8) <= movimiento_1;
	movimiento_1_10b(9) <= movimiento_1;
	movimiento_1_10b(10) <= movimiento_1;
	
	movimiento_1_9b(0) <= movimiento_1; 
   movimiento_1_9b(1) <= movimiento_1;
	movimiento_1_9b(2) <= movimiento_1;
	movimiento_1_9b(3) <= movimiento_1;
	movimiento_1_9b(4) <= movimiento_1;
	movimiento_1_9b(5) <= movimiento_1;
	movimiento_1_9b(6) <= movimiento_1;
	movimiento_1_9b(7) <= movimiento_1;
	movimiento_1_9b(8) <= movimiento_1;
	movimiento_1_9b(9) <= movimiento_1;
	
	movimiento_2_10b(0) <= movimiento_2; 
   movimiento_2_10b(1) <= movimiento_2;
	movimiento_2_10b(2) <= movimiento_2;
	movimiento_2_10b(3) <= movimiento_2;
	movimiento_2_10b(4) <= movimiento_2;
	movimiento_2_10b(5) <= movimiento_2;
	movimiento_2_10b(6) <= movimiento_2;
	movimiento_2_10b(7) <= movimiento_2;
	movimiento_2_10b(8) <= movimiento_2;
	movimiento_2_10b(9) <= movimiento_2;
	movimiento_2_10b(10) <= movimiento_2;
	
	movimiento_2_9b(0) <= movimiento_2; 
   movimiento_2_9b(1) <= movimiento_2;
	movimiento_2_9b(2) <= movimiento_2;
	movimiento_2_9b(3) <= movimiento_2;
	movimiento_2_9b(4) <= movimiento_2;
	movimiento_2_9b(5) <= movimiento_2;
	movimiento_2_9b(6) <= movimiento_2;
	movimiento_2_9b(7) <= movimiento_2;
	movimiento_2_9b(8) <= movimiento_2;
	movimiento_2_9b(9) <= movimiento_2;
	
	movimiento_3_10b(0) <= movimiento_3; 
   movimiento_3_10b(1) <= movimiento_3;
	movimiento_3_10b(2) <= movimiento_3;
	movimiento_3_10b(3) <= movimiento_3;
	movimiento_3_10b(4) <= movimiento_3;
	movimiento_3_10b(5) <= movimiento_3;
	movimiento_3_10b(6) <= movimiento_3;
	movimiento_3_10b(7) <= movimiento_3;
	movimiento_3_10b(8) <= movimiento_3;
	movimiento_3_10b(9) <= movimiento_3;
	movimiento_3_10b(10) <= movimiento_3;
	
	movimiento_3_9b(0) <= movimiento_3; 
   movimiento_3_9b(1) <= movimiento_3;
	movimiento_3_9b(2) <= movimiento_3;
	movimiento_3_9b(3) <= movimiento_3;
	movimiento_3_9b(4) <= movimiento_3;
	movimiento_3_9b(5) <= movimiento_3;
	movimiento_3_9b(6) <= movimiento_3;
	movimiento_3_9b(7) <= movimiento_3;
	movimiento_3_9b(8) <= movimiento_3;
	movimiento_3_9b(9) <= movimiento_3;
	
	movimiento_4_10b(0) <= movimiento_4; 
   movimiento_4_10b(1) <= movimiento_4;
	movimiento_4_10b(2) <= movimiento_4;
	movimiento_4_10b(3) <= movimiento_4;
	movimiento_4_10b(4) <= movimiento_4;
	movimiento_4_10b(5) <= movimiento_4;
	movimiento_4_10b(6) <= movimiento_4;
	movimiento_4_10b(7) <= movimiento_4;
	movimiento_4_10b(8) <= movimiento_4;
	movimiento_4_10b(9) <= movimiento_4;
	movimiento_4_10b(10) <= movimiento_4;
	
	movimiento_4_9b(0) <= movimiento_4; 
   movimiento_4_9b(1) <= movimiento_4;
	movimiento_4_9b(2) <= movimiento_4;
	movimiento_4_9b(3) <= movimiento_4;
	movimiento_4_9b(4) <= movimiento_4;
	movimiento_4_9b(5) <= movimiento_4;
	movimiento_4_9b(6) <= movimiento_4;
	movimiento_4_9b(7) <= movimiento_4;
	movimiento_4_9b(8) <= movimiento_4;
	movimiento_4_9b(9) <= movimiento_4;
	
	
	SUMADIRECCION1: ENTITY work.direccion_1
	PORT MAP (
	--		 direccion1       => movimiento_1,
			 actual_regx		=> actual_regx,
			 actual_regy		=> actual_regy,
			 siguiente_regx	=> direccion1_x,
			 siguiente_regy	=> direccion1_y
	);
	
   SUMADIRECCION2: ENTITY work.direccion_2
	PORT MAP (			 
			 actual_regx		=> actual_regx,
			 actual_regy		=> actual_regy,
			 siguiente_regx	=> direccion2_x,
			 siguiente_regy	=> direccion2_y
				 );   

   SUMADIRECCION3: ENTITY work.direccion_3
	PORT MAP (			 
			 actual_regx		=> actual_regx,
			 actual_regy		=> actual_regy,
			 siguiente_regx	=> direccion3_x,
			 siguiente_regy	=> direccion3_y
);   
	
	SUMADIRECCION4: ENTITY work.direccion_4
	PORT MAP (
			 actual_regx		=> actual_regx,
			 actual_regy		=> actual_regy,
			 siguiente_regx	=> direccion4_x,
			 siguiente_regy	=> direccion4_y
);
	CONTROLDIRECIONES: ENTITY work.control_direcciones
	PORT MAP (
			   clk			=> clk,
				rst			=> rst,
				actual_regx	=> actual_regx,
				actual_regy => actual_regy,
				dir_1			=> movimiento_1,
				dir_2			=> movimiento_2,
				dir_3			=> movimiento_3,
				dir_4			=> movimiento_4
);			 	

siguiente_x <= (movimiento_1_10b AND direccion1_x) OR (movimiento_2_10b AND direccion2_x) OR 
					(movimiento_3_10b AND direccion3_x) OR (movimiento_4_10b AND direccion4_x);
	
siguiente_y <= (movimiento_1_9b AND direccion1_y) OR (movimiento_2_9b AND direccion2_y) OR 
					(movimiento_3_9b AND direccion3_y) OR (movimiento_4_9b AND direccion4_y);

	END ARCHITECTURE ;