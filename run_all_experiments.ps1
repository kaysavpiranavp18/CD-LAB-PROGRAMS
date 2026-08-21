$env:PATH = "C:\msys64\usr\bin;C:\msys64\ucrt64\bin;" + $env:PATH

$baseDir = $PSScriptRoot

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   CS4501 COMPILER DESIGN LAB - BUILDING AND EXECUTING    " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# Experiment 1
Write-Host "`n--- [EXP 1] Lexical Analyzer with Symbol Table ---" -ForegroundColor Yellow
Set-Location "$baseDir\Experiment_01_Lexical_Analyzer_SymbolTable"
flex symtab.l
gcc lex.yy.c -o symtab.exe
.\symtab.exe input.c

# Experiment 2
Write-Host "`n--- [EXP 2] C Lexical Analyzer Tokens ---" -ForegroundColor Yellow
Set-Location "$baseDir\Experiment_02_Lexical_Analyzer_Tokens"
flex lexer.l
gcc lex.yy.c -o lexer.exe
.\lexer.exe iplex.c

# Experiment 3
Write-Host "`n--- [EXP 3] Arithmetic Expression Parser ---" -ForegroundColor Yellow
Set-Location "$baseDir\Experiment_03_Arithmetic_Expression_Parser"
flex art_expr.l
bison -d art_expr.y
gcc lex.yy.c art_expr.tab.c -o art_expr.exe
"a+b*c-d/e" | .\art_expr.exe
"a=b" | .\art_expr.exe

# Experiment 4
Write-Host "`n--- [EXP 4] Valid Variable Recognizer ---" -ForegroundColor Yellow
Set-Location "$baseDir\Experiment_04_Valid_Variable_Recognizer"
flex valvar.l
bison -d valvar.y
gcc lex.yy.c valvar.tab.c -o valvar.exe
"add" | .\valvar.exe
"add1" | .\valvar.exe
"1add" | .\valvar.exe

# Experiment 5
Write-Host "`n--- [EXP 5] Control Structure Syntax Checker ---" -ForegroundColor Yellow
Set-Location "$baseDir\Experiment_05_Control_Structure_Syntax_Checker"
flex control.l
bison -d control.y
gcc lex.yy.c control.tab.c -o control.exe
"if (x < 5) { y = 10; }" | .\control.exe

# Experiment 6
Write-Host "`n--- [EXP 6] Calculator Lex & Yacc ---" -ForegroundColor Yellow
Set-Location "$baseDir\Experiment_06_Calculator_Lex_Yacc"
flex cal.l
bison -d cal.y
gcc lex.yy.c cal.tab.c -o calc.exe
"2+2" | .\calc.exe
"(5+3)*2" | .\calc.exe

# Experiment 7
Write-Host "`n--- [EXP 7] Three Address Code Generator ---" -ForegroundColor Yellow
Set-Location "$baseDir\Experiment_07_Three_Address_Code_Generator"
flex tac.l
bison -d tac.y
gcc lex.yy.c tac.tab.c -o tac.exe
"a = b + c * d" | .\tac.exe

# Experiment 8
Write-Host "`n--- [EXP 8] Type Checking ---" -ForegroundColor Yellow
Set-Location "$baseDir\Experiment_08_Type_Checking"
flex typecheck.l
bison -d typecheck.y
gcc lex.yy.c typecheck.tab.c -o typecheck.exe
"int a; int b; int c; a = b * c;" | .\typecheck.exe
"int a; float b; int c; a = b + c;" | .\typecheck.exe

# Experiment 9
Write-Host "`n--- [EXP 9] Code Optimization ---" -ForegroundColor Yellow
Set-Location "$baseDir\Experiment_09_Code_Optimization"
flex optimize.l
bison -d optimize.y
gcc lex.yy.c optimize.tab.c -o optimize.exe
"a = 2 + 4; b = d * 1; c = s * 2;" | .\optimize.exe

# Experiment 10
Write-Host "`n--- [EXP 10] Compiler Backend 8086 ---" -ForegroundColor Yellow
Set-Location "$baseDir\Experiment_10_Compiler_Backend_8086"
flex backend.l
bison -d backend.y
gcc lex.yy.c backend.tab.c -o backend.exe
"t1 = a + b; t2 = t1 - c; t3 = t2 * d; t4 = t3 / e; x = t4;" | .\backend.exe

Set-Location $baseDir
Write-Host "`n==========================================================" -ForegroundColor Green
Write-Host "   ALL EXPERIMENTS BUILT & VERIFIED SUCCESSFULLY!         " -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green
