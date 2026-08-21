# Compiler Design Lab Manual

This manual contains the detailed documentation, algorithms, source code, and outputs for all 10 Compiler Design Lab experiments.

---
## Experiment 1: Lexical Analyzer with Symbol Table

### AIM
To develop a lexical analyzer using FLEX to recognize tokens such as identifiers, constants, comments, and operators in a C program and to create a symbol table while recognizing identifiers.

### ALGORITHM
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

### CODE

#### `symtab.l`
```lex
%{
#include <stdio.h> 
#include <string.h> 
#include <stdlib.h>

struct symtab { 
    char name[30]; 
    int type;
} symtab[100]; 

int sc = 0;

int lookup(char *s) { 
    int i;
    for (i = 0; i < sc; i++) {
        if (strcmp(symtab[i].name, s) == 0) 
            return i;
    }
    return -1;
}

void insert(char *s) {
    if (lookup(s) == -1) { 
        strcpy(symtab[sc].name, s); 
        symtab[sc].type = 1;
        sc++;
    }
}
%}

DIGIT [0-9]
ID [a-zA-Z_][a-zA-Z0-9_]*

%%
"/*"([^*]|\*+[^*/])*\*+"/" { printf("Comment    : %s\n", yytext); } 
"//".*                    { printf("Comment    : %s\n", yytext); }
{ID}                       { insert(yytext); printf("Identifier : %s\n", yytext); }
{DIGIT}+                   { printf("Constant   : %s\n", yytext); } 
"+"|"-"|"*"|"/"|"="|"<"|">" { printf("Operator   : %s\n", yytext); } 
[ \t\n]                    { /* skip whitespace */ }
.                          { /* ignore other characters */ }
%%

int yywrap() { return 1; }

int main(int argc, char *argv[]) { 
    if (argc < 2) {
        printf("Usage: %s <input file>\n", argv[0]); 
        return 1;
    }
    yyin = fopen(argv[1], "r"); 
    if (!yyin) {
        printf("Cannot open file %s\n", argv[1]); 
        return 1;
    }
    yylex();
    printf("\nSYMBOL TABLE\n"); 
    printf("S.No\tName\n");
    int i;
    for (i = 0; i < sc; i++)
        printf("%d\t%s\n", i + 1, symtab[i].name);
    fclose(yyin);
    return 0;
}
```

#### `input.c`
```c
int a = 10; // sum variable 
b = a + 5;
```

### COMPILATION & EXECUTION
```bash
flex symtab.l
gcc lex.yy.c -o symtab
./symtab input.c
```

### OUTPUT
```text
Identifier : int
Identifier : a
Operator   : =
Constant   : 10
Comment    : // sum variable 
Identifier : b
Operator   : =
Identifier : a
Operator   : +
Constant   : 5

SYMBOL TABLE
S.No	Name
1	int
2	a
3	b
```

### RESULT
Thus the FLEX program to develop a lexical analyzer recognizing identifiers, constants, comments and operators, and to build a symbol table, was executed and verified successfully.


---\n
## Experiment 2: Lexical Analyzer using LEX Tool

### AIM
The goal is to create a program that reads a C source code file and identifies individual tokens such as identifiers, keywords, constants, operators, preprocessor directives, header files and delimiters, using FLEX and its built-in regular expression matching.

### ALGORITHM
1. Start by defining patterns (using regular expressions) for each type of token (keywords, identifiers, numbers, operators, delimiters, etc.).
2. Set up a FLEX (`.l`) file with three parts:
   - Definitions
   - Rules
   - C code (`main` function)
3. In the rules section, match each pattern with an action (e.g., print "Keyword" if a keyword is found).
4. Compile the FLEX program using `flex` and `gcc` commands.
5. Run the compiled program and provide a C source code file as input.
6. The program scans the input and prints out each recognized token type.

### CODE

