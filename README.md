# Async FIFO with CDC, UVM & STA (Planned)

> **Status:** RTL in progress (write path partially implemented).  
> **Goal:** Build an industry-grade Async FIFO IP with correct CDC handling, UVM-based verification, and STA-aware synthesis results.

---

## 1. Project Overview
This project implements a **configurable asynchronous FIFO** supporting independent read and write clock domains. The design follows industry-standard CDC practices using Gray-coded pointers and multi-flop synchronizers, and is verified incrementally using waveform-based testing and later **UVM**. Timing closure and quality-of-results (QoR) are evaluated using **STA** after synthesis.

This repository is intentionally structured to scale from **basic RTL bring-up → UVM → STA → publishable IP-quality results**.

---

## 2. Repository Folder Structure

```
async_fifo/
│
├── rtl/                          # Synthesizable RTL source (source of truth)
│   ├── fifo_top.vhd              # Top-level FIFO module
│   ├── fifo_mem.vhd              # FIFO memory implementation
│   ├── fifo_ptr_ctrl.vhd         # Read/Write pointer logic
│   ├── fifo_sync.vhd             # CDC synchronizers (Gray pointers)
│   └── pkg_fifo.vhd              # Common types & utility functions
│
├── tb/                           # Directed (non-UVM) testbench
│   ├── tb_async_fifo.vhd
│   ├── tb_tasks.vhd
│   └── tb_pkg.vhd
│
├── uvm/                          # UVM verification environment (future)
│   ├── env/
│   ├── agents/
│   ├── sequences/
│   ├── scoreboard/
│   ├── tests/
│   └── top/
│
├── sim/                          # Simulation control files (instructions)
│   ├── modelsim/
│   │   ├── compile.do            # Compilation script
│   │   ├── simulate.do           # Simulation run script
│   │   └── wave.do               # Waveform setup
│   └── vivado/
│       └── sim.tcl               # Vivado simulation script
│
├── syn/                          # Synthesis & STA setup (instructions)
│   ├── constraints/
│   │   └── async_fifo.xdc        # Timing & CDC constraints
│   ├── scripts/
│   │   ├── run_syn.tcl           # Synthesis script
│   │   └── run_sta.tcl           # Static timing analysis script
│   └── reports/                  # (Optional) reference templates
│
├── scripts/                      # Project-level automation (entry points)
│   ├── run_sim.sh                # One-command simulation
│   ├── run_syn.sh                # One-command synthesis
│   └── clean.sh                  # Remove all generated files
│
├── build/                        # Tool-generated workspace (gitignored)
│   ├── sim/
│   │   └── modelsim/             # ModelSim work/, wlf, logs, vcd
│   ├── syn/
│   │   └── vivado/               # Vivado synthesis outputs
│   └── impl/
│       └── vivado/               # Place & route outputs
│
├── results/                      # Raw results (optional, usually gitignored)
│   ├── sim/                      # Raw simulation outputs
│   ├── syn/                      # Raw synthesis reports
│   └── impl/                     # Raw implementation reports
│
├── docs/                         # Curated, human-readable documentation
│   ├── architecture/             # Block diagrams, CDC explanation
│   ├── waveforms/                # Annotated waveform screenshots
│   ├── reports/                  # Cleaned timing/utilization summaries
│   └── notes.md                  # Design notes & observations
│
├── README.md                     # Project overview & results summary
├── .gitignore                    # Excludes build/, results/, tool junk
└── .gitkeep                      # (Optional) keep empty dirs tracked

```

---

## 3. Design Architecture

### 3.1 Key Features
- Independent **read/write clock domains**
- Gray-coded pointer based CDC
- Dual-flop synchronizers
- Full / Empty / (Planned) Almost-Full flags
- Parameterized depth and data width

### 3.2 CDC Strategy
- Binary pointers generated locally
- Gray-coded pointers synchronized across domains
- Gray → Binary conversion post-synchronization
- Full/Empty computed using synchronized pointers only

*(Add block diagram here in `/docs/architecture`)*

---

## 4. Verification Strategy

### 4.1 Phase 1 – Directed Testbench (Current)
- Clock-domain independent stimulus
- Write/read burst testing
- Wrap-around and boundary stress
- Manual waveform inspection

### 4.2 Phase 2 – UVM (Planned)
**Components:**
- Write Agent (Driver + Monitor)
- Read Agent (Driver + Monitor)
- Scoreboard with data integrity checks
- Functional coverage:
  - Wrap conditions
  - Empty → Non-empty transitions
  - Full → Non-full transitions

*(Place UVM diagrams and class hierarchy here later)*

---

## 5. Static Timing Analysis (STA) Plan

### Tools
- Vivado (primary)
- Constraints via XDC

### Focus Areas
- Synchronizer paths (CDC marked false paths)
- Write/read domain separation
- Setup / Hold margins

---

## 6. Results & Metrics (Placeholders)

> **NOTE:** These sections will be populated after UVM + STA completion.

### 6.1 Synthesis Results
| Metric | Value |
|------|------|
| LUTs | TBD |
| FFs | TBD |
| BRAM | TBD |
| Fmax | TBD |

### 6.2 Timing Summary
| Path | Slack |
|----|------|
| Write Domain | TBD |
| Read Domain | TBD |

### 6.3 Waveform Evidence
- Write wrap-around verification
- Read/write concurrency
- CDC stability

*(Waveforms stored in `/docs/waveforms`)*

---

## 7. Simulation Instructions

### ModelSim
```
do sim/modelsim/compile.do
do sim/modelsim/simulate.do
```

### Vivado
```
source sim/vivado/sim.tcl
```

---

## 8. Roadmap

- [x] RTL skeleton
- [x] Folder restructuring
- [x] README standardization
- [x] GitHub initial upload
- [ ] Correct read/write CDC handling (current)
- [ ] UVM verification
- [ ] STA & synthesis results
- [ ] Resume & portfolio update
- [ ] Log → Graph automation (Python)

---

## 9. Author
**Yusuf Ahmad**  
B.Tech ECE | RTL & VLSI Design  

---

> *This project is part of a long-term RTL IP portfolio targeting industry-grade design and verification roles.*

