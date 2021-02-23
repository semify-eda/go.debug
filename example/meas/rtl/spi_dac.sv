//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2020 03:07:06 PM
// Design Name: 
// Module Name: spi_adc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`default_nettype none
module spi_dac(
  input wire  rst_ni,               // I; Reset (active low)
  input wire  clk,                  // I; Clock 
  
  // Control
  input wire         en_i,            // I; Enable

  // SPI interface
  output logic       spi_cs_no,       // O; SPI chip select
  output logic       spi_sck_o,       // O; SPI clock
  output logic [1:0] spi_mosi_o,      // O; SPI data in (2 bit)
  
  // data input 
  input  wire [11:0]  data0_i,        // I; DAC data channel 0 
  input  wire  [1:0]  data_pd0_i,     // I; DAC operating mode
  input  wire         data0_updata_i, // I; New DAC data cahnnel 0 available
  input  wire [11:0]  data1_i,        // I; DAC data channel 1 
  input  wire  [1:0]  data_pd1_i,     // I; DAC operating mode
  input  wire         data1_updata_i  // I; New DAC data cahnnel 1 available
);

  // -------------------------------------------------------------------------
  // Definition
  // -------------------------------------------------------------------------
  // Chip select
  logic       cs_nff;  // FF
  logic       cs_clr;  //   clear
  logic       cs_set;  //   set
  
  // Clock period counter
  logic [3:0] sck_cnt_ff;   // Counter FF
  logic       sck_cnt_en;   //   Enable
  logic       sck_cnt_clr;  //   Clear
  logic       sck_cnt_rdy;  //   Counter ready
  
  // Clock pin FF
  logic       sck_ff;       // FF
  logic       sck_clr;      //  Clear
  logic       sck_set;      //  Set
  
  // Bit counter
  logic [3:0] bit_cnt_ff;   // Counter FF
  logic       bit_cnt_en;   //   Enable
  logic       bit_cnt_clr;  //   Clear
  logic       bit_cnt_rdy;  //   Counter ready
  
  // input data register
  logic [11:0] data0_ff; // FF 
  logic [11:0] data1_ff; // FF 

  // Serial DAC data shift register 
  logic [13:0] data0_shft_ff; // FF 
  logic [13:0] data1_shft_ff; // FF 
  logic        datax_ld;      // load 
  logic        datax_shft;    // shift cycle 
  logic        datax_shft_en; // shift enable   
  
  // FSM states
  enum logic [3:0] {
    IDLE              = 4'h0,
    START             = 4'h1,
    CS_HIGH_SCK_HIGH  = 4'h2,
    CS_HIGH_SCK_LOW   = 4'h3,
    SCK_LOW           = 4'h4,
    SCK_HIGH          = 4'h5,
    UPDATE            = 4'h6,
    CS_QUIET          = 4'h7,
    FRAME_END_SCK_HIGH_CS_LOW = 4'h8
  } fsm_state_ff, fsm_state_next;
      
  localparam bit [3:0] SCK_CNT_MAX = 4'he;
  
  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------

 // Sample input data
  always_ff @(posedge clk, negedge rst_ni) begin
    if (~rst_ni) begin
      data0_ff <= 12'h000;
      data1_ff <= 12'h000;
    end else begin    
      if (data0_updata_i) begin 
        data0_ff <= data0_i;
      end
      if (data1_updata_i) begin 
        data1_ff <= data1_i;
      end
    end
  end
 
  // Sequential part of sequence FSM  
  always_ff @(posedge clk, negedge rst_ni) begin
    if (~rst_ni) begin
      fsm_state_ff <= IDLE;
    end else begin    
      fsm_state_ff <= fsm_state_next;
    end
  end

 // sequential part directly controlled by the FSM
  always_ff @(posedge clk, negedge rst_ni) begin
    if (~rst_ni) begin
      cs_nff        <= 1'b1;
      sck_ff        <= 1'b0;
      sck_cnt_ff    <= 4'h0;
      data0_shft_ff <= 14'h0000;
      data1_shft_ff <= 14'h0000;
    end else begin  
      if (cs_clr) begin
        cs_nff <= 1'b0;
      end else if (cs_set) begin
        cs_nff <= 1'b1;
      end
      
      if (sck_clr) begin
        sck_ff <= 1'b0;
      end else if (sck_set) begin
        sck_ff <= 1'b1;
      end
      
      if (sck_cnt_clr) begin 
        sck_cnt_ff <= 4'h0;
      end else if (sck_cnt_en & ~sck_cnt_rdy) begin 
        sck_cnt_ff <= sck_cnt_ff + 1'b1;
      end
       
      if (bit_cnt_clr) begin 
        bit_cnt_ff <= 4'h0;
      end else if (bit_cnt_en & ~bit_cnt_rdy) begin
        bit_cnt_ff <= bit_cnt_ff + 1'b1;
      end  
      
      if (datax_ld) begin
        data0_shft_ff <= {data_pd0_i, data0_ff};
        data1_shft_ff <= {data_pd1_i, data1_ff};
      end else if (datax_shft) begin
        data0_shft_ff <= {data0_shft_ff[12:0], 1'b0};
        data1_shft_ff <= {data1_shft_ff[12:0], 1'b0};
      end
      
    end
  end
  assign sck_cnt_rdy   = (sck_cnt_ff >= SCK_CNT_MAX);
  assign bit_cnt_rdy   = (bit_cnt_ff >= 4'hf);
  assign datax_shft_en = (bit_cnt_ff >= 4'h2);
     
  // combinational part of FSM
  always_comb begin
    fsm_state_next = fsm_state_ff;
    cs_clr         = 1'b0;
    cs_set         = 1'b0 ;
    sck_cnt_clr    = 1'b0;  
    sck_cnt_en     = 1'b0;
    sck_clr        = 1'b0;
    sck_set        = 1'b0;
    bit_cnt_clr    = 1'b0;
    bit_cnt_en     = 1'b0;
    datax_ld       = 1'b0;
    datax_shft     = 1'b0;
    case (fsm_state_ff)
      IDLE: begin
          if (en_i) begin
            cs_set         = 1'b1;
            sck_set        = 1'b1;
            sck_cnt_clr    = 1'b1;
            datax_ld       = 1'b1;
            fsm_state_next = START;
          end
        end
      START: begin
          cs_set         = 1'b1;
          sck_set        = 1'b1;
          sck_cnt_clr    = 1'b1;
          datax_ld       = 1'b1;
          fsm_state_next = CS_HIGH_SCK_HIGH;
        end
        
      CS_HIGH_SCK_HIGH: begin
          sck_cnt_en     = 1'b1;
          if (sck_cnt_rdy) begin
            sck_clr        = 1'b1;
            sck_cnt_clr    = 1'b1;
            fsm_state_next = CS_HIGH_SCK_LOW;
          end  
        end

      CS_HIGH_SCK_LOW: begin
          sck_cnt_en     = 1'b1;
          if (sck_cnt_rdy) begin
            cs_clr         = 1'b1;
            sck_cnt_clr    = 1'b1;
            sck_set        = 1'b1;
            bit_cnt_clr    = 1'b1;    
            fsm_state_next = SCK_HIGH;
          end  
        end

      SCK_HIGH: begin
          sck_cnt_en     = 1'b1;
          if (sck_cnt_rdy) begin
            sck_cnt_clr    = 1'b1;
            sck_clr        = 1'b1;
            fsm_state_next = SCK_LOW;
          end  
        end

      SCK_LOW: begin
          sck_cnt_en     = 1'b1;
          if (sck_cnt_rdy) begin
            if (bit_cnt_rdy) begin
              sck_set        = 1'b1;
              fsm_state_next = FRAME_END_SCK_HIGH_CS_LOW;
            end else begin
              sck_cnt_clr    = 1'b1;
              sck_set        = 1'b1;
              bit_cnt_en     = 1'b1;
              if (datax_shft_en) begin
                datax_shft     = 1'b1;
              end
              fsm_state_next = SCK_HIGH;
            end  
          end  
        end
        
      FRAME_END_SCK_HIGH_CS_LOW: begin
          fsm_state_next = START; 
        end  
        
      default: begin
          fsm_state_next = IDLE; 
        end  

    endcase
  end

  // Outputs -----------------------------------------------------------------
  assign spi_cs_no  = cs_nff;
  assign spi_sck_o  = sck_ff;
  assign spi_mosi_o = {data1_shft_ff[13], data0_shft_ff[13]};  
  
endmodule
`default_nettype wire
