module code(clk,rst,req,grant);
input clk;
input rst;
input [3:0]req;
output reg [3:0]grant;
reg [2:0] present_state,next_state;
parameter S_start=3'b000;
parameter S0=3'b001;
parameter S1=3'b010;
parameter S2=3'b011;
parameter S3=3'b100;
always @ (posedge clk, negedge rst) begin
if(!rst)
present_state<=S_start;
else
present_state<=next_state;
end
always @ (*) begin
case(present_state)
S_start: 
begin
    if(req[0])
    begin
    next_state=S0;
    end
    else if(req[1])
    begin
    next_state=S1;
    end
    else if(req[2])
    begin
        next_state=S2;
    end
    else if(req[3])
    begin
        next_state=S3;
    end
    else
    begin
    next_state=S_start;
    end
end
S0: 
begin
    if(req[1])
    begin
        next_state=S1;
    end
    else if(req[2])
    begin
        next_state=S2;
    end
    else if(req[3])
    begin
        next_state=S3;
    end
    else if(req[0])
    begin
        next_state=S0;
    end
    else
    begin
        next_state=S_start;
    end
end
S1:
begin
    if(req[2])
    begin
    next_state=S2;
    end
    else if(req[3])
    begin
        next_state=S3;
    end
    else if(req[0])
    begin
        next_state=S0;
    end
    else if(req[1])
    begin
        next_state=S1;
    end
    else 
    begin
        next_state=S_start;
    end
end 
S2:
begin
    if(req[3])
    begin
        next_state=S3;
    end
    else if(req[0])
    begin
        next_state=S0;
    end
    else if(req[1])
    begin
        next_state=S1;
    end
    else if(req[2])
    begin
        next_state=S2;
    end
    else 
    begin
        next_state=S_start;
    end
end
S3:
begin
if(req[0])
    begin
        next_state=S0;
    end
    else if(req[1])
    begin
        next_state=S1;
    end
    else if(req[2])
    begin
        next_state=S2;
    end
    else if(req[3])
    begin
        next_state=S3;
    end
    else
    begin
        next_state=S_start;
    end
end
endcase
end
always @ (*)
begin
    case(present_state)
    S0: grant=4'b0001;
    S1: grant=4'b0010;
    S2: grant=4'b0100;
    S3: grant=4'b1000;
    default: grant=4'b0000;
    endcase
end
endmodule


