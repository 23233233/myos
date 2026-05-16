#include "print.h"
#include "idt.h"

void idt_init(void);

void kernel_main() {
    print_clear();
    print_set_colour(PRINT_COLOUR_WHITE, PRINT_COLOUR_BLACK);
    print_str("Booting kernel...\n");

    idt_init();
    print_str("IDT initialized successfully!\n");
}