module sa_2D( AA, BB, CLK, RST,
Y_0,
Y_1,
Y_2,
Y_3,
Y_4,
Y_5,
Y_6,
Y_7,
Y_8,
Y_9,
Y_10,
Y_11,
Y_12,
Y_13,
Y_14,
Y_15,
Y_16,
Y_17,
Y_18,
Y_19,
Y_20,
Y_21,
Y_22,
Y_23,
Y_24,
Y_25,
Y_26,
Y_27,
Y_28,
Y_29,
Y_30,
Y_31,
Y_32,
Y_33,
Y_34,
Y_35,
Y_36,
Y_37,
Y_38,
Y_39,
Y_40,
Y_41,
Y_42,
Y_43,
Y_44,
Y_45,
Y_46,
Y_47,
Y_48,
Y_49,
Y_50,
Y_51,
Y_52,
Y_53,
Y_54,
Y_55,
Y_56,
Y_57,
Y_58,
Y_59,
Y_60,
Y_61,
Y_62,
Y_63,
Y_64,
Y_65,
Y_66,
Y_67,
Y_68,
Y_69,
Y_70,
Y_71,
Y_72,
Y_73,
Y_74,
Y_75,
Y_76,
Y_77,
Y_78,
Y_79,
Y_80,
Y_81,
Y_82,
Y_83,
Y_84,
Y_85,
Y_86,
Y_87,
Y_88,
Y_89,
Y_90,
Y_91,
Y_92,
Y_93,
Y_94,
Y_95,
Y_96,
Y_97,
Y_98,
Y_99,
Y_100,
Y_101,
Y_102,
Y_103,
Y_104,
Y_105,
Y_106,
Y_107,
Y_108,
Y_109,
Y_110,
Y_111,
Y_112,
Y_113,
Y_114,
Y_115,
Y_116,
Y_117,
Y_118,
Y_119,
Y_120,
Y_121,
Y_122,
Y_123,
Y_124,
Y_125,
Y_126,
Y_127,
Y_128,
Y_129,
Y_130,
Y_131,
Y_132,
Y_133,
Y_134,
Y_135,
Y_136,
Y_137,
Y_138,
Y_139,
Y_140,
Y_141,
Y_142,
Y_143,
Y_144,
Y_145,
Y_146,
Y_147,
Y_148,
Y_149,
Y_150,
Y_151,
Y_152,
Y_153,
Y_154,
Y_155,
Y_156,
Y_157,
Y_158,
Y_159,
Y_160,
Y_161,
Y_162,
Y_163,
Y_164,
Y_165,
Y_166,
Y_167,
Y_168,
Y_169,
Y_170,
Y_171,
Y_172,
Y_173,
Y_174,
Y_175,
Y_176,
Y_177,
Y_178,
Y_179,
Y_180,
Y_181,
Y_182,
Y_183,
Y_184,
Y_185,
Y_186,
Y_187,
Y_188,
Y_189,
Y_190,
Y_191,
Y_192,
Y_193,
Y_194,
Y_195,
Y_196,
Y_197,
Y_198,
Y_199,
Y_200,
Y_201,
Y_202,
Y_203,
Y_204,
Y_205,
Y_206,
Y_207,
Y_208,
Y_209,
Y_210,
Y_211,
Y_212,
Y_213,
Y_214,
Y_215,
Y_216,
Y_217,
Y_218,
Y_219,
Y_220,
Y_221,
Y_222,
Y_223,
Y_224,
Y_225,
Y_226,
Y_227,
Y_228,
Y_229,
Y_230,
Y_231,
Y_232,
Y_233,
Y_234,
Y_235,
Y_236,
Y_237,
Y_238,
Y_239,
Y_240,
Y_241,
Y_242,
Y_243,
Y_244,
Y_245,
Y_246,
Y_247,
Y_248,
Y_249,
Y_250,
Y_251,
Y_252,
Y_253,
Y_254,
Y_255
);

parameter HPE=64;  // step 1 horizontal processing elements
parameter VPE=64;  // vertical processing elements

parameter WIDTH=32;   // step 2 operands width  
`define P_W 64        // outputs width  
`define M_W 32        // width 
parameter group_cnt=(WIDTH>>2)+3;     // no of groups
input   [WIDTH*HPE-1:0]  AA;
input   [WIDTH*HPE-1:0]  BB;
input           CLK;
input           RST;

