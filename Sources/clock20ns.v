//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Trinity College Dublin
// Engineer: Patrick Farmer 20331828
// 
// Create Date: 24.03.2023 9:51:15
// Module Name: dtypeReset
// 
//////////////////////////////////////////////////////////////////////////////////


module clock20ns (
  output reg reset,
  output reg clk,
  output integer count
);

    // Only create clock for 3000 periods, could be changed to forever block if needed
    initial begin
        count = 0;
        clk = 0;
        //reset = 0;
        forever begin
            if (count == -1) begin
                reset = 1;
                clk = 0;
                count = 0;
                #10;
                reset = 0;
            end else begin
                clk = ~clk;
                count = count + 1;
                #10;
            end;
        end
    end

    // Create reset pattern to demonstrate reset functionality
    initial
    begin
        reset = 1'b1;
        #200;
        reset = 1'b0;
        #200;
        reset = 1'b1;
        #20;
        reset = 1'b0;
    end
endmodule
