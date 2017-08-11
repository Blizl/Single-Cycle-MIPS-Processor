----------------------------------------------------------------------------------
-- Company: Digilent Inc.
-- Engineer: Ryan Kim
-- Modification: Majid Sabbagh
-- Create Date:    11:50:03 10/24/2011 
-- Module Name:    OledExample - Behavioral 
-- Project Name: 	 PmodOLED Demo
-- Tool versions:  ISE 13.2
-- Description: Demo for the PmodOLED.  First displays the alphabet for ~4 seconds and then
--				Clears the display, waits for a ~1 second and then displays "This is Digilent's
--				PmodOLED"
--
-- Revision: 1.2
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity OledEx is
    Port ( CLK 				        : in  STD_LOGIC; --System CLK
			  RST 				    : in	STD_LOGIC; --Synchronous Reset
			  EN					: in  STD_LOGIC; --Example block enable pin
			  A 					: in STD_LOGIC_VECTOR(7 DOWNTO 0);--ALU first input
			  B 					: in STD_LOGIC_VECTOR(7 DOWNTO 0);--ALU second input
			  F 					: in STD_LOGIC_VECTOR(7 DOWNTO 0);--ALU output result
			  S 					: in STD_LOGIC_VECTOR(2 DOWNTO 0);--ALU operation select
			  OVF                   : in STD_LOGIC;--Overflow flag
			  CS  				    : out STD_LOGIC; --SPI Chip Select
			  SDO					: out STD_LOGIC; --SPI Data out
			  SCLK				    : out STD_LOGIC; --SPI Clock
			  DC					: out STD_LOGIC; --Data/Command Controller
			  FIN  				    : out STD_LOGIC);--Finish flag for example block
end OledEx;

architecture Behavioral of OledEx is

--SPI Controller Component
COMPONENT SpiCtrl
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         SPI_EN : IN  std_logic;
         SPI_DATA : IN  std_logic_vector(7 downto 0);
         CS : OUT  std_logic;
         SDO : OUT  std_logic;
         SCLK : OUT  std_logic;
         SPI_FIN : OUT  std_logic
        );
    END COMPONENT;

--Delay Controller Component
COMPONENT Delay
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         DELAY_MS : IN  std_logic_vector(11 downto 0);
         DELAY_EN : IN  std_logic;
         DELAY_FIN : OUT  std_logic
        );
    END COMPONENT;
	 
--Character Library, Latency = 1
COMPONENT charLib
  PORT (
    clka : IN STD_LOGIC; --Attach System Clock to it
    addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0); --First 8 bits is the ASCII value of the character the last 3 bits are the parts of the char
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) --Data byte out
  );
END COMPONENT;

--Binary to BCD converter
component BINBCD8 is
    Port ( BIN 	: in  STD_LOGIC_VECTOR(7 downto 0);
		BCD	: out STD_LOGIC_VECTOR(9 downto 0)
		);
end component;

--Sign detector
component SIGNDET is
    Port ( DATA: in STD_LOGIC_VECTOR (7 downto 0);--input data in two's complement
    SIGN: out STD_LOGIC_VECTOR (7 downto 0)--output sign vector
    );
end component;   

--States for state machine
type states is (Idle,
				ClearDC,
				SetPage,
				PageNum,
				LeftColumn1,
				LeftColumn2,
				SetDC,
				Alphabet,
				Wait1,
				ClearScreen,
				Wait2,
				DigilentScreen,
				UpdateScreen,
				SendChar1,
				SendChar2,
				SendChar3,
				SendChar4,
				SendChar5,
				SendChar6,
				SendChar7,
				SendChar8,
				ReadMem,
				ReadMem2,
				Done,
				Transition1,
				Transition2,
				Transition3,
				Transition4,
				Transition5
					);
type OledMem is array(0 to 3, 0 to 15) of STD_LOGIC_VECTOR(7 downto 0);

