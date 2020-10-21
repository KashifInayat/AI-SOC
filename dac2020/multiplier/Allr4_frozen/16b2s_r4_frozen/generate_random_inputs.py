#!/usr/bin/python2.7 
import numpy as np
import math

np.random.seed(7)

def float2fixed(v, fb):
    return int(v*(2.0**fb))

def write_rom(filename, vec, width):
    f = open(filename, 'w')
    digits = int(math.ceil(width/4.0))
    fmtstr = "%%0%dx\n" % digits
    for i in range(vec.size):
        f.write(fmtstr % (vec[i] & ((1<<(digits*4))-1)))

def generate_inputs(bitwidth=8, n_vecs=1000):
    prob = np.random.random(n_vecs)
    values = np.random.randint(0, 2**bitwidth-1, n_vecs)
	#values[prob<=sparsity] = 0
    write_rom("./inputs/bitwidth_%d_n_%d.txt" % (bitwidth, n_vecs), values, bitwidth)

#n_points = 20
#for i in range(n_points+1):
generate_inputs(32, 10000)
