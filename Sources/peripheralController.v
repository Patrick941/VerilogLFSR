//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Trinity College Dublin
// Engineer: Patrick Farmer 20331828
// 
// Create Date: 24.03.2023 23:02:15
// Module Name: peripheralController.v
// 
//////////////////////////////////////////////////////////////////////////////////

module peripheralController (
    output wire [15:0] led,
    output wire [6:0] LED_out,
    output wire [3:0] anode_select,
    input wire [4:0] button_input,
    input wire clk, reset
);  

    // Declare variables    
    wire button_pressed, button_not_pressed;
    assign button_pressed = 1;
    assign button_not_pressed = 0;

    wire [21:0] lfsr_full_out;
    wire lfsr_out, max_tick;
    wire scaled_clock;
    wire [12:0] counter;

    integer clockScale;

    initial clockScale = 5000000;
    reg [31:0] testVal;

    // scale clock
    clockDivider clock_unit(.clk(clk), .clk_out(scaled_clock), .clkscale(clockScale));

    // test function, serves no purpose
    always @ (posedge scaled_clock) begin
        testVal = testVal + 1;
        if(max_tick == 1'b1 && button_input[4] == button_pressed) begin
            
        end
    end

    initial testVal = 0;

    // read lfsr
    lfsr lsft_unit(.clk(scaled_clock), .reset(reset), .lfsr_out(lfsr_out), .max_tick(max_tick), .lfsr_full_out(lfsr_full_out));

    // check if lfsr matches
    patternDetector patternDetector_unit(.clk(scaled_clock), .reset(reset), .lfsr(lfsr_full_out), .loop(max_tick), .counter(counter));

    // write counter onto seven seg
    seven_segment_controller seven_segment_controller_unit(.clk(clk), .reset(reset), .counter(counter), .anode_select(anode_select), .LED_out(LED_out));

    // write lfsr to leds
    assign led = lfsr_full_out[21: 6];
    //assign led = lfsr_full_out[15:0];
    //assign led = testVal[15:0];
    //assign led = 16'b1010101110101010;



    // Lock to ensure program doesnt iterate a number of times when pressed once
    reg lock;

    initial begin
        lock = 1'b0;
    end

    // Checking which button was pressed and perform appropriate action, also implement lock
    always @ (posedge clk) begin
        if(lock == 1'b0) begin
            if (button_input[0] == button_pressed || button_input[3] == button_pressed) clockScale = clockScale / 2;
            else if(button_input[1] == button_pressed || button_input[2] == button_pressed) clockScale = clockScale *2;
            else if (button_input[4] == button_pressed) clockScale = 5000000;
            else;
            lock = 1'b1;
        end
        else if (button_input == 5'b00000) lock = 1'b0;
        else ;
    end

endmodule