#### `lexer.l`
```lex
%{
#include <stdio.h>
%}

KEYWORD int|float|char|double|void|for|while|if|else|return|struct|switch|case|break|do

%%
"#include"              { printf("Preprocessor Directive : %s\n", yytext); } 
"<"[a-zA-Z.]+">"        { printf("Header File            : %s\n", yytext); }
{KEYWORD}               { printf("Keyword                : %s\n", yytext); } 
[a-zA-Z_][a-zA-Z0-9_]*  { printf("Identifier             : %s\n", yytext); } 
[0-9]+                  { printf("Number                 : %s\n", yytext); }
"=="|"<="|">="          { printf("Operator               : %s\n", yytext); } 
"+"|"-"|"*"|"/"|"="|"<"|">" { printf("Operator           : %s\n", yytext); }
[(){};,]                { printf("Delimiter              : %s\n", yytext); } 
[ \t\n]                 { /* skip whitespace */ }
.                       { /* ignore rest */ }
%%

int yywrap() { return 1; }

int main(int argc, char *argv[]) { 
    if (argc < 2) {
        printf("Usage: %s <input file>\n", argv[0]); 
        return 1;
    }
    yyin = fopen(argv[1], "r"); 
    if (!yyin) {
        printf("Cannot open file %s\n", argv[1]); 
        return 1;
    }
    yylex();
    printf("\nEnd of file\n"); 
    fclose(yyin);
    return 0;
}
```

#### `iplex.c`
```c
#include<stdio.h>
void main()
{
int x; 
x = 10;
}
```

### COMPILATION & EXECUTION
```bash
flex lexer.l
gcc lex.yy.c -o lexer
./lexer iplex.c
```

### OUTPUT
```text
Preprocessor Directive : #include
Header File            : <stdio.h>
Keyword                : void
Identifier             : main
Delimiter              : (
Delimiter              : )
Delimiter              : {
Keyword                : int
Identifier             : x
Delimiter              : ;
Identifier             : x
Operator               : =
Number                 : 10
Delimiter              : ;
Delimiter              : }

End of file
```

### RESULT
Thus, the FLEX program for implementation of a Lexical Analyzer was executed and verified successfully.


---\n
## Experiment 3: Valid Arithmetic Expression Recognizer

### AIM
To write a program to recognize a valid arithmetic expression that uses operators `+`, `-`, `*`, and `/` using FLEX and BISON.

### ALGORITHM

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

### CODE

#### `art_expr.l`
```lex
%{
#include <stdio.h>
#include "art_expr.tab.h"
%}

%%
[a-zA-Z][0-9a-zA-Z]* { return ID; } 
[0-9]+               { return DIG; }
[ \t]+               { ; }
.                    { return yytext[0]; }
\n                   { return 0; }
%%

int yywrap() { 
    return 1;
}
```

#### `art_expr.y`
```yacc
%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(const char *s);
%}

%token ID DIG
%left '+' '-'
%left '*' '/'
%right UMINUS

%%
stmt: expn ;
expn: expn '+' expn 
    | expn '-' expn 
    | expn '*' expn 
    | expn '/' expn 
    | '-' expn %prec UMINUS 
    | '(' expn ')' 
    | DIG 
    | ID;
%%

int main() {
    printf("Enter the Expression\n"); 
    yyparse();
    printf("valid Expression\n"); 
    return 0;
}

int yyerror(const char *s) { 
    printf("Invalid Expression\n"); 
    exit(0);
}
```

### COMPILATION & EXECUTION
```bash
flex art_expr.l
bison -d art_expr.y
gcc lex.yy.c art_expr.tab.c -o art_expr
./art_expr
```

### SAMPLE RUN & OUTPUT

#### Test 1 (Valid)
Input: `a+b*c-d/e`
Output:
```text
Enter the Expression
valid Expression
```

#### Test 2 (Invalid)
Input: `a=b`
Output:
```text
Enter the Expression
Invalid Expression
```

### RESULT
Thus the program to recognize a valid arithmetic expression that uses operators `+`, `-`, `*` and `/` using FLEX and BISON was executed and verified successfully.


---\n
## Experiment 4: Valid Variable Recognizer

