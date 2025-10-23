#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "ast/controllers/stringvalueof.h"

static Symbol Ejecutar(NodoBase *self, AST *ast, void *env)
{
    StringValueOf *s = (StringValueOf *)self;

    // Evaluamos la expresión
    Symbol val = NodoBase_Ejecutar(s->expr, ast, env);

    char buffer[256]; // temporal para almacenar el string convertido
    memset(buffer, 0, sizeof(buffer));

    switch (val.tipo)
    {
    case T_INTEGER:
        snprintf(buffer, sizeof(buffer), "%d", val.val.i);
        break;

    case T_DOUBLE:
        snprintf(buffer, sizeof(buffer), "%f", val.val.d);
        break;
    case T_FLOAT:
        snprintf(buffer, sizeof(buffer), "%f", val.val.fl);
        break;

    case T_BOOLEAN:
        snprintf(buffer, sizeof(buffer), "%s", val.val.i ? "true" : "false");
        break;

    case T_STRING:
        snprintf(buffer, sizeof(buffer), "%s", val.val.s ? val.val.s : "");
        break;
    case T_CHAR:
        snprintf(buffer, sizeof(buffer), "%c", val.val.c);
        break;
    case T_NULL:
        snprintf(buffer, sizeof(buffer), "null");
        break;

    default:
        snprintf(buffer, sizeof(buffer), "[objeto]");
        break;
    }
  
    char *str = strdup(buffer);

    // Retornamos como símbolo string
    return SymStr(self->lin, self->col, str);
}
 
static void Destruir(NodoBase *self)
{
    StringValueOf *s = (StringValueOf *)self;
    if (s->expr)
        NodoBase_Destruir(s->expr);
    free(s);
}

/* Constructor */
StringValueOf *NewStringValueOf(int lin, int col, NodoBase *expr)
{
    StringValueOf *s = (StringValueOf *)malloc(sizeof(StringValueOf));
    NodoBase_init(&s->base, "StringValueOf", lin, col, Ejecutar, Destruir);
    s->expr = expr;
    return s;
}
