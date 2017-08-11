----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- Majid Sabbagh
-- Create Date: 08/23/2014 10:39:18 PM
-- Design Name: 
-- Module Name: SIGNDET
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- This module detects the sign of input.
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SIGNDET is
    Port (
    DATA: in STD_LOGIC_VECTOR (7 downto 0);--input data in two's complement
    SIGN: out STD_LOGIC_VECTOR (7 downto 0)--Sign ASCII - or Space
     );
end SIGNDET;

architecture Behavioral of signdet is

begin

      signcheck: process(DATA)
    
      begin
            if(DATA(7) = '1') then
                SIGN <= X"2D";-- negative  
            else
                SIGN <= X"20";-- space, for positive numbers    
            end if;
      end process signcheck;            

end Behavioral;