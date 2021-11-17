-- Name		: Akash Kollipara
-- BITS ID	: 2020ht01001
-- File		: mux_32b_4x1_tb.vhdl
-- Description	: This file consists of test bench for mux 4x1

entity mux_32b_4x1_tb is
end entity;

architecture behavioral of mux_32b_4x1_tb is
	-- Instantiate Mux 4x1 core
	component mux_32b_4x1
		port(
			a, b	: in bit_vector (31 downto 0);
			c, d	: in bit_vector (31 downto 0);
			sel	: in bit_vector (1 downto 0);
			y	: out bit_vector (31 downto 0)
		    );
	end component;

	-- Signals to connect TB and Mux 4x1 core
	signal a, b, c, d	: bit_vector (31 downto 0);
	signal sel		: bit_vector (1 downto 0);
	signal y		: bit_vector (31 downto 0);

	-- Delay of 350ps for representation purposes
	constant delay : time := 350 ps;
begin
	-- Connect Mux 4x1
	mux_uut: mux_32b_4x1 port map(
					a => a,
					b => b,
					c => c,
					d => d,
					sel => sel,
					y => y
				     );

	-- Test bench to check the mux functionality
	test_process: process
	begin
		a <= "00000000000000000000000000001111";
		b <= "00000000000000000000000011110000";
		c <= "00000000000000000000111100000000";
		d <= "00000000000000001111000000000000";
		sel <= "00";	-- select a
		wait for delay;
		sel <= "01";	-- select b
		wait for delay;
		sel <= "10";	-- select c
		wait for delay;
		sel <= "11";	-- select d
		wait for delay;
		wait;
	end process;
end behavioral;

