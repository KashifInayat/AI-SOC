vcs -full64 ./test1.v ../../rtl/8x8_MB_Radix_8/mb8_radix8.v -ld ld -LDFLAGS "/usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o" +v2k  -gui -sverilog
./simv
#+incdir+../../rtl/s_ice/ +define+SERIAL_MULTIPLIER_TEST
#-sverilog 
