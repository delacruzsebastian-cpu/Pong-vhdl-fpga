library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity generador_hsync is 
	Port ( h_cuenta : in std_logic_vector (10 downto 0); 
			 clk50MHz : in std_logic; 
			 reset 	 : in std_logic; 
			 hsync 	 : out std_logic); 
end generador_hsync;

architecture comportamiento of generador_hsync is 
signal h_cuenta_int 			: integer range 1586 downto 0; 
signal hsync_aux, change_h : std_logic; 

begin 
-- conversión de tipo para trabajar con enteros 
h_cuenta_int <= CONV_INTEGER (h_cuenta); 
-- asignación a la salida, trabajamos con una señal de salida
 -- auxiliar 
 hsync <= hsync_aux;
 -- Biestable de generación de hsync, que se inicializa a nivel uno
 process (clk50MHz,reset,change_h) 
	begin 
		if reset = '1' then 
			hsync_aux <= '1'; 
		elsif clk50MHz='1' and clk50MHz'event then 
			if change_h = '1' then 
				hsync_aux <= not hsync_aux; 
			else hsync_aux <= hsync_aux; 
			end if; 
		end if; 
	end process;

-- Proceso que genera los instantes de cambios de estado de hsync 
process (h_cuenta_int) 
	begin 
	-- La señal hsync debe cambiar de estado en la cuenta 1.327 y 1.515 
	-- del contador horizontal. Para ello, la señal change_h debe activarse 
	-- una valor antes en cada caso. 
		if (h_cuenta_int = 1326) or (h_cuenta_int = 1514) then 
			change_h <= '1'; else change_h <= '0'; 
		end if; 
	end process; 
end comportamiento;

