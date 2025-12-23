module binaryToGray#(
    parameter N = 4
)(
    input wire[N-1:0]  binNum,
    output wire[N-1:0] grayNum    
);

assign grayNum = binNum ^ (binNum >> 1);

endmodule