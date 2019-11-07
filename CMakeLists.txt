cmake_minimum_required(VERSION 3.14)
project (cmake-cpp-nasm)

#Set C++ language version
set(CMAKE_CXX_STANDARD 17)
#Enable ASM provided by NASM
enable_language(ASM_NASM)

#Make a EXE with cpp and asm files
add_executable(cmake-cpp-nasm cpp.cpp asm.asm)

