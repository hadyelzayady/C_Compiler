typedef enum { typeCon, typeId, typeOpr } nodeEnum;
typedef enum {int_type,float_type,char_type} dataEnum;
union Data {
   int i;
   float f;
   char ch;
}Data ; 
 /* constants */
typedef struct {
	char* type;
 union  Data value; /* value of constant */
} conNodeType;

/* identifiers */
typedef struct {
 char* var; /* subscript to sym array */
 int reg;
} idNodeType;

/* operators */
typedef struct {
 int oper; /* operator */
 int nops; /* number of operands */
 struct nodeTypeTag *op[1]; /* operands, extended at runtime */
} oprNodeType;

typedef struct nodeTypeTag {
 nodeEnum type; /* type of node */
 union {
 conNodeType con; /* constants */
 idNodeType id; /* identifiers */
 oprNodeType opr; /* operators */
 };
}nodeType;
