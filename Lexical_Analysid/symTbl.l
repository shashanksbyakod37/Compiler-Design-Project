%option noyywrap
%{
    #include<string.h>
    #include<stdio.h>
    #include "symTbl.tab.h"
    int line = 0;
    #define YYSTYPE char *
    #define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno;
%}

alpha [A-Za-z_]
digit [0-9]
%option yylineno
%%
"/*"					{ multicomment(); }
"//"					{ singlecomment(); }
[ \t\n] {yylval = strdup(yytext);}
":" {yylval = strdup(yytext);return T_colon;}
"?" {yylval = strdup(yytext);return T_ques;}
"while" {yylval = strdup(yytext);return WHILE;}
"do"	{yylval = strdup(yytext);return DO;}
"for" {yylval = strdup(yytext);return FOR;}
"if" {yylval = strdup(yytext);return IF;}
"else" {yylval = strdup(yytext);return ELSE;}
"printf" {yylval = strdup(yytext);return PRINTF;}
"break" {yylval = strdup(yytext);return BREAK;}
"continue" {yylval = strdup(yytext);return CONTINUE;}
"int" {yylval = strdup(yytext);return INT;}
"float" {yylval = strdup(yytext);return FLOAT;}
"char" {yylval = strdup(yytext);return CHAR;}
"void" {yylval = strdup(yytext);return VOID;}
"#include" {yylval = strdup(yytext);return INCLUDE;}
"main()" {yylval = strdup(yytext);return MAINTOK;}
{digit}+    {yylval = strdup(yytext);return NUM;}
{digit}+.{digit}+ {yylval = strdup(yytext);return FLOAT;}
{alpha}({alpha}|{digit})* {yylval = strdup(yytext);return ID;}
{alpha}({alpha}|{digit})*"\.h"?  {yylval = strdup(yytext);return H;}
\".*\" {yylval = strdup(yytext);return STRING;}
"<" {yylval = strdup(yytext);return T_lt;}
">"     {yylval = strdup(yytext);return T_gt;}
"="     {yylval = strdup(yytext);return T_eq;}
"<="    {yylval = strdup(yytext);return T_lteq;}
">="    {yylval = strdup(yytext);return T_gteq;}
"=="    {yylval = strdup(yytext);return T_eqeq;}
"!="    {yylval = strdup(yytext);return T_neq;}
"+"     {yylval = strdup(yytext);return T_pl;}
"-"     {yylval = strdup(yytext);return T_min;}
"*"     {yylval = strdup(yytext);return T_mul;}
"/"     {yylval = strdup(yytext);return T_div;}
"++"    {yylval = strdup(yytext);return T_incr;}
"--"    {yylval = strdup(yytext);return T_decr;}
"!"     {yylval = strdup(yytext);return T_neq;}
"||"    {yylval = strdup(yytext);return T_or;}
"&&"    {yylval = strdup(yytext);return T_and;}


.    return yytext[0];

%%


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
