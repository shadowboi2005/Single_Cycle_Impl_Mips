module RegFile(
    input wire clk,
    input wire RegWr,
    input wire [31:0] WrRegData,
    input wire [4:0] Rs,
    input wire [4:0] Rt,
    input wire [4:0] Rd,
    output wire [31:0] Reg1Val,
    output wire [31:0] Reg2Val
);

    reg [31:0] RegData [31:0];

    assign Reg1Val = RegData[Rs];
    assign Reg2Val = RegData[Rt];
    always @(posedge clk) begin
        if (RegWr == 1'b1) begin
            assign RegData[Rd] = WrRegData;
        end
    end

endmodule
