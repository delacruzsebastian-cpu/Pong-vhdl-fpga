LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

     ENTITY segmentos IS
        PORT(
			dit : IN STD_LOGIC_VECTOR (2 DOWNTO 0 );
			salida_multi_seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)	 
				 );
     END segmentos;


ARCHITECTURE behaviour OF segmentos IS
SIGNAL data : std_logic_vector (6 DOWNTO 0);
BEGIN 
salida_multi_seg <= data; 
PROCESS (dit,data)
	BEGIN
		CASE dit IS 
		when	"000" =>data<= "1000000";
		when	"001" =>data<= "1111001";
		when 	"010" =>data<= "0100100";
		when 	"011" =>data<= "0110000";
		when 	"100" =>data<= "0011001";
		when 	"101" =>data<= "0010010";
		when 	"110" =>data<= "0000011";
		when 	"111" =>data<= "1111000";
		
		when others =>data<= "1111111";
	
END CASE;
END PROCESS;

END ARCHITECTURE;