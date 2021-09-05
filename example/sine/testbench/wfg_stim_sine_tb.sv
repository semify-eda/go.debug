`default_nettype none
`timescale 1ns / 1ps
  
module wfg_stim_sine_tb ();
 logic clk;                          // clock signal  
 logic rst_n;                        // reset signal
 logic wfg_stim_spi_tready_o;
 wire wfg_stim_spi_tvalid_i;
 wire [17:0] wfg_stim_spi_tdata_i;   // data expected - sine 
 logic ctrl_en_q_i;                  // enable/disable data generation
 logic [15:0] inc_val_q_i;           // angular increment
 logic [15:0] gain_val_q_i;          // sine gain - multiplier
 logic [17:0] offset_val_q_i;        // sine offset
 
 real phase_in;                      // angular phase for sine generation
 logic signed [16:0] sine_in;        // sine value scled from float to int
 real pi = 3.1416;                   // pi const
 integer i;                           
 logic signed [31:0] expected_sine;  // expected sine value - compared with data_read
 logic signed [34:0] sine_gain_temp; // sine after applying gain
 logic signed [17:0] sine_out;       // sine after applying offset
 int id1;
 logic trigger;

  parameter CLK_PERIOD = 2;

  always #(CLK_PERIOD / 2) clk = ~clk;

  wfg_stim_sine wfg_stim_sine_top_inst (.*);

  initial begin
    $dumpfile ("stim_sine.vcd");
    $dumpvars;
    `ifndef GUI
    id1 = $eaVPIAnalyzerCreateCb("Analyzer 1", 0, 18, 0, int'($time), "wfg_stim_sine_tb.trigger", "wfg_stim_sine_tb.expected_sine", "wfg_stim_sine_tb.wfg_stim_spi_tdata_i");
    `endif
    #1 rst_n = 0;
    #1 rst_n = 1;
    
    inc_val_q_i = 16'h1357;
    clk = 0;
    trigger = 0;
    offset_val_q_i = 18'b101010101010101010;
    gain_val_q_i = 16'h2000;
    ctrl_en_q_i = 1;
    phase_in = 2 * pi; 
    phase_in = phase_in * inc_val_q_i / 17'h10000;
    
    // Generating sine wave samples for comparison - ErrorAnalyzer relevant
    for(i=0; i<251; i=i+1) begin
      #18 sine_in[16:0] = 16'hFFFF * $sin(phase_in * i);  // Scaling sine in float to s1f15 integer
      sine_gain_temp[33:0] = (sine_in[16:0] * gain_val_q_i[15:0]);  // Applying gain
      if(gain_val_q_i[15:0] > 16'h7FFF) begin
        sine_gain_temp[34:0] = {{16{sine_in[16]}},sine_in[15:0]} * {{16{1'b0}},16'h7FFF};
      end else begin
        sine_gain_temp[34:0] = {{16{sine_in[16]}},sine_in[15:0]} * {{16{1'b0}},gain_val_q_i[15:0]};
      end
      expected_sine[17:0] = sine_gain_temp[31:14];
      sine_out[17:0] = expected_sine[17:0] + offset_val_q_i[17:0];  // Applying offset
      // Underflow check
      if((expected_sine[17] == 1'b1) && (offset_val_q_i[17] == 1'b1) && (sine_out[17] == 1'b0)) begin
        expected_sine[31:0] = 32'h00020000;
      // Overflow check
      end else if ((expected_sine[17] == 1'b0) && (offset_val_q_i[17] == 1'b0) && (sine_out[17] == 1'b1)) begin
        expected_sine[31:0] = 32'h0001FFFF;
      end else begin
        expected_sine[31:0] = sine_out[17:0] & 32'h0003FFFF;
      end
      wfg_stim_spi_tready_o = 1;
      trigger = ~trigger; // On the trigger pulse add samples to the ErrorAnalyzer
      #18 wfg_stim_spi_tready_o = 0;

    end    

    $finish;
  end


endmodule
