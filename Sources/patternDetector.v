//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Trinity College Dublin
// Engineer: Patrick Farmer 20331828
// 
// Create Date: 24.03.2023 22:05:15
// Module Name: patternDetector.v
// 
//////////////////////////////////////////////////////////////////////////////////

module patternDetector (
    input wire[21:0] lfsr,
    input clk, reset,
    input loop,
    output reg [12:0] counter
);
    localparam pattern = 11'b11010101100;
    
    wire [10:0] boolCheck;
    assign boolCheck = (lfsr[21:11] ^~ pattern[10:0]);
    wire matches;
    //assign matches = boolCheck[0] & boolCheck[1] & boolCheck[2] & boolCheck[3] & boolCheck[4] & boolCheck[5] & boolCheck[6] & boolCheck[7] & boolCheck[8] & boolCheck[9] & boolCheck[10];
    reg tenLock, nineLock, eightLock, sevenLock, sixLock, fiveLock;
    reg fourLock, threeLock, twoLock, oneLock, zeroLock, setZeroNextClock;
    // Enter loop every positive edge of clock 
    always @(posedge clk) begin
        if(lfsr[21] ^~ pattern[10]) tenLock = 0; else tenLock = 1;
        if(lfsr[20] ^~ pattern[9] && tenLock == 0) nineLock = 0; else nineLock = 1;
        if(lfsr[19] ^~ pattern[8] && nineLock == 0) eightLock = 0; else eightLock = 1;
        if(lfsr[18] ^~ pattern[7] && eightLock == 0) sevenLock = 0; else sevenLock = 1;
        if(lfsr[17] ^~ pattern[6] && sevenLock == 0) sixLock = 0; else sixLock = 1;
        if(lfsr[16] ^~ pattern[5] && sixLock == 0) fiveLock = 0; else fiveLock = 1;
        if(lfsr[15] ^~ pattern[4] && fiveLock == 0) fourLock = 0; else fourLock = 1;
        if(lfsr[14] ^~ pattern[3] && fourLock == 0) threeLock = 0; else threeLock = 1;
        if(lfsr[13] ^~ pattern[2] && threeLock == 0) twoLock = 0; else twoLock = 1;
        if(lfsr[12] ^~ pattern[1] && twoLock == 0) oneLock = 0; else oneLock = 1;
        if(lfsr[11] ^~ pattern[0] && oneLock == 0) zeroLock = 0; else zeroLock = 1;
        if(zeroLock == 0) counter = counter + 1; else;
        // reset counter if either of these conditions are met
        if (reset == 1) counter = 0;
        else;
    end
    initial counter = 0; 

endmodule