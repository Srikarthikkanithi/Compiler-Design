%union {
    char* str;
    int val;
}

%{
    #include<bits/stdc++.h>
    using namespace std;
    int yylex(void);
    void yyerror(const char *);
    string trim(string &s) {
        size_t start = s.find_first_not_of(" \n\r\t");
        size_t end = s.find_last_not_of(" \n\r\t");
        return (start == string::npos) ? "" : s.substr(start, end - start + 1);
    }
    map<string,pair<string,string>> macro_info_expr;
    map<string,pair<string,string>> macro_info_stmt;
%}


%token<str> ANDAND OROR NE LE  ACCESSOR DBRACKETS  DEFINE
%token<str> CLASS PUBLIC STATIC VOID MAIN STRING SYSTEM OUT PRINTLINE IDENTIFIER TRUE FALSE THIS 
%token<str> NEW INT LENGTH WHILE BOOLEAN FUNCTION RETURN EXTENDS IF ELSE
%token<str> IMPORT HEAD
%token<val> NUMBER
%type<str> goal mainclass expression  primary_expression   optional_extends
%type<str> expressionlist expressionrest expressionlistopt expressionrest_mult binary_operator
%type<str> block while_statement  if_statement  optional_array print_statement statement mult_statement
%type<str> formal_parameter formal_parameter_list mult_formal_parameter_rest formal_parameter_rest  optional_formal_parameter_list
%type<str> variable_declaration method_declaration  mult_method_declaration mult_var_declaration 
%type<str> type type_declaration parted_class_declaration parted_class_declarations mult_type_declaration
%type<str> mult_rest_identifier  rest_identifier  mult_identifier_optional  optional_import
%type  macro_def_statement mult_macro_def
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%%

goal :
     optional_import mult_macro_def mainclass mult_type_declaration {string temp = string($1) + string($3) + string($4) ; $$ = strdup(temp.c_str());cout<<temp<<endl; }
     ;

mainclass :
          CLASS IDENTIFIER '{' PUBLIC STATIC VOID MAIN '(' STRING DBRACKETS IDENTIFIER ')' '{' print_statement '}' '}' {
            string temp = string($1) + " " + string($2) + " {\n" + 
            + "     " +string($4) + " " + string($5) + " " + string($6) + " "
            + string($7) + " ( " + string($9) + "[]" + string($11) + " ) {\n" 
            + "         " +string($14) + "\n"
            + "     }\n"
            + "}\n";
            $$ = strdup(temp.c_str());
          }
          ;

print_statement:
          SYSTEM '.' OUT '.' PRINTLINE '(' expression ')' ';' {string temp = string($1) + "." + string($3) + "." + string($5) + " ( " + string($7) + " ) ; " ; $$ = strdup(temp.c_str()); }
        ;

