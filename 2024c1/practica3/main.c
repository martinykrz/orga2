#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <ctype.h>
#include <assert.h>
#include <math.h>
#include <stdbool.h>
#include <float.h>

#include "test-utils.h"
#include "checkpoints.h"

#define ARR_LENGTH  4
#define ROLL_LENGTH 10

static uint32_t x[ROLL_LENGTH];
static double   f[ROLL_LENGTH];

void shuffle(uint32_t max){
	for (int i = 0; i < ROLL_LENGTH; i++) {
		x[i] = (uint32_t) rand() % max;
        f[i] = ((float)rand()/(float)(RAND_MAX)) * max;
	}
}

TEST(test_strLen) {
	TEST_ASSERT_EQUALS(uint32_t,  0, strLen(""));
	TEST_ASSERT_EQUALS(uint32_t,  3, strLen("sar"));
	TEST_ASSERT_EQUALS(uint32_t,  2, strLen("23"));
	TEST_ASSERT_EQUALS(uint32_t,  4, strLen("taaa"));
	TEST_ASSERT_EQUALS(uint32_t,  3, strLen("tbb"));
	TEST_ASSERT_EQUALS(uint32_t,  3, strLen("tix"));
	TEST_ASSERT_EQUALS(uint32_t,  5, strLen("taaab"));
	TEST_ASSERT_EQUALS(uint32_t,  4, strLen("taa0"));
	TEST_ASSERT_EQUALS(uint32_t,  3, strLen("tbb"));
	TEST_ASSERT_EQUALS(uint32_t, 11, strLen("Hola mundo!"));
	TEST_ASSERT_EQUALS(uint32_t,  9, strLen("Astronomo"));
	TEST_ASSERT_EQUALS(uint32_t, 10, strLen("Astrognomo"));
	TEST_ASSERT_EQUALS(uint32_t, 19, strLen("Campeones del mundo"));
}

TEST(test_strClone_string_normal) {
	char* a = "Omega 4";
	char* ac = strClone(a);
	TEST_ASSERT(a != ac);
	strcpy(assert_name, "ac == \"Omega 4\"");
	TEST_ASSERT(ac[0] == 'O' && ac[1] == 'm' && ac[2] == 'e' && ac[3] == 'g' && ac[4] == 'a' && ac[5] == ' ' && ac[6] == '4' && ac[7] == '\0');

	strDelete(ac);
}

TEST(test_strClone_string_vacio) {
	char* n = "";
	char* nc = strClone(n);
	TEST_ASSERT(n != nc);
	strcpy(assert_name, "ac == \"\"");
	TEST_ASSERT(nc[0] == '\0');

	strDelete(nc);
}

TEST(test_strCmp_las_cadenas_que_son_iguales_son_iguales) {
	// Esta cadena vive en la pila
	char cadena[] = "Orga 2!";
	TEST_ASSERT_EQUALS(int32_t, 0, strCmp("Orga 2!", cadena));
	TEST_ASSERT_EQUALS(int32_t, 0, strCmp(cadena,    "Orga 2!"));
	TEST_ASSERT_EQUALS(int32_t, 0, strCmp("Omega 4", "Omega 4"));
	TEST_ASSERT_EQUALS(int32_t, 0, strCmp("",        ""));
	TEST_ASSERT_EQUALS(int32_t, 0, strCmp("Palaven", "Palaven"));
	TEST_ASSERT_EQUALS(int32_t, 0, strCmp("Feros",   "Feros"));
}

TEST(test_strCmp_vacio_es_menor_a_todo) {
	// Esta cadena vive en la pila
	char cadena[] = "Orga 2!";
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("", cadena));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("", "Omega 4"));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("", "Feros"));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("", "Palaven"));
}

TEST(test_strCmp_hay_cadenas_menores_a_otras) {
	// Esta cadena vive en la pila
	char cadena[] = "Orga 2!";
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("Omega 4",    cadena));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp(cadena,       "Orga 3?"));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("Feros",      "Omega 4"));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("Feros",      "Palaven"));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("Omega 4",    "Palaven"));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("Astrognomo", "Astronomo")); // Obviamente, porque un astro-gnomo va a ser más chiquitito
}

TEST(test_strCmp_todo_es_mayor_a_vacio) {
	// Esta cadena vive en la pila
	char cadena[] = "Orga 2!";
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp(cadena,    ""));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Omega 4", ""));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Feros",   ""));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Palaven", ""));
}


TEST(test_strCmp_hay_cadenas_mayores_a_otras) {
	// Esta cadena vive en la pila
	char cadena[] = "Orga 2!";
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp(cadena,      "Omega 4"));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Orga 3?",   cadena));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Omega 4",   "Feros"));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Palaven",   "Feros"));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Palaven",   "Omega 4"));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Astronomo", "Astrognomo")); // Obviamente, porque un astro-gnomo va a ser más chiquitito
}

TEST(test_strCmp_stress_test) {
	char* cadenas[9] = {"sar","23","taaa","tbb","tix", "taaab", "taa0", "tbb", ""};
	int32_t resultados[9][9] = {
		{  0, -1,  1,  1,  1,  1,  1,  1, -1 },
		{  1,  0,  1,  1,  1,  1,  1,  1, -1 },
		{ -1, -1,  0,  1,  1,  1, -1,  1, -1 },
		{ -1, -1, -1,  0,  1, -1, -1,  0, -1 },
		{ -1, -1, -1, -1,  0, -1, -1, -1, -1 },
		{ -1, -1, -1,  1,  1,  0, -1,  1, -1 },
		{ -1, -1,  1,  1,  1,  1,  0,  1, -1 },
		{ -1, -1, -1,  0,  1, -1, -1,  0, -1 },
		{  1,  1,  1,  1,  1,  1,  1,  1,  0 },
	};

	for (int i = 0; i < 9; i++) {
		for (int j = 0; j < 9; j++) {
			sprintf(assert_name, "strCmp(\"%s\", \"%s\")", cadenas[i], cadenas[j]);
			TEST_ASSERT_EQUALS(int32_t, resultados[i][j], strCmp(cadenas[i], cadenas[j]));
		}
	}
}

int main (void){
	/* Acá pueden realizar sus propias pruebas */
	// assert(alternate_sum_4(8,2,5,1) == 10);	
    srand(0);

    printf("= Checkpoint 4\n");
	printf("==============\n");
	test_strLen();
	test_strClone_string_normal();
	test_strClone_string_vacio();
	test_strCmp_las_cadenas_que_son_iguales_son_iguales();
	test_strCmp_vacio_es_menor_a_todo();
	test_strCmp_hay_cadenas_menores_a_otras();
	test_strCmp_todo_es_mayor_a_vacio();
	test_strCmp_hay_cadenas_mayores_a_otras();
	test_strCmp_stress_test();
	printf("\n");   
	
	return 0;    
}
