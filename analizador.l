%{
/*
  Analizador léxico en lex para
  el lenguaje descrito en clase.
  
  Integrantes:
    - Núñez Quintana Luis Axel 
    - Leyva Mercado Christian Alejandro
  Fecha de elaboración: 07 de diciembre del 2022
*/

// Bibliotecas/Headers
#include <stdio.h>
#include <stdlib.h>

// Variables Globales/ Constantes
#define LONGITUD_MAXIMA_CADENAS 20
FILE *archSal; // Archivo de salida

// Variables analizador sintáctico
char cadena[4000];
int insertaAtomo =0;
int atomo = 0;
int errores = 0;
char actual = 'a';

// Firma de funciones de analizador sintáctico
char getcharatomo ();
void error(char*, char*);
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
void error(char * error, char* origen){
    printf("Error al analizar atomo %d: %c, se esperaba %s \n",atomo, cadena[atomo - 1], error);
    printf("Lanzado desde %s\n", origen);
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

void muestraCadena(){
    printf("Cadena de átomos: \n");
    int i = 0;
    printf(" 1: ");
    for(i = 0; i < 4000; i ++){
        if((i + 1) % 10 == 0){
            printf("\n %d: ", i + 1);
        }
        printf("%c ", cadena[i]);
        if(cadena[i] == '_'){
            break;
        }
    }
    printf("\n");
}

// Definición de funciones de analizador sintáctico
void program(){ // 1
    if(actual == 'b'|| actual == 'g'|| actual == '#'|| actual == 'y'|| actual == 'x'){
        func();
        otraFunc();
        return;
    }else{
        error("bg#yx","program");
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
        error("bg#yx_","otraFunc");
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
                            error("}","func");
                        }
                    }else{
                        error("{","func");
                    }
                }else{
                    error(")","func");
                }
            }else{
                error("(","func");
            }
        }else{
            error("i","func");
        }
    }else{
        error("bg#yx","func");
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
            error("i","param");
        }
    }else if(actual == ')'){
        return;
    }else{
        error("bg#yx)","param");
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
            error("i","otroParam");
        }
    }else if(actual == ')'){
        return;
    }else{
        error(",)","otroParam");
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
        error("bg#yxifhwj}[zc","cuerpo");
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
        error("bg#yxifhwj}[zc","decl");
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
            error(";","d");
        }
    }else{
        error("bg#yx","d");
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
        error("bg#yx","tipo");
    }
    
}


void k(){ // 10
    if(actual == 'i'){
        actual = getcharatomo ();
        q();
        return;
    }else{
        error("i","k");
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
        error(";=,","q");
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
        error("nrs","n");
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
        error(";,","c");
    }
    
}

void a(){ // 14
    if(actual == 'i'){
        actual = getcharatomo ();
        if(actual == '='){
            actual = getcharatomo ();
            aPrima();
            if(actual == ';'){
                actual = getcharatomo();
                return;
            }
        }else{
            error("=","a");
        }
    }else{
        error("i","a");
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
        error("s(inr[","aPrima");
    }
    
}

void e(){ // 16
    if(actual == '(' || actual == 'i' || actual == 'n' || actual == 'r' ||
        actual == '['){
        t();
        ePrima();
        return;
    }else{
        error("(inr[","e");
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
        error("+-;)","ePrima");
    }
    
}

void t(){ // 18
    if(actual == '(' || actual == 'i' || actual == 'n' || actual == 'r' ||
        actual == '['){
        f();
        tPrima();
        return;
    }else{
        error("(inr[","t");
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
        error("*/\\%%^+-);","tPrima");
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
            error(")","f");
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
        error("(inr[","f");
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
        error("inrs","r");
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
        error("<>ledu","rPrima");
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
        error("inrs","v");
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
        error("in","vPrima");
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
        error("ir","vBiPrima");
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
        error("is","vTriPrima");
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
            error(";","p");
        }
    }else{
        error("ifhwj[zc","p");
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
        error("}t:qaoifhwj[zc","listaP");
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
                            error("}","w");
                        }
                    }else{
                        error("{","w");
                    }
                }else{
                    error("m","w");
                }
            }else{
                error(")","w");
            }
        }else{
            error("(","w");
        }
    }else{
        error("w","w");
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
                    error(":","i");
                }
            }else{
                error(")","i");
            }
        }else{
            error("(","i");
        }
    }else{
        error("f","i");
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
        error("t:","iPrima");
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
                    error("}","j");
                }
            }else{
                error("{","j");
            }
        }else{
            error("(","j");
        }
    }else{
        error("j","j");
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
                error(";","y");
            }
        }else{
            error("=","y");
        }
    }else if(actual == ';'){
        actual = getcharatomo ();
        return;
    }else{
        error("i;","y");
    }
    
}

void x(){ // 34
    if(actual == 'i'|| actual == 'n'|| actual == 'r'|| actual == 's'){
        r();
        if(actual == ';'){
            actual = getcharatomo ();
            return;
        }else{
            error(";","x");
        }
    }else if(actual == ';'){
        actual = getcharatomo ();
        return;
    }else{
        error("inrs;","x");
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
                error(")","z");
            }
        }else{
            error("=","z");
        }
    }else if(actual == ')'){
        actual = getcharatomo ();
        return;
    }else{
        error("i)","z");
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
                            error("}","h");
                        }
                    }else{
                        error("{","h");
                    }
                }else{
                    error(")","h");
                }
            }else{
                error("i","h");
            }
        }else{
            error("(","h");
        }
    }else{
        error("h","h");
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
                error(":","cPrima");
            }
        }else{
            error("n","cPrima");
        }
    }else if(actual == 'o' || actual == '}'){
        return;
    }else{
        error("ao}","cPrima");
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
            error(":","oPrima");
        }
    }else if(actual == '}'){
        return;
    }else{
        error("o}","oPrima");
    }
    
}

