%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ST.h"
#include <math.h>
// stuff from flex that bison needs to know about:
extern  int yylex();
extern  int yyparse();
extern int linenum;
int errors=0;
 extern FILE* yyin;
void yyerror(const char *s);
/*-------------------------------------------------------------------------
Install identifier & check if previously defined.
-------------------------------------------------------------------------*/
install ( char *sym_name )
{ printf("%c\n",sym_name[0]);
	symrec *s;
s = getsym (sym_name);
if (s == 0)
s = putsym (sym_name);
else { errors++;
printf( "%s is already defined\n", sym_name );
}
}
context_check( char *sym_name )
{ if ( getsym( sym_name ) == 0 )
printf( "%s is an undeclared identifier\n", sym_name );
}
%}


// Bison fundamentally works by asking flex to get the next token, which it
// returns as an object of type "yystype".  But tokens could be of any
// arbitrary data type!  So we deal with that in Bison by defining a C union
// holding each of the types of tokens that Flex could return, and have Bison
// use that union instead of "int" for the definition of "yystype":
%union { /* SEMANTIC RECORD */
char *id; /* For returning identifiers */
float f;
int in;
}
// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:
//types
%token  FLOAT
%token CHAR
%token INT
%token CONSTANT
%token<id> VARIABLE
//values
%token<f> FLOATVAL
%token <f>INTVAL
%token <id>CHARVAL
%token IF ELSE 
%token WHILE FOR  REPEAT UNTIL SWITCH BREAK CASE COLON
%left MINUS PLUS MULT DIVIDE POWEROF IFAND IFOR AND OR XOR NOT
%right EQUAL
%token T_NEWLINE
%token SEMI
//format
%token OPENING_PAR CLOSING_PAR OPENING_CURLY CLOSING_CURLY
%left BOOLEAN_EQUAL BOOLEAN_LESS BOOLEAN_GREATER BOOLEAN_LESS_EQUAL BOOLEAN_GREATER_EQUAL BOOLEAN_NOT_EQUAL
// %start assign
%%
code_block  : line | if_condition |while_loop| for_loop |repeat_loop|switch_case|;

//
while_loop : WHILE OPENING_PAR expression CLOSING_PAR OPENING_CURLY code_block CLOSING_CURLY code_block;
//
for_loop : FOR OPENING_PAR for_expression CLOSING_PAR OPENING_CURLY code_block CLOSING_CURLY code_block;
for_expression : for_init SEMI expression SEMI for_assignment;
for_init : type VARIABLE EQUAL expression | VARIABLE EQUAL expression;
for_assignment : VARIABLE EQUAL expression;
//
repeat_loop : REPEAT OPENING_CURLY code_block CLOSING_CURLY UNTIL OPENING_PAR expression CLOSING_PAR SEMI code_block;
//
switch_case : SWITCH OPENING_PAR VARIABLE CLOSING_PAR OPENING_CURLY case_block CLOSING_CURLY code_block;
case_block : CASE val COLON code_block BREAK SEMI switch_trail;
switch_trail : case_block | ;
//
if_condition : IF OPENING_PAR expression CLOSING_PAR OPENING_CURLY code_block CLOSING_CURLY if_trail //{$$ = $3;}

if_trail :  ELSE OPENING_CURLY code_block CLOSING_CURLY code_block
	 | ELSE if_condition
  	 | code_block ;
//
/*boolean_expression : expression {$$ = $1;}
 | expression IFAND expression {$$ = $1 && $3;}
 | expression IFOR expression {$$ = $1 || $3;}
 ;*/

/*boolean_operation: expression compartor expression ;

compartor: BOOLEAN_EQUAL
	| BOOLEAN_LESS 
	| BOOLEAN_GREATER 
	| BOOLEAN_LESS_EQUAL 
	| BOOLEAN_GREATER_EQUAL
	;*/

line : assignment_statment SEMI code_block
 	| expression SEMI code_block
 	| VARIABLE EQUAL expression SEMI code_block
 	;

assignment_statment : type VARIABLE EQUAL expression {printf("%s h\n",$1 );
	install($2);}
	 | constant VARIABLE EQUAL expression {install($2);}
	 | type VARIABLE {install($2);}
	 ;

expression: 
	 expression PLUS expression	{$$ = $1 + $3;}	
	| expression MINUS expression {$$ = $1 - $3;}
	| expression MULT expression {$$ = $1 * $3;}
	| expression POWEROF expression	
	| expression DIVIDE expression {$$ = $1 / $3;}
	| expression AND expression {$$ = $1 & $3;}
	| expression OR expression {$$ = $1 | $3;}
	| expression XOR expression {$$ = $1 ^ $3;}
	| NOT expression {$$ = ! $1; }
	| expression BOOLEAN_EQUAL expression {$$ = $1 == $3;}
	| expression BOOLEAN_NOT_EQUAL expression {$$ = $1 != $3;}
	| expression BOOLEAN_LESS expression {$$ = $1 < $3;}
	| expression BOOLEAN_GREATER expression {$$ = $1 > $3;}
	| expression BOOLEAN_LESS_EQUAL expression {$$ = $1 <= $3;}
	| expression BOOLEAN_GREATER_EQUAL expression {$$ = $1 >= $3;}
	| expression IFAND expression {$$ = $1 && $3;}
	| expression IFOR expression {$$ = $1 || $3;}
	| OPENING_PAR expression CLOSING_PAR {$$ = $1;}
	//| VARIABLE 		
	| val            {$$=$1;}
	; 

	; 
type : INT
 | FLOAT 
 | CHAR 
 ;
 val:
 	INTVAL
 	| FLOATVAL;

constant :
 CONSTANT type;




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