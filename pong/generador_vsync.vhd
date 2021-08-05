library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity generador_vsync is 
	Port ( v_cuenta : in std_logic_vector (9 downto 0);
		    clk50MHz : in std_logic; 
			 reset 	 : in std_logic; 
			 vsync 	 : out std_logic); 
end generador_vsync;

architecture comportamiento of generador_vsync is 
signal v_cuenta_int : integer range 524 downto 0; 
	begin 
-- Convierte a entero el vector de entrada v_cuenta 
v_cuenta_int <= CONV_INTEGER (v_cuenta); 
-- vsync generation flip-flop, which is initialized to one state 
process (clk50MHz,reset,v_cuenta_int) 
	begin
		if reset = '1' then 
			vsync <= '1'; 
		elsif clk50MHz='1' and clk50MHz'event then 
			if (v_cuenta_int >= 500) and (v_cuenta_int <= 502) then 
			-- valores originales 500 y 502
				vsync <= '0'; 
			else vsync <= '1'; 
			end if; 
		end if;
	end process; 
end comportamiento;