`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.01.2019 10:31:11
// Design Name: 
// Module Name: IRTransmitterSM_TB
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


module IR_interface_TB(

    );
    
    reg CLK;
    reg [3:0] COMMAND;
    reg [1:0] CAR_SELECT_IN;
    wire [1:0] CAR_SELECT_OUT;
    wire IR_LED;
    wire [2:0] CURR_STATE;
    
    wire FREQUENCY_TRIGGER;
    wire FREQUENCY_PULSE;
    wire [7:0] START_BURST_SIZE;
    wire [5:0] CAR_SELECT_BURST_SIZE;
    wire [5:0] GAP_SIZE;
    wire [5:0] ASSERT_BURST_SIZE;
    wire [4:0] DE_ASSERT_BURST_SIZE;
    
    top uut (
        .CLK(CLK),
        .Command(COMMAND),
        .CarSelectIn(CAR_SELECT_IN),
        .CarSelectOut(CAR_SELECT_OUT),
        .IRLed(IR_LED)
    );
    
//    CarParameterSelector uut(
//        .CLK(CLK),
//        .CarSelectIn(CAR_SELECT_IN),
//        .StartBurstSize(START_BURST_SIZE),
//        .CarSelectBurstSize(CAR_SELECT_BURST_SIZE),
//        .GapSize(GAP_SIZE),
//        .AssertBurstSize(ASSERT_BURST_SIZE),
//        .DeAssertBurstSize(DE_ASSERT_BURST_SIZE),
//        .FrequencyTrigger(FREQUENCY_TRIGGER),
//        .FrequencyPulse(FREQUENCY_PULSE)
//    );
    
//    IRTransmitterSM uut (
//        .CLK(CLK),
//        .Command(COMMAND),
//        .StartBurstSize(START_BURST_SIZE),
//        .CarSelectBurstSize(CAR_SELECT_BURST_SIZE),
//        .GapSize(GAP_SIZE),
//        .AssertBurstSize(ASSERT_BURST_SIZE),
//        .DeAssertBurstSize(DE_ASSERT_BURST_SIZE),
//        .FrequencyTrigger(FREQUENCY_TRIGGER),
//        .FrequencyPulse(FREQUENCY_PULSE)
//    );
      
    always begin
        CLK = 1; #5; CLK = 0; #5;
    end
    
    initial begin
        CAR_SELECT_IN = 2'b01;
        COMMAND = 4'b1000;
        #500000000
        COMMAND = 4'b1100;
    end
    
endmodule
