//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Trinity College Dublin
// Engineer: Patrick Farmer 20331828
// 
// Create Date: 25.03.2023 11:51:15
// Module Name: lfsrTB
// 
//////////////////////////////////////////////////////////////////////////////////

module lfsr_tb;
    // Declare variables
    wire clk, reset;
    wire max_tick;
    wire lfsr_out;
    wire [21:0] lfsr_full_out;
    wire [31:0] counterOne, counterZero;
    wire [12:0] patternCounter;


    // Generate clocks
    clock20ns clock_unit (.clk(clk), .reset(reset));
    // Attach clocks and read output into lfsr_out
    lfsr lsft_unit(.clk(clk), .reset(reset), .lfsr_out(lfsr_out), .max_tick(max_tick), .lfsr_full_out(lfsr_full_out));
    // Put output into tracker module to count the number of 1s and 0s
    tracker tracker_unit(.clk(clk), .val(lfsr_out), .counterOne(counterOne), .counterZero(counterZero), .loop(max_tick), .reset(reset));
    // LFSR is checked by pattern detector
    patternDetector pattern_detector_unit(.clk(clk), .reset(reset), .loop(max_tick), .counter(patternCounter), .lfsr(lfsr_full_out));
endmodule