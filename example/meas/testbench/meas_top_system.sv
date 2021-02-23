//  --------------------------------------------------------------------------
//                    Copyright Message
//  --------------------------------------------------------------------------
//
//  CONFIDENTIAL and PROPRIETARY
//  COPYRIGHT (c) Klaus Strohmayer 2020
//
//  All rights are reserved. Reproduction in whole or in part is
//  prohibited without the written consent of the copyright owner.
//
//
//  ----------------------------------------------------------------------------
//                    Description
//  ----------------------------------------------------------------------------
//
//  Measurement system level (RTL + Model) 
//
//  ----------------------------------------------------------------------------
//                    Revision History (written manually)
//  ----------------------------------------------------------------------------
//
//  Date        Author     Change Description
//  ==========  =========  ========================================================
//  2019-12-30  kstrohma   Initial release
//  (rev xxxxx)       

`default_nettype none
module meas_top_system(
  input  wire               clk        , // I; Clock
  input  wire               reset_ni   , // I; Reset (active low)
  input  wire  [15:0]       sw           // I; SW
);
  
  // -------------------------------------------------------------------------
  // Definition 
  // -------------------------------------------------------------------------

  wire [7:0] JA; 
  // verilator lint_save
  // verilator lint_off UNOPTFLAT
  wire [7:0] JB; 
  // verilator lint_restore

  
  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------
  meas_top u_meas_top(  
    // verilator lint_save
    // verilator lint_off PINCONNECTEMPTY
    .clk(clk),               // I; CLK Input
	 
    //Push Button Inputs	 
    .btnC(~reset_ni),         // I; Center 
    .btnU(1'b0),              // I; Up 
    .btnD(1'b0),              // I; Down 
    .btnR(1'b0),              // I; Left  
    .btnL(1'b0),              // I; Right
	 
    // Slide Switch Inputs
    .sw  (sw      ),          // I; SW 0..15 
 
    // PMOD Header
    .JA(JA),                  // IO; Jumper A
    .JB(JB),                  // IO; Jumper B
  
    // USB-RS232 Interface
    .RsTx(),           // O; TXD  
    .RsRx(1'b0),       // I; RXD

    // LED  
    .led(),            // O; LED Outputs 0..15
     
    // Seven Segment Display Outputs
    .seg(),            // O; Segment 6..0  
    .an (),            // O; Anode of Seg0 ..3
    .dp ()             // O; 
    // verilator lint_restore
  );
  
  // verilator lint_save
  // verilator lint_off PINCONNECTEMPTY
  spi_vip u_adc_spi_vip(
    // Control
    .reset_ni           (reset_ni), // I; asynchronous reset (active low)  
    .tx_en_i            (1'b1),     // I; TX enable
    .rx_en_i            (1'b0),     // I; RX enable

    // SPI interface
    .spi_cs_ni         (JA[0]),     // O; SPI chip select
    .spi_sck_i         (JA[3]),     // O; SPI clock
    .spi_miso_o        (JA[2:1]),   // O; SPI data out (2 bit)
    .spi_mosi_i        (2'b00),     // I; SPI data in (2 bit)
    
    // Monitoring TX data 
    .tx_mon_data_update_o(),        // O; New TxD data available
    .tx_mon_data0_o      (),        // O; TX data channel 0 
    .tx_mon_data1_o      (),        // O; TX data channel 1  

    // Monitoring RX data
    .rx_mon_data_update_o(),        // O; New RxD data available
    .rx_mon_data0_o      (),        // O; RX data channel 0 
    .rx_mon_data1_o      ()         // O; RX data channel 1  
  );

  spi_vip u_dac_spi_vip(
    // Control
    .reset_ni           (reset_ni), // I; asynchronous reset (active low)  
    .tx_en_i            (1'b0),     // I; TX enable
    .rx_en_i            (1'b1),     // I; RX enable

    // SPI interface
    .spi_cs_ni         (JB[0]),     // O; SPI chip select
    .spi_sck_i         (JB[3]),     // O; SPI clock
    .spi_miso_o        (),          // O; SPI data out (2 bit)
    .spi_mosi_i        (JB[2:1]),   // I; SPI data in (2 bit)
    
    // Monitoring TX data 
    .tx_mon_data_update_o(),        // O; New TxD data available
    .tx_mon_data0_o      (),        // O; TX data channel 0 
    .tx_mon_data1_o      (),        // O; TX data channel 1  

    // Monitoring RX data
    .rx_mon_data_update_o(),        // O; New RxD data available
    .rx_mon_data0_o      (),        // O; RX data channel 0 
    .rx_mon_data1_o      ()         // O; RX data channel 1  
  );
  // verilator lint_restore

  import ea_package::*;
  
  // Check that the SystemVerilog API fits to the C DPI functions
  initial begin
    if (eaAPIVersionOk(EA_API_VERSION, EA_API_SUBVERSION) == EA_OK) begin
      $display("(INFO) ErrorAnalyzer API version %1dv%1d.", EA_API_VERSION, EA_API_SUBVERSION);
    end else begin
      $display("(ERROR) Used ErrorAnalyzer API version %1dv%1d does not match external DPI functions!", EA_API_VERSION, EA_API_SUBVERSION);
    end;
  end
  
  // Checking of ADC SPI -----------------------------------------------------
  //   Define data provided by the ADC
  //   Check that the correct data is received by the SPI Master inside the design
  scoreboard #(.ANALYZER_TYPE(ea_package::EA_TYPE_LOG)) u_sb_adc();

  initial begin
    // Init scoreboard
    u_sb_adc.init("ADC");
     
    for (bit[11:0] i=0; i<256; i++) begin
      // Add ADC data 
      u_adc_spi_vip.tx_data_put(i, 11*i+2088);   
      // Add same data as expected values to ADC scoreboard       
      u_sb_adc.exp_data_put(i, 11*i+2088); 
    end    
    for (bit[11:0] i=255; i>10; i--) begin
      // Add ADC data 
      u_adc_spi_vip.tx_data_put(i, 11*i+2088);   
      // Add same data as expected values to ADC scoreboard       
      u_sb_adc.exp_data_put(i, 11*i+2088); 
    end    
  end   
  
  `ifdef EA_ERROR_TIMESHIFT
    // Skip first sample --> represents a synchronization issue
    bit first = 1;
  `else
    bit first = 0;
  `endif  
  always @(negedge clk) begin
    if (u_meas_top.spi_adc_data_update) begin
      if (reset_ni) begin
        if (!first) begin 
          // New ADC data received within meas_top added to scoreboard   
          u_sb_adc.read_data_put(u_meas_top.spi_adc_data0[11:0], u_meas_top.spi_adc_data1[11:0]);
        end else begin
          first = 0;
        end
      end
    end
  end
  
  
  // Check of Averaging ------------------------------------------------------
  scoreboard #(.ANALYZER_TYPE(ea_package::EA_TYPE_ARITH)) u_sb_avg();
  
  initial begin
    // Init scoreboard
    u_sb_avg.init("Averager");
  end
  
  // Calculate expected value from input value  
  logic [11:0] avg0_reg = 0;
  logic [11:0] avg1_reg = 0;
  `ifdef EA_ERROR_STUCK
    logic [11:0] avg0_reg_s0_msk = 12'b111111101111; 
    logic [11:0] avg1_reg_s1_msk = 12'b000000000010;
  `else 
    logic [11:0] avg0_reg_s0_msk = 12'b111111111111; 
    logic [11:0] avg1_reg_s1_msk = 12'b000000000000;
  `endif    
  always @(negedge clk) begin
    if (reset_ni) begin
      if (u_meas_top.u_avg_data0.din_update_i) begin
        // Calculate expected output value based on actual input value   
        avg0_reg = (u_meas_top.u_avg_data0.din_i >> 3) + (avg0_reg >> 3) + (avg0_reg >> 2) + (avg0_reg >> 1);
        avg1_reg = (u_meas_top.u_avg_data1.din_i >> 3) + (avg1_reg >> 3) + (avg1_reg >> 2) + (avg1_reg >> 1);
        u_sb_avg.exp_data_put((avg0_reg & avg0_reg_s0_msk), (avg1_reg | avg1_reg_s1_msk));
      end
    end  
  end  
   
  always @(negedge clk) begin
    if (reset_ni) begin
      if (u_meas_top.u_avg_data0.dout_update_o) begin
        // New ADC data received within meas_top added to scoreboard   
        u_sb_avg.read_data_put(u_meas_top.u_avg_data0.dout_o, u_meas_top.u_avg_data1.dout_o);
      end
    end  
  end  

  
  // Check of DAC ------------------------------------------------------------
  scoreboard #(.ANALYZER_TYPE(ea_package::EA_TYPE_LOG)) u_sb_dac();
  int dac_exp_cnt = 0;
  int dac_read_cnt = 0;
  
  initial begin
    // Init scoreboard
    u_sb_dac.init("DAC");
  end
  
  // Calculate expected value from input value  
  always @(negedge clk) begin
    if (reset_ni) begin
      if (u_meas_top.u_spi_dac.data0_updata_i & u_meas_top.u_spi_dac.en_i) begin
        dac_exp_cnt++;
 
        u_sb_dac.exp_data_put(u_meas_top.u_spi_dac.data0_i, u_meas_top.u_spi_dac.data1_i);
      end
    end  
  end  
   
  always @(negedge u_dac_spi_vip.rx_mon_data_update_o) begin
    if (reset_ni) begin
      //if (u_dac_spi_vip.rx_mon_data_update_o) begin
        // New ADC data received within meas_top added to scoreboard   
      dac_read_cnt++;
        u_sb_dac.read_data_put(u_dac_spi_vip.rx_mon_data0_o, u_dac_spi_vip.rx_mon_data1_o);
      //end
    end  
  end  
    
endmodule
`default_nettype wire
