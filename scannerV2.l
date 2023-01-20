
%{ 	 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int currentLine = 1;
%} 

%option noyywrap
 
IDENTIFIER		[a-zA-Z][a-zA-Z0-9_]*
NUMBER_CONST	0|[+|-]?[1-9][0-9]*([.][0-9]*)?|[+|-]?0[.][0-9]*
STRING_CONST	[\"][a-zA-Z0-9_]*[\"]

%%
"dec"		{printf("Reserved token: %s\n", yytext);return DEC;}
"real"		{printf("Reserved token: %s\n", yytext);return REAL;}
"char"		{printf("Reserved token: %s\n", yytext);return CHAR;}
"while"		{printf("Reserved token: %s\n", yytext);return WHILE;}
"if"		{printf("Reserved token: %s\n", yytext);return IF;}
"else"		{printf("Reserved token: %s\n", yytext);return ELSE;}
"extract"	{printf("Reserved token: %s\n", yytext);return EXTRACT;}
"inject"	{printf("Reserved token: %s\n", yytext);return INJECT;}

"+"			{printf("Operator: %s\n", yytext);return plus;}
"-"			{printf("Operator: %s\n", yytext);return minus;}
"*"			{printf("Operator: %s\n", yytext);return mul;}
"/"			{printf("Operator: %s\n", yytext);return division;}
"="			{printf("Operator: %s\n", yytext);return eq;}
"=="		{printf("Operator: %s\n", yytext);return equal;}
"<>"		{printf("Operator: %s\n", yytext);return different;}
"<"			{printf("Operator: %s\n", yytext);return less;}
">"			{printf("Operator: %s\n", yytext);return more;}
"<="		{printf("Operator: %s\n", yytext);return lessOrEqual;}
">="		{printf("Operator: %s\n", yytext);return moreOrEqual;}

"("			{printf("Separator: %s\n", yytext);return leftRoundBracket;}
")"			{printf("Separator: %s\n", yytext);return rightRoundBracket;}
";"			{printf("Separator: %s\n", yytext);return semicolon;}
":"			{printf("Separator: %s\n", yytext);return colon;}
"."			{printf("Separator: %s\n", yytext);return dot;}
","			{printf("Separator: %s\n", yytext);return comma;}
"{"			{printf("Separator: %s\n", yytext);return leftCurlyBrace;}
"}"			{printf("Separator: %s\n", yytext);return rightCurlyBrace;}
"["			{printf("Separator: %s\n", yytext);return leftSquaredBracket;}
"]"			{printf("Separator: %s\n", yytext);return rightSquaredBracket;}

{IDENTIFIER}		{printf("Identifier: %s\n", yytext);return IDENTIFIER;}
{NUMBER_CONST}		{printf("Number: %s\n", yytext);return NUMBER_CONST;}
{STRING_CONST}		{printf("String: %s\n", yytext);return STRING_CONST;}

[ \t]+  	{}
[\n]+ {currentLine++;}

[0-9_][a-zA-Z0-9_]*		{printf("Illegal identifier at line %d\n", currentLine); return -1;}
[+|-]0		{printf("Illegal numeric constant at line %d\n", currentLine); return -1;}
[+|-]?[0][0-9]*([.][0-9]*)?		{printf("Illegal numeric constant at line %d\n", currentLine); return -1;}
[\"][a-zA-Z0-9_]+|[a-zA-Z0-9_]+[\"]		{printf("Illegal string constant at line %d\n", currentLine); return -1;}

%%