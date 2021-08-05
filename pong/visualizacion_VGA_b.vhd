LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 

-----------------------------------------------------
ENTITY visualizacion_VGA_b IS 
     PORT (	clk  	 : IN 		STD_LOGIC;
				rst	 : IN 		STD_LOGIC;
				rst_b    : IN 	STD_LOGIC;
				vsync  : OUT 	STD_LOGIC;
				hsync  : OUT 	STD_LOGIC;
				R 		 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);  -- Red colour SIGNAL 
				G 		 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);  -- Green colour SIGNAL 
				B 		 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0); -- Blue colour SIGNAL 
				x		 : OUT STD_LOGIC_VECTOR	(10 DOWNTO 0);
				y		 : OUT STD_LOGIC_VECTOR	(9 DOWNTO 0);
				blank  : BUFFER STD_LOGIC
				);
END ENTITY visualizacion_VGA_b;
-----------------------------------------------------
ARCHITECTURE functional OF visualizacion_VGA_b IS 

	SIGNAL	clk_estados : STD_LOGIC;
   SIGNAL	h_cuenta	   :	STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL	hsync1	   :	STD_LOGIC;
	SIGNAL	v_cuenta	   :	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL   blank1      :  STD_LOGIC;
	SIGNAL	R_S			:	STD_LOGIC_VECTOR(3 DOWNTO 0);			
	SIGNAL	G_S			:	STD_LOGIC_VECTOR(3 DOWNTO 0);	
	SIGNAL	B_S			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL   salidadeimax  : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL   salidadeimay  : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL   salidaderegx  : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL   salidaderegy  : STD_LOGIC_VECTOR(9 DOWNTO 0);	
	SIGNAL   salidacontrolx  : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL   salidacontroly  : STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	
BEGIN 	

	clkestados: ENTITY work.digital_clock_top_bola
	PORT MAP (
				clk50mhz 	=>  clk,
	         clk   		=>  clk_estados
	);
	
   control: ENTITY work.control_bola
	PORT MAP (rst	       		=> rst,
				 clk		    		=> clk_estados,
				 actual_regx		=> salidaderegx,
				 actual_regy		=> salidaderegy,		
				 siguiente_x		=> salidacontrolx,	
				 siguiente_y		=> salidacontroly
				 );   

   imagenZ: ENTITY work.image_generator_b
	PORT MAP (rst	       =>rst,
				 clk50MHz    => clk,
				 hctr 		 => h_cuenta,	 
				 vctr 		 => v_cuenta,
				 blank		 => blank1,
				 R		   	 => R_S,
				 G		   	 => G_S,
				 B		   	 => B_S,		 
				 act_regx_in => salidacontrolx,
				 act_regy_in => salidacontroly,
				 act_regx	 => salidadeimax,
				 act_regy	 => salidadeimay
				 );   

	registroposcactualx: ENTITY work.my_dff_h
	PORT MAP (clk    => clk_estados,
				 rst    => rst_b,
				 ena    => '1',
				 d		  => salidadeimax,
				 q		  => salidaderegx
				 );
	registroposcactualy: ENTITY work.my_dff
	PORT MAP (
				 clk    => clk_estados,
				 rst    => rst_b,
				 ena    => '1',
				 d		  => salidadeimay,
				 q		  => salidaderegy
				 );
	
	
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


	hsync <= hsync1; 				 
	blank <= blank1;
	R <= R_S;
	G <= G_S;
	B <= B_S;
	x <= salidadeimax;
	y <= salidadeimay;
			
END ARCHITECTURE functional;