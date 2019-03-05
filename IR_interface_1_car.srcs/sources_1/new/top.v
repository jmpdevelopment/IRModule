`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: The University of Edinburgh
// Engineer: Juozas Pazera s1554371
// 
// Create Date: 25.02.2019 10:38:02
// Design Name: 
// Module Name: top
// Project Name: IR_interface
// Target Devices: Digilent Basys 3 Board
// Tool Versions: 
// Description: This module just combines CarParameterSelector module that outputs right parameters on car selected.
//              These parameters are then passed to IRTransmitterSM to generate right pulse sequence
//              SevenSegmentDisplay module is used to display which car is selected    
// 
// Dependencies: CarParameterSelector, IRTransmitterSM and SevenSegmentDisplay modules
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input CLK,
    input [3:0] Command,
    input [1:0] CarSelectIn,
    output [1:0] CarSelectOut,
    output IRLed,
    output [6:0] SegmentDisplayOut,
    output [3:0] SegmentDisplayAnodeActivate
    );
    
    wire [7:0] START_BURST_SIZE;
    wire [5:0] CAR_SELECT_BURST_SIZE;
    wire [5:0] GAP_SIZE;
    wire [5:0] ASSERT_BURST_SIZE;
    wire [4:0] DE_ASSERT_BURST_SIZE;
    wire FREQUENCY_TRIGGER;
    wire FREQUENCY_PULSE;
    wire GENERATED_PACKET;
    wire [1:0] SELECTED_CAR;
    wire [3:0] ACTIVE_ANODE;
    wire [6:0] SEGMENT_DISPLAY_OUT;
    
    CarParameterSelector # ()
        CarSelector (.CLK(CLK),
            .CarSelectIn(CarSelectIn),
            .StartBurstSize(START_BURST_SIZE),
            .CarSelectBurstSize(CAR_SELECT_BURST_SIZE),
            .GapSize(GAP_SIZE),
            .AssertBurstSize(ASSERT_BURST_SIZE),
            .DeAssertBurstSize(DE_ASSERT_BURST_SIZE),
            .FrequencyTrigger(FREQUENCY_TRIGGER),
            .FrequencyPulse(FREQUENCY_PULSE),
            .SelectedCar(SELECTED_CAR)
            );
            
    IRTransmitterSM # ()
        IRTransmitterSM (.CLK(CLK),
        .Command(Command),
        .StartBurstSize(START_BURST_SIZE),
        .CarSelectBurstSize(CAR_SELECT_BURST_SIZE),
        .GapSize(GAP_SIZE),
        .AssertBurstSize(ASSERT_BURST_SIZE),
        .DeAssertBurstSize(DE_ASSERT_BURST_SIZE),
        .FrequencyTrigger(FREQUENCY_TRIGGER),
        .FrequencyPulse(FREQUENCY_PULSE),
        .IRLed(GENERATED_PACKET)
        );
        
    SevenSegmentDisplay # ()
        SevenSegmentDisplay(.CLK(CLK),
        .CarSelect(SELECTED_CAR),
        .ActiveAnode(ACTIVE_ANODE),
        .SegmentDisplayOut(SEGMENT_DISPLAY_OUT)
        );
    
    assign IRLed = GENERATED_PACKET;
    assign SegmentDisplayAnodeActivate = ACTIVE_ANODE;
    assign SegmentDisplayOut = SEGMENT_DISPLAY_OUT;
    assign CarSelectOut = SELECTED_CAR;
    
endmodule
