for i in 16 32 64 128 256 
do
./run_dc.sh $i
./run_vcs.sh $i
./run_pt.sh $i
done
