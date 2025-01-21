module comb_circuit(input Sa,Sb,Op,sign,
                    output Sr,Operation);

always@(*)begin
    case({Sa,Sb,Op})
        3'b000:
        begin
            Operation <= 1'b0;
            Sr <= 1'b0;
        end
        3'b001:
        begin
            Operation <= 1'b1;
            Sr <= sign;
        end
        3'b010:
        begin
            Operation <= 1'b1;
            Sr <= sign;
        end
        3'b011:
        begin
            Operation <= 1'b0;
            Sr <= 1'b0;
        end
        3'b100:
        begin
            Operation <= 1'b1;
            Sr <= sign;
        end
        3'b101:
        begin
            Operation <= 1'b0;
            Sr <= 1'b1;
        end
        3'b110:
        begin
            Operation <= 1'b0;
            Sr <= 1'b1;
        end
        3'b111:
        begin
            Operation <= 1'b1;
            Sr <= sign;
        end
end