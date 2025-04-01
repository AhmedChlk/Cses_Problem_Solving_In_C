#include <stdio.h>

int main() {
    long n;
    if (scanf("%ld", &n) != 1) {
        fprintf(stderr, "Erreur : entrée invalide.\n");
        return 1;
    }

    while (n != 1) {
        printf("%ld ", n);
        if (n % 2 == 0)
            n /= 2;
        else
            n = n * 3 + 1;
    }
    printf("%ld\n", n);
    return 0;
}
