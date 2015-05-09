
_interrupt:

;FirmV_0_7_0.c,204 :: 		void interrupt()
;FirmV_0_7_0.c,206 :: 		if(TMR0IF_bit)
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;FirmV_0_7_0.c,208 :: 		msCounter=msCounter+1;
	INCF        _msCounter+0, 1 
;FirmV_0_7_0.c,209 :: 		LCDBackLight=1;
	BSF         PORTA+0, 4 
;FirmV_0_7_0.c,210 :: 		Flag20ms=1;
	MOVLW       1
	MOVWF       _Flag20ms+0 
;FirmV_0_7_0.c,211 :: 		if(ms20A==255)
	MOVF        _ms20A+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;FirmV_0_7_0.c,212 :: 		{ms20A=0;RemotePulse1=0;}
	CLRF        _ms20A+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt2
L_interrupt1:
;FirmV_0_7_0.c,214 :: 		ms20A=ms20A+1;
	INCF        _ms20A+0, 1 
L_interrupt2:
;FirmV_0_7_0.c,216 :: 		if(ms20B==255)
	MOVF        _ms20B+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;FirmV_0_7_0.c,217 :: 		{ms20B=0;RemotePulse2=0;}
	CLRF        _ms20B+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt4
L_interrupt3:
;FirmV_0_7_0.c,219 :: 		ms20B=ms20B+1;
	INCF        _ms20B+0, 1 
L_interrupt4:
;FirmV_0_7_0.c,221 :: 		if(msCounter>=25)
	MOVLW       25
	SUBWF       _msCounter+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt5
;FirmV_0_7_0.c,223 :: 		msCounter=0;
	CLRF        _msCounter+0 
;FirmV_0_7_0.c,224 :: 		ms500=ms500+1;
	MOVLW       1
	ADDWF       _ms500+0, 1 
	MOVLW       0
	ADDWFC      _ms500+1, 1 
	ADDWFC      _ms500+2, 1 
	ADDWFC      _ms500+3, 1 
;FirmV_0_7_0.c,225 :: 		LCDFlashFlag=!LCDFlashFlag;
	MOVF        _LCDFlashFlag+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _LCDFlashFlag+0 
;FirmV_0_7_0.c,226 :: 		LCDBackLight=0;
	BCF         PORTA+0, 4 
;FirmV_0_7_0.c,227 :: 		Flag500ms=1;
	MOVLW       1
	MOVWF       _Flag500ms+0 
;FirmV_0_7_0.c,228 :: 		}
L_interrupt5:
;FirmV_0_7_0.c,229 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,230 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,231 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, 2 
;FirmV_0_7_0.c,232 :: 		}
L_interrupt0:
;FirmV_0_7_0.c,235 :: 		if(INT1F_bit)
	BTFSS       INT1F_bit+0, 0 
	GOTO        L_interrupt6
;FirmV_0_7_0.c,237 :: 		if(RemotePulse1==0)
	MOVF        _RemotePulse1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;FirmV_0_7_0.c,238 :: 		{ RemotePulse1=RemotePulse1+1;ms20A=0;}
	INCF        _RemotePulse1+0, 1 
	CLRF        _ms20A+0 
	GOTO        L_interrupt8
L_interrupt7:
;FirmV_0_7_0.c,240 :: 		{ RemotePulse1=RemotePulse1+1;}
	INCF        _RemotePulse1+0, 1 
L_interrupt8:
;FirmV_0_7_0.c,241 :: 		if(RemotePulse1>=5)
	MOVLW       5
	SUBWF       _RemotePulse1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt9
;FirmV_0_7_0.c,242 :: 		if((ms20A>=19)&&(ms20A<=21))
	MOVLW       19
	SUBWF       _ms20A+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
	MOVF        _ms20A+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
L__interrupt745:
;FirmV_0_7_0.c,243 :: 		{RemoteAFlag=1;RemotePulse1=0;}
	MOVLW       1
	MOVWF       _RemoteAFlag+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt13
L_interrupt12:
;FirmV_0_7_0.c,245 :: 		RemotePulse1=0;
	CLRF        _RemotePulse1+0 
L_interrupt13:
L_interrupt9:
;FirmV_0_7_0.c,246 :: 		INT1IF_bit=0;
	BCF         INT1IF_bit+0, 0 
;FirmV_0_7_0.c,247 :: 		}
L_interrupt6:
;FirmV_0_7_0.c,251 :: 		if(INT2IF_bit)
	BTFSS       INT2IF_bit+0, 1 
	GOTO        L_interrupt14
;FirmV_0_7_0.c,253 :: 		if(RemotePulse2==0)
	MOVF        _RemotePulse2+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt15
;FirmV_0_7_0.c,254 :: 		{ RemotePulse2=RemotePulse2+1;ms20B=0;}
	INCF        _RemotePulse2+0, 1 
	CLRF        _ms20B+0 
	GOTO        L_interrupt16
L_interrupt15:
;FirmV_0_7_0.c,256 :: 		{ RemotePulse2=RemotePulse2+1;}
	INCF        _RemotePulse2+0, 1 
L_interrupt16:
;FirmV_0_7_0.c,257 :: 		if(RemotePulse2>=5)
	MOVLW       5
	SUBWF       _RemotePulse2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt17
;FirmV_0_7_0.c,258 :: 		if((ms20B>=19)&&(ms20B<=21))
	MOVLW       19
	SUBWF       _ms20B+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
	MOVF        _ms20B+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
L__interrupt744:
;FirmV_0_7_0.c,259 :: 		{RemoteBFlag=1;RemotePulse2=0;}
	MOVLW       1
	MOVWF       _RemoteBFlag+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt21
L_interrupt20:
;FirmV_0_7_0.c,261 :: 		RemotePulse2=0;
	CLRF        _RemotePulse2+0 
L_interrupt21:
L_interrupt17:
;FirmV_0_7_0.c,262 :: 		INT2IF_bit=0;
	BCF         INT2IF_bit+0, 1 
;FirmV_0_7_0.c,263 :: 		}
L_interrupt14:
;FirmV_0_7_0.c,268 :: 		if(INT0F_bit==1)
	BTFSS       INT0F_bit+0, 1 
	GOTO        L_interrupt22
;FirmV_0_7_0.c,270 :: 		ZCCounter=ZCCounter+1;
	INCF        _ZCCounter+0, 1 
;FirmV_0_7_0.c,271 :: 		if(ZCCounter==255)
	MOVF        _ZCCounter+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt23
;FirmV_0_7_0.c,272 :: 		ZCCounter=2;
	MOVLW       2
	MOVWF       _ZCCounter+0 
L_interrupt23:
;FirmV_0_7_0.c,273 :: 		if(ZCCounter%3==1)
	MOVLW       3
	MOVWF       R4 
	MOVF        _ZCCounter+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt24
;FirmV_0_7_0.c,275 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt25
;FirmV_0_7_0.c,276 :: 		if(Motor1FullSpeed)
	MOVF        _Motor1FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt26
;FirmV_0_7_0.c,277 :: 		Motor1=1;
	BSF         PORTB+0, 3 
	GOTO        L_interrupt27
L_interrupt26:
;FirmV_0_7_0.c,279 :: 		Motor1=0;
	BCF         PORTB+0, 3 
L_interrupt27:
L_interrupt25:
;FirmV_0_7_0.c,281 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt28
;FirmV_0_7_0.c,282 :: 		if(Motor2FullSpeed)
	MOVF        _Motor2FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt29
;FirmV_0_7_0.c,283 :: 		Motor2=1;
	BSF         PORTB+0, 4 
	GOTO        L_interrupt30
L_interrupt29:
;FirmV_0_7_0.c,285 :: 		Motor2=0;
	BCF         PORTB+0, 4 
L_interrupt30:
L_interrupt28:
;FirmV_0_7_0.c,286 :: 		}
L_interrupt24:
;FirmV_0_7_0.c,287 :: 		if(ZCCounter%3==0)
	MOVLW       3
	MOVWF       R4 
	MOVF        _ZCCounter+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt31
;FirmV_0_7_0.c,289 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt32
;FirmV_0_7_0.c,290 :: 		Motor1=1;
	BSF         PORTB+0, 3 
L_interrupt32:
;FirmV_0_7_0.c,292 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt33
;FirmV_0_7_0.c,293 :: 		Motor2=1;
	BSF         PORTB+0, 4 
L_interrupt33:
;FirmV_0_7_0.c,294 :: 		}
L_interrupt31:
;FirmV_0_7_0.c,295 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, 1 
;FirmV_0_7_0.c,296 :: 		}
L_interrupt22:
;FirmV_0_7_0.c,297 :: 		}
L__interrupt860:
	RETFIE      1
; end of _interrupt

_ResetTaskEvents:

;FirmV_0_7_0.c,310 :: 		void ResetTaskEvents()
;FirmV_0_7_0.c,312 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,313 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,314 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,315 :: 		}
	RETURN      0
; end of _ResetTaskEvents

_Decrypt:

;FirmV_0_7_0.c,324 :: 		void Decrypt()
;FirmV_0_7_0.c,326 :: 		Sipher[0]=Crypto[1][0]+0x0D;
	MOVLW       13
	ADDWF       _crypto+16, 0 
	MOVWF       _Sipher+0 
;FirmV_0_7_0.c,327 :: 		Sipher[1]=Crypto[1][1]+0x0D;
	MOVLW       13
	ADDWF       _crypto+17, 0 
	MOVWF       _Sipher+1 
;FirmV_0_7_0.c,328 :: 		Sipher[2]=Crypto[1][2]+0x0D;
	MOVLW       13
	ADDWF       _crypto+18, 0 
	MOVWF       _Sipher+2 
;FirmV_0_7_0.c,329 :: 		Sipher[3]=Crypto[1][3]-0x26;
	MOVLW       38
	SUBWF       _crypto+19, 0 
	MOVWF       _Sipher+3 
;FirmV_0_7_0.c,330 :: 		Sipher[4]=Crypto[1][4]-0x3C;
	MOVLW       60
	SUBWF       _crypto+20, 0 
	MOVWF       _Sipher+4 
;FirmV_0_7_0.c,331 :: 		Sipher[5]=Crypto[1][5]-0x41;
	MOVLW       65
	SUBWF       _crypto+21, 0 
	MOVWF       _Sipher+5 
;FirmV_0_7_0.c,332 :: 		Sipher[6]=Crypto[1][6]-0x0C;
	MOVLW       12
	SUBWF       _crypto+22, 0 
	MOVWF       _Sipher+6 
;FirmV_0_7_0.c,333 :: 		Sipher[7]=Crypto[1][7]+0x34;
	MOVLW       52
	ADDWF       _crypto+23, 0 
	MOVWF       _Sipher+7 
;FirmV_0_7_0.c,334 :: 		Sipher[8]=Crypto[1][8]-0x01;
	DECF        _crypto+24, 0 
	MOVWF       _Sipher+8 
;FirmV_0_7_0.c,335 :: 		Sipher[9]=Crypto[1][9]-0x1F;
	MOVLW       31
	SUBWF       _crypto+25, 0 
	MOVWF       _Sipher+9 
;FirmV_0_7_0.c,336 :: 		Sipher[10]=Crypto[1][10]-0x3A;
	MOVLW       58
	SUBWF       _crypto+26, 0 
	MOVWF       _Sipher+10 
;FirmV_0_7_0.c,337 :: 		Sipher[11]=Crypto[1][11]-0x3B;
	MOVLW       59
	SUBWF       _crypto+27, 0 
	MOVWF       _Sipher+11 
;FirmV_0_7_0.c,338 :: 		Sipher[12]=Crypto[1][12]-0x3C;
	MOVLW       60
	SUBWF       _crypto+28, 0 
	MOVWF       _Sipher+12 
;FirmV_0_7_0.c,339 :: 		Sipher[13]=Crypto[1][13]+0x0D;
	MOVLW       13
	ADDWF       _crypto+29, 0 
	MOVWF       _Sipher+13 
;FirmV_0_7_0.c,340 :: 		Sipher[14]=Crypto[1][14]+0x0D;
	MOVLW       13
	ADDWF       _crypto+30, 0 
	MOVWF       _Sipher+14 
;FirmV_0_7_0.c,341 :: 		Sipher[15]=Crypto[1][15]+0x0D;
	MOVLW       13
	ADDWF       _crypto+31, 0 
	MOVWF       _Sipher+15 
;FirmV_0_7_0.c,342 :: 		}
	RETURN      0
; end of _Decrypt

_Logger:

;FirmV_0_7_0.c,354 :: 		void Logger(char* text, char TimeStampFlag)
;FirmV_0_7_0.c,357 :: 		if(TimeStampFlag)
	MOVF        FARG_Logger_TimeStampFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Logger34
;FirmV_0_7_0.c,359 :: 		longwordtostrwithzeros(ms500,time);
	MOVF        _ms500+0, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+0 
	MOVF        _ms500+1, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+1 
	MOVF        _ms500+2, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+2 
	MOVF        _ms500+3, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+3 
	MOVLW       Logger_time_L0+0
	MOVWF       FARG_LongWordToStrWithZeros_output+0 
	MOVLW       hi_addr(Logger_time_L0+0)
	MOVWF       FARG_LongWordToStrWithZeros_output+1 
	CALL        _LongWordToStrWithZeros+0, 0
;FirmV_0_7_0.c,360 :: 		uart_write_text(time);
	MOVLW       Logger_time_L0+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(Logger_time_L0+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;FirmV_0_7_0.c,361 :: 		uart1_write_text(": ");
	MOVLW       58
	MOVWF       ?lstr1_FirmV_0_7_0+0 
	MOVLW       32
	MOVWF       ?lstr1_FirmV_0_7_0+1 
	CLRF        ?lstr1_FirmV_0_7_0+2 
	MOVLW       ?lstr1_FirmV_0_7_0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_FirmV_0_7_0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;FirmV_0_7_0.c,362 :: 		}
L_Logger34:
;FirmV_0_7_0.c,363 :: 		uart1_write_text(text);
	MOVF        FARG_Logger_text+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_Logger_text+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;FirmV_0_7_0.c,364 :: 		uart1_write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,365 :: 		uart1_write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,366 :: 		}
	RETURN      0
; end of _Logger

_main:

;FirmV_0_7_0.c,383 :: 		void main() {
;FirmV_0_7_0.c,386 :: 		PhotocellRel=1;
	BSF         PORTC+0, 5 
;FirmV_0_7_0.c,388 :: 		Init();
	CALL        _Init+0, 0
;FirmV_0_7_0.c,390 :: 		Decrypt();
	CALL        _Decrypt+0, 0
;FirmV_0_7_0.c,392 :: 		Buzzer=1;
	BSF         PORTB+0, 5 
;FirmV_0_7_0.c,393 :: 		Logger("Start ...",1);
	MOVLW       83
	MOVWF       ?lstr2_FirmV_0_7_0+0 
	MOVLW       116
	MOVWF       ?lstr2_FirmV_0_7_0+1 
	MOVLW       97
	MOVWF       ?lstr2_FirmV_0_7_0+2 
	MOVLW       114
	MOVWF       ?lstr2_FirmV_0_7_0+3 
	MOVLW       116
	MOVWF       ?lstr2_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr2_FirmV_0_7_0+5 
	MOVLW       46
	MOVWF       ?lstr2_FirmV_0_7_0+6 
	MOVLW       46
	MOVWF       ?lstr2_FirmV_0_7_0+7 
	MOVLW       46
	MOVWF       ?lstr2_FirmV_0_7_0+8 
	CLRF        ?lstr2_FirmV_0_7_0+9 
	MOVLW       ?lstr2_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr2_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,394 :: 		memcpy(LCDLine1,Sipher,16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       _Sipher+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(_Sipher+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,395 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,396 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,397 :: 		Buzzer=0;
	BCF         PORTB+0, 5 
;FirmV_0_7_0.c,399 :: 		while(1)
L_main35:
;FirmV_0_7_0.c,401 :: 		if(Flag20ms==1)
	MOVF        _Flag20ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main37
;FirmV_0_7_0.c,403 :: 		if((Buzzer==1)&&(BuzzCounter<100))
	BTFSS       PORTB+0, 5 
	GOTO        L_main40
	MOVLW       100
	SUBWF       _BuzzCounter+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main40
L__main751:
;FirmV_0_7_0.c,404 :: 		{BuzzCounter=BuzzCounter+1;}
	INCF        _BuzzCounter+0, 1 
L_main40:
;FirmV_0_7_0.c,406 :: 		if((Buzzer==1)&&(LongBuzzFlag))
	BTFSS       PORTB+0, 5 
	GOTO        L_main43
	MOVF        _LongBuzzFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main43
L__main750:
;FirmV_0_7_0.c,407 :: 		if(BuzzCounter>=25){BuzzFlag=0;LongBuzzFlag=0;Buzzer=0;}
	MOVLW       25
	SUBWF       _BuzzCounter+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main44
	CLRF        _BuzzFlag+0 
	CLRF        _LongBuzzFlag+0 
	BCF         PORTB+0, 5 
L_main44:
L_main43:
;FirmV_0_7_0.c,409 :: 		if((Buzzer==1)&&(BuzzFlag)&&(!LongBuzzFlag))
	BTFSS       PORTB+0, 5 
	GOTO        L_main47
	MOVF        _BuzzFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main47
	MOVF        _LongBuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main47
L__main749:
;FirmV_0_7_0.c,410 :: 		{BuzzFlag=0;LongBuzzFlag=0;Buzzer=0;}
	CLRF        _BuzzFlag+0 
	CLRF        _LongBuzzFlag+0 
	BCF         PORTB+0, 5 
L_main47:
;FirmV_0_7_0.c,412 :: 		if(((BuzzFlag)||(LongBuzzFlag))&&(!Buzzer))
	MOVF        _BuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main748
	MOVF        _LongBuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main748
	GOTO        L_main52
L__main748:
	BTFSC       PORTB+0, 5 
	GOTO        L_main52
L__main747:
;FirmV_0_7_0.c,413 :: 		{Buzzer=1;BuzzCounter=0;}
	BSF         PORTB+0, 5 
	CLRF        _BuzzCounter+0 
L_main52:
;FirmV_0_7_0.c,416 :: 		if(DebouncingDelay<DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelay+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main53
;FirmV_0_7_0.c,417 :: 		DebouncingDelay=DebouncingDelay+1;
	INCF        _DebouncingDelay+0, 1 
L_main53:
;FirmV_0_7_0.c,418 :: 		LCDUpdater();
	CALL        _LCDUpdater+0, 0
;FirmV_0_7_0.c,419 :: 		if(KeyFlag<200)
	MOVLW       200
	SUBWF       _KeyFlag+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main54
;FirmV_0_7_0.c,420 :: 		KeyFlag=KeyFlag+1;
	INCF        _KeyFlag+0, 1 
L_main54:
;FirmV_0_7_0.c,421 :: 		Flag20ms=0;
	CLRF        _Flag20ms+0 
;FirmV_0_7_0.c,422 :: 		}
L_main37:
;FirmV_0_7_0.c,424 :: 		if(Flag500ms==1)
	MOVF        _Flag500ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main55
;FirmV_0_7_0.c,426 :: 		if(FlashFlag)
	MOVF        _FlashFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main56
;FirmV_0_7_0.c,427 :: 		Buzzer=!Buzzer;
	BTG         PORTB+0, 5 
	GOTO        L_main57
L_main56:
;FirmV_0_7_0.c,429 :: 		if((!BuzzFlag)&&(!LongBuzzFlag))Buzzer=0;
	MOVF        _BuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main60
	MOVF        _LongBuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main60
L__main746:
	BCF         PORTB+0, 5 
L_main60:
L_main57:
;FirmV_0_7_0.c,430 :: 		ResetTaskEvents();
	CALL        _ResetTaskEvents+0, 0
;FirmV_0_7_0.c,431 :: 		TaskManager();
	CALL        _TaskManager+0, 0
;FirmV_0_7_0.c,432 :: 		TorqueLogger();
	CALL        _TorqueLogger+0, 0
;FirmV_0_7_0.c,433 :: 		Flag500ms=0;
	CLRF        _Flag500ms+0 
;FirmV_0_7_0.c,434 :: 		}
L_main55:
;FirmV_0_7_0.c,435 :: 		EventHandler();
	CALL        _EventHandler+0, 0
;FirmV_0_7_0.c,436 :: 		StateManager();
	CALL        _StateManager+0, 0
;FirmV_0_7_0.c,437 :: 		}
	GOTO        L_main35
;FirmV_0_7_0.c,439 :: 		}
	GOTO        $+0
; end of _main

_StateManager:

;FirmV_0_7_0.c,464 :: 		void StateManager()
;FirmV_0_7_0.c,467 :: 		switch(State)
	GOTO        L_StateManager61
;FirmV_0_7_0.c,470 :: 		case 0: State1(); break;
L_StateManager63:
	CALL        _State1+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,472 :: 		case 1: State1(); break;
L_StateManager64:
	CALL        _State1+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,474 :: 		case 2: State2(); break;
L_StateManager65:
	CALL        _State2+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,476 :: 		case 3: State3(); break;
L_StateManager66:
	CALL        _State3+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,478 :: 		case 4: State4(); break;
L_StateManager67:
	CALL        _State4+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,480 :: 		case 5: State5(); break;
L_StateManager68:
	CALL        _State5+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,482 :: 		case 6: State6(); break;
L_StateManager69:
	CALL        _State6+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,484 :: 		case 7: State7(); break;
L_StateManager70:
	CALL        _State7+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,486 :: 		case 8: State8(); break;
L_StateManager71:
	CALL        _State8+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,488 :: 		case 10:State00(); break;
L_StateManager72:
	CALL        _State00+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,490 :: 		case 100:Menu0(); break;
L_StateManager73:
	CALL        _Menu0+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,492 :: 		case 101:Menu1(); break;
L_StateManager74:
	CALL        _Menu1+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,494 :: 		case 102:Menu2(); break;
L_StateManager75:
	CALL        _Menu2+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,496 :: 		case 103:Menu3(); break;
L_StateManager76:
	CALL        _Menu3+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,498 :: 		case 200:LearnAuto(); break;
L_StateManager77:
	CALL        _LearnAuto+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,500 :: 		case 201:LearnManual(); break;
L_StateManager78:
	CALL        _LearnManual+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,502 :: 		case 250:About(); break;
L_StateManager79:
	CALL        _About+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,504 :: 		}
L_StateManager61:
	MOVF        _State+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager63
	MOVF        _State+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager64
	MOVF        _State+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager65
	MOVF        _State+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager66
	MOVF        _State+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager67
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager68
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager69
	MOVF        _State+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager70
	MOVF        _State+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager71
	MOVF        _State+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager72
	MOVF        _State+0, 0 
	XORLW       100
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager73
	MOVF        _State+0, 0 
	XORLW       101
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager74
	MOVF        _State+0, 0 
	XORLW       102
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager75
	MOVF        _State+0, 0 
	XORLW       103
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager76
	MOVF        _State+0, 0 
	XORLW       200
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager77
	MOVF        _State+0, 0 
	XORLW       201
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager78
	MOVF        _State+0, 0 
	XORLW       250
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager79
L_StateManager62:
;FirmV_0_7_0.c,505 :: 		}
	RETURN      0
; end of _StateManager

_StateTest:

;FirmV_0_7_0.c,509 :: 		void StateTest()
;FirmV_0_7_0.c,511 :: 		if (Events.Photocell==1)
	MOVF        _Events+6, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StateTest80
;FirmV_0_7_0.c,512 :: 		LCDLine1[0]='1';
	MOVLW       49
	MOVWF       _LCDLine1+0 
	GOTO        L_StateTest81
L_StateTest80:
;FirmV_0_7_0.c,514 :: 		LCDLine1[0]='0';
	MOVLW       48
	MOVWF       _LCDLine1+0 
L_StateTest81:
;FirmV_0_7_0.c,516 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,518 :: 		}
	RETURN      0
; end of _StateTest

_State00:

;FirmV_0_7_0.c,522 :: 		void State00()
;FirmV_0_7_0.c,527 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,528 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,529 :: 		StartMotor(1,_Close);
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,530 :: 		StartMotor(2,_Close);
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,532 :: 		if(Events.Remote.b0==1)
	BTFSS       _Events+4, 0 
	GOTO        L_State0082
;FirmV_0_7_0.c,533 :: 		{Flasher=0;FlashFlag=0;StopMotor(1);StopMotor(2);
	BCF         PORTD+0, 7 
	CLRF        _FlashFlag+0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,534 :: 		State=1;                }
	MOVLW       1
	MOVWF       _State+0 
L_State0082:
;FirmV_0_7_0.c,535 :: 		}
	RETURN      0
; end of _State00

_State1:

;FirmV_0_7_0.c,544 :: 		void State1()
;FirmV_0_7_0.c,546 :: 		char delay=3;
	MOVLW       3
	MOVWF       State1_delay_L0+0 
;FirmV_0_7_0.c,547 :: 		unsigned long AutoCloseTemp=0;
	CLRF        State1_AutoCloseTemp_L0+0 
	CLRF        State1_AutoCloseTemp_L0+1 
	CLRF        State1_AutoCloseTemp_L0+2 
	CLRF        State1_AutoCloseTemp_L0+3 
;FirmV_0_7_0.c,548 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,549 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,551 :: 		if(Events.Keys==2)
	MOVF        _Events+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State183
;FirmV_0_7_0.c,552 :: 		{State=100;MenuPointer=0;}
	MOVLW       100
	MOVWF       _State+0 
	CLRF        _MenuPointer+0 
L_State183:
;FirmV_0_7_0.c,554 :: 		ActiveDoors=3-Events.Remote;
	MOVF        _Events+4, 0 
	SUBLW       3
	MOVWF       _ActiveDoors+0 
;FirmV_0_7_0.c,558 :: 		if(Events.Remote!=0)
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State184
;FirmV_0_7_0.c,561 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,562 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,563 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,564 :: 		if(Lockenable)
	MOVF        _LockEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State185
;FirmV_0_7_0.c,565 :: 		AddTask(ms500+1,12);
	MOVLW       1
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       12
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State185:
;FirmV_0_7_0.c,566 :: 		temp=ms500+delay;
	MOVF        State1_delay_L0+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,567 :: 		AddTask(temp,1);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       1
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,568 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State186
;FirmV_0_7_0.c,569 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       7
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
	GOTO        L_State187
