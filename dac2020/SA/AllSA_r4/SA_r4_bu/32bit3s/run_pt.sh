if [ $# -eq 0 ] 
then
	echo "ex> ./run_pt.sh [array size]"
	exit
fi
pt_shell -f power_vector.ptcl -x "set array_size $1"  | tee run_pt.$1\.out
