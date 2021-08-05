LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 

ENTITY image_generator_b IS 
	PORT ( hctr 		 : IN  STD_LOGIC_VECTOR (10 DOWNTO 0); 
			 vctr 		 : IN  STD_LOGIC_VECTOR (9 DOWNTO 0); 
			 blank 		 : IN  STD_LOGIC; 	-- blank interval SIGNAL 
			 clk50MHz	 : IN  STD_LOGIC;	-- main clock 
			 rst 			 : IN  STD_LOGIC;  	-- global reset
--			 pre1_regx_s : IN  STD_LOGIC_VECTOR (10 DOWNTO 0);
--			 pre1_regy_s : IN  STD_LOGIC_VECTOR (9 DOWNTO 0);
--			 pre_regx_s  : IN  STD_LOGIC_VECTOR (10 DOWNTO 0);
--			 pre_regy_s  : IN  STD_LOGIC_VECTOR (9 DOWNTO 0);
			 act_regx_in : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
			 act_regy_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			 act_regx	 : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
			 act_regy	 : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
			 R 			 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);  -- Red colour SIGNAL 
			 G 			 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);  -- Green colour SIGNAL 
			 B 			 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0) -- Blue colour SIGNAL 
			);
END image_generator_b;

ARCHITECTURE Behavioral of image_generator_b is 
	SIGNAL hctr_int 				: INTEGER RANGE 1586 DOWNTO 0; 
	SIGNAL vctr_int 				: INTEGER RANGE 524 DOWNTO 0; 
	SIGNAL R_int, G_int, B_int : STD_LOGIC_VECTOR (3 DOWNTO 0); 
	SIGNAL color					: STD_LOGIC_VECTOR (2 DOWNTO 0);
--	SIGNAL pre1_regx_s_int		: INTEGER RANGE 1586 DOWNTO 0;
--	SIGNAL pre1_regy_s_int		: INTEGER RANGE 524 DOWNTO 0;
--	SIGNAL pre_regx_s_int		: INTEGER RANGE 1586 DOWNTO 0;
--	SIGNAL pre_regy_s_int		: INTEGER RANGE 524 DOWNTO 0;
	SIGNAL act_regx_s_int		: INTEGER RANGE 1586 DOWNTO 0;
	SIGNAL act_regy_s_int		: INTEGER RANGE 524 DOWNTO 0;
	
BEGIN 

	hctr_int 		 <= CONV_INTEGER (hctr); 
	vctr_int 		 <= CONV_INTEGER (vctr);
	act_regx_s_int	 <= CONV_INTEGER (act_regx_in);
	act_regy_s_int	 <= CONV_INTEGER (act_regy_in);
--   pre1_regx_s_int  <= CONV_INTEGER (pre1_regx_s);
--	pre1_regy_s_int  <= CONV_INTEGER (pre1_regy_s);
--	pre_regx_s_int  <= CONV_INTEGER (pre_regx_s);
--	pre_regy_s_int  <= CONV_INTEGER (pre_regy_s);

			
	PROCESS (clk50MHz,rst,R_int,G_int,B_int) 
		BEGIN
		IF rst = '1' THEN 
			R <= "0000"; 
			G <= "0000"; 
			B <= "0000"; 
		ELSIF clk50MHz='1' AND clk50MHz'EVENT THEN 
			R <= R_int; 
			G <= G_int; 
			B <= B_int; 
		END IF; 
	END PROCESS; 
		color <= 
		"011" WHEN ((hctr_int >= act_regx_s_int -20)   AND (hctr_int < act_regx_s_int +20) AND 
						(vctr_int >= act_regy_s_int -10)	AND (vctr < act_regy_s_int +10) AND (blank = '1')) ELSE
		"101" WHEN ((hctr_int >= 608)AND (hctr_int < 618) AND (blank = '1')) ELSE 			
		"000"; 
		
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
		  
		
		act_regx <= act_regx_in;
		act_regy <= act_regy_in;
		  
		END Behavioral;