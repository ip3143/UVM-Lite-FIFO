# FIFO Verification Project (UVM-lite) 

This project implements and verifies a parameterized FIFO (First-In-First-Out) buffer using **SystemVerilog**. The design is simulated in **ModelSim** and verified using a simplified **UVM-lite** testbench architecture. It serves as a personal project for learning and showcasing key skills in RTL design, constrained-random verification, and modular testbench development.

## Features

### RTL Design
- Parameterized FIFO width and depth
- Synchronous read/write with `wr_en`, `rd_en` control signals
- `full` and `empty` status flags
- Optional: Combinational or registered output (`data_out`) for flexibility

### Testbench (UVM-lite Style)
- **Transaction-based stimulus** using a `fifo_transaction` class
- **Driver** pushes inputs onto the FIFO based on test vectors
- **Monitor** watches read activity and captures outputs
- **Scoreboard** compares actual FIFO outputs to expected data
- **Environment** wires up the driver, monitor, and scoreboard
- Supports both **directed** and **randomized** stimulus

## Tools Used

- **SystemVerilog**
- **ModelSim** for simulation and debugging

## How to Run the Simulation

1. Open ModelSim and create a project.
2. Add all `.sv` files to the project.
3. Ensure `+sv` is passed during compilation (`vlog +sv ...`) if using CLI.
4. Set `fifo_test` as the top-level module.
5. Run the simulation and view results in the waveform viewer or console output.

## Sample Output
PASS: Got expected data A0
PASS: Got expected data A1
PASS: Got expected data A2
PASS: Got expected data A3

(potential extra debugging messages)

## Concepts Demonstrated

- RTL design principles (FIFO logic, synchronous interfaces)
- UVM-style verification without full UVM overhead
- Mailbox communication and modular testbench construction
- Debugging via waveforms and scoreboard
- Handling off-by-one/timing delays in monitor logic
