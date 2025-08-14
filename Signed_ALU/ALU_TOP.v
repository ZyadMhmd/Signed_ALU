`timescale 1ns/1ps

module ALU_TOP_TB;

reg  signed [15:0] A;
reg  signed [15:0] B;
reg  [3:0]  ALU_FUN;
reg         clk;
reg         rst;

wire signed [15:0] Arith_Out;
wire               Arith_Flag;
wire signed [15:0] Logic_Out;
wire               Logic_Flag;
wire signed [15:0] CMP_Out;
wire               CMP_Flag;
wire signed [15:0] Shift_Out;
wire               Shift_Flag;

// Instantiate DUT
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

// Clock generation (200 MHz)
initial clk = 0;
always #2.5 clk = ~clk; // 5 ns period

// Expected result
reg signed [15:0] expected_result;

// Task to apply a test
task apply_test;
    input [15:0] a_in;
    input [15:0] b_in;
    input [3:0]  alu_fun_in;
    begin
        A = a_in;
        B = b_in;
        ALU_FUN = alu_fun_in;
        #10; // Wait for 2 clock cycles

        // Expected output calculation
        case (alu_fun_in)
            // Arithmetic (ALU_FUN[3:2] = 00)
            4'b0000: expected_result = a_in + b_in; // ADD
            4'b0001: expected_result = a_in - b_in; // SUB
            4'b0010: expected_result = a_in * b_in; // MUL
            4'b0011: expected_result = b_in != 0 ? a_in / b_in : 16'hXXXX; // DIV

            // Logic (ALU_FUN[3:2] = 01)
            4'b0100: expected_result = a_in & b_in; // AND
            4'b0101: expected_result = a_in | b_in; // OR
            4'b0110: expected_result = ~(a_in & b_in); // NAND
            4'b0111: expected_result = ~(a_in | b_in); // NOR

            // Compare (ALU_FUN[3:2] = 10)
            4'b1000: expected_result = (a_in == b_in); // EQ
            4'b1001: expected_result = (a_in > b_in);  // GT
            4'b1010: expected_result = (a_in < b_in);  // LT
            4'b1011: expected_result = (a_in != b_in); // NE

            // Shift (ALU_FUN[3:2] = 11)
            4'b1100: expected_result = a_in << 1; // Shift left
            4'b1101: expected_result = a_in >> 1; // Shift right
            4'b1110: expected_result = a_in <<< 1; // Arithmetic shift left
            4'b1111: expected_result = a_in >>> 1; // Arithmetic shift right

            default: expected_result = 16'hXXXX;
        endcase

        // Display results
        $display("Time=%0t | ALU_FUN=%b | A=%0d | B=%0d | Expected=%0d | Arith=%0d | Logic=%0d | CMP=%0d | Shift=%0d",
                 $time, alu_fun_in, a_in, b_in, expected_result,
                 Arith_Out, Logic_Out, CMP_Out, Shift_Out);
    end
endtask

// Test sequence
initial begin
    rst = 0; A = 0; B = 0; ALU_FUN = 0;
    #10 rst = 1;

    // Test all ALU_FUN cases with a few sample inputs
    apply_test(10, 5, 4'b0000);
    apply_test(10, 5, 4'b0001);
    apply_test(4,  3, 4'b0010);
    apply_test(15, 3, 4'b0011);

    apply_test(8,  3, 4'b0100);
    apply_test(8,  3, 4'b0101);
    apply_test(8,  3, 4'b0110);
    apply_test(8,  3, 4'b0111);

    apply_test(7,  7, 4'b1000);
    apply_test(10, 5, 4'b1001);
    apply_test(3,  7, 4'b1010);
    apply_test(3,  7, 4'b1011);

    apply_test(5,  0, 4'b1100);
    apply_test(8,  0, 4'b1101);
    apply_test(-4, 0, 4'b1110);
    apply_test(-8, 0, 4'b1111);

    $stop; // Stop simulation, don't finish
end

endmodule

