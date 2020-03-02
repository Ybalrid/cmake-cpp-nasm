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


#If the goal is to interact with C++ code and assembly code, calling convention
#changes between platform, some adjustment on the assembly code is required.

#The following will pre-define a NASM macro "WIN32". This permit to conditionally assemble
#code in the following manner :
#  %ifdef WIN32
#     ;code for Windows ABI
#  %else
#     ;code for System V AMD64 ABI
#  %endif
if(WIN32)
	string(APPEND CMAKE_ASM_NASM_FLAGS "-dWIN32=1")
endif(WIN32)


#Make a EXE with cpp and asm files
add_executable(cmake-cpp-nasm cpp.cpp asm.asm library.asm library.hpp)

