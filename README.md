# Verilog FPGA Pong Game 🎮

A two-player Pong game implemented in Verilog for FPGA, featuring VGA display output, seven-segment timer display, and dot matrix scoreboards.

> **Course Project** - NCKU Digital System Experiments (數位系統實驗), Final Project, 2nd Year

## 📺 Demo

[![Demo Video](https://img.shields.io/badge/YouTube-Demo-red?logo=youtube)](https://youtu.be/Ks2PTz6LR7c?si=HQMXtv5yfV6o8Igq)

## ✨ Features

- **Two-Player Gameplay** - Compete against a friend in a classic game of Pong
- **VGA Display** - 640×480 output with real-time ball and paddle rendering
- **Seven-Segment Timer** - Countdown display for game duration
- **Dot Matrix Scoreboard** - 8×8 LED matrices showing player scores
- **Keypad Control** - 4×4 keypad input for paddle movement
- **FSM Game Logic** - State machine controlling game flow (new_game → play → new_ball → over)

## 🔧 Hardware Requirements

| Component | Specification |
|-----------|--------------|
| **FPGA Board** | Terasic DE0-CV |
| **FPGA Chip** | Intel Cyclone V 5CEFA4F23C7 |
| **Display** | VGA Monitor (640×480) |
| **Keypad** | 4×4 Matrix Keypad (NCKU DIC Lab custom board) |
| **Dot Matrix** | 8×8 LED Matrix ×2 (NCKU DIC Lab custom board) |
| **7-Segment Display** | On-board HEX displays |

## 📁 Project Structure

```
├── main.v                      # Top-level module
├── state_machine.v             # Game FSM (ball physics, collision detection)
├── vga_controller.v            # VGA timing generator
├── vga_driver.v                # VGA signal driver
├── graphics_gen.v              # Ball and paddle rendering
├── key_pad_controller.v        # 4×4 keypad scanner
├── dot_matrix_controller.v     # Score display on LED matrices
├── seven_display_controller.v  # Timer display on 7-segment
├── timer.v                     # Game countdown timer
├── fd_*.v                      # Frequency dividers (1Hz, 100Hz, 10kHz, 25MHz)
├── Sync.v                      # Synchronization module
├── two_sec_counter.v           # 2-second delay counter
└── pin_plan.tcl                # Pin assignments for DE0-CV
```

## 🚀 Getting Started

### Prerequisites

- Intel Quartus Prime (Lite Edition or higher)
- Terasic DE0-CV board with USB Blaster cable

### Build & Program

1. Clone this repository
   ```bash
   git clone https://github.com/HenryChang6/Verilog_FPGA_Pong_Game.git
   ```

2. Open Quartus Prime and create a new project targeting **5CEFA4F23C7**

3. Add all `.v` source files to the project

4. Import pin assignments
   ```tcl
   source pin_plan.tcl
   ```

5. Compile and program the FPGA

### Controls

| Key | Action |
|-----|--------|
| Player 1 Up | Keypad Row 1 |
| Player 1 Down | Keypad Row 2 |
| Player 2 Up | Keypad Row 3 |
| Player 2 Down | Keypad Row 4 |
| Start Game | Start Button |

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- NCKU DIC Lab for providing custom keypad and dot matrix boards
- Course instructors of Digital System Experiments