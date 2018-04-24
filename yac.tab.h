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
    FLOATVAL = 261,
    INTVAL = 262,
    CHARVAL = 263,
    IF = 264,
    ELSE = 265,
    WHILE = 266,
    FOR = 267,
    DO = 268,
    SWITCH = 269,
    BREAK = 270,
    CASE = 271,
    COLON = 272,
    MINUS = 273,
    PLUS = 274,
    MULT = 275,
    DIVIDE = 276,
    POWEROF = 277,
    IFAND = 278,
    IFOR = 279,
    AND = 280,
    OR = 281,
    XOR = 282,
    NAND = 283,
    VARIABLE = 284,
    EQUAL = 285,
    T_NEWLINE = 286,
    SEMI = 287,
    OPENING_PAR = 288,
    CLOSING_PAR = 289,
    OPENING_CURLY = 290,
    CLOSING_CURLY = 291,
    BOOLEAN_EQUAL = 292,
    BOOLEAN_LESS = 293,
    BOOLEAN_GREATER = 294,
    BOOLEAN_LESS_EQUAL = 295,
    BOOLEAN_GREATER_EQUAL = 296
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 18 "yac.y" /* yacc.c:1909  */

	int ival;
	float fval;
	char sval[100];

#line 102 "yac.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_YAC_TAB_H_INCLUDED  */
