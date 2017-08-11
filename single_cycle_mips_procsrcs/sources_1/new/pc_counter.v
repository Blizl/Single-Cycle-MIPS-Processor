`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2017 09:39:00 AM
// Design Name: 
// Module Name: pc_counter
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

module pc_logic(input clock,
             input rst,
             input [7:0] immediate,
             input take_branch,
             output reg [7:0]pc);

    always @(negedge clock, posedge rst)
    begin
        if(rst == 1)
            pc = 8'b0;
        else    
            begin
                if(take_branch == 1)
                    pc = pc + immediate;
                else
                    pc = pc + 1;
            end
            
    end
endmodule