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

