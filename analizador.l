%{
/*
  Analizador léxico en lex para
  el lenguaje descrito en clase.
  
  Integrantes:
    - Núñez Quintana Luis Axel 
    - Leyva Mercado Christian Alejandro
  Fecha de elaboración: 01 de noviembre del 2022
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

// Firma de funciones de analizador sintáctico
void getchar();
void error(char*)
void program();
void veredicto();
void rechaza();
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

void getchar(){
    return cadena[atomo++];
}

void veredicto(){
    if (errores = 0){
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
    if(c == 'b'|| c == 'g'|| c == '#'|| c == 'y'|| c == 'x'){
        func();
        otrafunc();
        return;
    }else{
        error("bg#yx");
    }
    rechaza();
}

void otraFunc(){ // 2
    if(c == 'b'|| c == 'g'|| c == '#'|| c == 'y'|| c == 'x'){
        func();
        otrafunc();
        return;
    }else if(c == '_'){
        return;
    }else{
        error("bg#yx_");
    }
    rechaza();
}

void func(){ // 3
    if(c == 'b'|| c == 'g'|| c == '#'|| c == 'y'|| c == 'x'){
        tipo();
        if(c == 'i'){
            c = getchar();
            if(c == '('){
                c = getchar();
                param();
                if(c == ')'){
                    c = getchar();
                    if(c == '{'){
                        c = getchar();
                        cuerpo();
                        if(c == '}'){
                            c = getchar();
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
    rechaza();
}

void param(){ // 4
    if(c == 'b'|| c == 'g'|| c == '#'|| c == 'y'|| c == 'x'){
        tipo();
        if(c == 'i'){
            c = getchar();
            otroparam();
            return;
        }else{
            error("i");
        }
    }else if(c == ')'){
        return;
    }else{
        error("bg#yx)");
    }
    rechaza();
}

void otroParam(){ // 5
    if(c == ','){
        c = getchar();
        tipo();
        if(c == 'i'){
            c = getchar();
            otroparam();
            return;
        }else{
            error("i");
        }
    }else if(c == ')'){
        return;
    }else{
        error(",)");
    }
    rechaza();
}

void cuerpo(){ // 6
    if(c == 'b'|| c == 'g'|| c == '#'|| c == 'y'|| c == 'x'||
        c == 'i'|| c == 'f'|| c == 'h'|| c == 'w'|| c == 'j'|| 
        c == '}'|| c == '['|| c == 'z'|| c == 'c'){
        decl();
        listaP();
        return;
    }else{
        error("bg#yxifhwj}[zc");
    }
    rechaza();
}

void decl(){ // 7
    if(c == 'i'|| c == 'f'|| c == 'h'|| c == 'w'|| c == 'j'|| 
        c == '}'|| c == '['|| c == 'z'|| c == 'c'){
        return;
    }else if(c == 'b'|| c == 'g'|| c == '#'|| c == 'y'|| c == 'x'){
        d();
        decl();
        return;
    }else{
        error("bg#yxifhwj}[zc");
    }
    rechaza();
}

void d(){ // 8
    if(c == 'b'|| c == 'g'|| c == '#'|| c == 'y'|| c == 'x'){
        tipo();
        k();
        if(c == ';'){
            c = getchar();
            return;
        }else{
            error(";");
        }
    }else{
        error("bg#yx");
    }
    rechaza();
}

void tipo(){ // 9
    if(c == 'b'){
        c = getchar();
        return;
    }else if( c == 'g'){
        c = getchar();
        return;
    }else if( c == '#'){
        c = getchar();
        return;
    }else if( c == 'y'){
        c = getchar();
        return;
    }else if( c == 'x'){
        c = getchar();
        return;
    }else{
        error("bg#yx");
    }
    rechaza();
}


void k(){ // 10
    if(c == 'i'){
        c = getchar();
        q();
        return;
    }else{
        error("i");
    }
    rechaza();
}

void q(){ // 11
    if(c == ';'){
        return;
    }else if(c == '='){
        c = getchar();
        n();
        c();
        return;
    }else if(c == ','){
        c = getchar();
        k();
        return;
    }else{
        error(";=,");
    }
    rechaza();
}

void n(){ // 12
    if(c == 'n'){
        c = getchar();
        return;
    }else if(c == 'r'){
        c = getchar();
        return;
    }else if(c == 's'){
        c = getchar();
        return;
    }else{
        error("nrs");
    }
    rechaza();
}

void d(){ // 13
    if(c == ';'){
        return;
    }else if(c == ','){
        c = getchar();
        k();
        return;
    }else{
        error(";,");
    }
    rechaza();
}

void a(){ // 14
    if(c == 'i'){
        c = getchar();
        if(c == '='){
            c = getchar();
            aPrima();
            return;
        }else{
            error("=");
        }
    }else{
        error("i");
    }
    rechaza();
}

void a(){ // 15
    if(c == 's'){
        c = getchar();
        return;
    }else if(c == '(' || c == 'i' || c == 'n' || c == 'r' ||
             c == '['){
        e();
        return;
    }else{
        error("s(inr[");
    }
    rechaza();
}

void e(){ // 16
    if(c == '(' || c == 'i' || c == 'n' || c == 'r' ||
        c == '['){
        t();
        ePrima();
        return;
    }else{
        error("(inr[");
    }
    rechaza();
}

void ePrima(){ // 17
    if(c == '+'){
        c = getchar();
        t();
        ePrima();
        return;
    }else if(c == '-'){
        c = getchar();
        t();
        ePrima();
        return;
    } else if(c == ';' || c == ')'){
        return;
    }else{
        error("+-;)");
    }
    rechaza();
}

void t(){ // 18
    if(c == '(' || c == 'i' || c == 'n' || c == 'r' ||
        c == '['){
        f();
        tPrima();
        return;
    }else{
        error("(inr[");
    }
    rechaza();
}

void tPrima(){ // 19
    if(c == '*'){
        c = getchar();
        f();
        tPrima();
        return;
    }else if(c == '/'){
        c = getchar();
        f();
        tPrima();
        return;
    }else if(c == '\\'){
        c = getchar();
        f();
        tPrima();
        return;
    }else if(c == '%%'){
        c = getchar();
        f();
        tPrima();
        return;
    }else if(c == '^'){
        c = getchar();
        f();
        tPrima();
        return;
    }else if(c == '+'|| c == '-' || c == ')' || c== ';'){
        return;
    }else{
        error("*/\\%%^+-);");
    }
    rechaza();
}

