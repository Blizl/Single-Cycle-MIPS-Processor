----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- VHDL Examples
-- Subra Ganesan
-- Reference: Professor Haskell's Notes,
-- Digital design with VHDL book by Vranesic
-- Create Date: 08/23/2014 10:39:18 PM
-- Design Name: 
-- Module Name: binbcd8 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BINBCD8 is
    Port (
    BIN: in STD_LOGIC_VECTOR (7 downto 0);
    BCD: out STD_LOGIC_VECTOR (9 downto 0)
     );
end BINBCD8;

architecture Behavioral of binbcd8 is

begin

      bcd1: process(BIN)
    
	  variable BIN_proc: STD_LOGIC_VECTOR (7 downto 0);
      variable z: STD_LOGIC_VECTOR (17 downto 0);
    
      begin     
              --Two's complement conversion
              if(BIN(7) = '1') then
                BIN_proc := not BIN;
                BIN_proc := BIN_proc + '1';
              else
                BIN_proc := BIN;  
              end if;
		    
              for i in 0 to 17 loop
                    z(i) := '0';
              end loop;
                    z(10 downto 3) := BIN_proc;
         
              for i in 0 to 4 loop
                if z(11 downto 8) > 4 then    
                     z(11 downto 8) := z(11 downto 8) + 3;
                end if;
              
                if z(15 downto 12) > 4 then    
                     z(15 downto 12) := z(15 downto 12) + 3;
                end if;
              
                z(17 downto 1) := z(16 downto 0);
                
              end loop;
                
              BCD <= z(17 downto 8);  
         
       end process bcd1;            

end Behavioral;