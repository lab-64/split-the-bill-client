#pragma once
#include <math.h>
#include <stdlib.h>
#include <time.h>

#define SEED time(NULL)

__attribute__((visibility("default"))) __attribute__((used))
double monte_carlo_pi(int n);