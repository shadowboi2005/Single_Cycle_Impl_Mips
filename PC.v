module ProgramCounter(
    input wire clk,
    input wire [31:0] newPC,
    output wire [31:0] currPC
);

    reg [31:0] PC;

    always @(posedge clk) begin
        PC <= newPC;
    end

    assign currPC = PC;

endmodule
