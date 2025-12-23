module FIFO(
  input  wire      reset,               // Reset

  input  wire      ClkWrite,            // Clock Write Domain
  input  wire      ClkRead,             // Clock Read Domain
  
  input  wire      Control,             // High when data flows in, else no
  output wire      haltInput,           // Halt flow of input

  input  wire[7:0] dataIn,              // Data input stream
  output wire[7:0] dataOut              // Data output stream
);

//------------------------------------------------------------------------------------------------
//        INTERNAL SIGNALS
//------------------------------------------------------------------------------------------------

reg[7:0] mem[7:0];			                // Main Memory

// Write - signals and registers
reg[7:0] dataInReg    = 8'b0;		   	    //Write - INPUT REGISTER - stores value temporarily to put inside memory
reg  haltInputDrive    = 0;             //Write - drive haltInput, Flag input wire from sending data

// Read  - signals and registers
reg[7:0] dataOutReg   = 8'b0;			      //Read  - OUTPUT REGISTER - stores value temporarily to take outside memory

// FLAGS
reg  doReadDataWrite   = 0;	  			    //Write - used to tell Reader to read (used to sync with ReadClk and output as doReadData)
reg  doReadDataRead    = 0;	  			    //Write - used to tell Reader to read (used to sync with ReadClk and output as doReadData)
wire syncReadDataWrite 	 ;     			    //Read  - used to check if data needs to be read
wire syncReadDataRead    ; 	  			    //Read  - used to check if data needs to be read

// POINTERS
reg [3:0] ptrWriteBin    ;              //pointer pointing to address of Write in binary
reg [3:0] ptrReadBin     ;              //pointer pointing to address of Read  in binary
wire[3:0] ptrWriteGray   ;              //pointer pointing to address of Write in Gray
wire[3:0] ptrReadGray    ;              //pointer pointing to address of Read  in Gray

wire[3:0] syncWriteGray  ;              //synched pointer pointing to address of Write in Gray
wire[3:0] syncReadGray   ;              //synched pointer pointing to address of Read  in Gray
wire[3:0] syncWriteBin   ;              //synched pointer pointing to address of Write in binary
wire[3:0] syncReadBin    ;              //synched pointer pointing to address of Read  in binary

//------------------------------------------------------------------------------------------------
//        COMPONENTS
//------------------------------------------------------------------------------------------------

binaryToGray pWB2G (                    // pWB2G = pointer Write Binary to Gray (Conversion)
  .binNum(ptrWriteBin),
  .grayNum(ptrWriteGray)
);
binaryToGray pRB2G (                    // pRB2G = pointer Read Binary to Gray (Conversion)
  .binNum(ptrReadBin),
  .grayNum(ptrReadGray)
);

sync WriteSync (                        // syncs the write pointer before sending to read domain 
  .In(ptrWriteGray),
  .Out(syncWriteGray),
  .Clk(ClkRead),
  .reset(reset)
);
sync ReadSync (                         // syncs the read pointer before sending to write domain 
  .In(ptrReadGray),
  .Out(syncReadGray),
  .Clk(ClkWrite),
  .reset(reset)
);

grayToBinary pWG2B (                    // pWG2B = pointer Write Gray to Binary (Conversion)
  .grayNum(syncWriteGray),              //  - stable write pointer address for Read Domain
  .binNum(syncWriteBin)
);            
grayToBinary pRG2B (                    // pWG2B = pointer Read Gray to Binary (Conversion)
  .grayNum(syncReadGray),               //  - stable read pointer address for Write Domain
  .binNum(syncReadBin)
);

sync #(4) doReadDataWriteSync (
  .In(doReadDataWrite),
  .Out(syncReadDataRead),
  .Clk(ClkRead),
  .reset(reset)
);
sync #(4) doReadDataReadSync (
  .In(doReadDataRead),
  .Out(syncReadDataWrite),
  .Clk(ClkWrite),
  .reset(reset)
);

// ---------------------- LOGIC --------------------------------------------------------------------

always @(posedge ClkWrite) begin : Block_DataInToReg
  if (reset == 1) begin
    ptrWriteBin     <= 4'b0;   
    haltInputDrive  <= 0   ;       
    dataInReg       <= 8'b0;   
    doReadDataWrite <= 0   ;

  end else if (Control == 1) begin
    if (!(syncWriteBin != syncReadBin && syncWriteBin[2:0] == syncReadBin[2:0])) begin    //do not proceed if loop is not same and pointer addresses is same (ensure it doesnt write on unread data)
      dataInReg <= dataIn;			                        	                                //value assigned to internal resistor of FIFO - to be used to assign at location later
      mem[ptrWriteBin[2:0]] <= dataInReg;                                                 //value assigned directly inside memory - (only because of assumed SPI it is here)
      ptrWriteBin <= ptrWriteBin + 1;
      doReadDataWrite <= 1;                                                               //tell reader, there is data to read
      haltInputDrive <= 0;                                                                //tell controller to send in data (###understand how this works, does it send data)
    end else begin
      haltInputDrive <= 1;                                                                //tell controller to send in data
    end
  end else begin
    if (syncReadDataWrite == 0) begin
      doReadDataWrite <= 0;
    end
  end
end

always @(posedge ClkRead) begin : Block_DataMemToOut
  if (reset == 1) begin
    doReadDataRead <= 0;       ptrReadBin   <= 4'b0;
    dataOutReg   <= 8'b0;    

  end else if (syncReadDataRead == 1) begin
    dataOutReg <= mem[ptrReadBin[2:0]];
    ptrReadBin <= ptrReadBin + 1;
    doReadDataRead <= 1;
    if (syncWriteBin == syncReadBin) begin
      doReadDataRead <= 0;
    end
  end
end
    
assign dataOut = dataOutReg;
assign haltInput = haltInputDrive;

endmodule
