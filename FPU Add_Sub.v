module fpu_add(input [31:0]A,B,
               input op,
               output reg[31:0]result);
reg [7:0]n;
reg [23:0]Mb_Shift;
wire Sr,Operation;
reg sign,carry;
reg [23:0]M;
reg [22:0]Mantissa;
wire [7:0]Ea=A[30:23] ,Eb=B[30:23];
reg [7:0]E;
wire [23:0]Ma={1'b1,A[22:0]}, Mb={1'b1,B[22:0]};
reg [23:0]Ma_swap,Mb_swap;
wire Sa =A[31], Sb=B[31];
integer i;
comb_circuit Combinational_Circuit(Sa,Sb,op,sign,Sr,Operation);
always@(*) begin
    n <= (Ea>Eb)?(Ea-Eb):(Eb-Ea);
    Ma_swap <= (Ea>Eb)?(Ma):(Mb);
    Mb_swap <= (Ea>Eb)?(Mb):(Ma);
    Mb_Shift <= Mb_swap>>n;
    sign <= (Ea>Eb)?(0):(1);
    M <= (Operation)?(Ma-Mb):(Ma+Mb);
    E <= (Ea>Eb)?(Ea):(Eb);
    if(carry)
    begin
        M = M>>1;
        E = (E < 8'hff) ? E + 1 : 8'hff;  
    end
    else if(|M != 1'b1)  
    begin
        M = 0;
    end
    else
    begin
        for(i = 0; M[23] !== 1'b1 && E > 0 && i < 24; i = i + 1) begin
            M = M << 1;
            E = E - 1;
        end
    end
    Mantissa = M[22:0];
    result = {Sr,E,Mantissa};
end
endmodule