### AIM
To write a program to recognize a valid variable which starts with a letter followed by any number of letters or digits using FLEX and BISON.

### ALGORITHM

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

### CODE

#### `valvar.l`
```lex
%{
#include "valvar.tab.h"
%}

%%
[a-zA-Z] { return LET; }
[0-9]    { return DIG; }
\n       { return 0; }
.        { return yytext[0]; }
%%

int yywrap() { 
    return 1;
}
```

#### `valvar.y`
```yacc
%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(const char *s);
%}

%token LET DIG

%%
variable: var ;
var: var DIG | var LET | LET ;
%%

int main() {
    printf("Enter the variable:\n"); 
    yyparse();
    printf("Valid variable\n"); 
    return 0;
}

int yyerror(const char *s) { 
    printf("Invalid variable\n"); 
    exit(0);
}
```

### COMPILATION & EXECUTION
```bash
flex valvar.l
bison -d valvar.y
gcc lex.yy.c valvar.tab.c -o valvar
./valvar
```

### SAMPLE RUN & OUTPUT

#### Case 1
Input: `add`
Output:
```text
Enter the variable:
Valid variable
```

#### Case 2
Input: `add1`
Output:
```text
Enter the variable:
Valid variable
```

#### Case 3
Input: `1add`
Output:
```text
Enter the variable:
Invalid variable
```

### RESULT
Thus the program to recognize a valid variable which starts with a letter followed by any number of letters or digits using FLEX and BISON was executed and verified successfully.


---\n
## Experiment 5: Control Structure Syntax Checker

### AIM
To write a program to recognize valid control structure syntax of C language (such as `for` loop, `while` loop, `if-else`, `if-else-if`, `switch-case`, etc.) using FLEX and BISON.

### ALGORITHM

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

### CODE

#### `control.l`
```lex
%{
#include "control.tab.h"
%}

%%
"if"                    { return IF; } 
"else"                  { return ELSE; } 
"for"                   { return FOR; } 
"while"                 { return WHILE; }
"switch"                { return SWITCH; } 
"case"                  { return CASE; } 
"default"               { return DEFAULT; }
[a-zA-Z_][a-zA-Z0-9_]* { return ID; } 
[0-9]+                  { return NUM; }
"{"                     { return LBRACE; }
"}"                     { return RBRACE; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }
":"                     { return COLON; }
";"                     { return SEMICOLON; }
"=="                    { return EQ; }
"<="                    { return LE; }
">="                    { return GE; }
"<"                     { return LT; }
">"                     { return GT; }
"="                     { return ASSIGN; }
[ \t\n]                 { /* skip whitespace */ }
.                       { return yytext[0]; }
%%

int yywrap() { return 1; }
```

#### `control.y`
```yacc
%{
#include <stdio.h> 
#include <stdlib.h>

int yylex(void);
int yyerror(const char *s);
%}

%token IF ELSE FOR WHILE SWITCH CASE DEFAULT
%token ID NUM
%token LBRACE RBRACE LPAREN RPAREN COLON SEMICOLON
%token EQ LE GE LT GT ASSIGN

%%
program:
stmt_list
;

stmt_list:
stmt_list stmt
| stmt
;

stmt:
if_stmt
| while_stmt
| for_stmt
| switch_stmt
| ID ASSIGN NUM SEMICOLON
| ID ASSIGN ID SEMICOLON
| LBRACE stmt_list RBRACE
| LBRACE RBRACE
| SEMICOLON
;

if_stmt:
IF LPAREN cond RPAREN stmt
| IF LPAREN cond RPAREN stmt ELSE stmt
;

while_stmt:
WHILE LPAREN cond RPAREN stmt
;

for_stmt:
FOR LPAREN ID ASSIGN NUM SEMICOLON cond SEMICOLON ID ASSIGN ID RPAREN stmt
;

switch_stmt:
SWITCH LPAREN ID RPAREN LBRACE case_list RBRACE
;

case_list:
case_list CASE NUM COLON stmt
| case_list DEFAULT COLON stmt
| CASE NUM COLON stmt
| DEFAULT COLON stmt
;

cond:
ID relop NUM
| ID relop ID
;

relop:
EQ | LE | GE | LT | GT
;

%%

int main() {
    printf("Enter a C control structure syntax:\n"); 
    yyparse();
    printf("Valid control structure syntax.\n"); 
    return 0;
}

int yyerror(const char *s) {
    printf("Invalid control structure syntax.\n"); 
    exit(0);
}
```

