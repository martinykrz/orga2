#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "checkpoints.h"

#define HANDS 1024
#define ITERATIONS 30
#define VECTOR_LENGTH 128 

static uint16_t x[VECTOR_LENGTH];
static uint16_t y[VECTOR_LENGTH];

char suits[4][9] = {"\xE2\x99\xA5", "\xE2\x99\xA6", "\xE2\x99\xA3", "\xE2\x99\xA0"};
char faces[13][6] = {"A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J",
                     "Q", "K"};

void shuffle(uint64_t max) {
    for (int i = 0; i < VECTOR_LENGTH; i++) {
        x[i] = (uint16_t)rand() % max;
        y[i] = (uint16_t)rand() % max;
    }
}

uint32_t shuffle_int(uint32_t min, uint32_t max) {
    return (uint32_t)(rand() % (max - min)) + min;
}

card_t *get_deck() {
    card_t *deck = (card_t *)malloc(sizeof(card_t) * 52);
    for (int i = 0; i < 52; i++) {
        deck[i].suit = i / 13;
        deck[i].value = i % 13 + 1;
    }
    return deck;
}

void print_card(card_t card) {
    printf("%s%s\n", faces[card.value - 1], suits[card.suit]);
}

void print_deck(card_t *deck) {
    for (int i = 0; i < 52; i++)
    {
        printf("Card %d: ", i);
        print_card(deck[i]);
    }
}

card_t *get_hand(card_t *deck) {
    card_t *hand = (card_t *)malloc(sizeof(card_t) * 5);
    for (int i = 0; i < 4; i++) {
        hand[i] = deck[i];
    }
    return hand;
}

card_t get_random_card() {
    return (card_t){.suit = shuffle_int(0, 4), .value = shuffle_int(1, 14)};
}

void shuffle_cards(card_t *array, size_t n) {
    if (n > 1) {
        size_t i;
        for (i = 0; i < n - 1; i++) {
            size_t j = i + rand() / (RAND_MAX / (n - i) + 1);
            card_t t = array[j];
            array[j] = array[i];
            array[i] = t;
        }
    }
}

card_t four[4] = {0};

void reset_four_of_a_kind() {
    uint8_t value = shuffle_int(2, 14);
    four[0].suit = CLUBS;
    four[0].value = value;
    four[1].suit = DIAMONDS;
    four[1].value = value;
    four[2].suit = HEARTS;
    four[2].value = value;
    four[3].suit = SPADES;
    four[3].value = value;
}

void get_four_of_a_kind(card_t *hand) {
    reset_four_of_a_kind();
    shuffle_cards(four, 4);

    for (int i = 0; i < 4; i++) {
        hand[i] = four[i];
    }
}

void test_four_of_a_kind() {
    card_t *deck = get_deck();
    for (int i = 0; i < ITERATIONS; i++) {
        card_t *test_data = (card_t *)malloc(sizeof(card_t) * 4 * HANDS);

        for (int i = 0; i < HANDS; i++) {
            uint32_t luck = shuffle_int(0, 10);

            if (luck >= 9) {
                get_four_of_a_kind(&test_data[i * 4]);
            } else {
                shuffle_cards(deck, 52);
                card_t *hand = get_hand(deck);
                for (int j = 0; j < 4; j++) {
                    test_data[i * 4 + j] = hand[j];
                }
                free(hand);
            }
        }
        
        uint32_t poker_hands_c = four_of_a_kind_c(test_data, HANDS);
        uint32_t poker_hands_asm = four_of_a_kind_asm(test_data, HANDS);

        printf("c: %d, asm: %d\n", poker_hands_c, poker_hands_asm);

        free(test_data);
    }
    free(deck);
}


int main (void){
	/* Acá pueden realizar sus propias pruebas */
    srand(0);
    test_four_of_a_kind();
	return 0;    
}
