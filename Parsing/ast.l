
%{
    #include<string.h>
    #include<stdio.h>
    #include "ast.tab.h"
%}

alpha [A-Za-z_]
digit [0-9]
%option yylineno

%%
[ \t\n] ;
"/*"					{ multicomment(); }
"//"					{ singlecomment(); }
":" {return T_colon;}
"?" {return T_ques;}
"while" {return(WHILE);}
"for" {return FOR;}
"if" {return IF;}
"else" {return ELSE;}
"printf" {printf("%c",*yytext);return *yytext;}
"break" {return BREAK;}
"continue" {return CONTINUE;}
"int" {return INT;}
"float" {return FLOAT;}
"char" {return CHAR;}
"void" {return VOID;}
"#include" {return INCLUDE;}
"main()" {return MAINTOK;}
{digit}+    {yylval = (int)yytext; return NUM;}
{digit}+.{digit}+ {return FLOAT;}
{alpha}({alpha}|{digit})* {yylval = yytext;return ID;}
{alpha}({alpha}|{digit})*"\.h"?  {return H;}
\".*\" {return STRING;}
"<" {return T_lt;}
">"     {return T_gt;}
"="     {return T_eq;}
"<="    {return T_lteq;}
">="    {return T_gteq;}
"=="    {return T_eqeq;}
"!="    {return T_neq;}
"+"     {return T_pl;}
"-"     {return T_min;}
"*"     {return T_mul;}
"/"     {return T_div;}
"++"    {return T_incr;}
"--"    {return T_decr;}
"!"     {return T_neq;}
"||"    {return T_or;}
"&&"    {return T_and;}


.    return yytext[0];

%%

yywrap()
{
	return(1);
}

multicomment()
{
	char c, c1;
	while ((c = input()) != '*' && c != 0);
	c1=input();
	if(c=='*' && c1=='/')
	{
		c=0;
	}
	if (c != 0)
		putchar(c1);
}
singlecomment()
{
	char c;
	while(c=input()!='\n');
	if(c=='\n')
		c=0;
	if(c!=0)
		putchar(c);
}
