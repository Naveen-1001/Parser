###Parser using Bison for a specific CFG###

** Context-Free Grammar**

stmts -> stmts stmt | epsilon
stmt -> ;

  | expr ;

  | if (expr) stmt

  | if (expr) stmt else stmt

  | for (expr ; expr ; expr ) stmt

  |  { stmts }

** Working **

* Prints all the syntax errors present in the program.
* Prints OK if there are no compilation errors.

#### Running the model
```sh
flex LexicalAnalyzer.l
bison -d Parser.y
gcc lex.yy.c Parser.tab.h -ll
./a.out < input.c
```
