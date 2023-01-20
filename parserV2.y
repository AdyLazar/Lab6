%{
#include <stdio.h>
#include <stdlib.h>

#define YYDEBUG 1 
%}

%token MAIN
%token DEC
%token CHAR
%token REAL
%token WHILE
%token IF
%token ELSE
%token EXTRACT
%token INJECT
%token THEN
%token DO

%token plus
%token minus
%token mul
%token division
%token eq
%token equal
%token different
%token less
%token more
%token lessOrEqual
%token moreOrEqual

%token leftRoundBracket
%token rightRoundBracket
%token semicolon
%token colon
%token dot
%token comma
%token leftSquaredBracket
%token rightSquaredBracket
%token leftCurlyBrace
%token rightCurlyBrace

%token IDENTIFIER
%token NUMBER_CONST
%token STRING_CONST
%token CHAR_CONST

%start program

%%

program : DEC MAIN rightRoundBracket leftRoundBracket cmpdstmt 
cmpdstmt : leftCurlyBrace stmtlist rightCurlyBrace
stmtlist : stmt | decllist | stmt semicolon stmtlist
stmt : simplstmt | structstmt 
simplstmt : assignstmt | iostmt
assignstmt : IDENTIFIER eq expression
expression : expression plus term | term
term : term mul factor | factor
factor : rightRoundBracket expression leftRoundBracket | IDENTIFIER
iostmt : EXTRACT leftRoundBracket IDENTIFIER leftRoundBracket | INJECT leftRoundBracket IDENTIFIER rightRoundBracket
structstmt : cmpdstmt | ifstmt | whilestmt
ifstmt : IF leftRoundBracket condition rightRoundBracket leftCurlyBrace stmtlist leftSquaredBracket ELSE leftCurlyBrace stmtlist rightCurlyBrace rightSquaredBracket rightCurlyBrace
whilestmt : WHILE leftRoundBracket condition rightRoundBracket leftCurlyBrace stmtlist rightCurlyBrace
condition : expression relation expression
decllist : declaration | declaration semicolon decllist
declaration : type IDENTIFIER
type1 : DEC | CHAR | REAL
arraydecl : type1 leftSquaredBracket NUMBER_CONST rightSquaredBracket 
type : type1|arraydecl
relation : less | lessOrEqual | equal | different | more | moreOrEqual 

%%

yyerror(char *s)
{	
	printf("%s\n",s);
}

extern FILE *yyin;

main(int argc, char **argv)
{
	if(argc>1) yyin :  fopen(argv[1],"r");
	if(argc>2 && !strcmp(argv[2],"-d")) yydebug: 1;
	if(!yyparse()) fprintf(stderr, "\tProgram is syntactically correct.\n");
}