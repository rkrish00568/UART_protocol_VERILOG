module baudRateGenerator #(parameter CLOCK_RATE=25000000,
                            parameter BAUD_RATE=115200,
                            parameter RX_OVERSAMPLE = 16)(
                                input clk,
                                input reset_n,
                                output reg o_Rx_clkTick,
                                output reg o_Tx_clkTick
                            );

    parameter TX_CNT = CLOCK_RATE/2*BAUD_RATE;
    parameter RX_CNT = CLOCK_RATE/2*BAUD_RATE*RX_OVERSAMPLE;
    parameter TX_CNT_WIDTH = $clog2(TX_CNT);
    parameter RX_CNT_WIDTH = $clog2(RX_CNT);

    reg [TX_CNT_WIDTH-1:0] r_Tx_Counter;
    reg [RX_CNT_WIDTH-1:0] r_Rx_Counter;

    // Rx Baud Rate

    always @(posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            o_Rx_clkTick <= 1'b0;
            r_Rx_Counter <= 0;
        end
        else if (r_Rx_Counter == RX_CNT -1) begin
            o_Rx_clkTick <= ~o_Rx_clkTick;
            r_Rx_Counter <= 0;
        end
        else begin
            r_Rx_Counter <= r_Rx_Counter+1;
        end

    end

    // Tx Baud Rate

    always @(posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            o_Tx_clkTick <= 1'b0;
            r_Tx_Counter <= 0;
        end
        else if (r_Tx_Counter == TX_CNT -1) begin
            o_Tx_clkTick <= ~o_Tx_clkTick;
            r_Tx_Counter <= 0;
        end
        else begin
            r_Tx_Counter <= r_Tx_Counter+1;
        end
    end
    