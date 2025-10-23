#include <stdlib.h>
#include <stdio.h>
#include "entorno/environment.h"
#include "entorno/ast.h"
#include "ast/controllers/if.h"

static Symbol Ejecutar(NodoBase *self, AST *ast, void *env)
{
    
    If *d = (If *)self;

    Symbol v = NodoBase_Ejecutar(d->condicion, ast, env);
  
    /* validación de tipo */
    if (v.tipo != T_BOOLEAN)
    {
        return SymNull(self->lin, self->col);
    }

    if (v.val.i == 1)
    {
        Environment if_stmt;
   
        Env_init(&if_stmt, env, "IF_STMT");
        (void)NodoBase_Ejecutar(d->bloqueIf, ast, &if_stmt);
        Env_free(&if_stmt);
    }
    else if (d->bloqueElse != NULL)  
    {
        Environment else_stmt;
     
        Env_init(&else_stmt, env, "ELSE_STMT");
        (void)NodoBase_Ejecutar(d->bloqueElse, ast, &else_stmt);
        Env_free(&else_stmt);
    }

    return SymNull(self->lin, self->col);
}


static void Destruir(NodoBase *self)
{
  If *d = (If *)self;
  free(d);
}

/* Constructor para if */
If *NewIf(int lin, int col, NodoBase *condicion, NodoBase *bloqueIf)
{
  If *d = (If *)malloc(sizeof(If));
  NodoBase_init(&d->base, "IF", lin, col, Ejecutar, Destruir);
  d->condicion = condicion;
  d->bloqueIf = bloqueIf;
  d->bloqueElse = NULL;  // sin else
  return d;
}

/* Constructor para if + else */
If *NewIfElse(int lin, int col, NodoBase *condicion, NodoBase *bloqueIf, NodoBase *bloqueElse)
{
  If *d = (If *)malloc(sizeof(If));
  NodoBase_init(&d->base, "IF", lin, col, Ejecutar, Destruir);
  d->condicion = condicion;
  d->bloqueIf = bloqueIf;
  d->bloqueElse = bloqueElse;
  return d;
}
