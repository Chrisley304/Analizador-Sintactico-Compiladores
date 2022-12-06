%{
/*
  Analizador léxico en lex para
  el lenguaje descrito en clase.
  
  Integrantes:
    - Núñez Quintana Luis Axel 
    - Leyva Mercado Christian Alejandro
  Fecha de elaboración: 05 de diciembre del 2022
*/

// Bibliotecas/Headers
#include <stdio.h>
#include <stdlib.h>

// Variables Globales/ Constantes
#define LONGITUD_MAXIMA_CADENAS 20
FILE *archSal; // Archivo de salida

// Variables analizador sintáctico
char cadena[4000];
int atomo = 0;
int errores = 0;
char actual = 'a';

// Firma de funciones de analizador sintáctico
char getcharatomo ();
void error(char*);
void program();
void veredicto();
void otraFunc();
void func();
void param();
void otroParam();
void cuerpo();
void decl();
void d();
void tipo();
void k();
void q();
void n();
void c();
void a();
void aPrima();
void e();
void ePrima();
void t();
void tPrima();
void f();
void r();
void rPrima();
void v();
void vPrima();
void vBiPrima();
void vTriPrima();
void p();
void listaP();
void w();
void i();
void iPrima();
void j();
void y();
void x();
void z();
void h();
void cPrima();
void oPrima();
void u();
void devuelve();
void valor();
void llama();
void arg();
void otroArg();

// Definción de funciones auxiliares de analizador sintáctico
void error(char * error){
    printf("Error al analizar atomo %d: %c, se esperaba %s \n",atomo, cadena[atomo], error);
    errores ++;
}

char getcharatomo (){
    return cadena[atomo++];
}

void veredicto(){
    if (errores == 0){
        printf("No hay errores en el analisis sintactico\n");
    }else{
        printf("En el analisis sintactico hubo %d errores \n", errores);
    }
}

void iniciaCadena(){
    int i = 0;
    for(i = 0; i < 4000; i ++){
        cadena[i] = '_';
    }
}

// Definición de funciones de analizador sintáctico
void program(){ // 1
    if(actual == 'b'|| actual == 'g'|| actual == '#'|| actual == 'y'|| actual == 'x'){
        func();
        otraFunc();
        return;
    }else{
        error("bg#yx");
    }
    
}

void otraFunc(){ // 2
    if(actual == 'b'|| actual == 'g'|| actual == '#'|| actual == 'y'|| actual == 'x'){
        func();
        otraFunc();
        return;
    }else if(actual == '_'){
        return;
    }else{
        error("bg#yx_");
    }
    
}

void func(){ // 3
    if(actual == 'b'|| actual == 'g'|| actual == '#'|| actual == 'y'|| actual == 'x'){
        tipo();
        if(actual == 'i'){
            actual = getcharatomo ();
            if(actual == '('){
                actual = getcharatomo ();
                param();
                if(actual == ')'){
                    actual = getcharatomo ();
                    if(actual == '{'){
                        actual = getcharatomo ();
                        cuerpo();
                        if(actual == '}'){
                            actual = getcharatomo ();
                            return;
                        }else{
                            error("}");
                        }
                    }else{
                        error("{");
                    }
                }else{
                    error(")");
                }
            }else{
                error("(");
            }
        }else{
            error("i");
        }
    }else{
        error("bg#yx");
    }
    
}

void param(){ // 4
    if(actual == 'b'|| actual == 'g'|| actual == '#'|| actual == 'y'|| actual == 'x'){
        tipo();
        if(actual == 'i'){
            actual = getcharatomo ();
            otroParam();
            return;
        }else{
            error("i");
        }
    }else if(actual == ')'){
        return;
    }else{
        error("bg#yx)");
    }
    
}

void otroParam(){ // 5
    if(actual == ','){
        actual = getcharatomo ();
        tipo();
        if(actual == 'i'){
            actual = getcharatomo ();
            otroParam();
            return;
        }else{
            error("i");
        }
    }else if(actual == ')'){
        return;
    }else{
        error(",)");
    }
    
}

void cuerpo(){ // 6
    if(actual == 'b'|| actual == 'g'|| actual == '#'|| actual == 'y'|| actual == 'x'||
        actual == 'i'|| actual == 'f'|| actual == 'h'|| actual == 'w'|| actual == 'j'|| 
        actual == '}'|| actual == '['|| actual == 'z'|| actual == 'c'){
        decl();
        listaP();
        return;
    }else{
        error("bg#yxifhwj}[zc");
    }
    
}

void decl(){ // 7
    if(actual == 'i'|| actual == 'f'|| actual == 'h'|| actual == 'w'|| actual == 'j'|| 
        actual == '}'|| actual == '['|| actual == 'z'|| actual == 'c'){
        return;
    }else if(actual == 'b'|| actual == 'g'|| actual == '#'|| actual == 'y'|| actual == 'x'){
        d();
        decl();
        return;
    }else{
        error("bg#yxifhwj}[zc");
    }
    
}

void d(){ // 8
    if(actual == 'b'|| actual == 'g'|| actual == '#'|| actual == 'y'|| actual == 'x'){
        tipo();
        k();
        if(actual == ';'){
            actual = getcharatomo ();
            return;
        }else{
            error(";");
        }
    }else{
        error("bg#yx");
    }
    
}

void tipo(){ // 9
    if(actual == 'b'){
        actual = getcharatomo ();
        return;
    }else if( actual == 'g'){
        actual = getcharatomo ();
        return;
    }else if( actual == '#'){
        actual = getcharatomo ();
        return;
    }else if( actual == 'y'){
        actual = getcharatomo ();
        return;
    }else if( actual == 'x'){
        actual = getcharatomo ();
        return;
    }else{
        error("bg#yx");
    }
    
}


void k(){ // 10
    if(actual == 'i'){
        actual = getcharatomo ();
        q();
        return;
    }else{
        error("i");
    }
    
}

void q(){ // 11
    if(actual == ';'){
        return;
    }else if(actual == '='){
        actual = getcharatomo ();
        n();
        c();
        return;
    }else if(actual == ','){
        actual = getcharatomo ();
        k();
        return;
    }else{
        error(";=,");
    }
    
}

void n(){ // 12
    if(actual == 'n'){
        actual = getcharatomo ();
        return;
    }else if(actual == 'r'){
        actual = getcharatomo ();
        return;
    }else if(actual == 's'){
        actual = getcharatomo ();
        return;
    }else{
        error("nrs");
    }
    
}

void c(){ // 13
    if(actual == ';'){
        return;
    }else if(actual == ','){
        actual = getcharatomo ();
        k();
        return;
    }else{
        error(";,");
    }
    
}

void a(){ // 14
    if(actual == 'i'){
        actual = getcharatomo ();
        if(actual == '='){
            actual = getcharatomo ();
            aPrima();
            return;
        }else{
            error("=");
        }
    }else{
        error("i");
    }
    
}

void aPrima(){ // 15
    if(actual == 's'){
        actual = getcharatomo ();
        return;
    }else if(actual == '(' || actual == 'i' || actual == 'n' || actual == 'r' ||
             actual == '['){
        e();
        return;
    }else{
        error("s(inr[");
    }
    
}

void e(){ // 16
    if(actual == '(' || actual == 'i' || actual == 'n' || actual == 'r' ||
        actual == '['){
        t();
        ePrima();
        return;
    }else{
        error("(inr[");
    }
    
}

void ePrima(){ // 17
    if(actual == '+'){
        actual = getcharatomo ();
        t();
        ePrima();
        return;
    }else if(actual == '-'){
        actual = getcharatomo ();
        t();
        ePrima();
        return;
    } else if(actual == ';' || actual == ')'){
        return;
    }else{
        error("+-;)");
    }
    
}

void t(){ // 18
    if(actual == '(' || actual == 'i' || actual == 'n' || actual == 'r' ||
        actual == '['){
        f();
        tPrima();
        return;
    }else{
        error("(inr[");
    }
    
}

void tPrima(){ // 19
    if(actual == '*'){
        actual = getcharatomo ();
        f();
        tPrima();
        return;
    }else if(actual == '/'){
        actual = getcharatomo ();
        f();
        tPrima();
        return;
    }else if(actual == '\\'){
        actual = getcharatomo ();
        f();
        tPrima();
        return;
    }else if(actual == '%'){
        actual = getcharatomo ();
        f();
        tPrima();
        return;
    }else if(actual == '^'){
        actual = getcharatomo ();
        f();
        tPrima();
        return;
    }else if(actual == '+'|| actual == '-' || actual == ')' || actual == ';'){
        return;
    }else{
        error("*/\\%%^+-);");
    }
    
}

void f(){ // 20
    if(actual == '('){
        actual = getcharatomo ();
        e();
        if(actual == ')'){
            actual = getcharatomo ();
            return;
        }else{
            error(")");
        }
    }else if(actual == 'i'){
        actual = getcharatomo ();
        return;
    }else if(actual == 'n'){
        actual = getcharatomo ();
        return;
    }else if(actual == 'r'){
        actual = getcharatomo ();
        return;
    }else if(actual == '['){
        llama();
        return;
    }else{
        error("(inr[");
    }
    
}

void r(){ // 21
    if(actual == 'i'){
        actual = getcharatomo ();
        rPrima();
        v();
        return;
    }else if(actual == 'n'){
        actual = getcharatomo ();
        rPrima();
        vPrima();
        return;
    }else if(actual == 'r'){
        actual = getcharatomo ();
        rPrima();
        vBiPrima();
        return;
    }else if(actual == 's'){
        actual = getcharatomo ();
        rPrima();
        vTriPrima();
        return;
    }else{
        error("inrs");
    }
    
}

void rPrima(){ // 22
    if(actual == '<'){
        actual = getcharatomo ();
        return;
    }else if(actual == '>'){
        actual = getcharatomo ();
        return;
    }else if(actual == 'l'){
        actual = getcharatomo ();
        return;
    }else if(actual == 'e'){
        actual = getcharatomo ();
        return;
    }else if(actual == 'd'){
        actual = getcharatomo ();
        return;
    }else if(actual == 'u'){
        actual = getcharatomo ();
        return;
    }else{
        error("<>ledu");
    }
    
}

void v(){ // 23
    if(actual == 'i'){
        actual = getcharatomo ();
        return;
    }else if(actual == 'n'){
        actual = getcharatomo ();
        return;
    }else if(actual == 'r'){
        actual = getcharatomo ();
        return;
    }else if(actual == 's'){
        actual = getcharatomo ();
        return;
    }else{
        error("inrs");
    }
    
}

void vPrima(){ // 24
    if(actual == 'i'){
        actual = getcharatomo ();
        return;
    }else if(actual == 'n'){
        actual = getcharatomo ();
        return;
    }else{
        error("in");
    }
    
}

void vBiPrima(){ // 25
    if(actual == 'i'){
        actual = getcharatomo ();
        return;
    }else if(actual == 'r'){
        actual = getcharatomo ();
        return;
    }else{
        error("ir");
    }
    
}

void vTriPrima(){ // 26
    if(actual == 'i'){
        actual = getcharatomo ();
        return;
    }else if(actual == 's'){
        actual = getcharatomo ();
        return;
    }else{
        error("is");
    }
    
}

void p(){ // 27
    if(actual == 'i'){
        a();
        return;
    }else if(actual == 'f'){
        i();
        return;
    }else if(actual == 'h'){
        h();
        return;
    }else if(actual == 'w'){
        w();
        return;
    }else if(actual == 'j'){
        j();
        return;
    }else if(actual == '['){
        llama();
        return;
    }else if(actual == 'z'){
        devuelve();
        return;
    }else if(actual == 'c'){
        actual = getcharatomo ();
        if(actual == ';'){
            actual = getcharatomo ();
            return;
        }else{
            error(";");
        }
    }else{
        error("ifhwj[zc");
    }
    
}

void listaP(){ // 28
    if(actual == '}' || actual == 't' || actual == ':' || actual == 'q' ||
        actual == 'a'|| actual == 'o'){
        return;
    }else if(actual == 'i'|| actual == 'f'|| actual == 'h'|| actual == 'w'|| actual == 'j'|| 
             actual == '['|| actual == 'z'|| actual == 'c'){
        p();
        listaP();
        return;
    }else{
        error("}t:qaoifhwj[zc");
    }
    
}

void w(){ // 29
    if(actual == 'w'){
        actual = getcharatomo ();
        if(actual == '('){
            actual = getcharatomo ();
            r();
            if(actual == ')'){
                actual = getcharatomo ();
                if(actual == 'm'){
                    actual = getcharatomo ();
                    if(actual == '{'){
                        actual = getcharatomo ();
                        listaP();
                        if(actual == '}'){
                            actual = getcharatomo ();
                            return;
                        }else{
                            error("}");
                        }
                    }else{
                        error("{");
                    }
                }else{
                    error("m");
                }
            }else{
                error(")");
            }
        }else{
            error("(");
        }
    }else{
        error("w");
    }
    
}

void i(){ // 30
    if(actual == 'f'){
        actual = getcharatomo ();
        if(actual == '('){
            actual = getcharatomo ();
            r();
            if(actual == ')'){
                actual = getcharatomo ();
                listaP();
                iPrima();
                if(actual == ':'){
                    actual = getcharatomo ();
                    return;
                }else{
                    error(":");
                }
            }else{
                error(")");
            }
        }else{
            error("(");
        }
    }else{
        error("f");
    }
    
}

void iPrima(){ // 31
    if(actual == 't'){
        actual = getcharatomo ();
        listaP();
        return;
    }else if(actual == ':'){
        return;
    }else{
        error("t:");
    }
    
}

void j(){ // 32
    if(actual == 'j'){
        actual = getcharatomo ();
        if(actual == '('){
            actual = getcharatomo ();
            y();
            x();
            z();
            if(actual == '{'){
                actual = getcharatomo ();
                listaP();
                if(actual == '}'){
                    actual = getcharatomo ();
                    return;
                }else{
                    error("}");
                }
            }else{
                error("{");
            }
        }else{
            error("(");
        }
    }else{
        error("j");
    }
    
}

void y(){ // 33
    if(actual == 'i'){
        actual = getcharatomo ();
        if(actual == '='){
            actual = getcharatomo ();
            e();
            if(actual == ';'){
                actual = getcharatomo ();
                return;
            }else{
                error(";");
            }
        }else{
            error("=");
        }
    }else if(actual == ';'){
        actual = getcharatomo ();
        return;
    }else{
        error("i;");
    }
    
}

void x(){ // 34
    if(actual == 'i'|| actual == 'n'|| actual == 'r'|| actual == 's'){
        r();
        if(actual == ';'){
            actual = getcharatomo ();
            return;
        }else{
            error(";");
        }
    }else if(actual == ';'){
        actual = getcharatomo ();
        return;
    }else{
        error("inrs;");
    }
    
}

void z(){ // 35
    if(actual == 'i'){
        actual = getcharatomo ();
        if(actual == '='){
            actual = getcharatomo ();
            e();
            if(actual == ')'){
                actual = getcharatomo ();
                return;
            }else{
                error(")");
            }
        }else{
            error("=");
        }
    }else if(actual == ')'){
        actual = getcharatomo ();
        return;
    }else{
        error("i)");
    }
    
}

void h(){ // 36
    if(actual == 'h'){
        actual = getcharatomo ();
        if(actual == '('){
            actual = getcharatomo ();
            if(actual == 'i'){
                actual = getcharatomo ();
                if(actual == ')'){
                    actual = getcharatomo ();
                    if(actual == '{'){
                        actual = getcharatomo ();
                        cPrima();
                        oPrima();
                        if(actual == '}'){
                            actual = getcharatomo ();
                            return;
                        }else{
                            error("}");
                        }
                    }else{
                        error("{");
                    }
                }else{
                    error(")");
                }
            }else{
                error("i");
            }
        }else{
            error("(");
        }
    }else{
        error("h");
    }
    
}

void cPrima(){ // 37
    if(actual == 'a'){
        actual = getcharatomo ();
        if(actual == 'n'){
            actual = getcharatomo ();
            if(actual == ':'){
                actual = getcharatomo ();
                listaP();
                u();
                cPrima();
                return;
            }else{
                error(":");
            }
        }else{
            error("n");
        }
    }else if(actual == 'o' || actual == '}'){
        return;
    }else{
        error("ao}");
    }
    
}

void oPrima(){ // 38
    if(actual == 'o'){
        actual = getcharatomo ();
        if(actual == ':'){
            actual = getcharatomo ();
            listaP();
            return;
        }else{
            error(":");
        }
    }else if(actual == '}'){
        return;
    }else{
        error("o}");
    }
    
}

void u(){ // 39
    if(actual == 'q'){
        actual = getcharatomo ();
        return;
    }else if(actual == 'a' || actual == 'o' || actual == '}'){
        return;
    }else{
        error("qao}");
    }
    
}

void devuelve(){ // 40
    if(actual == 'z'){
        actual = getcharatomo ();
        if(actual == '('){
            actual = getcharatomo ();
            valor();
            if(actual == ')'){
                actual = getcharatomo ();
                if(actual == ';'){
                    actual = getcharatomo ();
                    return;
                }else{
                    error(";");
                }
            }else{
                error(")");
            }
        }else{
            error("(");
        }
    }else{
        error("z");
    }
    
}

void valor(){ // 41
    if(actual == ')'){
        return;
    }else if(actual == 'i'|| actual == 'n'|| actual == 'r'|| actual == 's'){
        v();
        return;
    }else{
        error("inrs)");
    }
    
}

void llama(){ // 42
    if(actual == '['){
        actual = getcharatomo ();
        if(actual == 'i'){
            actual = getcharatomo ();
            if(actual == '('){
                actual = getcharatomo ();
                arg();
                if(actual == ')'){
                    actual = getcharatomo ();
                    if(actual == ']'){
                        actual = getcharatomo ();
                        return;
                    }else{
                        error("]");
                    }
                }else{
                    error(")");
                }
            }else{
                error("(");
            }
        }else{
            error("i");
        }
    }else{
        error("[");
    }
    
}

void arg(){ // 43
    if(actual == ')'){
        return;
    }else if(actual == 'i'|| actual == 'n'|| actual == 'r'|| actual == 's'){
        v();
        otroArg();
        return;
    }else{
        error(")inrs");
    }
    
}

void otroArg(){ // 44
    if(actual == ')'){
        return;
    }else if(actual == ','){
        actual = getcharatomo ();
        v();
        otroArg();
    }else{
        error("),");
    }
    
}

// Estructuras necesarias para las tablas:

// Para las linked lists
struct Nodo{
  int posicion;
  int clase;
  int tipo;
  char *valor;
  struct Nodo *sig;
};

struct Lista{
  struct Nodo *head, *tail;
};

struct Lista *crearLista()
{
  struct Lista *lista;
  lista = (struct Lista *)malloc(sizeof(struct Lista));
  if (lista == NULL)
  {
      printf("No se pudo reservar lista\n");
  }
  lista->head = NULL;
  lista->tail = NULL;
  return lista;
}

void agregarALista(struct Lista *lista, struct Nodo *nuevo)
{
  // Si la lista esta vacia:
  if (lista->head == NULL)
  {
    lista->head = nuevo;
  }
  else
  {
    lista->tail->sig = nuevo;
  }
  lista->tail = nuevo;
}

struct Nodo *crearNuevoNodoSimbolo(int posicion, char valor[], int tipo)
{
  struct Nodo *nuevoNodo = NULL;
  nuevoNodo = malloc(sizeof(struct Nodo));
  nuevoNodo->sig = NULL;
  nuevoNodo->posicion = posicion;
  nuevoNodo->tipo = tipo;
  nuevoNodo->valor = strdup(valor);
  return nuevoNodo;
}

struct Nodo *crearNuevoNodoLiteral(int posicion, char valor[])
{
  struct Nodo *nuevoNodo = NULL;
  nuevoNodo = malloc(sizeof(struct Nodo));
  nuevoNodo->sig = NULL;
  nuevoNodo->posicion = posicion;
  nuevoNodo->valor = strdup(valor);
  return nuevoNodo;
}

struct Nodo *crearNuevoNodoToken(int posicion,int clase, char valor[])
{
  struct Nodo *nuevoNodo = NULL;
  nuevoNodo = malloc(sizeof(struct Nodo));
  nuevoNodo->sig = NULL;
  nuevoNodo->posicion = posicion;
  nuevoNodo->clase = clase;
  nuevoNodo->valor = strdup(valor);
  return nuevoNodo;
}

// Catalogos
// 0 -> Palabras reservadas
char palabrasReservadas[][LONGITUD_MAXIMA_CADENAS] = {"alternative","big","evaluate","instead","large","loop","make","number","other","real","repeat","select","small","step","stop","symbol","throw"};
// 7 Operadores relacionales.
char operadoresRelacionales[][LONGITUD_MAXIMA_CADENAS] = {"<",">","<=",">=","==","!="};

// Tablas:
struct Lista *identificadoresList;
// 3 -> Constantes numéricas reales. 
struct Lista *realesList;
// 4 -> Constantes cadenas.
struct Lista *cadenasList;
// Tabla de tokens
struct Lista *tokensList;

// Contadores para llevar la 'cuenta' de la posicion en la tabla
int contTokens = -1;
int contIdent = -1;
int contReales = -1;
int contCadenas = -1;

// Para obtener la posicion del catalogo de palabras reservadas 
int buscaReservada(char* busqueda){
  for(int i = 0; i< 17; i++){
    if(strcmp(busqueda, palabrasReservadas[i]) == 0){
      return i;
    }
  }
  return -1;
}
// Para obtener la posicion del catalogo de operadores aritmeticos 
int buscaOperador(char* busqueda){
  for(int i = 0; i< 6; i++){
    if(strcmp(busqueda, operadoresRelacionales[i]) == 0){
      return i;
    }
  }
  return -1;
}
// Parser de int a string
char* parseInttoString(int numero){
  int length = snprintf( NULL, 0, "%d", numero );
  char* numStr = malloc( length + 1 );
  snprintf( numStr, length + 1, "%d", numero );
  return numStr; 
}

// Para buscar cadenas en listas ligadas
int buscaLista(char* busqueda, struct Lista *lista){
  struct Nodo *q;
  q = lista->head;
  while(q!=NULL)
  {
    if(strcmp(busqueda, q->valor) == 0){
      return q->posicion;
    }
    q=q->sig;
  }
  return -1;
}

%}
/*Expresiones regulares, si esta capitalizado el nombre tiene una acción asignada, de otra maanera es auxiliar*/
PalabraReservada alternative|big|evaluate|instead|large|loop|make|number|other|real|repeat|select|small|step|stop|symbol|throw
Identif \$([a-z]|[A-Z])+
digCero [0-9]
CerosInicio 0{digCero}+
digUno [1-9]
digSieteCero [0-7]
digSieteUno [1-7]
constantesNumEnt 0|({digUno}({digCero})*)
constantesNumOct (o|O)0|(o|O)({digSieteUno}({digSieteCero})*)
constantesRealDec 0|{digCero}*{digUno}
ConstantesReal {constantesNumEnt}\.{constantesRealDec}
ConstantesCad \"[^"'\n]([^"'\n])+\"|'[^'\n]'|\"'\"
SimbolosEsp [(){},:;]|\[|\]
OperadoresArit \+|\-|\*|\/|%|\\|\^
OperadoresRela1 <=|>=|==|!=
OperadoresRela2 <|>
OperadoresAsig =
FinDeLinea " "+|\n|\t

