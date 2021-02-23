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
//  ADC Model (SPI slave interface, providing two data channels) 
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
module spi_vip(
  // Control
  input wire          reset_ni,            // I; asynchronous reset (active low)  
  input wire          tx_en_i,             // I; TX enable
  input wire          rx_en_i,             // I; RX enable

  // SPI interface
  input  wire         spi_cs_ni,            // O; SPI chip select
  input  wire         spi_sck_i,            // O; SPI clock
  output wire  [1:0]  spi_miso_o,           // O; SPI data out (2 bit)
  input  wire  [1:0]  spi_mosi_i,           // I; SPI data in (2 bit)
  
  // Monitoring TX data 
  output logic        tx_mon_data_update_o, // O; New TxD data available
  output logic [11:0] tx_mon_data0_o,       // O; TX data channel 0 
  output logic [11:0] tx_mon_data1_o,       // O; TX data channel 1  

  // Monitoring RX data
  output logic        rx_mon_data_update_o, // O; New RxD data available
  output logic [11:0] rx_mon_data0_o,       // O; RX data channel 0 
  output logic [11:0] rx_mon_data1_o        // O; RX data channel 1  
);

  // -------------------------------------------------------------------------
  // Definition
  // -------------------------------------------------------------------------

  // verilator lint_save
  // verilator lint_off UNOPTFLAT
    logic [15:0] tx_data0;  
    logic [15:0] tx_data1; 
    
    logic [15:0] rx_data0;  
    logic [15:0] rx_data1; 
  // verilator lint_restore
  
  // Frame releated signals
  logic        msb_active;
  logic        msb_active_dly;
  logic        lsb_active;
  logic        lsb_active_dly;
  bit    [3:0] bit_cnt;
  

  typedef struct packed {
    bit [11:0] data0;
    bit [11:0] data1;
  } spi_data_t;
  spi_data_t spi_data;
  spi_data_t spi_data_2;
  
 
  // RX, TX data queue 
  spi_data_t tx_data_queue [$];
  spi_data_t rx_data_queue [$];
  
  // Add data to Tx queue
  function void tx_data_put(bit [11:0] data0, bit [11:0] data1);
    spi_data_t data;
    data = '{data0: data0, data1: data1};
    tx_data_queue.push_back(data);
  endfunction

  // Get data from Rx queue
  function spi_data_t rx_data_get();
    spi_data_t data = '{12'h000, 12'h000};
    if (rx_data_queue.size > 0) begin
      return rx_data_queue.pop_front();
    end else begin
      return data;
    end
  endfunction

     
  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------
  initial begin
    tx_mon_data0_o       = 12'h000;
    tx_mon_data1_o       = 12'h000;
    tx_mon_data_update_o = 1'b1;
    rx_mon_data0_o       = 12'h000;
    rx_mon_data1_o       = 12'h000;
    rx_mon_data_update_o = 1'b1;
  end
  
  // Frame handling -----------------------------------------------------------
  // MSB / LSB  detection 
  always_ff @(negedge spi_sck_i or posedge spi_cs_ni or negedge reset_ni) begin
    if (spi_cs_ni | ~reset_ni) begin
      msb_active        <= 1'b1;    
      msb_active_dly    <= 1'b0;      
      lsb_active        <= 1'b0; 
      lsb_active_dly    <= 1'b0;
      bit_cnt           <= 4'd15;
    end else begin 
      if (tx_en_i | rx_en_i) begin
        if (msb_active) begin
          msb_active        <= 1'b0;          
        end
        msb_active_dly <= msb_active;    
        lsb_active_dly <= lsb_active;
        
        // Bit counter
        if (bit_cnt > 4'h0) begin
          bit_cnt <= bit_cnt - 1'b1;   
          if (bit_cnt == 4'h1) begin
            lsb_active <= 1'b1;
          end      
        end else begin
          lsb_active <= 1'b0;
        end
            
      end else begin
        msb_active        <= 1'b0;                 
        msb_active_dly    <= 1'b0;       
      end  
    end
  end
  
  
  // TX -----------------------------------------------------------------------
  
  // TX data shifting  
  // txdataX: 4'b0000 + spi_data.dataX[11:0]
  // txdataX[15] is provided after falling edge of spi_cs_ni
  // First falling edge already shifts the data
  //   --> implemented by taking spi_data,dataX[14:0] instead of [15:0]
  always_ff @(negedge spi_sck_i or posedge spi_cs_ni or negedge reset_ni) begin
    if (spi_cs_ni | ~reset_ni) begin
      tx_data0          <= 16'h0000; 
      tx_data1          <= 16'h0000;
    end else begin 
      if (tx_en_i) begin
        if (msb_active) begin
          if (tx_data_queue.size > 0) begin
            // verilator lint_save
            // verilator lint_off BLKSEQ    
              spi_data = tx_data_queue.pop_front();
            // verilator lint_restore
            tx_data0 <= {4'h0, spi_data.data0};  
            tx_data1 <= {4'h0, spi_data.data1};  
          end else begin
            tx_data0 <= 16'h05a5;  
            tx_data1 <= 16'h05a5;  
          end        
        end else begin
          tx_data0 <= {1'b0, tx_data0[13:0], 1'b0};  
          tx_data1 <= {1'b0, tx_data1[13:0], 1'b0};  
        end  
      end else begin
        tx_data0 <= 16'h0000; 
        tx_data1 <= 16'h0000;
      end
    end
  end
  
  // Tristate handling
  assign spi_miso_o = (spi_cs_ni | ~tx_en_i) ? 2'bzz : {tx_data1[14], tx_data0[14]};

  // TX monitoring handling
  always @(negedge spi_sck_i or posedge spi_cs_ni or negedge reset_ni) begin
    if (spi_cs_ni | ~reset_ni) begin
      tx_mon_data_update_o <= 1'b0;
    end else begin 
      if (tx_en_i) begin
        if (~msb_active & msb_active_dly) begin
          tx_mon_data0_o       <= tx_data0[11:0];
          tx_mon_data1_o       <= tx_data1[11:0];
          tx_mon_data_update_o <= 1'b1;
        end else begin
          tx_mon_data_update_o <= 1'b0;
        end
      end else begin
        tx_mon_data0_o       <= 12'h0000;
        tx_mon_data1_o       <= 12'h0000;
        tx_mon_data_update_o <= 1'b0;
      end  
    end
  end

  
  // RX part ------------------------------------------------------------------  
  
  // RX data shifting
  always_ff @(negedge spi_sck_i or posedge spi_cs_ni or negedge reset_ni) begin
    if (spi_cs_ni | ~reset_ni) begin
      rx_data0 <= 16'h0000; 
      rx_data1 <= 16'h0000;
    end else begin 
      if (rx_en_i) begin
        if (~lsb_active & lsb_active_dly) begin        
          // verilator lint_save
          // verilator lint_off BLKSEQ    
          spi_data_2 = '{data0: rx_data0[11:0], data1: rx_data1[11:0]};
          // verilator lint_restore
          rx_data_queue.push_back(spi_data_2);
        end else begin 
          rx_data0 <= {rx_data0[14:0], spi_mosi_i[0]};
          rx_data1 <= {rx_data1[14:0], spi_mosi_i[1]};
        end   
      end else begin
        rx_data0 <= 16'h0000; 
        rx_data1 <= 16'h0000;  
      end
    end
  end

  // RX monitoring handling
  always @(posedge spi_sck_i or posedge spi_cs_ni or negedge reset_ni) begin
    if (spi_cs_ni | ~reset_ni) begin
      rx_mon_data_update_o <= 1'b0;
    end else begin 
      if (rx_en_i) begin
        if (~lsb_active & lsb_active_dly) begin
          rx_mon_data0_o       <= rx_data0[11:0];
          rx_mon_data1_o       <= rx_data1[11:0];
          rx_mon_data_update_o <= 1'b1;
        end else begin
          rx_mon_data_update_o <= 1'b0;
        end
      end else begin
        rx_mon_data0_o       <= 12'h0000;
        rx_mon_data1_o       <= 12'h0000;
        rx_mon_data_update_o <= 1'b0;
      end  
    end
  end
    

endmodule
`default_nettype wire