output   [(2*WIDTH*HPE)-1:0]  Y_0;
output   [(2*WIDTH*HPE)-1:0]  Y_1;
output   [(2*WIDTH*HPE)-1:0]  Y_2;
output   [(2*WIDTH*HPE)-1:0]  Y_3;
output   [(2*WIDTH*HPE)-1:0]  Y_4;
output   [(2*WIDTH*HPE)-1:0]  Y_5;
output   [(2*WIDTH*HPE)-1:0]  Y_6;
output   [(2*WIDTH*HPE)-1:0]  Y_7;
output   [(2*WIDTH*HPE)-1:0]  Y_8;
output   [(2*WIDTH*HPE)-1:0]  Y_9;
output   [(2*WIDTH*HPE)-1:0]  Y_10;
output   [(2*WIDTH*HPE)-1:0]  Y_11;
output   [(2*WIDTH*HPE)-1:0]  Y_12;
output   [(2*WIDTH*HPE)-1:0]  Y_13;
output   [(2*WIDTH*HPE)-1:0]  Y_14;
output   [(2*WIDTH*HPE)-1:0]  Y_15;
output   [(2*WIDTH*HPE)-1:0]  Y_16;
output   [(2*WIDTH*HPE)-1:0]  Y_17;
output   [(2*WIDTH*HPE)-1:0]  Y_18;
output   [(2*WIDTH*HPE)-1:0]  Y_19;
output   [(2*WIDTH*HPE)-1:0]  Y_20;
output   [(2*WIDTH*HPE)-1:0]  Y_21;
output   [(2*WIDTH*HPE)-1:0]  Y_22;
output   [(2*WIDTH*HPE)-1:0]  Y_23;
output   [(2*WIDTH*HPE)-1:0]  Y_24;
output   [(2*WIDTH*HPE)-1:0]  Y_25;
output   [(2*WIDTH*HPE)-1:0]  Y_26;
output   [(2*WIDTH*HPE)-1:0]  Y_27;
output   [(2*WIDTH*HPE)-1:0]  Y_28;
output   [(2*WIDTH*HPE)-1:0]  Y_29;
output   [(2*WIDTH*HPE)-1:0]  Y_30;
output   [(2*WIDTH*HPE)-1:0]  Y_31;
output   [(2*WIDTH*HPE)-1:0]  Y_32;
output   [(2*WIDTH*HPE)-1:0]  Y_33;
output   [(2*WIDTH*HPE)-1:0]  Y_34;
output   [(2*WIDTH*HPE)-1:0]  Y_35;
output   [(2*WIDTH*HPE)-1:0]  Y_36;
output   [(2*WIDTH*HPE)-1:0]  Y_37;
output   [(2*WIDTH*HPE)-1:0]  Y_38;
output   [(2*WIDTH*HPE)-1:0]  Y_39;
output   [(2*WIDTH*HPE)-1:0]  Y_40;
output   [(2*WIDTH*HPE)-1:0]  Y_41;
output   [(2*WIDTH*HPE)-1:0]  Y_42;
output   [(2*WIDTH*HPE)-1:0]  Y_43;
output   [(2*WIDTH*HPE)-1:0]  Y_44;
output   [(2*WIDTH*HPE)-1:0]  Y_45;
output   [(2*WIDTH*HPE)-1:0]  Y_46;
output   [(2*WIDTH*HPE)-1:0]  Y_47;
output   [(2*WIDTH*HPE)-1:0]  Y_48;
output   [(2*WIDTH*HPE)-1:0]  Y_49;
output   [(2*WIDTH*HPE)-1:0]  Y_50;
output   [(2*WIDTH*HPE)-1:0]  Y_51;
output   [(2*WIDTH*HPE)-1:0]  Y_52;
output   [(2*WIDTH*HPE)-1:0]  Y_53;
output   [(2*WIDTH*HPE)-1:0]  Y_54;
output   [(2*WIDTH*HPE)-1:0]  Y_55;
output   [(2*WIDTH*HPE)-1:0]  Y_56;
output   [(2*WIDTH*HPE)-1:0]  Y_57;
output   [(2*WIDTH*HPE)-1:0]  Y_58;
output   [(2*WIDTH*HPE)-1:0]  Y_59;
output   [(2*WIDTH*HPE)-1:0]  Y_60;
output   [(2*WIDTH*HPE)-1:0]  Y_61;
output   [(2*WIDTH*HPE)-1:0]  Y_62;
output   [(2*WIDTH*HPE)-1:0]  Y_63;
output   [(2*WIDTH*HPE)-1:0]  Y_64;
output   [(2*WIDTH*HPE)-1:0]  Y_65;
output   [(2*WIDTH*HPE)-1:0]  Y_66;
output   [(2*WIDTH*HPE)-1:0]  Y_67;
output   [(2*WIDTH*HPE)-1:0]  Y_68;
output   [(2*WIDTH*HPE)-1:0]  Y_69;
output   [(2*WIDTH*HPE)-1:0]  Y_70;
output   [(2*WIDTH*HPE)-1:0]  Y_71;
output   [(2*WIDTH*HPE)-1:0]  Y_72;
output   [(2*WIDTH*HPE)-1:0]  Y_73;
output   [(2*WIDTH*HPE)-1:0]  Y_74;
output   [(2*WIDTH*HPE)-1:0]  Y_75;
output   [(2*WIDTH*HPE)-1:0]  Y_76;
output   [(2*WIDTH*HPE)-1:0]  Y_77;
output   [(2*WIDTH*HPE)-1:0]  Y_78;
output   [(2*WIDTH*HPE)-1:0]  Y_79;
output   [(2*WIDTH*HPE)-1:0]  Y_80;
output   [(2*WIDTH*HPE)-1:0]  Y_81;
output   [(2*WIDTH*HPE)-1:0]  Y_82;
output   [(2*WIDTH*HPE)-1:0]  Y_83;
output   [(2*WIDTH*HPE)-1:0]  Y_84;
output   [(2*WIDTH*HPE)-1:0]  Y_85;
output   [(2*WIDTH*HPE)-1:0]  Y_86;
output   [(2*WIDTH*HPE)-1:0]  Y_87;
output   [(2*WIDTH*HPE)-1:0]  Y_88;
output   [(2*WIDTH*HPE)-1:0]  Y_89;
output   [(2*WIDTH*HPE)-1:0]  Y_90;
output   [(2*WIDTH*HPE)-1:0]  Y_91;
output   [(2*WIDTH*HPE)-1:0]  Y_92;
output   [(2*WIDTH*HPE)-1:0]  Y_93;
output   [(2*WIDTH*HPE)-1:0]  Y_94;
output   [(2*WIDTH*HPE)-1:0]  Y_95;
output   [(2*WIDTH*HPE)-1:0]  Y_96;
output   [(2*WIDTH*HPE)-1:0]  Y_97;
output   [(2*WIDTH*HPE)-1:0]  Y_98;
output   [(2*WIDTH*HPE)-1:0]  Y_99;
output   [(2*WIDTH*HPE)-1:0]  Y_100;
output   [(2*WIDTH*HPE)-1:0]  Y_101;
output   [(2*WIDTH*HPE)-1:0]  Y_102;
output   [(2*WIDTH*HPE)-1:0]  Y_103;
output   [(2*WIDTH*HPE)-1:0]  Y_104;
output   [(2*WIDTH*HPE)-1:0]  Y_105;
output   [(2*WIDTH*HPE)-1:0]  Y_106;
output   [(2*WIDTH*HPE)-1:0]  Y_107;
output   [(2*WIDTH*HPE)-1:0]  Y_108;
output   [(2*WIDTH*HPE)-1:0]  Y_109;
output   [(2*WIDTH*HPE)-1:0]  Y_110;
output   [(2*WIDTH*HPE)-1:0]  Y_111;
output   [(2*WIDTH*HPE)-1:0]  Y_112;
output   [(2*WIDTH*HPE)-1:0]  Y_113;
output   [(2*WIDTH*HPE)-1:0]  Y_114;
output   [(2*WIDTH*HPE)-1:0]  Y_115;
output   [(2*WIDTH*HPE)-1:0]  Y_116;
output   [(2*WIDTH*HPE)-1:0]  Y_117;
output   [(2*WIDTH*HPE)-1:0]  Y_118;
output   [(2*WIDTH*HPE)-1:0]  Y_119;
output   [(2*WIDTH*HPE)-1:0]  Y_120;
output   [(2*WIDTH*HPE)-1:0]  Y_121;
output   [(2*WIDTH*HPE)-1:0]  Y_122;
output   [(2*WIDTH*HPE)-1:0]  Y_123;
output   [(2*WIDTH*HPE)-1:0]  Y_124;
output   [(2*WIDTH*HPE)-1:0]  Y_125;
output   [(2*WIDTH*HPE)-1:0]  Y_126;
output   [(2*WIDTH*HPE)-1:0]  Y_127;
output   [(2*WIDTH*HPE)-1:0]  Y_128;
output   [(2*WIDTH*HPE)-1:0]  Y_129;
output   [(2*WIDTH*HPE)-1:0]  Y_130;
output   [(2*WIDTH*HPE)-1:0]  Y_131;
output   [(2*WIDTH*HPE)-1:0]  Y_132;
output   [(2*WIDTH*HPE)-1:0]  Y_133;
output   [(2*WIDTH*HPE)-1:0]  Y_134;
output   [(2*WIDTH*HPE)-1:0]  Y_135;
output   [(2*WIDTH*HPE)-1:0]  Y_136;
output   [(2*WIDTH*HPE)-1:0]  Y_137;
output   [(2*WIDTH*HPE)-1:0]  Y_138;
output   [(2*WIDTH*HPE)-1:0]  Y_139;
output   [(2*WIDTH*HPE)-1:0]  Y_140;
output   [(2*WIDTH*HPE)-1:0]  Y_141;
output   [(2*WIDTH*HPE)-1:0]  Y_142;
output   [(2*WIDTH*HPE)-1:0]  Y_143;
output   [(2*WIDTH*HPE)-1:0]  Y_144;
output   [(2*WIDTH*HPE)-1:0]  Y_145;
output   [(2*WIDTH*HPE)-1:0]  Y_146;
output   [(2*WIDTH*HPE)-1:0]  Y_147;
output   [(2*WIDTH*HPE)-1:0]  Y_148;
output   [(2*WIDTH*HPE)-1:0]  Y_149;
output   [(2*WIDTH*HPE)-1:0]  Y_150;
output   [(2*WIDTH*HPE)-1:0]  Y_151;
output   [(2*WIDTH*HPE)-1:0]  Y_152;
output   [(2*WIDTH*HPE)-1:0]  Y_153;
output   [(2*WIDTH*HPE)-1:0]  Y_154;
output   [(2*WIDTH*HPE)-1:0]  Y_155;
output   [(2*WIDTH*HPE)-1:0]  Y_156;
output   [(2*WIDTH*HPE)-1:0]  Y_157;
output   [(2*WIDTH*HPE)-1:0]  Y_158;
output   [(2*WIDTH*HPE)-1:0]  Y_159;
output   [(2*WIDTH*HPE)-1:0]  Y_160;
output   [(2*WIDTH*HPE)-1:0]  Y_161;
output   [(2*WIDTH*HPE)-1:0]  Y_162;
output   [(2*WIDTH*HPE)-1:0]  Y_163;
output   [(2*WIDTH*HPE)-1:0]  Y_164;
output   [(2*WIDTH*HPE)-1:0]  Y_165;
output   [(2*WIDTH*HPE)-1:0]  Y_166;
output   [(2*WIDTH*HPE)-1:0]  Y_167;
output   [(2*WIDTH*HPE)-1:0]  Y_168;
output   [(2*WIDTH*HPE)-1:0]  Y_169;
output   [(2*WIDTH*HPE)-1:0]  Y_170;
output   [(2*WIDTH*HPE)-1:0]  Y_171;
output   [(2*WIDTH*HPE)-1:0]  Y_172;
output   [(2*WIDTH*HPE)-1:0]  Y_173;
output   [(2*WIDTH*HPE)-1:0]  Y_174;
output   [(2*WIDTH*HPE)-1:0]  Y_175;
output   [(2*WIDTH*HPE)-1:0]  Y_176;
output   [(2*WIDTH*HPE)-1:0]  Y_177;
output   [(2*WIDTH*HPE)-1:0]  Y_178;
output   [(2*WIDTH*HPE)-1:0]  Y_179;
output   [(2*WIDTH*HPE)-1:0]  Y_180;
output   [(2*WIDTH*HPE)-1:0]  Y_181;
output   [(2*WIDTH*HPE)-1:0]  Y_182;
output   [(2*WIDTH*HPE)-1:0]  Y_183;
output   [(2*WIDTH*HPE)-1:0]  Y_184;
output   [(2*WIDTH*HPE)-1:0]  Y_185;
output   [(2*WIDTH*HPE)-1:0]  Y_186;
output   [(2*WIDTH*HPE)-1:0]  Y_187;
output   [(2*WIDTH*HPE)-1:0]  Y_188;
output   [(2*WIDTH*HPE)-1:0]  Y_189;
output   [(2*WIDTH*HPE)-1:0]  Y_190;
output   [(2*WIDTH*HPE)-1:0]  Y_191;
output   [(2*WIDTH*HPE)-1:0]  Y_192;
output   [(2*WIDTH*HPE)-1:0]  Y_193;
output   [(2*WIDTH*HPE)-1:0]  Y_194;
output   [(2*WIDTH*HPE)-1:0]  Y_195;
output   [(2*WIDTH*HPE)-1:0]  Y_196;
output   [(2*WIDTH*HPE)-1:0]  Y_197;
output   [(2*WIDTH*HPE)-1:0]  Y_198;
output   [(2*WIDTH*HPE)-1:0]  Y_199;
output   [(2*WIDTH*HPE)-1:0]  Y_200;
output   [(2*WIDTH*HPE)-1:0]  Y_201;
output   [(2*WIDTH*HPE)-1:0]  Y_202;
output   [(2*WIDTH*HPE)-1:0]  Y_203;
output   [(2*WIDTH*HPE)-1:0]  Y_204;
output   [(2*WIDTH*HPE)-1:0]  Y_205;
output   [(2*WIDTH*HPE)-1:0]  Y_206;
output   [(2*WIDTH*HPE)-1:0]  Y_207;
output   [(2*WIDTH*HPE)-1:0]  Y_208;
output   [(2*WIDTH*HPE)-1:0]  Y_209;
output   [(2*WIDTH*HPE)-1:0]  Y_210;
output   [(2*WIDTH*HPE)-1:0]  Y_211;
output   [(2*WIDTH*HPE)-1:0]  Y_212;
output   [(2*WIDTH*HPE)-1:0]  Y_213;
output   [(2*WIDTH*HPE)-1:0]  Y_214;
output   [(2*WIDTH*HPE)-1:0]  Y_215;
output   [(2*WIDTH*HPE)-1:0]  Y_216;
output   [(2*WIDTH*HPE)-1:0]  Y_217;
output   [(2*WIDTH*HPE)-1:0]  Y_218;
output   [(2*WIDTH*HPE)-1:0]  Y_219;
output   [(2*WIDTH*HPE)-1:0]  Y_220;
output   [(2*WIDTH*HPE)-1:0]  Y_221;
output   [(2*WIDTH*HPE)-1:0]  Y_222;
output   [(2*WIDTH*HPE)-1:0]  Y_223;
output   [(2*WIDTH*HPE)-1:0]  Y_224;
output   [(2*WIDTH*HPE)-1:0]  Y_225;
output   [(2*WIDTH*HPE)-1:0]  Y_226;
output   [(2*WIDTH*HPE)-1:0]  Y_227;
output   [(2*WIDTH*HPE)-1:0]  Y_228;
output   [(2*WIDTH*HPE)-1:0]  Y_229;
output   [(2*WIDTH*HPE)-1:0]  Y_230;
output   [(2*WIDTH*HPE)-1:0]  Y_231;
output   [(2*WIDTH*HPE)-1:0]  Y_232;
output   [(2*WIDTH*HPE)-1:0]  Y_233;
output   [(2*WIDTH*HPE)-1:0]  Y_234;
output   [(2*WIDTH*HPE)-1:0]  Y_235;
output   [(2*WIDTH*HPE)-1:0]  Y_236;
output   [(2*WIDTH*HPE)-1:0]  Y_237;
output   [(2*WIDTH*HPE)-1:0]  Y_238;
output   [(2*WIDTH*HPE)-1:0]  Y_239;
output   [(2*WIDTH*HPE)-1:0]  Y_240;
output   [(2*WIDTH*HPE)-1:0]  Y_241;
output   [(2*WIDTH*HPE)-1:0]  Y_242;
output   [(2*WIDTH*HPE)-1:0]  Y_243;
output   [(2*WIDTH*HPE)-1:0]  Y_244;
output   [(2*WIDTH*HPE)-1:0]  Y_245;
output   [(2*WIDTH*HPE)-1:0]  Y_246;
output   [(2*WIDTH*HPE)-1:0]  Y_247;
output   [(2*WIDTH*HPE)-1:0]  Y_248;
output   [(2*WIDTH*HPE)-1:0]  Y_249;
output   [(2*WIDTH*HPE)-1:0]  Y_250;
output   [(2*WIDTH*HPE)-1:0]  Y_251;
output   [(2*WIDTH*HPE)-1:0]  Y_252;
output   [(2*WIDTH*HPE)-1:0]  Y_253;
output   [(2*WIDTH*HPE)-1:0]  Y_254;
output   [(2*WIDTH*HPE)-1:0]  Y_255;


