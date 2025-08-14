`timescale 1ns/1ps

module ALU_TB2;

reg signed [15:0] A;
reg signed [15:0] B;
reg [3:0] ALU_FUN;
reg clk;
reg rst;

wire signed [15:0] Arith_Out;
wire Arith_Flag;
wire signed [15:0] Logic_Out;
wire Logic_Flag;
wire signed [15:0] CMP_Out;
wire CMP_Flag;
wire signed [15:0] Shift_Out;
wire Shift_Flag;

ALU_TOP DUT (
    .A(A),
    .B(B),
    .ALU_FUN(ALU_FUN),
    .clk(clk),
    .rst(rst),
    .Arith_Out(Arith_Out),
    .Arith_Flag(Arith_Flag),
    .Logic_Out(Logic_Out),
    .Logic_Flag(Logic_Flag),
    .CMP_Out(CMP_Out),
    .CMP_Flag(CMP_Flag),
    .Shift_Out(Shift_Out),
    .Shift_Flag(Shift_Flag)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 0;
    #10 rst = 1;

    // 00xx ? Arithmetic operations
    // Case 0000: ADD
    A = -10; B = -5; ALU_FUN = 4'b0000;
    #10 $display("ADD: Expected=%0d, Got=%0d", A+B, Arith_Out);

    // Case 0001: SUB
    A = 10; B = 5; ALU_FUN = 4'b0001;
    #10 $display("SUB: Expected=%0d, Got=%0d", A-B, Arith_Out);

    // Case 0010: MUL
    A = 3; B = 4; ALU_FUN = 4'b0010;
    #10 $display("MUL: Expected=%0d, Got=%0d", A*B, Arith_Out);

    // Case 0011: DIV
    A = 20; B = 4; ALU_FUN = 4'b0011;
    #10 $display("DIV: Expected=%0d, Got=%0d", A/B, Arith_Out);

    // 01xx ? Logic operations
    // Case 0100: AND
    A = 6; B = 3; ALU_FUN = 4'b0100;
    #10 $display("AND: Expected=%0d, Got=%0d", (A & B), Logic_Out);

    // Case 0101: OR
    A = 6; B = 3; ALU_FUN = 4'b0101;
    #10 $display("OR: Expected=%0d, Got=%0d", (A | B), Logic_Out);

    // Case 0110: NAND
    A = 6; B = 3; ALU_FUN = 4'b0110;
    #10 $display("NAND: Expected=%0d, Got=%0d", ~(A & B), Logic_Out);

    // Case 0111: NOR
    A = 6; B = 3; ALU_FUN = 4'b0111;
    #10 $display("NOR: Expected=%0d, Got=%0d", ~(A | B), Logic_Out);

    // 10xx ? Compare operations
    // Case 1000: NO OPERATION
    A = 6; B = 6; ALU_FUN = 4'b1000;
    #10 $display("NO OPERATION Expected=%0d, Got=%0d", 2'b00, CMP_Out );

    // Case 1001: Equal
    A = 6; B = 6; ALU_FUN = 4'b1001;
    #10 $display("XNOR: Expected=%0d, Got=%0d", 2'b01, CMP_Out);

    // Case 1010: Greater than
    A = 5; B = 1; ALU_FUN = 4'b1010;
    #10 $display("EQ: Expected=%0d, Got=%0d",2'b10, CMP_Out);

    // Case 1011: less than
    A = 7; B = 11; ALU_FUN = 4'b1011;
    #10 $display("GT: Expected=%0d, Got=%0d", 2'b11, CMP_Out);

    // 11xx ? Shift operations
    // Case 1100: A Shift Left
    A = 4; B = 1; ALU_FUN = 4'b1100;
    #10 $display("SHL: Expected=%0d, Got=%0d", (A >>1), Shift_Out);

    // Case 1101: A Shift Right
    A = 8; B = 1; ALU_FUN = 4'b1101;
    #10 $display("SHR: Expected=%0d, Got=%0d", (A <<1), Shift_Out);

    // Case 1110: B Shift Left
    A = 16'h000F; B = 1; ALU_FUN = 4'b1110;
    #10 $display("SHR: Expected=%0d, Got=%0d", (B >>1), Shift_Out);
    // Case 1111: B Shift Right
    A = 16'h000F; B = 1; ALU_FUN = 4'b1111;
    #10 $display("SHR: Expected=%0d, Got=%0d", (B <<1), Shift_Out);

    $stop;
end

endmodule


