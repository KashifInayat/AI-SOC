for i in 64 
do
./run_dc.sh $i
./run_vcs.sh $i
./run_pt.sh $i
done
