-- Author	: Akash Kollipara
-- BITS ID	: 2020ht01001
-- File		: alu_32b.vhdl
-- Description	: This file consists of alu 32bit model based on CLA,
--		  barrel shifter and logic mix core.

entity alu_32b is
	-- Defining port for ALU
	port(
		a, b	: in bit_vector (31 downto 0);
		aluc	: in bit_vector (3 downto 0);
		c	: out bit_vector (31 downto 0)
	    );
end entity;

architecture structural of alu_32b is
	-- Create signals for internally connecting modules
	signal aluc_2	: bit;
	signal aluc_3	: bit;
	signal o_cla	: bit_vector (31 downto 0);
	signal o_l_and	: bit_vector (31 downto 0);
	signal o_l_or	: bit_vector (31 downto 0);
	signal o_l_xor	: bit_vector (31 downto 0);
	signal o_l_lui	: bit_vector (31 downto 0);
	signal o_shift	: bit_vector (31 downto 0);
	signal o_mux1	: bit_vector (31 downto 0);
	signal o_mux2	: bit_vector (31 downto 0);
	
	-- Instantiate carry look-ahead adder core
	component cl_adder_32b is
		port(
			a, b	: in bit_vector (31 downto 0);
			s	: out bit_vector (31 downto 0);
			sub	: in bit
		    );
	end component;
	
	-- Instantiate barrel shifter core
	component barrel_shifter is
		port(
			a, b	: in bit_vector (31 downto 0);
			cntr	: in bit;
			opr	: in bit;
			y	: out bit_vector (31 downto 0)
		    );
	end component;

	-- Instantiate logic mix core
	component logic_mix is
		port(
			a, b	: in bit_vector (31 downto 0);
			o_and	: out bit_vector (31 downto 0);
			o_or	: out bit_vector (31 downto 0);
			o_xor	: out bit_vector (31 downto 0);
			o_lui	: out bit_vector (31 downto 0)
		    );
	end component;

	-- Instantiate mux 2x1 core
	component mux_32b_2x1 is
		port(
			a, b	: in bit_vector (31 downto 0);
			sel	: in bit;
			y	: out bit_vector (31 downto 0)
		    );
	end component;

	-- Instantiate mux 4x1 core
	component mux_32b_4x1 is
		port(
			a, b	: in bit_vector (31 downto 0);
			c, d	: in bit_vector (31 downto 0);
			sel	: in bit_vector (1 downto 0);
			y	: out bit_vector (31 downto 0)
		    );
	end component;
begin
	aluc_2 <= aluc(2);	-- Extract 2 bit of ALU-Control
	aluc_3 <= aluc(3);	-- Extract 3 bit of ALU-Control

	-- Connect carry look-ahead adder core with signals
	alu_adder: cl_adder_32b port map(
						a => a,
						b => b,
						s => o_cla,
						sub => aluc_2
					);

	-- Connect logic mix core with signals
	alu_logic: logic_mix port map(
						a => a,
						b => b,
						o_and => o_l_and,
						o_or => o_l_or,
						o_xor => o_l_xor,
						o_lui => o_l_lui
				     );

	-- Connect mux 2x1 core with signals, this mux will control
	-- the flow of "and" & "or" of logic mix
	alu_l_mux1: mux_32b_2x1 port map(
						a => o_l_and,
						b => o_l_or,
						y => o_mux1,
						sel => aluc_2
					);

	-- Connect mux 2x1 core with signals, this mux will control
	-- the flow of "xor" & "lui" of logic mix
	alu_l_mux2: mux_32b_2x1 port map(
						a => o_l_xor,
						b => o_l_lui,
						y => o_mux2,
						sel => aluc_2
					);

	-- Connect barrel shifter core with signals
	alu_shift: barrel_shifter port map(
						a => a,
						b => b,
						cntr => aluc_2,
						opr => aluc_3,
						y => o_shift
					  );

	-- Connect mux 4x1 core with signals, this mux will control
	-- the flow of "cl_adder_32b" core, "logic_mix" core, and "barrel-shifter" core.
	alu_mux: mux_32b_4x1 port map(
						a => o_cla,
						b => o_mux1,
						c => o_mux2,
						d => o_shift,
						sel => aluc (1 downto 0),
						y => c
				     );
end structural;
