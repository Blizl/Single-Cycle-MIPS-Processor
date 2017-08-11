-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
-- Date        : Tue Apr 11 09:36:16 2017
-- Host        : WLM3417EBAB1C33 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.srcs/sources_1/ip/data_memory/data_memory_funcsim.vhdl
-- Design      : data_memory
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity data_memory_spram is
  port (
    spo : out STD_LOGIC_VECTOR ( 8 downto 0 );
    clk : in STD_LOGIC;
    d : in STD_LOGIC_VECTOR ( 8 downto 0 );
    we : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of data_memory_spram : entity is "spram";
end data_memory_spram;

architecture STRUCTURE of data_memory_spram is
  signal qspo_int : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of qspo_int : signal is "true";
  signal \^spo\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute KEEP : string;
  attribute KEEP of \qspo_int_reg[0]\ : label is "yes";
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of \qspo_int_reg[0]\ : label is "no";
  attribute KEEP of \qspo_int_reg[1]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[1]\ : label is "no";
  attribute KEEP of \qspo_int_reg[2]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[2]\ : label is "no";
  attribute KEEP of \qspo_int_reg[3]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[3]\ : label is "no";
  attribute KEEP of \qspo_int_reg[4]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[4]\ : label is "no";
  attribute KEEP of \qspo_int_reg[5]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[5]\ : label is "no";
  attribute KEEP of \qspo_int_reg[6]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[6]\ : label is "no";
  attribute KEEP of \qspo_int_reg[7]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[7]\ : label is "no";
  attribute KEEP of \qspo_int_reg[8]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[8]\ : label is "no";
begin
  spo(8 downto 0) <= \^spo\(8 downto 0);
\qspo_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(0),
      Q => qspo_int(0),
      R => '0'
    );
\qspo_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(1),
      Q => qspo_int(1),
      R => '0'
    );
\qspo_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(2),
      Q => qspo_int(2),
      R => '0'
    );
\qspo_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(3),
      Q => qspo_int(3),
      R => '0'
    );
\qspo_int_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(4),
      Q => qspo_int(4),
      R => '0'
    );
\qspo_int_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(5),
      Q => qspo_int(5),
      R => '0'
    );
\qspo_int_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(6),
      Q => qspo_int(6),
      R => '0'
    );
\qspo_int_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(7),
      Q => qspo_int(7),
      R => '0'
    );
\qspo_int_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(8),
      Q => qspo_int(8),
      R => '0'
    );
