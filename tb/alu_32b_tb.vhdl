-- Name		: Akash Kollipara
-- BITS ID	: 2020ht01001
-- File		: alu_32b_tb.vhdl
-- Description  : This file consists of test bench for alu

entity alu_32b_tb is
end entity;

architecture behavioral of alu_32b_tb is
	-- Instantiate ALU core
	component alu_32b
		port(
			a, b	: in bit_vector (31 downto 0);
			aluc	: in bit_vector (3 downto 0);
			c	: out bit_vector (31 downto 0)
		    );
	end component;

	-- Signals to connect the TB to ALU
	signal a, b, c	: bit_vector (31 downto 0);
	signal aluc	: bit_vector (3 downto 0);

	-- Delay of 350ps for representation purposes
	constant delay : time := 350 ps;

begin
	-- Connect alu
	alu_uut: alu_32b port map(
					a => a,
					b => b,
					c => c,
					aluc => aluc
				 );

	-- Test bench to change ALU inputs and control signal
	-- to test all the modules of ALU
	test_process: process
	begin
		a <= "00000000000000000000000000011011";
		b <= "00000000000000000000000000010010";
		aluc <= "0000";	-- select add
		wait for delay;

		aluc <= "0100";	-- select sub
		wait for delay;

		aluc <= "0001";	-- select and
		wait for delay;

		aluc <= "0101";	-- select or
		wait for delay;

		aluc <= "0010";	-- select xor
		wait for delay;

		aluc <= "0110";	-- select lui
		wait for delay;

		a <= "00000000000000000000000000000101";
		b <= "00000000111111110000000011111111";
		aluc <= "0011";	-- select sll
		wait for delay;

		aluc <= "0111";	-- select srl
		wait for delay;

		aluc <= "1111";	-- select sra
		wait for delay;
		wait;
	end process;
end behavioral;
		
