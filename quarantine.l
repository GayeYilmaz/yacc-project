%{

#include "y.tab.h"
#include<stdio.h>
%}

digit	[0-9]
dot	"."
id	[a-z]
idc    [A-Z]
num	[0-9]+
bop	<|>|!=|<=|>=|==|&&|"||"

comment "/*"([^*]|\*+[^*/])*\*+"/"


%%
"^"                     {printf(" TOTHEPOWER ");}
\=                    {return EQUALS ;}
"=="                    {return ISEQUAL ;}
"while "                  {return WHILE ;}
"for "                    {return FOR ;}
"if "                     {return IF ;}
"else "                   {return ELSE ;}

"printf  "                 {return PRINT ;}
"int "                  {return INT ;}
"char"                   {return CHAR ;}
"true"                {return BOOLEAN;}
"false"                {return BOOLEAN;}
"float"                 {return FLOAT ;}
"void"                   {return VOID ;}
"!= "                   {return NE ;}

\<=                    {return LE;}
\>=                     {return GE;}
'<'						 {return GT;}
'>'						 {return LT ;}
"&&"                     {return AND ;}
"||"                     {return OR;}
"double"                   {return DOUBLE ;}
"struct"                  {return STRUCTER ;}
,                   {return COMA;}
[+-/*]               {return OP;} 
["]([^"\\\n]|\\.)*["]     {return STRING ; }
[//][^\r\n]*             {return COMMENT;}
{comment}                {return COMMENT;}
{num}                 { return NUM;}

\{                       {return OBC;}
\}                      {return CBC;}
\(                       {return OB;}
\)                        {return CB;}
\[                       {return OSB;}
\]                        {return CSB;}
'.'                          {return DOT;}
({idc})*                 {return  CONSTANT;}
{id}	                 {return  CHARACTER ;}
({id})*	                 {return  ID;}
[\t]+                     ;
[\n]                     {return '\n';}
.                        {return yytext[0];}
%%
