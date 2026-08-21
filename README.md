# Compiler Design Lab Programs

This repository contains the source code, Lex/Yacc specifications, and configurations for all 10 Compiler Design Lab experiments. It includes a helper script to build and execute all programs automatically.

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

## Detailed Experiment Guides

<details>
<summary><b>Experiment 1: Lexical Analyzer with Symbol Table</b></summary>

### Aim
To develop a lexical analyzer using FLEX to recognize tokens such as identifiers, constants, comments, and operators in a C program and to create a symbol table while recognizing identifiers.

### Algorithm
1. Start the program by including the necessary headers within the FLEX definitions section (`%{ ... %}`).
2. Define regular expressions for:
   - Identifiers: `[a-zA-Z_][a-zA-Z0-9_]*`
   - Constants: `[0-9]+`
   - Comments: `//.*` and `/* ... */`
   - Operators: `+ - * / = < >`
3. Declare a symbol table array (structure with `name` and `type` fields) in the definitions section.
4. Write rules in the rules section of the FLEX (`.l`) file:
   - When an identifier is recognized, call `insert()` to add it to the symbol table if not already present.
   - Print or categorize constants, operators, and comments as they are matched.
5. In `main()`, open the input file, call `yylex()`, then print the symbol table.
6. Compile the FLEX file using `flex` and `gcc`. Execute the program with a sample C code input file.

### Compilation & Execution
```bash
flex symtab.l
gcc lex.yy.c -o symtab
./symtab input.c
```

</details>

<details>
<summary><b>Experiment 2: Lexical Analyzer using LEX Tool</b></summary>

### Aim
The goal is to create a program that reads a C source code file and identifies individual tokens such as identifiers, keywords, constants, operators, preprocessor directives, header files and delimiters, using FLEX and its built-in regular expression matching.

### Algorithm
1. Start by defining patterns (using regular expressions) for each type of token (keywords, identifiers, numbers, operators, delimiters, etc.).
2. Set up a FLEX (`.l`) file with three parts:
   - Definitions
   - Rules
   - C code (`main` function)
3. In the rules section, match each pattern with an action (e.g., print "Keyword" if a keyword is found).
4. Compile the FLEX program using `flex` and `gcc` commands.
5. Run the compiled program and provide a C source code file as input.
6. The program scans the input and prints out each recognized token type.

### Compilation & Execution
```bash
flex lexer.l
gcc lex.yy.c -o lexer
./lexer iplex.c
```

</details>

<details>
<summary><b>Experiment 3: Valid Arithmetic Expression Recognizer</b></summary>

### Aim
To write a program to recognize a valid arithmetic expression that uses operators `+`, `-`, `*`, and `/` using FLEX and BISON.

### Algorithm
#### FLEX
1. Declare the required header file and variable declarations within `%{ ... %}`.
2. Define regular expressions to identify valid arithmetic expression tokens of lexemes (`ID`, `DIG`).
3. Return tokens to BISON.

#### BISON
1. Declare required header files and token declarations.
2. Define tokens (`ID`, `DIG`) and associativity/precedence of operators (`%left '+' '-'`, `%left '*' '/'`, `%right UMINUS`).
3. Mention grammar productions for expressions.
4. Call `yyparse()` in `main()` to initiate parsing.
5. `yyerror()` function is called when no productions in the grammar match the input statement.

### Compilation & Execution
```bash
flex art_expr.l
bison -d art_expr.y
gcc lex.yy.c art_expr.tab.c -o art_expr
./art_expr
```

</details>

<details>
<summary><b>Experiment 4: Valid Variable Recognizer</b></summary>

### Aim
To write a program to recognize a valid variable which starts with a letter followed by any number of letters or digits using FLEX and BISON.

### Algorithm
#### FLEX
1. Declare required header files and token header `valvar.tab.h`.
2. Define regular expressions:
   - Letters `[a-zA-Z]` -> return `LET`
   - Digits `[0-9]` -> return `DIG`

#### BISON
1. Declare token types `%token LET DIG`.
2. Define grammar rules for variable production:
   `var: var DIG | var LET | LET ;`
3. Call `yyparse()` in `main()`.
4. In `yyerror()`, print `"Invalid variable"`.

### Compilation & Execution
```bash
flex valvar.l
bison -d valvar.y
gcc lex.yy.c valvar.tab.c -o valvar
./valvar
```

</details>

<details>
<summary><b>Experiment 5: Control Structure Syntax Checker</b></summary>

### Aim
To write a program to recognize valid control structure syntax of C language (such as `for` loop, `while` loop, `if-else`, `if-else-if`, `switch-case`, etc.) using FLEX and BISON.

### Algorithm
#### FLEX
1. Include header files and token declarations.
2. Define regular expressions for control keywords (`if`, `else`, `for`, `while`, `switch`, `case`, `default`).
3. Return appropriate tokens to BISON.

#### BISON
1. Define grammar rules to match valid syntax for:
   - `if` statement and `if-else` ladder
   - `while` loop and `for` loop
   - `switch-case` structure
   - Compound statement blocks and assignments
2. Implement `yyparse()` in `main()` to trigger parsing.

