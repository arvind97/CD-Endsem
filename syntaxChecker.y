%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
void addToSymbol(char *);
struct symbol{
	char *token;
	char *type;
	char *dataType;
	char *scope;
	struct symbol *next;
};
typedef struct symbol symbol;
symbol *symPtr;
extern int yylineno;
extern FILE *yyin;
extern char *yytext;
extern char *tempid;
int errorFlag = 0;
FILE * sourceCode;
char type=' ';
char dataType=' ';
int funcCount=0;
extern int scope;
%}

%token VOID INT FLOAT CHAR CONSTANT IDENTIFIER
%token IF ELSE RETURN DO WHILE FOR
%token INC_OP DEC_OP U_PLUS U_MINUS  
%token EQUAL NOT_EQUAL GREATER_OR_EQUAL LESS_OR_EQUAL SHIFTLEFT LOG_AND LOG_OR

%right '='
%left LOG_OR    
%left LOG_AND
%left '<' '>' LESS_OR_EQUAL GREATER_OR_EQUAL
%left EQUAL NOT_EQUAL
%left SHIFTLEFT
%left '+' '-'
%left '*' '/' '%'
%right U_PLUS U_MINUS '!'
%left INC_OP DEC_OP

%union
{
    char *str;   
}

%type <str> id IDENTIFIER
%start program_head
%%

program_head
    : program
	
    ;

program
    : function
       
    | program function
       
    ;
						


function
    : var_type id '(' parameter_list ')' ';'				{ type='p';addToSymbol($2); dataType=' ';type=' ';}
        
    | var_type id '(' parameter_list ')' function_body		        { 	funcCount++;
    										type='f';
    										addToSymbol($2);
    										dataType=' ';
    										type=' ';
    									}
       
    ;

function_body
    : '{' statement_list  '}'
       
    | '{' declaration_list statement_list '}'
        
    ;

declaration_list
    : declaration ';'
       
    | declaration_list declaration ';'
       
    ;

declaration
    : INT id		{ dataType='i';type='v';addToSymbol($2);dataType=' ';type=' ';}		
       
    | FLOAT id             {dataType='f';type='v';addToSymbol($2);dataType=' ';type=' ';}
    
    | INT id '[' CONSTANT ']' {dataType='i';type='a';addToSymbol($2);dataType=' ';type=' ';}
    
    | FLOAT id '[' CONSTANT ']' {dataType='f';type='a';addToSymbol($2);dataType=' ';type=' ';}
       
    | declaration ',' id

    | error
       
    ;

parameter_list
    : INT id  		  
        
    | FLOAT id		
        
    | parameter_list ',' INT id 
       
    | parameter_list ',' FLOAT id 
        
    | VOID
       
    |
        
    ;

var_type
    : VOID	{ dataType='v';}
        
    | INT        { dataType='i';}
       
   
    | FLOAT      { dataType='f';}
    
    | CHAR       { dataType='c';}
        
    ;

statement_list
    : statement
        
    | statement_list statement
        
    ;

statement
    
    : assignment ';' 
    
    | IF '(' assignment ')' statement
        
    | WHILE  '(' assignment ')' statement 
        
    | DO statement WHILE '(' assignment ')' ';'
        
    | FOR '(' assignment ';' assignment ';' assignment ')' statement 
    
    | RETURN ';'
        
    | RETURN assignment ';'
       
    | '{' statement_list '}'
        
    | '{' '}'
       
    ;
    
assignment
    : expression
      
    | id '=' expression     { 
    			}
    
    | id '[' expression ']' '=' expression
       
    ;

expression
    : INC_OP expression   
        
    | DEC_OP expression
       
    | expression LOG_OR  expression
       
    | expression LOG_AND  expression
        
    | expression NOT_EQUAL expression
       
    | expression EQUAL expression
        
    | expression GREATER_OR_EQUAL expression
        
    | expression LESS_OR_EQUAL expression
        
    | expression '>' expression  
        
    | expression '<' expression
       
   
    | expression '+' expression 	
        
    | expression '-' expression
       
    | expression '*' expression
       
    | expression '/' expression
        
    | expression '%' expression
       
    | '!' expression
       
    | U_PLUS expression
        
    | U_MINUS expression
        
    | CONSTANT        
        
    | '(' expression ')'
       
    | id '(' exp_list ')'
        
    | id '('  ')' 
    
    | id '[' expression ']'
       
    | id                                        
    ;

exp_list
    : expression
       
    | exp_list ',' expression
       
    ;

id
    : IDENTIFIER {   $$ = strdup(yytext);   }
       
    ;

%%

void yyerror()
{
	errorFlag=1;
	fflush(stdout);
	printf("\n%s : %d :Syntax error \n",sourceCode,yylineno);
}
void main(int argc,char **argv){
	if(argc<=1){
		
		printf("Invalid ,Expected Format : ./a.out <\"sourceCode\"> \n");
		return 0;
	}
	
	yyin=fopen(argv[1],"r");
	sourceCode=(char *)malloc(strlen(argv[1])*sizeof(char));
	sourceCode=argv[1];
	yyparse();
	
	
	if(!errorFlag){
		
		printf("\n\n\t\t%s Parsing Completed\n\n",sourceCode);
		FILE *writeSymbol=fopen("symbolTable.txt","w");
		for(symbol *p=symPtr;p!=NULL;p=p->next){
			fprintf(writeSymbol,"\n   %s       %s       %s     %s",p->token,p->type,p->dataType,p->scope);
		}
	}	
	
	
	return 1;
}
void addToSymbol(char *token){
		//printf("\n   %s       %c       %c     ",token,type,dataType);
		symbol *temp=(symbol *)malloc(sizeof(symbol));
		temp->token=strdup(token);
		temp->type=(char *)malloc(sizeof(char)*4);
		temp->dataType=(char *)malloc(sizeof(char)*5);
		switch(type){
		 case 'v' : strcpy(temp->type,"VAR");break;
		 case 'f' : strcpy(temp->type,"FUNC");break;
		 case 'p' : strcpy(temp->type,"PROT");break;
		 case ' ' : strcpy(temp->type,"     ");break;
		}
		switch(dataType){
		 case 'i' : strcpy(temp->dataType,"INT");break;
		 case 'f' : strcpy(temp->dataType,"FLOAT");break;
		 case 'c' : strcpy(temp->dataType,"CHAR");break;
		 case 'v' : strcpy(temp->dataType,"VOID");break;
		}
		temp->scope=(char *)malloc(sizeof(char)*10);
		if(scope==0){
			strcpy(temp->scope,"GLOBAL");
		}
		else{
			strcpy(temp->scope,"FUNC_");
			char count[10];
			snprintf(count,10,"%d",funcCount);
			strcat(temp->scope,count);
			//strcat(temp->scope,funcCount);;
		}
		
		
		
		if(symPtr==NULL){
			symPtr=temp;
		}
		else{
			symbol *p=symPtr;
			while(p->next!=NULL){
				if(strcmp(temp->token,p->token)==0){
					printf("\nMultiple Declaration ");
					exit(0);
				}
				p=p->next;
			}
			p->next=temp;
		}
		
}	
