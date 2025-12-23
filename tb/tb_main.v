`timescale 1ns/1ps

module tb_FIFO;

parameter WRITE_COUNT = 30 ;
  
  integer i=0;
  // Testbench signals
  reg reset;
  reg ClkWrite;
  reg ClkRead;
  reg ControlIn;
  reg ControlIn;
  reg [7:0] dataIn;
  wire haltInput;
  wire [7:0] dataOut;
  reg  [7:0] dataReg;
  // Instantiate the FIFO
  FIFO uut (
    .reset(reset),
    .ClkWrite(ClkWrite),
    .ClkRead(ClkRead),
    .ControlIn(ControlIn),
    .haltInput(haltInput),
    .dataIn(dataIn),
    .dataOut(dataOut) // your module's port is dataOu, not dataOut
  );

  // Clock generation
initial begin
  ClkWrite = 0;
  forever #5 ClkWrite = ~ClkWrite ; // 100 MHz write clock
end
initial begin
  ClkRead = 0;
  forever #7 ClkRead = ~ClkRead ; // ~71 MHz read clock
end

task write (input reg data [7:0]) ;
  begin
    @ (posedge ClkWrite);
    ControlIn <= 1    ;
    dataIn  <= data ;
    @ (posedge ClkWrite);
    ControlIn <= 0    ;
  end  
endtask

task read (output reg data [7:0]) ;
  begin
    
  end
endtask

// Test sequence
initial begin
  reset   = 1 ;
  ControlIn = 0 ;
  i       = 0 ;
  #20 ;
  reset   = 0 ;

//      @(posedge ClkWrite);
//      if (!haltInput) begin
//        dataIn <= 10000001; // random byte    //original input in
//        ControlIn <= 1;
//      end
//    end

for ( i=0 ; i < WRITE_COUNT ; i++ ) begin
  write(i) ;
end   

    // Send a few more bytes
    repeat (4) begin
      @(posedge ClkWrite);
      if (!haltInput) begin
        dataIn <= 01010101;
        ControlIn <= 1;
      end
    end
    @(posedge ClkWrite);
    ControlIn <= 0;

    // Let simulation run for more reads
  //  #200;
    $finish;
  end

  // Monitor output
  initial begin
    $monitor("T=%0t | dataIn=%h | dataOut=%h | haltInput=%b | ControlIn=%b",
              $time, dataIn, dataOut, haltInput, ControlIn);
  end

endmodule
