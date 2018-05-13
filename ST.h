/***************************************************************************
Symbol Table Module
***************************************************************************/
/*=========================================================================
DECLARATIONS
=========================================================================*/
/*-------------------------------------------------------------------------
SYMBOL TABLE RECORD
-------------------------------------------------------------------------*/
#include "types.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
typedef enum { integert, floatt, chart } value_type_enum;

struct symrec
{
	char*name;
	union Data value;
	char* type;
	int flag;
	struct symrec *next; /* link field */
};
typedef struct symrec symrec;
symrec *sym_table = (symrec *)0;
symrec *putsym ();
symrec *putsym_1 ();
symrec *getsym ();
/*-------------------------------------------------------------------------
SYMBOL TABLE ENTRY
-------------------------------------------------------------------------*/
symrec *putsym ( char *sym_name,union Data v,char* type, int f )
{
	symrec *ptr;
	ptr = (symrec *) malloc (sizeof(symrec));
	ptr-> name = (char *) malloc (strlen(sym_name)+1);
	strcpy(ptr ->name,sym_name);
	ptr ->flag=f;
	ptr ->type= type;
	if(strcmp(type,"int")==0)
	{	//if(v.i !=NULL)
		//{
		ptr ->value.i=v.i;
		//}
	}
	 if(strcmp(type,"float")==0)
	{	//if(v.f !=NULL)
		//{
		ptr ->value.f=v.f;
		//}
	}
	if(strcmp(type,"char")==0)
	{
		ptr ->value.ch=v.ch;

	}
	ptr ->next = (struct symrec *)sym_table;
	sym_table = ptr;

	return ptr;
}
symrec *putsym_1 ( char *sym_name,char* type, int f )
{	symrec *ptr;
	ptr = (symrec *) malloc (sizeof(symrec));
	ptr-> name = (char *) malloc (strlen(sym_name)+1);
	strcpy(ptr ->name,sym_name);
	ptr ->flag=f;
		ptr ->type= type;

	ptr ->next = (struct symrec *)sym_table;
	sym_table = ptr;
	return ptr;}
symrec *getsym ( char *sym_name )
{	//printf("%s\n", sym_name);
	symrec *ptr;
	for (ptr = sym_table; ptr != (symrec *) 0;ptr = (symrec *)ptr->next)
	{
				
		if(strcmp (ptr->name,sym_name) == 0)
			{
				// printf("%s\n  hekki", ptr->name);
				return ptr;

			}
	}
	return 0;
}
/************************** End Symbol Table **************************/