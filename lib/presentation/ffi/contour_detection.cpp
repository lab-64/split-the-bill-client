#include "contour_detection.hpp"

double angle(cv::Point p1, cv::Point p2, cv::Point p0) {
    // Angle between Vector p0->p1 and p0->p2
    cv::Point v1 = p1 - p0;
    cv::Point v2 = p2 - p0;

    return v1.ddot(v2) / sqrt(v1.ddot(v1)* v2.ddot(v2)) + 1e-10;

}

//static double angle( cv::Point pt1, cv::Point pt2, cv::Point pt0 )
//{
//    double dx1 = pt1.x - pt0.x;
//    double dy1 = pt1.y - pt0.y;
//    double dx2 = pt2.x - pt0.x;
//    double dy2 = pt2.y - pt0.y;
//    return (dx1*dx2 + dy1*dy2)/sqrt((dx1*dx1 + dy1*dy1)*(dx2*dx2 + dy2*dy2) + 1e-10);
//}

int get_biggest_square(std::vector<std::vector<cv::Point>> squares) {
    if (squares.empty())
        return -1;
    int idx = 0;
    double maxArea = 0;
    for (int i = 0; i < squares.size(); ++i) {
        double area = cv::contourArea(squares[i]);
        if (maxArea < area) {
            maxArea = area;
            idx = i;
        }
    }
    return idx;
}


