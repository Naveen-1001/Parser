%x IN_COMMENT 

%{
    #include "Parser.tab.h"
    extern int line_number;
    extern int flag;

    void yyerror(char const *s) {
      fprintf(stderr, "line %d: %s\n", line_number, s);
    }
 
    extern char* yytext;
%}

%option noyywrap    

%%
"+"                         return PLUS;
"-"                         return MINUS;
"*"                         return MULTIPLY;
"/"                         return DIVIDE;
"%"                         return MODULO;
"<="                        return LESS_OR_EQUAL;
"<"                         return LESS_THAN;                     
">="                        return GREATER_OR_EQUAL;
">"                         return GREATER_THAN;
"=="                        return EQUALS;
"!="                        return NOT_EQUALS;
"="                         return ASSIGNMENT;
"!"                         return UNARY_NOT;
"&&"                        return LOGICAL_AND;
"||"                        return LOGICAL_OR;
"&"                         return BITWISE_AND;
"|"                         return BITWISE_OR;
">>"                        return BITWISE_RIGHTSHIFT;
"<<"                        return BITWISE_LEFTSHIFT;
"~"                         return BITWISE_NOT;
"^"                         return XOR;
"++"                        return UNARY_INCREMENT;
"--"                        return UNARY_DECREMENT;
";"                         return EOL;
","                         return COMMA;
"{"                         return LEFT_PARANTHESIS;
"}"                         return RIGHT_PARANTHESIS;
"("                         return LEFT_BRACKET;
")"                         return RIGHT_BRACKET;
"["                         return LEFT_SQR_BRACKET;
"]"                         return RIGHT_SQR_BRACKET;
"for"                       return FOR;
"if"                        return IF;
"else"                      return ELSE;
[a-zA-Z][a-zA-Z0-9_]*       return ID;
[0-9][0-9]*                 return NUM;
((0[0-7]+|0[xX][0-9A-Fa-f]+|[0-9]+)(U|L)?)  return NUM;
[0-9]+([\.][0-9]+)?([eE](\+|-)?[0-9]+)?     return NUM;

'(\\[ tvrafb\\]|[^\\'])'    ;
[\n]                        {line_number++;}
[ \t\r]*                    ;
.                           yyerror("Error in Syntax!");
%%
