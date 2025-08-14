module Shift_unit (
    input  signed [15:0] A,
    input  signed [15:0] B,
    input  wire   [1:0]  ALU_FUN,
    input  wire          clk,
    input  wire          rst,
    input  wire          Shift_enable,
    output reg signed [15:0] Shift_Out,
    output reg           Shift_Flag
);

always @(posedge clk or negedge rst) begin	
    if (!rst) begin
        Shift_Out  <= 16'sb0;
        Shift_Flag <= 1'b0;
    end
    else if (Shift_enable) begin
        case (ALU_FUN)
            2'b00: begin
                Shift_Out  <=A>>1;
                Shift_Flag <= 1'b1;
            end
            2'b01: begin
                Shift_Out  <= A<<1;
                Shift_Flag <= 1'b1;
            end
            2'b10: begin
                Shift_Out  <= B>>1;
                Shift_Flag <= 1'b1;
            end
            2'b11: begin
                Shift_Out  <= B<<1;
                Shift_Flag <= 1'b1;
            end
            default: begin
                Shift_Out  <= 16'sb0;
                Shift_Flag <= 1'b0;
            end
        endcase
    end
    else begin
        Shift_Flag <= 1'b0;
    end
end

endmodule
