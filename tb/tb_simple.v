`timescale 1ns / 1ps

module simple_tb;

    // Testbench signals
   reg [2:0] a;
   wire [6:0] result;
   integer    i;
   reg [6:0]  expected [7:0];
   reg	      test_fail;

    // Instantiate the DUT (Device Under Test)
    simple dut (
		.a (a),
		.result (result)
    );

 initial begin
    // Initialize the expected array
    expected[0] = 7'b0000000; // a=000
    expected[1] = 7'b0000001; // a=001
    expected[2] = 7'b0000011; // a=010
    expected[3] = 7'b0000111; // a=011
    expected[4] = 7'b0001111; // a=100
    expected[5] = 7'b0011111; // a=101
    expected[6] = 7'b0111111; // a=110
    expected[7] = 7'b1111111; // a=111
  end

   
   initial begin
      test_fail = 0;
      
      // Display header
      $display("Time\t| a   | result");
      $display("------\t|-----|-------");
      
      // Use a loop to test all 3-bit input combinations (0 to 7)
      for (i = 0; i < 8; i = i + 1) begin
	 a = i[2:0];
	 #10; // wait 10 time units
	 if (result == expected[i]) begin
	   $display("%0dns\t| %b | %b | Pass", $time, a, result);
	 end else begin
	    $display("%0dns\t| %b | %b | Fail", $time, a, result);
	    test_fail = 1;
	 end
      end
      
      // End simulation
      $finish_and_return(test_fail);
   end


endmodule
