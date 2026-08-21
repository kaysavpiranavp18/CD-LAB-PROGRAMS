# CS4501 - COMPILER DESIGN LABORATORY MANUAL

**Institution:** Chennai Institute of Technology  
**Department:** Computer Science & Engineering  
**Course Code / Name:** CS4501 - Compiler Design  

---

## Table of Contents & Experiment Summary

| Ex. No. | Title of Experiment | Mapping | Status | Directory |
| :---: | :--- | :---: | :---: | :--- |
| **1** | [Lexical Analyzer with Symbol Table](Experiment_01_Lexical_Analyzer_SymbolTable) | CO1 | Complete | [`Experiment_01_Lexical_Analyzer_SymbolTable`](Experiment_01_Lexical_Analyzer_SymbolTable) |
| **2** | [Lexical Analyzer for C Tokens using LEX](Experiment_02_Lexical_Analyzer_Tokens) | CO1 | Complete | [`Experiment_02_Lexical_Analyzer_Tokens`](Experiment_02_Lexical_Analyzer_Tokens) |
| **3** | [Valid Arithmetic Expression Parser](Experiment_03_Arithmetic_Expression_Parser) | CO2 | Complete | [`Experiment_03_Arithmetic_Expression_Parser`](Experiment_03_Arithmetic_Expression_Parser) |
| **4** | [Valid Variable Recognizer](Experiment_04_Valid_Variable_Recognizer) | CO2 | Complete | [`Experiment_04_Valid_Variable_Recognizer`](Experiment_04_Valid_Variable_Recognizer) |
| **5** | [Control Structure Syntax Checker](Experiment_05_Control_Structure_Syntax_Checker) | CO2 | Complete | [`Experiment_05_Control_Structure_Syntax_Checker`](Experiment_05_Control_Structure_Syntax_Checker) |
| **6** | [Calculator using LEX and YACC](Experiment_06_Calculator_Lex_Yacc) | CO3 | Complete | [`Experiment_06_Calculator_Lex_Yacc`](Experiment_06_Calculator_Lex_Yacc) |
| **7** | [Three-Address Code (TAC) Generator](Experiment_07_Three_Address_Code_Generator) | CO3 | Complete | [`Experiment_07_Three_Address_Code_Generator`](Experiment_07_Three_Address_Code_Generator) |
| **8** | [Type Checking using LEX and YACC](Experiment_08_Type_Checking) | CO4 | Complete | [`Experiment_08_Type_Checking`](Experiment_08_Type_Checking) |
| **9** | [Code Optimization Techniques](Experiment_09_Code_Optimization) | CO4 | Complete | [`Experiment_09_Code_Optimization`](Experiment_09_Code_Optimization) |
| **10** | [Compiler Back-end (8086 Assembly Generator)](Experiment_10_Compiler_Backend_8086) | CO5 | Complete | [`Experiment_10_Compiler_Backend_8086`](Experiment_10_Compiler_Backend_8086) |

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

---

## Summary of Results

All 10 experiments have been implemented according to the CS4501 lab manual specifications. The source files, lexer rules, bison context-free grammars, helper algorithms, and outputs have been validated with sample test cases.
