-- Name		: Akash Kollipara
-- BITS ID	: 2020ht01001
-- File		: barrel_shift_tb.vhdl
-- Description  : This file consists of test bench for barrel shifter

entity barrel_shift_tb is
end entity;

architecture behavioral of barrel_shift_tb is
	-- Instantiate Barrel Shifter core
	component barrel_shifter
		port(
			a, b	: in bit_vector (31 downto 0);
			cntr	: in bit;
			opr	: in bit;
			y	: out bit_vector (31 downto 0)
		    );
	end component;

	-- Signal to connect the TB and Barrel Shifter
	signal a, b, y	: bit_vector (31 downto 0);
	signal cntr, opr: bit;

	-- Delay of 350ps for representation purposes
	constant delay : time := 350 ps;

begin
	-- Connect barrel shifter
	bs_uut: barrel_shifter port map(
					a => a,
					b => b,
					cntr => cntr,
					opr => opr,
					y => y
				     );

	-- Test bench to change inputs of Barrel Shifter
	test_process: process
	begin
		a <= "00000000000000000000000000000101";
		b <= "00000000111111110000000011111111";

		cntr <= '0';	-- select sll
		opr <= '0';
		wait for delay;

		cntr <= '1';	-- select srl
		wait for delay;
		
		opr <= '1';	-- select sra
		wait for delay;
		wait;
	end process;
end behavioral;
