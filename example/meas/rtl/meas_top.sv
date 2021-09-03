//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Klaus Strohmayer
// 
// Create Date:    17:08:26 06/12/2014 
// Design Name: 
// Module Name:    basys3_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
//
// Description: 
//   Demo for PmodADC1 readout (PmodADC1 connected to JA) 
//     ADC values is shown on 4digit 7segment display
//     The ADC conversion is enabled via SW1
//     The channels is selected via SW15
//   
//   The system can be triggered via buttont BTNC
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module meas_top(  
  input wire clk,               // I; CLK Input
	 
  //Push Button Inputs	 
  input wire btnC,              // I; Center 
  input wire btnU,              // I; Up 
  input wire btnD,              // I; Down 
  input wire btnR,              // I; Left  
  input wire btnL,              // I; Right
	 
  // Slide Switch Inputs
  input wire [15:0] sw,         // I; SW 0..15 
 
  // PMOD Header
  inout wire [7:0] JA,          // IO; Jumper A
  inout wire [7:0] JB,          // IO; Jumper B
  
  // USB-RS232 Interface
  output wire      RsTx,        // O; TXD  
  input  wire      RsRx,        // I; RXD
  
  output wire [15:0] led,       // O; LED Outputs 
     
  // Seven Segment Display Outputs
  output [6:0] seg,             // O; Segment  
  output [3:0] an,              // O; Anode of Seg0 ..3
  output       dp               // O; 
);
	

  // -------------------------------------------------------------------------
  // Definition
  // -------------------------------------------------------------------------
  
  // ADC SPI - Data
  logic [11:0] spi_adc_data0;
  logic [11:0] spi_adc_data1;
  logic        spi_adc_data_update;

  // DAC SPI
  logic [11:0] spi_dac_din0;
  logic        spi_dac_din0_update;
  logic [11:0] spi_dac_din1;
  logic        spi_dac_din1_update;
      
  logic [11:0] adc_data_ff;
  logic [19:0] adc_data_bcd;
  
  logic spi_adc_en;
  
  // Reset
  logic       rst_n;
  logic [1:0] rst_nff;
  
  
  
  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------
  
  // Reset generation
  always @(negedge clk or posedge btnC) begin
    if (btnC) begin
      rst_nff <= 2'b00;
    end else begin
     rst_nff <= {rst_nff[0], 1'b1};
    end  
  end
  assign rst_n = rst_nff[1];

  // ADC SPI
  assign spi_adc_en = sw[0];
  spi_adc u_spi_adc(
    .rst_ni (rst_n),                    // I; Reset (active low)
    .clk    (clk),                      // I; Clock 
  
    // Control
    .en_i    (spi_adc_en),                   // I; Enable

    // SPI interface
    .spi_cs_no    (JA[0]),               // O; SPI chip select
    .spi_sck_o    (JA[3]),               // O; SPI clock
    .spi_miso_i   (JA[2:1]),             // I; SPI data in (2 bit)
  
    // data output 
    .data_update_o (spi_adc_data_update),// O; New data available
    .data0_o       (spi_adc_data0),      // O; ADC data channel 0 
    .data1_o       (spi_adc_data1)       // O; ADC data channel 1  
  );
  
  avg #(
    .DATA_W(12)
  ) u_avg_data0 (
    .clk             (clk),                 // I; System clock 
    .reset_ni        (rst_n),               // I; system cock reset (active low)  
    .din_i           (spi_adc_data0),       // I; Input data    
    .din_update_i    (spi_adc_data_update), // I; Input data update 
    .avg_clr_i       (1'b0),                // I; Clear average data 
    .dout_o          (spi_dac_din0),        // O; Averaged data 
    .dout_update_o   (spi_dac_din0_update) // O; Input data update 
  );
  
  avg #(
    .DATA_W(12)
  ) u_avg_data1 (
    .clk             (clk),                 // I; System clock 
    .reset_ni        (rst_n),               // I; system cock reset (active low)  
    .din_i           (spi_adc_data1),       // I; Input data    
    .din_update_i    (spi_adc_data_update), // I; Input data update 
    .avg_clr_i       (1'b0),                // I; Clear average data 
    .dout_o          (spi_dac_din1),        // O; Averaged data 
    .dout_update_o   (spi_dac_din1_update)  // O; Input data update 
  );

  // DAC SPI  
  logic spi_dac_en_ff, spi_dac_en;
  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      spi_dac_en_ff <= 1'b0;  
    end else begin  
      if (spi_dac_din1_update) begin
        spi_dac_en_ff <= 1'b1;
      end
    end
  end
  assign spi_dac_en = spi_dac_din1_update | spi_dac_en_ff;
  
  spi_dac u_spi_dac(
    .rst_ni (rst_n),             // I; Reset (active low)
    .clk    (clk),               // I; Clock 
  
    // Control
    .en_i    (spi_dac_en),       // I; Enable

    // SPI interface]
    .spi_cs_no       (JB[0]),    // O; SPI chip select
    .spi_sck_o       (JB[3]),    // O; SPI clock
    .spi_mosi_o      (JB[2:1]),  // O; SPI data in (2 bit)
  
    // data input 
    .data0_i         (spi_dac_din0),         // I; DAC data channel 0 
    .data_pd0_i      (sw[12:11]),            // I; DAC operating mode
    .data0_updata_i  (spi_dac_din0_update),  // I; New DAC data channel 0 available
    .data1_i         (spi_dac_din1),         // I; DAC data channel 1 
    .data_pd1_i      (sw[14:13]),            // I; DAC operating mode
    .data1_updata_i  (spi_dac_din1_update)   // I; New DAC data channel 1 available
  );


  // ADC data switch and registering 
  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      adc_data_ff <= 12'd1234;  
    end else begin
      if (spi_adc_en) begin
        if (sw[15]) begin
          // Channel 1
          if (spi_dac_din1_update) begin
            // new averaged ADC data available
             adc_data_ff <= spi_dac_din1; 
          end
        end else begin
          // Channel 0
          if (spi_dac_din0_update) begin
            // new averaged ADC data available
            adc_data_ff <= spi_dac_din0;
          end          
        end
        //end else begin
        //  // No ADC conversions done --> provide 0000
        //  adc_data_ff <= 12'd1234;
      end
    end       
  end

  // Binary to BCD conversion of ADC result
  bin_to_bcd u_bin_to_bcd (
    .dbin_i  ({4'b0000, adc_data_ff}), // QU in binary
    .dbcd_o  (adc_data_bcd)            // QU in BCD
  );

  // Route switch to LEDs
  assign led[15:0] = sw[15:0];

  // 7segment display module
  seg7_ctrl u_seg7_ctrl (
    .rst_ni   (rst_n),
    .clk      (clk),
    .clr      (1'b0),
    .x        (adc_data_bcd[15:0]),

    // 7 segement control
    .a_to_g   (seg),
    .an       (an),
    .dp       (dp)
  );

  
  // UART TX Ctrl
  logic [15:0] uart_data_ff;
  logic        uart_data_ld;
  logic        uart_send;  
  logic        uart_ready;
  
  logic [3:0]  uart_digit_data;
  logic [7:0]  uart_digit_ascii_data; 
  
  // FSM states
  enum logic [2:0] {
    IDLE           = 3'h0,
    BYTE1          = 3'h1,
    BYTE2          = 3'h2,
    BYTE3          = 3'h3,
    BYTE4          = 3'h4,
    START          = 3'h5,
    CR             = 3'h6
  } uart_fsm_state_ff, uart_fsm_state_next;
        
  // Sequential part of sequence FSM  
  always_ff @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
      uart_fsm_state_ff <= IDLE;
    end else begin    
      uart_fsm_state_ff <= uart_fsm_state_next;
    end
  end

 // sequential part directly controlled by the FSM
  always_ff @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
      uart_data_ff  <= 16'h0000;
    end else begin  
      if (uart_data_ld) begin
        uart_data_ff <= adc_data_bcd[15:0];
      end
    end
  end
     
  // combinational part of FSM
  always_comb begin
    uart_fsm_state_next = uart_fsm_state_ff;
    uart_data_ld        = 1'b0;    
    uart_send           = 1'b0;
    uart_digit_data     = 4'h0;
    case (uart_fsm_state_ff)
      IDLE: begin
          if (btnU) begin
            uart_data_ld        = 1'b1;
            uart_fsm_state_next = START;  
          end 
        end
      START: begin
          uart_send           = 1'b1;
          uart_digit_data     = uart_data_ff[15:12];
          uart_fsm_state_next = BYTE1;  
        end
      BYTE1: begin
          if (uart_ready) begin 
            uart_send           = 1'b1;
            uart_digit_data     = uart_data_ff[11:8];
            uart_fsm_state_next = BYTE2;
          end   
        end
      BYTE2: begin
          if (uart_ready) begin 
            uart_send           = 1'b1;
            uart_digit_data     = uart_data_ff[7:4];
            uart_fsm_state_next = BYTE3;
          end   
        end
      BYTE3: begin
          if (uart_ready) begin 
            uart_send           = 1'b1;
            uart_digit_data     = uart_data_ff[3:0];
            uart_fsm_state_next = BYTE4;
          end   
       end
      BYTE4: begin
          if (uart_ready) begin 
            uart_send           = 1'b1;
            uart_digit_data     = 4'hf;
            uart_fsm_state_next = CR;
          end   
       end
      CR: begin
          if (uart_ready) begin 
            uart_fsm_state_next = IDLE;
          end   
       end
      default: begin
            uart_fsm_state_next = IDLE;
          end 
       
    endcase
  end
  
  always_comb begin
    case (uart_digit_data)
      4'h0:    uart_digit_ascii_data = 8'h30;
      4'h1:    uart_digit_ascii_data = 8'h31;
      4'h2:    uart_digit_ascii_data = 8'h32;
      4'h3:    uart_digit_ascii_data = 8'h33;
      4'h4:    uart_digit_ascii_data = 8'h34;
      4'h5:    uart_digit_ascii_data = 8'h35;
      4'h6:    uart_digit_ascii_data = 8'h36;
      4'h7:    uart_digit_ascii_data = 8'h37;
      4'h8:    uart_digit_ascii_data = 8'h38;
      4'h9:    uart_digit_ascii_data = 8'h39;
      4'hf:    uart_digit_ascii_data = 8'h0d;
      default: uart_digit_ascii_data = 8'h3f;
    endcase
  end
   
  // UART  
  uart_tx u_uart_tx(  
    .reset_ni  (rst_n),                   // I; Asynchronous reset (active low)
    .clk_i     (clk),                     // I; System clock  
    .send_i    (uart_send),               // I; start to send a new data byte
    .data_i    (uart_digit_ascii_data),   // I; data to send
    .ready_o   (uart_ready),              // O; ready to take new data
    .tx_o      (RsTx)                     // O; Serial UART data stream
  );
     
endmodule
