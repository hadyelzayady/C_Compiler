%option noyywrap
%{
#include "types.h"
#include <stdio.h>
#include "yac.tab.h"
#define YY_DECL int yylex()
int linenum = 1;
%}
%%
"int"            {yylval.valtype = strdup(yytext);  return INT; }
"float"            { yylval.valtype = strdup(yytext);return FLOAT; }
"if"            { return IF; }
"while"			{return WHILE;}
"for" 			{return FOR;}
"switch" 		{return SWITCH;}
"case" 		{return CASE;}
"break" 		{return BREAK;}
"repeat"		{return REPEAT;}
"until"			{return UNTIL;}
"const"			{return CONSTANT;}
"default"		{return DEFAULT;}
"char"            {yylval.valtype = strdup(yytext); return CHAR; }
"else"				{return ELSE;}
":" 		{return COLON;}
"==" 			{return BOOLEAN_EQUAL;}
"!="				{return BOOLEAN_NOT_EQUAL;}
"<"				{return BOOLEAN_LESS;}
">"				{return BOOLEAN_GREATER;}
"<="				{return BOOLEAN_LESS_EQUAL;}
">="				{return BOOLEAN_GREATER_EQUAL;}
"="					{return EQUAL;}
";"					{return SEMI;}
"+"				{return PLUS;}
"-"				{return MINUS;}
"*"                 { return MULT; }
"/"                 { return DIVIDE; }
"^"                 { return POWEROF; }
"&&"             { return IFAND;}
"||"             { return IFOR; }
"&"             { return AND; }
"|"             { return OR; }
"xor"             { return XOR; }
"!"             { return NOT; }
[0-9]+          { yylval.iValue = atoi(yytext); return INTVAL; }
[0-9]+\.[0-9]+  { yylval.fValue = atof(yytext); return FLOATVAL; }
"'"[a-zA-Z0-9]"'"    {yylval.cValue=*yytext  ;return CHARVAL;}
"("				{return OPENING_PAR;}
")"				{return CLOSING_PAR;}
"{"				{return OPENING_CURLY;}
"}"				{return CLOSING_CURLY;}
[a-zA-Z][a-zA-Z0-9_]* { yylval.id=strdup(yytext);  return VARIABLE;}
[ \t]           ;
\n 				{++linenum;}
%%