void f(){ // 20
    if(c == '('){
        c = getchar();
        E();
        if(c == ')'){
            c = getchar();
            return;
        }else{
            error(")");
        }
    }else if(c == 'i'){
        c = getchar();
        return;
    }else if(c == 'n'){
        c = getchar();
        return;
    }else if(c == 'r'){
        c = getchar();
        return;
    }else if(c == '['){
        llama();
        return;
    }else{
        error("(inr[");
    }
    rechaza();
}

void r(){ // 21
    if(c == 'i'){
        c = getchar();
        rPrima();
        v();
        return;
    }else if(c == 'n'){
        c = getchar();
        rPrima();
        vPrima();
        return;
    }else if(c == 'r'){
        c = getchar();
        rPrima();
        vBiPrima();
        return;
    }else if(c == 's'){
        c = getchar();
        rPrima();
        vTriPrima();
        return;
    }else{
        error("inrs");
    }
    rechaza();
}

void rPrima(){ // 22
    if(c == '<'){
        c = getchar();
        return;
    }else if(c == '>'){
        c = getchar();
        return;
    }else if(c == 'l'){
        c = getchar();
        return;
    }else if(c == 'e'){
        c = getchar();
        return;
    }else if(c == 'd'){
        c = getchar();
        return;
    }else if(c == 'u'){
        c = getchar();
        return;
    }else{
        error("<>ledu");
    }
    rechaza();
}

void v(){ // 23
    if(c == 'i'){
        c = getchar();
        return;
    }else if(c == 'n'){
        c = getchar();
        return;
    }else if(c == 'r'){
        c = getchar();
        return;
    }else if(c == 's'){
        c = getchar();
        return;
    }else{
        error("inrs");
    }
    rechaza();
}

void vPrima(){ // 24
    if(c == 'i'){
        c = getchar();
        return;
    }else if(c == 'n'){
        c = getchar();
        return;
    }else{
        error("in");
    }
    rechaza();
}

void vBiPrima(){ // 25
    if(c == 'i'){
        c = getchar();
        return;
    }else if(c == 'r'){
        c = getchar();
        return;
    }else{
        error("ir");
    }
    rechaza();
}

void vTriPrima(){ // 26
    if(c == 'i'){
        c = getchar();
        return;
    }else if(c == 's'){
        c = getchar();
        return;
    }else{
        error("is");
    }
    rechaza();
}

void p(){ // 27
    if(c == 'i'){
        a();
        return;
    }else if(c == 'f'){
        i();
        return;
    }else if(c == 'h'){
        h();
        return;
    }else if(c == 'w'){
        w();
        return;
    }else if(c == 'j'){
        j();
        return;
    }else if(c == '['){
        llama();
        return;
    }else if(c == 'z'){
        devuelve();
        return;
    }else if(c == 'c'){
        c = getchar();
        if(c == ';'){
            c = getchar();
            return;
        }else{
            error(";");
        }
    }else{
        error("ifhwj[zc");
    }
    rechaza();
}

void listaP(){ // 28
    if(c == '}' || c == 't' || c == ':' || c == 'q' ||
        c == 'a'|| c == 'o'){
        return;
    }else if(c == 'i'|| c == 'f'|| c == 'h'|| c == 'w'|| c == 'j'|| 
             c == '['|| c == 'z'|| c == 'c'){
        p();
        listaP();
        return;
    }else{
        error("}t:qaoifhwj[zc");
    }
    rechaza();
}

