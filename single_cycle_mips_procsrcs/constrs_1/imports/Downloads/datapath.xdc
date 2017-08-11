## 
##  Modified by Farhad Abdolian (fabdolian@seemaconsulting.com) Nov. 5, 2012
##  Translated to XDC by Majid Sabbagh (sabbagh.m@husky.neu.edu) Aug. 17, 2014

set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

create_clock -period 10.000 -name clk [get_ports clk]

#We use the right push button as the general reset for this project
set_property PACKAGE_PIN R18 [get_ports right_pb_rst_general]
set_property IOSTANDARD LVCMOS33 [get_ports right_pb_rst_general]

#We use the left push button as the general reset for this project
set_property PACKAGE_PIN N15 [get_ports left_pb_rst_screen]
set_property IOSTANDARD LVCMOS33 [get_ports left_pb_rst_screen]

#We use the top push button as the clock pulse source for this project
set_property PACKAGE_PIN T18 [get_ports top_pb_clk]
set_property IOSTANDARD LVCMOS33 [get_ports top_pb_clk]

set_property PACKAGE_PIN AA12 [get_ports sdin]
set_property IOSTANDARD LVCMOS33 [get_ports sdin]

set_property PACKAGE_PIN AB12 [get_ports sclk]
set_property IOSTANDARD LVCMOS33 [get_ports sclk]

set_property PACKAGE_PIN U10 [get_ports dc]
set_property IOSTANDARD LVCMOS33 [get_ports dc]

set_property PACKAGE_PIN U9 [get_ports res]
set_property IOSTANDARD LVCMOS33 [get_ports res]

set_property PACKAGE_PIN U11 [get_ports vbat]
set_property IOSTANDARD LVCMOS33 [get_ports vbat]

set_property PACKAGE_PIN U12 [get_ports vdd]
set_property IOSTANDARD LVCMOS33 [get_ports vdd]
