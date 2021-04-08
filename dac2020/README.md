#FSA

This repo contains the verilog code of unsigned multipliers and tensor processing cores 8x8,16x16,32x32,64x64,128x128 with TCL and Shell files of synopsys tools. This work published in DAC2020 and entitled:

Factored Systolic Array Tensor Processing (https://ieeexplore.ieee.org/abstract/document/9218585)

## Prerequisites
To use these files, you must have synopsys tools:  VCS, DC, PrimeTime PX, PrimePower




## SAs usage:
1) copy the right multiplier into  ./designs/mult.ddc
2) dc_shell-xg-t -f dcopt_PE.tcl (to synthesize PE)
3) ./run_dc.sh [array_size]  (.e.g., ./run_dc.sh 16) for DC
4) ./run_vcs.sh [array_zie] for VCS
5) ./run_pt.sh [array_size] for PrimeTime Px/PrimePower

## Multiplier usage:
Use the following commands to get the corresponding tool:

- For DC
```bash
./run_dc.sh  for DC
```
- For VCS
```bash
./run_vcs.sh for VCS
```
For Px Prime Power
```bash
./run_pt.sh  for PrimeTime Px/PrimePower
```

##Citation
If you find FSA useful in your research, please consider citing:
```

@inproceedings{ullah2020factored,
  title={Factored radix-8 systolic array for tensor processing},
  author={Ullah, Inayat and Inayat, Kashif and Yang, Joon-Sung and Chung, Jaeyong},
  booktitle={2020 57th ACM/IEEE Design Automation Conference (DAC)},
  pages={1--6},
  year={2020},
  organization={IEEE}
}
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure you have valid license to proceed with the synopsys tools.
