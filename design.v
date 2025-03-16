`include "defines.v"
`include "baudRateGenerator.v"
`ifdef UART_TX_ONLY
`include "uart_tx_controller.v"
`elsif UART_RX_ONLY
`include "uart_rx_controller.v"
`else
`include "uart_tx_controller.v"
`include "uart_rx_controller.v"
`endif



module uartController #(parameter CLOCK_RATE=0,
                        parameter BAUD_RATE=0,
                        parameter RX_OVERSAMPLE = 1) (
    input clk,
    input reset_n,
`ifdef UART_TX_ONLY
input i_Tx_Ready,
input [7:0] i_Tx_Byte,
output o_Tx_Active,
output o_Tx_Data,
output o_Tx_Done,
`elsif UART_RX_ONLY
input i_Rx_Data,
output o_Rx_Done,
output [7:0] o_Rx_Byte
`else
input [7:0] i_Tx_Byte,
input i_Tx_Ready,
output [7:0] o_Rx_Byte,
output o_Rx_Done
`endif 
);

wire w_Rx_clktick;
wire w_Tx_clktick;
wire w_Tx_Data_to_Rx;

`ifdef UART_RX_ONLY
    assign w_Tx_Data_to_Rx = i_Rx_Data;
`elsif UART_TX_ONLY
    assign o_Tx_Data = w_Tx_Data_to_Rx;
`endif

baudRateGenerator #(CLOCK_RATE,BAUD_RATE,RX_OVERSAMPLE) xbaudRateGenerator(
    .clk(clk),
    .reset_n(reset_n),
    .o_Rx_clktick(w_Rx_clktick),
    .o_Tx_clktick(w_Tx_clktick)

);
    
`ifdef UART_TX_ONLY

uart_tx_controller xUART_TX(
    .clk(w_Tx_clktick),
    .reset_n(reset_n),
    .i_Tx_Byte(i_Tx_Byte),
    .i_Tx_Ready(i_Tx_Ready),
    .o_Tx_Done(o_Tx_Done),
    .o_Tx_Active(o_Tx_Active),
    .o_Tx_Data(w_Tx_Data_to_Rx)
);

`elsif UART_RX_ONLY

uart_rx_controller #(RX_OVERSAMPLE) xUART_RX(
    .clk(w_Rx_clktick),
    .reset_n(reset_n),
    .i_Rx_Data(w_Tx_Data_to_Rx),
    .o_Rx_Done(o_Rx_Done),
    .o_Rx_Byte(o_Rx_Byte)
)

`else 

uart_tx_controller xUART_TX(
    .clk(w_Tx_clktick),
    .reset_n(reset_n),
    .i_Tx_Byte(i_Tx_Byte),
    .i_Tx_Ready(i_Tx_Ready),
    .o_Tx_Done(),
    .o_Tx_Active(),
    .o_Tx_Data(w_Tx_Data_to_Rx)
);

uart_rx_controller #(RX_OVERSAMPLE) xUART_RX(
    .clk(w_Rx_clktick),
    .reset_n(reset_n),
    .i_Rx_Data(w_Tx_Data_to_Rx),
    .o_Rx_Done(o_Rx_Done),
    .o_Rx_Byte(o_Rx_Byte)
)

`endif 

endmodule