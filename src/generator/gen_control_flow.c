#include "gen_control_flow.h"
#include "gen_expressions.h"
#include "gen_statements.h"
#include "gen_utils.h"
#include "entorno/environment.h"
#include "ast/controllers/if.h"
#include "ast/controllers/loopWhile.h"
#include "ast/controllers/for.h"
#include "ast/AbstractTerminal.h"
#include "ast/controllers/float.h"
#include "ast/expresiones/callFunc.h"
#include <stdlib.h>

// Generar if
void generate_if(CodeGenerator *gen, NodoBase *if_stmt)
{
    If *i = (If *)if_stmt;

    int label_else = get_next_label(gen);
    int label_end  = get_next_label(gen);

    fprintf(gen->output_file, "    # If\n");

    // Evaluar la condición
    int reg = allocate_register(gen->reg_manager);
    generate_expression(gen, i->condicion, reg);

    // Comparar con 0
    fprintf(gen->output_file, "    cmp x%d, #0\n", reg);
    fprintf(gen->output_file, "    beq L%d\n", label_else);
    free_register(gen->reg_manager, reg);

    // Bloque verdadero
    generate_statement(gen, i->bloqueIf);

    // Si hay else o else if, saltar al final después del bloque if
    if (i->bloqueElse != NULL)
        fprintf(gen->output_file, "    b L%d\n", label_end);

    // Etiqueta del else (si no hay, simplemente sigue el flujo)
    fprintf(gen->output_file, "L%d:\n", label_else);

    // Bloque else (puede ser otro if o un bloque normal)
    if (i->bloqueElse != NULL)
        generate_statement(gen, i->bloqueElse);

    // Etiqueta final
    fprintf(gen->output_file, "L%d:\n", label_end);
}


// While TODO
void generate_while(CodeGenerator *gen, NodoBase *while_stmt)
{
    LoopWhile *w = (LoopWhile *)while_stmt;

    int label_start = get_next_label(gen);
    int label_end   = get_next_label(gen);

    fprintf(gen->output_file, "    # While\n");
    fprintf(gen->output_file, "L%d:\n", label_start);

    // Evaluar condición
    int reg = allocate_register(gen->reg_manager);
    generate_expression(gen, w->condicion, reg);

    // Suponiendo que es int/bool
    fprintf(gen->output_file, "    cmp x%d, #0\n", reg);
    fprintf(gen->output_file, "    beq L%d\n", label_end);
    free_register(gen->reg_manager, reg);

    // Cuerpo del while
    generate_statement(gen, w->scop);

    // Volver al inicio del bucle
    fprintf(gen->output_file, "    b L%d\n", label_start);

    // Etiqueta de salida
    fprintf(gen->output_file, "L%d:\n", label_end);
}
// For TODO
void generate_for(CodeGenerator *gen, NodoBase *for_stmt)
{

  For *f = (For *)for_stmt;

  fprintf(gen->output_file, "    # For\n");

  // Etiquetas para controlar el flujo
  int label_start = get_next_label(gen);
  int label_end = get_next_label(gen);

  // Generar inicialización (por ejemplo: int i = 0;)
  if (f->dcl != NULL)
  {
    generate_statement(gen, f->dcl);
  }

  //  Etiqueta de inicio del bucle
  fprintf(gen->output_file, "L%d:\n", label_start);

  // Evaluar la condición (por ejemplo: i < 10)
  if (f->condicion != NULL)
  {
    int reg_cond = allocate_register(gen->reg_manager);
    generate_expression(gen, f->condicion, reg_cond);

    // Comparar con 0 (falso)
    fprintf(gen->output_file, "    cmp x%d, #0\n", reg_cond);
    fprintf(gen->output_file, "    beq L%d\n", label_end); // Si es falso, salir
    free_register(gen->reg_manager, reg_cond);
  }

  // Generar el cuerpo del for
  generate_statement(gen, f->scop);

  //  Generar la actualización (por ejemplo: i++)
  if (f->masMenos != NULL)
  {
    generate_statement(gen, f->masMenos);
  }

  // Volver al inicio del bucle
  fprintf(gen->output_file, "    b L%d\n", label_start);

  // Etiqueta de salida
  fprintf(gen->output_file, "L%d:\n", label_end);
}

