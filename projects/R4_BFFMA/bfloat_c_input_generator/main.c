#include <stdio.h>
#include <math.h>
#include <time.h>
#include <stdlib.h>
#include <limits.h>


/////////////////FLOAT32 TO FLOAT16//////////////////
float fp32tobf16(float x)
{
    float y = x;
    int *p = (int *) &y;
    unsigned int exp, man;
    exp = *p & 0x7F800000u;
    man = *p & 0x007FFFFFu;
    if (exp == 0 && man == 0) {
        // zero
        return x; 
    }
    if (exp == 0x7F800000u) {
        // infinity or Nans
        return x;
    }
    // Normalized number
    // round to nearest
    float r = x;
    int *pr = (int *) &r;
    *pr &= 0xff800000; // r has the same exp as x
    r = r / 256;
    y = x + r;

    *p &= 0xffff0000;

    return y;
}

/////////////////Print in HEX//////////////////
void print_hex(float x)
{
    int *p = (int*) &x;
    printf("%f=%x\n", x, *p);
}

typedef union sfpFp {
    unsigned int sfp;
    float fp;
} SFP;


int main()
{
//    float t_a[]= {1.2, 2.31, 3.46, 5.63};
  //  float bf_a;
    
    
    // for (int i=0; i < 4; i++) {
      //  print_hex(t_a[i]);
       // bf_a = fp32tobf16(t_a[i]);
        //print_hex(bf_a);
    //}

    ///return 0;
    FILE* fp32;
    fp32 = fopen("sub_inputsfp32.txt", "w");
	FILE* bf16;
	bf16 = fopen("sub_inputsbf16.txt", "w");
    FILE* bf16_in_fp32;
    bf16_in_fp32 = fopen("sub_inputsbf16_in_fp32.txt", "w");
    srand(time(NULL));
    int i;
    SFP a_32, b_32, c_32, res_32;
    SFP a_16, b_16, res_16;
    for (i = 0; i < 1000; i++) {
        a_32.fp = (float)rand() / (float)INT_MAX;
        b_32.fp = (float)rand() / (float)INT_MAX;
        c_32.fp = (float)rand() / (float)INT_MAX;
        c_32.fp = -c_32.fp;
    ////////////////FP32 to bf16 Conversion///////////     
    	a_16.fp = fp32tobf16(a_32.fp);
        b_16.fp = fp32tobf16(b_32.fp);
    ////////////////FP32 File/////////////////////////    
        res_32.fp = fmaf(a_32.fp, b_32.fp, c_32.fp);
        fprintf(fp32, "%x %x %x %x\n", a_32.sfp, b_32.sfp, c_32.sfp, res_32.sfp);
    ////////////////bf16 File/////////////////////////    
		res_16.fp = fmaf(a_16.fp, b_16.fp, c_32.fp);
        fprintf(bf16, "%x %x %x %x\n", a_16.sfp, b_16.sfp, c_32.sfp, res_16.sfp);
    ////////////////f16_in_fp32 File/////////////////////////
        fprintf(bf16_in_fp32, "%x %x %x %x\n", a_16.sfp, b_16.sfp, c_32.sfp, res_16.sfp);
    }
	

return 0;

}