wire [WIDTH-1:0] Ain[0:HPE-1];
wire [WIDTH-1:0] Bin[0:HPE-1];

genvar z;
  generate for (z = 0; z < HPE; z = z+1) begin:Input_weights 
      assign Ain[z] = AA[(((z+1)*WIDTH)-1) : ((z)*WIDTH)];
      assign Bin[z] = BB[(((z+1)*WIDTH)-1) : ((z)*WIDTH)];
end
endgenerate

wire [group_cnt - 1:0] S [0:VPE-1][0:HPE-1];
wire [group_cnt - 1:0] D [0:VPE-1][0:HPE-1];
wire [group_cnt - 1:0] T [0:VPE-1][0:HPE-1];
wire [group_cnt - 1:0] Q [0:VPE-1][0:HPE-1];
wire [group_cnt - 1:0] N [0:VPE-1][0:HPE-1];

wire [WIDTH-1:0] MY_OUT[0:VPE-1][0:HPE-1];

wire [WIDTH+1:0] TMY[0:VPE-1][0:HPE-1];

wire [WIDTH*2-1:0] Y_OUT[0:VPE-1][0:HPE-1];

genvar i,j;
generate
    for (j = 0; j < HPE; j = j + 1) begin: outputs
assign Y_0[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][0];
assign Y_1[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][1];
assign Y_2[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][2];
assign Y_3[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][3];
assign Y_4[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][4];
assign Y_5[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][5];
assign Y_6[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][6];
assign Y_7[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][7];
assign Y_8[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][8];
assign Y_9[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][9];
assign Y_10[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][10];
assign Y_11[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][11];
assign Y_12[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][12];
assign Y_13[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][13];
assign Y_14[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][14];
assign Y_15[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][15];
assign Y_16[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][16];
assign Y_17[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][17];
assign Y_18[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][18];
assign Y_19[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][19];
assign Y_20[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][20];
assign Y_21[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][21];
assign Y_22[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][22];
assign Y_23[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][23];
assign Y_24[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][24];
assign Y_25[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][25];
assign Y_26[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][26];
assign Y_27[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][27];
assign Y_28[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][28];
assign Y_29[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][29];
assign Y_30[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][30];
assign Y_31[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][31];
assign Y_32[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][32];
assign Y_33[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][33];
assign Y_34[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][34];
assign Y_35[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][35];
assign Y_36[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][36];
assign Y_37[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][37];
assign Y_38[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][38];
assign Y_39[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][39];
assign Y_40[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][40];
assign Y_41[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][41];
assign Y_42[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][42];
assign Y_43[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][43];
assign Y_44[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][44];
assign Y_45[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][45];
assign Y_46[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][46];
assign Y_47[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][47];
assign Y_48[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][48];
assign Y_49[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][49];
assign Y_50[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][50];
assign Y_51[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][51];
assign Y_52[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][52];
assign Y_53[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][53];
assign Y_54[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][54];
assign Y_55[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][55];
assign Y_56[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][56];
assign Y_57[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][57];
assign Y_58[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][58];
assign Y_59[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][59];
assign Y_60[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][60];
assign Y_61[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][61];
assign Y_62[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][62];
assign Y_63[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][63];
assign Y_64[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][64];
assign Y_65[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][65];
assign Y_66[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][66];
assign Y_67[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][67];
assign Y_68[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][68];
assign Y_69[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][69];
assign Y_70[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][70];
assign Y_71[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][71];
assign Y_72[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][72];
assign Y_73[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][73];
assign Y_74[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][74];
assign Y_75[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][75];
assign Y_76[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][76];
assign Y_77[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][77];
assign Y_78[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][78];
assign Y_79[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][79];
assign Y_80[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][80];
assign Y_81[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][81];
assign Y_82[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][82];
assign Y_83[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][83];
assign Y_84[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][84];
assign Y_85[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][85];
assign Y_86[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][86];
assign Y_87[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][87];
assign Y_88[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][88];
assign Y_89[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][89];
assign Y_90[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][90];
assign Y_91[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][91];
assign Y_92[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][92];
assign Y_93[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][93];
assign Y_94[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][94];
assign Y_95[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][95];
assign Y_96[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][96];
assign Y_97[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][97];
assign Y_98[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][98];
assign Y_99[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][99];
assign Y_100[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][100];
assign Y_101[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][101];
assign Y_102[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][102];
assign Y_103[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][103];
assign Y_104[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][104];
assign Y_105[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][105];
assign Y_106[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][106];
assign Y_107[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][107];
assign Y_108[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][108];
assign Y_109[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][109];
assign Y_110[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][110];
assign Y_111[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][111];
assign Y_112[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][112];
assign Y_113[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][113];
assign Y_114[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][114];
assign Y_115[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][115];
assign Y_116[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][116];
assign Y_117[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][117];
assign Y_118[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][118];
assign Y_119[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][119];
assign Y_120[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][120];
assign Y_121[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][121];
assign Y_122[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][122];
assign Y_123[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][123];
assign Y_124[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][124];
assign Y_125[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][125];
assign Y_126[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][126];
assign Y_127[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][127];
assign Y_128[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][128];
assign Y_129[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][129];
assign Y_130[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][130];
assign Y_131[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][131];
assign Y_132[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][132];
assign Y_133[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][133];
assign Y_134[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][134];
assign Y_135[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][135];
assign Y_136[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][136];
assign Y_137[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][137];
assign Y_138[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][138];
assign Y_139[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][139];
assign Y_140[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][140];
assign Y_141[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][141];
assign Y_142[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][142];
assign Y_143[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][143];
assign Y_144[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][144];
assign Y_145[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][145];
assign Y_146[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][146];
assign Y_147[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][147];
assign Y_148[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][148];
assign Y_149[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][149];
assign Y_150[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][150];
assign Y_151[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][151];
assign Y_152[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][152];
assign Y_153[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][153];
assign Y_154[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][154];
assign Y_155[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][155];
assign Y_156[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][156];
assign Y_157[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][157];
assign Y_158[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][158];
assign Y_159[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][159];
assign Y_160[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][160];
assign Y_161[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][161];
assign Y_162[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][162];
assign Y_163[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][163];
assign Y_164[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][164];
assign Y_165[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][165];
assign Y_166[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][166];
assign Y_167[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][167];
assign Y_168[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][168];
assign Y_169[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][169];
assign Y_170[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][170];
assign Y_171[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][171];
assign Y_172[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][172];
assign Y_173[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][173];
assign Y_174[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][174];
assign Y_175[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][175];
assign Y_176[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][176];
assign Y_177[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][177];
assign Y_178[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][178];
assign Y_179[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][179];
assign Y_180[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][180];
assign Y_181[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][181];
assign Y_182[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][182];
assign Y_183[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][183];
assign Y_184[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][184];
assign Y_185[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][185];
assign Y_186[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][186];
assign Y_187[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][187];
assign Y_188[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][188];
assign Y_189[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][189];
assign Y_190[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][190];
assign Y_191[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][191];
assign Y_192[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][192];
assign Y_193[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][193];
assign Y_194[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][194];
assign Y_195[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][195];
assign Y_196[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][196];
assign Y_197[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][197];
assign Y_198[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][198];
assign Y_199[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][199];
assign Y_200[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][200];
assign Y_201[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][201];
assign Y_202[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][202];
assign Y_203[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][203];
assign Y_204[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][204];
assign Y_205[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][205];
assign Y_206[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][206];
assign Y_207[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][207];
assign Y_208[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][208];
assign Y_209[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][209];
assign Y_210[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][210];
assign Y_211[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][211];
assign Y_212[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][212];
assign Y_213[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][213];
assign Y_214[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][214];
assign Y_215[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][215];
assign Y_216[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][216];
assign Y_217[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][217];
assign Y_218[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][218];
assign Y_219[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][219];
assign Y_220[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][220];
assign Y_221[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][221];
assign Y_222[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][222];
assign Y_223[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][223];
assign Y_224[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][224];
assign Y_225[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][225];
assign Y_226[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][226];
assign Y_227[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][227];
assign Y_228[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][228];
assign Y_229[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][229];
assign Y_230[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][230];
assign Y_231[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][231];
assign Y_232[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][232];
assign Y_233[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][233];
assign Y_234[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][234];
assign Y_235[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][235];
assign Y_236[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][236];
assign Y_237[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][237];
assign Y_238[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][238];
assign Y_239[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][239];
assign Y_240[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][240];
assign Y_241[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][241];
assign Y_242[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][242];
assign Y_243[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][243];
assign Y_244[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][244];
assign Y_245[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][245];
assign Y_246[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][246];
assign Y_247[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][247];
assign Y_248[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][248];
assign Y_249[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][249];
assign Y_250[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][250];
assign Y_251[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][251];
assign Y_252[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][252];
assign Y_253[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][253];
assign Y_254[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][254];
assign Y_255[(j+1)*(WIDTH*2)-1 : (j)*(WIDTH*2)]=Y_OUT[j][255];

