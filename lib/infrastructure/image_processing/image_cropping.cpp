#include "image_cropping.hpp"

#include <vector>
#include <algorithm>

#include <opencv2/imgproc.hpp>
#include <opencv2/imgcodecs.hpp>

uint32_t perspectiveTransform(char* input, DetectedRectangle* cropPath, uint8_t** output) {
//    std::vector<uint8_t> inputBuf (input, input + inputSize);
//    cv::Mat originalImg = cv::imdecode(inputBuf, cv::IMREAD_COLOR);
    cv::Mat originalImg = cv::imread(input, cv::IMREAD_COLOR);
    if (originalImg.empty()) {
        return 42;
    }
    cv::cvtColor(originalImg, originalImg, cv::COLOR_RGBA2BGR);
    cv::Point2f src[4], dst[4];
    src[0].x = cropPath->topLeft[0] * originalImg.cols;
    src[0].y = cropPath->topLeft[1] * originalImg.rows;
    src[1].x = cropPath->topRight[0] * originalImg.cols;
    src[1].y = cropPath->topRight[1] * originalImg.rows;
    src[2].x = cropPath->bottomRight[0] * originalImg.cols;
    src[2].y = cropPath->bottomRight[1] * originalImg.rows;
    src[3].x = cropPath->bottomLeft[0] * originalImg.cols;
    src[3].y = cropPath->bottomLeft[1] * originalImg.rows;

    double width1 = sqrt(pow(src[1].x - src[0].x, 2) + pow(src[1].y - src[0].y, 2));
    double width2 = sqrt(pow(src[3].x - src[2].x, 2) + pow(src[3].y - src[2].y, 2));
    double height1 = sqrt(pow(src[0].x - src[3].x, 2) + pow(src[0].y - src[3].y, 2));
    double height2 = sqrt(pow(src[1].x - src[2].x, 2) + pow(src[1].y - src[2].y, 2));

    float maxWidth = std::max(width1, width2);
    float maxHeight = std::max(height1, height2);

    dst[0].x = 0;
    dst[0].y = 0;
    dst[1].x = maxWidth;
    dst[1].y = 0;
    dst[2].x = maxWidth;
    dst[2].y = maxHeight;
    dst[3].x = 0;
    dst[3].y = maxHeight;

    cv::Mat projectedImg;
    cv::Mat perspectiveTransform = cv::getPerspectiveTransform(src, dst);
    cv::warpPerspective(originalImg, projectedImg, perspectiveTransform, cv::Size(maxWidth, maxHeight));

    std::vector<uint8_t> outBuf;
    outBuf.resize(1000*1000);
    cv::imencode(".jpeg", projectedImg, outBuf);

    *output = new uint8_t [outBuf.size()];
    std::memmove(*output, outBuf.data(), outBuf.size());
    return outBuf.size();
}