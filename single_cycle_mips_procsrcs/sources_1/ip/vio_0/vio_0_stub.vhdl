-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
-- Date        : Tue Apr 11 09:41:34 2017
-- Host        : WLM3417EBAB1C33 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.srcs/sources_1/ip/vio_0/vio_0_stub.vhdl
-- Design      : vio_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vio_0 is
  Port ( 
    clk : in STD_LOGIC;
    probe_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    probe_in1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in3 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    probe_in4 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    probe_in5 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    probe_in6 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    probe_in7 : in STD_LOGIC_VECTOR ( 8 downto 0 );
    probe_in8 : in STD_LOGIC_VECTOR ( 8 downto 0 );
    probe_in9 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    probe_in10 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    probe_in11 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    probe_in12 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    probe_in13 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    probe_in14 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in15 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in16 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in17 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in18 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe_in19 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in20 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in21 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    probe_in22 : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );

end vio_0;

architecture stub of vio_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_in0[7:0],probe_in1[0:0],probe_in2[0:0],probe_in3[7:0],probe_in4[7:0],probe_in5[7:0],probe_in6[7:0],probe_in7[8:0],probe_in8[8:0],probe_in9[3:0],probe_in10[1:0],probe_in11[1:0],probe_in12[1:0],probe_in13[7:0],probe_in14[0:0],probe_in15[0:0],probe_in16[0:0],probe_in17[0:0],probe_in18[2:0],probe_in19[0:0],probe_in20[0:0],probe_in21[7:0],probe_in22[15:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vio,Vivado 2015.2";
begin
end;
