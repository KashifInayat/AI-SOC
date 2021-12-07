/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : Q-2019.12-SP5-5
// Date      : Mon Dec  6 12:59:32 2021
/////////////////////////////////////////////////////////////


module RCA_16b_final_0 ( clk, reset, cin, iso, ret, pse, a, b, s, cout );
  input [15:0] a;
  input [15:0] b;
  output [15:0] s;
  input clk, reset, cin, iso, ret, pse;
  output cout;
  wire   N17, N18, N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, N30,
         N31, N32, \intadd_1/n16 , \intadd_1/n15 , \intadd_1/n14 ,
         \intadd_1/n13 , \intadd_1/n12 , \intadd_1/n11 , \intadd_1/n10 ,
         \intadd_1/n9 , \intadd_1/n8 , \intadd_1/n7 , \intadd_1/n6 ,
         \intadd_1/n5 , \intadd_1/n4 , \intadd_1/n3 , \intadd_1/n2 ,
         \intadd_1/n1 ;

  DFFX1_RVT cout_reg ( .D(\intadd_1/n1 ), .CLK(clk), .Q(cout) );
  DFFX1_RVT \s_reg[15]  ( .D(N32), .CLK(clk), .Q(s[15]) );
  DFFX1_RVT \s_reg[14]  ( .D(N31), .CLK(clk), .Q(s[14]) );
  DFFX1_RVT \s_reg[13]  ( .D(N30), .CLK(clk), .Q(s[13]) );
  DFFX1_RVT \s_reg[12]  ( .D(N29), .CLK(clk), .Q(s[12]) );
  DFFX1_RVT \s_reg[11]  ( .D(N28), .CLK(clk), .Q(s[11]) );
  DFFX1_RVT \s_reg[10]  ( .D(N27), .CLK(clk), .Q(s[10]) );
  DFFX1_RVT \s_reg[9]  ( .D(N26), .CLK(clk), .Q(s[9]) );
  DFFX1_RVT \s_reg[8]  ( .D(N25), .CLK(clk), .Q(s[8]) );
  DFFX1_RVT \s_reg[7]  ( .D(N24), .CLK(clk), .Q(s[7]) );
  DFFX1_RVT \s_reg[6]  ( .D(N23), .CLK(clk), .Q(s[6]) );
  DFFX1_RVT \s_reg[5]  ( .D(N22), .CLK(clk), .Q(s[5]) );
  DFFX1_RVT \s_reg[4]  ( .D(N21), .CLK(clk), .Q(s[4]) );
  DFFX1_RVT \s_reg[3]  ( .D(N20), .CLK(clk), .Q(s[3]) );
  DFFX1_RVT \s_reg[2]  ( .D(N19), .CLK(clk), .Q(s[2]) );
  DFFX1_RVT \s_reg[1]  ( .D(N18), .CLK(clk), .Q(s[1]) );
  DFFX1_RVT \s_reg[0]  ( .D(N17), .CLK(clk), .Q(s[0]) );
  FADDX1_RVT \intadd_1/U17  ( .A(b[0]), .B(cin), .CI(a[0]), .CO(\intadd_1/n16 ), .S(N17) );
  FADDX1_RVT \intadd_1/U16  ( .A(a[1]), .B(b[1]), .CI(\intadd_1/n16 ), .CO(
        \intadd_1/n15 ), .S(N18) );
  FADDX1_RVT \intadd_1/U15  ( .A(a[2]), .B(b[2]), .CI(\intadd_1/n15 ), .CO(
        \intadd_1/n14 ), .S(N19) );
  FADDX1_RVT \intadd_1/U14  ( .A(a[3]), .B(b[3]), .CI(\intadd_1/n14 ), .CO(
        \intadd_1/n13 ), .S(N20) );
  FADDX1_RVT \intadd_1/U13  ( .A(a[4]), .B(b[4]), .CI(\intadd_1/n13 ), .CO(
        \intadd_1/n12 ), .S(N21) );
  FADDX1_RVT \intadd_1/U12  ( .A(a[5]), .B(b[5]), .CI(\intadd_1/n12 ), .CO(
        \intadd_1/n11 ), .S(N22) );
  FADDX1_RVT \intadd_1/U11  ( .A(a[6]), .B(b[6]), .CI(\intadd_1/n11 ), .CO(
        \intadd_1/n10 ), .S(N23) );
  FADDX1_RVT \intadd_1/U10  ( .A(a[7]), .B(b[7]), .CI(\intadd_1/n10 ), .CO(
        \intadd_1/n9 ), .S(N24) );
  FADDX1_RVT \intadd_1/U9  ( .A(a[8]), .B(b[8]), .CI(\intadd_1/n9 ), .CO(
        \intadd_1/n8 ), .S(N25) );
  FADDX1_RVT \intadd_1/U8  ( .A(a[9]), .B(b[9]), .CI(\intadd_1/n8 ), .CO(
        \intadd_1/n7 ), .S(N26) );
  FADDX1_RVT \intadd_1/U7  ( .A(a[10]), .B(b[10]), .CI(\intadd_1/n7 ), .CO(
        \intadd_1/n6 ), .S(N27) );
  FADDX1_RVT \intadd_1/U6  ( .A(a[11]), .B(b[11]), .CI(\intadd_1/n6 ), .CO(
        \intadd_1/n5 ), .S(N28) );
  FADDX1_RVT \intadd_1/U5  ( .A(a[12]), .B(b[12]), .CI(\intadd_1/n5 ), .CO(
        \intadd_1/n4 ), .S(N29) );
  FADDX1_RVT \intadd_1/U4  ( .A(a[13]), .B(b[13]), .CI(\intadd_1/n4 ), .CO(
        \intadd_1/n3 ), .S(N30) );
  FADDX1_RVT \intadd_1/U3  ( .A(a[14]), .B(b[14]), .CI(\intadd_1/n3 ), .CO(
        \intadd_1/n2 ), .S(N31) );
  FADDX1_RVT \intadd_1/U2  ( .A(a[15]), .B(b[15]), .CI(\intadd_1/n2 ), .CO(
        \intadd_1/n1 ), .S(N32) );
