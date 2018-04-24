%option noyywrap
%{
#include <stdio.h>
#include "yac.tab.h"
#define YY_DECL int yylex()
int linenum = 1;
%}
%%
"int"            { return INT; }
"float"            { return FLOAT; }
"if"            { return IF; }
"while"			{return WHILE;}
"for" 			{return FOR;}
"do" 			{return DO;}
"switch" 		{return SWITCH;}
"case" 		{return CASE;}
"break" 		{return BREAK;}
":" 		{return COLON;}
"==" 			{return BOOLEAN_EQUAL;}
"<"				{return BOOLEAN_LESS;}
">"				{return BOOLEAN_GREATER;}
"<="				{return BOOLEAN_LESS_EQUAL;}
">="				{return BOOLEAN_GREATER_EQUAL;}
"else"				{return ELSE;}
"="					{return EQUAL;}
";"					{return SEMI;}
"+"				{return PLUS;}
"-"				{return MINUS;}
"*"                 { return MULT; }
"/"                 { return DIVIDE; }
"^"                 { return POWEROF; }
"&&"             { return IFAND; }
"||"             { return IFOR; }
"and"             { return AND; }
"or"             { return OR; }
"xor"             { return XOR; }
"nand"             { return NAND; }
[ \t]           ;
\n 				{++linenum;}
[0-9]+          { yylval.ival = atoi(yytext); return INTVAL; }
[0-9]+\.[0-9]+  { return FLOATVAL; }
"'"[a-zA-Z0-9]"'"    {  return CHARVAL;}
"char"            { return CHAR; }
"("				{return OPENING_PAR;}
")"				{return CLOSING_PAR;}
"{"				{return OPENING_CURLY;}
"}"				{return CLOSING_CURLY;}
[a-zA-Z][a-zA-Z0-9_]* { return VARIABLE; }
%%