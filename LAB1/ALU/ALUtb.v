module ALUtb#(parameter W=4);

reg clktb;
reg [W-1:0] Atb;
reg [W-1:0] Btb;
reg [2:0] ALUcntrltb;
reg [W-1:0] Oexp;
reg COexp;
reg OVFexp;
reg Nexp;
reg Zexp;
reg [31:0] vectornum,errors;
reg [18:0] testvectors[9:0]; 
wire [W-1:0] Otb;
wire COtb;
wire OVFtb;
wire Ntb;
wire Ztb;

ALU dut(.A(Atb),.B(Btb),.ALUcntrl(ALUcntrltb),
			.O(Otb),.CO(COtb),.OVF(OVFtb),.N(Ntb),.Z(Ztb));
// To generate clock cycles 
always
begin
	clktb=~clktb; 
	#5;
end

// To read vectors
initial
begin
	clktb=1;
	$readmemb("ALUtb.tv",testvectors);
	vectornum = 0;
	errors = 0;
end			
// Test Vectors are read and operated at pos edges
	always @(posedge clktb)
	begin
		#1;
		{Atb,Btb,ALUcntrltb,Oexp,COexp,OVFexp,Nexp,Zexp}=testvectors[vectornum];
	end
// Test Vector Output and Expect are compared at neg edges
	always @(negedge clktb)
	begin
		if(Otb != Oexp)
		begin
			$display("Error: input = %b %b", Atb, Btb);
			$display("O outputs = %b (%b expected)",Otb,Oexp);
			errors= errors +1;
		end
		if(COtb != COexp)
		begin
			$display("Error: input = %b %b", Atb, Btb);
			$display("CO outputs = %b (%b expected)",COtb,COexp);
			errors= errors +1;
		end
		if(OVFtb != OVFexp)
		begin
			$display("Error: input = %b %b", Atb, Btb);
			$display("OVF outputs = %b (%b expected)",OVFtb,OVFexp);
			errors= errors +1;
		end
		if(Ntb != Nexp)
		begin
			$display("Error: input = %b %b", Atb, Btb);
			$display("N outputs = %b (%b expected)",Ntb,Nexp);
			errors= errors +1;
		end
		if(Ztb != Zexp)
		begin
			$display("Error: input = %b %b", Atb, Btb);
			$display("Z outputs = %b (%b expected)",Ztb,Zexp);
			errors= errors +1;
		end

		vectornum = vectornum +1;
		if(testvectors[vectornum] == 4'bx)
		begin
			$display("%d tests completed with %d errors",vectornum, errors);
			$stop;
		end
	end
endmodule












