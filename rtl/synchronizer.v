module sync#(
    parameter N = 8
)(
    input  Clk   ,
    input  reset ,

    input  wire[N-1:0] In  ,
    output wire[N-1:0] Out    
);

reg[N-1:0] sync_1;
reg[N-1:0] sync_2;

always @(posedge Clk) begin
    if (reset == 1) begin
        sync_1 <= 0;
        sync_2 <= 0;
    end else begin
        sync_1 <= In;
        sync_2 <= sync_1;
    end
end

assign Out = sync_2;

endmodule

// README : 
// this module is responsible for handling metastability issues that can arise when data changes 
// while another domain is reading it, specifically in different clock domains.
// Since in our design our write pointer reads the location of read pointer, and they both operate
// in different time domains, we need to stabilise the reading parameter, this is done using 2-3 
// D- Flip Flops, which read the data and stabilise the output before the write block receives the 
// read pointer's address. 