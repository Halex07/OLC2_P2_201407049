 #ifndef STRINGVALUEOF_H
#define STRINGVALUEOF_H

#include "ast/AbstractTerminal.h"

typedef struct {
    NodoBase base;
    NodoBase* expr;  // expresión que puede devolver cualquier tipo
} StringValueOf;

/* Constructor */
StringValueOf* NewStringValueOf(int lin, int col, NodoBase* expr);

#endif
