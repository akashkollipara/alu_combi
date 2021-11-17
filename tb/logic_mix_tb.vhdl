-- Name		: Akash Kollipara
-- BITS ID	: 2020ht01001
-- File		: logic_mix_tb.vhdl
-- Description	: This file consists of test bench for logic mix

entity logic_mix_tb is
end entity;

architecture behavioral of logic_mix_tb is
	-- Instantiate logic mix core
	component logic_mix
		port(
			a, b		: in bit_vector (31 downto 0);
			o_and, o_or	: out bit_vector (31 downto 0);
			o_xor, o_lui	: out bit_vector (31 downto 0)
		    );
	end component;

	-- Signals to connect the TB to logic-mix
	signal a, b		: bit_vector (31 downto 0);
	signal o_and, o_or	: bit_vector (31 downto 0);
	signal o_xor, o_lui	: bit_vector (31 downto 0);

	-- Delay of 350ps for representation purposes
	constant delay : time := 350 ps;

begin
	-- Connect logic-mix core
	logic_mix_uut: logic_mix port map(
						a => a,
						b => b,
						o_and => o_and,
						o_or => o_or,
						o_xor => o_xor,
						o_lui => o_lui
					 );

	-- Test bench to provide input and test output of 4 logic
	-- out signals
	test_process: process
	begin
		a <= "10101010101010101010101010101010";
		b <= "11001100110011001100110011001100";
		wait for delay;
		wait;
	end process;
end behavioral;
