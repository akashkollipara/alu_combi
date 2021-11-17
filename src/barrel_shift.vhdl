-- Author	: Akash Kollipara
-- BITS ID	: 2020ht01001
-- File		: barrel_shifter.vhdl
-- Description	: This file consists of barrel shifter core

-- These libraries are necessary for managing signed operations
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity barrel_shifter is
	-- Defining ports for barrel shifter
	port(
		a, b	: in bit_vector (31 downto 0);
		cntr	: in bit;
		opr	: in bit;
		y	: out bit_vector (31 downto 0));
end entity;

architecture behavioral of barrel_shifter is
	-- Create signal for shift_size
	signal shift_size	: std_logic_vector (4 downto 0);
begin
	-- Convert bit_vector to std_logic_vector
	shift_size <= to_stdlogicvector(a (4 downto 0));
	-- Process to define shift logic
	process(shift_size, b, cntr, opr)
	begin
		case cntr is
			when '0' =>
				-- Logical left shifter
				y <= b sll to_integer(unsigned(shift_size));
			when '1' =>
				case opr is
					when '0' =>
						-- Logical right shifter
						y <= b srl to_integer(unsigned(shift_size));
					when '1' =>
						-- Arithmatic right shifter
						y <= b sra to_integer(unsigned(shift_size));
				end case;
		end case;
	end process;
end behavioral;

