# cmake-cpp-nasm

This repository demonstrate how to mix 64bit intel assembly code and a C++ project while staying "cross-platform" (at least on the OS side of things)

This has been tested under:
 - Visual Studio 2019 + NASM 2.14.02 on Windows 10 64bit
 - GCC 9.2.0 + NASM 2.14.02 On Linux 64bit
 - clang-9 + NASM 0.98.40 (Apple Computer, Inc. build 11) on MacOs X (High Sierra)

## Requirement

 - CMake
 - A C++17 compiler
 - NASM

## How it works

CMake knows about NASM. NASM is the Netwide Assembler. This is a 16/32/64bit assembler for the Intel platform that works under many operating system and than can output many formats of object code. 

The following in CMakeLists.txt is the only thing required for your .asm files to be built by NASM if CMake can find the NASM installation on your system:

```CMake
#Enable ASM provided by NASM
enable_language(ASM_NASM)

if(APPLE)
        #Add leading underscore when building macho64 object files
        string(APPEND CMAKE_ASM_NASM_FLAGS "--prefix _")
endif(APPLE)
```

A peculiarity of symbol naming under MacOs X forces us to add the missing leading unerscore for the compiled and assembled files to link together.

To export a function called `foo` from assembly:

```asm
global foo
foo:
	<... source code of foo ...>
	xor rax, rax ;put zero in rax as rax represent the return value
	ret
```

To be able to call this function from C++ code we need to do two things

 - Define an external symbol
 - Deactivate C++ name mangling on said symbol (act as a C symbol)

C++ compiler will "decorate" name of compiled functions with the type of their arguments and other info about their calling context in a process named "name mangling". This is compiler specific and not needed for interacting with assembly code.

Thankfully this is doable by using `extern "C"` like so : 

```cpp
extern "C" void foo();
```

This will permit to call the foo function.


To learn more about how to pass arguments and use the stack in your assembly functions, you need to search about X86_64 function calling conventions and respect them ;-)

Beware! These calling conventions are different between compilers and operating systems!

Here's the relevant documentation for MSVC (and Microsoft Windows in genral as far as I can tel) for x64 code: https://docs.microsoft.com/en-us/cpp/build/x64-calling-convention?view=vs-2019

For other platform (everything UNIX basically) the System V AMD64 calling convention seems to be the norm, a short summary can be found on Wikipedia here : https://en.wikipedia.org/wiki/X86_calling_conventions#System_V_AMD64_ABI

