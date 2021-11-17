-- Author	: Akash Kollipara
-- BITS ID	: 2020ht01001
-- File		: 32b_mux_2x1.vhdl
-- Description	: This file consists of the 4x1 multiplexer core

entity mux_32b_4x1 is
	-- Defining port for Mux 4x1
	port(
		a, b, c, d	: in bit_vector (31 downto 0);
		sel		: in bit_vector (1 downto 0);
		y		: out bit_vector (31 downto 0));
end entity;

architecture behavioral of mux_32b_4x1 is
begin
	-- Case logic to select input
	process(a, b, c, d, sel) is
	begin
		case sel is
			when "00" =>
				y <= a;
			when "01" =>
				y <= b;
			when "10" =>
				y <= c;
			when "11" =>
				y <= d;
		end case;
	end process;
end behavioral;