--Variable that contains what the screen will be after the next UpdateScreen state
signal current_screen : OledMem;
----Signal that contains the screen filled with the ALU results
--Variables used in the Delay Controller Block
signal IN1_1c : STD_LOGIC_VECTOR (7 downto 0); --First ALU input ASCII (first digit)
signal IN2_1c : STD_LOGIC_VECTOR (7 downto 0); --Second ALU input ASCII (first digit)
signal ALUOUT_1c : STD_LOGIC_VECTOR (7 downto 0); -- ALU output ASCII (first digit)
signal IN1_2c : STD_LOGIC_VECTOR (7 downto 0); --First ALU input ASCII (second digit)
signal IN2_2c : STD_LOGIC_VECTOR (7 downto 0); --Second ALU input ASCII (second digit)
signal ALUOUT_2c : STD_LOGIC_VECTOR (7 downto 0); -- ALU output ASCII (second digit)
signal IN1_3c : STD_LOGIC_VECTOR (7 downto 0); --First ALU input ASCII (third digit)
signal IN2_3c : STD_LOGIC_VECTOR (7 downto 0); --Second ALU input ASCII (third digit)
signal ALUOUT_3c : STD_LOGIC_VECTOR (7 downto 0); -- ALU output ASCII (third digit)

signal IN1_1c_s : STD_LOGIC_VECTOR (7 downto 0); --First ALU input ASCII (first digit)
signal IN2_1c_s : STD_LOGIC_VECTOR (7 downto 0); --Second ALU input ASCII (first digit)
signal ALUOUT_1c_s : STD_LOGIC_VECTOR (7 downto 0); -- ALU output ASCII (first digit)
signal IN1_2c_s : STD_LOGIC_VECTOR (7 downto 0); --First ALU input ASCII (second digit)
signal IN2_2c_s : STD_LOGIC_VECTOR (7 downto 0); --Second ALU input ASCII (second digit)
signal ALUOUT_2c_s : STD_LOGIC_VECTOR (7 downto 0); -- ALU output ASCII (second digit)
signal IN1_3c_s : STD_LOGIC_VECTOR (7 downto 0); --First ALU input ASCII (third digit)
signal IN2_3c_s : STD_LOGIC_VECTOR (7 downto 0); --Second ALU input ASCII (third digit)
signal ALUOUT_3c_s : STD_LOGIC_VECTOR (7 downto 0); -- ALU output ASCII (third digit)

--sign signals
signal IN1_sign_s : STD_LOGIC_VECTOR (7 downto 0); --First ALU input sign
signal IN2_sign_s : STD_LOGIC_VECTOR (7 downto 0); --Second ALU input sign
signal ALUOUT_sign_s : STD_LOGIC_VECTOR (7 downto 0); -- ALU output sign

signal OP : STD_LOGIC_VECTOR (7 downto 0); --ALU Operation Selection ASCII extra character
signal OP_EX : STD_LOGIC_VECTOR (7 downto 0); --ALU Operation Selection ASCII extra character
signal OVF_FLAG : STD_LOGIC_VECTOR (7 downto 0); --Overflow flag
signal TEMP_OVF : STD_LOGIC_VECTOR (7 downto 0); --OVF bit to vector conversion
--signal repeat_delay : STD_LOGIC; -- Repeat Delay

signal DELAY_COUNTER : STD_LOGIC_VECTOR (31 downto 0); --Delay Counter


signal A_BCD : STD_LOGIC_VECTOR (9 downto 0);
signal B_BCD : STD_LOGIC_VECTOR (9 downto 0);
signal F_BCD : STD_LOGIC_VECTOR (9 downto 0);

signal A_BCD_sign : STD_LOGIC_VECTOR (7 downto 0);
signal B_BCD_sign : STD_LOGIC_VECTOR (7 downto 0);
signal F_BCD_sign : STD_LOGIC_VECTOR (7 downto 0);

