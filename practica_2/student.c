#include "student.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>


void printStudent(student_t *stud)
{
    printf("Nombre: %s\ndni: %d\n", stud->name, stud->dni);
    printf("Calificaciones: ");
    for (int i=0; i < 3; i++) {
        printf("%d, ", stud->califications[i]);
    }
    printf("\nConcepto: %d\n", stud->concept);
}

void printStudentp(studentp_t *stud)
{
    printf("Nombre: %s\ndni: %d\n", stud->name, stud->dni);
    printf("Calificaciones: ");
    for (int i=0; i < 3; i++) {
        printf("%d, ", stud->califications[i]);
    }
    printf("\nConcepto: %d\n", stud->concept);
}
