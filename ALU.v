module ALU (
    input wire clk,
    input wire [3:0] ALUOp,
    input wire [31:0] inp1, inp2,
    output wire [31:0] ALUOut,
    output wire zero
);

    always @(posedge clk) begin
        case(ALUOp)
            4'b0000: ALUOut <= inp1 & inp2;
            4'b0001: ALUOut <= inp1 | inp2;
            4'b0010: ALUOut <= inp1 + inp2;
            4'b0011: ALUOut <= inp1 - inp2;
        endcase
        assign zero = (ALUOut == 0) ? 1'b1 : 1'b0;
    end
    
endmodule