expression:
           primary_expression binary_operator primary_expression  {string temp = string($1) + " " + string($2) + " " + string($3); $$=strdup(temp.c_str()); }
         | primary_expression '[' primary_expression ']' {string temp = string($1) + " [ " + string($3) + " ] " ; $$ = strdup(temp.c_str());}  
         | primary_expression '.' LENGTH {string temp = string($1) + "." + string($3); $$ = strdup(temp.c_str());}
         | primary_expression             {$$ = strdup($1);}
         | primary_expression '.' IDENTIFIER  '(' expressionlistopt ')' {string temp = string($1) + "." + string($3) + " ( " + string($5) + " ) "; $$ = strdup(temp.c_str()); }
         | '(' IDENTIFIER ')' ACCESSOR expression {string temp = "(" + string($2) + ") ->" +  string($5) ; $$ = strdup(temp.c_str());}
         | IDENTIFIER '(' expressionlistopt ')' {
                                                 if(macro_info_expr.find(string($1))==macro_info_expr.end()){
                                                      yyerror("");
                                                      
                                                    }
                                                    string temp3 = string($3);
                                                    string temp1 = macro_info_expr[string($1)].first,temp2 = macro_info_expr[string($1)].second; 
                                                    vector<string> vec1,vec2,vec3;
                                                    stringstream ss1(temp1);
                                                    stringstream ss2(temp2);
                                                    stringstream ss3(temp3);
                                                    string word1,word2,word3;
                                                    while(getline(ss1,word1, ',')){
                                                      vec1.push_back(trim(word1));
                                                    }
                                                    while(getline(ss2,word2, ' ')){
                                                      vec2.push_back(word2);
                                                    }
                                                    while(getline(ss3,word3, ',')){
                                                      vec3.push_back(trim(word3));
                                                    }
                                                    if(vec1.size()!=vec3.size()){
                                                      yyerror("");
                                                    }
                                                    map<string,string> parameter_map;
                                                    for(int i=0;i<vec1.size();i++){
                                                      parameter_map[vec1[i]] = vec3[i];
                                                    }
                                                    string temp ="";
                                                    //  for(auto& i:vec2){
                                                    //   cout<<i<<endl;
                                                    // }
                                                    for(int i=0;i<vec2.size();i++){
                                                      if(parameter_map.find(vec2[i])==parameter_map.end()){
                                                        temp= temp + (vec2[i]) ;                                                        
                                                      }else{
                                                        temp += "(" + parameter_map[vec2[i]] + ")";                                                
                                                      }
                                                      temp+=(" ");
                                                    }
                                                    // cout<<temp<<"hellofolks1"<<endl;
                                                    temp.pop_back();
                                                    $$ = strdup(temp.c_str());
                                                }
         ;

primary_expression:
                 NUMBER  {$$ = strdup((to_string($1)).c_str()); }
                | TRUE     {$$ =strdup($1); }
                | FALSE     {$$ =strdup($1);}
                | IDENTIFIER   {$$ =strdup($1); }
                | THIS        {$$ =strdup($1); }
                | NEW INT '[' expression ']'  {string temp = string($1)+ " " + string($2) + " [ " + string($4) + " ] " ; $$ = strdup(temp.c_str());}
                | NEW IDENTIFIER '(' ')' {string temp = string($1) + " " + string($2) + " () " ; $$ = strdup(temp.c_str());}
                | '!' expression {string temp = "!"+ string($2); $$ = strdup(temp.c_str());}
                | '(' expression ')' {string temp = "( " + string($2) + ')'; $$ = strdup(temp.c_str());}
                | '(' IDENTIFIER ')' {string temp = "( " + string($2) + ')'; $$ = strdup(temp.c_str());}
                ;

binary_operator :
                ANDAND {$$ = strdup($1);}
              | OROR  {$$ = strdup($1);}
              | NE    {$$ = strdup($1);}
              | LE    {$$ = strdup($1);}
              | '+'   {$$ = strdup("+");}
              | '-'   {$$ = strdup("-");}
              | '*'   {$$ = strdup("*");}
              | '/'   {$$ = strdup("/");}
              ;


expressionlistopt:
                  expressionlist  {$$ = strdup($1);}
                |                 {$$ = strdup("");}
                ;
            
expressionlist :
               expression expressionrest_mult {string temp = string($1) + " " + string($2); $$ = strdup(temp.c_str());}
               ;

expressionrest_mult :
                   expressionrest expressionrest_mult  {string temp = string($1) + string ($2) ; $$ = strdup(temp.c_str());}
                |                    {$$ = strdup("");}
                ;

expressionrest :
               ',' expression {string temp = " , " + string($2) + " " ; $$ = strdup(temp.c_str());}
               ;