### COMPILATION & EXECUTION
```bash
flex control.l
bison -d control.y
gcc lex.yy.c control.tab.c -o control
./control
```

### SAMPLE RUN & OUTPUT
Input:
```c
if (x < 5) { y = 10; }
```
Output:
```text
Enter a C control structure syntax:
Valid control structure syntax.
```

### RESULT
Thus the program to recognize a valid control structure syntax of C language (For loop, while loop, if-else, if-else-if, switch-case, etc.) using FLEX and BISON was executed and verified successfully.


---\n
## Experiment 6: Calculator using LEX and YACC

### AIM
To write a program to implement a Calculator using FLEX and BISON.

### ALGORITHM
1. In the FLEX file `cal.l`, define regular expressions for numbers (integers and floating-point values).
2. Store the token's numeric value in `yylval.dval` and return token `NUM`.
3. In BISON file `cal.y`, define `%union { double dval; }` to handle double precision arithmetic.
4. Set operator precedence and associativity: `%left '+' '-'`, `%left '*' '/'`, `%right UMINUS`.
5. Evaluate arithmetic operations (`+`, `-`, `*`, `/`) and print result using `%g`.
6. Display syntax error if the input fails to parse.

### CODE

#### `cal.l`
```lex
%{
#include <stdlib.h>
#include "cal.tab.h"
%}

DIGIT [0-9]+(\.[0-9]+)?
%option noyywrap

%%
{DIGIT} { yylval.dval = atof(yytext); return NUM; }
[ \t]   { /* skip whitespace */ }
\n      { return '\n'; }
.       { return yytext[0]; }
%%
```

#### `cal.y`
```yacc
%{
#include <ctype.h> 
#include <stdio.h> 
#include <stdlib.h>

int yylex(void);
int yyerror(const char *s);
%}

%union {
    double dval;
}

%token <dval> NUM
%type <dval> E

%left '+' '-'
%left '*' '/'
%right UMINUS

%%
Statment: E { printf("Answer: %g\n", $1); }
| Statment '\n'
;

E : E '+' E { $$ = $1 + $3; }
| E '-' E   { $$ = $1 - $3; }
| E '*' E   { $$ = $1 * $3; }
| E '/' E   { $$ = $1 / $3; }
| NUM       { $$ = $1; }
;

%%

int main() {
    printf("Enter the expression:\n"); 
    yyparse();
    return 0;
}

int yyerror(const char *s) { 
    printf("%s\n", s); 
    return 0;
}
```

### COMPILATION & EXECUTION
```bash
flex cal.l
bison -d cal.y
gcc lex.yy.c cal.tab.c -o calc
./calc
```

### SAMPLE RUN & OUTPUT
Input:
```text
2+2
```
Output:
```text
Enter the expression:
Answer: 4
```

### RESULT
Thus the program for implementing a calculator using FLEX and BISON was executed and verified successfully.


---\n
## Experiment 7: Three Address Code (TAC) Generator

### AIM
To write a program using FLEX and BISON to generate three-address code (TAC) for a simple arithmetic expression.

### ALGORITHM

#### FLEX
1. Include headers and define tokens for identifiers (`ID`) and numbers (`NUM`).
2. Pass string values using `yylval.str = strdup(yytext)`.

#### BISON
1. Declare tokens and operator associativity (`%left '+' '-'`, `%left '*' '/'`).
2. Maintain a global `tempCount` variable to generate intermediate temporary variable names (`t1`, `t2`, etc.).
3. During expression reduction, emit three-address code instructions (e.g. `t1 = c * d`).
4. On statement completion, emit the final assignment (e.g. `a = t2`).

