%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include "ST.h"
#include <assert.h>
#include <math.h>
// stuff from flex that bison needs to know about:
//nodeType *opr(int oper, int nops, ...);
//void freeNode(nodeType *p);
nodeType *opr(int oper, int nops, ...);
nodeType *id(char* var);
nodeType *icon(int value);
nodeType *fcon(float value);
nodeType *chcon(char value);
void freeNode(nodeType *p);
int ex(nodeType *p);
int errors=0;
extern int linenum;
extern  int yylex();
extern  int yyparse();
extern FILE* yyin;
void yyerror(const char *s);
/*-------------------------------------------------------------------------
Install identifier & check if previously defined.
-------------------------------------------------------------------------*/
void install (char *sym_name,union Data v,char* type, int flag )
{ 

	//printf("%s\n",sym_name);
	symrec *s;
	s = getsym (sym_name) ;
	if (s == 0)
		{s = putsym (sym_name,v,type,flag);
	//printf("%s\n", s->name );
		}
	else { 
		errors++;
		printf( "%s is already defined\n", sym_name );
	}
}
void install_1 (char *sym_name,char* type, int flag )
{ 

	//printf("%s\n",sym_name);
	symrec *s;
	s = getsym (sym_name);
	if (s == 0)
		{
			s = putsym_1 (sym_name,type,flag);
	//printf("%s\n", s->name );
		}
	else { 
		errors++;
		printf( "%s is already defined\n", sym_name );
	}
}
symrec * context_check( char *sym_name )
{ 
	if ( getsym( sym_name ) == 0 )
	{
		printf( "%s is an undeclared identifier\n", sym_name );
		return NULL;
	}
	else 
	{
	  symrec *s=getsym(sym_name);
	  return s;
	  // printf("%s\n", s);
	}	
}
char* str_split(char* a_str)
{
    char * pch;
  //printf ("Splitting string \"%s\" into tokens:\n",a_str);
    // printf("%s\n", a_str);
  pch = strtok (a_str," ");
   char * str = pch;
 	// printf("%s\n", str);
    return str;
}
%}
%union { /* SEMANTIC RECORD */
char *id; /* For returning identifiers */
char *valtype;
float fValue;
int iValue;
char cValue;
nodeType *nPtr; /* node pointer */
};
// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:
//types
%token  <valtype>FLOAT
%token <valtype>CHAR
%token <valtype>INT
%token CONSTANT
%token<id> VARIABLE
//values
%token<fValue> FLOATVAL
%token <iValue>INTVAL
%token <cValue>CHARVAL

%token IF ELSE 
%token WHILE FOR  REPEAT UNTIL SWITCH BREAK CASE COLON DEFAULT
%token T_NEWLINE
%token SEMI

%left MINUS PLUS MULT DIVIDE POWEROF IFAND IFOR AND OR XOR NOT
%right EQUAL
//format
%token OPENING_PAR CLOSING_PAR OPENING_CURLY CLOSING_CURLY
%left BOOLEAN_EQUAL BOOLEAN_LESS BOOLEAN_GREATER BOOLEAN_LESS_EQUAL BOOLEAN_GREATER_EQUAL BOOLEAN_NOT_EQUAL
%type <valtype> type constant
 %type <nPtr>  assignment_statment line while_loop for_loop  for_assignment repeat_loop if_condition if_trail expression code_block case_block switch_case switch_trail
//%type <nPtr>  expression line assignment_statment 
// %start assign
%%

 code_block  : line | if_condition |while_loop| for_loop |repeat_loop|switch_case|{$$=NULL;};

while_loop : WHILE OPENING_PAR expression CLOSING_PAR OPENING_CURLY code_block CLOSING_CURLY code_block{$$=opr(WHILE,3,$3,$6,$8);};
////
for_loop: FOR OPENING_PAR assignment_statment SEMI expression SEMI for_assignment CLOSING_PAR OPENING_CURLY code_block CLOSING_CURLY code_block
{$$=opr(EQUAL,5,$3,$5,$7,$10,$12);};
for_assignment : VARIABLE EQUAL expression{$$=opr(EQUAL,2,id($1),$3);};
// //

repeat_loop : REPEAT OPENING_CURLY code_block CLOSING_CURLY UNTIL OPENING_PAR expression CLOSING_PAR SEMI code_block
{$$=opr(REPEAT,3,$3,$7,$10);};
//
switch_case : SWITCH OPENING_PAR VARIABLE CLOSING_PAR OPENING_CURLY case_block DEFAULT COLON code_block CLOSING_CURLY code_block{$$=opr(SWITCH,4,id($3),$6,$9,$11);};
case_block : CASE expression COLON code_block BREAK SEMI switch_trail {$$=opr(CASE,3,$2,$4,$7);};
switch_trail : case_block | {$$=NULL;};
//
if_condition : IF OPENING_PAR expression CLOSING_PAR OPENING_CURLY code_block CLOSING_CURLY if_trail {$$ = opr(IF ,3, $3,$6,$8);};

