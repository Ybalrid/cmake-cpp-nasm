#pragma once

#ifdef __cplusplus
extern "C"
{
#endif

// The calling conventions are pretty much set in stone for x64, and correspond
// to "put 4 first args in registers, the rest on the stack" See the assembly
// file comments for info about how to access these args
int compute_answer();
int sum_4_ints(int, int, int, int); // this is a prototype, the arguments don't have names but you
                                    // can put them there if you want :-)
int  sum_6_ints(int, int, int, int, int, int);
void increment_pointer_int(int*);
void swap(int*, int*);

#ifdef __cplusplus
} //End of extern "C" bloc
#endif
