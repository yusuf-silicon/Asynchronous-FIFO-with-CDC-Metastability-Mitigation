module grayToBinary#(
    parameter N = 4
)(
    input wire[N-1:0]  grayNum,
    output wire[N-1:0] binNum    
);

reg[N-1:0] binNumReg;
integer i;

always @* begin
    binNumReg[N-1] = grayNum[N-1];
    for ( i=(N-2) ; i>=0 ; i=i-1) begin
        binNumReg[i] = binNumReg[i+1] ^ grayNum[i];
    end
end

assign binNum = binNumReg;

endmodule