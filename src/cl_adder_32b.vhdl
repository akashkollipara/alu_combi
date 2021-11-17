-- Author	: Akash Kollipara
-- BITS ID	: 2020ht01001
-- File		: cl_adder_32b.vhdl
-- Description	: This file consists of Carry Look-ahead Adder
--		  which is built from 1bit partial full adder

entity partial_full_adder is
	-- Defining port for partial full adder
	port(
		a, b, c	: in bit;
		s, p, g	: out bit
	);
end partial_full_adder;

architecture behavioral of partial_full_adder is
begin
	-- Building logic for 1bit partial full adder
	-- This unit computes, sum, p and g
	s <= a xor b xor c;
	p <= a xor b;
	g <= a and b;
end behavioral;

entity cl_adder_32b is
	-- Defining port for carry look-ahead adder
	port(
		a, b	: in bit_vector (31 downto 0);
		s	: out bit_vector (31 downto 0);
		sub	: in bit
	);
end cl_adder_32b;

architecture behavioral of cl_adder_32b is
	-- Instantiate partial full adder core
	component partial_full_adder is
		port(
			a, b, c	: in bit;
			s, p, g : out bit
		    );
	end component;

	-- Signals for connecting the PFA cores
	signal g, p, bp	: bit_vector (31 downto 0);
	signal c	: bit_vector (32 downto 0);
begin
	-- If sub is enabled then carry needs to be set for generating
	-- complement of the number
	c(0) <= sub;
	-- Finding 2's complement
	complement_b: for i in 0 to 31 generate
		bp(i) <= b(i) xor sub;
	end generate complement_b;

	-- Generate the connections for 32 PFA core to build 32b CLA adder
	connect_pfas: for i in 0 to 31 generate
		pfa: partial_full_adder
		port map(
				a => a(i),
				b => bp(i),
				c => c(i),
				s => s(i),
				p => p(i),
				g => g(i)
			);
		c(i+1) <= g(i) or (p(i) and c(i));
	end generate connect_pfas;
end behavioral;
