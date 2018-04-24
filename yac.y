%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// stuff from flex that bison needs to know about:
extern  int yylex();
extern  int yyparse();
extern int linenum;
 extern FILE* yyin;
void yyerror(const char *s);
%}

// Bison fundamentally works by asking flex to get the next token, which it
// returns as an object of type "yystype".  But tokens could be of any
// arbitrary data type!  So we deal with that in Bison by defining a C union
// holding each of the types of tokens that Flex could return, and have Bison
// use that union instead of "int" for the definition of "yystype":
%union {
	int ival;
	float fval;
	char sval[100];
}

// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:
//types
%token  FLOAT
%token CHAR
%token INT
%token CONSTANT
//values
%token <fval>FLOATVAL
%token <ival>INTVAL
%token <sval>CHARVAL
%token <sval>VARIABLE
%token IF ELSE 
%token WHILE FOR  DO SWITCH BREAK CASE COLON
%token MINUS PLUS MULT DIVIDE POWEROF IFAND IFOR AND OR XOR NAND
%token EQUAL
%token T_NEWLINE
%token SEMI
//format
%token OPENING_PAR CLOSING_PAR OPENING_CURLY CLOSING_CURLY
%token BOOLEAN_EQUAL BOOLEAN_LESS BOOLEAN_GREATER BOOLEAN_LESS_EQUAL BOOLEAN_GREATER_EQUAL 
// %start ass
%%
code_block  : line | if_condition |while_loop| for_loop |do_loop|switch_case|;

//
while_loop : WHILE OPENING_PAR boolean_expression CLOSING_PAR OPENING_CURLY code_block CLOSING_CURLY code_block;
//
for_loop : FOR OPENING_PAR for_expression CLOSING_PAR OPENING_CURLY code_block CLOSING_CURLY code_block;
for_expression : for_init SEMI boolean_expression SEMI for_assignment;
for_init : type VARIABLE EQUAL expression | VARIABLE EQUAL expression;
for_assignment : VARIABLE EQUAL expression;
//
do_loop : DO OPENING_CURLY code_block CLOSING_CURLY WHILE OPENING_PAR boolean_expression CLOSING_PAR SEMI code_block;
//
switch_case : SWITCH OPENING_PAR VARIABLE CLOSING_PAR OPENING_CURLY case_block CLOSING_CURLY code_block;
case_block : CASE val COLON code_block BREAK SEMI switch_trail;
switch_trail : case_block | ;
//
if_condition : IF OPENING_PAR boolean_expression CLOSING_PAR OPENING_CURLY code_block CLOSING_CURLY if_trail;

if_trail :  ELSE OPENING_CURLY code_block CLOSING_CURLY code_block
	 | ELSE if_condition
  	 | code_block ;
//
boolean_expression : boolean_operation
 | boolean_expression IFAND boolean_expression
 | boolean_expression IFOR boolean_expression
 ;

boolean_operation: expression compartor expression ;

compartor: BOOLEAN_EQUAL
	| BOOLEAN_LESS 
	| BOOLEAN_GREATER 
	| BOOLEAN_LESS_EQUAL 
	| BOOLEAN_GREATER_EQUAL
	;

line : assignment_statment SEMI code_block
 	| expression SEMI code_block
 	| VARIABLE EQUAL expression SEMI code_block
 	;

assignment_statment : type VARIABLE EQUAL expression | constant VARIABLE EQUAL expression 
	 | type VARIABLE 
	 ;

expression: 
	 expression PLUS expression		
	| expression MINUS expression		
	| expression MULT expression		
	| expression POWEROF expression		
	| expression DIVIDE expression		
	| expression AND expression
	| expression OR expression
	| expression XOR expression
	| expression NAND expression
	| VARIABLE 				
	| val
	;


type : INT
 | FLOAT 
 | CHAR 
 ;
constant : CONSTANT type;

val: FLOATVAL
	|INTVAL
	;



%%
int main(int argc,char**argv) {
  // open a file handle to a particular file:
    FILE *myfile = fopen(argv[1], "r");
    // make sure it is valid:
    if (!myfile) {
        printf("file not opened\n");
        return -1;
    }
    // set flex to read from it instead of defaulting to STDIN:
    yyin = myfile;

    // parse through the input until there is no more:
    do {
        yyparse();
    } while (!feof(yyin));
	return 0;
	
}


void yyerror(const char *s) {
	printf("error %s @ : %i\n",s,linenum); 
	exit(-1);
}