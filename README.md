# MiniJava to MIPS Compiler Pipeline

An end-to-end, multi-stage optimizing compiler for the **MiniJava** language implemented in **Java**. The compiler takes high-level source code with macros, performs semantic verification, lowers the code through multiple intermediate representations (IRs), performs register allocation, and generates executable **MIPS Assembly**.

---

## 📊 Pipeline Architecture

The compiler works as a sequential Unix-style pipeline where the output of each stage serves as standard input to the next:

---

## ⚙️ Compilation Stages

### Stage 1: Macro Expansion (`P1.l`, `P1.y`)
* **Tools**: Flex, Bison, C
* **Function**: Translates extended `MacroJava` constructs into standard `MiniJava` syntax via macro expansion and parsing.

### Stage 2: Type Checker & Semantic Analysis (`P2.java`)
* **Tools**: JavaCC, JTB (Java Tree Builder)
* **Function**: Performs scope resolution and semantic type checking using Visitor patterns. Identifies type mismatches or undeclared symbols.

### Stage 3: Intermediate Code Generation (`P3.java`)
* **Tools**: JavaCC, JTB
* **Function**: Translates validated MiniJava ASTs into **MiniIR** (High-level Intermediate Representation).

### Stage 4: IR Lowering / Simplification (`P4.java`)
* **Tools**: JavaCC, JTB
* **Function**: Lowers MiniIR constructs into simplified **MicroIR** to flatten complex expressions and control flow.

### Stage 5: Register Allocation (`P5.java`)
* **Tools**: JavaCC, JTB
* **Function**: Performs liveness analysis and linear-scan register allocation on MicroIR to map virtual registers to physical registers or stack spill slots (**MiniRA**).

### Stage 6: MIPS Assembly Generation (`P6.java`)
* **Tools**: JavaCC, JTB
* **Function**: Translates MiniRA into final, executable **MIPS Assembly** code (`.s`).

---

## 🛠️ Toolchain & Environment
* **Language**: Java, C
* **Parsers & Lexers**: JavaCC, JTB, Flex, Bison
* **Target Architecture**: MIPS Assembly
