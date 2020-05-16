%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
int yyerror();
%}

%start grammar

%left OP
%token NUM ID 
%token WHILE FOR 
%token IF  ELSE PRINT 
%token INT CHAR BOOLEAN FLOAT DOUBLE VOID
%token STRUCTER
%token COMMENT 
%token CONSTANT
%token CHARACTER  STRING
%token COMA
%token GE LE GT LT NE AND OR
%left  DOT ISEQUAL OBC CBC OB CB EQUALS  CSB OSB


%%
grammar: start'\n'{printf("TRUE "); exit(0);};
start:  Function
    |COMMENT
    | Declaration 
	 ;

/* Declaration block */
Declaration: Type Assignment ';'
    | Assignment ';'
    | FunctionCall ';'
    | ArrayUsage ';'
    | Type ArrayUsage ';'
    | StructStmt ';'
    | error
    ;

/* Assignment block */
Assignment: ID EQUALS Assignment
    | ID EQUALS FunctionCall
    | ID EQUALS ArrayUsage
    | ArrayUsage EQUALS Assignment
    | ID COMA Assignment
    | Assignment NE Assignment
	| NUM COMA Assignment
    | ID OP  Assignment
    | NUM OP Assignment
    | OB  Assignment CB
    |   NUM
    |   ID
    ;

/* Function Call Block */
FunctionCall : ID OB CB
    | ID OB Assignment CB
    ;

/* Array Usage */
ArrayUsage : ID OSB Assignment CSB
    ;

/* Function block */
Function: Type ID OB  ArgListOpt CB CompoundStmt
    ;
ArgListOpt: ArgList
    |
    ;
ArgList:  ArgList ',' Arg
    | Arg
    ;
Arg:    Type ID
    ;
CompoundStmt:   OBC StmtList CBC
    ;
StmtList:StmtList Stmt
    |
    ;
Stmt:   WhileStmt
    | Declaration
    | ForStmt
    | IfStmt
    | PrintFunc
    ;

/* Type Identifier block */
Type:   INT
    | FLOAT
    | CHAR
    | DOUBLE
    | VOID
    ;

/* Loop Blocks */
WhileStmt: WHILE OB Expr CB Stmt
    | WHILE OB Expr CB CompoundStmt
    ;

/* For Block */
ForStmt: FOR OB Expr ';' Expr ';' Expr CB Stmt
       | FOR OB Expr ';' Expr ';' Expr CB CompoundStmt
       | FOR OB Expr CB Stmt
       | FOR OB Expr CB CompoundStmt
    ;

/* IfStmt Block */
IfStmt : IF OB Expr CB Stmt ELSE Stmt
    ;

/* Struct Statement */
StructStmt : STRUCTER ID OBC Type Assignment CBC
    ;

/* Print Function */
PrintFunc : PRINT OB Expr CB ';'
    ;

/*Expression Block*/
Expr:
    | Expr NE Expr
	| Expr LE Expr
	| Expr GE Expr
	| Expr GT Expr
	| Expr LT Expr
	| Expr AND Expr
	| Expr OR Expr
	|Expr ISEQUAL Expr
	|Expr EQUALS Expr
	| Assignment
    | ArrayUsage
    ;
%%
int main()
{
printf("Enter Code\n");
yyparse();
return 0;
}
yyerror()
{
printf("FALSE :");
exit(0);
}
