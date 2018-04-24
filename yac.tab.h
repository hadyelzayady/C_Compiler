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
    FLOATVAL = 262,
    INTVAL = 263,
    CHARVAL = 264,
    VARIABLE = 265,
    IF = 266,
    ELSE = 267,
    WHILE = 268,
    FOR = 269,
    DO = 270,
    SWITCH = 271,
    BREAK = 272,
    CASE = 273,
    COLON = 274,
    MINUS = 275,
    PLUS = 276,
    MULT = 277,
    DIVIDE = 278,
    POWEROF = 279,
    IFAND = 280,
    IFOR = 281,
    AND = 282,
    OR = 283,
    XOR = 284,
    NAND = 285,
    EQUAL = 286,
    T_NEWLINE = 287,
    SEMI = 288,
    OPENING_PAR = 289,
    CLOSING_PAR = 290,
    OPENING_CURLY = 291,
    CLOSING_CURLY = 292,
    BOOLEAN_EQUAL = 293,
    BOOLEAN_LESS = 294,
    BOOLEAN_GREATER = 295,
    BOOLEAN_LESS_EQUAL = 296,
    BOOLEAN_GREATER_EQUAL = 297
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

#line 103 "yac.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_YAC_TAB_H_INCLUDED  */
