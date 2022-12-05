#include <stdio.h>
#include <string.h>
#include <stdlib.h>

const int LONGITUD_MAXIMA_CADENAS = 50;

struct Nodo{
    int posicion;
    int clase;
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

struct Nodo *crearNuevoNodo(int posicion,int clase, char *valor)
{
    struct Nodo *nuevoNodo = NULL;
    nuevoNodo = malloc(sizeof(struct Nodo));
    nuevoNodo->sig = NULL;
    nuevoNodo->posicion = posicion;
    nuevoNodo->clase = clase;
    nuevoNodo->valor = valor;
    return nuevoNodo;
}

int main(){
    struct Lista *lista = crearLista();
    struct Nodo *nodo = crearNuevoNodo(0,8,"a");
    struct Nodo *nodo2 = crearNuevoNodo(1,8,"a");
    agregarALista(lista,nodo);
    agregarALista(lista,nodo2);
    // printf("El nodo 2 contiene: %d & %s", lista->tail->clase, lista->tail->valor);
    int prueba = 0;
    prueba++;
    printf("%d",prueba);
    return 0;
}