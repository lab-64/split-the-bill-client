#pragma once
#include <iostream>
#include <vector>
#include <cstdint>
#include <opencv2/opencv.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>

typedef double Coord[2];

struct DetectedSquare{
    Coord topLeft;
    Coord topRight;
    Coord bottomLeft;
    Coord bottomRight;
};

// DetectedSquare* detect_contour(uint8_t* inputBytes, uint8_t** outputBytes, uint32_t bufSize);

extern "C" __attribute__((visibility("default"))) __attribute__((used))
DetectedSquare* detect_contour(uint8_t* inputBytes, uint32_t bufSize);

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint32_t debug_image(uint8_t* inputBytes, uint8_t** outputBytes, uint32_t bufSize);
