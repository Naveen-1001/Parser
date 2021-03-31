%{
    #include <stdarg.h>
    #include <stdio.h>
    #include "shared_values.h"
    #define YYSTYPE char *
    extern int yylineno;
    extern int flag;
    int yylex();
    void yyerror(const char *s);
    int yydebug = 1;
    int indent = 0;
    char *iden_dum;
%}

// Tokens Definition
%token EOL
%token LEFT_PARANTHESIS
%token RIGHT_PARANTHESIS
%token ID
%token NUM
%token FOR

%left COMMA
%right ASSIGNMENT
%left LOGICAL_OR
%left LOGICAL_AND
%left BITWISE_OR
%left XOR
%left BITWISE_AND
%left EQUALS NOT_EQUALS
%left LESS_THAN LESS_OR_EQUAL GREATER_THAN GREATER_OR_EQUAL
%left BITWISE_LEFTSHIFT BITWISE_RIGHTSHIFT
%left PLUS MINUS
%left MULTIPLY DIVIDE MODULO
%right UNARY_INCREMENT UNARY_DECREMENT UNARY_NOT BITWISE_NOT
%left LEFT_BRACKET RIGHT_BRACKET LEFT_SQR_BRACKET RIGHT_SQR_BRACKET

%nonassoc IF
%nonassoc ELSE
%start program

// Grammar Rules for CFG
%%
program: stmts {if(flag==0) printf("OK\n");}
       ;

stmts: stmts stmt 
     | %empty
     | error{ flag=1;} 
     ;

stmt: EOL 
    | exp EOL 
    | IF LEFT_BRACKET exp RIGHT_BRACKET stmt %prec IF
    | IF LEFT_BRACKET exp RIGHT_BRACKET stmt ELSE stmt
    | FOR LEFT_BRACKET exp EOL exp EOL exp RIGHT_BRACKET stmt
    | LEFT_PARANTHESIS stmts RIGHT_PARANTHESIS
    ;

exp: exp COMMA assignment-exp
   | assignment-exp
   ;

assignment-exp: var ASSIGNMENT assignment-exp
              | arithmetic-exp
              ;

arithmetic-exp: arithmetic-exp LOGICAL_OR logical-or-exp
              | logical-or-exp
              ;

logical-or-exp: logical-or-exp LOGICAL_AND logical-and-exp
              | logical-and-exp
              ;

logical-and-exp: logical-and-exp BITWISE_OR bitwise-or-exp
               | bitwise-or-exp
               ;

bitwise-or-exp: bitwise-or-exp XOR bitwise-xor-exp
              | bitwise-xor-exp
              ;

bitwise-xor-exp: bitwise-xor-exp BITWISE_AND bitwise-and-exp
               | bitwise-and-exp
               ;

bitwise-and-exp: bitwise-and-exp relational-operator relational-exp
               | relational-exp
               ;

relational-exp: relational-exp relational-operator-lg bitwise-shift-exp
              | bitwise-shift-exp
              ;

bitwise-shift-exp: bitwise-shift-exp bitwise-shift-operator additive-exp
                 | additive-exp
                 ;

additive-exp: additive-exp plus_minus multiplicative-exp
            | multiplicative-exp
            ;

multiplicative-exp : multiplicative-exp mult_divide_modulo unary-exp
                   | unary-exp
                   ;

unary-exp: UNARY_INCREMENT unary-exp
         | UNARY_DECREMENT unary-exp
         | UNARY_NOT unary-exp
         | BITWISE_NOT unary-exp
         | PLUS unary-exp
         | MINUS unary-exp
         | unary-exp UNARY_INCREMENT
         | unary-exp UNARY_DECREMENT
         | bracket-exp
         ;

bracket-exp: LEFT_BRACKET exp RIGHT_BRACKET 
           | var 
           | NUM
           ;

var: ID 
   | ID LEFT_SQR_BRACKET exp RIGHT_SQR_BRACKET
   ;

bitwise-shift-operator: BITWISE_LEFTSHIFT 
                      | BITWISE_RIGHTSHIFT
                      ;
                        
relational-operator: EQUALS
                   | NOT_EQUALS
                   ;

relational-operator-lg: LESS_THAN 
                      | LESS_OR_EQUAL 
                      | GREATER_THAN 
                      | GREATER_OR_EQUAL
                      ;

plus_minus: PLUS 
          | MINUS
          ;

mult_divide_modulo : MULTIPLY 
                   | DIVIDE
                   | MODULO
                   ;

%%                                                                              
int main (void) {     
  yyparse ();
}