end
endgenerate


wire [group_cnt - 1:0] s [0:HPE-1];
wire [group_cnt - 1:0] d [0:HPE-1];
wire [group_cnt - 1:0] t [0:HPE-1];
wire [group_cnt - 1:0] q [0:HPE-1];
wire [group_cnt - 1:0] n [0:HPE-1];

genvar l;
generate
	for (l = 0; l < HPE; l = l + 1) begin: pre_pro1

pre_process_be pre_pro_be(.mx(Ain[l]), .CLK(CLK), .sr(s[l]), .dr(d[l]), .tr(t[l]), .qr(q[l]), .nr(n[l]));

    end
endgenerate    


genvar k;
generate
	for (k = 0; k < HPE; k = k + 1) begin: pre_process
    pre_process_TMY prep00(.my(Bin[k]), .CLK(CLK), .RST(RST), .my_out(MY_OUT[k][0]), .TMY(TMY[k][0])); 	
    end
endgenerate        


generate
    for (j = 0; j < HPE-1; j = j + 1) begin: first_col_PEs 
    PE_OS_16_R8 PE00( .s(s[j]), .d(d[j]), .t(t[j]), .q(q[j]), .n(n[j]), .Y(MY_OUT[0][j]), .TMY(TMY[0][j]), .CLK(CLK), .RST(RST), .S_OUT(S[j][0]), .D_OUT(D[j][0]), .T_OUT(T[j][0]), .Q_OUT(Q[j][0]), .N_OUT(N[j][0]), .Y_OUT(MY_OUT[0][j+1]), .TMY_OUT(TMY[0][j+1]), .MAC_OUT(Y_OUT[j][0]));
    end