%%
  /*Acciones para expresiones regulares de clase, espacios o errores*/
{PalabraReservada}  {
  int pos = buscaReservada(yytext);
  contTokens++;
  // Parse de int a str para la struct
  char *posStr = parseInttoString(pos);
  struct Nodo *temp = crearNuevoNodoToken(contTokens,0, posStr);
  agregarALista(tokensList,temp);
}
{Identif} {
  contTokens++;

  int posicionIdent = buscaLista(yytext,identificadoresList);
  if (posicionIdent == -1){
    contIdent++;
    posicionIdent = contIdent;
    // Se añade a la tabla de identificadores
    struct Nodo *tempTabla = crearNuevoNodoSimbolo(posicionIdent,yytext,-1);
    agregarALista(identificadoresList,tempTabla);
  }
  
  // Se añade a la tabla de tokens
  char* posStr = parseInttoString(posicionIdent);
  struct Nodo *tempToken = crearNuevoNodoToken(contTokens,1,posStr);
  agregarALista(tokensList,tempToken);
}
{CerosInicio} {
  printf("Error: %s\n", yytext);
}
{constantesNumEnt} {
  contTokens++;
  // Se añade a la tabla de tokens
  struct Nodo *tempToken = crearNuevoNodoToken(contTokens,2,yytext);
  agregarALista(tokensList,tempToken);
}
{constantesNumOct} {
  contTokens++;
  // Antes de añadir a la tabla de tokens, se convierte el numero a decimal
  // Se utiliza una cadena auxiliar "ignorar" la 'o' que se ingresa y colocar un 0 en su lugar
  char* copiaNumeroStr;
  copiaNumeroStr = (char*)malloc(strlen(yytext));
  strcpy(copiaNumeroStr, yytext);
  // Se cambia la 'o'|'O' por un 0 y se convierte a entero la cadena
  copiaNumeroStr[0] = '0';
  // Con la funcion strtol se convierte el numero en str a octal colocando la funcion en base 8:
  int numeroDecimal = strtol(copiaNumeroStr, NULL, 8);
  // printf("Numero octal ingresado: %o\n",numero);
  // printf("Numero decimal ingresado: %d\n",numero);
  // Se añade a la tabla de tokens
  struct Nodo *tempToken = crearNuevoNodoToken(contTokens,2,parseInttoString(numeroDecimal));
  agregarALista(tokensList,tempToken);
}
{ConstantesReal} {
  contTokens++;
  contReales++;
  // Se añade a la tabla de identificadores
  struct Nodo *tempTabla = crearNuevoNodoLiteral(contReales,yytext);
  agregarALista(realesList,tempTabla);
  // Se añade a la tabla de tokens
  char* posStr = parseInttoString(contReales);
  struct Nodo *tempToken = crearNuevoNodoToken(contTokens,3,posStr);
  agregarALista(tokensList,tempToken);
}
{ConstantesCad} {
  contTokens++;
  contCadenas++;
  // Se añade a la tabla de identificadores
  struct Nodo *tempTabla = crearNuevoNodoLiteral(contCadenas,yytext);
  agregarALista(cadenasList,tempTabla);
  // Se añade a la tabla de tokens
  char* posStr = parseInttoString(contCadenas);
  struct Nodo *tempToken = crearNuevoNodoToken(contTokens,4,posStr);
  agregarALista(tokensList,tempToken);
}
{SimbolosEsp} {
  contTokens++;
  struct Nodo *tempToken = crearNuevoNodoToken(contTokens,5,yytext);
  agregarALista(tokensList,tempToken);
}
{OperadoresArit} {
  contTokens++;
  struct Nodo *tempToken = crearNuevoNodoToken(contTokens,6,yytext);
  agregarALista(tokensList,tempToken);
}
{OperadoresRela1} {
  int pos = buscaOperador(yytext);
  contTokens++;
  // Parse de int a str para la struct
  char* posStr = parseInttoString(pos);
  struct Nodo *temp = crearNuevoNodoToken(contTokens,7,posStr);
  agregarALista(tokensList,temp);
}
{OperadoresRela2} {
  int pos = buscaOperador(yytext);
  contTokens++;
  // Parse de int a str para la struct
  char* posStr = parseInttoString(pos);
  struct Nodo *temp = crearNuevoNodoToken(contTokens,7,posStr);
  agregarALista(tokensList,temp);
}
{OperadoresAsig} {
  contTokens++;
  struct Nodo *tempToken = crearNuevoNodoToken(contTokens,8,yytext);
  agregarALista(tokensList,tempToken);
}
{FinDeLinea} {
  printf("");
}
. {
  printf("Error: %s\n", yytext);
}

