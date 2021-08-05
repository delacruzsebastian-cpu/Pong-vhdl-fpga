LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 

ENTITY image_generator_3 IS 
	PORT ( hctr 	: IN STD_LOGIC_VECTOR (10 DOWNTO 0); 
			 vctr 	: IN STD_LOGIC_VECTOR (9 DOWNTO 0); 
			 blank 	: IN STD_LOGIC; 	-- blank interval SIGNAL 
			 clk50MHz: IN STD_LOGIC;	-- main clock 
			 reset 	: IN STD_LOGIC;  	-- global reset 
			 R 		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);  -- Red colour SIGNAL 
			 G 		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);  -- Green colour SIGNAL 
			 B 		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)  -- Blue colour SIGNAL 
);
			 END image_generator_3;

ARCHITECTURE Behavioral of image_generator_3 is 
	SIGNAL hctr_int 				: INTEGER RANGE 1586 DOWNTO 0; 
	SIGNAL vctr_int 				: INTEGER RANGE 524 DOWNTO 0; 
	SIGNAL R_int, G_int, B_int : STD_LOGIC_VECTOR (3 DOWNTO 0);  
	SIGNAL color					: STD_LOGIC_VECTOR (2 DOWNTO 0);
	
BEGIN 
	hctr_int <= CONV_INTEGER (hctr); 
	vctr_int <= CONV_INTEGER (vctr); 
	-- utilizamos biestables de salida para evitar posibles Glitches 
	-- Iniiciaizamos los biestables a cero 
	PROCESS (clk50MHz,reset,R_int,G_int,B_int) 
		BEGIN
		IF reset = '1' THEN 
			R <= "0000"; 
			G <= "0000"; 
			B <= "0000"; 
		ELSIF clk50MHz='1' AND clk50MHz'EVENT THEN 
			R <= R_int; 
			G <= G_int; 
			B <= B_int; 
		END IF; 
	END PROCESS; 
	-- Colores obtenidos en función de R G B (1 bit per SIGNAL) 
	-- 000: black 
	-- 001: blue 
	-- 010: green 
	-- 011: cyan
	-- Circuito combinacional que genera los colores de cada franja 
	-- en función de la posición horizontal de cada punto 
	-- franja vertical blanca de la izda 
		color <= 
		"011" WHEN ((hctr_int >= 0)   AND (hctr_int < 50)	  AND (vctr_int >= 297)	AND (vctr < 367) AND (blank = '1')) ELSE  
		"000"; -- Intérvalos blank (blank = 0) 
		R_int(0) <= color(2); 
		R_int(1) <= color(2); 
		R_int(2) <= color(2); 
		R_int(3) <= color(2); 
		G_int(0) <= color(1); 
		G_int(1) <= color(1); 
		G_int(2) <= color(1); 
		G_int(3) <= color(1); 	
		B_int(0) <= color(0); 
		B_int(1) <= color(0); 
		B_int(2) <= color(0); 
		B_int(3) <= color(0); 
		END Behavioral;