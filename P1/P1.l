%{

    #include<bits/stdc++.h>
    #include "P1.tab.h"
    extern void yyerror(const char *);
    using namespace std;
    int line_counter=1;
    
%}

%%

"class"   {yylval.str=strdup(yytext); return CLASS;}
"public"   {yylval.str=strdup(yytext); return PUBLIC;}
"static"   {yylval.str=strdup(yytext); return STATIC;}
"void"      {yylval.str=strdup(yytext); return VOID;}
"main"     {yylval.str=strdup(yytext); return MAIN;}
"String"   {yylval.str=strdup(yytext); return STRING;}
"System"   {yylval.str=strdup(yytext); return SYSTEM;}
"out"      {yylval.str=strdup(yytext); return OUT;}
"println"  {yylval.str=strdup(yytext); return PRINTLINE;}

"true"     {yylval.str=strdup(yytext); return TRUE;}
"false"     {yylval.str=strdup(yytext); return FALSE;}

"this"     {yylval.str=strdup(yytext); return THIS;}

"new"     {yylval.str=strdup(yytext); return NEW;}
"length"   {yylval.str=strdup(yytext); return LENGTH;}

"while"     {yylval.str=strdup(yytext); return WHILE;}
"if"     {yylval.str=strdup(yytext); return IF;}
"else"   {yylval.str=strdup(yytext); return ELSE;}

"int"     {yylval.str=strdup(yytext); return INT;}
"boolean"  {yylval.str=strdup(yytext); return BOOLEAN;}
"Function"  {yylval.str=strdup(yytext); return FUNCTION;}
"return"  {yylval.str=strdup(yytext); return RETURN;}
"extends"  {yylval.str=strdup(yytext); return EXTENDS;}
"#define" {yylval.str=strdup(yytext) ;return DEFINE;}

"import" {yylval.str=strdup(yytext); return IMPORT;}
"java.util.function.Function" {yylval.str=strdup(yytext); return HEAD;}









"("        {return '(';}
")"        {return ')';}
"["        {return '[';}
"]"        {return ']';}
"{"        {return '{';}
"}"        {return '}';}
"."        {return '.';}
","        {return ',';}
";"        {return ';';}
"+"        {return '+';}
"-"        {return '-';}
"*"        {return '*';}
"/"        {return '/';}
"="        {return '=';}
"!"        {return '!';}
"<"        {return '<';}
">"        {return '>';}

"[]"       {yylval.str=strdup(yytext); return DBRACKETS;}
"&&"       {yylval.str=strdup(yytext); return ANDAND;}
"||"       {yylval.str=strdup(yytext); return OROR;}
"!="       {yylval.str=strdup(yytext); return NE;}
"<="       {yylval.str=strdup(yytext); return LE;}
"->"       {yylval.str=strdup(yytext); return ACCESSOR;}

[_a-zA-Z][_0-9a-zA-Z]*    {yylval.str=strdup(yytext); return IDENTIFIER;}
0|[1-9][0-9]*              {yylval.val=atoi(yytext); return NUMBER;}
"//".*"\n"             {}
"/*"([^*]|\*+[^*/]|\n)*\*+"/"   {  }
[ \t\r\n]                    {}
.                        {yyerror("");}
%%

int yywrap(void){
    return 1;
}

