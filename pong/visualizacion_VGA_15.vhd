LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 

-----------------------------------------------------
ENTITY visualizacion_VGA_15 IS 
     PORT (	clk  	: IN 		STD_LOGIC;
				rst	: IN 		STD_LOGIC;
				vsync : OUT 	STD_LOGIC;
				hsync : OUT 	STD_LOGIC;
				R 		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);  -- Red colour SIGNAL 
				G 		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);  -- Green colour SIGNAL 
				B 		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0); -- Blue colour SIGNAL 
				blank : BUFFER STD_LOGIC
				);
END ENTITY visualizacion_VGA_15;
-----------------------------------------------------
ARCHITECTURE functional OF visualizacion_VGA_15 IS 

   SIGNAL	h_cuenta	:	STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL	hsync1	:	STD_LOGIC;
	SIGNAL	v_cuenta	:	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL   blank1   :  STD_LOGIC;
	SIGNAL	R_S			:	STD_LOGIC_VECTOR(3 DOWNTO 0);			
	SIGNAL	G_S			:	STD_LOGIC_VECTOR(3 DOWNTO 0);	
	SIGNAL	B_S			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	
BEGIN 	
   contador_h: ENTITY work.contador_horizontal
	PORT MAP (clk50MHz => clk,
				 reset    => rst,
				 h_cuenta => h_cuenta
				 );
							
   hsyncZ: ENTITY work.generador_hsync
	PORT MAP (h_cuenta => h_cuenta,
				 clk50MHz => clk,
				 reset 	 => rst,
				 hsync    => hsync1
				 );
					
   contador_vZ: ENTITY work.contador_vertical
	PORT MAP (reset      => 	rst,
				 clk50MHz 	=> 	clk,
				 hsync    	=>   hsync1,
				 v_cuenta 	=>   v_cuenta
				 );
					
   vsyncZ: ENTITY work.generador_vsync
	PORT MAP (reset      =>	rst,
				 v_cuenta 	=> v_cuenta,
				 clk50MHz 	=> clk, 
				 vsync 	 	=> vsync
				 );

   blankZ: ENTITY work.generador_blank
	PORT MAP (hctr 	=> h_cuenta,	 
				 vctr 	=> v_cuenta,
				 blank	=> blank1
				 );

   imagenZ: ENTITY work.image_generator_15
	PORT MAP (reset      =>	rst,
				 clk50MHz   => clk,
				 hctr 		=> h_cuenta,	 
				 vctr 		=> v_cuenta,
				 blank		=> blank1,
				 R		   	=> R_S,
				 G		   	=> G_S,
				 B		   	=> B_S		      
				 );

	hsync <= hsync1; 				 
	blank <= blank1;
	R <= R_S;
	G <= G_S;
	B <= B_S;
			
END ARCHITECTURE functional;