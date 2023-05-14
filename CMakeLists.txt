cmake_minimum_required(VERSION 3.15)

project(run)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --std=c++17 -Os -pthread -g")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --std=c++17 -pthread")
find_package(OpenCV 4.5.0)
set(CMAKE_PREFIX_PATH /opt/intel/openvino_2021/deployment_tools/inference_engine/share)
find_package(InferenceEngine REQUIRED)
# set(CMAKE_PREFIX_PATH /opt/intel/openvino_2021/deployment_tools/ngraph/cmake)
# find_package(ngraph)
find_package(Eigen3 REQUIRED)
# Disable ROS yaml-cpp
add_definitions(-DUSE_ROS_YAML_CPP=0)

# Find system yaml-cpp
# find_package(yaml-cpp REQUIRED )
include_directories(/usr/local/include/)
find_library(YAML_CPP_LIB yaml-cpp /usr/local/lib)
find_package(PythonLibs REQUIRED)
find_package(matplotlib_cpp REQUIRED)
# 定义自己编译的Ceres的库目录
set(Ceres_LIBS_DIR /usr/local/ceres/lib)
# 定义CeresConfig.cmake所在文件目录
set(Ceres_DIR ${Ceres_LIBS_DIR}/cmake/Ceres)
find_package(Ceres REQUIRED)
message(STATUS "Found Ceres: ${CERES_FOUND}")
message(STATUS "    Ceres Include Dirs: ${CERES_INCLUDE_DIRS}")
message(STATUS "    Ceres Libs: ${CERES_LIBRARIES}")
find_package(fmt REQUIRED)
find_package(glog REQUIRED)
message("glog_include_dirs=${GLOG_INCLUDE_DIRS}")
message("glog_libraries=${GLOG_LIBRARIES}")

include_directories(${OpenCV_INCLUDE_DIRS})
include_directories(${EIGEN3_INCLUDE_DIRS})
include_directories(${InferenceEngine_INCLUDE_DIRS})
include_directories(${YAML_CPP_INCLUDE_DIRS})
include_directories(
        ${GLOB_INCLUDE_DIRS}
)
include_directories(${CERES_INCLUDE_DIRS})

add_executable(run
        main.cpp
        ${PROJECT_SOURCE_DIR}/autoaim/armor_tracker.cpp
        ${PROJECT_SOURCE_DIR}/autoaim/armor_tracker.h
        ${PROJECT_SOURCE_DIR}/autoaim/autoaim.cpp
        ${PROJECT_SOURCE_DIR}/autoaim/autoaim.h
        ${PROJECT_SOURCE_DIR}/autoaim/detector/inference.cpp
        ${PROJECT_SOURCE_DIR}/autoaim/detector/inference.h
        ${PROJECT_SOURCE_DIR}/autoaim/predictor/predictor.cpp
        ${PROJECT_SOURCE_DIR}/autoaim/predictor/predictor.h
        ${PROJECT_SOURCE_DIR}/buff/fan_tracker.cpp
        ${PROJECT_SOURCE_DIR}/buff/fan_tracker.h
        ${PROJECT_SOURCE_DIR}/buff/buff.cpp
        ${PROJECT_SOURCE_DIR}/buff/buff.h
        ${PROJECT_SOURCE_DIR}/buff/detector/inference.cpp
        ${PROJECT_SOURCE_DIR}/buff/detector/inference.h
        ${PROJECT_SOURCE_DIR}/buff/predictor/predictor.cpp
        ${PROJECT_SOURCE_DIR}/buff/predictor/predictor.h
        ${PROJECT_SOURCE_DIR}/debug.h
        ${PROJECT_SOURCE_DIR}/general/general.cpp
        ${PROJECT_SOURCE_DIR}/general/general.h
        ${PROJECT_SOURCE_DIR}/coordsolver/coordsolver.cpp
        ${PROJECT_SOURCE_DIR}/coordsolver/coordsolver.h
        ${PROJECT_SOURCE_DIR}/filter/particle_filter.cpp
        ${PROJECT_SOURCE_DIR}/filter/particle_filter.h
        ${PROJECT_SOURCE_DIR}/thread/thread.cpp
        ${PROJECT_SOURCE_DIR}/thread/thread.h
        ${PROJECT_SOURCE_DIR}/camera/DaHengCamera.h
        ${PROJECT_SOURCE_DIR}/camera/DaHengCamera.cpp
        ${PROJECT_SOURCE_DIR}/camera/DaHengCamera.cpp
        ${PROJECT_SOURCE_DIR}/camera/DxImageProc.h
        ${PROJECT_SOURCE_DIR}/camera/GxIAPI.h
        ${PROJECT_SOURCE_DIR}/serial/serialport.cpp
        ${PROJECT_SOURCE_DIR}/serial/serialport.h
        ${PROJECT_SOURCE_DIR}/serial/wt61pc.cpp
        ${PROJECT_SOURCE_DIR}/serial/wt61pc.h
        ${PROJECT_SOURCE_DIR}/serial/CRC_Check.cpp
        ${PROJECT_SOURCE_DIR}/serial/CRC_Check.h
        )



target_link_libraries(run ${OpenCV_LIBRARIES} ${InferenceEngine_LIBRARIES} ${Eigen3_LIBRARIES}
        yaml-cpp gxiapi Ceres::ceres fmt::fmt matplotlib_cpp::matplotlib_cpp ${GLOG_LIBRARIES} ${YAML_CPP_LIBRARIES} )

# Ceres::ceres
