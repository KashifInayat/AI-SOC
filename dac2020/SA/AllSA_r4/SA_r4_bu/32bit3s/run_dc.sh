if [ $# -eq 0 ] 
then
	echo "ex> ./run_dc.sh [array size]"
	exit
fi
dc_shell-xg-t -f dcopt2s.tcl -x "set array_size $1" | tee run_dc.$1\.out
