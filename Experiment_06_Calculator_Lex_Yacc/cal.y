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

