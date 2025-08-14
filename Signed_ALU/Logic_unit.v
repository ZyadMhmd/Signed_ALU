
module Logic_unit (
    input  signed [15:0] A,
    input  signed [15:0] B,
    input  wire   [1:0]  ALU_FUN,
    input  wire          clk,
    input  wire          rst,
    input  wire          Logic_enable,
    output reg signed [15:0] Logic_Out,
    output reg           Logic_Flag
);

always @(posedge clk or negedge rst) begin	
    if (!rst) begin
        Logic_Out  <= 16'sb0;
        Logic_Flag <= 1'b0;
    end
    else if (Logic_enable) begin
        case (ALU_FUN)
            2'b00: begin
                Logic_Out  <= A & B;
                Logic_Flag <= 1'b1;
            end
            2'b01: begin
                Logic_Out  <= A | B;
                Logic_Flag <= 1'b1;
            end
            2'b10: begin
                Logic_Out  <= ~ ( A & B);
                Logic_Flag <= 1'b1;
            end
            2'b11: begin
                Logic_Out  <= ~ (A | B); 
                Logic_Flag <= 1'b1;
            end
            default: begin
                Logic_Out  <= 16'sb0;
                Logic_Flag <= 1'b0;
            end
        endcase
    end
    else begin
        Logic_Flag <= 1'b0;
    end
end

endmodule
