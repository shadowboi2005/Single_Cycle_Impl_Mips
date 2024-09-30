module InstructionMemory(
    input wire clk,
    input wire [31:0] PC,
    output wire [31:0] instruction
);

    reg [31:0] InstructionMem [65535:0];
    
    always @(posedge clk) begin
        assign instruction = InstructionMem[PC];
    end

endmodule
