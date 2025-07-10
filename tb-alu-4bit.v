`timescale 1ns/1ps
module tb_alu_4bit;

    reg [3:0] A, B;
    reg [2:0] SEL;
    wire [3:0] RESULT;
    wire CARRY, OVERFLOW, ZERO;

    alu_4bit uut (
        .A(A), .B(B), .SEL(SEL),
        .RESULT(RESULT), .CARRY(CARRY),
        .OVERFLOW(OVERFLOW), .ZERO(ZERO)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, tb_alu_4bit);

        $display("A     B     SEL   RESULT  CARRY  OVERFLOW  ZERO");

        A = 4'b0011; B = 4'b0001; SEL = 3'b000; #10;  // A+B
        $display("%b  %b  %b   %b     %b       %b        %b", A, B, SEL, RESULT, CARRY, OVERFLOW, ZERO);

        A = 4'b0110; B = 4'b0011; SEL = 3'b001; #10;  // A-B
        $display("%b  %b  %b   %b     %b       %b        %b", A, B, SEL, RESULT, CARRY, OVERFLOW, ZERO);

        A = 4'b1100; B = 4'b1010; SEL = 3'b010; #10;  // A & B
        A = 4'b1100; B = 4'b1010; SEL = 3'b011; #10;  // A | B
        A = 4'b1100; B = 4'b1010; SEL = 3'b100; #10;  // A ^ B

        A = 4'b0100; B = 4'b0011; SEL = 3'b101; #10;  // A > B
        A = 4'b1010; B = 4'b0000; SEL = 3'b110; #10;  // Shift Left
        A = 4'b1000; B = 4'b0000; SEL = 3'b111; #10;  // Shift Right

        $stop;
    end
endmodule
