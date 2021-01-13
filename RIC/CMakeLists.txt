cmake_minimum_required(VERSION 3.5)
project(RIC)
set(CMAKE_CXX_STANDARD 14)
add_definitions(-DWITH_SSE)
find_package(OpenCV REQUIRED)

include_directories(${OpenCV_INCLUDE_DIRS})

add_executable(${PROJ_NAME} main.cpp RIC.cpp SLIC.cpp)

target_link_libraries(main ${OpenCV_LIBS})

