cmake_minimum_required(VERSION 3.19)
project(app LANGUAGES CXX)

# Override with -DCMAKE_PREFIX_PATH=... or CMakeUserPresets.json.
# Do not commit a machine-only path as the only way to configure.
# if(WIN32)
#   list(PREPEND CMAKE_PREFIX_PATH "D:/Qt/6.10.0/msvc2022_64")
# endif()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Widgets)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_standard_project_setup()
else()
    set(CMAKE_AUTOMOC ON)
    set(CMAKE_AUTOUIC ON)
endif()
set(CMAKE_AUTORCC ON)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_add_executable(${PROJECT_NAME} app/main.cpp)
else()
    add_executable(${PROJECT_NAME} app/main.cpp)
endif()

target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Widgets
)
