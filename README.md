# Compiler Design Lab Programs

This repository contains the source code and build configurations for all 10 Compiler Design Lab experiments.

---

## Quick Start & Automated Execution

You can compile and run all 10 experiments automatically using the provided PowerShell script [`run_all_experiments.ps1`](run_all_experiments.ps1):

```powershell
powershell -ExecutionPolicy Bypass -File .\run_all_experiments.ps1
```

### Prerequisites
- GCC (`gcc`)
- FLEX (`flex`)
- BISON (`bison`)

---

## Project Structure

```
Compiler Design Lab Assignment/
├── Experiment_01_Lexical_Analyzer_SymbolTable/
│   ├── symtab.l
│   └── input.c
├── Experiment_02_Lexical_Analyzer_Tokens/
│   ├── lexer.l
│   └── iplex.c
├── Experiment_03_Arithmetic_Expression_Parser/
│   ├── art_expr.l
│   └── art_expr.y
├── Experiment_04_Valid_Variable_Recognizer/
│   ├── valvar.l
│   └── valvar.y
├── Experiment_05_Control_Structure_Syntax_Checker/
│   ├── control.l
│   └── control.y
├── Experiment_06_Calculator_Lex_Yacc/
│   ├── cal.l
│   └── cal.y
├── Experiment_07_Three_Address_Code_Generator/
│   ├── tac.l
│   └── tac.y
├── Experiment_08_Type_Checking/
│   ├── typecheck.l
│   └── typecheck.y
├── Experiment_09_Code_Optimization/
│   ├── optimize.l
│   └── optimize.y
├── Experiment_10_Compiler_Backend_8086/
│   ├── backend.l
│   └── backend.y
├── run_all_experiments.ps1
└── README.md
```
