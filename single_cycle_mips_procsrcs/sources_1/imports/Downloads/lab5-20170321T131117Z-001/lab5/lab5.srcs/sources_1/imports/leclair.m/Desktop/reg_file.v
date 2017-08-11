module reg_file (input clk,
                    input rst,
                    input wr_en,
                    input [1:0] rd0_reg_num,
                    input [1:0] rd1_reg_num,
                    input [1:0] wr_reg_num,
                    input [8:0] wr_data,
                    output [8:0] rd0_data,
                    output [8:0] rd1_data);

        reg[8:0] mem[3:0]; //wordsize 9, 4 wordsize
        integer i;
        always @ (posedge rst, posedge clk)
          begin
            if(rst)
              begin
                for(i = 0; i < 4; i=i+1)
                  begin
                    mem[i] = 0;
                  end
              end
            else if (wr_en)
              begin
                mem[wr_reg_num] = wr_data;
              end
          end
        assign rd0_data = mem[rd0_reg_num];
        assign rd1_data = mem[rd1_reg_num];
  endmodule
