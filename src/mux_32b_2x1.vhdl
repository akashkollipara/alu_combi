-- Author	: Akash Kollipara
-- BITS ID	: 2020ht01001
-- File		: mux_32b_2x1.vhdl
-- Description	: This file consists of the 2x1 multiplexer core

entity mux_32b_2x1 is
	-- Defining port for Mux 2x1
	port(
		a, b	: in bit_vector (31 downto 0);
		sel	: in bit;
		y	: out bit_vector (31 downto 0));
end entity;

architecture behavioral of mux_32b_2x1 is
begin
	-- Case logic to select input
	process(a, b, sel) is
	begin
		case sel is
			when '0' =>
				y <= a;
			when '1' =>
				y <= b;
		end case;
	end process;
end behavioral;