### CODE

#### `tac.l`
```lex
%{
#include <string.h>
#include "tac.tab.h" 
%}

%%
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return ID; } 
[0-9]+               { yylval.str = strdup(yytext); return NUM; }
[\t\n ]+             { /* skip spaces */ }
.                    { return yytext[0]; }
%%

int yywrap() { 
    return 1;
}
```

#### `tac.y`
```yacc
%{
#include <stdio.h> 
#include <stdlib.h> 
#include <string.h> 

int tempCount = 1; 
char temp[10];

int yylex(void);
int yyerror(const char *s);
%}

%union { char *str; }
%token <str> ID NUM
%type <str> expr
%left '+' '-'
%left '*' '/'

%%
stmt: ID '=' expr { printf("%s = %s\n", $1, $3); }
;

expr: expr '+' expr { 
    sprintf(temp, "t%d", tempCount++);
    printf("%s = %s + %s\n", temp, $1, $3);
    $$ = strdup(temp);
}
| expr '-' expr {
    sprintf(temp, "t%d", tempCount++); 
    printf("%s = %s - %s\n", temp, $1, $3);
    $$ = strdup(temp);
}
| expr '*' expr {
    sprintf(temp, "t%d", tempCount++); 
    printf("%s = %s * %s\n", temp, $1, $3);
    $$ = strdup(temp);
}
| expr '/' expr {
    sprintf(temp, "t%d", tempCount++); 
    printf("%s = %s / %s\n", temp, $1, $3);
    $$ = strdup(temp);
}
| ID { $$ = $1; }
| NUM { $$ = $1; }
;

%%

int main() {
    printf("Enter the expression:\n"); 
    yyparse();
    return 0;
}

int yyerror(const char* s) { 
    printf("Error: %s\n", s); 
    return 0;
}
```

### COMPILATION & EXECUTION
```bash
flex tac.l
bison -d tac.y
gcc lex.yy.c tac.tab.c -o tac
./tac
```

### SAMPLE RUN & OUTPUT
Input:
```text
a = b + c * d
```
Output:
```text
Enter the expression:
t1 = c * d
t2 = b + t1
a = t2
```

### RESULT
Thus, the program to generate three-address code using FLEX and BISON was executed and verified successfully.


---\n
## Experiment 8: Type Checking using LEX and YACC

### AIM
To write a program using FLEX and BISON to implement type checking of variables in simple declarations and expressions, using a symbol table built during parsing.

### ALGORITHM
1. Use FLEX to tokenize keywords (`int`, `float`), identifiers, numbers, and operators.
2. In BISON, define a symbol table structure storing `name` and `type`.
3. On a declaration statement (e.g. `int a;`), insert the variable name and type into the symbol table via `insert()`.
4. On assignment (e.g. `a = b * c;`), query `typeOf()` for left-hand side and right-hand side types.
5. If a variable is undeclared, output `"Undefined variable: <var>"`.
6. If operand types match, report `"No type mismatch in expression: <var> = ..."`; otherwise report `"Type mismatch in assignment to <var>"`.

### CODE

#### `typecheck.l`
```lex
%{
#include <string.h> 
#include <stdlib.h>
#include "typecheck.tab.h" 
%}

%%
"int"                  { return INT; }
"float"                { return FLOAT; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return ID; } 
[0-9]+                 { yylval.str = strdup(yytext); return NUM; }
"="                    { return '='; }
"+"                    { return '+'; }
"-"                    { return '-'; }
"*"                    { return '*'; }
"/"                    { return '/'; }
";"                    { return ';'; }
[ \t\n]                { /* skip whitespace */ }
.                      { return yytext[0]; }
%%

int yywrap() { return 1; }
```