signal alphabet_screen : OledMem := ((X"20",X"20",X"20",X"20",X"44",X"4c",X"44",X"20",X"4C",X"61",X"62",X"20",X"20",X"20",X"20",X"20"),	
												(X"43",X"61",X"6C",X"63",X"75",X"6C",X"61",X"74",X"69",X"6F",X"6E",X"3A",X"0A",X"20",X"20",X"20"),
												(X"46",X"20",X"3D", IN1_sign_s, IN1_3c_s, IN1_2c_s, IN1_1c_s, OP, OP_EX, IN2_sign_s, IN2_3c_s, IN2_2c_s, IN2_1c_s, X"20",X"3D",X"3E"),
												(X"46",X"20",X"3D", ALUOUT_sign_s, ALUOUT_3c_s, ALUOUT_2c_s, ALUOUT_1c_s, X"20", X"20",X"20",X"20",X"4F",X"56",X"46",X"3A", OVF_FLAG));
----Constant that contains the screen filled with the Alphabet and numbers
--constant alphabet_screen : OledMem :=((X"41",X"42",X"43",X"44",X"45",X"46",X"47",X"48",X"49",X"4A",X"4B",X"4C",X"4D",X"4E",X"4F",X"50"),
--												(X"51",X"52",X"53",X"54",X"55",X"56",X"57",X"58",X"59",X"5A",X"61",X"62",X"63",X"64",X"65",X"66"),
--												(X"67",X"68",X"69",X"6A",X"6B",X"6C",X"6D",X"6E",X"6F",X"70",X"71",X"72",X"73",X"74",X"75",X"76"),
--												(X"77",X"78",X"79",X"7A",X"30",X"31",X"32",X"33",X"34",X"35",X"36",X"37",X"38",X"39",X"7F",X"7F"));
--Constant that fills the screen with blank (spaces) entries
constant clear_screen : OledMem :=   ((X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20"),	
												(X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20"),
												(X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20"),
												(X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20"));
--Constant that holds "This is Digilent's PmodOLED"
constant digilent_screen : OledMem:= ((X"54",X"68",X"69",X"73",X"20",X"69",X"73",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20"),
												(X"44",X"69",X"67",X"69",X"6C",X"65",X"6E",X"74",X"27",X"73",X"20",X"20",X"20",X"20",X"20",X"20"),
												(X"50",X"6D",X"6F",X"64",X"4F",X"4C",X"45",X"44",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20"),
												(X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20"));
--Current overall state of the state machine
signal current_state : states := Idle;
--State to go to after the SPI transmission is finished
signal after_state : states;
--State to go to after the set page sequence
signal after_page_state : states;
--State to go to after sending the character sequence
signal after_char_state : states;
--State to go to after the UpdateScreen is finished
signal after_update_state : states;

--Contains the value to be outputted to DC
signal temp_dc : STD_LOGIC := '0';

--Variables used in the Delay Controller Block
signal temp_delay_ms : STD_LOGIC_VECTOR (11 downto 0); --amount of ms to delay
signal temp_delay_en : STD_LOGIC := '0'; --Enable signal for the delay block
signal temp_delay_fin : STD_LOGIC; --Finish signal for the delay block

--Variables used in the SPI controller block
signal temp_spi_en : STD_LOGIC := '0'; --Enable signal for the SPI block
signal temp_spi_data : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); --Data to be sent out on SPI
signal temp_spi_fin : STD_LOGIC; --Finish signal for the SPI block

signal temp_char : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); --Contains ASCII value for character
signal temp_addr : STD_LOGIC_VECTOR (10 downto 0) := (others => '0'); --Contains address to BYTE needed in memory
signal temp_dout : STD_LOGIC_VECTOR (7 downto 0); --Contains byte outputted from memory
signal temp_page : STD_LOGIC_VECTOR (1 downto 0) := (others => '0'); --Current page
signal temp_index : integer range 0 to 15 := 0; --Current character on page

begin
DC <= temp_dc;
TEMP_OVF <= "0000000" & OVF;

IN1_1c <= "0000" & A_BCD(3 downto 0);
IN2_1c <= "0000" & B_BCD(3 downto 0);
ALUOUT_1c <= "0000" & F_BCD(3 downto 0);

IN1_2c <= "0000" & A_BCD(7 downto 4);
IN2_2c <= "0000" & B_BCD(7 downto 4);
ALUOUT_2c <= "0000" & F_BCD(7 downto 4);

IN1_3c <= "000000" & A_BCD(9 downto 8);
IN2_3c <= "000000" & B_BCD(9 downto 8);
ALUOUT_3c <= "000000" & F_BCD(9 downto 8);

IN1_sign_s <= A_BCD_sign;
IN2_sign_s <= B_BCD_sign;
ALUOUT_sign_s <= F_BCD_sign; 

--Example finish flag only high when in done state
FIN <= '1' when (current_state = Done) else
					'0';
--Instantiate SPI Block
 SPI_COMP: SpiCtrl PORT MAP (
          CLK => CLK,
          RST => RST,
          SPI_EN => temp_spi_en,
          SPI_DATA => temp_spi_data,
          CS => CS,
          SDO => SDO,
          SCLK => SCLK,
          SPI_FIN => temp_spi_fin
        );
--Instantiate Delay Block
   DELAY_COMP: Delay PORT MAP (
          CLK => CLK,
          RST => RST,
          DELAY_MS => temp_delay_ms,
          DELAY_EN => temp_delay_en,
          DELAY_FIN => temp_delay_fin);
--Instantiate Memory Block
CHAR_LIB_COMP : charLib
  PORT MAP (
    clka => CLK,
    addra => temp_addr,
    douta => temp_dout);
  
  --Sign Recognition
  SIGNDETect_alu1stin: SIGNDET Port map(A, A_BCD_sign);
  SIGNDETect_alu2ndin: SIGNDET Port map(B, B_BCD_sign);
  SIGNDETect_aluout: SIGNDET Port map(F, F_BCD_sign); 
  --Instantiate Binary to BCD converter
  Bin2BCDconv_alu1stin: BINBCD8 Port map(A, A_BCD);
  Bin2BCDconv_alu2ndin: BINBCD8 Port map(B, B_BCD);
  Bin2BCDconv_aluout: BINBCD8 Port map(F, F_BCD);
  -- Reference: Wakerely, p. 410
  -- Converting ALU PORTs to ASCII equivalent
  process(S, A, B, F, OVF)-- execution if there is a change in S, A, B, C, or D
	begin
		case S is -- All RHS variables and S are in the sensitivity list.
		when "000" => -- add operation
		IN1_1c_s <= IN1_1c + X"30";
        IN1_2c_s <= IN1_2c + X"30";
        IN1_3c_s <= IN1_3c + X"30";                  
        IN2_1c_s <= IN2_1c + X"30";
        IN2_2c_s <= IN2_2c + X"30";
        IN2_3c_s <= IN2_3c + X"30";
        ALUOUT_1c_s <=  ALUOUT_1c + X"30";
        ALUOUT_2c_s <=  ALUOUT_2c + X"30";
        ALUOUT_3c_s <=  ALUOUT_3c + X"30";
        OP <= X"2B";
        OP_EX <= X"20";
        OVF_FLAG <= TEMP_OVF + X"30";      
         	
		when "001" => -- not operation on second input
		IN1_1c_s <= X"20";
        IN1_2c_s <= X"20";
        IN1_3c_s <= X"20";                  
        IN2_1c_s <= IN2_1c + X"30";
        IN2_2c_s <= IN2_2c + X"30";
        IN2_3c_s <= IN2_3c + X"30";
        ALUOUT_1c_s <=  ALUOUT_1c + X"30";
        ALUOUT_2c_s <=  ALUOUT_2c + X"30";
        ALUOUT_3c_s <=  ALUOUT_3c + X"30";
        OP <= X"20";
        OP_EX <= X"7E";
        OVF_FLAG <= TEMP_OVF + X"30";      
        			
		when "010" => -- and operation
		IN1_1c_s <= IN1_1c + X"30";
        IN1_2c_s <= IN1_2c + X"30";
        IN1_3c_s <= IN1_3c + X"30";                  
        IN2_1c_s <= IN2_1c + X"30";
        IN2_2c_s <= IN2_2c + X"30";
        IN2_3c_s <= IN2_3c + X"30";
        ALUOUT_1c_s <=  ALUOUT_1c + X"30";
        ALUOUT_2c_s <=  ALUOUT_2c + X"30";
        ALUOUT_3c_s <=  ALUOUT_3c + X"30";  		
		OP <= X"26";
		OP_EX <= X"20";	
		OVF_FLAG <= TEMP_OVF + X"30";
		 	
		when "011" => -- or operation
		IN1_1c_s <= IN1_1c + X"30";
        IN1_2c_s <= IN1_2c + X"30";
        IN1_3c_s <= IN1_3c + X"30";                  
        IN2_1c_s <= IN2_1c + X"30";
        IN2_2c_s <= IN2_2c + X"30";
        IN2_3c_s <= IN2_3c + X"30";
        ALUOUT_1c_s <=  ALUOUT_1c + X"30";
        ALUOUT_2c_s <=  ALUOUT_2c + X"30";
        ALUOUT_3c_s <=  ALUOUT_3c + X"30";
		OP <= X"7C";
		OP_EX <= X"20";
		OVF_FLAG <= TEMP_OVF + X"30";  	
			
		when "100" => -- xor operation
		IN1_1c_s <= IN1_1c + X"30";
        IN1_2c_s <= IN1_2c + X"30";
        IN1_3c_s <= IN1_3c + X"30";                  
        IN2_1c_s <= IN2_1c + X"30";
        IN2_2c_s <= IN2_2c + X"30";
        IN2_3c_s <= IN2_3c + X"30";
        ALUOUT_1c_s <=  ALUOUT_1c + X"30";
        ALUOUT_2c_s <=  ALUOUT_2c + X"30";
        ALUOUT_3c_s <=  ALUOUT_3c + X"30";
        OP <= X"5E";
        OP_EX <= X"20";        	
		OVF_FLAG <= TEMP_OVF + X"30"; 
			
		when "101" => 
		IN1_1c_s <= IN1_1c + X"30";
        IN1_2c_s <= IN1_2c + X"30";
        IN1_3c_s <= IN1_3c + X"30";                  
        IN2_1c_s <= IN2_1c + X"30";
        IN2_2c_s <= IN2_2c + X"30";
        IN2_3c_s <= IN2_3c + X"30";
        ALUOUT_1c_s <=  ALUOUT_1c + X"30";
        ALUOUT_2c_s <=  ALUOUT_2c + X"30";
        ALUOUT_3c_s <=  ALUOUT_3c + X"30";
        OP <= X"3C";
        OP_EX <= X"20";
		OVF_FLAG <= TEMP_OVF + X"30"; 	
	
		when "110" => 
		IN1_1c_s <= IN1_1c + X"30";
        IN1_2c_s <= IN1_2c + X"30";
        IN1_3c_s <= IN1_3c + X"30";                  
        IN2_1c_s <= IN2_1c + X"30";
        IN2_2c_s <= IN2_2c + X"30";
        IN2_3c_s <= IN2_3c + X"30";
        ALUOUT_1c_s <=  ALUOUT_1c + X"30";
        ALUOUT_2c_s <=  ALUOUT_2c + X"30";
        ALUOUT_3c_s <=  ALUOUT_3c + X"30";
        OP <= X"3D";
        OP_EX <= X"3D";        
		OVF_FLAG <= TEMP_OVF + X"30";         
        		
		when "111" => 
		IN1_1c_s <= IN1_1c + X"30";
        IN1_2c_s <= IN1_2c + X"30";
        IN1_3c_s <= IN1_3c + X"30";                  
        IN2_1c_s <= IN2_1c + X"30";
        IN2_2c_s <= IN2_2c + X"30";
        IN2_3c_s <= IN2_3c + X"30";
        ALUOUT_1c_s <=  ALUOUT_1c + X"30";
        ALUOUT_2c_s <=  ALUOUT_2c + X"30";
        ALUOUT_3c_s <=  ALUOUT_3c + X"30";
		OP <= X"21";
        OP_EX <= X"3D";            
		OVF_FLAG <= TEMP_OVF + X"30"; 

		when others => 
		IN1_1c_s <= X"20";
        IN1_2c_s <= X"20";
        IN1_3c_s <= X"20";                  
        IN2_1c_s <= X"20";
        IN2_2c_s <= X"20";
        IN2_3c_s <= X"20";
        ALUOUT_1c_s <=  X"20";
        ALUOUT_2c_s <=  X"20";
        ALUOUT_3c_s <=  X"20";
		OP <= X"20";
		OP_EX <= X"20";
		OVF_FLAG <= X"20";		
	end case;
  end process;
  
	process (CLK)
	begin
		if(rising_edge(CLK)) then
			case(current_state) is
				--Idle until EN pulled high than intialize Page to 0 and go to state Alphabet afterwards
				when Idle => 
					if(EN = '1') then
						current_state <= ClearDC;
						after_page_state <= Alphabet;
						temp_page <= "00";
						DELAY_COUNTER <= X"00000000";
						--repeat_delay <= '1';
					end if;
				--Set current_screen to constant alphabet_screen and update the screen.  Go to state Wait1 afterwards
				when Alphabet => 
					current_screen <= alphabet_screen;
					current_state <= UpdateScreen;
					after_update_state <= Wait1;
				--Wait 4ms and go to ClearScreen
				when Wait1 => 
--					if(repeat_delay = '0') then
                    if (DELAY_COUNTER = X"3B9ACA00") then
                        DELAY_COUNTER <= X"00000000";
                        temp_delay_ms <= "111110100000"; --4000
                        after_state <= ClearScreen;
                        current_state <= Transition3; --Transition3 = The delay transition states
                    else
                    DELAY_COUNTER <= DELAY_COUNTER + X"00000001";
--                        repeat_delay <= '0';
--                    	current_screen <= alphabet_screen;
--                        current_state <= UpdateScreen;
--                        after_update_state <= Wait1;
--                        temp_delay_ms <= "111110100000"; --4000
                    end if;
				--set current_screen to constant clear_screen and update the screen. Go to state Wait2 afterwards
				when ClearScreen => 
					current_screen <= clear_screen;
					after_update_state <= Wait2;
					current_state <= UpdateScreen;
				--Wait 1ms and go to DigilentScreen
				when Wait2 =>
					temp_delay_ms <= "001111101000"; --1000
					after_state <= DigilentScreen;
					current_state <= Transition3; --Transition3 = The delay transition states
				--Set currentScreen to constant digilent_screen and update the screen. Go to state Done afterwards
				when DigilentScreen =>
					current_screen <= digilent_screen;
					after_update_state <= Done;
					current_state <= UpdateScreen;
				--Do nothing until EN is deassertted and then current_state is Idle
				when Done			=>
					if(EN = '0') then
						current_state <= Idle;
					end if;
					
				--UpdateScreen State
				--1. Gets ASCII value from current_screen at the current page and the current spot of the page
				--2. If on the last character of the page transition update the page number, if on the last page(3)
				--			then the updateScreen go to "after_update_state" after 
				when UpdateScreen =>
					temp_char <= current_screen(CONV_INTEGER(temp_page),temp_index);
					if(temp_index = 15) then	
						temp_index <= 0;
						temp_page <= temp_page + 1;
						after_char_state <= ClearDC;
						if(temp_page = "11") then
							after_page_state <= after_update_state;
						else	
							after_page_state <= UpdateScreen;
						end if;
					else
						temp_index <= temp_index + 1;
						after_char_state <= UpdateScreen;
					end if;
					current_state <= SendChar1;
				
				--Update Page states
				--1. Sets DC to command mode
				--2. Sends the SetPage Command
				--3. Sends the Page to be set to
				--4. Sets the start pixel to the left column
				--5. Sets DC to data mode
				when ClearDC =>
					temp_dc <= '0';
					current_state <= SetPage;
				when SetPage =>
					temp_spi_data <= "00100010";
					after_state <= PageNum;
					current_state <= Transition1;
				when PageNum =>
					temp_spi_data <= "000000" & temp_page;
					after_state <= LeftColumn1;
					current_state <= Transition1;
				when LeftColumn1 =>
					temp_spi_data <= "00000000";
					after_state <= LeftColumn2;
					current_state <= Transition1;
				when LeftColumn2 =>
					temp_spi_data <= "00010000";
					after_state <= SetDC;
					current_state <= Transition1;
				when SetDC =>
					temp_dc <= '1';
					current_state <= after_page_state;
				--End Update Page States

				--Send Character States
				--1. Sets the Address to ASCII value of char with the counter appended to the end
				--2. Waits a clock for the data to get ready by going to ReadMem and ReadMem2 states
				--3. Send the byte of data given by the block Ram
				--4. Repeat 7 more times for the rest of the character bytes
				when SendChar1 =>
					temp_addr <= temp_char & "000";
					after_state <= SendChar2;
					current_state <= ReadMem;
				when SendChar2 =>
					temp_addr <= temp_char & "001";
					after_state <= SendChar3;
					current_state <= ReadMem;
				when SendChar3 =>
					temp_addr <= temp_char & "010";
					after_state <= SendChar4;
					current_state <= ReadMem;
				when SendChar4 =>
					temp_addr <= temp_char & "011";
					after_state <= SendChar5;
					current_state <= ReadMem;
				when SendChar5 =>
					temp_addr <= temp_char & "100";
					after_state <= SendChar6;
					current_state <= ReadMem;
				when SendChar6 =>
					temp_addr <= temp_char & "101";
					after_state <= SendChar7;
					current_state <= ReadMem;
				when SendChar7 =>
					temp_addr <= temp_char & "110";
					after_state <= SendChar8;
					current_state <= ReadMem;
				when SendChar8 =>
					temp_addr <= temp_char & "111";
					after_state <= after_char_state;
					current_state <= ReadMem;
				when ReadMem =>
					current_state <= ReadMem2;
				when ReadMem2 =>
					temp_spi_data <= temp_dout;
					current_state <= Transition1;
				--End Send Character States
					
				--SPI transitions
				--1. Set SPI_EN to 1
				--2. Waits for SpiCtrl to finish
				--3. Goes to clear state (Transition5)
				when Transition1 =>
					temp_spi_en <= '1';
					current_state <= Transition2;
				when Transition2 =>
					if(temp_spi_fin = '1') then
						current_state <= Transition5;
					end if;
					
				--Delay Transitions
				--1. Set DELAY_EN to 1
				--2. Waits for Delay to finish
				--3. Goes to Clear state (Transition5)
				when Transition3 =>
					temp_delay_en <= '1';
					current_state <= Transition4;
				when Transition4 =>
					if(temp_delay_fin = '1') then
						current_state <= Transition5;
					end if;
				
				--Clear transition
				--1. Sets both DELAY_EN and SPI_EN to 0
				--2. Go to after state
				when Transition5 =>
					temp_spi_en <= '0';
					temp_delay_en <= '0';
					current_state <= after_state;
				--END SPI transitions
				--END Delay Transitions
				--END Clear transition
			
				when others 		=>
					current_state <= Idle;
			end case;
		end if;
	end process;
	
end Behavioral;