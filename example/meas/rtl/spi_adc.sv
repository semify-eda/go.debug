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
module spi_adc(
  input wire  rst_ni,               // I; Reset (active low)
  input wire  clk,                  // I; Clock 
  
  // Control
  input wire       en_i,            // I; Enable

  // SPI interface
  output logic     spi_cs_no,       // O; SPI chip select
  output logic     spi_sck_o,       // O; SPI clock
  input wire [1:0] spi_miso_i,      // I; SPI data in (2 bit)
  
  // data output 
  output        logic data_update_o, // O; New data available
  output logic [11:0] data0_o,       // O; ADC data channel 0 
  output logic [11:0] data1_o        // O; ADC data channel 1  
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
  

  // Serial ADC data shift register
  logic [11:0] data0_shft_ff; // FF 
  logic [11:0] data1_shft_ff; // FF 
  logic        datax_shft;    // shift cycle 
  logic        datax_shft_en; // shift enable   
  logic        data_update;   // New data available
  
  // FSM states
  enum logic [2:0] {
    IDLE           = 3'h0,
    CS_HIGH        = 3'h1,
    CS_LOW         = 3'h2,
    SCK_0          = 3'h3,
    SCK_LOW        = 3'h4,
    SCK_HIGH       = 3'h5,
    UPDATE         = 3'h6,
    CS_QUIET       = 3'h7
  } fsm_state_ff, fsm_state_next;
      
  localparam bit [3:0] SCK_CNT_MAX = 4'he;
  
  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------

  // Sequential part of sequence FSM  
  always_ff @(posedge clk, negedge rst_ni) begin
    if (~rst_ni) begin
      fsm_state_ff <= IDLE;
    end else begin    
      fsm_state_ff <= fsm_state_next;
    end
  end

  // Sequential part directly controlled by the FSM
  always_ff @(posedge clk, negedge rst_ni) begin
    if (~rst_ni) begin
      cs_nff        <= 1'b1;
      sck_ff        <= 1'b0;
      sck_cnt_ff    <= 4'h0;
      data0_shft_ff <= 12'h000;
      data1_shft_ff <= 12'h000;
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
      
      if (datax_shft) begin
        data0_shft_ff <= {data0_shft_ff[10:0], spi_miso_i[0]};
        data1_shft_ff <= {data1_shft_ff[10:0], spi_miso_i[1]};
      end
      
    end
  end
  assign sck_cnt_rdy   = (sck_cnt_ff >= SCK_CNT_MAX);
  assign bit_cnt_rdy   = (bit_cnt_ff >= 4'hf);
  assign datax_shft_en = (bit_cnt_ff >= 4'h3);
     
  // Combinational part of FSM
  always_comb begin
    fsm_state_next = fsm_state_ff;
    cs_clr         = 1'b0;
    cs_set         = 1'b0;
    sck_cnt_clr    = 1'b0;  
    sck_cnt_en     = 1'b0;
    sck_clr        = 1'b0;
    sck_set        = 1'b0;
    bit_cnt_clr    = 1'b0;
    bit_cnt_en     = 1'b0;
    datax_shft     = 1'b0;
    data_update    = 1'b0;
    case (fsm_state_ff)
      IDLE: begin
          if (en_i) begin
            cs_set         = 1'b1;
            sck_cnt_clr    = 1'b1;
            sck_set        = 1'b1;
            fsm_state_next = CS_HIGH;
          end
        end
        
      CS_HIGH: begin
          sck_cnt_en     = 1'b1;
          if (sck_cnt_rdy) begin
            cs_clr         = 1'b1;
            sck_cnt_clr    = 1'b1;
            fsm_state_next = CS_LOW;
          end
        end
        
      CS_LOW: begin
          sck_cnt_en     = 1'b1;
          if (sck_cnt_rdy) begin 
            fsm_state_next = SCK_0;
          end
        end

      SCK_0: begin
          sck_cnt_clr    = 1'b1;
          sck_clr        = 1'b1;
          bit_cnt_clr    = 1'b1;    
          fsm_state_next = SCK_LOW;
        end

      SCK_LOW: begin
          sck_cnt_en     = 1'b1;
          if (sck_cnt_rdy) begin
            sck_cnt_clr    = 1'b1;
            sck_set        = 1'b1;
            `ifdef EA_ERROR_BITSHIFT
              // Wrong compare sampling edge --> results in a bit shift
              if (datax_shft_en) begin
                datax_shft     = 1'b1;
              end
            `endif
            fsm_state_next = SCK_LOW;
            fsm_state_next = SCK_HIGH;
          end  
        end

      SCK_HIGH: begin
          sck_cnt_en     = 1'b1;
          if (sck_cnt_rdy) begin
            if (bit_cnt_rdy) begin
              cs_set         = 1'b1; 
              fsm_state_next = UPDATE;
            end else begin
              sck_cnt_clr    = 1'b1;
              sck_clr        = 1'b1;
              bit_cnt_en     = 1'b1;
              `ifndef EA_ERROR_BITSHIFT
                // Correct compare sampling edge 
                if (datax_shft_en) begin
                  datax_shft     = 1'b1;
                end
              `endif
              fsm_state_next = SCK_LOW;
            end  
          end  
        end

      UPDATE: begin
          data_update    = 1'b1;
          cs_set         = 1'b1;
          sck_cnt_clr    = 1'b1;
          sck_set        = 1'b1;
          fsm_state_next = CS_HIGH;
        end
      default: begin
          fsm_state_next = IDLE; 
        end  
    endcase
  end


  // Outputs -----------------------------------------------------------------
  always_ff @(posedge clk, negedge rst_ni) begin
    if (~rst_ni) begin
      data0_o       <= 12'h000;
      data1_o       <= 12'h000;
      data_update_o <= 1'b0;
    end else begin
      if (data_update) begin
        data0_o   <= data0_shft_ff;
        data1_o   <= data1_shft_ff;
      end
      data_update_o <= data_update;
    end
  end
/*
  assign data0_o       = data0_shft_ff;
  assign data1_o       = data1_shft_ff;
  assign data_update_o = data_update;
*/  
  assign spi_cs_no = cs_nff;
  assign spi_sck_o = sck_ff;
  
  
endmodule
`default_nettype wire
