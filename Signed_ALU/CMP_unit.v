module CMP_unit (
    input  signed [15:0] A,
    input  signed [15:0] B,
    input  wire   [1:0]  ALU_FUN,
    input  wire          clk,
    input  wire          rst,
    input  wire          CMP_enable,
    output reg signed [15:0] CMP_Out,
    output reg           CMP_Flag
);

always @(posedge clk or negedge rst) begin	
    if (!rst) begin
        CMP_Out  <= 16'sb0;
        CMP_Flag <= 1'b0;
    end
    else if (CMP_enable) begin
        case (ALU_FUN)
            2'b00: begin
                CMP_Out  <=16'b0;
                CMP_Flag <= 1'b1;
            end
            2'b01: begin
                CMP_Out  <= (A == B) ? 16'b1 : 16'b0;
                CMP_Flag <= 1'b1;
            end
            2'b10: begin
                CMP_Out  <= (A > B) ? 16'b10 : 16'b0;
                CMP_Flag <= 1'b1;
            end
            2'b11: begin
                CMP_Out  <= (A < B) ? 16'b11 : 16'b0;
                CMP_Flag <= 1'b1;
            end
            default: begin
                CMP_Out  <= 16'sb0;
                CMP_Flag <= 1'b0;
            end
        endcase
    end
    else begin
        CMP_Flag <= 1'b0;
    end
end

endmodule