ram_reg_0_255_0_0: unisim.vcomponents.RAM256X1S
    generic map(
      INIT => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
        port map (
      A(7 downto 0) => a(7 downto 0),
      D => d(0),
      O => \^spo\(0),
      WCLK => clk,
      WE => we
    );
ram_reg_0_255_1_1: unisim.vcomponents.RAM256X1S
    generic map(
      INIT => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
        port map (
      A(7 downto 0) => a(7 downto 0),
      D => d(1),
      O => \^spo\(1),
      WCLK => clk,
      WE => we
    );
ram_reg_0_255_2_2: unisim.vcomponents.RAM256X1S
    generic map(
      INIT => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
        port map (
      A(7 downto 0) => a(7 downto 0),
      D => d(2),
      O => \^spo\(2),
      WCLK => clk,
      WE => we
    );
ram_reg_0_255_3_3: unisim.vcomponents.RAM256X1S
    generic map(
      INIT => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
        port map (
      A(7 downto 0) => a(7 downto 0),
      D => d(3),
      O => \^spo\(3),
      WCLK => clk,
      WE => we
    );
ram_reg_0_255_4_4: unisim.vcomponents.RAM256X1S
    generic map(
      INIT => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
        port map (
      A(7 downto 0) => a(7 downto 0),
      D => d(4),
      O => \^spo\(4),
      WCLK => clk,
      WE => we
    );
ram_reg_0_255_5_5: unisim.vcomponents.RAM256X1S
    generic map(
      INIT => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
        port map (
      A(7 downto 0) => a(7 downto 0),
      D => d(5),
      O => \^spo\(5),
      WCLK => clk,
      WE => we
    );
ram_reg_0_255_6_6: unisim.vcomponents.RAM256X1S
    generic map(
      INIT => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
        port map (
      A(7 downto 0) => a(7 downto 0),
      D => d(6),
      O => \^spo\(6),
      WCLK => clk,
      WE => we
    );
ram_reg_0_255_7_7: unisim.vcomponents.RAM256X1S
    generic map(
      INIT => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
        port map (
      A(7 downto 0) => a(7 downto 0),
      D => d(7),
      O => \^spo\(7),
      WCLK => clk,
      WE => we
    );
ram_reg_0_255_8_8: unisim.vcomponents.RAM256X1S
    generic map(
      INIT => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
        port map (
      A(7 downto 0) => a(7 downto 0),
      D => d(8),
      O => \^spo\(8),
      WCLK => clk,
      WE => we
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity data_memory_dist_mem_gen_v8_0_synth is
  port (
    spo : out STD_LOGIC_VECTOR ( 8 downto 0 );
    clk : in STD_LOGIC;
    d : in STD_LOGIC_VECTOR ( 8 downto 0 );
    we : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of data_memory_dist_mem_gen_v8_0_synth : entity is "dist_mem_gen_v8_0_synth";
end data_memory_dist_mem_gen_v8_0_synth;

architecture STRUCTURE of data_memory_dist_mem_gen_v8_0_synth is
begin
\gen_sp_ram.spram_inst\: entity work.data_memory_spram
     port map (
      a(7 downto 0) => a(7 downto 0),
      clk => clk,
      d(8 downto 0) => d(8 downto 0),
      spo(8 downto 0) => spo(8 downto 0),
      we => we
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity data_memory_dist_mem_gen_v8_0 is
  port (
    a : in STD_LOGIC_VECTOR ( 7 downto 0 );
    d : in STD_LOGIC_VECTOR ( 8 downto 0 );
    dpra : in STD_LOGIC_VECTOR ( 7 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    i_ce : in STD_LOGIC;
    qspo_ce : in STD_LOGIC;
    qdpo_ce : in STD_LOGIC;
    qdpo_clk : in STD_LOGIC;
    qspo_rst : in STD_LOGIC;
    qdpo_rst : in STD_LOGIC;
    qspo_srst : in STD_LOGIC;
    qdpo_srst : in STD_LOGIC;
    spo : out STD_LOGIC_VECTOR ( 8 downto 0 );
    dpo : out STD_LOGIC_VECTOR ( 8 downto 0 );
    qspo : out STD_LOGIC_VECTOR ( 8 downto 0 );
    qdpo : out STD_LOGIC_VECTOR ( 8 downto 0 )
  );
  attribute C_ADDR_WIDTH : integer;
  attribute C_ADDR_WIDTH of data_memory_dist_mem_gen_v8_0 : entity is 8;
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of data_memory_dist_mem_gen_v8_0 : entity is "0";
  attribute C_DEPTH : integer;
  attribute C_DEPTH of data_memory_dist_mem_gen_v8_0 : entity is 256;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of data_memory_dist_mem_gen_v8_0 : entity is "./";
  attribute C_FAMILY : string;
  attribute C_FAMILY of data_memory_dist_mem_gen_v8_0 : entity is "zynq";
  attribute C_HAS_CLK : integer;
  attribute C_HAS_CLK of data_memory_dist_mem_gen_v8_0 : entity is 1;
  attribute C_HAS_D : integer;
  attribute C_HAS_D of data_memory_dist_mem_gen_v8_0 : entity is 1;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_HAS_I_CE : integer;
  attribute C_HAS_I_CE of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_HAS_QSPO : integer;
  attribute C_HAS_QSPO of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_HAS_QSPO_CE : integer;
  attribute C_HAS_QSPO_CE of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_HAS_QSPO_RST : integer;
  attribute C_HAS_QSPO_RST of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_HAS_QSPO_SRST : integer;
  attribute C_HAS_QSPO_SRST of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_HAS_SPO : integer;
  attribute C_HAS_SPO of data_memory_dist_mem_gen_v8_0 : entity is 1;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of data_memory_dist_mem_gen_v8_0 : entity is 1;
  attribute C_MEM_INIT_FILE : string;
  attribute C_MEM_INIT_FILE of data_memory_dist_mem_gen_v8_0 : entity is "no_coe_file_loaded";
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of data_memory_dist_mem_gen_v8_0 : entity is 1;
  attribute C_PARSER_TYPE : integer;
  attribute C_PARSER_TYPE of data_memory_dist_mem_gen_v8_0 : entity is 1;
  attribute C_PIPELINE_STAGES : integer;
  attribute C_PIPELINE_STAGES of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_QCE_JOINED : integer;
  attribute C_QCE_JOINED of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_QUALIFY_WE : integer;
  attribute C_QUALIFY_WE of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_READ_MIF : integer;
  attribute C_READ_MIF of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_REG_A_D_INPUTS : integer;
  attribute C_REG_A_D_INPUTS of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of data_memory_dist_mem_gen_v8_0 : entity is 0;
  attribute C_SYNC_ENABLE : integer;
  attribute C_SYNC_ENABLE of data_memory_dist_mem_gen_v8_0 : entity is 1;
  attribute C_WIDTH : integer;
  attribute C_WIDTH of data_memory_dist_mem_gen_v8_0 : entity is 9;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of data_memory_dist_mem_gen_v8_0 : entity is "dist_mem_gen_v8_0";
end data_memory_dist_mem_gen_v8_0;

architecture STRUCTURE of data_memory_dist_mem_gen_v8_0 is
  signal \<const0>\ : STD_LOGIC;
begin
  dpo(8) <= \<const0>\;
  dpo(7) <= \<const0>\;
  dpo(6) <= \<const0>\;
  dpo(5) <= \<const0>\;
  dpo(4) <= \<const0>\;
  dpo(3) <= \<const0>\;
  dpo(2) <= \<const0>\;
  dpo(1) <= \<const0>\;
  dpo(0) <= \<const0>\;
  qdpo(8) <= \<const0>\;
  qdpo(7) <= \<const0>\;
  qdpo(6) <= \<const0>\;
  qdpo(5) <= \<const0>\;
  qdpo(4) <= \<const0>\;
  qdpo(3) <= \<const0>\;
  qdpo(2) <= \<const0>\;
  qdpo(1) <= \<const0>\;
  qdpo(0) <= \<const0>\;
  qspo(8) <= \<const0>\;
  qspo(7) <= \<const0>\;
  qspo(6) <= \<const0>\;
  qspo(5) <= \<const0>\;
  qspo(4) <= \<const0>\;
  qspo(3) <= \<const0>\;
  qspo(2) <= \<const0>\;
  qspo(1) <= \<const0>\;
  qspo(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\synth_options.dist_mem_inst\: entity work.data_memory_dist_mem_gen_v8_0_synth
     port map (
      a(7 downto 0) => a(7 downto 0),
      clk => clk,
      d(8 downto 0) => d(8 downto 0),
      spo(8 downto 0) => spo(8 downto 0),
      we => we
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity data_memory is
  port (
    a : in STD_LOGIC_VECTOR ( 7 downto 0 );
    d : in STD_LOGIC_VECTOR ( 8 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    spo : out STD_LOGIC_VECTOR ( 8 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of data_memory : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of data_memory : entity is "data_memory,dist_mem_gen_v8_0,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of data_memory : entity is "data_memory,dist_mem_gen_v8_0,{x_ipProduct=Vivado 2015.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=dist_mem_gen,x_ipVersion=8.0,x_ipCoreRevision=8,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_FAMILY=zynq,C_ADDR_WIDTH=8,C_DEFAULT_DATA=0,C_DEPTH=256,C_HAS_CLK=1,C_HAS_D=1,C_HAS_DPO=0,C_HAS_DPRA=0,C_HAS_I_CE=0,C_HAS_QDPO=0,C_HAS_QDPO_CE=0,C_HAS_QDPO_CLK=0,C_HAS_QDPO_RST=0,C_HAS_QDPO_SRST=0,C_HAS_QSPO=0,C_HAS_QSPO_CE=0,C_HAS_QSPO_RST=0,C_HAS_QSPO_SRST=0,C_HAS_SPO=1,C_HAS_WE=1,C_MEM_INIT_FILE=no_coe_file_loaded,C_ELABORATION_DIR=./,C_MEM_TYPE=1,C_PIPELINE_STAGES=0,C_QCE_JOINED=0,C_QUALIFY_WE=0,C_READ_MIF=0,C_REG_A_D_INPUTS=0,C_REG_DPRA_INPUT=0,C_SYNC_ENABLE=1,C_WIDTH=9,C_PARSER_TYPE=1}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of data_memory : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of data_memory : entity is "dist_mem_gen_v8_0,Vivado 2015.2";
end data_memory;

architecture STRUCTURE of data_memory is
  signal NLW_U0_dpo_UNCONNECTED : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal NLW_U0_qdpo_UNCONNECTED : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal NLW_U0_qspo_UNCONNECTED : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "zynq";
  attribute C_HAS_CLK : integer;
  attribute C_HAS_CLK of U0 : label is 1;
  attribute C_HAS_D : integer;
  attribute C_HAS_D of U0 : label is 1;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of U0 : label is 0;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of U0 : label is 0;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of U0 : label is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of U0 : label is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of U0 : label is 0;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of U0 : label is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of U0 : label is 0;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of U0 : label is 1;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of U0 : label is 1;
  attribute C_QCE_JOINED : integer;
  attribute C_QCE_JOINED of U0 : label is 0;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of U0 : label is 0;
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of U0 : label is std.standard.true;
  attribute c_addr_width : integer;
  attribute c_addr_width of U0 : label is 8;
  attribute c_default_data : string;
  attribute c_default_data of U0 : label is "0";
  attribute c_depth : integer;
  attribute c_depth of U0 : label is 256;
  attribute c_elaboration_dir : string;
  attribute c_elaboration_dir of U0 : label is "./";
  attribute c_has_i_ce : integer;
  attribute c_has_i_ce of U0 : label is 0;
  attribute c_has_qspo : integer;
  attribute c_has_qspo of U0 : label is 0;
  attribute c_has_qspo_ce : integer;
  attribute c_has_qspo_ce of U0 : label is 0;
  attribute c_has_qspo_rst : integer;
  attribute c_has_qspo_rst of U0 : label is 0;
  attribute c_has_qspo_srst : integer;
  attribute c_has_qspo_srst of U0 : label is 0;
  attribute c_has_spo : integer;
  attribute c_has_spo of U0 : label is 1;
  attribute c_mem_init_file : string;
  attribute c_mem_init_file of U0 : label is "no_coe_file_loaded";
  attribute c_parser_type : integer;
  attribute c_parser_type of U0 : label is 1;
  attribute c_pipeline_stages : integer;
  attribute c_pipeline_stages of U0 : label is 0;
  attribute c_qualify_we : integer;
  attribute c_qualify_we of U0 : label is 0;
  attribute c_read_mif : integer;
  attribute c_read_mif of U0 : label is 0;
  attribute c_reg_a_d_inputs : integer;
  attribute c_reg_a_d_inputs of U0 : label is 0;
  attribute c_sync_enable : integer;
  attribute c_sync_enable of U0 : label is 1;
  attribute c_width : integer;
  attribute c_width of U0 : label is 9;
begin
U0: entity work.data_memory_dist_mem_gen_v8_0
     port map (
      a(7 downto 0) => a(7 downto 0),
      clk => clk,
      d(8 downto 0) => d(8 downto 0),
      dpo(8 downto 0) => NLW_U0_dpo_UNCONNECTED(8 downto 0),
      dpra(7) => '0',
      dpra(6) => '0',
      dpra(5) => '0',
      dpra(4) => '0',
      dpra(3) => '0',
      dpra(2) => '0',
      dpra(1) => '0',
      dpra(0) => '0',
      i_ce => '1',
      qdpo(8 downto 0) => NLW_U0_qdpo_UNCONNECTED(8 downto 0),
      qdpo_ce => '1',
      qdpo_clk => '0',
      qdpo_rst => '0',
      qdpo_srst => '0',
      qspo(8 downto 0) => NLW_U0_qspo_UNCONNECTED(8 downto 0),
      qspo_ce => '1',
      qspo_rst => '0',
      qspo_srst => '0',
      spo(8 downto 0) => spo(8 downto 0),
      we => we
    );
end STRUCTURE;
