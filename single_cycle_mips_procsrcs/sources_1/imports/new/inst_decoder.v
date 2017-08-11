`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2017 09:22:49 AM
// Design Name: 
// Module Name: inst_decoder
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


module inst_decoder(
    input [15:0] instruction,
    output reg RegWrite,
    output reg RegDst,
    output reg [7:0] immediate,
    output reg ALUSrc1,
    output reg ALUSrc2,
    output reg [2:0] ALUOp,
    output reg MemWrite,
    output reg [3:0] opcode,
    output reg MemToReg,
    output reg [1:0] rs_addr,
    output reg [1:0] rt_addr,
    output reg [1:0] rd_addr
    );
    
    always @ instruction
    begin
        opcode = instruction[15:12];
        case(instruction[15:12])
            //lw
            0: begin 
            RegDst = 1'b0;
            RegWrite = 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b1;
            ALUOp = 3'b000;
            MemWrite = 1'b0;
            MemToReg = 1'b1;
            rs_addr = instruction[11:10]; 
            rt_addr = instruction[9:8];
            //rd_addr = instruction[7:6];
            immediate = instruction[7:0];
            end
            
            //sw
            1: begin
            RegDst=   1'b0;
            RegWrite= 1'b0;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b1;
            ALUOp = 3'b000;
            MemWrite = 1'b1;
            MemToReg = 1'b0;
            rs_addr = instruction[11:10]; 
            rt_addr = instruction[9:8];
            //rd_addr = instruction[7:6];
            immediate = instruction[7:0];
            end
            //add
            2: begin
            RegDst=   1'b1;
            RegWrite= 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b000;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
            rs_addr = instruction[11:10]; 
            rt_addr = instruction[9:8];
            rd_addr = instruction[7:6];
            end
            //addi
            3: begin
            RegDst=   1'b0;
            RegWrite= 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b1;
            ALUOp = 3'b000;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
            rs_addr = instruction[11:10]; 
            rt_addr = instruction[9:8];
            //rd_addr = instruction[7:6];
            immediate = instruction[7:0];
            end
            //inv
            4: begin
            RegDst=   1'b1;
            RegWrite= 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b001;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
            rs_addr = instruction[11:10]; 
            rt_addr = instruction[9:8];
            rd_addr = instruction[7:6];
            end
            //and
            5: begin
            RegDst=   1'b1;
            RegWrite= 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b010;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
            rs_addr = instruction[11:10]; 
            rt_addr = instruction[9:8];
            rd_addr = instruction[7:6];
            end         
            //andi
            6: begin
            RegDst=   1'b0;
            RegWrite= 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b1;
            ALUOp = 3'b010;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
            rs_addr = instruction[11:10]; 
            rt_addr = instruction[9:8];
            //rd_addr = instruction[7:6];
            immediate = instruction[7:0];
            end
            //or
            7: begin
            RegDst= 1'b1;
            RegWrite= 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b011;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
            rs_addr = instruction[11:10]; 
            rt_addr = instruction[9:8];
            rd_addr = instruction[7:6];
           end             
            //ori
            8: begin
            RegDst=   1'b0;
            RegWrite= 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b1;
            ALUOp = 3'b011;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
            rs_addr = instruction[11:10]; 
            rt_addr = instruction[9:8];
            //rd_addr = instruction[7:6];
            immediate = instruction[7:0];
            end
            //sra
            9: begin
            RegDst=   1'b0;
            RegWrite= 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b100;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
            rs_addr = instruction[11:10]; 
            rt_addr = instruction[9:8];
            //rd_addr = instruction[7:6];
            immediate = instruction[7:0];
            end
            //sll
            10: begin
            RegDst=   1'b0;
            RegWrite= 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b101;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
            rs_addr = instruction[11:10]; 
            rt_addr = instruction[9:8];
            //rd_addr = instruction[7:6];
            immediate = instruction[7:0];
            end
            //beq
            11: begin
            RegDst=   1'b0;
            RegWrite= 1'b0;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b110;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
            rs_addr = instruction[11:10]; 
            rt_addr = instruction[9:8];
            //rd_addr = instruction[7:6];
            immediate = instruction[7:0];
            end            
            //bne
            12: begin
            RegDst=   1'b0;
            RegWrite= 1'b0;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b111;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
            rs_addr = instruction[11:10]; 
            rt_addr = instruction[9:8];
            //rd_addr = instruction[7:6];
            immediate = instruction[7:0];            
            end
            //clr
            13: begin
            RegDst=   1'b1;
            RegWrite= 1'b1;
            ALUSrc1 = 1'b1;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b010;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
            rs_addr = instruction[11:10]; 
            rt_addr = instruction[9:8];
            rd_addr = instruction[7:6];
            end           
        endcase
    end
    
endmodule