void u(){ // 39
    if(actual == 'q'){
        actual = getcharatomo ();
        return;
    }else if(actual == 'a' || actual == 'o' || actual == '}'){
        return;
    }else{
        error("qao}","u");
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
                    error(";","devuelve");
                }
            }else{
                error(")","devuelve");
            }
        }else{
            error("(","devuelve");
        }
    }else{
        error("z","devuelve");
    }
    
}

void valor(){ // 41
    if(actual == ')'){
        return;
    }else if(actual == 'i'|| actual == 'n'|| actual == 'r'|| actual == 's'){
        v();
        return;
    }else{
        error("inrs)","valor");
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
                        error("]","llama");
                    }
                }else{
                    error(")","llama");
                }
            }else{
                error("(","llama");
            }
        }else{
            error("i","llama");
        }
    }else{
        error("[","llama");
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
        error(")inrs","arg");
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
        error("),","otroArg");
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
  switch(pos){
    case 0:
        cadena[insertaAtomo++] = 'a';
        break;
    case 1:
        cadena[insertaAtomo++] = 'b';
        break;
    case 2:
        cadena[insertaAtomo++] = 'f';
        break;
    case 3:
        cadena[insertaAtomo++] = 't';
        break;
    case 4:
        cadena[insertaAtomo++] = 'g';
        break;
    case 5:
        cadena[insertaAtomo++] = 'w';
        break;
    case 6:
        cadena[insertaAtomo++] = 'm';
        break;
    case 7:
        cadena[insertaAtomo++] = '#';
        break;
    case 8:
        cadena[insertaAtomo++] = 'o';
        break;
    case 9:
        cadena[insertaAtomo++] = 'x';
        break;
    case 10:
        cadena[insertaAtomo++] = 'j';
        break;
    case 11:
        cadena[insertaAtomo++] = 'h';
        break;
    case 12:
        cadena[insertaAtomo++] = 'p';
        break;
    case 13:
        cadena[insertaAtomo++] = 'c';
        break;
    case 14:
        cadena[insertaAtomo++] = 'q';
        break;
    case 15:
        cadena[insertaAtomo++] = 'y';
        break;
    case 16:
        cadena[insertaAtomo++] = 'z';
        break;
  }
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
  cadena[insertaAtomo++] = 'i';
}
{CerosInicio} {
  printf("Error: %s\n", yytext);
}
{constantesNumEnt} {
  contTokens++;
  // Se añade a la tabla de tokens
  struct Nodo *tempToken = crearNuevoNodoToken(contTokens,2,yytext);
  agregarALista(tokensList,tempToken);
  cadena[insertaAtomo++] = 'n';
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
  cadena[insertaAtomo++] = 'n';
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
  cadena[insertaAtomo++] = 'r';
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
  cadena[insertaAtomo++] = 's';
}
{SimbolosEsp} {
  contTokens++;
  struct Nodo *tempToken = crearNuevoNodoToken(contTokens,5,yytext);
  agregarALista(tokensList,tempToken);
  cadena[insertaAtomo++] = *yytext;
}
{OperadoresArit} {
  contTokens++;
  struct Nodo *tempToken = crearNuevoNodoToken(contTokens,6,yytext);
  agregarALista(tokensList,tempToken);
  cadena[insertaAtomo++] = *yytext;
}
{OperadoresRela1} {
  int pos = buscaOperador(yytext);
  contTokens++;
  // Parse de int a str para la struct
  char* posStr = parseInttoString(pos);
  struct Nodo *temp = crearNuevoNodoToken(contTokens,7,posStr);
  agregarALista(tokensList,temp);

  switch(pos){
    case 2:
        cadena[insertaAtomo++] = 'l';
        break;
    case 3:
        cadena[insertaAtomo++] = 'u';
        break;
    case 4:
        cadena[insertaAtomo++] = 'e';
        break;
    case 5:
        cadena[insertaAtomo++] = 'd';
        break;
  }
}
{OperadoresRela2} {
  int pos = buscaOperador(yytext);
  contTokens++;
  // Parse de int a str para la struct
  char* posStr = parseInttoString(pos);
  struct Nodo *temp = crearNuevoNodoToken(contTokens,7,posStr);
  agregarALista(tokensList,temp);
  switch(pos){
    case 0:
        cadena[insertaAtomo++] = '<';
        break;
    case 1:
        cadena[insertaAtomo++] = '>';
        break;
  }
}
{OperadoresAsig} {
  contTokens++;
  struct Nodo *tempToken = crearNuevoNodoToken(contTokens,8,yytext);
  agregarALista(tokensList,tempToken);
  cadena[insertaAtomo++] = '=';
}
{FinDeLinea} {
  printf("");
}
. {
  // Condicion para evitar el retorno de carro como error
  if(*yytext != 13){
    printf("Error: %s\n", yytext);
    printf("Valor: %d\n", *yytext);
  }
}

%%
int yywrap(){return(1);}

// Función para crear archivo de salida con extensión .txt
void obtenerArchivoSalidaTXT(){
  archSal = fopen("analisisLexico.txt","w");
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
  archSal = fopen("analisisLexico.csv","w");
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
    muestraCadena();
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
