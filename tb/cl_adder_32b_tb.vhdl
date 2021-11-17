-- Name		: Akash Kollipara
-- BITS ID	: 2020ht01001
-- File		: cl_adder_32b_tb.vhdl

entity cl_adder_32b_tb is
end entity;

architecture behavioral of cl_adder_32b_tb is
	-- Instantiate CLA Adder core
	component cl_adder_32b
		port(
			a, b	: in bit_vector (31 downto 0);
			sub	: in bit;
			s	: out bit_vector (31 downto 0)
		    );
	end component;

	-- Signal to connect the TB to CLA adder
	signal a, b	: bit_vector (31 downto 0);
	signal sub	: bit;
	signal s	: bit_vector (31 downto 0);

	-- Delay of 350ps for representation purposes
	constant delay : time := 350 ps;

begin
	-- Connect CLA Adder
	adder_uut: cl_adder_32b port map(
						a => a,
						b => b,
						sub => sub,
						s => s
					   );

	-- Test bench to change CLA adder inputes and test the
	-- functionality
	test_process: process
	begin
		a <= "00000000000000101010101010101010";
		b <= "00000000000000001100110011001100";

		sub <= '0';
		wait for delay;
		sub <= '1';
		wait for delay;
		wait;
	end process;
end behavioral;
