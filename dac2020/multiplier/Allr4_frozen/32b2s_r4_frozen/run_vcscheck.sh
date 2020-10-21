vcs -full64 ./test.v ./r4_32bit2s.v -ld ld -LDFLAGS "/usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o" +v2k  +define+Multiplier #+define+INPUT_FILE_NAMEX=\"./inputs/xbitwidth_32_n_10000.txt\"  +define+INPUT_FILE_NAMEY=\"./inputs/ybitwidth_32_n_10000.txt\" 
 -sverilog -gui
./simv
#+incdir+../../rtl/s_ice/ +define+SERIAL_MULTIPLIER_TEST
#-sverilog 
