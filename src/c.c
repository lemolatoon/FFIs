#include<stdio.h>
#include<stdbool.h>

void check_elapsed_time(int (*func_ptr)(int), char *lang_name);
int c_n_th_prime(int n);

void  hello_c(void) {
    printf("Hello from C\n");
    char *name = "C";
    check_elapsed_time(c_n_th_prime, name);
    printf("Exiting C...\n");
}

bool is_prime(int n);

int c_n_th_prime(int n) {
    int count = 1;
    int current_n = 2;
    for(;;) {
        if (is_prime(current_n)) {
            if (count == n) {
                return current_n;
            }
            count += 1;
        }
        current_n += 1;
    }
}

bool is_prime(int n) {
    if (n == 2) {
        return true;
    }
    if (n % 2 == 0) {
        return false;
    }
    int i = 3;
    while (i * i <= n) {
        if (n % i == 0) {
            return false;
        }
        i += 2;
    }
    return true;
}