// DetectedSquare* detect_contour(uint8_t* inputBytes, uint8_t** outputBytes, uint32_t bufSize) {
DetectedSquare* detect_contour(uint8_t* inputBytes, uint32_t bufSize) {
    std::vector<uint8_t> buf(inputBytes, inputBytes + bufSize);
    cv::Mat inputMat = cv::imdecode(buf, cv::IMREAD_GRAYSCALE);
//    cv::cvtColor(inputMat, inputMat, cv::COLOR_YUV420p2BGR);
//    cv::cvtColor(inputMat, inputMat, cv::COLOR_BGR2GRAY);

//cv::Mat yuv(1, buf.size(), CV_8U, buf.data());
//cv::Mat inputMat;
//cv::cvtColor(yuv, inputMat, cv::COLOR_YUV2RGB_NV12 );


//    cv::Mat gray0(inputMat.size(), CV_8U), gray;
//
//    cv::medianBlur(inputMat, gray, 3);
//
//    std::vector<std::vector<cv::Point> > contours;
//    std::vector<std::vector<cv::Point>> squares;
//
//
//
//        const  int thresh_level = 2;
//        int thresholdLevels[] = {10, 30, 50, 70};
//        // try several threshold levels
//        for(int thresh : thresholdLevels)
//        {
////            // hack: use Canny instead of zero threshold level.
////            // Canny helps to catch squares with gradient shading
////            if( l == 0 )
////            {
////                // apply Canny. Take the upper threshold from slider
////                // and set the lower to 0 (which forces edges merging)
////                cv::Canny(gray0, gray, 10, 20, 3);
////                // dilate canny output to remove potential
////                // holes between edge segments
////                cv::dilate(gray, gray, cv::Mat(), cv::Point(-1,-1));
////            }
////            else
////            {
////                // apply threshold if l!=0:
////                // tgray(x,y) = gray(x,y) < (l+1)*255/N ? 255 : 0
////                gray = gray0 >= (l+1) * 255 / thresh_level;
////            }
//            cv::Canny(gray, gray0, thresh, thresh*3, 3);
//            cv::dilate(gray0, gray0, cv::Mat(), cv::Point(-1, -1));
//
//            // find contours and store them all as a list
//            cv::findContours(gray0, contours, cv::RETR_LIST, cv::CHAIN_APPROX_SIMPLE);
//
//            std::vector<cv::Point> approx;
//
//            // test each contour
//            for( size_t i = 0; i < contours.size(); ++i)
//            {
//                // approximate contour with accuracy proportional
//                // to the contour perimeter
//                cv::approxPolyDP(contours[i], approx, cv::arcLength(cv::Mat(contours[i]), true)*0.02, true);
//                cv::approxPolyDP(contours[i], contours[i], cv::arcLength(cv::Mat(contours[i]), true)*0.02, true);
//                // square contours should have 4 vertices after appro   ximation
//                // relatively large area (to filter out noisy contours)
//                // and be convex.
//                // Note: absolute value of an area is used because
//                // area may be positive or negative - in accordance with the
//                // contour orientation
//                if( approx.size() == 4 &&
//                    fabs(cv::contourArea(cv::Mat(approx))) > 1000 &&
//                    cv::isContourConvex(cv:: Mat(approx)) )
//                {
//                    double maxCosine = 0;
//
//                    for( int j = 2; j < 5; j++ )
//                    {
//                        // find the maximum cosine of the angle between joint edges
//                        double cosine = fabs(angle(approx[j%4], approx[j-2], approx[j-1]));
//                        maxCosine = MAX(maxCosine, cosine);
//                    }
//
//                    // if cosines of all angles are small
//                    // (all angles are ~90 degree) then write quandrange
//                    // vertices to resultant sequence
//                    if( maxCosine < 0.3 )
//                        squares.push_back(approx);
//                }
//            }
//        }




//    int height = inputMat.rows;
//    int width = inputMat.cols;
//    // Create an output Mat with the same size and type as the input
    cv::Mat blurred, outputMat;

    // Apply Gaussian blur
    cv::medianBlur(inputMat, blurred, 3); // You can adjust the kernel size (here: 5x5) and standard deviation (here: 0) as needed
    float sharpeningMaskData[9] = {-1, -1, -1, -1, 8, -1, -1, -1, -1};
    cv::Mat sharpeningMask(3, 3, CV_32F, sharpeningMaskData);
    //cv::filter2D(blurred, blurred, -1, sharpeningMask);

    cv::Mat erodeKernel(3, 3, CV_8U, 1);
    cv::Mat dilateKernel(5, 5, CV_8U, 1);
    //outputMat.convertTo(outputMat, CV_8U);
//    cv::morphologyEx(outputMat, outputMat, cv::MORPH_CLOSE, erodeKernel, cv::Point(-1, -1), 20);
//    cv::morphologyEx(outputMat, outputMat, cv::MORPH_OPEN, erodeKernel, cv::Point(-1, -1), 5);
    cv::Mat dilated;
//    cv::dilate(outputMat, outputMat, dilateKernel, cv::Point(-1, -1), 1);
//    cv::erode(outputMat, outputMat, erodeKernel, cv::Point(-1, -1), 2);
//    cv::dilate(outputMat, outputMat, dilateKernel, cv::Point(-1, -1), 3);
    cv::morphologyEx(blurred, outputMat, cv::MORPH_OPEN, dilateKernel, cv::Point(-1, -1), 3);
//    cv::morphologyEx(blurred, outputMat, cv::MORPH_OPEN, dilateKernel, cv::Point(-1, -1), 1);

//     cv::adaptiveThreshold(outputMat, outputMat, 255, cv::ADAPTIVE_THRESH_GAUSSIAN_C, cv::THRESH_BINARY, 21, 5);
    cv::threshold(outputMat, outputMat, 0, 255, cv::THRESH_OTSU + cv::THRESH_BINARY);
    //cv::Canny(outputMat, outputMat, 0, 200);

    std::vector<std::vector<cv::Point>> contours;
    std::vector<cv::Vec4i> hierarchy;
    cv::findContours(outputMat, contours, hierarchy, cv::RETR_EXTERNAL, cv::CHAIN_APPROX_TC89_L1);

    std::vector<std::vector<cv::Point>> squares;
    squares.clear();

    std::vector<cv::Point> approx;
    for (int i = 0; i < contours.size(); ++i) {
        cv::approxPolyDP(contours[i], approx, 0.02 * cv::arcLength(contours[i], true), true);
        cv::approxPolyDP(contours[i], contours[i], 0.02 * cv::arcLength(contours[i], true), true);

        if (approx.size() == 4 && fabs(cv::contourArea(approx)) > 1000 && cv::isContourConvex(approx)) {
            double maxCosine = 0;

            for (int j = 2; j < 5; ++j) {
                double cosine = fabs(angle(approx[j%4], approx[j-2], approx[j-1]));
                maxCosine = MAX(maxCosine, cosine);
            }
            if (maxCosine < 0.3){
                squares.push_back(approx);
            }
        }

    }
//    cv::Mat a(outputMat.rows, outputMat.cols, CV_8UC3, cv::Scalar(0, 0, 0));
//    cv::Mat b = cv::imdecode(buf, cv::IMREAD_COLOR);
//    if (squares.size() == 0) {
//        cv::drawContours(b, contours, -1, cv::Scalar(0, 0, 255), 10);
//
//    }
//    else
//    cv::drawContours(b, contours, -1, cv::Scalar(0, 255, 0), 10);
////    cv::polylines(b, squares, true, cv::Scalar(0, 255, 0), 10, cv::LINE_AA);
//
//    /** TODO Find the correct rectangle and its corners
//     * this is done by checking the ratio between convex hull and minimum bounding box of the contours
//     * If ratio is close to one it resembles a rectangle
//    **/
//
//    //cv::Canny(blurred, outputMat, 0, 200);
//    std::vector<uint8_t> out;
//    out.resize(10*1000*1000);
//    std::vector<int> compression_params;
////    compression_params.push_back(cv::IMWRITE_JPEG_PROGRESSIVE );
////    compression_params.push_back(1);
////    compression_params.push_back(cv::IMWRITE_JPEG_OPTIMIZE  );
////    compression_params.push_back(1);
//    //outputMat.convertTo(outputMat, CV_8U);
//    cv::imencode(".jpeg", b, out);
//
//    // Copy the data back to the output array
//    size_t count = std::min(static_cast<size_t>(out.size()), static_cast<size_t>(bufSize));
//    *outputBytes = new uint8_t[out.size()];
//    std::memmove(*outputBytes, out.data(), out.size());
//    return out.size();

    DetectedSquare* detectedSquare = new DetectedSquare();

    int idx = get_biggest_square(squares);
    if (idx < 0) {
        detectedSquare->topLeft[0] = 0;
        detectedSquare->topLeft[1] = 0;
        detectedSquare->topRight[0] = inputMat.cols;
        detectedSquare->topRight[1] = 0;
        detectedSquare->bottomLeft[0] = inputMat.rows;
        detectedSquare->bottomLeft[1] = 0;
        detectedSquare->bottomRight[0] = inputMat.rows;
        detectedSquare->bottomRight[1] = inputMat.cols;
    }
    else {
        detectedSquare->topLeft[0] = squares[idx][0].x;
        detectedSquare->topLeft[1] = squares[idx][0].y;;
        detectedSquare->topRight[0] = squares[idx][1].x;
        detectedSquare->topRight[1] = squares[idx][1].y;
        detectedSquare->bottomLeft[0] = squares[idx][2].x;
        detectedSquare->bottomLeft[1] = squares[idx][2].y;
        detectedSquare->bottomRight[0] = squares[idx][3].x;
        detectedSquare->bottomRight[1] = squares[idx][3].y;
    }
    return detectedSquare;
}

