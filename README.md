## UART Controller in Verilog

# Overview

This project implements a Universal Asynchronous Receiver-Transmitter (UART) controller in Verilog. The design includes a baud rate generator, transmitter, receiver, and testbench for verification. The UART controller facilitates serial communication between digital systems.

# Features

Baud rate generation for precise timing

UART transmitter and receiver modules

Configurable data width and stop bits

FIFO buffer for efficient data handling

Testbench for functional verification

## File Structure

├── baudRateGenerator.v     # Baud rate generator module
├── defines.v               # Macro definitions
├── design.v                # Main UART design
├── testbench.v             # Testbench for simulation
├── uart_rx_controller.v    # UART receiver module
├── uart_tx_controller.v    # UART transmitter module
└── README.md               # Project documentation

# Setup & Simulation

Prerequisites

Ensure you have the following tools installed:

Icarus Verilog (iverilog) for compilation

GTKWave for waveform visualization

## Steps to Run the Simulation

Compile the Verilog files:

iverilog -o uart_testbench testbench.v

# Run the simulation:

vvp uart_testbench

View waveforms (optional):

gtkwave dump.vcd

# Configuration

Modify defines.v to configure baud rate, data bits, and other UART parameters:

`define CLOCK_FREQ 50000000  // 50 MHz clock
`define BAUD_RATE  115200    // Standard baud rate
`define DATA_BITS  8         // Number of data bits

# Contributing

Feel free to fork this repository and submit pull requests for improvements!
