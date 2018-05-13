/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_YAC_TAB_H_INCLUDED
# define YY_YY_YAC_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    FLOAT = 258,
    CHAR = 259,
    INT = 260,
    CONSTANT = 261,
    VARIABLE = 262,
    FLOATVAL = 263,
    INTVAL = 264,
    CHARVAL = 265,
    IF = 266,
    ELSE = 267,
    WHILE = 268,
    FOR = 269,
    REPEAT = 270,
    UNTIL = 271,
    SWITCH = 272,
    BREAK = 273,
    CASE = 274,
    COLON = 275,
    DEFAULT = 276,
    T_NEWLINE = 277,
    SEMI = 278,
    MINUS = 279,
    PLUS = 280,
    MULT = 281,
    DIVIDE = 282,
    POWEROF = 283,
    IFAND = 284,
    IFOR = 285,
    AND = 286,
    OR = 287,
    XOR = 288,
    NOT = 289,
    EQUAL = 290,
    OPENING_PAR = 291,
    CLOSING_PAR = 292,
    OPENING_CURLY = 293,
    CLOSING_CURLY = 294,
    BOOLEAN_EQUAL = 295,
    BOOLEAN_LESS = 296,
    BOOLEAN_GREATER = 297,
    BOOLEAN_LESS_EQUAL = 298,
    BOOLEAN_GREATER_EQUAL = 299,
    BOOLEAN_NOT_EQUAL = 300
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 82 "yac.y" /* yacc.c:1909  */
 /* SEMANTIC RECORD */
char *id; /* For returning identifiers */
char *valtype;
float fValue;
int iValue;
char cValue;
nodeType *nPtr; /* node pointer */

#line 109 "yac.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_YAC_TAB_H_INCLUDED  */