endgenerate   
PE_OS_16_R8 PE1111( .s(s[HPE-1]), .d(d[HPE-1]), .t(t[HPE-1]), .q(q[HPE-1]), .n(n[HPE-1]), .Y(MY_OUT[0][HPE-1]), .TMY(TMY[0][HPE-1]), .CLK(CLK), .RST(RST), .S_OUT(S[HPE-1][0]), .D_OUT(D[HPE-1][0]), .T_OUT(T[HPE-1][0]), .Q_OUT(Q[HPE-1][0]), .N_OUT(N[HPE-1][0]), .Y_OUT(), .TMY_OUT(), .MAC_OUT(Y_OUT[HPE-1][0]) );


generate
    for (j = 0; j < HPE-1; j = j + 1) begin: systolic_2D_PEs 
		for (i = 0; i < VPE-1; i = i + 1) begin : systolic_2D_PEsss 
		PE_OS_16_R8 PEyy( .s(S[i][j]), .d(D[i][j]), .t(T[i][j]), .q(Q[i][j]), .n(N[i][j]), .Y(MY_OUT[j+1][i]), .TMY(TMY[j+1][i]), .CLK(CLK), .RST(RST), .S_OUT(S[i][j+1]), .D_OUT(D[i][j+1]), .T_OUT(T[i][j+1]), .Q_OUT(Q[i][j+1]), .N_OUT(N[i][j+1]), .Y_OUT(MY_OUT[j+1][i+1]), .TMY_OUT(TMY[j+1][i+1]), .MAC_OUT(Y_OUT[i][j+1]) );
		end	
		PE_OS_16_R8 PEzz( .s(S[HPE-1][j]), .d(D[HPE-1][j]), .t(T[HPE-1][j]), .q(Q[HPE-1][j]), .n(N[HPE-1][j]), .Y(MY_OUT[j+1][HPE-1]), .TMY(TMY[j+1][HPE-1]), .CLK(CLK), .RST(RST), .S_OUT(S[HPE-1][j+1]), .D_OUT(D[HPE-1][j+1]), .T_OUT(T[HPE-1][j+1]), .Q_OUT(Q[HPE-1][j+1]), .N_OUT(N[HPE-1][j+1]), .Y_OUT(), .TMY_OUT(), .MAC_OUT(Y_OUT[HPE-1][j+1]) );
