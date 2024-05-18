cmake_minimum_required(VERSION 3.5)
project(SplitTheBill)

# Set download URL for opencv C++ package for Android
set(OPENCV_DOWNLOAD_URL "https://github.com/opencv/opencv/releases/download/4.8.0/opencv-4.8.0-android-sdk.zip")
set(OPENCV_DESTINATION_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../include")

file(MAKE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../../include")

if(NOT EXISTS "${OPENCV_DESTINATION_DIR}/opencv2")
    #file(MAKE_DIRECTORY "${OPENCV_DESTINATION_DIR}/opencv2")
    message(NOTICE "OpenCV not found. Downloading and extracting...")
    # Download
    file(DOWNLOAD ${OPENCV_DOWNLOAD_URL} "${CMAKE_CURRENT_SOURCE_DIR}/../../opencv-android.zip" SHOW_PROGRESS)
    # Extract
    execute_process(
            COMMAND ${CMAKE_COMMAND} -E tar xzf "${CMAKE_CURRENT_SOURCE_DIR}/../../opencv-android.zip"
            WORKING_DIRECTORY "${OPENCV_DESTINATION_DIR}"
    )
    # rename
    execute_process(COMMAND ${CMAKE_COMMAND} -E rename
            "${OPENCV_DESTINATION_DIR}/OpenCV-android-sdk"
            "${OPENCV_DESTINATION_DIR}/opencv2")
    file(REMOVE_RECURSE "${OPENCV_DESTINATION_DIR}/opencv2/samples")
    file(REMOVE_RECURSE "${OPENCV_DESTINATION_DIR}/opencv2/sdk/libcxx_helper")

    # move parts to the correct directories
    file(MAKE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake_libs")
    execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory "${OPENCV_DESTINATION_DIR}/opencv2/sdk/native/libs" "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake_libs")

    execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory "${OPENCV_DESTINATION_DIR}/opencv2/sdk/native/jni/include/opencv2" "${OPENCV_DESTINATION_DIR}/opencv2")

    file(REMOVE_RECURSE "${OPENCV_DESTINATION_DIR}/opencv2/sdk")

    file(REMOVE "${CMAKE_CURRENT_SOURCE_DIR}/../../opencv-android.zip")

else()
    message(NOTICE "Opencv found in ${OPENCV_DESTINATION_DIR}/opencv2")
endif()

add_library(lib_opencv SHARED IMPORTED)
set_target_properties(lib_opencv PROPERTIES IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/../../cmake_libs/${ANDROID_ABI}/libopencv_java4.so)

# Example on linkung opencv
#add_library(opencv_detection SHARED
#        ${CMAKE_CURRENT_SOURCE_DIR}/../../lib/presentation/ffi/contour_detection.cpp
#)

#target_include_directories(opencv_detection PRIVATE
#        ${OPENCV_DESTINATION_DIR}
#)

#target_link_libraries(opencv_detection PUBLIC lib_opencv)


#set(LIB_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../lib/presentation/ffi/monte_carlo_pi.c")
#
#add_library(monte_carlo_pi SHARED ${LIB_PATH})

add_library(opencv_cropping SHARED ${CMAKE_CURRENT_SOURCE_DIR}/../../lib/infrastructure/image_processing/image_cropping.cpp)

target_include_directories(opencv_cropping PRIVATE ${OPENCV_DESTINATION_DIR})

target_link_libraries(opencv_cropping PUBLIC lib_opencv)