module Decoder(
    input  wire [1:0] ALU_FUN,
    output reg        Logic_enable,
    output reg        Arithmetic_enable,
    output reg        CMP_enable,
    output reg        Shift_enable
);

always @(*) begin
    // Default all enables to 0
    Arithmetic_enable = 1'b0;
    Logic_enable      = 1'b0;
    CMP_enable        = 1'b0;
    Shift_enable      = 1'b0;

    case (ALU_FUN)
        2'b00: Arithmetic_enable = 1'b1;
        2'b01: Logic_enable      = 1'b1;
        2'b10: CMP_enable        = 1'b1;
        2'b11: Shift_enable      = 1'b1;
    endcase
end

endmodule

