module controlPath(
    input wire clk,
    input wire zero,
    input wire [31:0] instruction,
    input wire [31:0] PC4,
    input wire [31:0] branchTgt,
    input wire [31:0] MemOut,
    input wire [31:0] ALUOut,
    input wire [31:0] Reg2Val,
    output reg MemRd,
    output reg MemWr,
    output reg RegWr,
    output reg [3:0] ALUOp,
    output reg [31:0] ALUInput2,
    output reg [31:0] newPC,
    output reg [31:0] offset,
    output reg [31:0] WrRegData,
    output reg [4:0] Rs,
    output reg [4:0] Rt,
    output reg [4:0] WrReg,
    output reg [31:0] Addr,
    output reg [31:0] Data
);
    wire [4:0] Rd;
    assign Rd = instruction[15:11];
    wire [5:0] opcode;
    assign opcode = instruction[31:26];
    assign Rs = instruction[25:21];
    assign Rt = instruction[20:16];
    wire [5:0] funct; 
    assign funct = instruction[5:0];
    wire [15:0] immediate;
    assign immediate = instruction[15:0];
    wire signed [31:0] sign_ext_imm;
    assign sign_ext_imm = {{16{immediate[15]}}, immediate};

    always @(posedge clk) begin
        case(opcode)
            6'b000000: begin
                case(funct)
                    6'b100000: ALUOp <= 4'b0010;
                    6'b100010: ALUOp <= 4'b0011;
                    6'b100100: ALUOp <= 4'b0000;
                    6'b100101: ALUOp <= 4'b0001;
                    default: ALUOp <= 4'b0000;
                endcase
                ALUInput2 <= Reg2Val;
                WrReg <= Rd;
                RegWr <= 1'b1;
                MemRd <= 1'b0;
                MemWr <= 1'b0;
            end
            6'b001000: begin
                ALUOp <= 4'b0010;
                ALUInput2 <= sign_ext_imm;
                WrReg <= Rt;
                RegWr <= 1'b1;
                MemRd <= 1'b0;
                MemWr <= 1'b0;
            end
            6'b001100: begin
                ALUOp <= 4'b0000;
                ALUInput2 <= {16'b0, immediate};
                WrReg <= Rt;
                RegWr <= 1'b1;
                MemRd <= 1'b0;
                MemWr <= 1'b0;
            end
            6'b001101: begin
                ALUOp <= 4'b0001;
                ALUInput2 <= {16'b0, immediate};
                WrReg <= Rt;
                RegWr <= 1'b1;
                MemRd <= 1'b0;
                MemWr <= 1'b0;
            end
            6'b000100: begin
                ALUOp <= 4'b0011;
                ALUInput2 <= Reg2Val;
                if (zero) begin
                    newPC <= branchTgt;
                end else begin
                    newPC <= PC4;
                end
                RegWr <= 1'b0;
                MemRd <= 1'b0;
                MemWr <= 1'b0;
            end
            6'b000101: begin
                ALUOp <= 4'b0011;
                ALUInput2 <= Reg2Val;
                if (!zero) begin
                    newPC <= branchTgt;
                end else begin
                    newPC <= PC4;
                end
                RegWr <= 1'b0;
                MemRd <= 1'b0;
                MemWr <= 1'b0;
            end
            default: begin
                ALUOp <= 4'b0000;
                newPC <= PC4;
                RegWr <= 1'b0;
                MemRd <= 1'b0;
                MemWr <= 1'b0;
            end
        endcase
    end
endmodule