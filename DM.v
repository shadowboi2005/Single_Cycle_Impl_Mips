module DataMemory(
    input wire clk,
    input wire MemRd,
    input wire MemWr,
    input wire [31:0] Addr,
    input wire [31:0] Data,
    output wire [31:0] MemOut,
);

    reg [31:0] DataMem [65535:0]

    always @(posedge clk) begin
        if (MemRd == 1'b1) begin
            MemOut <= DataMem[Addr];
        end
    end

    always @(negedge clk) begin
        if (MemWr == 1'b1) begin
            DataMem[Addr] <= Data;
        end
    end

endmodule
