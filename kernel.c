#define VIDEO_MEMORY ((volatile char*)0xB8000)//special memory address for text mode display

void clear_screen() {
    for (int i = 0; i < 80 * 25 * 2; i++) {
        VIDEO_MEMORY[i] = 0;
    }
}

void print_string(const char* str, int color) {
    static int offset = 0;
    while (*str) {
        if (*str == '\n') {
            offset = (offset / 80 + 1) * 80; 
        } else {
            VIDEO_MEMORY[offset * 2] = *str;
            VIDEO_MEMORY[offset * 2 + 1] = color;
            offset++;
        }
        str++;
    }
}

void int_to_string(int num, char* str) {
    int i = 0, sign = num;
    if (num < 0) num = -num;
    
    do {
        str[i++] = num % 10 + '0';
    } while ((num /= 10) > 0);
    
    if (sign < 0) str[i++] = '-';
    str[i] = '\0';
    
    
    for (int j = 0, k = i - 1; j < k; j++, k--) {
        char temp = str[j];
        str[j] = str[k];
        str[k] = temp;
    }
}

int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return (b != 0) ? a / b : 0; }

void main() {
    clear_screen();
    
    int a = 15, b = 5;
    char result_str[20];
    
    print_string("Simple OS Calculator\n", 0x0F);
    
    int result = add(a, b);
    int_to_string(result, result_str);
    print_string("Addition: ", 0x07);
    print_string(result_str, 0x0A);
    print_string("\n", 0x07); 
    
    result = subtract(a, b);
    int_to_string(result, result_str);
    print_string("Subtraction: ", 0x07);
    print_string(result_str, 0x0C);
    print_string("\n", 0x07); 
    
    result = multiply(a, b);
    int_to_string(result, result_str);
    print_string("Multiplication: ", 0x07);
    print_string(result_str, 0x0E);
    print_string("\n", 0x07); 
    
    result = divide(a, b);
    int_to_string(result, result_str);
    print_string("Division: ", 0x07);
    print_string(result_str, 0x09);
    print_string("\n", 0x07); 
}