end
endgenerate

  
endmodule


module INVBLOCK ( GIN, PHI, GOUT );
input  GIN;
input  PHI;
output GOUT;
   assign GOUT =   GIN;
endmodule


module XXOR1 ( A, B, GIN, PHI, SUM );
input  A;
input  B;
input  GIN;
input  PHI;
output SUM;
   assign SUM = (  (A ^ B)) ^ GIN;
endmodule


module BLOCK0 ( A, B, PHI, POUT, GOUT );
input  A;
input  B;
input  PHI;
output POUT;
output GOUT;
   assign POUT =   (A | B);
   assign GOUT =   (A & B);
endmodule


module BLOCK1 ( PIN1, PIN2, GIN1, GIN2, PHI, POUT, GOUT );
input  PIN1;
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output POUT;
output GOUT;
   assign POUT =   (PIN1 & PIN2);
   assign GOUT =  (GIN2 | (PIN2 & GIN1));
endmodule


module BLOCK2 ( PIN1, PIN2, GIN1, GIN2, PHI, POUT, GOUT );
input  PIN1;
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output POUT;
output GOUT;
   assign POUT =   (PIN1 & PIN2);
   assign GOUT =   (GIN2 | (PIN2 & GIN1));
endmodule


module BLOCK1A ( PIN2, GIN1, GIN2, PHI, GOUT );
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output GOUT;
   assign GOUT = (GIN2 | (PIN2 & GIN1));