L_State186:
;FirmV_0_7_0.c,571 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _M1isSlow+0 
L_State187:
;FirmV_0_7_0.c,572 :: 		temp=ms500+OpenSoftStartTime+OverloadDelay+delay;
	MOVF        _OpenSoftStartTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVLW       6
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,573 :: 		AddTask(temp,10); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       10
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,574 :: 		temp=ms500+OpenSoftStartTime+delay;
	MOVF        _OpenSoftStartTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,575 :: 		AddTask(temp,5);//Speed up after soft start
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,576 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State188
;FirmV_0_7_0.c,577 :: 		{temp=ms500+Door1OpenTime-OpenSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
	MOVF        _Door1OpenTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _OpenSoftStopTime+0, 0 
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       7
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State188:
;FirmV_0_7_0.c,578 :: 		temp=ms500+Door1OpenTime+delay;
	MOVF        _Door1OpenTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,579 :: 		AddTask(temp,3);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,580 :: 		AutoCloseTemp=ms500+Door1OpenTime+delay;
	MOVF        _Door1OpenTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       State1_AutoCloseTemp_L0+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       State1_AutoCloseTemp_L0+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       State1_AutoCloseTemp_L0+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       State1_AutoCloseTemp_L0+3 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       State1_AutoCloseTemp_L0+0, 1 
	MOVLW       0
	ADDWFC      State1_AutoCloseTemp_L0+1, 1 
	ADDWFC      State1_AutoCloseTemp_L0+2, 1 
	ADDWFC      State1_AutoCloseTemp_L0+3, 1 
;FirmV_0_7_0.c,582 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State191
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State191
L__State1752:
;FirmV_0_7_0.c,584 :: 		temp=ms500+ActionTimeDiff+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,585 :: 		AddTask(temp,2);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       2
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,586 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State192
;FirmV_0_7_0.c,587 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,8); M2isSlow=1;}//speed down
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       8
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	GOTO        L_State193
L_State192:
;FirmV_0_7_0.c,589 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,6); M2isSlow=0;}//speed up
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       6
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _M2isSlow+0 
L_State193:
;FirmV_0_7_0.c,590 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+OverloadDelay+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _OpenSoftStartTime+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVLW       6
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,591 :: 		AddTask(temp,11); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       11
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,592 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _OpenSoftStartTime+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,593 :: 		AddTask(temp,6);//Speed up after soft start
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       6
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,594 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State194
;FirmV_0_7_0.c,595 :: 		{temp=ms500+ActionTimeDiff+Door2OpenTime-OpenSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _Door2OpenTime+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        _OpenSoftStopTime+0, 0 
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       8
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State194:
;FirmV_0_7_0.c,596 :: 		temp=ms500+Door2OpenTime+ActionTimeDiff+delay;
	MOVF        _Door2OpenTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,597 :: 		AddTask(temp,4);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       4
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,598 :: 		AutoCloseTemp=ms500+Door2OpenTime+ActionTimeDiff+delay;
	MOVF        _Door2OpenTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       State1_AutoCloseTemp_L0+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       State1_AutoCloseTemp_L0+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       State1_AutoCloseTemp_L0+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       State1_AutoCloseTemp_L0+3 
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       State1_AutoCloseTemp_L0+0, 1 
	MOVLW       0
	ADDWFC      State1_AutoCloseTemp_L0+1, 1 
	ADDWFC      State1_AutoCloseTemp_L0+2, 1 
	ADDWFC      State1_AutoCloseTemp_L0+3, 1 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       State1_AutoCloseTemp_L0+0, 1 
	MOVLW       0
	ADDWFC      State1_AutoCloseTemp_L0+1, 1 
	ADDWFC      State1_AutoCloseTemp_L0+2, 1 
	ADDWFC      State1_AutoCloseTemp_L0+3, 1 
;FirmV_0_7_0.c,599 :: 		}
L_State191:
;FirmV_0_7_0.c,601 :: 		if(AutoCloseTime!=0)
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State1861
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State1861:
	BTFSC       STATUS+0, 2 
	GOTO        L_State195
;FirmV_0_7_0.c,602 :: 		{temp=AutoCloseTemp+AutoCloseTime;AddTask(temp,9);}
	MOVF        _AutoCloseTime+0, 0 
	ADDWF       State1_AutoCloseTemp_L0+0, 0 
	MOVWF       R0 
	MOVF        _AutoCloseTime+1, 0 
	ADDWFC      State1_AutoCloseTemp_L0+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      State1_AutoCloseTemp_L0+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      State1_AutoCloseTemp_L0+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State195:
;FirmV_0_7_0.c,604 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,605 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,606 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,607 :: 		State=3;
	MOVLW       3
	MOVWF       _State+0 
;FirmV_0_7_0.c,608 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,609 :: 		}
L_State184:
;FirmV_0_7_0.c,610 :: 		}
	RETURN      0
; end of _State1

_State2:

;FirmV_0_7_0.c,624 :: 		void State2()
;FirmV_0_7_0.c,626 :: 		char delay=2,PrevAC=0;
	MOVLW       2
	MOVWF       State2_delay_L0+0 
	CLRF        State2_PrevAC_L0+0 
;FirmV_0_7_0.c,628 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,629 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,632 :: 		if(ReturnAutoclose()!=PrevAC)
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	XORWF       State2_PrevAC_L0+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_State296
;FirmV_0_7_0.c,634 :: 		LCDFlashFlag=0;
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,635 :: 		PrevAC=ReturnAutoclose();
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	MOVWF       State2_PrevAC_L0+0 
;FirmV_0_7_0.c,636 :: 		charValueToStr_AC(PrevAC,LCDLine2+11);
	MOVF        R0, 0 
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       _LCDLine2+11
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       hi_addr(_LCDLine2+11)
	MOVWF       FARG_charValueToStr_AC+1 
	CALL        _charValueToStr_AC+0, 0
;FirmV_0_7_0.c,637 :: 		memcpy(LCDLine2,"Close after",11);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       67
	MOVWF       ?lstr3_FirmV_0_7_0+0 
	MOVLW       108
	MOVWF       ?lstr3_FirmV_0_7_0+1 
	MOVLW       111
	MOVWF       ?lstr3_FirmV_0_7_0+2 
	MOVLW       115
	MOVWF       ?lstr3_FirmV_0_7_0+3 
	MOVLW       101
	MOVWF       ?lstr3_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr3_FirmV_0_7_0+5 
	MOVLW       97
	MOVWF       ?lstr3_FirmV_0_7_0+6 
	MOVLW       102
	MOVWF       ?lstr3_FirmV_0_7_0+7 
	MOVLW       116
	MOVWF       ?lstr3_FirmV_0_7_0+8 
	MOVLW       101
	MOVWF       ?lstr3_FirmV_0_7_0+9 
	MOVLW       114
	MOVWF       ?lstr3_FirmV_0_7_0+10 
	CLRF        ?lstr3_FirmV_0_7_0+11 
	MOVLW       ?lstr3_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr3_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       11
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,638 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,639 :: 		}
L_State296:
;FirmV_0_7_0.c,642 :: 		if((Events.Remote!=0)||(CheckTask(9)))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State2757
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2757
	GOTO        L_State299
L__State2757:
;FirmV_0_7_0.c,645 :: 		ClearTasks(0);
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,646 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State2756
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State2756
	GOTO        L_State2102
L__State2756:
;FirmV_0_7_0.c,648 :: 		temp=ms500+delay;
	MOVF        State2_delay_L0+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,649 :: 		AddTask(temp,1);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       1
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,650 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2103
;FirmV_0_7_0.c,651 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       7
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
	GOTO        L_State2104
L_State2103:
;FirmV_0_7_0.c,653 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _M1isSlow+0 
L_State2104:
;FirmV_0_7_0.c,654 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
	MOVF        _CloseSoftStartTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVLW       6
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,655 :: 		AddTask(temp,10); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       10
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,656 :: 		temp=ms500+CloseSoftStartTime+delay;
	MOVF        _CloseSoftStartTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,657 :: 		AddTask(temp,5);//Speed up after soft start
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,658 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2105
;FirmV_0_7_0.c,659 :: 		{temp=ms500+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _CloseSoftStopTime+0, 0 
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       7
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State2105:
;FirmV_0_7_0.c,660 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2106
;FirmV_0_7_0.c,661 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       2
	ADDWF       _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	GOTO        L_State2107
L_State2106:
;FirmV_0_7_0.c,663 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,3);}
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State2107:
;FirmV_0_7_0.c,665 :: 		}
L_State2102:
;FirmV_0_7_0.c,667 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2110
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State2110
L__State2755:
;FirmV_0_7_0.c,669 :: 		temp=ms500+delay;
	MOVF        State2_delay_L0+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,670 :: 		AddTask(temp,2);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       2
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,671 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2111
;FirmV_0_7_0.c,672 :: 		{AddTask(temp,8); M2isSlow=1;}//speed down
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       8
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	GOTO        L_State2112
L_State2111:
;FirmV_0_7_0.c,674 :: 		{AddTask(temp,6); M2isSlow=0;}//speed up
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       6
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _M2isSlow+0 
L_State2112:
;FirmV_0_7_0.c,675 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
	MOVF        _CloseSoftStartTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVLW       6
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,676 :: 		AddTask(temp,11); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       11
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,677 :: 		temp=ms500+CloseSoftStartTime+delay;
	MOVF        _CloseSoftStartTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,678 :: 		AddTask(temp,6);//Speed up after soft start
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       6
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,679 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2113
;FirmV_0_7_0.c,680 :: 		{temp=ms500+Door2CloseTime-CloseSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
	MOVF        _Door2CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _CloseSoftStopTime+0, 0 
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       8
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State2113:
;FirmV_0_7_0.c,682 :: 		temp=ms500+Door2CloseTime+delay;
	MOVF        _Door2CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,683 :: 		AddTask(temp,4);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       4
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,687 :: 		temp=ms500+ActionTimeDiff+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,688 :: 		AddTask(temp,1);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       1
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,689 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2114
;FirmV_0_7_0.c,690 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       7
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
	GOTO        L_State2115
L_State2114:
;FirmV_0_7_0.c,692 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _M1isSlow+0 
L_State2115:
;FirmV_0_7_0.c,693 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+OverloadDelay+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _CloseSoftStartTime+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVLW       6
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,694 :: 		AddTask(temp,10); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       10
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,695 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _CloseSoftStartTime+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,696 :: 		AddTask(temp,5);//Speed up after soft start
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,697 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2116
;FirmV_0_7_0.c,698 :: 		{temp=ms500+ActionTimeDiff+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        _CloseSoftStopTime+0, 0 
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       7
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State2116:
;FirmV_0_7_0.c,699 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2117
;FirmV_0_7_0.c,700 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       2
	ADDWF       _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	GOTO        L_State2118
L_State2117:
;FirmV_0_7_0.c,702 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,3);}
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State2118:
;FirmV_0_7_0.c,704 :: 		}
L_State2110:
;FirmV_0_7_0.c,707 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,708 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,709 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,710 :: 		State=4;
	MOVLW       4
	MOVWF       _State+0 
;FirmV_0_7_0.c,711 :: 		}
L_State299:
;FirmV_0_7_0.c,713 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State2121
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2862
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State2862:
	BTFSC       STATUS+0, 2 
	GOTO        L_State2121
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State2121
L__State2754:
;FirmV_0_7_0.c,714 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S2 Auto Close Deleted",1);}
	MOVLW       1
	MOVWF       _PassFlag+0 
	CALL        _GetAutocloseTime+0, 0
	MOVF        R0, 0 
	MOVWF       __AC+0 
	MOVLW       ?ICS?lstr4_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr4_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr4_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr4_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr4_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr4_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr4_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State2121:
;FirmV_0_7_0.c,716 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State2124
	BTFSC       _Events+6, 0 
	GOTO        L_State2124
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2863
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State2863:
	BTFSC       STATUS+0, 2 
	GOTO        L_State2124
L__State2753:
;FirmV_0_7_0.c,717 :: 		if(CloseAfterPass==0)
	MOVF        _CloseAfterPass+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State2125
;FirmV_0_7_0.c,718 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:",1);Logger(t,1);}
	MOVF        __AC+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _PassFlag+0 
	MOVF        _temp+0, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+3 
	MOVLW       _t+0
	MOVWF       FARG_LongWordToStrWithZeros_output+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_LongWordToStrWithZeros_output+1 
	CALL        _LongWordToStrWithZeros+0, 0
	MOVLW       ?ICS?lstr5_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr5_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr5_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr5_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr5_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       16
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr5_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr5_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       _t+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	GOTO        L_State2126
L_State2125:
;FirmV_0_7_0.c,720 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:",1);Logger(t,1);}
	MOVF        _CloseAfterPass+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _PassFlag+0 
	MOVF        _temp+0, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+3 
	MOVLW       _t+0
	MOVWF       FARG_LongWordToStrWithZeros_output+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_LongWordToStrWithZeros_output+1 
	CALL        _LongWordToStrWithZeros+0, 0
	MOVLW       ?ICS?lstr6_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr6_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr6_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr6_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr6_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       16
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr6_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr6_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       _t+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State2126:
L_State2124:
;FirmV_0_7_0.c,722 :: 		}
	RETURN      0
; end of _State2

_State3:

;FirmV_0_7_0.c,737 :: 		void State3()
;FirmV_0_7_0.c,739 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,740 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,742 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3127
;FirmV_0_7_0.c,743 :: 		{StartMotor(1,_Open);Logger("S3 Motor1Start",1); Lock=0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr7_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr7_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr7_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr7_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr7_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr7_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr7_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr7_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr7_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr7_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr7_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr7_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr7_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr7_FirmV_0_7_0+13 
	CLRF        ?lstr7_FirmV_0_7_0+14 
	MOVLW       ?lstr7_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr7_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	BCF         PORTD+0, 6 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __opening+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__opening+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State3127:
;FirmV_0_7_0.c,745 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3128
;FirmV_0_7_0.c,746 :: 		{StartMotor(2,_Open);Logger("S3 Motor2Start",1); Lock=0;}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr8_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr8_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr8_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr8_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr8_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr8_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr8_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr8_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr8_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr8_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr8_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr8_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr8_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr8_FirmV_0_7_0+13 
	CLRF        ?lstr8_FirmV_0_7_0+14 
	MOVLW       ?lstr8_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr8_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	BCF         PORTD+0, 6 
L_State3128:
;FirmV_0_7_0.c,748 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3129
;FirmV_0_7_0.c,749 :: 		{SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;Logger("S3 Motor1 Fast",1);}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _M1isSlow+0 
	MOVLW       83
	MOVWF       ?lstr9_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr9_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr9_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr9_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr9_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr9_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr9_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr9_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr9_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr9_FirmV_0_7_0+9 
	MOVLW       70
	MOVWF       ?lstr9_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr9_FirmV_0_7_0+11 
	MOVLW       115
	MOVWF       ?lstr9_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr9_FirmV_0_7_0+13 
	CLRF        ?lstr9_FirmV_0_7_0+14 
	MOVLW       ?lstr9_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr9_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3129:
;FirmV_0_7_0.c,751 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3130
;FirmV_0_7_0.c,752 :: 		{SetMotorSpeed(0,Motor2FullSpeed); M1isSlow=1;Logger("S3 Motor1 Slow",1);}
	CLRF        FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
	MOVLW       83
	MOVWF       ?lstr10_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr10_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr10_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr10_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr10_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr10_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr10_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr10_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr10_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr10_FirmV_0_7_0+9 
	MOVLW       83
	MOVWF       ?lstr10_FirmV_0_7_0+10 
	MOVLW       108
	MOVWF       ?lstr10_FirmV_0_7_0+11 
	MOVLW       111
	MOVWF       ?lstr10_FirmV_0_7_0+12 
	MOVLW       119
	MOVWF       ?lstr10_FirmV_0_7_0+13 
	CLRF        ?lstr10_FirmV_0_7_0+14 
	MOVLW       ?lstr10_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr10_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3130:
;FirmV_0_7_0.c,754 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3131
;FirmV_0_7_0.c,755 :: 		{SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;Logger("S3 Motor2 Fast",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag2+0 
	CLRF        _M2isSlow+0 
	MOVLW       83
	MOVWF       ?lstr11_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr11_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr11_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr11_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr11_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr11_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr11_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr11_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr11_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr11_FirmV_0_7_0+9 
	MOVLW       70
	MOVWF       ?lstr11_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr11_FirmV_0_7_0+11 
	MOVLW       115
	MOVWF       ?lstr11_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr11_FirmV_0_7_0+13 
	CLRF        ?lstr11_FirmV_0_7_0+14 
	MOVLW       ?lstr11_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr11_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3131:
;FirmV_0_7_0.c,757 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3132
;FirmV_0_7_0.c,758 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S3 Motor2 Slow",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CLRF        FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	MOVLW       83
	MOVWF       ?lstr12_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr12_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr12_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr12_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr12_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr12_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr12_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr12_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr12_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr12_FirmV_0_7_0+9 
	MOVLW       83
	MOVWF       ?lstr12_FirmV_0_7_0+10 
	MOVLW       108
	MOVWF       ?lstr12_FirmV_0_7_0+11 
	MOVLW       111
	MOVWF       ?lstr12_FirmV_0_7_0+12 
	MOVLW       119
	MOVWF       ?lstr12_FirmV_0_7_0+13 
	CLRF        ?lstr12_FirmV_0_7_0+14 
	MOVLW       ?lstr12_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr12_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3132:
;FirmV_0_7_0.c,760 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3133
;FirmV_0_7_0.c,761 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S3 Overflow Flag1 Set",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr13_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr13_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr13_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr13_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr13_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr13_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr13_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3133:
;FirmV_0_7_0.c,763 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3134
;FirmV_0_7_0.c,764 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S3 Overflow Flag2 Set",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr14_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr14_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr14_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr14_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr14_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr14_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr14_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3134:
;FirmV_0_7_0.c,766 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3135
;FirmV_0_7_0.c,767 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S3 Motor1 Stop",1);}
	BCF         _OpenDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr15_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr15_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr15_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr15_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr15_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr15_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr15_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr15_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr15_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr15_FirmV_0_7_0+9 
	MOVLW       83
	MOVWF       ?lstr15_FirmV_0_7_0+10 
	MOVLW       116
	MOVWF       ?lstr15_FirmV_0_7_0+11 
	MOVLW       111
	MOVWF       ?lstr15_FirmV_0_7_0+12 
	MOVLW       112
	MOVWF       ?lstr15_FirmV_0_7_0+13 
	CLRF        ?lstr15_FirmV_0_7_0+14 
	MOVLW       ?lstr15_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr15_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3135:
;FirmV_0_7_0.c,769 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3136
;FirmV_0_7_0.c,770 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S3 Motor2 Stop",1);}
	BCF         _OpenDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr16_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr16_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr16_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr16_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr16_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr16_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr16_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr16_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr16_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr16_FirmV_0_7_0+9 
	MOVLW       83
	MOVWF       ?lstr16_FirmV_0_7_0+10 
	MOVLW       116
	MOVWF       ?lstr16_FirmV_0_7_0+11 
	MOVLW       111
	MOVWF       ?lstr16_FirmV_0_7_0+12 
	MOVLW       112
	MOVWF       ?lstr16_FirmV_0_7_0+13 
	CLRF        ?lstr16_FirmV_0_7_0+14 
	MOVLW       ?lstr16_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr16_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3136:
;FirmV_0_7_0.c,772 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3137
;FirmV_0_7_0.c,773 :: 		{Lock=1;}
	BSF         PORTD+0, 6 
L_State3137:
;FirmV_0_7_0.c,775 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3140
	BTFSS       _Events+5, 0 
	GOTO        L_State3140
	MOVF        _M1isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3140
L__State3763:
;FirmV_0_7_0.c,776 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor1 Collision",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       5
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr17_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr17_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr17_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr17_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr17_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       20
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr17_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr17_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,777 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errOverload+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errOverload+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State3140:
;FirmV_0_7_0.c,779 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3143
	BTFSS       _Events+5, 1 
	GOTO        L_State3143
	MOVF        _M2isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3143
L__State3762:
;FirmV_0_7_0.c,780 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor2 Collision",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       5
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr18_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr18_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr18_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr18_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr18_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       20
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr18_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr18_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,781 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errOverload+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errOverload+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State3143:
;FirmV_0_7_0.c,783 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State3761
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State3761
	GOTO        L_State3146
L__State3761:
;FirmV_0_7_0.c,784 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State3146:
;FirmV_0_7_0.c,786 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State3149
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3149
L__State3760:
;FirmV_0_7_0.c,787 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Photocell Int",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       5
	MOVWF       _State+0 
	MOVLW       ?ICS?lstr19_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr19_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr19_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr19_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr19_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr19_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr19_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,788 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errPhoto+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errPhoto+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State3149:
;FirmV_0_7_0.c,790 :: 		if(Events.Remote!=0)
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State3150
;FirmV_0_7_0.c,791 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Remote Stoped",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       5
	MOVWF       _State+0 
	MOVLW       ?ICS?lstr20_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr20_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr20_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr20_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr20_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr20_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr20_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,792 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errRemote+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errRemote+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State3150:
;FirmV_0_7_0.c,794 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3153
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3153
L__State3759:
;FirmV_0_7_0.c,795 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Limit Switch Stoped",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       5
	MOVWF       _State+0 
	MOVLW       ?ICS?lstr21_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr21_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr21_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr21_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr21_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       23
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr21_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr21_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,796 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errLimit+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errLimit+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State3153:
;FirmV_0_7_0.c,798 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3154
;FirmV_0_7_0.c,799 :: 		{State=2; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_blank,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       2
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __open+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__open+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State3154:
;FirmV_0_7_0.c,801 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State3758
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State3758
	GOTO        L_State3157
L__State3758:
;FirmV_0_7_0.c,802 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S3 Autoclose Renewed",1);memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;LCDLines=2;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State3864
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State3864:
	BTFSC       STATUS+0, 2 
	GOTO        L_State3158
	MOVF        _AutoCloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _AutoCloseTime+1, 0 
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       ?ICS?lstr22_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr22_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr22_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr22_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr22_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr22_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr22_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __autoclose+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__autoclose+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State3158:
L_State3157:
;FirmV_0_7_0.c,804 :: 		}
	RETURN      0
; end of _State3

_State4:

;FirmV_0_7_0.c,818 :: 		void State4()
;FirmV_0_7_0.c,820 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,821 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,824 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4159
;FirmV_0_7_0.c,825 :: 		{StartMotor(1,_Close);Logger("S4 Motor1Start",1);}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr23_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr23_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr23_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr23_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr23_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr23_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr23_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr23_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr23_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr23_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr23_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr23_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr23_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr23_FirmV_0_7_0+13 
	CLRF        ?lstr23_FirmV_0_7_0+14 
	MOVLW       ?lstr23_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr23_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4159:
;FirmV_0_7_0.c,827 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4160
;FirmV_0_7_0.c,828 :: 		{StartMotor(2,_Close);Logger("S4 Motor2Start",1);memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr24_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr24_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr24_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr24_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr24_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr24_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr24_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr24_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr24_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr24_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr24_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr24_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr24_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr24_FirmV_0_7_0+13 
	CLRF        ?lstr24_FirmV_0_7_0+14 
	MOVLW       ?lstr24_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr24_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __closing+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__closing+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State4160:
;FirmV_0_7_0.c,830 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4161
;FirmV_0_7_0.c,831 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S4 M1 Overload Check",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr25_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr25_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr25_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr25_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr25_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr25_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr25_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4161:
;FirmV_0_7_0.c,833 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4162
;FirmV_0_7_0.c,834 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S4 M2 Overload Check",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr26_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr26_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr26_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr26_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr26_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr26_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr26_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4162:
;FirmV_0_7_0.c,836 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4163
;FirmV_0_7_0.c,837 :: 		{SetMotorSpeed(1,Motor2FullSpeed); OverloadCheckFlag1=0; M1isSlow=0;Logger("S4 M1 Speed UP",1);}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _M1isSlow+0 
	MOVLW       83
	MOVWF       ?lstr27_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr27_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr27_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr27_FirmV_0_7_0+3 
	MOVLW       49
	MOVWF       ?lstr27_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr27_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr27_FirmV_0_7_0+6 
	MOVLW       112
	MOVWF       ?lstr27_FirmV_0_7_0+7 
	MOVLW       101
	MOVWF       ?lstr27_FirmV_0_7_0+8 
	MOVLW       101
	MOVWF       ?lstr27_FirmV_0_7_0+9 
	MOVLW       100
	MOVWF       ?lstr27_FirmV_0_7_0+10 
	MOVLW       32
	MOVWF       ?lstr27_FirmV_0_7_0+11 
	MOVLW       85
	MOVWF       ?lstr27_FirmV_0_7_0+12 
	MOVLW       80
	MOVWF       ?lstr27_FirmV_0_7_0+13 
	CLRF        ?lstr27_FirmV_0_7_0+14 
	MOVLW       ?lstr27_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr27_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4163:
;FirmV_0_7_0.c,839 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4164
;FirmV_0_7_0.c,840 :: 		{SetMotorSpeed(0,Motor2FullSpeed); OverloadCheckFlag1=0; M1isSlow=1;Logger("S4 M1 Speed Down",1);}
	CLRF        FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       _M1isSlow+0 
	MOVLW       ?ICS?lstr28_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr28_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr28_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr28_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr28_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr28_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr28_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4164:
;FirmV_0_7_0.c,842 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4165
;FirmV_0_7_0.c,843 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S4 M2 Speed UP",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       83
	MOVWF       ?lstr29_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr29_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr29_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr29_FirmV_0_7_0+3 
	MOVLW       50
	MOVWF       ?lstr29_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr29_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr29_FirmV_0_7_0+6 
	MOVLW       112
	MOVWF       ?lstr29_FirmV_0_7_0+7 
	MOVLW       101
	MOVWF       ?lstr29_FirmV_0_7_0+8 
	MOVLW       101
	MOVWF       ?lstr29_FirmV_0_7_0+9 
	MOVLW       100
	MOVWF       ?lstr29_FirmV_0_7_0+10 
	MOVLW       32
	MOVWF       ?lstr29_FirmV_0_7_0+11 
	MOVLW       85
	MOVWF       ?lstr29_FirmV_0_7_0+12 
	MOVLW       80
	MOVWF       ?lstr29_FirmV_0_7_0+13 
	CLRF        ?lstr29_FirmV_0_7_0+14 
	MOVLW       ?lstr29_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr29_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4165:
;FirmV_0_7_0.c,845 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4166
;FirmV_0_7_0.c,846 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S4 M2 Speed Down",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CLRF        FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	MOVLW       ?ICS?lstr30_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr30_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr30_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr30_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr30_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr30_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr30_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4166:
;FirmV_0_7_0.c,848 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4167
;FirmV_0_7_0.c,849 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S4 M1 Stoped",1);}
	BCF         _CloseDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr31_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr31_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr31_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr31_FirmV_0_7_0+3 
	MOVLW       49
	MOVWF       ?lstr31_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr31_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr31_FirmV_0_7_0+6 
	MOVLW       116
	MOVWF       ?lstr31_FirmV_0_7_0+7 
	MOVLW       111
	MOVWF       ?lstr31_FirmV_0_7_0+8 
	MOVLW       112
	MOVWF       ?lstr31_FirmV_0_7_0+9 
	MOVLW       101
	MOVWF       ?lstr31_FirmV_0_7_0+10 
	MOVLW       100
	MOVWF       ?lstr31_FirmV_0_7_0+11 
	CLRF        ?lstr31_FirmV_0_7_0+12 
	MOVLW       ?lstr31_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr31_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4167:
;FirmV_0_7_0.c,851 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4168
;FirmV_0_7_0.c,852 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S4 M2 Stoped",1);}
	BCF         _CloseDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr32_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr32_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr32_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr32_FirmV_0_7_0+3 
	MOVLW       50
	MOVWF       ?lstr32_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr32_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr32_FirmV_0_7_0+6 
	MOVLW       116
	MOVWF       ?lstr32_FirmV_0_7_0+7 
	MOVLW       111
	MOVWF       ?lstr32_FirmV_0_7_0+8 
	MOVLW       112
	MOVWF       ?lstr32_FirmV_0_7_0+9 
	MOVLW       101
	MOVWF       ?lstr32_FirmV_0_7_0+10 
	MOVLW       100
	MOVWF       ?lstr32_FirmV_0_7_0+11 
	CLRF        ?lstr32_FirmV_0_7_0+12 
	MOVLW       ?lstr32_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr32_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4168:
;FirmV_0_7_0.c,854 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4171
	BTFSS       _Events+5, 0 
	GOTO        L_State4171
	MOVF        _M1isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4171
L__State4768:
;FirmV_0_7_0.c,855 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M1 Overloaded",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       6
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr33_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr33_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr33_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr33_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr33_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr33_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr33_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,856 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errOverload+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errOverload+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State4171:
;FirmV_0_7_0.c,858 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4174
	BTFSS       _Events+5, 1 
	GOTO        L_State4174
	MOVF        _M2isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4174
L__State4767:
;FirmV_0_7_0.c,859 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M2 Overloaded",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       6
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr34_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr34_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr34_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr34_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr34_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr34_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr34_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,860 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errOverload+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errOverload+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State4174:
;FirmV_0_7_0.c,862 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State4766
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State4766
	GOTO        L_State4177
L__State4766:
;FirmV_0_7_0.c,863 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State4177:
;FirmV_0_7_0.c,865 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State4178
;FirmV_0_7_0.c,866 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S4 Photocell Int",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       6
	MOVWF       _State+0 
	MOVLW       1
	MOVWF       _PhotocellOpenFlag+0 
	MOVLW       ?ICS?lstr35_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr35_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr35_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr35_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr35_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr35_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr35_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,867 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errPhoto+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errPhoto+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State4178:
;FirmV_0_7_0.c,869 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4181
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4181
L__State4765:
;FirmV_0_7_0.c,870 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Limit Switch Stop",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       6
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr36_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr36_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr36_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr36_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr36_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr36_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr36_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,871 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errLimit+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errLimit+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State4181:
;FirmV_0_7_0.c,873 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State4182
;FirmV_0_7_0.c,874 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Remote Pressed",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       6
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr37_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr37_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr37_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr37_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr37_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       18
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr37_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr37_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,875 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errRemote+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errRemote+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State4182:
;FirmV_0_7_0.c,877 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4183
;FirmV_0_7_0.c,878 :: 		{State=1; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       1
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __close+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__close+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State4183:
;FirmV_0_7_0.c,880 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State4764
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State4764
	GOTO        L_State4186
L__State4764:
;FirmV_0_7_0.c,881 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S4 Autoclose Renewed",1);memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;LCDLines=2;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State4865
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State4865:
	BTFSC       STATUS+0, 2 
	GOTO        L_State4187
	MOVF        _AutoCloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _AutoCloseTime+1, 0 
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       ?ICS?lstr38_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr38_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr38_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr38_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr38_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr38_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr38_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __autoclose+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__autoclose+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State4187:
L_State4186:
;FirmV_0_7_0.c,883 :: 		}
	RETURN      0
; end of _State4

_State5:

;FirmV_0_7_0.c,898 :: 		void State5()
;FirmV_0_7_0.c,900 :: 		char delay=2;
	MOVLW       2
	MOVWF       State5_delay_L0+0 
;FirmV_0_7_0.c,901 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,902 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,903 :: 		if((Events.Remote!=0)||(CheckTask(9)==1))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State5773
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5773
	GOTO        L_State5190
L__State5773:
;FirmV_0_7_0.c,905 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State5772
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5772
	GOTO        L_State5193
L__State5772:
;FirmV_0_7_0.c,907 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,908 :: 		temp=ms500+delay;
	MOVF        State5_delay_L0+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,909 :: 		AddTask(temp,1);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       1
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,910 :: 		AddTask(temp,5);
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,911 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,912 :: 		temp=ms500+OverloadDelay+delay;
	MOVLW       6
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,913 :: 		AddTask(temp,10); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       10
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,914 :: 		temp=ms500+Door1CloseTime+delay;
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,915 :: 		AddTask(temp,3);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,916 :: 		}
L_State5193:
;FirmV_0_7_0.c,917 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State5196
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State5196
L__State5771:
;FirmV_0_7_0.c,919 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,920 :: 		temp=ms500+delay;
	MOVF        State5_delay_L0+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,921 :: 		AddTask(temp,2);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       2
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,922 :: 		AddTask(temp,6);
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       6
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,923 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,924 :: 		temp=ms500+OverloadDelay+delay;
	MOVLW       6
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,925 :: 		AddTask(temp,11); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       11
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,926 :: 		temp=ms500+Door1CloseTime+delay;
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,927 :: 		AddTask(temp,4);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       4
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,932 :: 		temp=ms500+ActionTimeDiff+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,933 :: 		AddTask(temp,1);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       1
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,934 :: 		temp=ms500+ActionTimeDiff+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,935 :: 		AddTask(temp,5);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,936 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,937 :: 		temp=ms500+ActionTimeDiff+OverloadDelay+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVLW       6
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,938 :: 		AddTask(temp,10); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       10
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,939 :: 		temp=ms500+Door2CloseTime+delay+ActionTimeDiff;
	MOVF        _Door2CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,940 :: 		AddTask(temp,3);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,941 :: 		}
L_State5196:
;FirmV_0_7_0.c,942 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,943 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,944 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,945 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,946 :: 		}
L_State5190:
;FirmV_0_7_0.c,948 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State5199
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State5866
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State5866:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5199
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State5199
L__State5770:
;FirmV_0_7_0.c,949 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S5 Auto Close Deleted",1);}
	MOVLW       1
	MOVWF       _PassFlag+0 
	CALL        _GetAutocloseTime+0, 0
	MOVF        R0, 0 
	MOVWF       __AC+0 
	MOVLW       ?ICS?lstr39_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr39_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr39_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr39_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr39_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr39_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr39_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State5199:
;FirmV_0_7_0.c,951 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State5202
	BTFSC       _Events+6, 0 
	GOTO        L_State5202
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State5867
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State5867:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5202
L__State5769:
;FirmV_0_7_0.c,954 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:",1);Logger(t,1);}
	MOVF        __AC+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _PassFlag+0 
	MOVF        _temp+0, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+3 
	MOVLW       _t+0
	MOVWF       FARG_LongWordToStrWithZeros_output+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_LongWordToStrWithZeros_output+1 
	CALL        _LongWordToStrWithZeros+0, 0
	MOVLW       ?ICS?lstr40_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr40_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr40_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr40_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr40_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       16
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr40_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr40_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       _t+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,956 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:",1);Logger(t,1);}
L_State5204:
;FirmV_0_7_0.c,957 :: 		}
L_State5202:
;FirmV_0_7_0.c,959 :: 		}
	RETURN      0
