LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY puntaje IS 
	GENERIC		(	N				:	INTEGER	:=	3);
	PORT			(	clk			:	IN STD_LOGIC;
						rst			:	IN STD_LOGIC;
						en				:	IN STD_LOGIC;
						syn_clr		:	IN STD_LOGIC;
						load			:	IN STD_LOGIC;
						up				:	IN STD_LOGIC;
						d				:	IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
						max_tick		:	BUFFER STD_LOGIC;
						min_tick		:	OUT STD_LOGIC;
						counter		:	BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY;

ARCHITECTURE rtl OF puntaje IS
	CONSTANT ONES			:	UNSIGNED(N-1 DOWNTO 0)	:= (OTHERS => '1');
	CONSTANT ZEROS			:	UNSIGNED(N-1 DOWNTO 0)	:= (OTHERS => '0');

	SIGNAL count_s			:	UNSIGNED(N-1 DOWNTO 0);
	SIGNAL count_next		:	UNSIGNED(N-1 DOWNTO 0);
	
	signal rst_n : std_LOGIC;
	
BEGIN

	count_next <=		(OTHERS => '0' ) WHEN syn_clr= '1'			    ELSE
							UNSIGNED(d) 	  WHEN load =   '1'			    ELSE
							count_s + 1      WHEN (en = '1' AND up= '1') ELSE
							count_s - 1      WHEN (en = '1' AND up= '0') ELSE
							count_s;
							
							
	PROCESS(clk,rst_n)
		VARIABLE temp	:	UNSIGNED(N-1 DOWNTO 0);
	BEGIN
		IF(rst_n='1')	THEN
			temp := (OTHERS => '0');
		ELSIF (rising_edge(clk)) THEN
			IF (en='1')	THEN
				temp := count_next;
			END IF;
		END IF;
		counter <= STD_LOGIC_VECTOR(temp);
		count_s <= temp;
	END PROCESS;

	
	max_tick <= counter(2) AND counter(1) AND counter(0); 
	rst_n	<=	max_tick ;
	min_tick <= '1' WHEN count_s = ZEROS ELSE '0';
	
END ARCHITECTURE;