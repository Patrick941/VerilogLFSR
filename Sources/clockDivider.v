//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Trinity College Dublin
// Engineer: Patrick Farmer 20331828
// 
// Create Date: 24.03.2023 21:51:15
// Module Name: clockDivider.v
// 
////////////////////////////////////////////////////////////////////////////////////

module clockDivider(
    // Declare variables
    input wire clk,
    input wire [31:0] clkscale,
    output reg clk_out
    );
    
    // Counter count every clkscale clk cycle
    reg[31:0] counter = 0;
    
    always@(posedge clk) begin
        counter = counter + 1;
        // Only count every clkscale clk cycle
        if(counter >= clkscale) begin
            // Set output clock opposite of itself and reset counter
            clk_out=~clk_out;
            counter=0;
        end
    end
endmodule