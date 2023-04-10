//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Trinity College Dublin
// Engineer: Patrick Farmer 20331828
// 
// Create Date: 24.03.2023 21:51:22
// Module Name: lfsr.v
// 
//////////////////////////////////////////////////////////////////////////////////

module lfsr (
    // declare variables
    input wire clk, reset,
    output wire lfsr_out,
    output reg max_tick,
    output reg [21:0] lfsr_full_out
    );
    localparam seed = 22'b1101100011110101111111;
    // Forbidden seed:
    // localparam seed = 22'b1111111111111111111111; 
    reg [21:0] tempVector;
    reg [21:0] outputVector;
    reg tempVal;

    // tracker cycle count
    integer loopTracker;

    initial 
    begin
        outputVector = seed; 
        tempVector = seed; 
        max_tick = 1'b0;
        loopTracker = 0;
    end

    // read output 
    assign lfsr_out = lfsr_full_out[21];


    always @(posedge clk or posedge reset) begin      
        if(max_tick == 1'b0) begin  
            // Iterate lfsr once and if loopTracker exceeds a certain amount reset max_tick
            tempVector = outputVector;
            loopTracker <= loopTracker + 1;
            // At max tick set max tick high
            if (loopTracker >= 4194303) begin
                max_tick <= 1'b1;
                loopTracker <= 0;
            end
            // do nothing for testing
            else begin
                //max_tick <= 1'b0;
            end
                
            // Get temp val from the lfsr taps and attach that to the MSB of outputVector
            tempVal = tempVector[20] ^ tempVector[21]; // Use blocking assignment here
            outputVector <= {tempVector[20:0], tempVal}; 
            lfsr_full_out <= outputVector;
        end else if (reset == 1) begin
            // Doesn't work correctly
            tempVector = seed;
            outputVector = seed;
        end else begin
            tempVector = seed;
            outputVector = seed;
        end
    end  
endmodule


