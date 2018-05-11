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
    MINUS = 276,
    PLUS = 277,
    MULT = 278,
    DIVIDE = 279,
    POWEROF = 280,
    IFAND = 281,
    IFOR = 282,
    AND = 283,
    OR = 284,
    XOR = 285,
    NOT = 286,
    EQUAL = 287,
    T_NEWLINE = 288,
    SEMI = 289,
    OPENING_PAR = 290,
    CLOSING_PAR = 291,
    OPENING_CURLY = 292,
    CLOSING_CURLY = 293,
    BOOLEAN_EQUAL = 294,
    BOOLEAN_LESS = 295,
    BOOLEAN_GREATER = 296,
    BOOLEAN_LESS_EQUAL = 297,
    BOOLEAN_GREATER_EQUAL = 298,
    BOOLEAN_NOT_EQUAL = 299
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_YAC_TAB_H_INCLUDED  */
