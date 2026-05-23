`timescale 1ns/1ps

module tb_main;

// UUT Parameters
parameter WORD_WIDTH  = 8                      ; 
parameter DATA_WIDTH  = 8                      ;
parameter ADDR_WIDTH  = $clog2(DATA_WIDTH) + 1 ;   
parameter FLAG_WIDTH  = 1                      ;
// Local Parameters
parameter WRITE_COUNT = 30 ;
parameter  READ_COUNT = 15 ;

//------------------------------------------------------------------------------------------------  
//        SIGNALS
//------------------------------------------------------------------------------------------------

// Testbench Signals
reg                     reset      ;
reg                     ClkWrite   ;
wire                    HaltInput  ;
reg                     ControlIn  ;
reg  [DATA_WIDTH - 1:0] DataIn     ;
reg                     ClkRead    ;
wire                    HaltOutput ;
wire                    ReadValid  ;
reg                     ControlOut ;
wire [DATA_WIDTH - 1:0] DataOut    ;

// Internal Signals 
reg  [DATA_WIDTH - 1:0] memOut [0:WORD_WIDTH - 1]   ;
reg assigned = 0 ;
integer i=0;
integer j=0;
integer k=0;

//------------------------------------------------------------------------------------------------
//        COMPONENTS
//------------------------------------------------------------------------------------------------

// Instantiate the FIFO
FIFO #(WORD_WIDTH,DATA_WIDTH,FLAG_WIDTH) uut (
  .reset      (reset     ) ,
  .ClkWrite   (ClkWrite  ) ,
  .HaltInput  (HaltInput ) ,
  .ControlIn  (ControlIn ) ,
  .DataIn     (DataIn    ) ,
  .ClkRead    (ClkRead   ) ,
  .HaltOutput (HaltOutput) ,
  .ReadValid  (ReadValid ) ,
  .ControlOut (ControlOut) ,
  .DataOut    (DataOut   )  
);

//------------------------------------------------------------------------------------------------
//        GENERATION
//------------------------------------------------------------------------------------------------

// Clock Generation
initial begin
  ClkWrite = 0;
  forever #5 ClkWrite = ~ClkWrite ; // 100 MHz write clock
end
initial begin
  ClkRead = 0;
  forever #15 ClkRead = ~ClkRead ; // ~33 MHz read clock
end

//------------------------------------------------------------------------------------------------
//        TASKS
//------------------------------------------------------------------------------------------------
// ---------- TASK WRITE ---------- //
task write (input integer count) ;
  begin
    @ (posedge ClkWrite) ;
    for ( i=0 ; i < count ; i=i+1 ) begin
      if (HaltInput) begin  
        wait (!HaltInput)  ;
        write_operation(i) ;
      end
      else begin 
        write_operation(i) ;
      end
    end 
  end  
endtask

task write_operation (input reg [DATA_WIDTH - 1:0] data) ;
  begin
    DataIn  <= data      ;
    ControlIn <= 1       ;
    @ (posedge ClkWrite) ;
    ControlIn <= 0       ;
  end  
endtask

// ---------- TASKS READ ---------- //
task read (input integer count) ;
  begin
    j = 0 ;
    @ (posedge ClkRead) ;
    ControlOut = 1 ;
    while (j < count) begin
    read_control(memOut[k]) ;
    ControlOut = 1 ;
      if (assigned) begin
        j = j + 1 ;
        k = (k == 7) ? 0 : k + 1 ;
        assigned = 0 ;
        ControlOut = ((j + 2 > count) && (!HaltOutput)) ? 0 : 1 ;
      end
    end
    ControlOut = 0 ; 
  end
endtask

task read_control (output reg [DATA_WIDTH - 1:0] data) ;
  begin
    @ (posedge ClkRead) ;
    if (ReadValid) begin
      data = DataOut ;
      assigned = 1 ; 
    end
    else begin
      data = memOut[k] ;
    end
  end
endtask

// Test Sequence
initial begin
  i          = 0 ;
  j          = 0 ;
  k          = 0 ;
  reset      = 1 ;
  ControlIn  = 0 ;
  ControlOut = 0 ;
  #20 ;
  reset      = 0 ;

  fork 
    begin  
      write(WRITE_COUNT);
    end
    begin
      read(15) ;
      #100;
      read(15) ;
      #100;
    end
  join
  
  #300;
  $finish;
end

// Monitor output
initial begin
  $monitor("T=%0t | DataIn=%h | DataOut=%h | HaltInput=%b | ControlIn=%b",
            $time, DataIn, DataOut, HaltInput, ControlIn);
end

endmodule