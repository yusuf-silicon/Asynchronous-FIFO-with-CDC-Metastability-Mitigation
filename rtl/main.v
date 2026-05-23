`timescale 1ns/1ps

module FIFO #(
  parameter WORD_WIDTH = 8                      , 
  parameter DATA_WIDTH = 8                      ,
  parameter FLAG_WIDTH = 1			,
  parameter ADDR_WIDTH = $clog2(DATA_WIDTH) + 1     // MSB - loop ; Remaining address value
)(
  input  wire                    reset      ,       // Reset high

  input  wire                    ClkWrite   ,       // Clock Write Domain
  output wire                    HaltInput  ,       // signal write - dont send in data 
  input  wire                    ControlIn  ,       // High when data flows in, else no
  input  wire [DATA_WIDTH - 1:0] DataIn     ,       // Data input stream
  
  input  wire                    ClkRead    ,       // Clock Read Domain
  output wire                    HaltOutput ,       // signal write - dont send in data 
  output wire                    ReadValid  ,       // valid data or not
  input  wire                    ControlOut ,       // High when data flows in, else no
  output wire [DATA_WIDTH - 1:0] DataOut            // Data output stream
);

//------------------------------------------------------------------------------------------------
//        INTERNAL SIGNALS
//------------------------------------------------------------------------------------------------

//memory
reg [DATA_WIDTH - 1:0] mem [0 : WORD_WIDTH - 1];

// Write Domain
reg [ADDR_WIDTH - 1:0] ptrWriteBin     ;            //pointer pointing to address of Write in binary
reg [ADDR_WIDTH - 1:0] ptrReadBin      ;            //pointer pointing to address of Read  in binary
reg [DATA_WIDTH - 1:0] DataInReg       ; 		   	    //Write - INPUT REGISTER - stores value temporarily to put inside memory
reg                    haltInputDrive  ;            //Write - drive HaltInput, Flag input wire from sending data

// Read  Domain
reg [DATA_WIDTH - 1:0] dataOutReg      ;	          //Read - OUTPUT REGISTER - stores value temporarily to take outside memory
reg                    readValid       ;	          //Read - OUTPUT REGISTER - stores value temporarily to take outside memory
reg                    haltOutputDrive ;            //Read - drive HaltOutput, Flag output wire from receiving data

//------------------------------------------------------------------------------------------------
//        COMPONENTS
//------------------------------------------------------------------------------------------------

// ============ READ POINTER SYNC ============ 
// output wires
wire [ADDR_WIDTH - 1:0] ptrReadGray  ;               //pointer pointing to address of Read  in Gray
wire [ADDR_WIDTH - 1:0] syncReadGray ;               //synched pointer pointing to address of Read  in Gray
wire [ADDR_WIDTH - 1:0] syncReadBin  ;               //synched pointer pointing to address of Read  in binary
//sub-components 
binaryToGray pRB2G (                                // pRB2G = pointer Read Binary to Gray (Conversion)
  .binNum  (ptrReadBin  ),
  .grayNum (ptrReadGray ) 
);
sync #(ADDR_WIDTH) ReadSync (                       // syncs the read pointer before sending to write domain 
  .In      (ptrReadGray ),
  .Out     (syncReadGray),
  .Clk     (ClkWrite    )
);
grayToBinary pRG2B (                                // pWG2B = pointer Read Gray to Binary (Conversion)
  .grayNum (syncReadGray),                          //  - stable read pointer address for Write Domain
  .binNum  (syncReadBin )
);

// ============ WRITE POINTER SYNC ============ 
// output wires
wire [ADDR_WIDTH - 1:0] ptrWriteGray  ;              //pointer pointing to address of Write in Gray
wire [ADDR_WIDTH - 1:0] syncWriteGray ;              //synched pointer pointing to address of Write in Gray
wire [ADDR_WIDTH - 1:0] syncWriteBin  ;              //synched pointer pointing to address of Write in binary
//sub-components 
binaryToGray pWB2G (                                // pWB2G = pointer Write Binary to Gray (Conversion)
  .binNum  (ptrWriteBin  ),
  .grayNum (ptrWriteGray )
);
sync #(ADDR_WIDTH) WriteSync (                      // syncs the write pointer before sending to read domain 
  .In      (ptrWriteGray ),
  .Out     (syncWriteGray),
  .Clk     (ClkRead      )
);
grayToBinary pWG2B (                                // pWG2B = pointer Write Gray to Binary (Conversion)
  .grayNum (syncWriteGray),                         //  - stable write pointer address for Read Domain
  .binNum  (syncWriteBin )
);            

//------------------------------------------------------------------------------------------------
//        LOGIC
//------------------------------------------------------------------------------------------------
always @(posedge ClkWrite or posedge reset) begin
  if (reset == 1) begin
    ptrWriteBin    <= 0 ;   
    haltInputDrive <= 1 ;       
    DataInReg      <= 0 ;   

  end else begin
    haltInputDrive <= 1 ;
    if (!(ptrWriteBin != syncReadBin && ptrWriteBin[ADDR_WIDTH-2 : 0] == syncReadBin[ADDR_WIDTH-2 : 0])) begin
      if (ControlIn == 1) begin
        DataInReg <= DataIn;			                        	                              
        mem[ptrWriteBin[ADDR_WIDTH-2 : 0]] <= DataIn;                                                 
        ptrWriteBin <= ptrWriteBin + 1;
      end 
      if (((ptrWriteBin[ADDR_WIDTH-2 : 0] + 2) != syncReadBin[ADDR_WIDTH-2 : 0]) && ((ptrWriteBin[ADDR_WIDTH-2 : 0] + 1) != syncReadBin[ADDR_WIDTH-2 : 0])) begin
        haltInputDrive <= 0;                                                             
      end
    end
  end 
end

always @(posedge ClkRead or posedge reset) begin 
  if (reset == 1) begin
    ptrReadBin <= 0 ;
    readValid  <= 0 ;
  end
  else begin
      readValid <= 0 ;
    if (ControlOut && !haltOutputDrive) begin
      dataOutReg <= mem[ptrReadBin[ADDR_WIDTH-2 : 0]];
      ptrReadBin <= ptrReadBin + 1 ;
      readValid  <= 1 ;
    end
  end 
end
assign haltOutputDrive = (ptrReadBin == syncWriteBin) ;

//------------------------------------------------------------------------------------------------
//        OUTPUT
//------------------------------------------------------------------------------------------------

assign HaltOutput = haltOutputDrive ;
assign ReadValid  = readValid       ;
assign HaltInput  = haltInputDrive  ;
assign DataOut    = dataOutReg      ;

endmodule