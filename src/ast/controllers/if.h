#ifndef IF_H
#define IF_H

#include "ast/AbstractTerminal.h"

typedef struct If
{
  NodoBase base;
  NodoBase *condicion;   // condición booleana
  NodoBase *bloqueIf;    // bloque del if
  NodoBase *bloqueElse;  // bloque opcional del else
} If;

/* Constructores */
If *NewIf(int lin, int col, NodoBase *condicion, NodoBase *bloqueIf);
If *NewIfElse(int lin, int col, NodoBase *condicion, NodoBase *bloqueIf, NodoBase *bloqueElse);

#endif