#### `typecheck.y`
```yacc
%{
#include <stdio.h> 
#include <string.h> 
#include <stdlib.h>

struct sym { 
    char name[20]; 
    char type[10]; 
} table[50]; 

int n = 0;

void insert(char *name, char *type) { 
    strcpy(table[n].name, name); 
    strcpy(table[n].type, type);
    n++;
}

char* typeOf(char *name) { 
    int i;
    for (i = 0; i < n; i++) {
        if (strcmp(table[i].name, name) == 0) 
            return table[i].type;
    }
    return "undefined";
}

int yylex(void);
int yyerror(const char *s);
%}

%union { char *str; }
%token <str> ID NUM
%token INT FLOAT
%type <str> expr

%%
program: stmts ;
stmts: stmts stmt | stmt ; 
stmt: decl | assign ; 

decl:
INT ID ';' { insert($2, "int"); }
| FLOAT ID ';' { insert($2, "float"); }
;

assign:
ID '=' expr ';' {
    char *lt = typeOf($1);
    if (strcmp(lt, "undefined") == 0) 
        printf("Undefined variable: %s\n", $1);
    else if (strcmp(lt, $3) == 0)
        printf("No type mismatch in expression: %s = ...\n", $1);
    else
        printf("Type mismatch in assignment to %s\n", $1);
}
;

expr:
ID {
    char *t = typeOf($1);
    if (strcmp(t, "undefined") == 0) 
        printf("Undefined variable: %s\n", $1);
    $$ = t;
}
| NUM { $$ = "int"; }
| expr '+' expr { $$ = (strcmp($1, $3) == 0) ? $1 : "mismatch"; }
| expr '-' expr { $$ = (strcmp($1, $3) == 0) ? $1 : "mismatch"; }
| expr '*' expr { $$ = (strcmp($1, $3) == 0) ? $1 : "mismatch"; }
| expr '/' expr { $$ = (strcmp($1, $3) == 0) ? $1 : "mismatch"; }
;

%%

int main() {
    printf("Enter declarations and expressions:\n"); 
    yyparse();
    return 0;
}

int yyerror(const char *s) { 
    printf("Syntax Error: %s\n", s); 
    return 0;
}
```

### COMPILATION & EXECUTION
```bash
flex typecheck.l
bison -d typecheck.y
gcc lex.yy.c typecheck.tab.c -o typecheck
./typecheck
```

### SAMPLE RUN & OUTPUT

#### Case 1: Matching Types
Input:
```c
int a;
int b;
int c;
a = b * c;
```
Output:
```text
Enter declarations and expressions:
No type mismatch in expression: a = ...
```

#### Case 2: Type Mismatch
Input:
```c
int a;
float b;
int c;
a = b + c;
```
Output:
```text
Enter declarations and expressions:
Type mismatch in assignment to a
```

### RESULT
Thus, the FLEX and BISON program for type checking was successfully implemented. The program builds a symbol table from declarations and checks type consistency in assignment expressions.


---\n
## Experiment 9: Simple Code Optimization Techniques

### AIM
To write a program using FLEX and BISON to implement simple code optimization techniques such as constant folding, strength reduction and algebraic simplification, applied while parsing three-address code style assignment statements.

### ALGORITHM
1. Use FLEX to tokenize input assignment statements.
2. In BISON semantic actions, evaluate optimization transformations:
   - **Constant Folding**: if both operands are numeric constants, compute the result at compile-time (e.g. `2 + 4 -> 6`).
   - **Algebraic Simplification**: simplify identity expressions (`x + 0 -> x`, `x - 0 -> x`, `x * 1 -> x`, `x / 1 -> x`).
   - **Strength Reduction**: replace expensive operations with cheaper ones (`x * 2 -> x + x`).
3. Print comments describing triggered optimizations alongside the simplified three-address code statement.

### CODE

#### `optimize.l`
```lex
%{
#include <string.h> 
#include <stdlib.h>
#include "optimize.tab.h" 
%}

%%
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return ID; } 
[0-9]+               { yylval.str = strdup(yytext); return NUM; }
"="                    { return '='; }
"+"                    { return '+'; }
"-"                    { return '-'; }
"*"                    { return '*'; }
"/"                    { return '/'; }
";"                    { return ';'; }
[ \t\n]                { /* skip whitespace */ }
.                      { return yytext[0]; }
%%

int yywrap() { return 1; }
```