uint32_t debug_image(uint8_t* inputBytes, uint8_t** outputBytes, uint32_t bufSize) {
    std::vector<uint8_t> buf(inputBytes, inputBytes + bufSize);
//    cv::Mat inputMat = cv::imdecode(buf, cv::IMREAD_COLOR);
//    cv::cvtColor(inputMat, inputMat, cv::COLOR_YUV420p2BGR);
//    cv::cvtColor(inputMat, inputMat, cv::COLOR_BGR2GRAY);

    cv::Mat yuv(1, buf.size(), CV_8U, buf.data());
    cv::Mat inputMat;
    cv::cvtColor(yuv, inputMat, cv::COLOR_YUV420sp2BGR, 3);

    std::vector<uint8_t> out;
    out.resize(10*1000*1000);
    std::vector<int> compression_params;
//    compression_params.push_back(cv::IMWRITE_JPEG_PROGRESSIVE );
//    compression_params.push_back(1);
//    compression_params.push_back(cv::IMWRITE_JPEG_OPTIMIZE  );
//    compression_params.push_back(1);
    //outputMat.convertTo(outputMat, CV_8U);
    cv::imencode(".jpeg", inputMat, out);

    // Copy the data back to the output array
    size_t count = std::min(static_cast<size_t>(out.size()), static_cast<size_t>(bufSize));
    *outputBytes = new uint8_t[out.size()];
    std::memmove(*outputBytes, out.data(), out.size());
    return out.size();
}