### Compilation & Execution
```bash
flex control.l
bison -d control.y
gcc lex.yy.c control.tab.c -o control
./control
```

</details>

<details>
<summary><b>Experiment 6: Calculator using LEX and YACC</b></summary>

### Aim
To write a program to implement a Calculator using FLEX and BISON.

### Algorithm
1. In the FLEX file `cal.l`, define regular expressions for numbers (integers and floating-point values).
2. Store the token's numeric value in `yylval.dval` and return token `NUM`.
3. In BISON file `cal.y`, define `%union { double dval; }` to handle double precision arithmetic.
4. Set operator precedence and associativity: `%left '+' '-'`, `%left '*' '/'`, `%right UMINUS`.
5. Evaluate arithmetic operations (`+`, `-`, `*`, `/`) and print result using `%g`.
6. Display syntax error if the input fails to parse.

### Compilation & Execution
```bash
flex cal.l
bison -d cal.y
gcc lex.yy.c cal.tab.c -o calc
./calc
```

</details>

<details>
<summary><b>Experiment 7: Three Address Code (TAC) Generator</b></summary>

### Aim
To write a program using FLEX and BISON to generate three-address code (TAC) for a simple arithmetic expression.

### Algorithm
#### FLEX
1. Include headers and define tokens for identifiers (`ID`) and numbers (`NUM`).
2. Pass string values using `yylval.str = strdup(yytext)`.

#### BISON
1. Declare tokens and operator associativity (`%left '+' '-'`, `%left '*' '/'`).
2. Maintain a global `tempCount` variable to generate intermediate temporary variable names (`t1`, `t2`, etc.).
3. During expression reduction, emit three-address code instructions (e.g. `t1 = c * d`).
4. On statement completion, emit the final assignment (e.g. `a = t2`).

### Compilation & Execution
```bash
flex tac.l
bison -d tac.y
gcc lex.yy.c tac.tab.c -o tac
./tac
```

</details>

<details>
<summary><b>Experiment 8: Type Checking using LEX and YACC</b></summary>

### Aim
To write a program using FLEX and BISON to implement type checking of variables in simple declarations and expressions, using a symbol table built during parsing.

### Algorithm
1. Use FLEX to tokenize keywords (`int`, `float`), identifiers, numbers, and operators.
2. In BISON, define a symbol table structure storing `name` and `type`.
3. On a declaration statement (e.g. `int a;`), insert the variable name and type into the symbol table via `insert()`.
4. On assignment (e.g. `a = b * c;`), query `typeOf()` for left-hand side and right-hand side types.
5. If a variable is undeclared, output `"Undefined variable: <var>"`.
6. If operand types match, report `"No type mismatch in expression: <var> = ..."`; otherwise report `"Type mismatch in assignment to <var>"`.

### Compilation & Execution
```bash
flex typecheck.l
bison -d typecheck.y
gcc lex.yy.c typecheck.tab.c -o typecheck
./typecheck
```

</details>

<details>
<summary><b>Experiment 9: Simple Code Optimization Techniques</b></summary>

### Aim
To write a program using FLEX and BISON to implement simple code optimization techniques such as constant folding, strength reduction and algebraic simplification, applied while parsing three-address code style assignment statements.

### Algorithm
1. Use FLEX to tokenize input assignment statements.
2. In BISON semantic actions, evaluate optimization transformations:
   - **Constant Folding**: if both operands are numeric constants, compute the result at compile-time (e.g. `2 + 4 -> 6`).
   - **Algebraic Simplification**: simplify identity expressions (`x + 0 -> x`, `x - 0 -> x`, `x * 1 -> x`, `x / 1 -> x`).
   - **Strength Reduction**: replace expensive operations with cheaper ones (`x * 2 -> x + x`).
3. Print comments describing triggered optimizations alongside the simplified three-address code statement.

### Compilation & Execution
```bash
flex optimize.l
bison -d optimize.y
gcc lex.yy.c optimize.tab.c -o optimize
./optimize
```

</details>

<details>
<summary><b>Experiment 10: Compiler Back-end (8086 Assembly Generator)</b></summary>

### Aim
To write a program using FLEX and BISON to implement the back-end of a compiler which takes three-address code (TAC) as input and generates equivalent 8086 assembly language code.

### Algorithm
1. Use FLEX to tokenize TAC assignment statements into identifiers (`ID`) and operators (`=`, `+`, `-`, `*`, `/`, `;`).
2. In BISON semantic actions:
   - For initial operand, emit `MOV AX, operand`.
   - On `+`, emit `ADD AX, operand`.
   - On `-`, emit `SUB AX, operand`.
   - On `*`, emit `MUL operand`.
   - On `/`, emit `MOV DX, 0`, `MOV BX, operand`, `DIV BX`.
   - When the statement is reduced, emit `MOV target, AX`.
3. Process all input TAC lines and output the equivalent 8086 assembly instructions.

### Compilation & Execution
```bash
flex backend.l
bison -d backend.y
gcc lex.yy.c backend.tab.c -o backend
./backend
```

</details>

---

## Summary of Results

All 10 experiments have been implemented according to the laboratory manual specifications. The source files, lexer rules, bison context-free grammars, helper algorithms, and outputs have been validated with sample test cases.