endmodule


module BLOCK2A ( PIN2, GIN1, GIN2, PHI, GOUT );
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output GOUT;
   assign GOUT =   (GIN2 | (PIN2 & GIN1));
endmodule


module pre_process_TMY #(parameter WIDTH = 32)(
input [WIDTH-1:0] my,
input CLK,
input RST,
output reg [WIDTH-1:0] my_out,
output reg [WIDTH+1:0] TMY);
`define TMY_W 34        // outputs width  
`define M_W 32        // width 
//wire [WIDTH:0] OPA;
//wire [WIDTH:0] OPB;
wire [WIDTH+1:0] SUM;
//wire CIN;
//wire PHI;
//assign CIN=1'b0;
//assign PHI=1'b0;

//assign OPA={my,1'b0}; 
//assign OPB={1'b0,my}; 
//assign SUM[0]=OPB[0];
assign SUM=my+(my<<1);

//DBLCADDER_16_16 D (.OPA(OPA[WIDTH:1]) , .OPB(OPB[WIDTH:1]) , .CIN (CIN) , .PHI (PHI) , .SUM(SUM[WIDTH:1]), .COUT(SUM[`M_W+1]) );

always @(posedge CLK) // or negedge RST )
begin
/*
if(RST==1'b0)
begin
         TMY<=`TMY_W'h0;
         my_out<=`M_W'h0;
end
else
begin
*/
         TMY<=SUM;
         my_out<=my;
