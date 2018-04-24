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
    MINUS = 268,
    PLUS = 269,
    MULT = 270,
    DIVIDE = 271,
    POWEROF = 272,
    IFAND = 273,
    IFOR = 274,
    AND = 275,
    OR = 276,
    XOR = 277,
    NAND = 278,
    VARIABLE = 279,
    EQUAL = 280,
    T_NEWLINE = 281,
    SEMI = 282,
    OPENING_PAR = 283,
    CLOSING_PAR = 284,
    OPENING_CURLY = 285,
    CLOSING_CURLY = 286,
    BOOLEAN_EQUAL = 287,
    BOOLEAN_LESS = 288,
    BOOLEAN_GREATER = 289,
    BOOLEAN_LESS_EQUAL = 290,
    BOOLEAN_GREATER_EQUAL = 291
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

#line 97 "yac.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_YAC_TAB_H_INCLUDED  */