endmodule


module powercontrol_final ( clk, reset, pwr_sig, pse, iso, ret, pse1, iso1, 
        ret1 );
  input clk, reset, pwr_sig;
  output pse, iso, ret, pse1, iso1, ret1;
  wire   N10, N11, N12, n1, n2, n3;

  DFFX1_RVT ret_reg ( .D(N11), .CLK(clk), .Q(ret) );
  DFFX1_RVT iso_reg ( .D(N10), .CLK(clk), .Q(iso) );
  DFFX1_RVT pse_reg ( .D(N12), .CLK(clk), .Q(pse) );
  INVX0_RVT U3 ( .A(reset), .Y(n3) );
  NAND3X0_RVT U4 ( .A1(pwr_sig), .A2(ret), .A3(n3), .Y(N12) );
  INVX0_RVT U5 ( .A(pse), .Y(n2) );
  INVX0_RVT U6 ( .A(pwr_sig), .Y(n1) );
  OA221X1_RVT U7 ( .A1(pwr_sig), .A2(n2), .A3(n1), .A4(iso), .A5(n3), .Y(N11)
         );
  OA21X1_RVT U8 ( .A1(pwr_sig), .A2(ret), .A3(n3), .Y(N10) );
endmodule


module RCA_32b_final ( clk, reset, cin, pwr_sig, a, b, s );
  input [31:0] a;
  input [31:0] b;
  output [32:0] s;
  input clk, reset, cin, pwr_sig;
  wire   cout_lsb, iso, pse, net27, net28, net29, net30, net31, net32, net33,
         net34, net35, net36, net37, net38, net39, net40, net41, net42, net43,
         \lsb_rca/N32 , \lsb_rca/N31 , \lsb_rca/N30 , \lsb_rca/N29 ,
         \lsb_rca/N28 , \lsb_rca/N27 , \lsb_rca/N26 , \lsb_rca/N25 ,
         \lsb_rca/N24 , \lsb_rca/N23 , \lsb_rca/N22 , \lsb_rca/N21 ,
         \lsb_rca/N20 , \lsb_rca/N19 , \lsb_rca/N18 , \lsb_rca/N17 ,
         \intadd_0/n16 , \intadd_0/n15 , \intadd_0/n14 , \intadd_0/n13 ,
         \intadd_0/n12 , \intadd_0/n11 , \intadd_0/n10 , \intadd_0/n9 ,
         \intadd_0/n8 , \intadd_0/n7 , \intadd_0/n6 , \intadd_0/n5 ,
         \intadd_0/n4 , \intadd_0/n3 , \intadd_0/n2 , \intadd_0/n1 , n8;

  RCA_16b_final_0 msb_rca ( .clk(clk), .reset(1'b0), .cin(cout_lsb), .iso(1'b0), .ret(1'b0), .pse(pse), .a(a[31:16]), .b(b[31:16]), .s({net27, net28, net29, 
        net30, net31, net32, net33, net34, net35, net36, net37, net38, net39, 
        net40, net41, net42}), .cout(net43) );
  powercontrol_final pwr_ctrl ( .clk(clk), .reset(reset), .pwr_sig(pwr_sig), 
        .pse(pse), .iso(iso) );
  DFFX1_RVT \lsb_rca/s_reg[0]  ( .D(\lsb_rca/N17 ), .CLK(clk), .Q(s[0]) );
  DFFX1_RVT \lsb_rca/s_reg[1]  ( .D(\lsb_rca/N18 ), .CLK(clk), .Q(s[1]) );
  DFFX1_RVT \lsb_rca/s_reg[2]  ( .D(\lsb_rca/N19 ), .CLK(clk), .Q(s[2]) );
  DFFX1_RVT \lsb_rca/s_reg[3]  ( .D(\lsb_rca/N20 ), .CLK(clk), .Q(s[3]) );
  DFFX1_RVT \lsb_rca/s_reg[4]  ( .D(\lsb_rca/N21 ), .CLK(clk), .Q(s[4]) );
  DFFX1_RVT \lsb_rca/s_reg[5]  ( .D(\lsb_rca/N22 ), .CLK(clk), .Q(s[5]) );
  DFFX1_RVT \lsb_rca/s_reg[6]  ( .D(\lsb_rca/N23 ), .CLK(clk), .Q(s[6]) );
  DFFX1_RVT \lsb_rca/s_reg[7]  ( .D(\lsb_rca/N24 ), .CLK(clk), .Q(s[7]) );
  DFFX1_RVT \lsb_rca/s_reg[8]  ( .D(\lsb_rca/N25 ), .CLK(clk), .Q(s[8]) );
  DFFX1_RVT \lsb_rca/s_reg[9]  ( .D(\lsb_rca/N26 ), .CLK(clk), .Q(s[9]) );
  DFFX1_RVT \lsb_rca/s_reg[10]  ( .D(\lsb_rca/N27 ), .CLK(clk), .Q(s[10]) );
  DFFX1_RVT \lsb_rca/s_reg[11]  ( .D(\lsb_rca/N28 ), .CLK(clk), .Q(s[11]) );
  DFFX1_RVT \lsb_rca/s_reg[12]  ( .D(\lsb_rca/N29 ), .CLK(clk), .Q(s[12]) );
  DFFX1_RVT \lsb_rca/s_reg[13]  ( .D(\lsb_rca/N30 ), .CLK(clk), .Q(s[13]) );
  DFFX1_RVT \lsb_rca/s_reg[14]  ( .D(\lsb_rca/N31 ), .CLK(clk), .Q(s[14]) );
  DFFX1_RVT \lsb_rca/s_reg[15]  ( .D(\lsb_rca/N32 ), .CLK(clk), .Q(s[15]) );
  DFFX1_RVT \lsb_rca/cout_reg  ( .D(\intadd_0/n1 ), .CLK(clk), .Q(cout_lsb) );
  ISOLANDX1_RVT ISO__snps_PD_switch__PD_switch_ISO_snps_cout_UPF_ISO ( .D(
        net43), .ISO(n8), .Q(s[32]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[0]_UPF_ISO  ( .D(
        net42), .ISO(n8), .Q(s[16]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[1]_UPF_ISO  ( .D(
        net41), .ISO(n8), .Q(s[17]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[2]_UPF_ISO  ( .D(
        net40), .ISO(n8), .Q(s[18]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[3]_UPF_ISO  ( .D(
        net39), .ISO(n8), .Q(s[19]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[4]_UPF_ISO  ( .D(
        net38), .ISO(n8), .Q(s[20]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[5]_UPF_ISO  ( .D(
        net37), .ISO(n8), .Q(s[21]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[6]_UPF_ISO  ( .D(
        net36), .ISO(n8), .Q(s[22]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[7]_UPF_ISO  ( .D(
        net35), .ISO(n8), .Q(s[23]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[8]_UPF_ISO  ( .D(
        net34), .ISO(n8), .Q(s[24]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[9]_UPF_ISO  ( .D(
        net33), .ISO(n8), .Q(s[25]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[10]_UPF_ISO  ( .D(
        net32), .ISO(n8), .Q(s[26]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[11]_UPF_ISO  ( .D(
        net31), .ISO(n8), .Q(s[27]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[12]_UPF_ISO  ( .D(
        net30), .ISO(n8), .Q(s[28]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[13]_UPF_ISO  ( .D(
        net29), .ISO(n8), .Q(s[29]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[14]_UPF_ISO  ( .D(
        net28), .ISO(n8), .Q(s[30]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  ISOLANDX1_RVT \ISO__snps_PD_switch__PD_switch_ISO_snps_s[15]_UPF_ISO  ( .D(
        net27), .ISO(n8), .Q(s[31]) ); //synopsys isolation_upf PD_switch_ISO+PD_switch
  FADDX1_RVT \intadd_0/U17  ( .A(b[0]), .B(cin), .CI(a[0]), .CO(\intadd_0/n16 ), .S(\lsb_rca/N17 ) );
  FADDX1_RVT \intadd_0/U16  ( .A(a[1]), .B(b[1]), .CI(\intadd_0/n16 ), .CO(
        \intadd_0/n15 ), .S(\lsb_rca/N18 ) );
  FADDX1_RVT \intadd_0/U15  ( .A(a[2]), .B(b[2]), .CI(\intadd_0/n15 ), .CO(
        \intadd_0/n14 ), .S(\lsb_rca/N19 ) );
  FADDX1_RVT \intadd_0/U14  ( .A(a[3]), .B(b[3]), .CI(\intadd_0/n14 ), .CO(
        \intadd_0/n13 ), .S(\lsb_rca/N20 ) );
  FADDX1_RVT \intadd_0/U13  ( .A(a[4]), .B(b[4]), .CI(\intadd_0/n13 ), .CO(
        \intadd_0/n12 ), .S(\lsb_rca/N21 ) );
  FADDX1_RVT \intadd_0/U12  ( .A(a[5]), .B(b[5]), .CI(\intadd_0/n12 ), .CO(
        \intadd_0/n11 ), .S(\lsb_rca/N22 ) );
  FADDX1_RVT \intadd_0/U11  ( .A(a[6]), .B(b[6]), .CI(\intadd_0/n11 ), .CO(
        \intadd_0/n10 ), .S(\lsb_rca/N23 ) );
  FADDX1_RVT \intadd_0/U10  ( .A(a[7]), .B(b[7]), .CI(\intadd_0/n10 ), .CO(
        \intadd_0/n9 ), .S(\lsb_rca/N24 ) );
  FADDX1_RVT \intadd_0/U9  ( .A(a[8]), .B(b[8]), .CI(\intadd_0/n9 ), .CO(
        \intadd_0/n8 ), .S(\lsb_rca/N25 ) );
  FADDX1_RVT \intadd_0/U8  ( .A(a[9]), .B(b[9]), .CI(\intadd_0/n8 ), .CO(
        \intadd_0/n7 ), .S(\lsb_rca/N26 ) );
  FADDX1_RVT \intadd_0/U7  ( .A(a[10]), .B(b[10]), .CI(\intadd_0/n7 ), .CO(
        \intadd_0/n6 ), .S(\lsb_rca/N27 ) );
  FADDX1_RVT \intadd_0/U6  ( .A(a[11]), .B(b[11]), .CI(\intadd_0/n6 ), .CO(
        \intadd_0/n5 ), .S(\lsb_rca/N28 ) );
  FADDX1_RVT \intadd_0/U5  ( .A(a[12]), .B(b[12]), .CI(\intadd_0/n5 ), .CO(
        \intadd_0/n4 ), .S(\lsb_rca/N29 ) );
  FADDX1_RVT \intadd_0/U4  ( .A(a[13]), .B(b[13]), .CI(\intadd_0/n4 ), .CO(
        \intadd_0/n3 ), .S(\lsb_rca/N30 ) );
  FADDX1_RVT \intadd_0/U3  ( .A(a[14]), .B(b[14]), .CI(\intadd_0/n3 ), .CO(
        \intadd_0/n2 ), .S(\lsb_rca/N31 ) );
  FADDX1_RVT \intadd_0/U2  ( .A(a[15]), .B(b[15]), .CI(\intadd_0/n2 ), .CO(
        \intadd_0/n1 ), .S(\lsb_rca/N32 ) );
  INVX2_RVT snps_iso_control_inv_0 ( .A(iso), .Y(n8) );
endmodule

