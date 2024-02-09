module MorraCinese (
  // Inputs
  input [1:0] PRIMO,
  input [1:0] SECONDO,
  input INIZIA,
  input clk,
  // Outputs
  output reg [1:0] MANCHE = 2'b00,
  output reg [1:0] PARTITA = 2'b00
);

  reg [1:0] MOSSA_PRECEDENTE = 2'b00;
  reg [4:0] NUMERO_PARTITE = 5'b00000;
  reg [4:0] CONTATORE = 5'b00000;
  reg [1:0] MANCHE_REG = 2'b00;
  reg [2:0] STATO = 3'b000;
  reg [2:0] STATO_PROSSIMO;
  reg CMIN = 1'b0;
  reg CMAX = 1'b0;

  reg [1:0] MANCHE_FSM;
  integer i = 1; // Debug purpose

  localparam S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100,
              S5 = 3'b101,
              S6 = 3'b110,
              S7 = 3'b111;


  always @(posedge clk) begin : UPDATE_STATE
    STATO = STATO_PROSSIMO;
  end

  always @(posedge clk) begin : DATAPATH
    if (INIZIA) begin
      MOSSA_PRECEDENTE  = 2'b00;
      PARTITA           = 2'b00;
      MANCHE_REG        = 2'b00;
      MANCHE_FSM        = 2'b00;
      MANCHE            = 2'b00;
      CMAX              = 1'b0;
      CMIN              = 1'b0;
      NUMERO_PARTITE    = {PRIMO, SECONDO} + 4;
      CONTATORE         = 5'b00000;  
      STATO             = 3'b000;
    end else begin
      // Datapath core logic
      if ({MOSSA_PRECEDENTE, MANCHE_REG} == {PRIMO, 2'b01} || {MOSSA_PRECEDENTE, MANCHE_REG} == {SECONDO, 2'b10}) begin
        MANCHE_FSM = 2'b00;
      end else begin
        case ({PRIMO, SECONDO}) 
          4'b0101, 4'b1010, 4'b1111: begin
            MANCHE_FSM = 2'b11;
            MOSSA_PRECEDENTE = 2'b00;
          end
          4'b0111, 4'b1001, 4'b1110, 4'b0100, 4'b1000, 4'b1100 : begin
            MANCHE_FSM = 2'b01;
            MOSSA_PRECEDENTE = {PRIMO};
          end
          4'b0110, 4'b1011, 4'b1101, 4'b0001, 4'b0010, 4'b0011: begin
            MANCHE_FSM = 2'b10;
            MOSSA_PRECEDENTE = {SECONDO};
          end
          4'b0000: begin
            MANCHE_FSM = 2'b00;
            MOSSA_PRECEDENTE = 2'b00;
          end
        endcase
        if (MANCHE_FSM != 2'b00) begin
          MANCHE_REG = MANCHE_FSM;
          CONTATORE = CONTATORE + 1;
        end
      end
              
      if (CONTATORE == 4)
        CMIN = 1'b1;
      if (CONTATORE == NUMERO_PARTITE) 
        CMAX = 1'b1;     
    end
    #10;
  end

  always @(posedge clk) begin : FSM
    if (!INIZIA) begin
      case (STATO)
        S0: begin
          MANCHE = MANCHE_FSM;
          case (MANCHE_FSM)
            2'b00: begin
              PARTITA = 2'b00;
              STATO_PROSSIMO = S0;
            end
            2'b01: begin
              if (CMAX) begin
                PARTITA = 2'b01;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S1;
              end
            end
            2'b10: begin
              if (CMAX) begin
                PARTITA = 2'b10;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S4;
              end
            end
            2'b11: begin
              if (CMAX) begin
                PARTITA = 2'b11;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S0;
              end
            end
          endcase
        end

        S1: begin
          MANCHE = MANCHE_FSM;
          case (MANCHE_FSM)
            2'b00: begin
              PARTITA = 2'b00;
              STATO_PROSSIMO = S1;
            end
            2'b01: begin
              if (CMAX || CMIN) begin
                PARTITA = 2'b01;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S2;
              end   
            end
            2'b10: begin
              if (CMAX) begin
                PARTITA = 2'b11;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S0;
              end
            end
            2'b11: begin
              if (CMAX) begin
                PARTITA = 2'b01;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S1;
              end
            end
          endcase
        end

        S2: begin
          MANCHE = MANCHE_FSM;
          case (MANCHE_FSM)
            2'b00: begin
              PARTITA = 2'b00;
              STATO_PROSSIMO = S2;
            end
            2'b01: begin
              if (CMAX) begin
                PARTITA = 2'b01;
                STATO_PROSSIMO = S7;
              end else begin
                if (CMIN) begin
                  PARTITA = 2'b01;
                  STATO_PROSSIMO = S7;
                end else begin
                  PARTITA = 2'b00;
                  STATO_PROSSIMO = S3;
                end
              end
            end
            2'b10: begin
              if (CMAX) begin
                PARTITA = 2'b01;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S1;
              end
            end
            2'b11: begin
              if (CMAX || CMIN) begin
                PARTITA = 2'b01;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S2;
              end
            end
          endcase
        end

        S3: begin
          MANCHE = MANCHE_FSM;
          case (MANCHE_FSM)
            2'b00: begin
              PARTITA = 2'b00;
              STATO_PROSSIMO = S3;
            end
            2'b01: begin
              PARTITA = 2'b01;
              STATO_PROSSIMO = S7;
            end
            2'b10: begin
              if (CMAX || CMIN) begin
                PARTITA = 2'b01;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S2;
              end
            end
            2'b11: begin
              if (CMAX || CMIN) begin
                PARTITA = 2'b01;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S3;
              end
            end
          endcase
        end

        S4: begin
          MANCHE = MANCHE_FSM;
          case (MANCHE_FSM)
            2'b00: begin
              PARTITA = 2'b00;
              STATO_PROSSIMO = S4;
            end
            2'b01: begin
              if (CMAX) begin
                PARTITA = 2'b11;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S0;
              end
            end
            2'b10: begin
              if (CMAX || CMIN) begin
                PARTITA = 2'b10;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S5;
              end 
            end
            2'b11: begin
              if (CMAX) begin
                PARTITA = 2'b10;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S4;
              end
            end
          endcase
        end

        S5: begin
          MANCHE = MANCHE_FSM;
          case(MANCHE_FSM)
            2'b00: begin
              PARTITA = 2'b00;
              STATO_PROSSIMO = S5;
            end
            2'b01: begin
              if (CMAX) begin
                PARTITA = 2'b10;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S4;
              end
            end
            2'b10: begin
              if (CMAX || CMIN) begin
                PARTITA = 2'b10;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S6;
              end
            end
            2'b11: begin
              if (CMAX || CMIN) begin
                PARTITA = 2'b10;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S5;
              end
            end
          endcase
        end

        S6: begin
          MANCHE = MANCHE_FSM;
          case(MANCHE_FSM)
            2'b00: begin
              PARTITA = 2'b00;
              STATO_PROSSIMO = S6;
            end
            2'b01: begin
              if (CMAX || CMIN) begin
                PARTITA = 2'b10;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S5;
              end
            end
            2'b10: begin
              if (CMAX || CMIN) begin
                PARTITA = 2'b10;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S6;
              end
            end
            2'b11: begin
              if (CMAX || CMIN) begin
                PARTITA = 2'b10;
                STATO_PROSSIMO = S7;
              end else begin
                PARTITA = 2'b00;
                STATO_PROSSIMO = S6;
              end
            end
          endcase
        end

        S7: begin
          STATO_PROSSIMO = S7;
          MANCHE = 2'b00;
          PARTITA = 2'b00;
        end
      endcase
    end else if (INIZIA) begin
      MANCHE = 2'b00;
      PARTITA = 2'b00;
      STATO_PROSSIMO = S0;
    end
  end
endmodule