; end of _State5

_State6:

;FirmV_0_7_0.c,979 :: 		void State6()
;FirmV_0_7_0.c,983 :: 		char delay=3;
	MOVLW       3
	MOVWF       State6_delay_L0+0 
;FirmV_0_7_0.c,984 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,985 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,986 :: 		if((Events.Remote!=0)||(PhotocellOpenFlag))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State6778
	MOVF        _PhotocellOpenFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6778
	GOTO        L_State6207
L__State6778:
;FirmV_0_7_0.c,988 :: 		PhotocellOpenFlag=0;
	CLRF        _PhotocellOpenFlag+0 
;FirmV_0_7_0.c,989 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,990 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,991 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,992 :: 		if(Lockenable)
	MOVF        _LockEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State6208
;FirmV_0_7_0.c,993 :: 		AddTask(ms500+1,12);
	MOVLW       1
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       12
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State6208:
;FirmV_0_7_0.c,994 :: 		temp=ms500+delay;
	MOVF        State6_delay_L0+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,995 :: 		AddTask(temp,1);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       1
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,996 :: 		AddTask(temp,5);
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,997 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,998 :: 		temp=ms500+OverloadDelay+delay;
	MOVLW       6
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,999 :: 		AddTask(temp,10); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       10
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,1000 :: 		temp=ms500+Door1OpenTime+delay;
	MOVF        _Door1OpenTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,1001 :: 		AddTask(temp,3);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,1002 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6211
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6211
L__State6777:
;FirmV_0_7_0.c,1004 :: 		AddTask(ms500+ActionTimeDiff+delay,2);
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       2
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,1005 :: 		AddTask(ms500+ActionTimeDiff+delay,6);
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       6
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,1006 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,1007 :: 		AddTask(ms500+ActionTimeDiff+OverloadDelay+delay,11); //overload check
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       6
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       11
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,1008 :: 		AddTask(ms500+Door2OpenTime+ActionTimeDiff+delay,4);//Stop motor
	MOVF        _Door2OpenTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       4
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,1009 :: 		}
L_State6211:
;FirmV_0_7_0.c,1010 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,1011 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,1012 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,1013 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,1014 :: 		State=8;
	MOVLW       8
	MOVWF       _State+0 
;FirmV_0_7_0.c,1015 :: 		}
L_State6207:
;FirmV_0_7_0.c,1018 :: 		if(CheckTask(9)==1)
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6212
;FirmV_0_7_0.c,1020 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1021 :: 		temp=ms500+delay;
	MOVF        State6_delay_L0+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,1022 :: 		AddTask(temp,1);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       1
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,1023 :: 		AddTask(temp,5);
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,1024 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,1025 :: 		temp=ms500+OverloadDelay+delay;
	MOVLW       6
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,1026 :: 		AddTask(temp,10); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       10
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,1027 :: 		temp=ms500+Door1CloseTime+delay;
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,1028 :: 		AddTask(temp,3);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,1030 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6215
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6215
L__State6776:
;FirmV_0_7_0.c,1032 :: 		AddTask(ms500+ActionTimeDiff+delay,2);
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       2
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,1033 :: 		AddTask(ms500+ActionTimeDiff+delay,6);
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       6
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,1034 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,1035 :: 		AddTask(ms500+ActionTimeDiff+OverloadDelay+delay,11); //overload check
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       6
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       11
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,1036 :: 		AddTask(ms500+Door1CloseTime+ActionTimeDiff+delay,4);//Stop motor
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       4
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,1037 :: 		}
L_State6215:
;FirmV_0_7_0.c,1038 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,1039 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,1040 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,1041 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,1042 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,1043 :: 		}
L_State6212:
;FirmV_0_7_0.c,1045 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State6218
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6868
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State6868:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6218
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State6218
L__State6775:
;FirmV_0_7_0.c,1046 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S6 Auto Close Deleted",1);}
	MOVLW       1
	MOVWF       _PassFlag+0 
	CALL        _GetAutocloseTime+0, 0
	MOVF        R0, 0 
	MOVWF       __AC+0 
	MOVLW       ?ICS?lstr42_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr42_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr42_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr42_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr42_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr42_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr42_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State6218:
;FirmV_0_7_0.c,1048 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6221
	BTFSC       _Events+6, 0 
	GOTO        L_State6221
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6869
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State6869:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6221
L__State6774:
;FirmV_0_7_0.c,1050 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:",1);Logger(t,1);}
	MOVF        __AC+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _PassFlag+0 
	MOVF        _temp+0, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+3 
	MOVLW       _t+0
	MOVWF       FARG_LongWordToStrWithZeros_output+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_LongWordToStrWithZeros_output+1 
	CALL        _LongWordToStrWithZeros+0, 0
	MOVLW       ?ICS?lstr43_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr43_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr43_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr43_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr43_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       16
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr43_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr43_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       _t+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,1052 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:",1);Logger(t,1);}
L_State6223:
;FirmV_0_7_0.c,1053 :: 		}
L_State6221:
;FirmV_0_7_0.c,1055 :: 		}
	RETURN      0
; end of _State6

_State7:

;FirmV_0_7_0.c,1077 :: 		void State7()
;FirmV_0_7_0.c,1079 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,1080 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,1082 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7224
;FirmV_0_7_0.c,1083 :: 		{StartMotor(1,_Close);Logger("S7 Motor1Start",1);}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr45_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr45_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr45_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr45_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr45_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr45_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr45_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr45_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr45_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr45_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr45_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr45_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr45_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr45_FirmV_0_7_0+13 
	CLRF        ?lstr45_FirmV_0_7_0+14 
	MOVLW       ?lstr45_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr45_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7224:
