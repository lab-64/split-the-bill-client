#pragma once

#include <cstdint>

typedef double Coord[2];

struct DetectedRectangle {
    Coord topLeft;
    Coord topRight;
    Coord bottomRight;
    Coord bottomLeft;
};

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint32_t perspectiveTransform(char* input, DetectedRectangle* cropPath,  uint8_t** output);
