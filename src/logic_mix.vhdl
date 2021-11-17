-- Author	: Akash Kollipara
-- BITS ID	: 2020ht01001
-- File		: mux_32b_2x1.vhdl

entity logic_mix is
	port(
		a, b		: in bit_vector (31 downto 0);
		o_and, o_or	: out bit_vector (31 downto 0);
		o_xor, o_lui	: out bit_vector (31 downto 0));
end entity;

architecture behavioral of logic_mix is
begin
	o_and <= a and b;
	o_or <= a or b;
	o_xor <= a xor b;
	o_lui(31 downto 16) <= b(15 downto 0);
end behavioral;