if_trail :  ELSE OPENING_CURLY code_block CLOSING_CURLY code_block {$$=opr(ELSE,2,$3,$5);}
	 | ELSE if_condition{$$=opr(ELSE,1,$2);}
  	 | code_block ;


line : assignment_statment SEMI code_block
	| expression SEMI code_block
  	| VARIABLE EQUAL expression SEMI code_block {  
  												
  													$$=opr(EQUAL,2,id($1),$3);
  								}
  						;
  	

assignment_statment : type VARIABLE EQUAL expression {	
														install_1($2,$1,0);	
														$$=opr(EQUAL,2,id($2),$4);
													}
	  | constant VARIABLE EQUAL expression {			install_1($2,$1,1);	
														$$=opr(EQUAL,2,id($2),$4);	}
	  												// 		char * type = str_split($1);
															// char * variable = str_split($2);

															// if(($4)->type==typeCon)
															// install(id(variable)->id.var,($4)->con.value,type,1);			
													
															// else if(($4)->type==typeId)
															// 	{	
															// 		char * str3 = str_split(($4)->id.var);
															// 		symrec *s=context_check(str3);
															// 		if (s !=0)
															// 		 {if (strcmp(type,s->type)==0)
															// 		 {
																
															// 		 install(id(variable)->id.var,s->value,type,1);
															// 		 }	
															// 		 else 	printf("variable types doesn't match @ line %i\n",linenum );	
															// 		}

															// 	}
															// else { 
															// 		if((($4)->opr.op[0])->type==typeCon)
															// 			{ 
															// 				if (strcmp((($4)->opr.op[0])->con.type,type)!=0)
															// 				printf("variable types doesn't match @ line %i\n",linenum );
															// 				 install_1(id(variable)->id.var,type,1);
															// 			}
															// 		else if((($4)->opr.op[0])->type==typeId)
															// 			{	
															// 				char * str3 = str_split((($4)->opr.op[0])->id.var);
																			
															// 				symrec *s=context_check(str3);
																			
															// 				if(s != 0)
															// 				{if (strcmp(s->type,type)!=0)
															// 					printf("variable types doesn't match @ line %i\n",linenum );
															// 					 install_1(id(variable)->id.var,type,1);
															// 					}
															// 			}
															// 		else {printf("too many operandes to handle\n");	}//opr()}
																	
																//

	 //  }
														//	}
	  | type VARIABLE  { install_1($2,$1,0);}
	 ;

expression: 
	  expression PLUS expression	{$$ = opr(PLUS, 2, $1, $3);}	
	| expression MINUS expression {$$ = opr(MINUS, 2, $1, $3);}
	| expression MULT expression {$$ = opr(MULT, 2, $1, $3);}
	| expression DIVIDE expression {$$ = opr(DIVIDE, 2, $1, $3);}
	| expression AND expression {$$ = opr(AND, 2, $1, $3);}
	| expression OR expression {$$ = opr(OR, 2, $1, $3);}
	| expression XOR expression {$$ = opr(XOR, 2, $1, $3);}
	// | NOT expression {$$ =  $1; }
	| expression BOOLEAN_EQUAL expression {$$ = opr(BOOLEAN_EQUAL, 2, $1, $3);}
	| expression BOOLEAN_NOT_EQUAL expression {$$ = opr(BOOLEAN_NOT_EQUAL, 2, $1, $3);}
	| expression BOOLEAN_LESS expression {$$ = opr(BOOLEAN_LESS, 2, $1, $3);}
	| expression BOOLEAN_GREATER expression {$$ = opr(BOOLEAN_GREATER, 2, $1, $3);}
	| expression BOOLEAN_LESS_EQUAL expression {$$ = opr(BOOLEAN_LESS_EQUAL, 2, $1, $3);}
	| expression BOOLEAN_GREATER_EQUAL expression {$$ = opr(BOOLEAN_GREATER_EQUAL, 2, $1, $3);}
	| expression IFAND expression {$$ = opr(IFAND, 2, $1, $3);}
	| expression IFOR expression {$$ = opr(IFOR, 2, $1, $3);}
	| OPENING_PAR expression CLOSING_PAR {$$ = $2;}
	| VARIABLE 		   {$$ = id($1);}
	| INTVAL            {$$=icon($1);}
	| FLOATVAL            {$$=fcon($1);}
	| CHARVAL            {$$=chcon($1);}
	; 

	; 
type : INT {$$=$1;}
 | FLOAT {$$=$1;}
 | CHAR {$$=$1;}
 ;

constant :
 	CONSTANT type {$$ =$2;}




