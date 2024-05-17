#pragma once

#include <cstdint>

typedef double Coord[2];

struct DetectedRectangle {
    Coord topLeft;
    Coord topRight;
    Coord bottomRight;
    Cord bottomLeft;
};

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint32_t perspectiveTransform(uint8_t* input, DetectedRectangle cropPath,  uint8_t** output, uint32_t inputSize);