statement:
          block {$$ = strdup($1);}
        | print_statement {$$ = strdup($1);}
        | while_statement {$$ = strdup($1);}
        | if_statement {$$ =strdup($1);}
        | IDENTIFIER '='  expression ';' {string temp = string($1) + " = " + string($3) + " ; "; $$ = strdup(temp.c_str()); }
        | IDENTIFIER '[' expression ']' '=' expression ';' {string temp = string($1) + "[" + string($3) + " ] = " + string($6) + " ; "; $$ = strdup(temp.c_str()); }
        | IDENTIFIER '(' expressionlistopt ')' ';' {
                                                   if(macro_info_stmt.find(string($1))==macro_info_stmt.end()){
                                                      yyerror("");
                                                    }
                                                    string temp3 = string($3);
                                                    string temp1 = macro_info_stmt[string($1)].first,temp2 = macro_info_stmt[string($1)].second; 
                                                    vector<string> vec1,vec2,vec3;
                                                    stringstream ss1(temp1);
                                                    stringstream ss2(temp2);
                                                    stringstream ss3(temp3);
                                                    string word1,word2,word3;
                                                    while(getline(ss1,word1, ',')){
                                                      vec1.push_back(trim(word1));
                                                    }
                                                    while(getline(ss2,word2, ' ')){
                                                      vec2.push_back(word2);
                                                    }
                                                    while(getline(ss3,word3, ',')){
                                                      vec3.push_back(trim(word3));
                                                    }
                                                    if(vec1.size()!=vec3.size()){
                                                      
                                                      yyerror("");
                                                      
                                                    }
                                                    map<string,string> parameter_map;
                                                    for(int i=0;i<vec1.size();i++){
                                                      parameter_map[vec1[i]] = vec3[i];
                                                    }
                                                    string temp ="";
                                                    for(int i=0;i<vec2.size();i++){
                                                      if(parameter_map.find(vec2[i])==parameter_map.end()){
                                                        temp = temp + (vec2[i]) ;                                                        
                                                      }else{
                                                        temp =temp + (parameter_map[vec2[i]]);                                                
                                                      }
                                                      temp+=(" ");
                                                    }
                                                    temp.pop_back();
                                                    $$ = strdup(temp.c_str());
                                                    }
        ;

block :
       '{' mult_statement '}'   {string temp = " {\n" + string($2) + " \n}"; $$  = strdup(temp.c_str());}
       ;

mult_statement :
                 statement mult_statement{string temp = string($1) + "\n" +  string($2); $$ = strdup(temp.c_str());}
              |                          {$$ = strdup("");}
              ;

                  
while_statement : 
                 WHILE '(' expression ')' statement {string temp = string($1) + " ( " + string($3) + " ) " + string($5); $$ = strdup(temp.c_str());}

if_statement : 
              IF '(' expression ')' statement %prec LOWER_THAN_ELSE {string temp = string($1) + " ( " + string($3) + " ) " + string($5) + " \n "  ; $$ = strdup(temp.c_str());}
            | IF '(' expression ')' statement ELSE statement  {string temp = string($1) + " ( " + string($3) + " ) " + string($5) +  " \n " + string($6) + " \n " + string($7)  ; $$ = strdup(temp.c_str());}
              ;



type :
      INT optional_array {string temp = string($1) + " " + string($2) ; $$ = strdup(temp.c_str());}
    | BOOLEAN  {$$ = strdup($1);}
    | IDENTIFIER   {$$ = strdup($1);}
    | FUNCTION '<' IDENTIFIER ',' IDENTIFIER '>' {string temp = string($1) + " < " + string($3) + "," + string($5) + " > "; $$ = strdup(temp.c_str());}
    ;

optional_array :
                DBRACKETS {$$ = strdup($1);}
              |         {$$ = strdup("");}
              ;


formal_parameter_list :
                       formal_parameter mult_formal_parameter_rest {string temp = string($1) + string($2) ; $$ = strdup(temp.c_str()); }
                       ;

mult_formal_parameter_rest :
                            mult_formal_parameter_rest formal_parameter_rest {string temp = string($1) + string($2); $$ = strdup(temp.c_str());}
                          |                                                 {$$ = strdup("");}
                          ;

