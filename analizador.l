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
ConstantesNum {constantesNumEnt}|{constantesNumOct}
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
{ConstantesNum} {
  contTokens++;
  // Se añade a la tabla de tokens
  struct Nodo *tempToken = crearNuevoNodoToken(contTokens,2,yytext);
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
    // Se ejecuta lex
    yylex();
    // Se cierra el flujo del archivo
    fclose(yyin);
    // Se generan los archivos de salida
    obtenerArchivoSalidaCSV();
    obtenerArchivoSalidaTXT();
    // Se muestra la salida del programa
    mostrarSalida();
  }else{
    // La entrada sera por teclado
    yylex();
  }
  // mostrarSalida();
  return 0;
}