%%
int yywrap(){return(1);}

// Función para crear archivo de salida con extensión .txt
void obtenerArchivoSalidaTXT(){
  archSal = fopen("salida.txt","w");
  struct Nodo *q;
  // Tabla de identificadores
  fprintf(archSal,"=== Tabla de identificadores ===\nPosición: Valor | Tipo\n");
  q=identificadoresList->head;
  while(q!=NULL)
  {
    fprintf(archSal,"%d: %s | %d\n",q->posicion,q->valor,q->tipo);
    q=q->sig;
  }
  fprintf(archSal,"\n");
  // Tabla de constantes reales
  fprintf(archSal,"=== Tabla de constantes reales ===\nPosición: Valor\n");
  q=realesList->head;
  while(q!=NULL)
  {
    fprintf(archSal,"%d: %s\n",q->posicion,q->valor);
    q=q->sig;
  }
  // Tabla de constantes cadenas
  fprintf(archSal,"=== Tabla de constantes cadenas ===\nPosición: Valor\n");
  q=cadenasList->head;
  while(q!=NULL)
  {
    fprintf(archSal,"%d: %s\n",q->posicion,q->valor);
    q=q->sig;
  }
  // Tabla de tokens
  fprintf(archSal,"=== Tabla de tokens ===\nPosición: Clase | Valor\n");
  q=tokensList->head;
  while(q!=NULL)
  {
    fprintf(archSal,"%d: %d | %s\n",q->posicion,q->clase,q->valor);
    q=q->sig;
  }

  fprintf(archSal,"\n\n");
  fclose(archSal);
}

