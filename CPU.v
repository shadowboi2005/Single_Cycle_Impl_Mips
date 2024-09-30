module CPU();

    wire [31:0] PC, PC4, branchTgt;
    wire [31:0] instruction;
    wire [31:0] ALUOut, MemOut;
    wire [31:0] Reg1Val, Reg2Val;
    wire [31:0] ALUInput2, WrRegData;
    wire [4:0] Rs, Rt, WrReg;
    wire [3:0] ALUOp;
    wire MemRd, MemWr, RegWr, zero, clk;
    wire [31:0] offset;

    ProgramCounter pc_inst (
        .clk(clk),
        .newPC(PC4),
        .currPC(PC)
    );

    InstructionMemory im_inst (
        .clk(clk),
        .PC(PC),
        .instruction(instruction)
    );

    controlPath cp_inst (
        .clk(clk),
        .instruction(instruction),
        .PC4(PC4),
        .branchTgt(branchTgt),
        .MemOut(MemOut),
        .ALUOut(ALUOut),
        .Reg2Val(Reg2Val),
        .MemRd(MemRd),
        .MemWr(MemWr),
        .RegWr(RegWr),
        .ALUOp(ALUOp),
        .ALUInput2(ALUInput2),
        .newPC(PC4),
        .offset(offset),
        .WrRegData(WrRegData),
        .Rs(Rs),
        .Rt(Rt),
        .WrReg(WrReg)
    );

    DataMemory dm_inst (
        .clk(clk),
        .MemRd(MemRd),
        .MemWr(MemWr),
        .Addr(ALUOut),
        .Data(Reg2Val),
        .MemOut(MemOut)
    );

    RegFile rf_inst (
        .clk(clk),
        .RegWr(RegWr),
        .WrRegData(ALUOut),
        .Rs(Rs),
        .Rt(Rt),
        .WrReg(WrReg),
        .Reg1Val(Reg1Val),
        .Reg2Val(Reg2Val)
    );

    ALU alu_inst (
        .clk(clk),
        .ALUOp(ALUOp),
        .Reg1Val(Reg1Val),
        .ALUInput2(ALUInput2),
        .ALUOut(ALUOut),
        .zero(zero)
    );

    branchAdder ba_inst (
        .PC(PC),
        .offset(offset),
        .PC4(PC4),
        .branchTgt(branchTgt)
    );

    always begin
        #5 clk = ~clk;
    end

endmodule