%%
nodeType *opr(int oper, int nops, ...) {
 	va_list ap;
 	nodeType *p;
 	int i;
 /* allocate node, extending op array */
 	if ((p = malloc(sizeof(nodeType) +(nops-1) * sizeof(nodeType *))) == NULL)
 	yyerror("out of memory");
	 /* copy information */
	 p->type = typeOpr;
	 p->opr.oper = oper;
	 p->opr.nops = nops;
	 va_start(ap, nops);
	 for ( i = 0; i < nops; i++)
 	{ 	
 	p->opr.op[i] = va_arg(ap, nodeType*);
 	if(oper==MINUS ||  oper==PLUS ||  oper==MULT ||  oper==DIVIDE ||  oper==POWEROF ||  oper==IFAND ||  oper==IFOR ||  oper==AND ||  oper==OR ||  oper==XOR || oper==NOT ||  oper==BOOLEAN_EQUAL ||  oper==BOOLEAN_LESS ||  oper==BOOLEAN_GREATER || oper==BOOLEAN_LESS_EQUAL ||  oper==BOOLEAN_GREATER_EQUAL ||  oper==BOOLEAN_NOT_EQUAL || oper==EQUAL)
	{	
		if(i>0)
		{	
			if((p->opr.op[0])->type==typeCon)
				{	
					if((p->opr.op[i])->type==typeCon)
					{	
						if(strcmp((p->opr.op[i])->con.type,(p->opr.op[0])->con.type)!=0)	
						printf( "operade types doesnt match @ line %i\n",linenum );
					}	
						if((p->opr.op[i])->type==typeId)
						{	char *iden=str_split((p->opr.op[i])->id.var);
							symrec *variable=context_check(iden);
							if(variable!= 0)
							if(strcmp(variable ->type, (p->opr.op[0])->con.type)!=0)
							{ 
								printf( "operade types doesnt match @ line %i\n",linenum );
							}
						}
				}
			if((p->opr.op[0])->type==typeId)
				{  
					char *oper1=str_split((p->opr.op[0])->id.var);
					//printf("%s\n", oper1);

					symrec *oper1_variable=context_check(oper1);

					if (oper1_variable != 0)
					{
						if((p->opr.op[i])->type==typeCon)
						{	
							
						if(strcmp((p->opr.op[i])->con.type,oper1_variable->type)!=0)	
						printf( "operade types doesnt match @ line %i\n",linenum );
						}

							if((p->opr.op[i])->type==typeId)
						{
							char *iden=str_split((p->opr.op[i])->id.var);
							
						symrec *variable=context_check(iden);
							if(variable !=0)
							{
						
								if(strcmp(variable ->type, oper1_variable ->type)!=0)
								{ 
								printf( "operade types doesnt match @ line %i\n",linenum );
								}
							}
						}
						if((p->opr.op[i])->type==typeOpr)
						{	
							for (int k=0; k<(p->opr.op[i])->opr.nops ;k++)
							{	nodeType *a =(p->opr.op[i])->opr.op[k];
								if(a->type ==typeCon)
									{
										if(strcmp(a->con.type,oper1_variable->type)!=0)	
											printf( "operade types doesnt match @ line %i\n",linenum );
										
									}
								if(a->type ==typeId)
									{	symrec * req = context_check(a->id.var);
										if (req!=0)
										if(strcmp(req->type,oper1_variable->type)!=0)	
											printf( "operade types doesnt match @ line %i\n",linenum );
										
									}
							}
						}

					}
				}
				
		}
 	}
 }
 	va_end(ap);
 return p;

}
nodeType *id(char *var) {
	//printf("%s\n",var);
 nodeType *p;
 /* allocate node */
 if ((p = malloc(sizeof(nodeType))) == NULL)
 yyerror("out of memory");
 /* copy information */
 p->type = typeId;
 p->id.var = var;
 p->id.reg= -1 ;
 return p;
}
nodeType *icon(int value) {
 nodeType *p;
	//printf("%d\n",value);

 /* allocate node */
 if ((p = malloc(sizeof(nodeType))) == NULL)
 yyerror("out of memory");
 
 /* copy information */
 p->type = typeCon;
 p->con.value.i = value;
  p->con.type="int\0";
 return p;
}
nodeType *fcon(float value) {
 nodeType *p;
 /* allocate node */
 if ((p = malloc(sizeof(nodeType))) == NULL)
 yyerror("out of memory");
 /* copy information */
 p->type = typeCon;
 p->con.value.f = value;
  p->con.type="float\0";
 return p;
}
nodeType *chcon(char value) {
 nodeType *p;
 /* allocate node */
 if ((p = malloc(sizeof(nodeType))) == NULL)
 yyerror("out of memory");
 /* copy information */
 p->type = typeCon;
 p->con.value.ch = value;
  p->con.type="char\0";
 return p;
}
int main(int argc,char**argv) {
 // open a file handle to a particular file:
       // printf("file not opened\n");
    FILE *myfile = fopen(argv[1], "r");
    // make sure it is valid:
    if (!myfile) {
        return -1;
    }
    // set flex to read from it instead of defaulting to STDIN:
    yyin = myfile;

    //parse through the input until there is no more:
    do {
        yyparse();
    } while (!feof(yyin));
	return 0;
	
}


void yyerror(const char *s) {
	printf("error %s @ : %i\n",s,linenum); 
	exit(-1);
}