//end
end

endmodule

module pre_process_be #(parameter WIDTH = 32)(mx, CLK, sr, dr, tr, qr, nr);
    
parameter group_cnt=(WIDTH>>2)+3; 

input [WIDTH-1:0] mx;
input CLK;
output reg [group_cnt - 1:0]sr;
output reg [group_cnt - 1:0]dr;
output reg [group_cnt - 1:0]tr;
output reg [group_cnt - 1:0]qr;
output reg [group_cnt - 1:0]nr;

wire [group_cnt - 1:0]s, d, t, q, n;


//Booth Encoding
   	    booth_encoder b_e0(.x({mx[2], mx[1], mx[0], 1'b0}), .single(s[0]), .double(d[0]), .triple(t[0]), .quad(q[0]), .neg(n[0]));
	    booth_encoder b_e1(.x({mx[5],mx[4], mx[3], mx[2]}), .single(s[1]), .double(d[1]), .triple(t[1]), .quad(q[1]), .neg(n[1]));
            booth_encoder b_e2(.x({mx[8],mx[7], mx[6], mx[5]}), .single(s[2]), .double(d[2]), .triple(t[2]), .quad(q[2]), .neg(n[2]));
            booth_encoder b_e3(.x({mx[11],mx[10], mx[9], mx[8]}), .single(s[3]), .double(d[3]), .triple(t[3]), .quad(q[3]), .neg(n[3]));
            booth_encoder b_e4(.x({mx[14],mx[13], mx[12], mx[11]}), .single(s[4]), .double(d[4]), .triple(t[4]), .quad(q[4]), .neg(n[4]));
	    booth_encoder b_e5(.x({mx[17],mx[16], mx[15], mx[14]}), .single(s[5]), .double(d[5]), .triple(t[5]), .quad(q[5]), .neg(n[5]));
            booth_encoder b_e6(.x({mx[20],mx[19], mx[18], mx[17]}), .single(s[6]), .double(d[6]), .triple(t[6]), .quad(q[6]), .neg(n[6]));
	    booth_encoder b_e7(.x({mx[23],mx[22], mx[21], mx[20]}), .single(s[7]), .double(d[7]), .triple(t[7]), .quad(q[7]), .neg(n[7]));
	    booth_encoder b_e8(.x({mx[26],mx[25], mx[24], mx[23]}), .single(s[8]), .double(d[8]), .triple(t[8]), .quad(q[8]), .neg(n[8]));
	    booth_encoder b_e9(.x({mx[29],mx[28], mx[27], mx[26]}), .single(s[9]), .double(d[9]), .triple(t[9]), .quad(q[9]), .neg(n[9]));
	    booth_encoder b_e10(.x({1'b0,mx[31], mx[30], mx[29]}), .single(s[10]), .double(d[10]), .triple(t[10]), .quad(q[10]), .neg(n[10]));
    
always@(posedge CLK)
begin
sr<=s;
dr<=d;
tr<=t;
qr<=q;
nr<=n;
end
endmodule

/******************** Booth Encoder ********************/
module booth_encoder (x, single, double, triple, quad, neg);

input [3:0]x;

output single;

output  double;

output triple;

output  quad;

output neg;

wire w0;

wire w1;

wire w2;

wire w3;

wire w4;

wire w5;

assign neg=x[3];

assign w0=x[0]^x[1];

assign w1=x[1]^x[2];

assign w2=x[2]^x[3];

assign single=~((~w0)|w2);

assign double=~((~w1)|w0);

assign triple=~((~w2)|(~w0));

assign quad=~((~w2)|(w0|w1));

endmodule

/******************** Booth Selector ********************/
//module booth_selector(y,ty,single,double,triple,quad,neg,p);
module booth_sel(y2, y1, y0, ty, single, double, triple, quad, neg, p);
input y2;
input y1;
input y0;
input ty;
input single;
input double;
input triple;
input quad;
input neg;
output p;

assign  p = (neg ^ ((y2 & single)|(ty & triple)| (y1 & double) | (y0 & quad)));
endmodule
/******************** 1bit Full Adder ********************/

module FULL_ADDER ( a, b, cin, sum, cout );

input  a;

input  b;

input  cin;

output sum;

output cout;

   wire TMP;

   assign TMP = a ^ b;

   assign sum = TMP ^ cin;

   assign cout =  ~ (( ~ (TMP & cin)) & ( ~ (a & b)));

endmodule
 
module HALF_ADDER ( a, b, sum, cout );

input  a;

input  b;

output sum;

output cout;

   assign sum = a ^ b;

   assign cout = a & b;

endmodule



