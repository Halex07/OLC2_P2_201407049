#include <stdlib.h>
#include <stdio.h>
#include "entorno/environment.h"
#include "entorno/ast.h"
#include "ast/sentencias/double.h"

static Symbol Ejecutar(NodoBase *self, AST *ast, void *env){
    Double *p = (Double *)self;
    Symbol t = NodoBase_Ejecutar(p->exp,ast,env);

  
    if (t.tipo != T_STRING && t.val.s == NULL)
        return SymNull(self->lin, self->col);
    double num = atof(t.val.s);
    return SymDouble(self->lin,self->col,(double)num);
}

static void Destruir(NodoBase *self){
    Double *p = (Double *)self;
    if (p->exp) NodoBase_Destruir(p->exp);
    free(p);
}

Double *NewDouble(int line, int col, NodoBase *exp){
    Double *p = (Double *)malloc(sizeof(Double));
    NodoBase_init(&p->base,"Double",line, col, Ejecutar, Destruir);

    p->exp = exp;
    return p;
}