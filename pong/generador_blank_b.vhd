library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

	entity generador_blank_b is 
		Port ( hctr 	: in std_logic_vector (10 downto 0); 
				 vctr 	: in std_logic_vector (9 downto 0); 
				 blank	: out std_logic ); 
end generador_blank_b;

architecture Behavioral of generador_blank_b is 
signal hctr_int : integer range 1586 downto 0; 
signal vctr_int : integer range 524 downto 0;

	begin 
	-- conversiÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â³n de tipos de los contadores a entero 
	hctr_int <= CONV_INTEGER (hctr); 
	vctr_int <= CONV_INTEGER (vctr);
	
	-- Circuito combinacional que genera el blank horizontal y el vertical 
	-- El valor de blank se corresponde con un cero 
	process (hctr_int,vctr_int) 
		
	begin 
		if ((hctr_int >= 1208) and (hctr_int <= 1586)) or ((vctr_int >= 480) and (vctr_int <= 524)) then 
			blank <= '0'; 
		else blank <= '1'; 
		end if;
	end process; 
end Behavioral;