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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
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
    VOID = 258,
    INT = 259,
    FLOAT = 260,
    CHAR = 261,
    CONSTANT = 262,
    IDENTIFIER = 263,
    IF = 264,
    ELSE = 265,
    RETURN = 266,
    DO = 267,
    WHILE = 268,
    FOR = 269,
    INC_OP = 270,
    DEC_OP = 271,
    U_PLUS = 272,
    U_MINUS = 273,
    EQUAL = 274,
    NOT_EQUAL = 275,
    GREATER_OR_EQUAL = 276,
    LESS_OR_EQUAL = 277,
    SHIFTLEFT = 278,
    LOG_AND = 279,
    LOG_OR = 280
  };
#endif
/* Tokens.  */
#define VOID 258
#define INT 259
#define FLOAT 260
#define CHAR 261
#define CONSTANT 262
#define IDENTIFIER 263
#define IF 264
#define ELSE 265
#define RETURN 266
#define DO 267
#define WHILE 268
#define FOR 269
#define INC_OP 270
#define DEC_OP 271
#define U_PLUS 272
#define U_MINUS 273
#define EQUAL 274
#define NOT_EQUAL 275
#define GREATER_OR_EQUAL 276
#define LESS_OR_EQUAL 277
#define SHIFTLEFT 278
#define LOG_AND 279
#define LOG_OR 280

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 44 "syntaxChecker.y" /* yacc.c:1909  */

    char *str;
   

#line 109 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
