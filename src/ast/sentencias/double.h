#ifndef DOUBLE_H
#define DOUBLE_H
#include "ast/AbstractTerminal.h"

typedef struct Double
{
    NodoBase base;
    NodoBase *exp;

}Double;

Double *NewDouble(int lin, int col, NodoBase *exp);

#endif