;FirmV_0_7_0.c,1085 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7225
;FirmV_0_7_0.c,1086 :: 		{StartMotor(2,_Close);Logger("S7 Motor2Start",1);memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr46_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr46_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr46_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr46_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr46_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr46_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr46_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr46_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr46_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr46_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr46_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr46_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr46_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr46_FirmV_0_7_0+13 
	CLRF        ?lstr46_FirmV_0_7_0+14 
	MOVLW       ?lstr46_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr46_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __closing+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__closing+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State7225:
;FirmV_0_7_0.c,1088 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7226
;FirmV_0_7_0.c,1089 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S7 M1 Overload Check",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr47_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr47_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr47_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr47_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr47_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr47_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr47_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7226:
;FirmV_0_7_0.c,1091 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7227
;FirmV_0_7_0.c,1092 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S7 M2 Overload Check",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr48_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr48_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr48_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr48_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr48_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr48_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr48_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7227:
;FirmV_0_7_0.c,1094 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7228
;FirmV_0_7_0.c,1095 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S7 M1 Speed UP",1);}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
	MOVLW       83
	MOVWF       ?lstr49_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr49_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr49_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr49_FirmV_0_7_0+3 
	MOVLW       49
	MOVWF       ?lstr49_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr49_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr49_FirmV_0_7_0+6 
	MOVLW       112
	MOVWF       ?lstr49_FirmV_0_7_0+7 
	MOVLW       101
	MOVWF       ?lstr49_FirmV_0_7_0+8 
	MOVLW       101
	MOVWF       ?lstr49_FirmV_0_7_0+9 
	MOVLW       100
	MOVWF       ?lstr49_FirmV_0_7_0+10 
	MOVLW       32
	MOVWF       ?lstr49_FirmV_0_7_0+11 
	MOVLW       85
	MOVWF       ?lstr49_FirmV_0_7_0+12 
	MOVLW       80
	MOVWF       ?lstr49_FirmV_0_7_0+13 
	CLRF        ?lstr49_FirmV_0_7_0+14 
	MOVLW       ?lstr49_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr49_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7228:
;FirmV_0_7_0.c,1097 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7229
;FirmV_0_7_0.c,1098 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S7 M2 Speed UP",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       83
	MOVWF       ?lstr50_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr50_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr50_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr50_FirmV_0_7_0+3 
	MOVLW       50
	MOVWF       ?lstr50_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr50_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr50_FirmV_0_7_0+6 
	MOVLW       112
	MOVWF       ?lstr50_FirmV_0_7_0+7 
	MOVLW       101
	MOVWF       ?lstr50_FirmV_0_7_0+8 
	MOVLW       101
	MOVWF       ?lstr50_FirmV_0_7_0+9 
	MOVLW       100
	MOVWF       ?lstr50_FirmV_0_7_0+10 
	MOVLW       32
	MOVWF       ?lstr50_FirmV_0_7_0+11 
	MOVLW       85
	MOVWF       ?lstr50_FirmV_0_7_0+12 
	MOVLW       80
	MOVWF       ?lstr50_FirmV_0_7_0+13 
	CLRF        ?lstr50_FirmV_0_7_0+14 
	MOVLW       ?lstr50_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr50_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7229:
;FirmV_0_7_0.c,1100 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(CloseDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7786
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7787
	BTFSS       _Events+5, 0 
	GOTO        L__State7787
	GOTO        L__State7786
L__State7787:
	GOTO        L_State7236
L__State7786:
	BTFSS       _CloseDone+0, 0 
	GOTO        L_State7236
L__State7785:
;FirmV_0_7_0.c,1101 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S7 M1 Stoped",1);}
	BCF         _CloseDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr51_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr51_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr51_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr51_FirmV_0_7_0+3 
	MOVLW       49
	MOVWF       ?lstr51_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr51_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr51_FirmV_0_7_0+6 
	MOVLW       116
	MOVWF       ?lstr51_FirmV_0_7_0+7 
	MOVLW       111
	MOVWF       ?lstr51_FirmV_0_7_0+8 
	MOVLW       112
	MOVWF       ?lstr51_FirmV_0_7_0+9 
	MOVLW       101
	MOVWF       ?lstr51_FirmV_0_7_0+10 
	MOVLW       100
	MOVWF       ?lstr51_FirmV_0_7_0+11 
	CLRF        ?lstr51_FirmV_0_7_0+12 
	MOVLW       ?lstr51_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr51_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7236:
;FirmV_0_7_0.c,1103 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(CloseDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7783
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7784
	BTFSS       _Events+5, 1 
	GOTO        L__State7784
	GOTO        L__State7783
L__State7784:
	GOTO        L_State7243
L__State7783:
	BTFSS       _CloseDone+0, 1 
	GOTO        L_State7243
L__State7782:
;FirmV_0_7_0.c,1104 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S7 M2 Stoped",1);}
	BCF         _CloseDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr52_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr52_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr52_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr52_FirmV_0_7_0+3 
	MOVLW       50
	MOVWF       ?lstr52_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr52_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr52_FirmV_0_7_0+6 
	MOVLW       116
	MOVWF       ?lstr52_FirmV_0_7_0+7 
	MOVLW       111
	MOVWF       ?lstr52_FirmV_0_7_0+8 
	MOVLW       112
	MOVWF       ?lstr52_FirmV_0_7_0+9 
	MOVLW       101
	MOVWF       ?lstr52_FirmV_0_7_0+10 
	MOVLW       100
	MOVWF       ?lstr52_FirmV_0_7_0+11 
	CLRF        ?lstr52_FirmV_0_7_0+12 
	MOVLW       ?lstr52_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr52_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7243:
;FirmV_0_7_0.c,1106 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State7781
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State7781
	GOTO        L_State7246
L__State7781:
;FirmV_0_7_0.c,1107 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State7246:
;FirmV_0_7_0.c,1109 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State7247
;FirmV_0_7_0.c,1110 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S7 Photocell Int",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       6
	MOVWF       _State+0 
	MOVLW       1
	MOVWF       _PhotocellOpenFlag+0 
	MOVLW       ?ICS?lstr53_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr53_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr53_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr53_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr53_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr53_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr53_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1111 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errPhoto+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errPhoto+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State7247:
;FirmV_0_7_0.c,1113 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State7248
;FirmV_0_7_0.c,1114 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Remote Pressed",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       6
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr54_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr54_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr54_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr54_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr54_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       18
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr54_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr54_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1115 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errRemote+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errRemote+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State7248:
;FirmV_0_7_0.c,1117 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State7251
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7251
L__State7780:
;FirmV_0_7_0.c,1118 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Limit Switch Stop",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       6
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr55_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr55_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr55_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr55_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr55_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr55_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr55_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1119 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errLimit+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errLimit+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State7251:
;FirmV_0_7_0.c,1121 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State7252
;FirmV_0_7_0.c,1122 :: 		{State=1; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       1
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __close+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__close+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State7252:
;FirmV_0_7_0.c,1124 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State7779
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State7779
	GOTO        L_State7255
L__State7779:
;FirmV_0_7_0.c,1125 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S7 Autoclose Renewed",1);memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;LCDLines=2;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7870
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State7870:
	BTFSC       STATUS+0, 2 
	GOTO        L_State7256
	MOVF        _AutoCloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _AutoCloseTime+1, 0 
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       ?ICS?lstr56_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr56_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr56_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr56_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr56_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr56_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr56_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __autoclose+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__autoclose+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State7256:
L_State7255:
;FirmV_0_7_0.c,1128 :: 		}
	RETURN      0
; end of _State7

_State8:

;FirmV_0_7_0.c,1145 :: 		void State8()
;FirmV_0_7_0.c,1147 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,1148 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,1150 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8257
;FirmV_0_7_0.c,1151 :: 		{StartMotor(1,_Open);Logger("S8 Motor1Start",1); Lock=0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr57_FirmV_0_7_0+0 
	MOVLW       56
	MOVWF       ?lstr57_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr57_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr57_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr57_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr57_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr57_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr57_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr57_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr57_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr57_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr57_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr57_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr57_FirmV_0_7_0+13 
	CLRF        ?lstr57_FirmV_0_7_0+14 
	MOVLW       ?lstr57_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr57_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	BCF         PORTD+0, 6 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __opening+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__opening+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State8257:
;FirmV_0_7_0.c,1153 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8258
;FirmV_0_7_0.c,1154 :: 		{StartMotor(2,_Open);Logger("S8 Motor2Start",1); Lock=0;}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr58_FirmV_0_7_0+0 
	MOVLW       56
	MOVWF       ?lstr58_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr58_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr58_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr58_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr58_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr58_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr58_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr58_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr58_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr58_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr58_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr58_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr58_FirmV_0_7_0+13 
	CLRF        ?lstr58_FirmV_0_7_0+14 
	MOVLW       ?lstr58_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr58_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	BCF         PORTD+0, 6 
L_State8258:
;FirmV_0_7_0.c,1156 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8259
;FirmV_0_7_0.c,1157 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S8 Overflow Flag1 Set",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr59_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr59_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr59_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr59_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr59_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr59_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr59_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8259:
;FirmV_0_7_0.c,1159 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8260
;FirmV_0_7_0.c,1160 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S8 Overflow Flag2 Set",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr60_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr60_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr60_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr60_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr60_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr60_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr60_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8260:
;FirmV_0_7_0.c,1162 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8261
;FirmV_0_7_0.c,1163 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S8 Motor1 Fast",1);}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
	MOVLW       83
	MOVWF       ?lstr61_FirmV_0_7_0+0 
	MOVLW       56
	MOVWF       ?lstr61_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr61_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr61_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr61_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr61_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr61_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr61_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr61_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr61_FirmV_0_7_0+9 
	MOVLW       70
	MOVWF       ?lstr61_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr61_FirmV_0_7_0+11 
	MOVLW       115
	MOVWF       ?lstr61_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr61_FirmV_0_7_0+13 
	CLRF        ?lstr61_FirmV_0_7_0+14 
	MOVLW       ?lstr61_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr61_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8261:
;FirmV_0_7_0.c,1165 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8262
;FirmV_0_7_0.c,1166 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S8 Motor2 Fast",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       83
	MOVWF       ?lstr62_FirmV_0_7_0+0 
	MOVLW       56
	MOVWF       ?lstr62_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr62_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr62_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr62_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr62_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr62_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr62_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr62_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr62_FirmV_0_7_0+9 
	MOVLW       70
	MOVWF       ?lstr62_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr62_FirmV_0_7_0+11 
	MOVLW       115
	MOVWF       ?lstr62_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr62_FirmV_0_7_0+13 
	CLRF        ?lstr62_FirmV_0_7_0+14 
	MOVLW       ?lstr62_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr62_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8262:
;FirmV_0_7_0.c,1168 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(OpenDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8796
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8797
	BTFSS       _Events+5, 0 
	GOTO        L__State8797
	GOTO        L__State8796
L__State8797:
	GOTO        L_State8269
L__State8796:
	BTFSS       _OpenDone+0, 0 
	GOTO        L_State8269
L__State8795:
;FirmV_0_7_0.c,1169 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S8 Motor1 Stop",1);}
	BCF         _OpenDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr63_FirmV_0_7_0+0 
	MOVLW       56
	MOVWF       ?lstr63_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr63_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr63_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr63_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr63_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr63_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr63_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr63_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr63_FirmV_0_7_0+9 
	MOVLW       83
	MOVWF       ?lstr63_FirmV_0_7_0+10 
	MOVLW       116
	MOVWF       ?lstr63_FirmV_0_7_0+11 
	MOVLW       111
	MOVWF       ?lstr63_FirmV_0_7_0+12 
	MOVLW       112
	MOVWF       ?lstr63_FirmV_0_7_0+13 
	CLRF        ?lstr63_FirmV_0_7_0+14 
	MOVLW       ?lstr63_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr63_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8269:
;FirmV_0_7_0.c,1171 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(OpenDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8793
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8794
	BTFSS       _Events+5, 1 
	GOTO        L__State8794
	GOTO        L__State8793
L__State8794:
	GOTO        L_State8276
L__State8793:
	BTFSS       _OpenDone+0, 1 
	GOTO        L_State8276
L__State8792:
;FirmV_0_7_0.c,1172 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S8 Motor2 Stop",1);}
	BCF         _OpenDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr64_FirmV_0_7_0+0 
	MOVLW       56
	MOVWF       ?lstr64_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr64_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr64_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr64_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr64_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr64_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr64_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr64_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr64_FirmV_0_7_0+9 
	MOVLW       83
	MOVWF       ?lstr64_FirmV_0_7_0+10 
	MOVLW       116
	MOVWF       ?lstr64_FirmV_0_7_0+11 
	MOVLW       111
	MOVWF       ?lstr64_FirmV_0_7_0+12 
	MOVLW       112
	MOVWF       ?lstr64_FirmV_0_7_0+13 
	CLRF        ?lstr64_FirmV_0_7_0+14 
	MOVLW       ?lstr64_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr64_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8276:
;FirmV_0_7_0.c,1174 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8277
;FirmV_0_7_0.c,1175 :: 		{Lock=1;}
	BSF         PORTD+0, 6 
L_State8277:
;FirmV_0_7_0.c,1177 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State8791
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State8791
	GOTO        L_State8280
L__State8791:
;FirmV_0_7_0.c,1178 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State8280:
;FirmV_0_7_0.c,1180 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State8283
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8283
L__State8790:
;FirmV_0_7_0.c,1181 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S8 Photocell Int",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       5
	MOVWF       _State+0 
	MOVLW       ?ICS?lstr65_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr65_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr65_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr65_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr65_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr65_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr65_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1182 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errPhoto+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errPhoto+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State8283:
;FirmV_0_7_0.c,1184 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State8284
;FirmV_0_7_0.c,1185 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Motors Stoped (Remote)",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       5
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr66_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr66_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr66_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr66_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr66_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       26
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr66_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr66_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1186 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errRemote+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errRemote+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State8284:
;FirmV_0_7_0.c,1188 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State8287
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8287
L__State8789:
;FirmV_0_7_0.c,1189 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Limit Switch Stop",1);ClearTasks(9);
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       5
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr67_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr67_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr67_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr67_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr67_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr67_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr67_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1190 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errLimit+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errLimit+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State8287:
;FirmV_0_7_0.c,1192 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State8288
;FirmV_0_7_0.c,1193 :: 		{State=2; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       2
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __open+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__open+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State8288:
;FirmV_0_7_0.c,1195 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State8788
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State8788
	GOTO        L_State8291
L__State8788:
;FirmV_0_7_0.c,1196 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S8 Autoclose Renewed",1);memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;LCDLines=2;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8871
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State8871:
	BTFSC       STATUS+0, 2 
	GOTO        L_State8292
	MOVF        _AutoCloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _AutoCloseTime+1, 0 
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       ?ICS?lstr68_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr68_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr68_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr68_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr68_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr68_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr68_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __autoclose+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__autoclose+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       2
	MOVWF       _LCDLines+0 
L_State8292:
L_State8291:
;FirmV_0_7_0.c,1199 :: 		}
	RETURN      0
; end of _State8

_LCDUpdater:

;FirmV_0_7_0.c,1208 :: 		void LCDUpdater()
;FirmV_0_7_0.c,1213 :: 		if(LCDUpdateFlag==1)
	MOVF        _LCDUpdateFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDUpdater293
;FirmV_0_7_0.c,1215 :: 		if(LCDLines!=line)
	MOVF        _LCDLines+0, 0 
	XORWF       LCDUpdater_line_L0+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater294
;FirmV_0_7_0.c,1217 :: 		line=LCDLines;
	MOVF        _LCDLines+0, 0 
	MOVWF       LCDUpdater_line_L0+0 
;FirmV_0_7_0.c,1218 :: 		LCD_init(LCDLines);
	MOVF        _LCDLines+0, 0 
	MOVWF       FARG_LCD_Init+0 
	CALL        _LCD_Init+0, 0
;FirmV_0_7_0.c,1219 :: 		delay_ms(50);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_LCDUpdater295:
	DECFSZ      R13, 1, 0
	BRA         L_LCDUpdater295
	DECFSZ      R12, 1, 0
	BRA         L_LCDUpdater295
	DECFSZ      R11, 1, 0
	BRA         L_LCDUpdater295
	NOP
	NOP
;FirmV_0_7_0.c,1220 :: 		}
L_LCDUpdater294:
;FirmV_0_7_0.c,1221 :: 		lcd_out(1,0,LCDLine1);
	MOVLW       1
	MOVWF       FARG_LCD_out+0 
	CLRF        FARG_LCD_out+0 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_LCD_out+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_LCD_out+1 
	CALL        _LCD_out+0, 0
;FirmV_0_7_0.c,1222 :: 		if(!LCDFlash)
	MOVF        _LCDFlash+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDUpdater296
;FirmV_0_7_0.c,1223 :: 		lcd_out(2,0,LCDLine2);
	MOVLW       2
	MOVWF       FARG_LCD_out+0 
	CLRF        FARG_LCD_out+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_LCD_out+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_LCD_out+1 
	CALL        _LCD_out+0, 0
	GOTO        L_LCDUpdater297
L_LCDUpdater296:
;FirmV_0_7_0.c,1225 :: 		UpdateWhenFlashing=1;
	MOVLW       1
	MOVWF       LCDUpdater_UpdateWhenFlashing_L0+0 
L_LCDUpdater297:
;FirmV_0_7_0.c,1226 :: 		LCDUpdateFlag=0;
	CLRF        _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1227 :: 		}
L_LCDUpdater293:
;FirmV_0_7_0.c,1229 :: 		if(LCDFlash)
	MOVF        _LCDFlash+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater298
;FirmV_0_7_0.c,1231 :: 		if(((LCDFlashFlag)&&(LastLCDFlashState==0))||((LastLCDFlashState)&&(UpdatewhenFlashing)))
	MOVF        _LCDFlashFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater803
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__LCDUpdater803
	GOTO        L__LCDUpdater801
L__LCDUpdater803:
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater802
	MOVF        LCDUpdater_UpdateWhenFlashing_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater802
	GOTO        L__LCDUpdater801
L__LCDUpdater802:
	GOTO        L_LCDUpdater305
L__LCDUpdater801:
;FirmV_0_7_0.c,1232 :: 		{memcpy(LCDLineTemp,LCDLine2,16);LCDLineTemp[0]='>';LCDLineTemp[1]='>';LCDLineTemp[2]='>';LCDLineTemp[13]='<';LCDLineTemp[14]='<';LCDLineTemp[15]='<';lcd_out(2,0,LCDLineTemp);LastLCDFlashState=1;UpdatewhenFlashing=0;}
	MOVLW       LCDUpdater_LCDLineTemp_L0+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(LCDUpdater_LCDLineTemp_L0+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       62
	MOVWF       LCDUpdater_LCDLineTemp_L0+0 
	MOVLW       62
	MOVWF       LCDUpdater_LCDLineTemp_L0+1 
	MOVLW       62
	MOVWF       LCDUpdater_LCDLineTemp_L0+2 
	MOVLW       60
	MOVWF       LCDUpdater_LCDLineTemp_L0+13 
	MOVLW       60
	MOVWF       LCDUpdater_LCDLineTemp_L0+14 
	MOVLW       60
	MOVWF       LCDUpdater_LCDLineTemp_L0+15 
	MOVLW       2
	MOVWF       FARG_LCD_out+0 
	CLRF        FARG_LCD_out+0 
	MOVLW       LCDUpdater_LCDLineTemp_L0+0
	MOVWF       FARG_LCD_out+0 
	MOVLW       hi_addr(LCDUpdater_LCDLineTemp_L0+0)
	MOVWF       FARG_LCD_out+1 
	CALL        _LCD_out+0, 0
	MOVLW       1
	MOVWF       LCDUpdater_LastLCDFlashState_L0+0 
	CLRF        LCDUpdater_UpdateWhenFlashing_L0+0 
L_LCDUpdater305:
;FirmV_0_7_0.c,1233 :: 		if(((!LCDFlashFlag)&&(LastLCDFlashState!=0))||((!LastLCDFlashState)&&(UpdatewhenFlashing)))
	MOVF        _LCDFlashFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCDUpdater800
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater800
	GOTO        L__LCDUpdater798
L__LCDUpdater800:
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCDUpdater799
	MOVF        LCDUpdater_UpdateWhenFlashing_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater799
	GOTO        L__LCDUpdater798
L__LCDUpdater799:
	GOTO        L_LCDUpdater312
L__LCDUpdater798:
;FirmV_0_7_0.c,1234 :: 		{lcd_out(2,0,LCDLine2);LastLCDFlashState=0;UpdatewhenFlashing=0;}
	MOVLW       2
	MOVWF       FARG_LCD_out+0 
	CLRF        FARG_LCD_out+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_LCD_out+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_LCD_out+1 
	CALL        _LCD_out+0, 0
	CLRF        LCDUpdater_LastLCDFlashState_L0+0 
	CLRF        LCDUpdater_UpdateWhenFlashing_L0+0 
L_LCDUpdater312:
;FirmV_0_7_0.c,1235 :: 		}
L_LCDUpdater298:
;FirmV_0_7_0.c,1238 :: 		}
	RETURN      0
; end of _LCDUpdater

_Init:

;FirmV_0_7_0.c,1258 :: 		void Init()
;FirmV_0_7_0.c,1260 :: 		char i=0;
	CLRF        Init_i_L0+0 
;FirmV_0_7_0.c,1262 :: 		porta=0;
	CLRF        PORTA+0 
;FirmV_0_7_0.c,1263 :: 		portb=0;
	CLRF        PORTB+0 
;FirmV_0_7_0.c,1264 :: 		portc=0;
	CLRF        PORTC+0 
;FirmV_0_7_0.c,1265 :: 		portd=0;
	CLRF        PORTD+0 
;FirmV_0_7_0.c,1266 :: 		porte=0;
	CLRF        PORTE+0 
;FirmV_0_7_0.c,1267 :: 		trisa=0b101111;
	MOVLW       47
	MOVWF       TRISA+0 
;FirmV_0_7_0.c,1268 :: 		trisb=0b10000111;
	MOVLW       135
	MOVWF       TRISB+0 
;FirmV_0_7_0.c,1269 :: 		trisc=0b10000100;
	MOVLW       132
	MOVWF       TRISC+0 
;FirmV_0_7_0.c,1270 :: 		trisd=0b00111111;
	MOVLW       63
	MOVWF       TRISD+0 
;FirmV_0_7_0.c,1271 :: 		trise=0b001;
	MOVLW       1
	MOVWF       TRISE+0 
;FirmV_0_7_0.c,1272 :: 		adcon1=0b1100;  // an6, an5 and an7 is digital
	MOVLW       12
	MOVWF       ADCON1+0 
;FirmV_0_7_0.c,1278 :: 		LCDBackLight=1;
	BSF         PORTA+0, 4 
;FirmV_0_7_0.c,1279 :: 		I2C1_init(100000);
	MOVLW       100
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;FirmV_0_7_0.c,1281 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Init313:
	DECFSZ      R13, 1, 0
	BRA         L_Init313
	DECFSZ      R12, 1, 0
	BRA         L_Init313
	DECFSZ      R11, 1, 0
	BRA         L_Init313
	NOP
	NOP
;FirmV_0_7_0.c,1283 :: 		LCD_init(1);
	MOVLW       1
	MOVWF       FARG_LCD_Init+0 
	CALL        _LCD_Init+0, 0
;FirmV_0_7_0.c,1284 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,1285 :: 		delay_ms(300);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_Init314:
	DECFSZ      R13, 1, 0
	BRA         L_Init314
	DECFSZ      R12, 1, 0
	BRA         L_Init314
	DECFSZ      R11, 1, 0
	BRA         L_Init314
	NOP
	NOP
;FirmV_0_7_0.c,1286 :: 		SetContrast(20);
	MOVLW       20
	MOVWF       FARG_SetContrast+0 
	CALL        _SetContrast+0, 0
;FirmV_0_7_0.c,1289 :: 		ms500=0;
	CLRF        _ms500+0 
	CLRF        _ms500+1 
	CLRF        _ms500+2 
	CLRF        _ms500+3 
;FirmV_0_7_0.c,1290 :: 		t0con=0b10000101; //enable tmr0 and prescalar
	MOVLW       133
	MOVWF       T0CON+0 
;FirmV_0_7_0.c,1291 :: 		intcon.b7=1;   //global int enable
	BSF         INTCON+0, 7 
;FirmV_0_7_0.c,1292 :: 		intcon.b5=1;  //tmr0 int enable
	BSF         INTCON+0, 5 
;FirmV_0_7_0.c,1293 :: 		intcon.b2=0; //tmr0 flag
	BCF         INTCON+0, 2 
;FirmV_0_7_0.c,1294 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,1295 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,1298 :: 		INT1IP_bit=1;
	BSF         INT1IP_bit+0, 6 
;FirmV_0_7_0.c,1299 :: 		INT1E_bit=1;
	BSF         INT1E_bit+0, 3 
;FirmV_0_7_0.c,1300 :: 		INT1F_bit=0;
	BCF         INT1F_bit+0, 0 
;FirmV_0_7_0.c,1301 :: 		INT2IP_bit=1;
	BSF         INT2IP_bit+0, 7 
;FirmV_0_7_0.c,1302 :: 		INT2E_bit=1;
	BSF         INT2E_bit+0, 4 
;FirmV_0_7_0.c,1303 :: 		INT2F_bit=0;
	BCF         INT2F_bit+0, 1 
;FirmV_0_7_0.c,1304 :: 		INTEDG1_bit=1;
	BSF         INTEDG1_bit+0, 5 
;FirmV_0_7_0.c,1305 :: 		INTEDG2_bit=1;
	BSF         INTEDG2_bit+0, 4 
;FirmV_0_7_0.c,1308 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, 1 
;FirmV_0_7_0.c,1309 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, 4 
;FirmV_0_7_0.c,1312 :: 		for(i=0;i<20;i++)
	CLRF        Init_i_L0+0 
L_Init315:
	MOVLW       20
	SUBWF       Init_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Init316
;FirmV_0_7_0.c,1313 :: 		Tasks[i].Expired=1;
	MOVF        Init_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,1312 :: 		for(i=0;i<20;i++)
	INCF        Init_i_L0+0, 1 
;FirmV_0_7_0.c,1313 :: 		Tasks[i].Expired=1;
	GOTO        L_Init315
L_Init316:
;FirmV_0_7_0.c,1316 :: 		Events.Keys=0;
	CLRF        _Events+0 
;FirmV_0_7_0.c,1317 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,1318 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,1319 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,1320 :: 		Events.Remote=0;
	CLRF        _Events+4 
;FirmV_0_7_0.c,1321 :: 		Events.Overload=0;
	CLRF        _Events+5 
;FirmV_0_7_0.c,1322 :: 		Events.Photocell=0;
	CLRF        _Events+6 
;FirmV_0_7_0.c,1325 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,1328 :: 		UART1_init(115200);
	MOVLW       21
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;FirmV_0_7_0.c,1331 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,1335 :: 		}
	RETURN      0
; end of _Init

_TaskManager:

;FirmV_0_7_0.c,1349 :: 		void TaskManager()
;FirmV_0_7_0.c,1351 :: 		char i=0;
	CLRF        TaskManager_i_L0+0 
;FirmV_0_7_0.c,1352 :: 		for(i=0;i<20;i++)
	CLRF        TaskManager_i_L0+0 
L_TaskManager318:
	MOVLW       20
	SUBWF       TaskManager_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TaskManager319
;FirmV_0_7_0.c,1353 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Time==ms500)&&(Tasks[i].Fired==0))
	MOVF        TaskManager_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_TaskManager323
	MOVF        TaskManager_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	XORWF       _ms500+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager872
	MOVF        R3, 0 
	XORWF       _ms500+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager872
	MOVF        R2, 0 
	XORWF       _ms500+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager872
	MOVF        R1, 0 
	XORWF       _ms500+0, 0 
L__TaskManager872:
	BTFSS       STATUS+0, 2 
	GOTO        L_TaskManager323
	MOVF        TaskManager_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_TaskManager323
L__TaskManager804:
;FirmV_0_7_0.c,1354 :: 		Tasks[i].Fired=1;
	MOVF        TaskManager_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_TaskManager323:
;FirmV_0_7_0.c,1352 :: 		for(i=0;i<20;i++)
	INCF        TaskManager_i_L0+0, 1 
;FirmV_0_7_0.c,1354 :: 		Tasks[i].Fired=1;
	GOTO        L_TaskManager318
L_TaskManager319:
;FirmV_0_7_0.c,1355 :: 		}
	RETURN      0
; end of _TaskManager

_AddTask:

;FirmV_0_7_0.c,1367 :: 		void AddTask(unsigned long OccTime,char tcode)
;FirmV_0_7_0.c,1370 :: 		for(i=0;i<20;i++)
	CLRF        AddTask_i_L0+0 
L_AddTask324:
	MOVLW       20
	SUBWF       AddTask_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AddTask325
;FirmV_0_7_0.c,1371 :: 		if(Tasks[i].Expired==1)
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_AddTask327
;FirmV_0_7_0.c,1373 :: 		Tasks[i].TaskCode=tcode;
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_AddTask_tcode+0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,1374 :: 		Tasks[i].Time=OccTime;
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_AddTask_OccTime+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_AddTask_OccTime+1, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_AddTask_OccTime+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_AddTask_OccTime+3, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,1375 :: 		Tasks[i].Expired=0;
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;FirmV_0_7_0.c,1376 :: 		Tasks[i].Fired=0;
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;FirmV_0_7_0.c,1377 :: 		break;
	GOTO        L_AddTask325
;FirmV_0_7_0.c,1378 :: 		}
L_AddTask327:
;FirmV_0_7_0.c,1370 :: 		for(i=0;i<20;i++)
	INCF        AddTask_i_L0+0, 1 
;FirmV_0_7_0.c,1378 :: 		}
	GOTO        L_AddTask324
L_AddTask325:
;FirmV_0_7_0.c,1379 :: 		}
	RETURN      0
; end of _AddTask

_EventHandler:

;FirmV_0_7_0.c,1389 :: 		void EventHandler()
;FirmV_0_7_0.c,1392 :: 		Events.ExternalKeys=GetExternalKeysState();
	CALL        _GetExternalKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+8 
;FirmV_0_7_0.c,1393 :: 		Events.Limiter=GetLimitSwitchState();
	CALL        _GetLimitSwitchState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+7 
;FirmV_0_7_0.c,1394 :: 		Events.Keys=GetKeysState();
	CALL        _GetKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+0 
;FirmV_0_7_0.c,1395 :: 		Events.Remote=GetRemoteState();
	CALL        _GetRemoteState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+4 
;FirmV_0_7_0.c,1396 :: 		Events.Overload=GetOverloadState();
	CALL        _GetOverloadState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+5 
;FirmV_0_7_0.c,1397 :: 		Events.Photocell=GetPhotocellState();
	CALL        _GetPhotocellState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+6 
;FirmV_0_7_0.c,1399 :: 		for(i=0;i<20;i++)
	CLRF        EventHandler_i_L0+0 
L_EventHandler328:
	MOVLW       20
	SUBWF       EventHandler_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_EventHandler329
;FirmV_0_7_0.c,1400 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Fired==1))
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler333
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler333
L__EventHandler805:
;FirmV_0_7_0.c,1402 :: 		if(Events.Task1==0)
	MOVF        _Events+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler334
;FirmV_0_7_0.c,1403 :: 		{Events.Task1=Tasks[i].TaskCode; Tasks[i].Expired=1;Tasks[i].Fired=0;}
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0L
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Events+1 
	MOVLW       5
	ADDWF       R2, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	GOTO        L_EventHandler335
L_EventHandler334:
;FirmV_0_7_0.c,1404 :: 		else if(Events.Task2==0)
	MOVF        _Events+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler336
;FirmV_0_7_0.c,1405 :: 		{Events.Task2=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0L
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Events+2 
	MOVLW       5
	ADDWF       R2, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	GOTO        L_EventHandler337
L_EventHandler336:
;FirmV_0_7_0.c,1406 :: 		else if(Events.Task3==0)
	MOVF        _Events+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler338
;FirmV_0_7_0.c,1407 :: 		{Events.Task3=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0L
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Events+3 
	MOVLW       5
	ADDWF       R2, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
L_EventHandler338:
L_EventHandler337:
L_EventHandler335:
;FirmV_0_7_0.c,1408 :: 		}
L_EventHandler333:
;FirmV_0_7_0.c,1399 :: 		for(i=0;i<20;i++)
	INCF        EventHandler_i_L0+0, 1 
;FirmV_0_7_0.c,1408 :: 		}
	GOTO        L_EventHandler328
L_EventHandler329:
;FirmV_0_7_0.c,1409 :: 		}
	RETURN      0
; end of _EventHandler

_GetKeysState:

;FirmV_0_7_0.c,1419 :: 		char GetKeysState()
;FirmV_0_7_0.c,1421 :: 		unsigned res=0;
	CLRF        GetKeysState_res_L0+0 
	CLRF        GetKeysState_res_L0+1 
;FirmV_0_7_0.c,1425 :: 		char resch=0,fin;
	CLRF        GetKeysState_resch_L0+0 
;FirmV_0_7_0.c,1426 :: 		resch.b0=~KeyDown;
	BTFSC       PORTD+0, 5 
	GOTO        L__GetKeysState873
	BSF         GetKeysState_resch_L0+0, 0 
	GOTO        L__GetKeysState874
L__GetKeysState873:
	BCF         GetKeysState_resch_L0+0, 0 
L__GetKeysState874:
;FirmV_0_7_0.c,1427 :: 		resch.b1=~KeyMenu;
	BTFSC       PORTE+0, 0 
	GOTO        L__GetKeysState875
	BSF         GetKeysState_resch_L0+0, 1 
	GOTO        L__GetKeysState876
L__GetKeysState875:
	BCF         GetKeysState_resch_L0+0, 1 
L__GetKeysState876:
;FirmV_0_7_0.c,1428 :: 		resch.b2=~KeyUp;
	BTFSC       PORTD+0, 4 
	GOTO        L__GetKeysState877
	BSF         GetKeysState_resch_L0+0, 2 
	GOTO        L__GetKeysState878
L__GetKeysState877:
	BCF         GetKeysState_resch_L0+0, 2 
L__GetKeysState878:
;FirmV_0_7_0.c,1430 :: 		if((resch==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState339
;FirmV_0_7_0.c,1432 :: 		if(Pressed==0)
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState340
;FirmV_0_7_0.c,1433 :: 		{Repeat=0;RepeatCount=0;Pressed=0;fin=0;RepeatRate=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        GetKeysState_RepeatCount_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState340:
;FirmV_0_7_0.c,1434 :: 		if(Pressed==1)
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState341
;FirmV_0_7_0.c,1435 :: 		if(DebouncingDelay>=DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelay+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetKeysState342
;FirmV_0_7_0.c,1436 :: 		{Repeat=0;RepeatCount=0;Pressed=0;fin=0;RepeatRate=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        GetKeysState_RepeatCount_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState342:
L_GetKeysState341:
;FirmV_0_7_0.c,1437 :: 		}
L_GetKeysState339:
;FirmV_0_7_0.c,1448 :: 		if((Repeat==1)&&(KeyFlag>=RepeatSpeed))
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState345
	MOVF        GetKeysState_RepeatSpeed_L0+0, 0 
	SUBWF       _KeyFlag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetKeysState345
L__GetKeysState810:
;FirmV_0_7_0.c,1449 :: 		{RepeatRate=1;KeyFlag=0;if(RepeatCount<25)RepeatCount=RepeatCount+1;}
	MOVLW       1
	MOVWF       GetKeysState_RepeatRate_L0+0 
	CLRF        _KeyFlag+0 
	MOVLW       25
	SUBWF       GetKeysState_RepeatCount_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState346
	INCF        GetKeysState_RepeatCount_L0+0, 1 
L_GetKeysState346:
L_GetKeysState345:
;FirmV_0_7_0.c,1453 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0)&&(ms500==PressTime+KeyRepeatDelay))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState349
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState349
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState349
	MOVLW       2
	ADDWF       GetKeysState_PressTime_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      GetKeysState_PressTime_L0+1, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      GetKeysState_PressTime_L0+2, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      GetKeysState_PressTime_L0+3, 0 
	MOVWF       R4 
	MOVF        _ms500+3, 0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState879
	MOVF        _ms500+2, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState879
	MOVF        _ms500+1, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState879
	MOVF        _ms500+0, 0 
	XORWF       R1, 0 
L__GetKeysState879:
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState349
L__GetKeysState809:
;FirmV_0_7_0.c,1454 :: 		{Repeat=1;KeyFlag=0;}
	MOVLW       1
	MOVWF       GetKeysState_Repeat_L0+0 
	CLRF        _KeyFlag+0 
L_GetKeysState349:
;FirmV_0_7_0.c,1456 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState352
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState352
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState352
L__GetKeysState808:
;FirmV_0_7_0.c,1457 :: 		fin=0;
	CLRF        GetKeysState_fin_L0+0 
L_GetKeysState352:
;FirmV_0_7_0.c,1459 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==1))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState355
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState355
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState355
L__GetKeysState807:
;FirmV_0_7_0.c,1460 :: 		{fin=resch*RepeatRate;RepeatRate=0;}
	MOVF        GetKeysState_resch_L0+0, 0 
	MULWF       GetKeysState_RepeatRate_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState355:
