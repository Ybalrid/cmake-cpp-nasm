#pragma once

#ifdef __cplusplus
#include <cstdint>
extern "C"
{
#else
#include <stdint.h>
#endif

// This test the WIN32 macro
bool asm_is_windows();


// The calling conventions are pretty much set in stone for x64, and correspond
// to "put 4 first args in registers, the rest on the stack" See the assembly
// file comments for info about how to access these args
int compute_answer();
int sum_4_ints(int, int, int, int); // this is a prototype, the arguments don't have names but you
                                    // can put them there if you want :-)

// Test to dereference a C pointer in assembly and mutate it's content
void increment_pointer_int64(int64_t*);


#ifdef __cplusplus
} //End of extern "C" bloc
#endif
