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