;FirmV_0_7_0.c,1463 :: 		if((resch!=0)&&(Pressed==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState358
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState358
L__GetKeysState806:
;FirmV_0_7_0.c,1464 :: 		{fin=resch; Pressed=1;PressTime=ms500;DebouncingDelay=0;}
	MOVF        GetKeysState_resch_L0+0, 0 
	MOVWF       GetKeysState_fin_L0+0 
	MOVLW       1
	MOVWF       _Pressed+0 
	MOVF        _ms500+0, 0 
	MOVWF       GetKeysState_PressTime_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       GetKeysState_PressTime_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       GetKeysState_PressTime_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       GetKeysState_PressTime_L0+3 
	CLRF        _DebouncingDelay+0 
L_GetKeysState358:
;FirmV_0_7_0.c,1468 :: 		if(fin != 0)
	MOVF        GetKeysState_fin_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState359
;FirmV_0_7_0.c,1469 :: 		BuzzFlag=1;
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_GetKeysState359:
;FirmV_0_7_0.c,1471 :: 		return fin;
	MOVF        GetKeysState_fin_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1472 :: 		}
	RETURN      0
; end of _GetKeysState

_GetExternalKeysState:

;FirmV_0_7_0.c,1482 :: 		char GetExternalKeysState()
;FirmV_0_7_0.c,1484 :: 		char out=0;
	CLRF        GetExternalKeysState_out_L0+0 
;FirmV_0_7_0.c,1485 :: 		if(KeyUp==0)
	BTFSC       PORTD+0, 4 
	GOTO        L_GetExternalKeysState360
;FirmV_0_7_0.c,1486 :: 		out.b0=1;
	BSF         GetExternalKeysState_out_L0+0, 0 
L_GetExternalKeysState360:
;FirmV_0_7_0.c,1487 :: 		if(KeyDown==0)
	BTFSC       PORTD+0, 5 
	GOTO        L_GetExternalKeysState361
;FirmV_0_7_0.c,1488 :: 		out.b1=1;
	BSF         GetExternalKeysState_out_L0+0, 1 
L_GetExternalKeysState361:
;FirmV_0_7_0.c,1489 :: 		return out;
	MOVF        GetExternalKeysState_out_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1490 :: 		}
	RETURN      0
; end of _GetExternalKeysState

_GetLimitSwitchState:

;FirmV_0_7_0.c,1503 :: 		char GetLimitSwitchState()
;FirmV_0_7_0.c,1505 :: 		if((Limit1==0)||(Limit2==0))
	BTFSS       PORTD+0, 0 
	GOTO        L__GetLimitSwitchState811
	BTFSS       PORTD+0, 1 
	GOTO        L__GetLimitSwitchState811
	GOTO        L_GetLimitSwitchState364
L__GetLimitSwitchState811:
;FirmV_0_7_0.c,1506 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_GetLimitSwitchState364:
;FirmV_0_7_0.c,1508 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1509 :: 		}
	RETURN      0
; end of _GetLimitSwitchState

_GetRemoteState:

;FirmV_0_7_0.c,1518 :: 		char GetRemoteState()
;FirmV_0_7_0.c,1520 :: 		char res=0;
	CLRF        GetRemoteState_res_L0+0 
;FirmV_0_7_0.c,1521 :: 		res.b0=RemoteAFlag.b0;
	BTFSC       _RemoteAFlag+0, 0 
	GOTO        L__GetRemoteState880
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState881
L__GetRemoteState880:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState881:
;FirmV_0_7_0.c,1522 :: 		res.b1=RemoteBFlag.b0;
	BTFSC       _RemoteBFlag+0, 0 
	GOTO        L__GetRemoteState882
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState883
L__GetRemoteState882:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState883:
;FirmV_0_7_0.c,1523 :: 		RemoteAFlag=0;
	CLRF        _RemoteAFlag+0 
;FirmV_0_7_0.c,1524 :: 		RemoteBFlag=0;
	CLRF        _RemoteBFlag+0 
;FirmV_0_7_0.c,1525 :: 		res.b0=res.b0;
;FirmV_0_7_0.c,1526 :: 		res.b1=res.b1;
;FirmV_0_7_0.c,1528 :: 		if(State<20)
	MOVLW       20
	SUBWF       _State+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetRemoteState366
;FirmV_0_7_0.c,1530 :: 		res.b0=res.b0|Events.Keys.b2;//up key
	BTFSC       GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState884
	BTFSC       _Events+0, 2 
	GOTO        L__GetRemoteState884
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState885
L__GetRemoteState884:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState885:
;FirmV_0_7_0.c,1531 :: 		res.b1=res.b1|Events.Keys.b0;//down key
	BTFSC       GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState886
	BTFSC       _Events+0, 0 
	GOTO        L__GetRemoteState886
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState887
L__GetRemoteState886:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState887:
;FirmV_0_7_0.c,1532 :: 		}
L_GetRemoteState366:
;FirmV_0_7_0.c,1534 :: 		return res;
	MOVF        GetRemoteState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1535 :: 		}
	RETURN      0
; end of _GetRemoteState

_GetOverloadState:

;FirmV_0_7_0.c,1545 :: 		char GetOverloadState()
;FirmV_0_7_0.c,1547 :: 		char res=0;
	CLRF        GetOverloadState_res_L0+0 
;FirmV_0_7_0.c,1549 :: 		VCapM1=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _VCapM1+0 
	MOVF        R1, 0 
	MOVWF       _VCapM1+1 
;FirmV_0_7_0.c,1550 :: 		VCapM2=ADC_Read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _VCapM2+0 
	MOVF        R1, 0 
	MOVWF       _VCapM2+1 
;FirmV_0_7_0.c,1553 :: 		if(OverloadCheckFlag1==0)
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetOverloadState367
;FirmV_0_7_0.c,1554 :: 		OverloadCounter1=0;
	CLRF        _OverloadCounter1+0 
	CLRF        _OverloadCounter1+1 
L_GetOverloadState367:
;FirmV_0_7_0.c,1556 :: 		if(OverloadCheckFlag2==0)
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetOverloadState368
;FirmV_0_7_0.c,1557 :: 		OverloadCounter2=0;
	CLRF        _OverloadCounter2+0 
	CLRF        _OverloadCounter2+1 
L_GetOverloadState368:
;FirmV_0_7_0.c,1560 :: 		if(Motor1FullSpeed!=0)
	MOVF        _Motor1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState369
;FirmV_0_7_0.c,1564 :: 		if(VCapM1<OverloadTreshold)
	MOVF        _OverloadTreshold+1, 0 
	SUBWF       _VCapM1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState888
	MOVF        _OverloadTreshold+0, 0 
	SUBWF       _VCapM1+0, 0 
L__GetOverloadState888:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState370
;FirmV_0_7_0.c,1566 :: 		if(OverloadCounter1<65530)
	MOVLW       255
	SUBWF       _OverloadCounter1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState889
	MOVLW       250
	SUBWF       _OverloadCounter1+0, 0 
L__GetOverloadState889:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState371
;FirmV_0_7_0.c,1567 :: 		OverloadCounter1=OverloadCounter1+1;
	INFSNZ      _OverloadCounter1+0, 1 
	INCF        _OverloadCounter1+1, 1 
L_GetOverloadState371:
;FirmV_0_7_0.c,1568 :: 		}
	GOTO        L_GetOverloadState372
L_GetOverloadState370:
;FirmV_0_7_0.c,1571 :: 		if(OverloadCounter1>0)
	MOVLW       0
	MOVWF       R0 
	MOVF        _OverloadCounter1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState890
	MOVF        _OverloadCounter1+0, 0 
	SUBLW       0
L__GetOverloadState890:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState373
;FirmV_0_7_0.c,1572 :: 		OverloadCounter1=OverloadCounter1-1;
	MOVLW       1
	SUBWF       _OverloadCounter1+0, 1 
	MOVLW       0
	SUBWFB      _OverloadCounter1+1, 1 
L_GetOverloadState373:
;FirmV_0_7_0.c,1573 :: 		}
L_GetOverloadState372:
;FirmV_0_7_0.c,1574 :: 		}
	GOTO        L_GetOverloadState374
L_GetOverloadState369:
;FirmV_0_7_0.c,1576 :: 		{OverloadCounter1=0;}
	CLRF        _OverloadCounter1+0 
	CLRF        _OverloadCounter1+1 
L_GetOverloadState374:
;FirmV_0_7_0.c,1578 :: 		if (OverloadCounter1>OverloadDuration)
	MOVF        _OverloadCounter1+1, 0 
	SUBWF       _OverloadDuration+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState891
	MOVF        _OverloadCounter1+0, 0 
	SUBWF       _OverloadDuration+0, 0 
L__GetOverloadState891:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState375
;FirmV_0_7_0.c,1579 :: 		res.b0=1;
	BSF         GetOverloadState_res_L0+0, 0 
L_GetOverloadState375:
;FirmV_0_7_0.c,1584 :: 		if(Motor2FullSpeed!=0)
	MOVF        _Motor2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState376
;FirmV_0_7_0.c,1586 :: 		if(VCapM2<OverloadTreshold)
	MOVF        _OverloadTreshold+1, 0 
	SUBWF       _VCapM2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState892
	MOVF        _OverloadTreshold+0, 0 
	SUBWF       _VCapM2+0, 0 
L__GetOverloadState892:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState377
;FirmV_0_7_0.c,1588 :: 		if(OverloadCounter2<65530)
	MOVLW       255
	SUBWF       _OverloadCounter2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState893
	MOVLW       250
	SUBWF       _OverloadCounter2+0, 0 
L__GetOverloadState893:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState378
;FirmV_0_7_0.c,1589 :: 		OverloadCounter2=OverloadCounter2+1;
	INFSNZ      _OverloadCounter2+0, 1 
	INCF        _OverloadCounter2+1, 1 
L_GetOverloadState378:
;FirmV_0_7_0.c,1590 :: 		}
	GOTO        L_GetOverloadState379
L_GetOverloadState377:
;FirmV_0_7_0.c,1593 :: 		if(OverloadCounter2>0)
	MOVLW       0
	MOVWF       R0 
	MOVF        _OverloadCounter2+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState894
	MOVF        _OverloadCounter2+0, 0 
	SUBLW       0
L__GetOverloadState894:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState380
;FirmV_0_7_0.c,1594 :: 		OverloadCounter2=OverloadCounter2-1;
	MOVLW       1
	SUBWF       _OverloadCounter2+0, 1 
	MOVLW       0
	SUBWFB      _OverloadCounter2+1, 1 
L_GetOverloadState380:
;FirmV_0_7_0.c,1595 :: 		}
L_GetOverloadState379:
;FirmV_0_7_0.c,1596 :: 		}
	GOTO        L_GetOverloadState381
L_GetOverloadState376:
;FirmV_0_7_0.c,1598 :: 		{OverloadCounter2=0;}
	CLRF        _OverloadCounter2+0 
	CLRF        _OverloadCounter2+1 
L_GetOverloadState381:
;FirmV_0_7_0.c,1601 :: 		if (OverloadCounter2>OverloadDuration)
	MOVF        _OverloadCounter2+1, 0 
	SUBWF       _OverloadDuration+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState895
	MOVF        _OverloadCounter2+0, 0 
	SUBWF       _OverloadDuration+0, 0 
L__GetOverloadState895:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState382
;FirmV_0_7_0.c,1602 :: 		res.b1=1;
	BSF         GetOverloadState_res_L0+0, 1 
L_GetOverloadState382:
;FirmV_0_7_0.c,1604 :: 		return res;
	MOVF        GetOverloadState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1605 :: 		}
	RETURN      0
; end of _GetOverloadState

_GetPhotocellState:

;FirmV_0_7_0.c,1618 :: 		char GetPhotocellState()
;FirmV_0_7_0.c,1620 :: 		if(Phcell1==0)
	BTFSC       PORTD+0, 3 
	GOTO        L_GetPhotocellState383
;FirmV_0_7_0.c,1621 :: 		{if(PhotocellCount<=20)PhotocellCount=PhotocellCount+1;}
	MOVF        _PhotocellCount+0, 0 
	SUBLW       20
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState384
	INCF        _PhotocellCount+0, 1 
L_GetPhotocellState384:
	GOTO        L_GetPhotocellState385
L_GetPhotocellState383:
;FirmV_0_7_0.c,1623 :: 		{PhotocellCount=0;}
	CLRF        _PhotocellCount+0 
L_GetPhotocellState385:
;FirmV_0_7_0.c,1624 :: 		if(PhotocellCount>=20)
	MOVLW       20
	SUBWF       _PhotocellCount+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState386
;FirmV_0_7_0.c,1625 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_GetPhotocellState386:
;FirmV_0_7_0.c,1627 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1628 :: 		}
	RETURN      0
; end of _GetPhotocellState

_SetMotorSpeed:

;FirmV_0_7_0.c,1640 :: 		void SetMotorSpeed(char M1FullSpeed,char M2FullSpeed)
;FirmV_0_7_0.c,1642 :: 		if((M1FullSpeed==0)||(M2FullSpeed==0))
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed812
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed812
	GOTO        L_SetMotorSpeed390
L__SetMotorSpeed812:
;FirmV_0_7_0.c,1643 :: 		INT0E_bit=1;
	BSF         INT0E_bit+0, 4 
	GOTO        L_SetMotorSpeed391
L_SetMotorSpeed390:
;FirmV_0_7_0.c,1645 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, 4 
L_SetMotorSpeed391:
;FirmV_0_7_0.c,1647 :: 		Motor1FullSpeed=M1FullSpeed;
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	MOVWF       _Motor1FullSpeed+0 
;FirmV_0_7_0.c,1648 :: 		Motor2FullSpeed=M2FullSpeed;
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	MOVWF       _Motor2FullSpeed+0 
;FirmV_0_7_0.c,1649 :: 		}
	RETURN      0
; end of _SetMotorSpeed

_OverloadInit:

;FirmV_0_7_0.c,1660 :: 		void OverloadInit(char ch)
;FirmV_0_7_0.c,1662 :: 		if(ch==1)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit392
;FirmV_0_7_0.c,1664 :: 		OverloadCounter1=0;
	CLRF        _OverloadCounter1+0 
	CLRF        _OverloadCounter1+1 
;FirmV_0_7_0.c,1665 :: 		Events.Overload.b0=0;
	BCF         _Events+5, 0 
;FirmV_0_7_0.c,1666 :: 		}
L_OverloadInit392:
;FirmV_0_7_0.c,1668 :: 		if(ch==2)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit393
;FirmV_0_7_0.c,1670 :: 		OverloadCounter2=0;
	CLRF        _OverloadCounter2+0 
	CLRF        _OverloadCounter2+1 
;FirmV_0_7_0.c,1671 :: 		Events.Overload.b1=0;
	BCF         _Events+5, 1 
;FirmV_0_7_0.c,1672 :: 		}
L_OverloadInit393:
;FirmV_0_7_0.c,1673 :: 		}
	RETURN      0
; end of _OverloadInit

_SaveConfigs:

;FirmV_0_7_0.c,1684 :: 		void SaveConfigs()
;FirmV_0_7_0.c,1687 :: 		EEPROM_Write(1,Door1OpenTime);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1688 :: 		EEPROM_Write(2,Door2OpenTime);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1689 :: 		EEPROM_Write(3,Door1CloseTime);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1690 :: 		EEPROM_Write(4,Door2CloseTime);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1691 :: 		EEPROM_Write(5,ActionTimeDiff);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1692 :: 		EEPROM_Write(6,OpenSoftStartTime);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1693 :: 		EEPROM_Write(7,OpenSoftStopTime);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1694 :: 		EEPROM_Write(8,CloseSoftStartTime);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1695 :: 		EEPROM_Write(9,CloseSoftStopTime);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1696 :: 		EEPROM_Write(10,Hi(AutoCloseTime));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1697 :: 		EEPROM_Write(11,Lo(AutoCloseTime));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1698 :: 		EEPROM_Write(12,OverloadSens);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OverloadSens+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1699 :: 		EEPROM_Write(13,CloseAfterPass);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1700 :: 		EEPROM_Write(14,LockForce);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _LockForce+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1701 :: 		EEPROM_Write(15,OpenPhEnable);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenPhEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1702 :: 		EEPROM_Write(16,LimiterEnable);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _LimiterEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1703 :: 		EEPROM_Write(17,LockEnable);
	MOVLW       17
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _LockEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1704 :: 		EEPROM_Write(18,OverloadTime);
	MOVLW       18
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OverloadTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1705 :: 		SetOverloadParams(OverloadSens,OverloadTime);
	MOVF        _OverloadSens+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadTime+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1707 :: 		}
	RETURN      0
; end of _SaveConfigs

_LoadConfigs:

;FirmV_0_7_0.c,1720 :: 		void LoadConfigs()
;FirmV_0_7_0.c,1722 :: 		Door1OpenTime=EEPROM_Read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1723 :: 		Door2OpenTime=EEPROM_Read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1724 :: 		Door1CloseTime=EEPROM_Read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1725 :: 		Door2CloseTime=EEPROM_Read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1726 :: 		ActionTimeDiff=EEPROM_Read(5);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1727 :: 		OpenSoftStartTime=EEPROM_Read(6);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1728 :: 		OpenSoftStopTime=EEPROM_Read(7);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1729 :: 		CloseSoftStartTime=EEPROM_Read(8);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1730 :: 		CloseSoftStopTime=EEPROM_Read(9);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1731 :: 		AutoCloseTime=EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _AutoCloseTime+0 
	MOVLW       0
	MOVWF       _AutoCloseTime+1 
;FirmV_0_7_0.c,1732 :: 		AutoCloseTime=AutoCloseTime<<8;
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       _AutoCloseTime+1 
	CLRF        _AutoCloseTime+0 
;FirmV_0_7_0.c,1733 :: 		AutoCloseTime=AutocloseTime|EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	IORWF       _AutoCloseTime+0, 1 
	MOVLW       0
	IORWF       _AutoCloseTime+1, 1 
;FirmV_0_7_0.c,1734 :: 		OverloadSens=EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadSens+0 
;FirmV_0_7_0.c,1735 :: 		CloseAfterPass=EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseAfterPass+0 
;FirmV_0_7_0.c,1736 :: 		LockForce=EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockForce+0 
;FirmV_0_7_0.c,1737 :: 		OpenPhEnable=EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenPhEnable+0 
;FirmV_0_7_0.c,1738 :: 		LimiterEnable=EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LimiterEnable+0 
;FirmV_0_7_0.c,1739 :: 		LockEnable=EEPROM_Read(17);
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockEnable+0 
;FirmV_0_7_0.c,1740 :: 		OverloadTime=EEPROM_Read(18);
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadTime+0 
;FirmV_0_7_0.c,1741 :: 		SetOverloadParams(OverloadSens,OverloadTime);
	MOVF        _OverloadSens+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        R0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1743 :: 		}
	RETURN      0
; end of _LoadConfigs

_FactorySettings:

;FirmV_0_7_0.c,1756 :: 		void FactorySettings()
;FirmV_0_7_0.c,1758 :: 		Door1OpenTime=20;
	MOVLW       20
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1759 :: 		Door1CloseTime=20;
	MOVLW       20
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1760 :: 		Door2OpenTime=20;
	MOVLW       20
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1761 :: 		Door2CloseTime=20;
	MOVLW       20
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1762 :: 		OverloadSens=7;
	MOVLW       7
	MOVWF       _OverloadSens+0 
;FirmV_0_7_0.c,1763 :: 		OverloadTime=2;
	MOVLW       2
	MOVWF       _OverloadTime+0 
;FirmV_0_7_0.c,1764 :: 		SetOverloadParams(7,2);
	MOVLW       7
	MOVWF       FARG_SetOverloadParams+0 
	MOVLW       2
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1765 :: 		OpenSoftStopTime=10;
	MOVLW       10
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1766 :: 		OpenSoftStartTime=4;
	MOVLW       4
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1767 :: 		CloseSoftStopTime=10;
	MOVLW       10
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1768 :: 		CloseSoftStartTime=4;
	MOVLW       4
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1769 :: 		ActionTimeDiff=12;
	MOVLW       12
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1770 :: 		AutoCloseTime=0;
	CLRF        _AutoCloseTime+0 
	CLRF        _AutoCloseTime+1 
;FirmV_0_7_0.c,1771 :: 		LockForce=0;
	CLRF        _LockForce+0 
;FirmV_0_7_0.c,1772 :: 		OpenPhEnable=0;
	CLRF        _OpenPhEnable+0 
;FirmV_0_7_0.c,1773 :: 		LimiterEnable=0;
	CLRF        _LimiterEnable+0 
;FirmV_0_7_0.c,1774 :: 		CloseAfterPass=0;
	CLRF        _CloseAfterPass+0 
;FirmV_0_7_0.c,1775 :: 		LockEnable=1;
	MOVLW       1
	MOVWF       _LockEnable+0 
;FirmV_0_7_0.c,1777 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,1778 :: 		}
	RETURN      0
; end of _FactorySettings

_StartMotor:

;FirmV_0_7_0.c,1784 :: 		void StartMotor(char Mx,char Dir)
;FirmV_0_7_0.c,1786 :: 		if(Mx==1)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor394
;FirmV_0_7_0.c,1788 :: 		Motor1Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor896
	BCF         PORTC+0, 1 
	GOTO        L__StartMotor897
L__StartMotor896:
	BSF         PORTC+0, 1 
L__StartMotor897:
;FirmV_0_7_0.c,1789 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_StartMotor395:
	DECFSZ      R13, 1, 0
	BRA         L_StartMotor395
	DECFSZ      R12, 1, 0
	BRA         L_StartMotor395
	DECFSZ      R11, 1, 0
	BRA         L_StartMotor395
	NOP
	NOP
;FirmV_0_7_0.c,1790 :: 		Motor1Start=1;
	MOVLW       1
	MOVWF       _Motor1Start+0 
;FirmV_0_7_0.c,1791 :: 		Motor1=1;
	BSF         PORTB+0, 3 
;FirmV_0_7_0.c,1792 :: 		}
L_StartMotor394:
;FirmV_0_7_0.c,1794 :: 		if(Mx==2)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor396
;FirmV_0_7_0.c,1796 :: 		Motor2Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor898
	BCF         PORTC+0, 0 
	GOTO        L__StartMotor899
L__StartMotor898:
	BSF         PORTC+0, 0 
L__StartMotor899:
;FirmV_0_7_0.c,1797 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_StartMotor397:
	DECFSZ      R13, 1, 0
	BRA         L_StartMotor397
	DECFSZ      R12, 1, 0
	BRA         L_StartMotor397
	DECFSZ      R11, 1, 0
	BRA         L_StartMotor397
	NOP
	NOP
;FirmV_0_7_0.c,1798 :: 		Motor2Start=1;
	MOVLW       1
	MOVWF       _Motor2Start+0 
;FirmV_0_7_0.c,1799 :: 		Motor2=1;
	BSF         PORTB+0, 4 
;FirmV_0_7_0.c,1800 :: 		}
L_StartMotor396:
;FirmV_0_7_0.c,1801 :: 		}
	RETURN      0
; end of _StartMotor

_StopMotor:

;FirmV_0_7_0.c,1804 :: 		void StopMotor(char Mx)
;FirmV_0_7_0.c,1806 :: 		if(Mx==1)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor398
;FirmV_0_7_0.c,1808 :: 		Motor1Start=0;
	CLRF        _Motor1Start+0 
;FirmV_0_7_0.c,1809 :: 		Motor1=0;
	BCF         PORTB+0, 3 
;FirmV_0_7_0.c,1810 :: 		}
L_StopMotor398:
;FirmV_0_7_0.c,1812 :: 		if(Mx==2)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor399
;FirmV_0_7_0.c,1814 :: 		Motor2Start=0;
	CLRF        _Motor2Start+0 
;FirmV_0_7_0.c,1815 :: 		Motor2=0;
	BCF         PORTB+0, 4 
;FirmV_0_7_0.c,1816 :: 		}
L_StopMotor399:
;FirmV_0_7_0.c,1817 :: 		}
	RETURN      0
; end of _StopMotor

_CheckTask:

;FirmV_0_7_0.c,1829 :: 		char CheckTask(char TaskCode)
;FirmV_0_7_0.c,1831 :: 		if(Events.Task1==TaskCode)
	MOVF        _Events+1, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask400
;FirmV_0_7_0.c,1832 :: 		{Events.Task1=0; return 1;}
	CLRF        _Events+1 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask400:
;FirmV_0_7_0.c,1834 :: 		if(Events.Task2==TaskCode)
	MOVF        _Events+2, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask401
;FirmV_0_7_0.c,1835 :: 		{Events.Task2=0; return 1;}
	CLRF        _Events+2 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask401:
;FirmV_0_7_0.c,1837 :: 		if(Events.Task3==TaskCode)
	MOVF        _Events+3, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask402
;FirmV_0_7_0.c,1838 :: 		{Events.Task3=0; return 1;}
	CLRF        _Events+3 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask402:
;FirmV_0_7_0.c,1840 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1842 :: 		}
	RETURN      0
; end of _CheckTask

_ReturnAutoclose:

;FirmV_0_7_0.c,1850 :: 		char ReturnAutoclose()
;FirmV_0_7_0.c,1854 :: 		for(i=0;i<20;i++)
	CLRF        ReturnAutoclose_i_L0+0 
L_ReturnAutoclose403:
	MOVLW       20
	SUBWF       ReturnAutoclose_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ReturnAutoclose404
;FirmV_0_7_0.c,1856 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode==9))
	MOVF        ReturnAutoclose_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ReturnAutoclose408
	MOVF        ReturnAutoclose_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_ReturnAutoclose408
L__ReturnAutoclose813:
;FirmV_0_7_0.c,1857 :: 		{t=Tasks[i].Time;break;}
	MOVF        ReturnAutoclose_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       ReturnAutoclose_t_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       ReturnAutoclose_t_L0+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       ReturnAutoclose_t_L0+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       ReturnAutoclose_t_L0+3 
	GOTO        L_ReturnAutoclose404
L_ReturnAutoclose408:
;FirmV_0_7_0.c,1854 :: 		for(i=0;i<20;i++)
	INCF        ReturnAutoclose_i_L0+0, 1 
;FirmV_0_7_0.c,1858 :: 		}
	GOTO        L_ReturnAutoclose403
L_ReturnAutoclose404:
;FirmV_0_7_0.c,1860 :: 		if(i>=20) i=0;
	MOVLW       20
	SUBWF       ReturnAutoclose_i_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ReturnAutoclose409
	CLRF        ReturnAutoclose_i_L0+0 
	GOTO        L_ReturnAutoclose410
L_ReturnAutoclose409:
;FirmV_0_7_0.c,1861 :: 		else i=t-ms500;
	MOVF        _ms500+0, 0 
	SUBWF       ReturnAutoclose_t_L0+0, 0 
	MOVWF       ReturnAutoclose_i_L0+0 
