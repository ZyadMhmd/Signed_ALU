module Arithmetic_unit (
    input  signed [15:0] A,
    input  signed [15:0] B,
    input  wire   [1:0]  ALU_FUN,
    input  wire          clk,
    input  wire          rst,
    input  wire          Arithmetic_enable,
    output reg signed [15:0] Arith_Out,
    output reg           Arith_Flag
);

always @(posedge clk or negedge rst) begin	
    if (!rst) begin
        Arith_Out  <= 16'sb0;
        Arith_Flag <= 1'b0;
    end
    else if (Arithmetic_enable) begin
        case (ALU_FUN)
            2'b00: begin
                Arith_Out  <= A + B;
                Arith_Flag <= 1'b1;
            end
            2'b01: begin
                Arith_Out  <= A - B;
                Arith_Flag <= 1'b1;
            end
            2'b10: begin
                Arith_Out  <= A * B;
                Arith_Flag <= 1'b1;
            end
            2'b11: begin
                Arith_Out  <= (B != 0) ? (A / B) : 16'sh7FFF; 
                Arith_Flag <= 1'b1;
            end
            default: begin
                Arith_Out  <= 16'sb0;
                Arith_Flag <= 1'b0;
            end
        endcase
    end
    else begin
        Arith_Flag <= 1'b0;
    end
end

endmodule

