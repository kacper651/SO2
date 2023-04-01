cmake_minimum_required(VERSION 3.10)
project(SO2)

set(CMAKE_CXX_STANDARD 17)

find_package(Curses REQUIRED)
include_directories(${CURSES_INCLUDE_DIR})

add_executable(SO2 main.cpp main.cpp main.cpp main.cpp)
target_link_libraries(SO2 ${CURSES_LIBRARIES})
