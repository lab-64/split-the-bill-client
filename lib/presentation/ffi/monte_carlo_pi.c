#include "monte_carlo_pi.h"

double monte_carlo_pi(int n) {
    srand(SEED);

    int count = 0;

    double x, y, d, pi;

    for (int i = 0; i < n; ++i) {
        x = (double) rand() / RAND_MAX;
        y = (double) rand() / RAND_MAX;

        d = x*x + y*y;

        if (d <= 1) {
            ++count;
        }
    }

    pi = (double) count / n * 4;

    return pi;
}