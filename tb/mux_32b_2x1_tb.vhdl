-- Name		: Akash Kollipara
-- BITS ID	: 2020ht01001
-- File		: mux_32b_2x1_tb.vhdl
-- Description	: This file consists of test bench for mux 2x1

entity mux_32b_2x1_tb is
end entity;

architecture behavioral of mux_32b_2x1_tb is
	-- Instantiate Mux 2x1 Core
	component mux_32b_2x1
		port(
			a, b	: in bit_vector (31 downto 0);
			sel	: in bit;
			y	: out bit_vector (31 downto 0)
		    );
	end component;

	-- Signals to connect the TB and Mux 2x1 core
	signal a, b	: bit_vector (31 downto 0);
	signal sel	: bit;
	signal y	: bit_vector (31 downto 0);

	-- Delay of 350ps for representation purposes
	constant delay : time := 350 ps;
begin
	-- Connect Mux 2x1
	mux_uut: mux_32b_2x1 port map(
					a => a,
					b => b,
					sel => sel,
					y => y
				     );

	-- Test bench to check the mux functionality
	test_process: process
		begin
			a <= "00000000000000000000000000001111";
			b <= "00000000000000000000000011110000";
			sel <= '0';	-- select a
			wait for delay;
			sel <= '1';	-- select b
			wait for delay;
			wait;
		end process;
end behavioral;

