----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:45:47 02/26/2018 
-- Design Name: 
-- Module Name:    testpowermath - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testpowermath is
	generic (
		pwmsize : integer := 16;
		rastersize : integer := 8
	);
    Port ( 
		clk: in std_logic;
		pwmoriginal : in  STD_LOGIC_VECTOR (pwmsize-1 downto 0);
      rasterpower : in  STD_LOGIC_VECTOR (rastersize-1 downto 0);
      pwmout : out  STD_LOGIC_VECTOR (pwmsize-1 downto 0)
	);
end testpowermath;

architecture Behavioral of testpowermath is


signal b: unsigned(pwmsize+rastersize*2-1 downto 0);


begin
	atestpowermath: process  (clk, pwmoriginal, rasterpower, b)
	begin
    
        -- min = 1/256
        -- max = 240/256
        -- 
        -- main
        -- main_max
        -- scale
        -- scale_max
        -- 
        -- y = main * (scale / scale_max) * (max - min) + min * main_max
        -- y = main * (scale / scale_max) * ((240-1) / 256) + (1/256 * main_max)
        -- 
        -- y = (main * scale * 239 + B) / scale_max / 256
        -- 
        -- B = main_max * scale_max
    
		b <= unsigned(rasterpower) * (240-1) * unsigned(pwmoriginal) + (2 ** (pwmsize+rastersize));
		if rising_edge(clk) then
			pwmout <= std_logic_vector(b(rastersize+8+pwmsize-1 downto rastersize+8));
		end if;
	end process atestpowermath;
end Behavioral;

