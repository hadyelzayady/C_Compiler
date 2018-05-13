#include <stdio.h>
#include "ST.h"
#include "y.tab.h"

static int lbl;
static int t;

int ex(nodeType *p)
{
	int lbl1, lbl2;
	int tn;

	if(!p) return 0;
	switch (p->type)
	{
		case typeCon:
			printf("\t%d", p->con.value);
			return p->con.value;
			break;
		case typeId:
			printf("\t%c", p->id.i + 'a');
			break;
		case typeOpr:
			switch (p->opr.oper)
			{
				case WHILE:
					printf("L%03d:\n", lbl1=lbl++);
					ex(p->opr.op[0]);
					printf("\tjz\tL%03d\n", lbl2=lbl++);
					ex(p->opr.op[1]);
					printf("\tjmp\tL%03d\n", lbl1);
					printf("L%03d:\n", lbl2);
					ex(p->opr.op[2]);
					break;
				case IF:
					ex(p->opr.op[0]);
					if (p->opr.nops > 2)
					{
						printf("\tjz\tL%03d\n", lbl1=lbl++);
						ex(p->opr.op[1]);
						printf("\tjmp\tL%03d\n", lbl2=lbl++);
						printf("L%03d:\n", lbl1);
						ex(p->opr.op[2]);
						printf("L%03d:\n", lbl2);
					}
					else
					{
						printf("\tjz\tL%03d\n", lbl1=lbl++);
						ex(p->opr.op[1]);
						printf("L%03d:\n", lbl1);
					}
					break;
				case REPEAT:
					printf("\tL%03d:\n",lbl1=lbl++);
					ex(p->opr.op[0]);
					ex(p->opr.op[1]);
					printf("\tjnz\tL%03d\n",lbl1);
				case FOR:
					ex(p->opr.op[0]);
					printf("\tL\t%03d:", lbl1=lbl++);
					ex(p->opr.op[1]);
					printf("\tjz\tL%03d", lbl2=lbl++);
					ex(p->opr.op[2]);
					printf("\tjmp\tL%03d", lbl1);
					printf("\tL\t%03d:", lbl2);
					ex(p->opr.op[4]);
					break;
				case NOT:
					if (p->opr.op[0].type == typeOpr)
					{
						tn = ex(p->opr.op[0]);
					}

					printf("\tnot\t");
					if (p->opr.op[0].type == typeCon)
					{
						ex(p->opr.op[0]);
					}
					else if (p->opr.op[0].type == typeId)
					{
						ex(p->opr.op[0]);
					}
					else if (p->opr.op[0].type == typeOpr)
					{
						printf("\tt%d\t", tn);
					}
					printf("\tt%d\n", tn = t++);
					return tn;
					break;

				case EQUAL:
					if (p->opr.op[1].type == typeCon)
					{
						printf("\tEqual\t");
						ex(p->opr.op[1]);
						printf("\t%c\n", p->opr.op[0]->id.i + 'a');
					}
					else if (p->opr.op[1].type == typeId)
					{
						printf("\tEqual\t");
						ex(p->opr.op[1]);
						printf("\t%c\n", p->opr.op[0]->id.i + 'a');
					}
					else if (p->opr.op[1].type == typeOpr)
					{
						tn = ex(p->opr.op[1]);
						printf("\tEqual\t");
						printf("\tt%d\t"tn);
						printf("\t%c\n", p->opr.op[0]->id.i + 'a');
					}
					break;
				default:
					// ex(p->opr.op[0]);
					// ex(p->opr.op[1]);
					if (p->opr.op[0].type == typeOpr)
					{
						tn = ex(p->opr.op[0]);
					}
					if (p->opr.op[1].type == typeOpr)
					{
						tn = ex(p->opr.op[1]);
					}
					switch (ex(p->opr.oper))
					{
						case PLUS: printf("\tadd\t"); break;
						case MINUS: printf("\tsub\t"); break;
						case MULT: printf("\tmul\t"); break;
						case DIVIDE: printf("\tdiv\t"); break;
						case IFAND: printf("\tand\t"); break;
						case IFOR: printf("\tor\t"); break;
						case AND: printf("\tand\t"); break;
						case OR: printf("\tor\t"); break;
						case XOR: printf("\txor\t"); break;
						case BOOLEAN_EQUAL: printf("\t==\t"); break;
						case BOOLEAN_NOT_EQUAL: printf("\t!=\t"); break;
						case BOOLEAN_LESS: printf("\t<\t"); break;
						case BOOLEAN_GREATER: printf("\t>\t"); break;
						case BOOLEAN_LESS_EQUAL: printf("\t<=\t"); break;
						case BOOLEAN_GREATER_EQUAL: printf("\t>=\t"); break;
					}
					if (p->opr.op[0].type == typeCon)
					{
						ex(p->opr.op[0]);
					}
					else if (p->opr.op[0].type == typeId)
					{
						ex(p->opr.op[0]);
					}
					else if (p->opr.op[0].type == typeOpr)
					{
						printf("\tt%d\t", tn);
					}

					if (p->opr.op[1].type == typeCon)
					{
						ex(p->opr.op[1]);
					}
					else if (p->opr.op[1].type == typeId)
					{
						ex(p->opr.op[1]);
					}
					else if (p->opr.op[1].type == typeOpr)
					{
						printf("\tt%d\t", tn);
					}

					printf("\tt%d\n", tn = t++);
					return tn;
					break;

			}
	}
}