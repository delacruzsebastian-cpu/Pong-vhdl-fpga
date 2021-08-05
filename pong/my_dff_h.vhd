LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------
ENTITY my_dff_h IS
	PORT ( 
			 clk     : IN  STD_LOGIC;
			 rst  	: IN  STD_LOGIC;
			 ena 		: IN  STD_LOGIC;
			 d 	 	: IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
			 q			: OUT STD_LOGIC_VECTOR(10 DOWNTO 0));
END my_dff_h;
--------------------------------------------
ARCHITECTURE rtl of my_dff_h is
BEGIN 
	
	dff: PROCESS(clk, rst, d)
	BEGIN 
		IF(rst='1') THEN 
			q <= "01001100101";
		ELSIF (rising_edge(clk))THEN
			IF (ena='1') THEN 
				q <= d;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;