#### `optimize.y`
```yacc
%{
#include <stdio.h> 
#include <string.h> 
#include <stdlib.h> 
#include <ctype.h>

int yylex(void);
int yyerror(const char *s);
%}

%union { char *str; }
%token <str> ID NUM
%type <str> expr
%left '+' '-'
%left '*' '/'

%%
stmt_list: stmt_list stmt | stmt ;
stmt: ID '=' expr ';' { printf("%s = %s\n", $1, $3); } ; 

expr:
NUM { $$ = $1; }
| ID { $$ = $1; }
| expr '+' expr {
    if (isdigit($1[0]) && isdigit($3[0])) { 
        char buf[20];
        sprintf(buf, "%d", atoi($1) + atoi($3));
        $$ = strdup(buf);
        printf("// Constant Folding: %s + %s -> %s\n", $1, $3, $$);
    } else if (strcmp($3, "0") == 0) {
        $$ = $1;
        printf("// Algebraic Simplification: x + 0 -> x\n");
    } else if (strcmp($1, "0") == 0) {
        $$ = $3;
        printf("// Algebraic Simplification: 0 + x -> x\n");
    } else {
        char buf[40];
        sprintf(buf, "%s + %s", $1, $3);
        $$ = strdup(buf);
    }
}
| expr '-' expr {
    if (isdigit($1[0]) && isdigit($3[0])) { 
        char buf[20];
        sprintf(buf, "%d", atoi($1) - atoi($3));
        $$ = strdup(buf);
        printf("// Constant Folding: %s - %s -> %s\n", $1, $3, $$);
    } else if (strcmp($3, "0") == 0) {
        $$ = $1;
        printf("// Algebraic Simplification: x - 0 -> x\n");
    } else {
        char buf[40];
        sprintf(buf, "%s - %s", $1, $3);
        $$ = strdup(buf);
    }
}
| expr '*' expr {
    if (isdigit($1[0]) && isdigit($3[0])) { 
        char buf[20];
        sprintf(buf, "%d", atoi($1) * atoi($3));
        $$ = strdup(buf);
        printf("// Constant Folding: %s * %s -> %s\n", $1, $3, $$);
    } else if (strcmp($3, "1") == 0) {
        $$ = $1;
        printf("// Algebraic Simplification: x * 1 -> x\n");
    } else if (strcmp($3, "2") == 0) { 
        char buf[40];
        sprintf(buf, "%s + %s", $1, $1);
        $$ = strdup(buf);
        printf("// Strength Reduction: x * 2 -> x + x\n");
    } else {
        char buf[40];
        sprintf(buf, "%s * %s", $1, $3);
        $$ = strdup(buf);
    }
}
| expr '/' expr {
    if (isdigit($1[0]) && isdigit($3[0])) { 
        char buf[20];
        sprintf(buf, "%d", atoi($1) / atoi($3));
        $$ = strdup(buf);
        printf("// Constant Folding: %s / %s -> %s\n", $1, $3, $$);
    } else if (strcmp($3, "1") == 0) {
        $$ = $1;
        printf("// Algebraic Simplification: x / 1 -> x\n");
    } else {
        char buf[40];
        sprintf(buf, "%s / %s", $1, $3);
        $$ = strdup(buf);
    }
}
;

%%

int main() {
    printf("Enter Three Address Code statements (end with Ctrl+D):\n"); 
    yyparse();
    return 0;
}

int yyerror(const char *s) { 
    printf("Syntax Error: %s\n", s); 
    return 0;
}
```

### COMPILATION & EXECUTION
```bash
flex optimize.l
bison -d optimize.y
gcc lex.yy.c optimize.tab.c -o optimize
./optimize
```