// Función para mostrar la salida en consola
void mostrarSalida(){
  struct Nodo *q;
  // Tabla de identificadores
  printf("=== Tabla de identificadores ===\nPosición: Valor | Tipo\n");
  q=identificadoresList->head;
  while(q!=NULL)
  {
    printf("%d: %s | %d\n",q->posicion,q->valor,q->tipo);
    q=q->sig;
  }
  // Tabla de constantes reales
  printf("=== Tabla de constantes reales ===\nPosición: Valor\n");
  q=realesList->head;
  while(q!=NULL)
  {
    printf("%d: %s\n",q->posicion,q->valor);
    q=q->sig;
  }
  // Tabla de constantes cadenas
  printf("=== Tabla de constantes cadenas ===\nPosición: Valor\n");
  q=cadenasList->head;
  while(q!=NULL)
  {
    printf("%d: %s\n",q->posicion,q->valor);
    q=q->sig;
  }
  // Tabla de tokens
  printf("=== Tabla de tokens ===\nPosición: Clase | Valor\n");
  q=tokensList->head;
  while(q!=NULL)
  {
    printf("%d: %d | %s\n",q->posicion,q->clase,q->valor);
    q=q->sig;
  }

}

// Función para crear archivo de salida con extensión .csv
void obtenerArchivoSalidaCSV(){
  archSal = fopen("salida.csv","w");
  struct Nodo *q;
  // Tabla de identificadores
  fprintf(archSal,",Tabla de identificadores,\nPosición,Valor,Tipo\n");
  q=identificadoresList->head;
  while(q!=NULL)
  {
    fprintf(archSal,"%d,%s,%d\n",q->posicion,q->valor,q->tipo);
    q=q->sig;
  }
  fprintf(archSal,"\n");
  // Tabla de constantes reales
  fprintf(archSal,",Tabla de constantes reales,\nPosición,Valor,\n");
  q=realesList->head;
  while(q!=NULL)
  {
    fprintf(archSal,"%d,%s,\n",q->posicion,q->valor);
    q=q->sig;
  }
  fprintf(archSal,"\n");
  // Tabla de constantes cadenas
  fprintf(archSal,",Tabla de constantes cadenas,\nPosición,Valor,\n");
  q=cadenasList->head;
  while(q!=NULL)
  {
    fprintf(archSal,"%d,%s,\n",q->posicion,q->valor);
    q=q->sig;
  }
  fprintf(archSal,"\n");
  // Tabla de tokens
  fprintf(archSal,",Tabla de tokens,\nPosición,Clase,Valor\n");
  q=tokensList->head;
  while(q!=NULL)
  {
    fprintf(archSal,"%d,%d,%s\n",q->posicion,q->clase,q->valor);
    q=q->sig;
  }

  fprintf(archSal,"\n\n");
  fclose(archSal);
}

int main(int argc, char *argv[]){
  // Se inicializan las variables de las tablas
  identificadoresList = crearLista();
  realesList = crearLista();
  cadenasList = crearLista();
  tokensList = crearLista();
  // Si se especifica un archivo de entrada
  if(argc > 1){
    // Se indica que se leera dicho archivo
    yyin = fopen(argv[1],"r");
    // Se inicializa cadena de atomos
    iniciaCadena();
    // Se ejecuta lex
    yylex();
    // Se cierra el flujo del archivo
    fclose(yyin);
    // Se generan los archivos de salida
    obtenerArchivoSalidaCSV();
    obtenerArchivoSalidaTXT();
    // Se muestra la salida del programa
    mostrarSalida();
    
    printf("\n###########################\n");
    printf("ANALIZADOR SINTACTICO\n");
    actual = getcharatomo ();
    program();
    veredicto();
  }else{
    // La entrada sera por teclado
    yylex();
  }
  // mostrarSalida();
  return 0;
}
