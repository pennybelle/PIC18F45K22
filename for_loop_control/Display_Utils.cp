#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/for_loop_control/Display_Utils.c"

unsigned short mask(unsigned short num) {
 switch (num) {
 case 0 : return 0x3F;
 case 1 : return 0x06;
 case 2 : return 0x5B;
 case 3 : return 0x4F;
 case 4 : return 0x66;
 case 5 : return 0x6D;
 case 6 : return 0x7D;
 case 7 : return 0x07;
 case 8 : return 0x7F;
 case 9 : return 0x6F;
 }
}