formal_parameter_rest : 
                       ',' formal_parameter {string temp = " , " + string($2) ; $$ = strdup(temp.c_str());  }
                      ;   

formal_parameter :
                   type IDENTIFIER { string temp = string($1) + " " + string($2) ; $$ = strdup(temp.c_str());  }
                  ;

variable_declaration:
                     formal_parameter ';' {string temp = string($1) + " ; "; $$ = strdup(temp.c_str());}
                    ;

method_declaration :
                    PUBLIC formal_parameter '(' optional_formal_parameter_list ')' '{' mult_var_declaration mult_statement RETURN expression ';' '}' {string temp = string($1) + " " + string($2) + " ( " + string($4) + " ) {\n " + string($7) + string($8) + string($9) + " " + string($10) + "; \n }\n" ; $$ = strdup(temp.c_str()); }
                  ;

mult_method_declaration :
                        method_declaration mult_method_declaration {string temp = string($1) + "\n" + string($2); $$ = strdup(temp.c_str());}
                      |                                             {$$ = strdup("");}
                      ;

optional_formal_parameter_list :
                                formal_parameter_list {$$ = strdup($1); }
                              |                       {$$ = strdup("");}
                              ;

mult_var_declaration  :
                        mult_var_declaration variable_declaration {string temp = string($1) + "\n" + string($2); $$ = strdup(temp.c_str());}
                      |                                           {$$ = strdup("");}
                      ;

type_declaration  : 
                   CLASS IDENTIFIER parted_class_declarations  {string temp = string($1) + " " + string($2) + " " + string($3) + "\n"; $$ = strdup(temp.c_str());}
                  ;

parted_class_declarations :
                          optional_extends parted_class_declaration {string temp = string($1) + " " + string($2); $$ = strdup(temp.c_str());}
                          ;

optional_extends:
                                   {$$ = strdup("");}
              | EXTENDS IDENTIFIER {string temp = string($1) + " " + string($2) ; $$ = strdup(temp.c_str());}

parted_class_declaration :
                            '{' mult_var_declaration mult_method_declaration '}' {string temp = "{ \n" + string($2) + string($3) + " }"; $$ = strdup(temp.c_str());}
                          ;

mult_type_declaration :
                       type_declaration mult_type_declaration {string temp = string($1) + string($2) ; $$ = strdup(temp.c_str()); }
                      |                                       {$$ = strdup("");}
                      ;

mult_rest_identifier :                                      
                                                           {$$=strdup("");}
                     |rest_identifier mult_rest_identifier {string temp = string($1) + " " + string($2); $$ = strdup(temp.c_str()); }  
                     ;

rest_identifier  :
                 ',' IDENTIFIER {string temp = " , " + string($2) ; $$ = strdup(temp.c_str()); }  
                 ;

mult_identifier_optional :
                         IDENTIFIER mult_rest_identifier  {string temp = string($1) + " " + string($2); $$ = strdup(temp.c_str()); }
                        |                 {$$ = strdup("");}
                        ;

macro_def_statement :
                     DEFINE IDENTIFIER '(' mult_identifier_optional ')' '{' mult_statement '}' {string temp = string($7) ; macro_info_stmt[string($2)]={string($4),temp};}
                    |  DEFINE IDENTIFIER '(' mult_identifier_optional ')' '(' expression ')'  {string temp = "( " + string($7) + " )" ;macro_info_expr[string($2)]={string($4),temp};}
                     ;


mult_macro_def :
               macro_def_statement mult_macro_def {}
              |  {}
              ;
                     

optional_import :
                     {$$ = strdup("");}
                | IMPORT HEAD  ';' { string temp = "import java.util.function.Function;" ; $$ = strdup(temp.c_str());}
                ;

                      



                    



%%

void yyerror(const char *s) {
    extern int line_counter;
    cout<<"// Failed to parse macrojava code.";
    exit(1);
}
int main (void){
    return yyparse();
}