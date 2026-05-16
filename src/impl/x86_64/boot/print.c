#include "print.h"

const static size_t NUM_COLS = 80;
const static size_t NUM_ROWS = 25;

struct Char {
    uint8_t c;
    uint8_t colour;
};

struct Char* buffer = (struct Char*) 0xb8000;
size_t column = 0;
size_t row = 0;
uint8_t colour = PRINT_COLOUR_WHITE | PRINT_COLOUR_BLACK << 4;

void clear_row(size_t row) {
    struct Char empty = (struct Char) { .c = ' ', .colour = colour };

    for (size_t column = 0; column < NUM_COLS; column++) {
        buffer[row * NUM_COLS + column] = empty;
    }
}

void print_clear() {
    for (size_t i = 0; i < NUM_ROWS; i++) {
        clear_row(i);
    }
}

void print_newline() {
    column = 0;

    if (row < NUM_ROWS - 1) {
        row++;
        return;
    }

    for (size_t row = 1; row < NUM_ROWS; row++) {
        for (size_t column = 0; column < NUM_COLS; column++) {
            struct Char c = buffer[column + NUM_COLS * row];
            buffer[column + NUM_COLS * (row - 1)] = c;
        }
    }

    clear_row(NUM_ROWS - 1);
}

void print_char(char c) {
    if (c == '\n') {
        print_newline();
        return;
    }

    if (column >= NUM_COLS) {
        print_newline();
    }

    buffer[column + NUM_COLS * row] = (struct Char) { .c = (uint8_t) c, .colour = colour };

    column++;
}

void print_str(char* str) {
    for (size_t i = 0; 1; i++) {
        char c = (uint8_t) str[i];

        if (c == '\0') {
            return;
        }

        print_char(c);
    }
}

void print_set_colour(uint8_t fg, uint8_t bg) {
    colour = fg + (bg << 4);
}