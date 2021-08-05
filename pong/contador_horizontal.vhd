library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity contador_horizontal is 

Port ( clk50MHz 	: in std_logic; -- reloj principal 
		 reset 		: in std_logic; -- reset global 
		 h_cuenta   : out std_logic_vector (10 downto 0) ); 
end contador_horizontal; 
		 
architecture comportamiento of contador_horizontal is 

signal h_cuenta_int : integer range 1586 downto 0;

 begin

 -- convierte h_cuenta_int en entero y se asigna a la salida 
 h_cuenta <= CONV_STD_LOGIC_VECTOR (h_cuenta_int, 11);

 process (clk50MHz,reset,h_cuenta_int)
 
 begin 
 
		if reset = '1' then 
			h_cuenta_int <= 0; 
		elsif clk50MHz='1' and clk50MHz'event then 
			-- para saber que se ha llegado a la cuenta 1587 
			if h_cuenta_int = 1586 then --ajustar bien la cuenta 
			h_cuenta_int <= 0; 
			else 
			h_cuenta_int <= h_cuenta_int + 1;
			end if; 
		end if; 
	end process; 
	
	end comportamiento; 
	