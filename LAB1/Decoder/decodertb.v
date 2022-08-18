module decodertb();
reg clktb;
reg [1:0] Itb;
reg [3:0] Oexp;
reg [31:0] vectornum,errors;
reg [5:0] testvectors[3:0]; 
wire [3:0] Otb;
decoder DUT(.I(Itb), .O(Otb));
// To generate clock cycles 
always
begin
	clktb=~clktb; 
	#5;
end

// To read vectors
initial
begin
	clktb=0;
	$readmemb("decoder.tv",testvectors);
	vectornum = 0;
	errors = 0;
end

// Test Vectors are read and operated at pos edges
	always @(posedge clktb)
	begin
		#1;
		{Itb,Oexp}=testvectors[vectornum];
	end

// Test Vector Output and Expect are compared at neg edges
	always @(negedge clktb)
	begin
		if(Otb != Oexp)
		begin
			$display("Error: input = %b", {Itb});
			$display(" outputs = %b (%b expected)",Otb,Oexp);
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