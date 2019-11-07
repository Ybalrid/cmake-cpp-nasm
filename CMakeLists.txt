cmake_minimum_required(VERSION 3.14)
project (cmake-cpp-nasm)

#Set C++ language version
set(CMAKE_CXX_STANDARD 17)
#Enable ASM provided by NASM
enable_language(ASM_NASM)

if(APPLE)
	#Add leading underscore when building macho64 object files
	string(APPEND CMAKE_ASM_NASM_FLAGS "--prefix _")
endif(APPLE)

#Make a EXE with cpp and asm files
add_executable(cmake-cpp-nasm cpp.cpp asm.asm)