### SAMPLE RUN & OUTPUT
Input:
```c
a = 2 + 4;
b = d * 1;
c = s * 2;
```
Output:
```text
Enter Three Address Code statements (end with Ctrl+D):
// Constant Folding: 2 + 4 -> 6
a = 6
// Algebraic Simplification: x * 1 -> x
b = d
// Strength Reduction: x * 2 -> x + x
c = s + s
```

### RESULT
Thus, the FLEX and BISON program for simple code optimization techniques - constant folding, strength reduction, and algebraic simplification - was successfully implemented and tested with various inputs.


---\n
## Experiment 10: Compiler Back-end (8086 Assembly Generator)

### AIM
To write a program using FLEX and BISON to implement the back-end of a compiler which takes three-address code (TAC) as input and generates equivalent 8086 assembly language code.

### ALGORITHM
1. Use FLEX to tokenize TAC assignment statements into identifiers (`ID`) and operators (`=`, `+`, `-`, `*`, `/`, `;`).
2. In BISON semantic actions:
   - For initial operand, emit `MOV AX, operand`.
   - On `+`, emit `ADD AX, operand`.
   - On `-`, emit `SUB AX, operand`.
   - On `*`, emit `MUL operand`.
   - On `/`, emit `MOV DX, 0`, `MOV BX, operand`, `DIV BX`.
   - When the statement is reduced, emit `MOV target, AX`.
3. Process all input TAC lines and output the equivalent 8086 assembly instructions.

### CODE

#### `backend.l`
```lex
%{
#include <string.h> 
#include <stdlib.h>
#include "backend.tab.h" 
%}

%%
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return ID; } 
"="                    { return '='; }
"+"                    { return '+'; }
"-"                    { return '-'; }
"*"                    { return '*'; }
"/"                    { return '/'; }
";"                    { return ';'; }
[ \t\n]                { /* skip whitespace */ }
.                      { return yytext[0]; }
%%

int yywrap() { return 1; }
```

#### `backend.y`
```yacc
%{
#include <stdio.h> 
#include <string.h> 
#include <stdlib.h>

int yylex(void);
int yyerror(const char *s);
%}

%union { char *str; }
%token <str> ID
%type <str> expr
%left '+' '-'
%left '*' '/'

%%
stmt_list: stmt_list stmt | stmt ;
stmt: ID '=' expr ';' { printf("MOV %s, AX\n\n", $1); } ; 

expr:
ID { printf("MOV AX, %s\n", $1); $$ = $1; }
| expr '+' ID { printf("ADD AX, %s\n", $3); $$ = $3; }
| expr '-' ID { printf("SUB AX, %s\n", $3); $$ = $3; }
| expr '*' ID { printf("MUL %s\n", $3); $$ = $3; }
| expr '/' ID { printf("MOV DX, 0\nMOV BX, %s\nDIV BX\n", $3); $$ = $3; }
;

%%

int main() {
    printf("Enter TAC statements (end with Ctrl+D):\n"); 
    yyparse();
    return 0;
}

int yyerror(const char *s) { 
    printf("Syntax Error: %s\n", s); 
    return 0;
}
```

### COMPILATION & EXECUTION
```bash
flex backend.l
bison -d backend.y
gcc lex.yy.c backend.tab.c -o backend
./backend
```

### SAMPLE RUN & OUTPUT
Input:
```text
t1 = a + b;
t2 = t1 - c;
t3 = t2 * d;
t4 = t3 / e;
x = t4;
```
Output:
```text
Enter TAC statements (end with Ctrl+D):
MOV AX, a
ADD AX, b
MOV t1, AX

MOV AX, t1
SUB AX, c
MOV t2, AX

MOV AX, t2
MUL d
MOV t3, AX

MOV AX, t3
MOV DX, 0
MOV BX, e
DIV BX
MOV t4, AX

MOV AX, t4
MOV x, AX
```

### RESULT
Thus, the back-end of the compiler was successfully implemented using FLEX and BISON to translate three-address code into equivalent 8086 assembly language code.


---\n

