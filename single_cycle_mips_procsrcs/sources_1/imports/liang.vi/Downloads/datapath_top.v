`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Majid Sabbagh (sabbagh.m@husky.neu.edu)
// 
// Create Date: 08/17/2014 02:18:36 PM
// Design Name: 
// Module Name: eightbit_alu_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module datapath_top(
		input wire clk,
		input wire left_pb_rst_screen,
        input wire right_pb_rst_general,
        input wire top_pb_clk,
        input wire clk_sel,
        //output wire pb_clk_debounced,
        output wire sdin,
        output wire sclk,
        output wire dc,
        output wire res,
        output wire vbat,
        output wire vdd 
    );
    
    wire pb_clk_debounced, datapath_clk;
    
    wire [7:0] alu_1st_input, alu_2nd_input;
    wire [7:0] alu_output;
    wire [2:0] ALUOp;
    wire       alu_ovf_flag;
    wire       alu_take_branch_output;
    
    wire [15:0] instruction;
    //insturction fields
    wire [3:0] opcode;
    wire [1:0] rs_addr;
    wire [1:0] rt_addr;
    wire [1:0] rd_addr;
    wire [7:0] immediate;
    
    //control signals
    wire RegDst;
    wire RegWrite;
    wire ALUSrc1;
    wire ALUSrc2;
    wire MemWrite;
    wire MemToReg;

    wire [1:0] regfile_write_address;//destination register address
    wire [8:0] regfile_write_data;//result data
    wire [8:0] read_data1;//source register1 data
    wire [8:0] read_data2;//source register2 data

	wire [8:0] alu_result;
    wire [8:0] zero_register;
    wire [8:0] data_mem_out;       
    
    wire [7:0] pc; 
        
    debounce debounce_clk(
        .clk_in(clk),
        .rst_in(right_pb_rst_general),
        .sig_in(top_pb_clk),
        .sig_debounced_out(pb_clk_debounced)
    );    
    
   

    
        // ADD the PC Logic here
        pc_logic pc_counter (
            .clock(pb_clk_debounced),
            .rst(right_pb_rst_general),
            .immediate(immediate),
            .take_branch(alu_take_branch_output),
            .pc(pc)
        );
              
      
        instr_mem instruction_memory (
          .a(pc),      // input wire [7 : 0] a
          .spo(instruction)  // output wire [15 : 0] spo
        );
 
        inst_decoder instruction_decoder (
                .instruction(instruction),
                .opcode(opcode),
                .rs_addr(rs_addr),
                .rt_addr(rt_addr),
                .rd_addr(rd_addr),
                .immediate(immediate),
                .RegDst(RegDst),
                .RegWrite(RegWrite),
                .ALUSrc1(ALUSrc1),
                .ALUSrc2(ALUSrc2),
                .ALUOp(ALUOp),
                .MemWrite(MemWrite),
                .MemToReg(MemToReg)
                );
    
    //Select the right signal for the ALU's first input
    assign alu_1st_input = ALUSrc1 ? zero_register : read_data1;
    //Select the right signal for the ALU's second input
    assign alu_2nd_input = ALUSrc2 ? immediate : read_data2;
    
    assign zero_register = 8'b0;//ZERO constant          
          
    eightbit_alu alu (
        .a(alu_1st_input),
        .b(alu_2nd_input),
        .s(ALUOp),
        .f(alu_output),
        .ovf(alu_ovf_flag),
        .take_branch(alu_take_branch_output)
	);
	
    PmodOLEDCtrl PmodOLEDCtrl_inst (
        .CLK(clk),
        .RST(left_pb_rst_screen),
        .A(alu_1st_input),
        .B(alu_2nd_input),
        .S(ALUOp),
        .F(alu_output),
        .OVF(alu_ovf_flag),
        .SDIN(sdin),
        .SCLK(sclk),
        .DC(dc),
        .RES(res),
        .VBAT(vbat),   
        .VDD(vdd)
        );
	

		// ********************* ADD THE VIO HERE *************************** //

        vio_0 vio_0(
                   .clk(clk),
                   .probe_in0(alu_output),
                   .probe_in1(alu_ovf_flag),
                   .probe_in2(alu_take_branch_output),
                   .probe_in3(read_data1),
                   .probe_in4(read_data2),
                   .probe_in5(alu_1st_input),
                   .probe_in6(alu_2nd_input),
                   .probe_in7(regfile_write_data),
                   .probe_in8(data_mem_out),
                   .probe_in9(opcode),
                   .probe_in10(rs_addr),
                   .probe_in11(rt_addr),
                   .probe_in12(rd_addr),
                   .probe_in13(immediate),
                   .probe_in14(RegDst),
                   .probe_in15(RegWrite),
                   .probe_in16(ALUSrc1),
                   .probe_in17(ALUSrc2),
                   .probe_in18(ALUOp),
                   .probe_in19(MemWrite),
                   .probe_in20(MemToReg),
                   .probe_in21(pc),
                   .probe_in22(instruction));


	assign alu_result = {alu_ovf_flag, alu_output};
	
	//Select the right signal for the register file write data
    assign regfile_write_data = MemToReg ? data_mem_out : alu_result;
    
    //Select the right signal for the register file write address
    assign regfile_write_address = RegDst ? rd_addr : rt_addr;
           
	reg_file register_file (
        .rst(right_pb_rst_general),//reset
        .clk(pb_clk_debounced),//clock
        .wr_en(RegWrite),//Write enable
        .rd0_reg_num(rs_addr),//source register1 address
        .rd1_reg_num(rt_addr),//source register2 address
        .wr_reg_num(regfile_write_address),//destination register address
        .wr_data(regfile_write_data),//result data
        .rd0_data(read_data1),//source register1 data
        .rd1_data(read_data2)//source register2 data
    );
      
    data_memory calculator_data_memory (
        .a(alu_output),      // input wire [7 : 0] a
        .d(read_data2),      // input wire [8 : 0] d
        .clk(pb_clk_debounced),  // input wire clk
        .we(MemWrite),    // input wire we
        .spo(data_mem_out)  // output wire [8 : 0] spo
    );
    
    
endmodule