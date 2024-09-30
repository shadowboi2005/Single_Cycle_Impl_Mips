module branchAdder(
    input wire [31:0] PC,
    input wire [31:0] offset,
    output wire [31:0] PC4,
    output wire [31:0] branchTgt
);

    assign PC4 = PC + 4;
    assign branchTgt = PC4 + offset;

endmodule