L_ReturnAutoclose410:
;FirmV_0_7_0.c,1862 :: 		return i;
	MOVF        ReturnAutoclose_i_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1863 :: 		}
	RETURN      0
; end of _ReturnAutoclose

_GetAutocloseTime:

;FirmV_0_7_0.c,1873 :: 		char GetAutocloseTime()
;FirmV_0_7_0.c,1877 :: 		for(i=0;i<20;i++)
	CLRF        GetAutocloseTime_i_L0+0 
L_GetAutocloseTime411:
	MOVLW       20
	SUBWF       GetAutocloseTime_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetAutocloseTime412
;FirmV_0_7_0.c,1879 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode==9))
	MOVF        GetAutocloseTime_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetAutocloseTime416
	MOVF        GetAutocloseTime_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_GetAutocloseTime416
L__GetAutocloseTime814:
;FirmV_0_7_0.c,1880 :: 		{t=Tasks[i].Time;Tasks[i].Expired=1;break;}
	MOVF        GetAutocloseTime_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       GetAutocloseTime_t_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       GetAutocloseTime_t_L0+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       GetAutocloseTime_t_L0+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       GetAutocloseTime_t_L0+3 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	GOTO        L_GetAutocloseTime412
L_GetAutocloseTime416:
;FirmV_0_7_0.c,1877 :: 		for(i=0;i<20;i++)
	INCF        GetAutocloseTime_i_L0+0, 1 
;FirmV_0_7_0.c,1881 :: 		}
	GOTO        L_GetAutocloseTime411
L_GetAutocloseTime412:
;FirmV_0_7_0.c,1882 :: 		i=t-ms500;
	MOVF        _ms500+0, 0 
	SUBWF       GetAutocloseTime_t_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       GetAutocloseTime_i_L0+0 
;FirmV_0_7_0.c,1883 :: 		if(i>=20) i=0;
	MOVLW       20
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetAutocloseTime417
	CLRF        GetAutocloseTime_i_L0+0 
L_GetAutocloseTime417:
;FirmV_0_7_0.c,1884 :: 		return i;
	MOVF        GetAutocloseTime_i_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1885 :: 		}
	RETURN      0
; end of _GetAutocloseTime

_ClearTasks:

;FirmV_0_7_0.c,1902 :: 		void ClearTasks(char except)
;FirmV_0_7_0.c,1905 :: 		for(i=0;i<20;i++)
	CLRF        ClearTasks_i_L0+0 
L_ClearTasks418:
	MOVLW       20
	SUBWF       ClearTasks_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ClearTasks419
;FirmV_0_7_0.c,1906 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode!=except))
	MOVF        ClearTasks_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ClearTasks423
	MOVF        ClearTasks_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORWF       FARG_ClearTasks_except+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ClearTasks423
L__ClearTasks815:
;FirmV_0_7_0.c,1907 :: 		Tasks[i].Expired=1;
	MOVF        ClearTasks_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_ClearTasks423:
;FirmV_0_7_0.c,1905 :: 		for(i=0;i<20;i++)
	INCF        ClearTasks_i_L0+0, 1 
;FirmV_0_7_0.c,1907 :: 		Tasks[i].Expired=1;
	GOTO        L_ClearTasks418
L_ClearTasks419:
;FirmV_0_7_0.c,1908 :: 		}
	RETURN      0
; end of _ClearTasks

_Menu0:

;FirmV_0_7_0.c,1923 :: 		void Menu0()
;FirmV_0_7_0.c,1925 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,1926 :: 		memcpy(LCDLine2,"                ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr69_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr69_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr69_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr69_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr69_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr69_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr69_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,1928 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0424
;FirmV_0_7_0.c,1929 :: 		{memcpy(LCDLine1,"00 Learning Mode",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr70_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr70_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr70_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr70_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr70_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr70_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr70_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1930 :: 		if(LearningMode==0)memcpy(LCDLine2,"      Auto      ",16);
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0425
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr71_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr71_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr71_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr71_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr71_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr71_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr71_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0425:
;FirmV_0_7_0.c,1931 :: 		if(LearningMode==1)memcpy(LCDLine2,"     Manual     ",16);}
	MOVF        _LearningMode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0426
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr72_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr72_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr72_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr72_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr72_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr72_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr72_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0426:
L_Menu0424:
;FirmV_0_7_0.c,1933 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0427
;FirmV_0_7_0.c,1934 :: 		{memcpy(LCDLine1,"01 D1 Open Time ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr73_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr73_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr73_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr73_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr73_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr73_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr73_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1935 :: 		charValueToStr(Door1OpenTime,LCDLine2+6);}
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0427:
;FirmV_0_7_0.c,1937 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0428
;FirmV_0_7_0.c,1938 :: 		{memcpy(LCDLine1,"02 D2 Open Time ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr74_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr74_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr74_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr74_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr74_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr74_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr74_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1939 :: 		charValueToStr(Door2OpenTime,LCDLine2+6);}
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0428:
;FirmV_0_7_0.c,1941 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0429
;FirmV_0_7_0.c,1942 :: 		{memcpy(LCDLine1,"03 D1 Close Time",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr75_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr75_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr75_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr75_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr75_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr75_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr75_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1943 :: 		charValueToStr(Door1CloseTime,LCDLine2+6);}
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0429:
;FirmV_0_7_0.c,1945 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0430
;FirmV_0_7_0.c,1946 :: 		{memcpy(LCDLine1,"04 D2 Close Time",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr76_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr76_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr76_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr76_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr76_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr76_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr76_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1947 :: 		charValueToStr(Door2CloseTime,LCDLine2+6);}
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0430:
;FirmV_0_7_0.c,1949 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0431
;FirmV_0_7_0.c,1950 :: 		{memcpy(LCDLine1,"05 Op Soft Start",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr77_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr77_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr77_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr77_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr77_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr77_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr77_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1951 :: 		charValueToStr(OpenSoftStartTime,LCDLine2+6);}
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0431:
;FirmV_0_7_0.c,1953 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0432
;FirmV_0_7_0.c,1954 :: 		{memcpy(LCDLine1,"06 Op Soft Stop ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr78_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr78_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr78_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr78_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr78_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr78_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr78_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1955 :: 		charValueToStr(OpenSoftStopTime,LCDLine2+6);}
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0432:
;FirmV_0_7_0.c,1957 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0433
;FirmV_0_7_0.c,1958 :: 		{memcpy(LCDLine1,"07 Cl Soft Start",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr79_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr79_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr79_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr79_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr79_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr79_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr79_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1959 :: 		charValueToStr(CloseSoftStartTime,LCDLine2+6);}
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0433:
;FirmV_0_7_0.c,1961 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0434
;FirmV_0_7_0.c,1962 :: 		{memcpy(LCDLine1,"08 Cl Soft Stop ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr80_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr80_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr80_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr80_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr80_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr80_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr80_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1963 :: 		charValueToStr(CloseSoftStopTime,LCDLine2+6);}
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0434:
;FirmV_0_7_0.c,1965 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0435
;FirmV_0_7_0.c,1966 :: 		{memcpy(LCDLine1,"09 Overload Sens",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr81_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr81_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr81_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr81_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr81_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr81_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr81_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1967 :: 		bytetostr(OverloadSens,LCDLine2+3);if(OverloadSens>7)memcpy(LCDLine2+7,"250Kg-",6);else memcpy(LCDLine2+7,"250Kg+",6);}
	MOVF        _OverloadSens+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine2+3
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine2+3)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
	MOVF        _OverloadSens+0, 0 
	SUBLW       7
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu0436
	MOVLW       _LCDLine2+7
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+7)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       50
	MOVWF       ?lstr82_FirmV_0_7_0+0 
	MOVLW       53
	MOVWF       ?lstr82_FirmV_0_7_0+1 
	MOVLW       48
	MOVWF       ?lstr82_FirmV_0_7_0+2 
	MOVLW       75
	MOVWF       ?lstr82_FirmV_0_7_0+3 
	MOVLW       103
	MOVWF       ?lstr82_FirmV_0_7_0+4 
	MOVLW       45
	MOVWF       ?lstr82_FirmV_0_7_0+5 
	CLRF        ?lstr82_FirmV_0_7_0+6 
	MOVLW       ?lstr82_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr82_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       6
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0437
L_Menu0436:
	MOVLW       _LCDLine2+7
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+7)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       50
	MOVWF       ?lstr83_FirmV_0_7_0+0 
	MOVLW       53
	MOVWF       ?lstr83_FirmV_0_7_0+1 
	MOVLW       48
	MOVWF       ?lstr83_FirmV_0_7_0+2 
	MOVLW       75
	MOVWF       ?lstr83_FirmV_0_7_0+3 
	MOVLW       103
	MOVWF       ?lstr83_FirmV_0_7_0+4 
	MOVLW       43
	MOVWF       ?lstr83_FirmV_0_7_0+5 
	CLRF        ?lstr83_FirmV_0_7_0+6 
	MOVLW       ?lstr83_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr83_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       6
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0437:
L_Menu0435:
;FirmV_0_7_0.c,1969 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0438
;FirmV_0_7_0.c,1970 :: 		{memcpy(LCDLine1,"10 Overload Tim",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr84_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr84_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr84_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr84_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr84_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       16
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr84_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr84_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1971 :: 		charValueToStr(OverloadTime,LCDLine2+6);}
	MOVF        _OverloadTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0438:
;FirmV_0_7_0.c,1973 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0439
;FirmV_0_7_0.c,1974 :: 		{memcpy(LCDLine1,"11 Interval Time",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr85_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr85_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr85_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr85_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr85_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr85_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr85_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1975 :: 		charValueToStr(ActionTimeDiff,LCDLine2+6);}
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0439:
;FirmV_0_7_0.c,1977 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0440
;FirmV_0_7_0.c,1978 :: 		{memcpy(LCDLine1,"12 Auto-close T ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr86_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr86_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr86_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr86_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr86_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr86_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr86_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1979 :: 		intValueToStr(AutoCloseTime,LCDLine2+4);}
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_intValueToStr+0 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_intValueToStr+1 
	MOVLW       _LCDLine2+4
	MOVWF       FARG_intValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+4)
	MOVWF       FARG_intValueToStr+1 
	CALL        _intValueToStr+0, 0
L_Menu0440:
;FirmV_0_7_0.c,1981 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0441
;FirmV_0_7_0.c,1982 :: 		{memcpy(LCDLine1,"13 Factory Reset",16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr87_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr87_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr87_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr87_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr87_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr87_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr87_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_Menu0441:
;FirmV_0_7_0.c,1984 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0442
;FirmV_0_7_0.c,1985 :: 		{memcpy(LCDLine1,"14 Open Photo En",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr88_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr88_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr88_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr88_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr88_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr88_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr88_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1986 :: 		if(OpenPhEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _OpenPhEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0443
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       78
	MOVWF       ?lstr89_FirmV_0_7_0+0 
	MOVLW       111
	MOVWF       ?lstr89_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr89_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr89_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr89_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr89_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr89_FirmV_0_7_0+6 
	CLRF        ?lstr89_FirmV_0_7_0+7 
	MOVLW       ?lstr89_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr89_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0444
L_Menu0443:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       89
	MOVWF       ?lstr90_FirmV_0_7_0+0 
	MOVLW       101
	MOVWF       ?lstr90_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr90_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+6 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+7 
	CLRF        ?lstr90_FirmV_0_7_0+8 
	MOVLW       ?lstr90_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr90_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0444:
L_Menu0442:
;FirmV_0_7_0.c,1988 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0445
;FirmV_0_7_0.c,1989 :: 		{memcpy(LCDLine1,"15 Limit Enable ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr91_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr91_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr91_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr91_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr91_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr91_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr91_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1990 :: 		if(LimiterEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LimiterEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0446
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       78
	MOVWF       ?lstr92_FirmV_0_7_0+0 
	MOVLW       111
	MOVWF       ?lstr92_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr92_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr92_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr92_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr92_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr92_FirmV_0_7_0+6 
	CLRF        ?lstr92_FirmV_0_7_0+7 
	MOVLW       ?lstr92_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr92_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0447
L_Menu0446:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       89
	MOVWF       ?lstr93_FirmV_0_7_0+0 
	MOVLW       101
	MOVWF       ?lstr93_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr93_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+6 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+7 
	CLRF        ?lstr93_FirmV_0_7_0+8 
	MOVLW       ?lstr93_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr93_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0447:
L_Menu0445:
;FirmV_0_7_0.c,1992 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0448
;FirmV_0_7_0.c,1993 :: 		{memcpy(LCDLine1,"16 Lock Enable  ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr94_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr94_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr94_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr94_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr94_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr94_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr94_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1994 :: 		if(LockEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LockEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0449
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       78
	MOVWF       ?lstr95_FirmV_0_7_0+0 
	MOVLW       111
	MOVWF       ?lstr95_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr95_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr95_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr95_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr95_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr95_FirmV_0_7_0+6 
	CLRF        ?lstr95_FirmV_0_7_0+7 
	MOVLW       ?lstr95_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr95_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0450
L_Menu0449:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       89
	MOVWF       ?lstr96_FirmV_0_7_0+0 
	MOVLW       101
	MOVWF       ?lstr96_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr96_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr96_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr96_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr96_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr96_FirmV_0_7_0+6 
	MOVLW       32
	MOVWF       ?lstr96_FirmV_0_7_0+7 
	CLRF        ?lstr96_FirmV_0_7_0+8 
	MOVLW       ?lstr96_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr96_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0450:
L_Menu0448:
;FirmV_0_7_0.c,1996 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0451
;FirmV_0_7_0.c,1997 :: 		{memcpy(LCDLine1,"17 Lock Force   ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr97_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr97_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr97_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr97_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr97_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr97_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr97_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1998 :: 		if(LockForce==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0452
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       78
	MOVWF       ?lstr98_FirmV_0_7_0+0 
	MOVLW       111
	MOVWF       ?lstr98_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr98_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr98_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr98_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr98_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr98_FirmV_0_7_0+6 
	CLRF        ?lstr98_FirmV_0_7_0+7 
	MOVLW       ?lstr98_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr98_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0453
L_Menu0452:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       89
	MOVWF       ?lstr99_FirmV_0_7_0+0 
	MOVLW       101
	MOVWF       ?lstr99_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr99_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr99_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr99_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr99_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr99_FirmV_0_7_0+6 
	MOVLW       32
	MOVWF       ?lstr99_FirmV_0_7_0+7 
	CLRF        ?lstr99_FirmV_0_7_0+8 
	MOVLW       ?lstr99_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr99_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0453:
L_Menu0451:
;FirmV_0_7_0.c,2000 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0454
;FirmV_0_7_0.c,2001 :: 		{memcpy(LCDLine1,"18 Au-Cl Pass   ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr100_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr100_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr100_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr100_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr100_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr100_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr100_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2002 :: 		charValueToStr(CloseAfterPass,LCDLine2+6);}
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0454:
;FirmV_0_7_0.c,2004 :: 		if(MenuPointer==19)
	MOVF        _MenuPointer+0, 0 
	XORLW       19
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0455
;FirmV_0_7_0.c,2005 :: 		{memcpy(LCDLine1,"19 Save Changes ",16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr101_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr101_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr101_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr101_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr101_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr101_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr101_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_Menu0455:
;FirmV_0_7_0.c,2007 :: 		if(MenuPointer==20)
	MOVF        _MenuPointer+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0456
;FirmV_0_7_0.c,2008 :: 		{memcpy(LCDLine1,"20 Discard Exit ",16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr102_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr102_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr102_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr102_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr102_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr102_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr102_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_Menu0456:
;FirmV_0_7_0.c,2011 :: 		State=101;
	MOVLW       101
	MOVWF       _State+0 
;FirmV_0_7_0.c,2012 :: 		}
	RETURN      0
; end of _Menu0

_About:

;FirmV_0_7_0.c,2020 :: 		void About()
;FirmV_0_7_0.c,2022 :: 		if((Events.Keys.b1==1))
	BTFSS       _Events+0, 1 
	GOTO        L_About457
;FirmV_0_7_0.c,2023 :: 		AboutCounter=AboutCounter+1;
	INCF        _AboutCounter+0, 1 
L_About457:
;FirmV_0_7_0.c,2025 :: 		if(AboutCounter==1)
	MOVF        _AboutCounter+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_About458
;FirmV_0_7_0.c,2026 :: 		{memcpy(LCDLine1,Crypto[2],16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       _crypto+32
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(_crypto+32)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2027 :: 		memcpy(LCDLine2,Crypto[3],16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       _crypto+48
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(_crypto+48)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2028 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2029 :: 		}
L_About458:
;FirmV_0_7_0.c,2031 :: 		if(AboutCounter==2)
	MOVF        _AboutCounter+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_About459
;FirmV_0_7_0.c,2032 :: 		{memcpy(LCDLine1,Crypto[4],16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       _crypto+64
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(_crypto+64)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2033 :: 		memcpy(LCDLine2,Crypto[5],16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       _crypto+80
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(_crypto+80)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2034 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2035 :: 		}
L_About459:
;FirmV_0_7_0.c,2037 :: 		if(AboutCounter==3)
	MOVF        _AboutCounter+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_About460
;FirmV_0_7_0.c,2038 :: 		{State=100;}
	MOVLW       100
	MOVWF       _State+0 
L_About460:
;FirmV_0_7_0.c,2039 :: 		}
	RETURN      0
; end of _About

_Menu1:

;FirmV_0_7_0.c,2048 :: 		void Menu1()
;FirmV_0_7_0.c,2051 :: 		if((Events.Keys.b0==1))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu1461
;FirmV_0_7_0.c,2052 :: 		{if(MenuPointer==0){MenuPointer=20;}else{MenuPointer=MenuPointer-1;}State=100;}
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1462
	MOVLW       20
	MOVWF       _MenuPointer+0 
	GOTO        L_Menu1463
L_Menu1462:
	DECF        _MenuPointer+0, 1 
L_Menu1463:
	MOVLW       100
	MOVWF       _State+0 
L_Menu1461:
;FirmV_0_7_0.c,2054 :: 		if((Events.Keys.b2==1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu1464
;FirmV_0_7_0.c,2055 :: 		{if(MenuPointer==20){MenuPointer=0;}else{MenuPointer=MenuPointer+1;}State=100;}
	MOVF        _MenuPointer+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1465
	CLRF        _MenuPointer+0 
	GOTO        L_Menu1466
L_Menu1465:
	INCF        _MenuPointer+0, 1 
L_Menu1466:
	MOVLW       100
	MOVWF       _State+0 
L_Menu1464:
;FirmV_0_7_0.c,2057 :: 		if((Events.Keys.b1==1))
	BTFSS       _Events+0, 1 
	GOTO        L_Menu1467
;FirmV_0_7_0.c,2058 :: 		{State=102;}
	MOVLW       102
	MOVWF       _State+0 
L_Menu1467:
;FirmV_0_7_0.c,2060 :: 		if(Events.Keys==0b101)
	MOVF        _Events+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1468
;FirmV_0_7_0.c,2061 :: 		{memcpy(LCDLine1,Crypto[0],16);AboutCounter=0;memcpy(LCDLine2,Crypto[1],16);LCDLines=2;LCDUpdateFlag=1;State=250;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       _crypto+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(_crypto+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	CLRF        _AboutCounter+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       _crypto+16
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(_crypto+16)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       2
	MOVWF       _LCDLines+0 
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       250
	MOVWF       _State+0 
L_Menu1468:
;FirmV_0_7_0.c,2064 :: 		}
	RETURN      0
; end of _Menu1

_Menu2:

;FirmV_0_7_0.c,2072 :: 		void Menu2()
;FirmV_0_7_0.c,2075 :: 		LCDFlash=1;
	MOVLW       1
	MOVWF       _LCDFlash+0 
;FirmV_0_7_0.c,2077 :: 		if(Events.Keys.b1==1)
	BTFSS       _Events+0, 1 
	GOTO        L_Menu2469
;FirmV_0_7_0.c,2079 :: 		LCDFlash=0;LCDFlashFlag=0;State=101;;Menu0();
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
	MOVLW       101
	MOVWF       _State+0 
	CALL        _Menu0+0, 0
;FirmV_0_7_0.c,2080 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2470
;FirmV_0_7_0.c,2082 :: 		LearnPhase=0;
	CLRF        _LearnPhase+0 
;FirmV_0_7_0.c,2083 :: 		if(LearningMode==0)
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2471
;FirmV_0_7_0.c,2084 :: 		{State=200;LongBuzzFlag=1;}
	MOVLW       200
	MOVWF       _State+0 
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
L_Menu2471:
;FirmV_0_7_0.c,2085 :: 		if(LearningMode==1)
	MOVF        _LearningMode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2472
;FirmV_0_7_0.c,2086 :: 		{State=201;LongBuzzFlag=1;}
	MOVLW       201
	MOVWF       _State+0 
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
L_Menu2472:
;FirmV_0_7_0.c,2087 :: 		}
L_Menu2470:
;FirmV_0_7_0.c,2088 :: 		}
L_Menu2469:
;FirmV_0_7_0.c,2091 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2473
;FirmV_0_7_0.c,2092 :: 		{ if((Events.Keys.b0==1)&&(LearningMode>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2476
	MOVF        _LearningMode+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2476
L__Menu2851:
;FirmV_0_7_0.c,2093 :: 		{LearningMode=LearningMode-1;Menu0();State=102;}
	DECF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2476:
;FirmV_0_7_0.c,2094 :: 		if((Events.Keys.b2==1)&&(LearningMode<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2479
	MOVLW       1
	SUBWF       _LearningMode+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2479
L__Menu2850:
;FirmV_0_7_0.c,2095 :: 		{LearningMode=LearningMode+1;Menu0();State=102;}
	INCF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2479:
;FirmV_0_7_0.c,2096 :: 		}
L_Menu2473:
;FirmV_0_7_0.c,2100 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2480
;FirmV_0_7_0.c,2101 :: 		{ if((Events.Keys.b0==1)&&(Door1OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2483
	MOVF        _Door1OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2483
L__Menu2849:
;FirmV_0_7_0.c,2102 :: 		{Door1OpenTime=Door1OpenTime-1;Menu0();State=102;}
	DECF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2483:
;FirmV_0_7_0.c,2103 :: 		if((Events.Keys.b2==1)&&(Door1OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2486
	MOVLW       255
	SUBWF       _Door1OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2486
L__Menu2848:
;FirmV_0_7_0.c,2104 :: 		{Door1OpenTime=Door1OpenTime+1;Menu0();State=102;}
	INCF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2486:
;FirmV_0_7_0.c,2105 :: 		}
L_Menu2480:
;FirmV_0_7_0.c,2109 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2487
;FirmV_0_7_0.c,2110 :: 		{ if((Events.Keys.b0==1)&&(Door2OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2490
	MOVF        _Door2OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2490
L__Menu2847:
;FirmV_0_7_0.c,2111 :: 		{Door2OpenTime=Door2OpenTime-1;Menu0();State=102;}
	DECF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2490:
;FirmV_0_7_0.c,2112 :: 		if((Events.Keys.b2==1)&&(Door2OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2493
	MOVLW       255
	SUBWF       _Door2OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2493
L__Menu2846:
;FirmV_0_7_0.c,2113 :: 		{Door2OpenTime=Door2OpenTime+1;Menu0();State=102;}
	INCF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2493:
;FirmV_0_7_0.c,2114 :: 		}
L_Menu2487:
;FirmV_0_7_0.c,2117 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2494
;FirmV_0_7_0.c,2118 :: 		{ if((Events.Keys.b0==1)&&(Door1CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2497
	MOVF        _Door1CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2497
L__Menu2845:
;FirmV_0_7_0.c,2119 :: 		{Door1CloseTime=Door1CloseTime-1;Menu0();State=102;}
	DECF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2497:
;FirmV_0_7_0.c,2120 :: 		if((Events.Keys.b2==1)&&(Door1CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2500
	MOVLW       255
	SUBWF       _Door1CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2500
L__Menu2844:
;FirmV_0_7_0.c,2121 :: 		{Door1CloseTime=Door1CloseTime+1;Menu0();State=102;}
	INCF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2500:
;FirmV_0_7_0.c,2122 :: 		}
L_Menu2494:
;FirmV_0_7_0.c,2125 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2501
;FirmV_0_7_0.c,2126 :: 		{ if((Events.Keys.b0==1)&&(Door2CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2504
	MOVF        _Door2CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2504
L__Menu2843:
;FirmV_0_7_0.c,2127 :: 		{Door2CloseTime=Door2CloseTime-1;Menu0();State=102;}
	DECF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2504:
;FirmV_0_7_0.c,2128 :: 		if((Events.Keys.b2==1)&&(Door2CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2507
	MOVLW       255
	SUBWF       _Door2CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2507
L__Menu2842:
;FirmV_0_7_0.c,2129 :: 		{Door2CloseTime=Door2CloseTime+1;Menu0();State=102;}
	INCF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2507:
;FirmV_0_7_0.c,2130 :: 		}
L_Menu2501:
;FirmV_0_7_0.c,2134 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2508
;FirmV_0_7_0.c,2135 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2511
	MOVF        _OpenSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2511
L__Menu2841:
;FirmV_0_7_0.c,2136 :: 		{OpenSoftStartTime=OpenSoftStartTime-1;Menu0();State=102;}
	DECF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2511:
;FirmV_0_7_0.c,2137 :: 		if((Events.Keys.b2==1)&&(OpenSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2514
	MOVLW       255
	SUBWF       _OpenSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2514
L__Menu2840:
;FirmV_0_7_0.c,2138 :: 		{OpenSoftStartTime=OpenSoftStartTime+1;Menu0();State=102;}
	INCF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2514:
;FirmV_0_7_0.c,2139 :: 		}
L_Menu2508:
;FirmV_0_7_0.c,2142 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2515
;FirmV_0_7_0.c,2143 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2518
	MOVF        _OpenSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2518
L__Menu2839:
;FirmV_0_7_0.c,2144 :: 		{OpenSoftStopTime=OpenSoftStopTime-1;Menu0();State=102;}
	DECF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2518:
;FirmV_0_7_0.c,2145 :: 		if((Events.Keys.b2==1)&&(OpenSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2521
	MOVLW       255
	SUBWF       _OpenSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2521
L__Menu2838:
;FirmV_0_7_0.c,2146 :: 		{OpenSoftStopTime=OpenSoftStopTime+1;Menu0();State=102;}
	INCF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2521:
;FirmV_0_7_0.c,2147 :: 		}
L_Menu2515:
;FirmV_0_7_0.c,2150 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2522
;FirmV_0_7_0.c,2151 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2525
	MOVF        _CloseSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2525
L__Menu2837:
;FirmV_0_7_0.c,2152 :: 		{CloseSoftStartTime=CloseSoftStartTime-1;Menu0();State=102;}
	DECF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2525:
;FirmV_0_7_0.c,2153 :: 		if((Events.Keys.b2==1)&&(CloseSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2528
	MOVLW       255
	SUBWF       _CloseSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2528
L__Menu2836:
;FirmV_0_7_0.c,2154 :: 		{CloseSoftStartTime=CloseSoftStartTime+1;Menu0();State=102;}
	INCF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2528:
;FirmV_0_7_0.c,2155 :: 		}
L_Menu2522:
;FirmV_0_7_0.c,2158 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2529
;FirmV_0_7_0.c,2159 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2532
	MOVF        _CloseSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2532
L__Menu2835:
;FirmV_0_7_0.c,2160 :: 		{CloseSoftStopTime=CloseSoftStopTime-1;Menu0();State=102;}
	DECF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2532:
;FirmV_0_7_0.c,2161 :: 		if((Events.Keys.b2==1)&&(CloseSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2535
	MOVLW       255
	SUBWF       _CloseSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2535
L__Menu2834:
;FirmV_0_7_0.c,2162 :: 		{CloseSoftStopTime=CloseSoftStopTime+1;Menu0();State=102;}
	INCF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2535:
;FirmV_0_7_0.c,2163 :: 		}
L_Menu2529:
;FirmV_0_7_0.c,2167 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2536
;FirmV_0_7_0.c,2168 :: 		{ if((Events.Keys.b0==1)&&(OverloadSens>1))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2539
	MOVF        _OverloadSens+0, 0 
	SUBLW       1
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2539
L__Menu2833:
;FirmV_0_7_0.c,2169 :: 		{OverloadSens=OverloadSens-1;Menu0();State=102;}
	DECF        _OverloadSens+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2539:
;FirmV_0_7_0.c,2170 :: 		if((Events.Keys.b2==1)&&(OverloadSens<15))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2542
	MOVLW       15
	SUBWF       _OverloadSens+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2542
L__Menu2832:
;FirmV_0_7_0.c,2171 :: 		{OverloadSens=OverloadSens+1;Menu0();State=102;}
	INCF        _OverloadSens+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2542:
;FirmV_0_7_0.c,2172 :: 		}
L_Menu2536:
;FirmV_0_7_0.c,2175 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2543
;FirmV_0_7_0.c,2176 :: 		{ if((Events.Keys.b0==1)&&(OverloadTime>1))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2546
	MOVF        _OverloadTime+0, 0 
	SUBLW       1
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2546
L__Menu2831:
;FirmV_0_7_0.c,2177 :: 		{OverloadTime=OverloadTime-1;Menu0();State=102;}
	DECF        _OverloadTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2546:
;FirmV_0_7_0.c,2178 :: 		if((Events.Keys.b2==1)&&(OverloadTime<10))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2549
	MOVLW       10
	SUBWF       _OverloadTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2549
L__Menu2830:
;FirmV_0_7_0.c,2179 :: 		{OverloadTime=OverloadTime+1;Menu0();State=102;}
	INCF        _OverloadTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2549:
;FirmV_0_7_0.c,2180 :: 		}
L_Menu2543:
;FirmV_0_7_0.c,2185 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2550
;FirmV_0_7_0.c,2186 :: 		{ if((Events.Keys.b0==1)&&(ActionTimeDiff>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2553
	MOVF        _ActionTimeDiff+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2553
L__Menu2829:
;FirmV_0_7_0.c,2187 :: 		{ActionTimeDiff=ActionTimeDiff-1;Menu0();State=102;}
	DECF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2553:
;FirmV_0_7_0.c,2188 :: 		if((Events.Keys.b2==1)&&(ActionTimeDiff<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2556
	MOVLW       255
	SUBWF       _ActionTimeDiff+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2556
L__Menu2828:
;FirmV_0_7_0.c,2189 :: 		{ActionTimeDiff=ActionTimeDiff+1;Menu0();State=102;}
	INCF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2556:
;FirmV_0_7_0.c,2190 :: 		}
L_Menu2550:
;FirmV_0_7_0.c,2193 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2557
;FirmV_0_7_0.c,2194 :: 		{ if((Events.Keys.b0==1)&&(AutoCloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2560
	MOVLW       0
	MOVWF       R0 
	MOVF        _AutoCloseTime+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu2900
	MOVF        _AutoCloseTime+0, 0 
	SUBLW       0
L__Menu2900:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2560
L__Menu2827:
;FirmV_0_7_0.c,2195 :: 		{AutoCloseTime=AutoCloseTime-1;Menu0();State=102;}
	MOVLW       1
	SUBWF       _AutoCloseTime+0, 1 
	MOVLW       0
	SUBWFB      _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2560:
;FirmV_0_7_0.c,2196 :: 		if((Events.Keys.b2==1)&&(AutoCloseTime<65000))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2563
	MOVLW       253
	SUBWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu2901
	MOVLW       232
	SUBWF       _AutoCloseTime+0, 0 
L__Menu2901:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2563
L__Menu2826:
;FirmV_0_7_0.c,2197 :: 		{AutoCloseTime=AutoCloseTime+1;Menu0();State=102;}
	INFSNZ      _AutoCloseTime+0, 1 
	INCF        _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2563:
;FirmV_0_7_0.c,2198 :: 		}
L_Menu2557:
;FirmV_0_7_0.c,2201 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2564
;FirmV_0_7_0.c,2203 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2204 :: 		memcpy(LCDLine1,Sipher,16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       _Sipher+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(_Sipher+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2205 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2206 :: 		LCDFlash=0; LCDFlashFlag=0;
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,2207 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2208 :: 		LongBuzzFlag=1;
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
;FirmV_0_7_0.c,2209 :: 		FactorySettings();
	CALL        _FactorySettings+0, 0
;FirmV_0_7_0.c,2210 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2211 :: 		}
L_Menu2564:
;FirmV_0_7_0.c,2214 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2565
;FirmV_0_7_0.c,2215 :: 		{ if((Events.Keys.b0==1)&&(OpenPhEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2568
	MOVF        _OpenPhEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2568
L__Menu2825:
;FirmV_0_7_0.c,2216 :: 		{OpenPhEnable=OpenPhEnable-1;Menu0();State=102;}
	DECF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2568:
;FirmV_0_7_0.c,2217 :: 		if((Events.Keys.b2==1)&&(OpenPhEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2571
	MOVLW       1
	SUBWF       _OpenPhEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2571
L__Menu2824:
;FirmV_0_7_0.c,2218 :: 		{OpenPhEnable=OpenPhEnable+1;Menu0();State=102;}
	INCF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2571:
;FirmV_0_7_0.c,2219 :: 		}
L_Menu2565:
;FirmV_0_7_0.c,2223 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2572
;FirmV_0_7_0.c,2224 :: 		{ if((Events.Keys.b0==1)&&(LimiterEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2575
	MOVF        _LimiterEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2575
L__Menu2823:
;FirmV_0_7_0.c,2225 :: 		{LimiterEnable=LimiterEnable-1;Menu0();State=102;}
	DECF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2575:
;FirmV_0_7_0.c,2226 :: 		if((Events.Keys.b2==1)&&(LimiterEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2578
	MOVLW       1
	SUBWF       _LimiterEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2578
L__Menu2822:
;FirmV_0_7_0.c,2227 :: 		{LimiterEnable=LimiterEnable+1;Menu0();State=102;}
	INCF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2578:
;FirmV_0_7_0.c,2228 :: 		}
L_Menu2572:
;FirmV_0_7_0.c,2231 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2579
;FirmV_0_7_0.c,2232 :: 		{ if((Events.Keys.b0==1)&&(LockEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2582
	MOVF        _LockEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2582
L__Menu2821:
;FirmV_0_7_0.c,2233 :: 		{LockEnable=LockEnable-1;Menu0();State=102;}
	DECF        _LockEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2582:
;FirmV_0_7_0.c,2234 :: 		if((Events.Keys.b2==1)&&(LockEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2585
	MOVLW       1
	SUBWF       _LockEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2585
L__Menu2820:
;FirmV_0_7_0.c,2235 :: 		{LockEnable=LockEnable+1;Menu0();State=102;}
	INCF        _LockEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2585:
;FirmV_0_7_0.c,2236 :: 		}
L_Menu2579:
;FirmV_0_7_0.c,2239 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2586
;FirmV_0_7_0.c,2240 :: 		{ if((Events.Keys.b0==1)&&(LockForce>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2589
	MOVF        _LockForce+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2589
L__Menu2819:
;FirmV_0_7_0.c,2241 :: 		{LockForce=LockForce-1;Menu0();State=102;}
	DECF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2589:
;FirmV_0_7_0.c,2242 :: 		if((Events.Keys.b2==1)&&(LockForce<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2592
	MOVLW       1
	SUBWF       _LockForce+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2592
L__Menu2818:
;FirmV_0_7_0.c,2243 :: 		{LockForce=LockForce+1;Menu0();State=102;}
	INCF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2592:
;FirmV_0_7_0.c,2244 :: 		}
L_Menu2586:
;FirmV_0_7_0.c,2247 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2593
;FirmV_0_7_0.c,2248 :: 		{ if((Events.Keys.b0==1)&&(CloseAfterPass>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2596
	MOVF        _CloseAfterPass+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2596
L__Menu2817:
;FirmV_0_7_0.c,2249 :: 		{CloseAfterPass=CloseAfterPass-1;if(CloseAfterPass==9) CloseAfterPass=0;Menu0();State=102;}
	DECF        _CloseAfterPass+0, 1 
	MOVF        _CloseAfterPass+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2597
	CLRF        _CloseAfterPass+0 
L_Menu2597:
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2596:
;FirmV_0_7_0.c,2250 :: 		if((Events.Keys.b2==1)&&(CloseAfterPass<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2600
	MOVLW       255
	SUBWF       _CloseAfterPass+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2600
L__Menu2816:
;FirmV_0_7_0.c,2251 :: 		{CloseAfterPass=CloseAfterPass+1;if(CloseAfterPass==1) CloseAfterPass=10;Menu0();State=102;}
	INCF        _CloseAfterPass+0, 1 
	MOVF        _CloseAfterPass+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2601
	MOVLW       10
	MOVWF       _CloseAfterPass+0 
L_Menu2601:
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2600:
;FirmV_0_7_0.c,2252 :: 		}
L_Menu2593:
;FirmV_0_7_0.c,2255 :: 		if(MenuPointer==19)
	MOVF        _MenuPointer+0, 0 
	XORLW       19
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2602
;FirmV_0_7_0.c,2257 :: 		State=103;
	MOVLW       103
	MOVWF       _State+0 
;FirmV_0_7_0.c,2258 :: 		memcpy(LCDLine1,Sipher,16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       _Sipher+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(_Sipher+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2259 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2260 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2261 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2262 :: 		LongBuzzFlag=1;
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
;FirmV_0_7_0.c,2263 :: 		}
L_Menu2602:
;FirmV_0_7_0.c,2266 :: 		if(MenuPointer==20)
	MOVF        _MenuPointer+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2603
;FirmV_0_7_0.c,2268 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2269 :: 		memcpy(LCDLine1,Sipher,16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       _Sipher+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(_Sipher+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2270 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2271 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2272 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2273 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,2274 :: 		LongBuzzFlag=1;
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
;FirmV_0_7_0.c,2275 :: 		}
L_Menu2603:
;FirmV_0_7_0.c,2276 :: 		}
	RETURN      0
; end of _Menu2

_Menu3:

;FirmV_0_7_0.c,2288 :: 		void Menu3()
;FirmV_0_7_0.c,2290 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2291 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2292 :: 		}
	RETURN      0
; end of _Menu3

_LearnAuto:

;FirmV_0_7_0.c,2306 :: 		void LearnAuto()
;FirmV_0_7_0.c,2312 :: 		switch(LearnPhase)
	GOTO        L_LearnAuto604
;FirmV_0_7_0.c,2314 :: 		case 0:
L_LearnAuto606:
;FirmV_0_7_0.c,2315 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,2317 :: 		if(Events.Remote.b0==1) {DoorNo=2; LearnPhase=LearnPhase+1;BuzzFlag=1;} if(Events.Remote.b1==1) {DoorNo=1;LearnPhase=3;BuzzFlag=1;}
	BTFSS       _Events+4, 0 
	GOTO        L_LearnAuto607
	MOVLW       2
	MOVWF       LearnAuto_DoorNo_L0+0 
	INCF        _LearnPhase+0, 1 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnAuto607:
	BTFSS       _Events+4, 1 
	GOTO        L_LearnAuto608
	MOVLW       1
	MOVWF       LearnAuto_DoorNo_L0+0 
	MOVLW       3
	MOVWF       _LearnPhase+0 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnAuto608:
;FirmV_0_7_0.c,2318 :: 		OverloadCheckFlag1=0;OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,2319 :: 		break;
	GOTO        L_LearnAuto605
;FirmV_0_7_0.c,2321 :: 		case 1: //Start D2 and enable overload sensing after 3s
L_LearnAuto609:
;FirmV_0_7_0.c,2322 :: 		StartMotor(2,_Close);AddTask(ms500+6,21);LearnPhase=LearnPhase+1;
	MOVLW       2
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       6
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       21
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
;FirmV_0_7_0.c,2323 :: 		break;
	GOTO        L_LearnAuto605
;FirmV_0_7_0.c,2325 :: 		case 2: //Check if D2 reaches end of its course
L_LearnAuto610:
;FirmV_0_7_0.c,2326 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto613
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto613
L__LearnAuto857:
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnAuto613:
;FirmV_0_7_0.c,2327 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto614
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnAuto614:
;FirmV_0_7_0.c,2328 :: 		break;
	GOTO        L_LearnAuto605
;FirmV_0_7_0.c,2330 :: 		case 3: //Start D1 and enable overload sensin after 3 s
L_LearnAuto615:
;FirmV_0_7_0.c,2331 :: 		StartMotor(1,_Close);AddTask(ms500+6,20);LearnPhase=LearnPhase+1;;
	MOVLW       1
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       6
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       20
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
;FirmV_0_7_0.c,2333 :: 		case 4: //Check if D1 reaches end of its course
L_LearnAuto616:
;FirmV_0_7_0.c,2334 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto619
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto619
L__LearnAuto856:
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnAuto619:
;FirmV_0_7_0.c,2335 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto620
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto620:
;FirmV_0_7_0.c,2336 :: 		break;
	GOTO        L_LearnAuto605
;FirmV_0_7_0.c,2338 :: 		case 5: //Start D1 for opening and save start time and enable overload sensing after 3s
L_LearnAuto621:
;FirmV_0_7_0.c,2339 :: 		startT=ms500;StartMotor(1,_Open);AddTask(ms500+6,20);LearnPhase=LearnPhase+1;
	MOVF        _ms500+0, 0 
	MOVWF       LearnAuto_startT_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnAuto_startT_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnAuto_startT_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnAuto_startT_L0+3 
	MOVLW       1
	MOVWF       FARG_StartMotor_Mx+0 
	MOVLW       1
	MOVWF       FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       6
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       20
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
;FirmV_0_7_0.c,2340 :: 		break;
	GOTO        L_LearnAuto605
;FirmV_0_7_0.c,2342 :: 		case 6: //Check if D1 reaches end of its course and save the stop time
L_LearnAuto622:
;FirmV_0_7_0.c,2343 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);if(DoorNo==1)LearnPhase=11;else LearnPhase=LearnPhase+1;stopT=ms500;RawData.D1OpenTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto625
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto625
L__LearnAuto855:
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	MOVF        LearnAuto_DoorNo_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto626
	MOVLW       11
	MOVWF       _LearnPhase+0 
	GOTO        L_LearnAuto627
L_LearnAuto626:
	INCF        _LearnPhase+0, 1 
L_LearnAuto627:
	MOVF        LearnAuto_startT_L0+0, 0 
	SUBWF       _ms500+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnAuto_RawData_L0+1 
L_LearnAuto625:
;FirmV_0_7_0.c,2344 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto628
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto628:
;FirmV_0_7_0.c,2345 :: 		break;
	GOTO        L_LearnAuto605
;FirmV_0_7_0.c,2347 :: 		case 7: //Start D2 for opening and save start time and enable overload sensing after 3s
L_LearnAuto629:
;FirmV_0_7_0.c,2348 :: 		startT=ms500;StartMotor(2,_Open);AddTask(ms500+6,21);LearnPhase=LearnPhase+1;
	MOVF        _ms500+0, 0 
	MOVWF       LearnAuto_startT_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnAuto_startT_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnAuto_startT_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnAuto_startT_L0+3 
	MOVLW       2
	MOVWF       FARG_StartMotor_Mx+0 
	MOVLW       1
	MOVWF       FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       6
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       21
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
;FirmV_0_7_0.c,2349 :: 		break;
	GOTO        L_LearnAuto605
;FirmV_0_7_0.c,2351 :: 		case 8: //Check if D2 reaches end of its course and save the stop time
L_LearnAuto630:
;FirmV_0_7_0.c,2352 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D2OpenTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto633
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto633
L__LearnAuto854:
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
	MOVF        LearnAuto_startT_L0+0, 0 
	SUBWF       _ms500+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnAuto_RawData_L0+3 
L_LearnAuto633:
;FirmV_0_7_0.c,2353 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto634
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnAuto634:
;FirmV_0_7_0.c,2354 :: 		break;
	GOTO        L_LearnAuto605
;FirmV_0_7_0.c,2356 :: 		case 9: //Start D2 for closing and save start time and enable overload sensing after 6s
L_LearnAuto635:
;FirmV_0_7_0.c,2357 :: 		startT=ms500;StartMotor(2,_Close);AddTask(ms500+6,21);LearnPhase=LearnPhase+1;
	MOVF        _ms500+0, 0 
	MOVWF       LearnAuto_startT_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnAuto_startT_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnAuto_startT_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnAuto_startT_L0+3 
	MOVLW       2
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       6
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       21
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
;FirmV_0_7_0.c,2358 :: 		break;
	GOTO        L_LearnAuto605
;FirmV_0_7_0.c,2360 :: 		case 10: //Check if D2 reaches end of its course and save the stop time
L_LearnAuto636:
;FirmV_0_7_0.c,2361 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D2CloseTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto639
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto639
L__LearnAuto853:
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
	MOVF        LearnAuto_startT_L0+0, 0 
	SUBWF       _ms500+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnAuto_RawData_L0+2 
L_LearnAuto639:
;FirmV_0_7_0.c,2362 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto640
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnAuto640:
;FirmV_0_7_0.c,2363 :: 		break;
	GOTO        L_LearnAuto605
;FirmV_0_7_0.c,2365 :: 		case 11: //Start D1 for closing and save start time and enable overload sensing after 3s
L_LearnAuto641:
;FirmV_0_7_0.c,2366 :: 		startT=ms500;StartMotor(1,_Close);AddTask(ms500+6,20);LearnPhase=LearnPhase+1;
	MOVF        _ms500+0, 0 
	MOVWF       LearnAuto_startT_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnAuto_startT_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnAuto_startT_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnAuto_startT_L0+3 
	MOVLW       1
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       6
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       20
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
;FirmV_0_7_0.c,2367 :: 		break;
	GOTO        L_LearnAuto605
;FirmV_0_7_0.c,2369 :: 		case 12: //Check if D1 reaches end of its course and save the stop time
L_LearnAuto642:
;FirmV_0_7_0.c,2370 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D1CloseTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto645
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto645
L__LearnAuto852:
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
	MOVF        LearnAuto_startT_L0+0, 0 
	SUBWF       _ms500+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnAuto_RawData_L0+0 
L_LearnAuto645:
;FirmV_0_7_0.c,2371 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto646
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto646:
;FirmV_0_7_0.c,2372 :: 		break;
	GOTO        L_LearnAuto605
;FirmV_0_7_0.c,2374 :: 		case 13:
L_LearnAuto647:
;FirmV_0_7_0.c,2375 :: 		AutoLearnCalculator(&RawData);
	MOVLW       LearnAuto_RawData_L0+0
	MOVWF       FARG_AutoLearnCalculator+0 
	MOVLW       hi_addr(LearnAuto_RawData_L0+0)
	MOVWF       FARG_AutoLearnCalculator+1 
	CALL        _AutoLearnCalculator+0, 0
;FirmV_0_7_0.c,2376 :: 		SaveLearnData(&RawData,DoorNo);
	MOVLW       LearnAuto_RawData_L0+0
	MOVWF       FARG_SaveLearnData+0 
	MOVLW       hi_addr(LearnAuto_RawData_L0+0)
	MOVWF       FARG_SaveLearnData+1 
	MOVF        LearnAuto_DoorNo_L0+0, 0 
	MOVWF       FARG_SaveLearnData+0 
	CALL        _SaveLearnData+0, 0
;FirmV_0_7_0.c,2377 :: 		memcpy(LCDLine1," Learn Complete ",16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr103_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr103_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr103_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr103_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr103_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr103_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr103_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2378 :: 		memcpy(LCDLine2,"     Ready      ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr104_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr104_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr104_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr104_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr104_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr104_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr104_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2379 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2380 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2381 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,2383 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2384 :: 		break;
	GOTO        L_LearnAuto605
;FirmV_0_7_0.c,2387 :: 		}
L_LearnAuto604:
	MOVF        _LearnPhase+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto606
	MOVF        _LearnPhase+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto609
	MOVF        _LearnPhase+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto610
	MOVF        _LearnPhase+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto615
	MOVF        _LearnPhase+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto616
	MOVF        _LearnPhase+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto621
	MOVF        _LearnPhase+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto622
	MOVF        _LearnPhase+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto629
	MOVF        _LearnPhase+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto630
	MOVF        _LearnPhase+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto635
	MOVF        _LearnPhase+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto636
	MOVF        _LearnPhase+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto641
	MOVF        _LearnPhase+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto642
	MOVF        _LearnPhase+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto647
L_LearnAuto605:
;FirmV_0_7_0.c,2391 :: 		}
	RETURN      0
; end of _LearnAuto

_AutoLearnCalculator:

;FirmV_0_7_0.c,2411 :: 		void AutoLearnCalculator(Learn *raw)
;FirmV_0_7_0.c,2414 :: 		(*raw).D1OpenTime=(*raw).D1OpenTime+10;
	MOVLW       1
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       R2 
	MOVFF       R1, FSR0L
	MOVFF       R2, FSR0H
	MOVLW       10
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1L
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2415 :: 		(*raw).D2OpenTime=(*raw).D2OpenTime+10;
	MOVLW       3
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       R2 
	MOVFF       R1, FSR0L
	MOVFF       R2, FSR0H
	MOVLW       10
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1L
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2416 :: 		(*raw).D1CloseTime=(*raw).D1CloseTime+10;
	MOVFF       FARG_AutoLearnCalculator_raw+0, FSR0L
	MOVFF       FARG_AutoLearnCalculator_raw+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       FARG_AutoLearnCalculator_raw+0, FSR1L
	MOVFF       FARG_AutoLearnCalculator_raw+1, FSR1H
	MOVLW       10
	ADDWF       R0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2417 :: 		(*raw).D2CloseTime=(*raw).D2CloseTime+10;
	MOVLW       2
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       R2 
	MOVFF       R1, FSR0L
	MOVFF       R2, FSR0H
	MOVLW       10
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1L
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2419 :: 		(*raw).D1OpenSoftStart=4;
	MOVLW       4
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2420 :: 		(*raw).D1CloseSoftStart=4;
	MOVLW       6
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2421 :: 		(*raw).D2OpenSoftStart=4;
	MOVLW       8
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2422 :: 		(*raw).D2CloseSoftStart=4;
	MOVLW       10
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2424 :: 		(*raw).D1OpenSoftStop=10;
	MOVLW       5
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2425 :: 		(*raw).D2OpenSoftStop=10;
	MOVLW       9
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2426 :: 		(*raw).D1CloseSoftStop=10;
	MOVLW       7
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2427 :: 		(*raw).D2CloseSoftStop=10;
	MOVLW       11
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2429 :: 		}
	RETURN      0
; end of _AutoLearnCalculator

_SaveLearnData:

;FirmV_0_7_0.c,2441 :: 		void SaveLearnData(Learn *d,char DCount)
;FirmV_0_7_0.c,2443 :: 		Door1OpenTime=(*d).D1OpenTime;
	MOVLW       1
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,2444 :: 		Door1CloseTime=(*d).D1CloseTime;
	MOVFF       FARG_SaveLearnData_d+0, FSR0L
	MOVFF       FARG_SaveLearnData_d+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,2445 :: 		if(DCount==2)
	MOVF        FARG_SaveLearnData_DCount+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SaveLearnData648
;FirmV_0_7_0.c,2447 :: 		Door2OpenTime=(*d).D2OpenTime;
	MOVLW       3
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,2448 :: 		Door2CloseTime=(*d).D2CloseTime;
	MOVLW       2
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,2449 :: 		OpenSoftStartTime=((*d).D1OpenSoftStart+(*d).D2OpenSoftStart)/2;
	MOVLW       4
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVLW       8
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR2L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	ADDWFC      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,2450 :: 		OpenSoftStopTime=((*d).D1OpenSoftStop+(*d).D2OpenSoftStop)/2;
	MOVLW       5
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVLW       9
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR2L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	ADDWFC      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,2451 :: 		CloseSoftStartTime=((*d).D1CloseSoftStart+(*d).D2CloseSoftStart)/2;
	MOVLW       6
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVLW       10
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR2L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	ADDWFC      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,2452 :: 		CloseSoftStopTime=((*d).D1CloseSoftStop+(*d).D2CloseSoftStop)/2;
	MOVLW       7
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVLW       11
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR2L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	ADDWFC      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,2453 :: 		}
	GOTO        L_SaveLearnData649
L_SaveLearnData648:
;FirmV_0_7_0.c,2456 :: 		Door2OpenTime=0;
	CLRF        _Door2OpenTime+0 
;FirmV_0_7_0.c,2457 :: 		Door2CloseTime=0;
	CLRF        _Door2CloseTime+0 
;FirmV_0_7_0.c,2458 :: 		OpenSoftStartTime=(*d).D1OpenSoftStart;
	MOVLW       4
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,2459 :: 		OpenSoftStopTime=(*d).D1OpenSoftStop;
	MOVLW       5
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,2460 :: 		CloseSoftStartTime=(*d).D1CloseSoftStart;
	MOVLW       6
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,2461 :: 		CloseSoftStopTime=(*d).D1CloseSoftStop;
	MOVLW       7
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,2462 :: 		}
L_SaveLearnData649:
;FirmV_0_7_0.c,2464 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2465 :: 		}
	RETURN      0
; end of _SaveLearnData

_LearnManual:

;FirmV_0_7_0.c,2480 :: 		void LearnManual()
;FirmV_0_7_0.c,2488 :: 		switch(LearnPhase)
	GOTO        L_LearnManual650
;FirmV_0_7_0.c,2490 :: 		case 0:
L_LearnManual652:
;FirmV_0_7_0.c,2491 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,2493 :: 		if(Events.Remote.b0==1){LearnPhase=LearnPhase+1; DoorNo=2;BuzzFlag=1;}if(Events.Remote.b1==1){LearnPhase=3; DoorNo=1;BuzzFlag=1;}
	BTFSS       _Events+4, 0 
	GOTO        L_LearnManual653
	INCF        _LearnPhase+0, 1 
	MOVLW       2
	MOVWF       LearnManual_DoorNo_L0+0 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnManual653:
	BTFSS       _Events+4, 1 
	GOTO        L_LearnManual654
	MOVLW       3
	MOVWF       _LearnPhase+0 
	MOVLW       1
	MOVWF       LearnManual_DoorNo_L0+0 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnManual654:
;FirmV_0_7_0.c,2494 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2496 :: 		case 1: //Start D2 and enable overload sensing after 1s
L_LearnManual655:
;FirmV_0_7_0.c,2497 :: 		StartMotor(2,_Close);AddTask(ms500+4,21);LearnPhase=LearnPhase+1;OverloadCheckFlag2=0;
	MOVLW       2
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       4
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       21
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,2498 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2500 :: 		case 2: //Check if D2 reaches end of its course
L_LearnManual656:
;FirmV_0_7_0.c,2501 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnManual659
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnManual659
L__LearnManual859:
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnManual659:
;FirmV_0_7_0.c,2502 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual660
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnManual660:
;FirmV_0_7_0.c,2503 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2505 :: 		case 3: //Start D1 and enable overload sensin after 1 s
L_LearnManual661:
;FirmV_0_7_0.c,2506 :: 		StartMotor(1,_Close);AddTask(ms500+4,20);LearnPhase=LearnPhase+1;;OverloadCheckFlag1=0;
	MOVLW       1
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       4
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       20
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,2508 :: 		case 4: //Check if D1 reaches end of its course
L_LearnManual662:
;FirmV_0_7_0.c,2509 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnManual665
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnManual665
L__LearnManual858:
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnManual665:
;FirmV_0_7_0.c,2510 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual666
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnManual666:
;FirmV_0_7_0.c,2511 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2513 :: 		case 5: //Wait for remote to start D1 and slow down
L_LearnManual667:
;FirmV_0_7_0.c,2514 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(1,_Open);SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual668
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t1_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t1_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t1_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t1_L0+3 
	MOVLW       1
	MOVWF       FARG_StartMotor_Mx+0 
	MOVLW       1
	MOVWF       FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	CLRF        FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
	INCF        _LearnPhase+0, 1 
L_LearnManual668:
;FirmV_0_7_0.c,2515 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2517 :: 		case 6: //check for Remote press and fast up
L_LearnManual669:
;FirmV_0_7_0.c,2518 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(1,Motor2FullSpeed);M1isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual670
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t2_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t2_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t2_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t2_L0+3 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
L_LearnManual670:
;FirmV_0_7_0.c,2519 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2521 :: 		case 7: //check for Remote press and slow down
L_LearnManual671:
;FirmV_0_7_0.c,2522 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual672
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t3_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t3_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t3_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t3_L0+3 
	CLRF        FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
L_LearnManual672:
;FirmV_0_7_0.c,2523 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2525 :: 		case 8: //check for Remote press and stop
L_LearnManual673:
;FirmV_0_7_0.c,2526 :: 		if(Events.Remote!=0){if(DoorNo==2)LearnPhase=LearnPhase+1;else LearnPhase=17;t4=ms500;StopMotor(1);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual674
	MOVF        LearnManual_DoorNo_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnManual675
	INCF        _LearnPhase+0, 1 
	GOTO        L_LearnManual676
L_LearnManual675:
	MOVLW       17
	MOVWF       _LearnPhase+0 
L_LearnManual676:
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t4_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t4_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t4_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t4_L0+3 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,2527 :: 		RawData.D1OpenTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+1 
;FirmV_0_7_0.c,2528 :: 		RawData.D1OpenSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+4 
;FirmV_0_7_0.c,2529 :: 		RawData.D1OpenSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+5 
;FirmV_0_7_0.c,2530 :: 		}
L_LearnManual674:
;FirmV_0_7_0.c,2531 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2533 :: 		case 9: //Wait for remote to start D2 and slow down
L_LearnManual677:
;FirmV_0_7_0.c,2534 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(2,_Open);SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual678
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t1_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t1_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t1_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t1_L0+3 
	MOVLW       2
	MOVWF       FARG_StartMotor_Mx+0 
	MOVLW       1
	MOVWF       FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	CLRF        FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	INCF        _LearnPhase+0, 1 
L_LearnManual678:
;FirmV_0_7_0.c,2535 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2537 :: 		case 10: //check for Remote press and fast up
L_LearnManual679:
;FirmV_0_7_0.c,2538 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(Motor1FullSpeed,1);M2isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual680
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t2_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t2_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t2_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t2_L0+3 
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
L_LearnManual680:
;FirmV_0_7_0.c,2539 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2541 :: 		case 11: //check for Remote press and slow down
L_LearnManual681:
;FirmV_0_7_0.c,2542 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual682
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t3_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t3_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t3_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t3_L0+3 
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	CLRF        FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
L_LearnManual682:
;FirmV_0_7_0.c,2543 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2545 :: 		case 12: //check for Remote press and stop
L_LearnManual683:
;FirmV_0_7_0.c,2546 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(2);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual684
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t4_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t4_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t4_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t4_L0+3 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,2547 :: 		RawData.D2OpenTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+3 
;FirmV_0_7_0.c,2548 :: 		RawData.D2OpenSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+8 
;FirmV_0_7_0.c,2549 :: 		RawData.D2OpenSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+9 
;FirmV_0_7_0.c,2550 :: 		}
L_LearnManual684:
;FirmV_0_7_0.c,2551 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2553 :: 		case 13: //Wait for remote to start D2 and slow down
L_LearnManual685:
;FirmV_0_7_0.c,2554 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(2,_Close);SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual686
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t1_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t1_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t1_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t1_L0+3 
	MOVLW       2
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	CLRF        FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	INCF        _LearnPhase+0, 1 
L_LearnManual686:
;FirmV_0_7_0.c,2555 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2557 :: 		case 14: //check for Remote press and fast up
L_LearnManual687:
;FirmV_0_7_0.c,2558 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(Motor1FullSpeed,1);M2isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual688
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t2_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t2_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t2_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t2_L0+3 
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
L_LearnManual688:
;FirmV_0_7_0.c,2559 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2561 :: 		case 15: //check for Remote press and slow down
L_LearnManual689:
;FirmV_0_7_0.c,2562 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual690
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t3_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t3_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t3_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t3_L0+3 
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	CLRF        FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
L_LearnManual690:
;FirmV_0_7_0.c,2563 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2565 :: 		case 16: //check for Remote press and stop
L_LearnManual691:
;FirmV_0_7_0.c,2566 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(2);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual692
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t4_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t4_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t4_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t4_L0+3 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,2567 :: 		RawData.D2CloseTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+2 
;FirmV_0_7_0.c,2568 :: 		RawData.D2CloseSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+10 
;FirmV_0_7_0.c,2569 :: 		RawData.D2CloseSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+11 
;FirmV_0_7_0.c,2570 :: 		}
L_LearnManual692:
;FirmV_0_7_0.c,2571 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2573 :: 		case 17: //Wait for remote to start D1 and slow down
L_LearnManual693:
;FirmV_0_7_0.c,2574 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(1,_Close);SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual694
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t1_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t1_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t1_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t1_L0+3 
	MOVLW       1
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	CLRF        FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
	INCF        _LearnPhase+0, 1 
L_LearnManual694:
;FirmV_0_7_0.c,2575 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2577 :: 		case 18: //check for Remote press and fast up
L_LearnManual695:
;FirmV_0_7_0.c,2578 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(1,Motor2FullSpeed);M1isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual696
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t2_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t2_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t2_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t2_L0+3 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
L_LearnManual696:
;FirmV_0_7_0.c,2579 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2581 :: 		case 19: //check for Remote press and slow down
L_LearnManual697:
;FirmV_0_7_0.c,2582 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual698
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t3_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t3_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t3_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t3_L0+3 
	CLRF        FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
L_LearnManual698:
;FirmV_0_7_0.c,2583 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2585 :: 		case 20: //check for Remote press and stop
L_LearnManual699:
;FirmV_0_7_0.c,2586 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(1);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual700
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t4_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t4_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t4_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t4_L0+3 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,2587 :: 		RawData.D1CloseTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+0 
;FirmV_0_7_0.c,2588 :: 		RawData.D1CloseSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+6 
;FirmV_0_7_0.c,2589 :: 		RawData.D1CloseSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+7 
;FirmV_0_7_0.c,2590 :: 		}
L_LearnManual700:
;FirmV_0_7_0.c,2591 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2593 :: 		case 21:
L_LearnManual701:
;FirmV_0_7_0.c,2594 :: 		SaveLearnData(&RawData,DoorNo);
	MOVLW       LearnManual_RawData_L0+0
	MOVWF       FARG_SaveLearnData_d+0 
	MOVLW       hi_addr(LearnManual_RawData_L0+0)
	MOVWF       FARG_SaveLearnData_d+1 
	MOVF        LearnManual_DoorNo_L0+0, 0 
	MOVWF       FARG_SaveLearnData_DCount+0 
	CALL        _SaveLearnData+0, 0
;FirmV_0_7_0.c,2595 :: 		memcpy(LCDLine1," Learn Complete ",16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr105_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr105_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr105_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr105_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr105_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr105_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr105_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2596 :: 		memcpy(LCDLine2,"     Ready      ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr106_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr106_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr106_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr106_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr106_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr106_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr106_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2597 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2598 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2599 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,2601 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2602 :: 		break;
	GOTO        L_LearnManual651
;FirmV_0_7_0.c,2603 :: 		}
L_LearnManual650:
	MOVF        _LearnPhase+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual652
	MOVF        _LearnPhase+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual655
	MOVF        _LearnPhase+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual656
	MOVF        _LearnPhase+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual661
	MOVF        _LearnPhase+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual662
	MOVF        _LearnPhase+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual667
	MOVF        _LearnPhase+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual669
	MOVF        _LearnPhase+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual671
	MOVF        _LearnPhase+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual673
	MOVF        _LearnPhase+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual677
	MOVF        _LearnPhase+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual679
	MOVF        _LearnPhase+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual681
	MOVF        _LearnPhase+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual683
	MOVF        _LearnPhase+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual685
	MOVF        _LearnPhase+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual687
	MOVF        _LearnPhase+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual689
	MOVF        _LearnPhase+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual691
	MOVF        _LearnPhase+0, 0 
	XORLW       17
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual693
	MOVF        _LearnPhase+0, 0 
	XORLW       18
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual695
	MOVF        _LearnPhase+0, 0 
	XORLW       19
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual697
	MOVF        _LearnPhase+0, 0 
	XORLW       20
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual699
	MOVF        _LearnPhase+0, 0 
	XORLW       21
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual701
L_LearnManual651:
;FirmV_0_7_0.c,2604 :: 		}
	RETURN      0
; end of _LearnManual

_charValueToStr:

;FirmV_0_7_0.c,2625 :: 		void charValueToStr(char val, char * string)
;FirmV_0_7_0.c,2627 :: 		bytetostr(val>>1,string);
	MOVF        FARG_charValueToStr_val+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVF        FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_ByteToStr_output+0 
	MOVF        FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,2628 :: 		if((val%2)==1)
	MOVLW       1
	ANDWF       FARG_charValueToStr_val+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_charValueToStr702
;FirmV_0_7_0.c,2629 :: 		memcpy(string+3,".5s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       46
	MOVWF       ?lstr107_FirmV_0_7_0+0 
	MOVLW       53
	MOVWF       ?lstr107_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr107_FirmV_0_7_0+2 
	CLRF        ?lstr107_FirmV_0_7_0+3 
	MOVLW       ?lstr107_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr107_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_charValueToStr703
L_charValueToStr702:
;FirmV_0_7_0.c,2631 :: 		memcpy(string+3,".0s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       46
	MOVWF       ?lstr108_FirmV_0_7_0+0 
	MOVLW       48
	MOVWF       ?lstr108_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr108_FirmV_0_7_0+2 
	CLRF        ?lstr108_FirmV_0_7_0+3 
	MOVLW       ?lstr108_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr108_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_charValueToStr703:
;FirmV_0_7_0.c,2632 :: 		}
	RETURN      0
; end of _charValueToStr

_charValueToStr_AC:

;FirmV_0_7_0.c,2641 :: 		void charValueToStr_AC(char val, char * string)
;FirmV_0_7_0.c,2643 :: 		bytetostr(val>>1,string);
	MOVF        FARG_charValueToStr_AC_val+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVF        FARG_charValueToStr_AC_string+0, 0 
	MOVWF       FARG_ByteToStr_output+0 
	MOVF        FARG_charValueToStr_AC_string+1, 0 
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,2644 :: 		memcpy(string+3,"s  ",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_AC_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_AC_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       115
	MOVWF       ?lstr109_FirmV_0_7_0+0 
	MOVLW       32
	MOVWF       ?lstr109_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr109_FirmV_0_7_0+2 
	CLRF        ?lstr109_FirmV_0_7_0+3 
	MOVLW       ?lstr109_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr109_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2645 :: 		}
	RETURN      0
; end of _charValueToStr_AC

_intValueToStr:

;FirmV_0_7_0.c,2658 :: 		void intValueToStr(unsigned val, char * string)
;FirmV_0_7_0.c,2660 :: 		wordtostr(val>>1,string);
	MOVF        FARG_intValueToStr_val+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        FARG_intValueToStr_val+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	RRCF        FARG_WordToStr_input+1, 1 
	RRCF        FARG_WordToStr_input+0, 1 
	BCF         FARG_WordToStr_input+1, 7 
	MOVF        FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_WordToStr_output+0 
	MOVF        FARG_intValueToStr_string+1, 0 
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;FirmV_0_7_0.c,2661 :: 		if((val%2)==1)
	MOVLW       1
	ANDWF       FARG_intValueToStr_val+0, 0 
	MOVWF       R1 
	MOVF        FARG_intValueToStr_val+1, 0 
	MOVWF       R2 
	MOVLW       0
	ANDWF       R2, 1 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__intValueToStr902
	MOVLW       1
	XORWF       R1, 0 
L__intValueToStr902:
	BTFSS       STATUS+0, 2 
	GOTO        L_intValueToStr704
;FirmV_0_7_0.c,2662 :: 		memcpy(string+5,".5s",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       46
	MOVWF       ?lstr110_FirmV_0_7_0+0 
	MOVLW       53
	MOVWF       ?lstr110_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr110_FirmV_0_7_0+2 
	CLRF        ?lstr110_FirmV_0_7_0+3 
	MOVLW       ?lstr110_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr110_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_intValueToStr705
L_intValueToStr704:
;FirmV_0_7_0.c,2664 :: 		memcpy(string+5,".0s",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       46
	MOVWF       ?lstr111_FirmV_0_7_0+0 
	MOVLW       48
	MOVWF       ?lstr111_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr111_FirmV_0_7_0+2 
	CLRF        ?lstr111_FirmV_0_7_0+3 
	MOVLW       ?lstr111_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr111_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_intValueToStr705:
;FirmV_0_7_0.c,2665 :: 		}
	RETURN      0
; end of _intValueToStr

_SetOverloadParams:

;FirmV_0_7_0.c,2677 :: 		void SetOverloadParams(char p, char d)
;FirmV_0_7_0.c,2680 :: 		switch(p)
	GOTO        L_SetOverloadParams706
;FirmV_0_7_0.c,2682 :: 		case 0: OverloadTreshold=0; break;
L_SetOverloadParams708:
	CLRF        _OverloadTreshold+0 
	CLRF        _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2684 :: 		case 1: OverloadTreshold=480; break;
L_SetOverloadParams709:
	MOVLW       224
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2686 :: 		case 2: OverloadTreshold=490; break;
L_SetOverloadParams710:
	MOVLW       234
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2688 :: 		case 3: OverloadTreshold=500; break;
L_SetOverloadParams711:
	MOVLW       244
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2690 :: 		case 4: OverloadTreshold=530; break;
L_SetOverloadParams712:
	MOVLW       18
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2692 :: 		case 5: OverloadTreshold=550; break;
L_SetOverloadParams713:
	MOVLW       38
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2694 :: 		case 6: OverloadTreshold=570; break;
L_SetOverloadParams714:
	MOVLW       58
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2696 :: 		case 7: OverloadTreshold=600; break;
L_SetOverloadParams715:
	MOVLW       88
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2698 :: 		case 8: OverloadTreshold=630; break;
L_SetOverloadParams716:
	MOVLW       118
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2700 :: 		case 9: OverloadTreshold=650; break;
L_SetOverloadParams717:
	MOVLW       138
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2702 :: 		case 10: OverloadTreshold=670; break;
L_SetOverloadParams718:
	MOVLW       158
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2704 :: 		case 11: OverloadTreshold=700; break;
L_SetOverloadParams719:
	MOVLW       188
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2706 :: 		case 12: OverloadTreshold=750; break;
L_SetOverloadParams720:
	MOVLW       238
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2708 :: 		case 13: OverloadTreshold=800; break;
L_SetOverloadParams721:
	MOVLW       32
	MOVWF       _OverloadTreshold+0 
	MOVLW       3
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2710 :: 		case 14: OverloadTreshold=850; break;
L_SetOverloadParams722:
	MOVLW       82
	MOVWF       _OverloadTreshold+0 
	MOVLW       3
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2712 :: 		case 15: OverloadTreshold=900; break;
L_SetOverloadParams723:
	MOVLW       132
	MOVWF       _OverloadTreshold+0 
	MOVLW       3
	MOVWF       _OverloadTreshold+1 
	GOTO        L_SetOverloadParams707
;FirmV_0_7_0.c,2714 :: 		}
L_SetOverloadParams706:
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams708
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams709
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams710
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams711
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams712
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams713
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams714
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams715
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams716
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams717
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams718
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams719
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams720
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams721
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams722
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams723
L_SetOverloadParams707:
;FirmV_0_7_0.c,2717 :: 		switch(d)
	GOTO        L_SetOverloadParams724
;FirmV_0_7_0.c,2719 :: 		case 0: OverloadDuration=100; break;
L_SetOverloadParams726:
	MOVLW       100
	MOVWF       _OverloadDuration+0 
	MOVLW       0
	MOVWF       _OverloadDuration+1 
	GOTO        L_SetOverloadParams725
;FirmV_0_7_0.c,2721 :: 		case 1: OverloadDuration=500; break;
L_SetOverloadParams727:
	MOVLW       244
	MOVWF       _OverloadDuration+0 
	MOVLW       1
	MOVWF       _OverloadDuration+1 
	GOTO        L_SetOverloadParams725
;FirmV_0_7_0.c,2723 :: 		case 2: OverloadDuration=1000; break;
L_SetOverloadParams728:
	MOVLW       232
	MOVWF       _OverloadDuration+0 
	MOVLW       3
	MOVWF       _OverloadDuration+1 
	GOTO        L_SetOverloadParams725
;FirmV_0_7_0.c,2725 :: 		case 3: OverloadDuration=1500; break;
L_SetOverloadParams729:
	MOVLW       220
	MOVWF       _OverloadDuration+0 
	MOVLW       5
	MOVWF       _OverloadDuration+1 
	GOTO        L_SetOverloadParams725
;FirmV_0_7_0.c,2727 :: 		case 4: OverloadDuration=2000; break;
L_SetOverloadParams730:
	MOVLW       208
	MOVWF       _OverloadDuration+0 
	MOVLW       7
	MOVWF       _OverloadDuration+1 
	GOTO        L_SetOverloadParams725
;FirmV_0_7_0.c,2729 :: 		case 5: OverloadDuration=2500; break;
L_SetOverloadParams731:
	MOVLW       196
	MOVWF       _OverloadDuration+0 
	MOVLW       9
	MOVWF       _OverloadDuration+1 
	GOTO        L_SetOverloadParams725
;FirmV_0_7_0.c,2731 :: 		case 6: OverloadDuration=3000; break;
L_SetOverloadParams732:
	MOVLW       184
	MOVWF       _OverloadDuration+0 
	MOVLW       11
	MOVWF       _OverloadDuration+1 
	GOTO        L_SetOverloadParams725
;FirmV_0_7_0.c,2733 :: 		case 7: OverloadDuration=3500; break;
L_SetOverloadParams733:
	MOVLW       172
	MOVWF       _OverloadDuration+0 
	MOVLW       13
	MOVWF       _OverloadDuration+1 
	GOTO        L_SetOverloadParams725
;FirmV_0_7_0.c,2735 :: 		case 8: OverloadDuration=4000; break;
L_SetOverloadParams734:
	MOVLW       160
	MOVWF       _OverloadDuration+0 
	MOVLW       15
	MOVWF       _OverloadDuration+1 
	GOTO        L_SetOverloadParams725
;FirmV_0_7_0.c,2737 :: 		case 9: OverloadDuration=4500; break;
L_SetOverloadParams735:
	MOVLW       148
	MOVWF       _OverloadDuration+0 
	MOVLW       17
	MOVWF       _OverloadDuration+1 
	GOTO        L_SetOverloadParams725
;FirmV_0_7_0.c,2739 :: 		case 10: OverloadDuration=5000; break;
L_SetOverloadParams736:
	MOVLW       136
	MOVWF       _OverloadDuration+0 
	MOVLW       19
	MOVWF       _OverloadDuration+1 
	GOTO        L_SetOverloadParams725
;FirmV_0_7_0.c,2740 :: 		}
L_SetOverloadParams724:
	MOVF        FARG_SetOverloadParams_d+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams726
	MOVF        FARG_SetOverloadParams_d+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams727
	MOVF        FARG_SetOverloadParams_d+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams728
	MOVF        FARG_SetOverloadParams_d+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams729
	MOVF        FARG_SetOverloadParams_d+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams730
	MOVF        FARG_SetOverloadParams_d+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams731
	MOVF        FARG_SetOverloadParams_d+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams732
	MOVF        FARG_SetOverloadParams_d+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams733
	MOVF        FARG_SetOverloadParams_d+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams734
	MOVF        FARG_SetOverloadParams_d+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams735
	MOVF        FARG_SetOverloadParams_d+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams736
L_SetOverloadParams725:
;FirmV_0_7_0.c,2741 :: 		}
	RETURN      0
; end of _SetOverloadParams

_TorqueLogger:

;FirmV_0_7_0.c,2762 :: 		void TorqueLogger()
;FirmV_0_7_0.c,2765 :: 		switch(State)
	GOTO        L_TorqueLogger737
;FirmV_0_7_0.c,2767 :: 		case 3:
L_TorqueLogger739:
;FirmV_0_7_0.c,2768 :: 		txt[0]='D';txt[1]='3';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       51
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2769 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2770 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2771 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2773 :: 		txt[0]='D';txt[1]='3';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       51
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2774 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2775 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2776 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2778 :: 		break;
	GOTO        L_TorqueLogger738
;FirmV_0_7_0.c,2780 :: 		case 4:
L_TorqueLogger740:
;FirmV_0_7_0.c,2781 :: 		txt[0]='D';txt[1]='4';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       52
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2782 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2783 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2784 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2786 :: 		txt[0]='D';txt[1]='4';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       52
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2787 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2788 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2789 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2791 :: 		break;
	GOTO        L_TorqueLogger738
;FirmV_0_7_0.c,2793 :: 		case 7:
L_TorqueLogger741:
;FirmV_0_7_0.c,2794 :: 		txt[0]='D';txt[1]='7';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       55
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2795 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2796 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2797 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2799 :: 		txt[0]='D';txt[1]='7';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       55
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2800 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2801 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2802 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2804 :: 		break;
	GOTO        L_TorqueLogger738
;FirmV_0_7_0.c,2806 :: 		case 8:
L_TorqueLogger742:
;FirmV_0_7_0.c,2807 :: 		txt[0]='D';txt[1]='8';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       56
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2808 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2809 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2810 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2812 :: 		txt[0]='D';txt[1]='8';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       56
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2813 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2814 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2815 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2817 :: 		break;
	GOTO        L_TorqueLogger738
;FirmV_0_7_0.c,2819 :: 		case 200:
L_TorqueLogger743:
;FirmV_0_7_0.c,2820 :: 		txt[0]='D';txt[1]='L';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       76
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2821 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2822 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2823 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2825 :: 		txt[0]='D';txt[1]='L';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       76
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2826 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2827 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2828 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2830 :: 		break;
	GOTO        L_TorqueLogger738
;FirmV_0_7_0.c,2832 :: 		}
L_TorqueLogger737:
	MOVF        _State+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger739
	MOVF        _State+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger740
	MOVF        _State+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger741
	MOVF        _State+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger742
	MOVF        _State+0, 0 
	XORLW       200
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger743
L_TorqueLogger738:
;FirmV_0_7_0.c,2833 :: 		}
	RETURN      0
; end of _TorqueLogger
