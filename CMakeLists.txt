cmake_minimum_required(VERSION 3.26)

# Must at least specify Swift as a language here, otherwise CMake won't be able to determine
# the linker languauge in target_link_libraries later on.
#
# The CXX is not necessary yet (there are no files in the Swift-SDL3-Boilerplate project that are C++)
# but will be necessary later if we want to write C++ interop code with Swift.
#
project(Swift-SDL3-Boilerplate LANGUAGES CXX Swift)

# Suppose you wanted to add C++ interop code later...
# From: https://github.com/apple/swift-cmake-examples/tree/main

#set(CMAKE_CXX_STANDARD 17)

# Verify that we have a new enough compiler
#if("${CMAKE_Swift_COMPILER_VERSION}" VERSION_LESS 5.10)
#  message(FATAL_ERROR "Bidirectional C++ Interop requires Swift 5.10 or greater. Have ${CMAKE_Swift_COMPILER_VERSION}")
#endif()

#if(NOT "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" AND
#   NOT "${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
#  message(FATAL_ERROR "Project requires building with Clang.
#  Have ${CMAKE_CXX_COMPILER_ID}")
#endif()

# From: https://github.com/libsdl-org/SDL/blob/main/docs/INTRO-cmake.md
#
# Set the output directory for built objects.
# This makes sure that the dynamic library goes into the build directory automatically.
#
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/$<CONFIGURATION>")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/$<CONFIGURATION>")

# This assumes the SDL source is available in dependencies/SDL
add_subdirectory(dependencies/SDL)

# Create your executable target as usual
add_executable(swift-sdl-boilerplate src/main.swift)

# At the moment, this is needed purely for the modulemap file. Just adding it as a source file to the executable doesn't work.
# The modulemap is essentially a header file, and needs to be included (in the sense of "-I") so that Swift can correctly find
# the module to compile against.
#
# For a more modular setup, you might want to create a third outer directory called modules/, and then make a subdirectory
# for each dependency in dependencies/ (so just one called SDL/ for now) then place the modulemap inside that directory,
# pointed to the correct header location(s) in the appropriate dependency. One modulemap directory/file for each dependency.
#
# But this is boilerplate so we do it the quick way.
target_include_directories(swift-sdl-boilerplate PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>)

# Link to the SDL3 library
target_link_libraries(swift-sdl-boilerplate PRIVATE SDL3::SDL3)

# From: https://github.com/Ravbug/sdl3-sample
# If using satelite libraries (like SDL3_image::SDL3_image) SDL3 must be the last item in the link libraries list.
