module alu_4bit (
    input [3:0] A, B,
    input [2:0] SEL,
    output reg [3:0] RESULT,
    output reg CARRY, OVERFLOW, ZERO
);
    always @(*) begin
        CARRY = 0; OVERFLOW = 0;
        case (SEL)
            3'b000: {CARRY, RESULT} = A + B;           // Addition
            3'b001: {CARRY, RESULT} = A - B;           // Subtraction
            3'b010: RESULT = A & B;                    // AND
            3'b011: RESULT = A | B;                    // OR
            3'b100: RESULT = A ^ B;                    // XOR
            3'b101: RESULT = (A > B) ? 4'b0001 : 4'b0000; // Greater
            3'b110: RESULT = A << 1;                   // Shift Left
            3'b111: RESULT = A >> 1;                   // Shift Right
            default: RESULT = 4'b0000;
        endcase

        ZERO = (RESULT == 4'b0000);

        if ((SEL == 3'b000 || SEL == 3'b001) &&
            ((A[3] & B[3] & ~RESULT[3]) | (~A[3] & ~B[3] & RESULT[3])))
            OVERFLOW = 1;
    end
endmodule
