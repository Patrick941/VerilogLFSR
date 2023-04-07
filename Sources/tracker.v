//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Trinity College Dublin
// Engineer: Patrick Farmer 20331828
// 
// Create Date: 24.03.2023 19:51:15
// Module Name: tracker.v
// 
//////////////////////////////////////////////////////////////////////////////////

module tracker (
    input wire val,
    input clk, reset,
    input loop,
    output integer counterOne, counterZero
);

    // Enter loop every positive edge of clock 
    always @(posedge clk) begin
        // Increment the correct counter
        if (val == 1'b1) counterOne = counterOne + 1;
        else counterZero = counterZero + 1;
        // reset counter if either of these conditions are met
        if (reset == 1 || loop == 1) begin counterOne = 0;counterZero = 0; end
    end
        
    initial begin counterOne = 0; counterZero = 0; end 

endmodule