void w(){ // 29
    if(c == 'w'){
        c = getchar();
        if(c == '('){
            c = getchar();
            r();
            if(c == ')'){
                c = getchar();
                if(c == 'm'){
                    c = getchar();
                    if(c == '{'){
                        c = getchar();
                        listaP();
                        if(c == '}'){
                            c = getchar();
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
    rechaza();
}

void i(){ // 30
    if(c == 'f'){
        c = getchar();
        if(c == '('){
            c = getchar();
            r();
            if(c == ')'){
                c = getchar();
                listaP();
                iPrima();
                if(c == ':'){
                    c = getchar();
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
    rechaza();
}

void iPrima(){ // 31
    if(c == 't'){
        c = getchar();
        listaP();
        return;
    }else if(c == ':'){
        return;
    }else{
        error("t:");
    }
    rechaza();
}

void j(){ // 32
    if(c == 'j'){
        c = getchar();
        if(c == '('){
            c = getchar();
            y();
            x();
            z();
            if(c == '{'){
                c = getchar();
                listaP();
                if(c == '}'){
                    c = getchar();
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
    rechaza();
}

void y(){ // 33
    if(c == 'i'){
        c = getchar();
        if(c == '='){
            c = getchar();
            e();
            if(c == ';'){
                c = getchar();
                return;
            }else{
                error(";");
            }
        }else{
            error("=");
        }
    }else if(c == ';'){
        c = getchar();
        return;
    }else{
        error("i;");
    }
    rechaza();
}

void x(){ // 34
    if(c == 'i'|| c == 'n'|| c == 'r'|| c == 's'){
        r();
        if(c == ';'){
            c = getchar();
            return;
        }else{
            error(";");
        }
    }else if(c == ';'){
        c = getchar();
        return;
    }else{
        error("inrs;");
    }
    rechaza();
}

void z(){ // 35
    if(c == 'i'){
        c = getchar();
        if(c == '='){
            c = getchar();
            e();
            if(c == ')'){
                c = getchar();
                return;
            }else{
                error(")");
            }
        }else{
            error("=");
        }
    }else if(c == ')'){
        c = getchar();
        return;
    }else{
        error("i)");
    }
    rechaza();
}

void h(){ // 36
    if(c == 'h'){
        c = getchar();
        if(c == '('){
            c = getchar();
            if(c == 'i'){
                c = getchar();
                if(c == ')'){
                    c = getchar();
                    if(c == '{'){
                        c = getchar();
                        cPrima();
                        oPrima();
                        if(c == '}'){
                            c = getchar();
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
    rechaza();
}

void cPrima(){ // 37
    if(c == 'a'){
        c = getchar();
        if(c == 'n'){
            c = getchar();
            if(c == ':'){
                c = getchar();
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
    }else if(c == 'o' || c == '}'){
        return;
    }else{
        error("ao}");
    }
    rechaza();
}

void oPrima(){ // 38
    if(c == 'o'){
        c = getchar();
        if(c == ':'){
            c = getchar();
            listaP();
            return;
        }else{
            error(":");
        }
    }else if(c == '}'){
        return;
    }else{
        error("o}");
    }
    rechaza();
}

void u(){ // 39
    if(c == 'q'){
        c = getchar();
        return;
    }else if(c == 'a' || c == 'o' || c == '}'){
        return;
    }else{
        error("qao}");
    }
    rechaza();
}

void devuelve(){ // 40
    if(c == 'z'){
        c = getchar();
        if(c == '('){
            c = getchar();
            valor();
            if(c == ')'){
                c = getchar();
                if(c == ';'){
                    c = getchar();
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
    rechaza();
}

void valor(){ // 41
    if(c == ')'){
        return;
    }else if(c == 'i'|| c == 'n'|| c == 'r'|| c == 's'){
        v();
        return;
    }else{
        error("inrs)");
    }
    rechaza();
}

void llama(){ // 42
    if(c == '['){
        c = getchar();
        if(c == 'i'){
            c = getchar();
            if(c == '('){
                c = getchar();
                arg();
                if(c == ')'){
                    c = getchar();
                    if(c == ']'){
                        c = getchar();
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
    rechaza();
}

void arg(){ // 43
    if(c == ')'){
        return;
    }else if(c == 'i'|| c == 'n'|| c == 'r'|| c == 's'){
        v();
        otroArg();
        return;
    }else{
        error(")inrs");
    }
    rechaza();
}

void otroArg(){ // 44
    if(c == ')'){
        return;
    }else if(c == ','){
        c = getchar();
        v();
        otroArg();
    }else{
        error("),");
    }
    rechaza();
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
    c = getchar();
    program();
    veredicto();
  }else{
    // La entrada sera por teclado
    yylex();
  }
  // mostrarSalida();
  return 0;
}
