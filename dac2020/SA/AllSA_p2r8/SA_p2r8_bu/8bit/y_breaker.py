VPE=256

print("module sa_2D( AA, BB, CLK, RST,")
for i in range(VPE):
    print ("Y_%d,"% i)
print(");")
de = """
parameter HPE=64;  // step 1 horizontal processing elements
parameter VPE=64;  // vertical processing elements

parameter WIDTH=8;   // step 2 operands width  
`define P_W 16        // outputs width  
`define M_W 8        // width 
parameter group_cnt=(WIDTH>>2)+1;     // no of groups
input   [WIDTH*HPE-1:0]  AA;
input   [WIDTH*HPE-1:0]  BB;
input           CLK;
input           RST;
"""
print(de)
for i in range(VPE):
    print ("output   [(2*WIDTH*HPE)-1:0]  Y_%d;" % i);

print("""
genvar i,j;
generate
    for (j = 0; j < HPE; j = j + 1) begin: outputs
""")

for i in range(VPE):
    print("assign Y_%d[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][%d];" % (i,i))
print("""
end
endgenerate
"""
)



