
_interrupt:

;FirmV_0_7_0.c,207 :: 		void interrupt()
;FirmV_0_7_0.c,209 :: 		if(TMR0IF_bit)
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt0
;FirmV_0_7_0.c,211 :: 		msCounter=msCounter+1;
	INCF        _msCounter+0, 1 
;FirmV_0_7_0.c,212 :: 		LCDBackLight=1;
	BSF         PORTA+0, 4 
;FirmV_0_7_0.c,213 :: 		Flag20ms=1;
	MOVLW       1
	MOVWF       _Flag20ms+0 
;FirmV_0_7_0.c,214 :: 		if(ms20A>=25)
	MOVLW       25
	SUBWF       _ms20A+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
;FirmV_0_7_0.c,215 :: 		{ms20A=0;RemotePulse1=0;}
	CLRF        _ms20A+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt2
L_interrupt1:
;FirmV_0_7_0.c,217 :: 		ms20A=ms20A+1;
	INCF        _ms20A+0, 1 
L_interrupt2:
;FirmV_0_7_0.c,219 :: 		if(ms20B>=25)
	MOVLW       25
	SUBWF       _ms20B+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt3
;FirmV_0_7_0.c,220 :: 		{ms20B=0;RemotePulse2=0;}
	CLRF        _ms20B+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt4
L_interrupt3:
;FirmV_0_7_0.c,222 :: 		ms20B=ms20B+1;
	INCF        _ms20B+0, 1 
L_interrupt4:
;FirmV_0_7_0.c,224 :: 		if(msCounter>=25)
	MOVLW       25
	SUBWF       _msCounter+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt5
;FirmV_0_7_0.c,226 :: 		msCounter=0;
	CLRF        _msCounter+0 
;FirmV_0_7_0.c,227 :: 		ms500=ms500+1;
	MOVLW       1
	ADDWF       _ms500+0, 1 
	MOVLW       0
	ADDWFC      _ms500+1, 1 
	ADDWFC      _ms500+2, 1 
	ADDWFC      _ms500+3, 1 
;FirmV_0_7_0.c,228 :: 		LCDFlashFlag=!LCDFlashFlag;
	MOVF        _LCDFlashFlag+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _LCDFlashFlag+0 
;FirmV_0_7_0.c,229 :: 		LCDBackLight=0;
	BCF         PORTA+0, 4 
;FirmV_0_7_0.c,230 :: 		Flag500ms=1;
	MOVLW       1
	MOVWF       _Flag500ms+0 
;FirmV_0_7_0.c,231 :: 		}
L_interrupt5:
;FirmV_0_7_0.c,232 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,233 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,234 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;FirmV_0_7_0.c,235 :: 		}
L_interrupt0:
;FirmV_0_7_0.c,238 :: 		if(INT1F_bit)
	BTFSS       INT1F_bit+0, BitPos(INT1F_bit+0) 
	GOTO        L_interrupt6
;FirmV_0_7_0.c,240 :: 		if(RemotePulse1==0)
	MOVF        _RemotePulse1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;FirmV_0_7_0.c,241 :: 		{ RemotePulse1=RemotePulse1+1;ms20A=0;}
	INCF        _RemotePulse1+0, 1 
	CLRF        _ms20A+0 
	GOTO        L_interrupt8
L_interrupt7:
;FirmV_0_7_0.c,243 :: 		{ RemotePulse1=RemotePulse1+1;}
	INCF        _RemotePulse1+0, 1 
L_interrupt8:
;FirmV_0_7_0.c,244 :: 		if(RemotePulse1>=5)
	MOVLW       5
	SUBWF       _RemotePulse1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt9
;FirmV_0_7_0.c,245 :: 		if((ms20A>=19)&&(ms20A<=21))
	MOVLW       19
	SUBWF       _ms20A+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
	MOVF        _ms20A+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
L__interrupt821:
;FirmV_0_7_0.c,246 :: 		{RemoteAFlag=1;RemotePulse1=0;}
	MOVLW       1
	MOVWF       _RemoteAFlag+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt13
L_interrupt12:
;FirmV_0_7_0.c,248 :: 		RemotePulse1=0;
	CLRF        _RemotePulse1+0 
L_interrupt13:
L_interrupt9:
;FirmV_0_7_0.c,249 :: 		INT1IF_bit=0;
	BCF         INT1IF_bit+0, BitPos(INT1IF_bit+0) 
;FirmV_0_7_0.c,250 :: 		}
L_interrupt6:
;FirmV_0_7_0.c,254 :: 		if(INT2IF_bit)
	BTFSS       INT2IF_bit+0, BitPos(INT2IF_bit+0) 
	GOTO        L_interrupt14
;FirmV_0_7_0.c,256 :: 		if(RemotePulse2==0)
	MOVF        _RemotePulse2+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt15
;FirmV_0_7_0.c,257 :: 		{ RemotePulse2=RemotePulse2+1;ms20B=0;}
	INCF        _RemotePulse2+0, 1 
	CLRF        _ms20B+0 
	GOTO        L_interrupt16
L_interrupt15:
;FirmV_0_7_0.c,259 :: 		{ RemotePulse2=RemotePulse2+1;}
	INCF        _RemotePulse2+0, 1 
L_interrupt16:
;FirmV_0_7_0.c,260 :: 		if(RemotePulse2>=5)
	MOVLW       5
	SUBWF       _RemotePulse2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt17
;FirmV_0_7_0.c,261 :: 		if((ms20B>=19)&&(ms20B<=21))
	MOVLW       19
	SUBWF       _ms20B+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
	MOVF        _ms20B+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
L__interrupt820:
;FirmV_0_7_0.c,262 :: 		{RemoteBFlag=1;RemotePulse2=0;}
	MOVLW       1
	MOVWF       _RemoteBFlag+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt21
L_interrupt20:
;FirmV_0_7_0.c,264 :: 		RemotePulse2=0;
	CLRF        _RemotePulse2+0 
L_interrupt21:
L_interrupt17:
;FirmV_0_7_0.c,265 :: 		INT2IF_bit=0;
	BCF         INT2IF_bit+0, BitPos(INT2IF_bit+0) 
;FirmV_0_7_0.c,266 :: 		}
L_interrupt14:
;FirmV_0_7_0.c,271 :: 		if(INT0F_bit==1)
	BTFSS       INT0F_bit+0, BitPos(INT0F_bit+0) 
	GOTO        L_interrupt22
;FirmV_0_7_0.c,273 :: 		ZCCounter=ZCCounter+1;
	INCF        _ZCCounter+0, 1 
;FirmV_0_7_0.c,274 :: 		if(ZCCounter==255)
	MOVF        _ZCCounter+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt23
;FirmV_0_7_0.c,275 :: 		ZCCounter=2;
	MOVLW       2
	MOVWF       _ZCCounter+0 
L_interrupt23:
;FirmV_0_7_0.c,276 :: 		if(ZCCounter%3==1)
	MOVLW       3
	MOVWF       R4 
	MOVF        _ZCCounter+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt24
;FirmV_0_7_0.c,278 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt25
;FirmV_0_7_0.c,279 :: 		if(Motor1FullSpeed)
	MOVF        _Motor1FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt26
;FirmV_0_7_0.c,280 :: 		Motor1=1;
	BSF         PORTB+0, 3 
	GOTO        L_interrupt27
L_interrupt26:
;FirmV_0_7_0.c,282 :: 		Motor1=0;
	BCF         PORTB+0, 3 
L_interrupt27:
L_interrupt25:
;FirmV_0_7_0.c,284 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt28
;FirmV_0_7_0.c,285 :: 		if(Motor2FullSpeed)
	MOVF        _Motor2FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt29
;FirmV_0_7_0.c,286 :: 		Motor2=1;
	BSF         PORTB+0, 4 
	GOTO        L_interrupt30
L_interrupt29:
;FirmV_0_7_0.c,288 :: 		Motor2=0;
	BCF         PORTB+0, 4 
L_interrupt30:
L_interrupt28:
;FirmV_0_7_0.c,289 :: 		}
L_interrupt24:
;FirmV_0_7_0.c,290 :: 		if(ZCCounter%3==0)
	MOVLW       3
	MOVWF       R4 
	MOVF        _ZCCounter+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt31
;FirmV_0_7_0.c,292 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt32
;FirmV_0_7_0.c,293 :: 		Motor1=1;
	BSF         PORTB+0, 3 
L_interrupt32:
;FirmV_0_7_0.c,295 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt33
;FirmV_0_7_0.c,296 :: 		Motor2=1;
	BSF         PORTB+0, 4 
L_interrupt33:
;FirmV_0_7_0.c,297 :: 		}
L_interrupt31:
;FirmV_0_7_0.c,298 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, BitPos(INT0F_bit+0) 
;FirmV_0_7_0.c,299 :: 		}
L_interrupt22:
;FirmV_0_7_0.c,300 :: 		}
L_end_interrupt:
L__interrupt942:
	RETFIE      1
; end of _interrupt

_ResetTaskEvents:

;FirmV_0_7_0.c,313 :: 		void ResetTaskEvents()
;FirmV_0_7_0.c,315 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,316 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,317 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,318 :: 		}
L_end_ResetTaskEvents:
	RETURN      0
; end of _ResetTaskEvents

_Decrypt:

;FirmV_0_7_0.c,327 :: 		void Decrypt()
;FirmV_0_7_0.c,329 :: 		Sipher[0]=Crypto[1][0]+0x0D;
	MOVLW       13
	ADDWF       _crypto+16, 0 
	MOVWF       _Sipher+0 
;FirmV_0_7_0.c,330 :: 		Sipher[1]=Crypto[1][1]+0x0D;
	MOVLW       13
	ADDWF       _crypto+17, 0 
	MOVWF       _Sipher+1 
;FirmV_0_7_0.c,331 :: 		Sipher[2]=Crypto[1][2]+0x0D;
	MOVLW       13
	ADDWF       _crypto+18, 0 
	MOVWF       _Sipher+2 
;FirmV_0_7_0.c,332 :: 		Sipher[3]=Crypto[1][3]-0x26;
	MOVLW       38
	SUBWF       _crypto+19, 0 
	MOVWF       _Sipher+3 
;FirmV_0_7_0.c,333 :: 		Sipher[4]=Crypto[1][4]-0x3C;
	MOVLW       60
	SUBWF       _crypto+20, 0 
	MOVWF       _Sipher+4 
;FirmV_0_7_0.c,334 :: 		Sipher[5]=Crypto[1][5]-0x41;
	MOVLW       65
	SUBWF       _crypto+21, 0 
	MOVWF       _Sipher+5 
;FirmV_0_7_0.c,335 :: 		Sipher[6]=Crypto[1][6]-0x0C;
	MOVLW       12
	SUBWF       _crypto+22, 0 
	MOVWF       _Sipher+6 
;FirmV_0_7_0.c,336 :: 		Sipher[7]=Crypto[1][7]+0x34;
	MOVLW       52
	ADDWF       _crypto+23, 0 
	MOVWF       _Sipher+7 
;FirmV_0_7_0.c,337 :: 		Sipher[8]=Crypto[1][8]-0x01;
	DECF        _crypto+24, 0 
	MOVWF       _Sipher+8 
;FirmV_0_7_0.c,338 :: 		Sipher[9]=Crypto[1][9]-0x1F;
	MOVLW       31
	SUBWF       _crypto+25, 0 
	MOVWF       _Sipher+9 
;FirmV_0_7_0.c,339 :: 		Sipher[10]=Crypto[1][10]-0x3A;
	MOVLW       58
	SUBWF       _crypto+26, 0 
	MOVWF       _Sipher+10 
;FirmV_0_7_0.c,340 :: 		Sipher[11]=Crypto[1][11]-0x3B;
	MOVLW       59
	SUBWF       _crypto+27, 0 
	MOVWF       _Sipher+11 
;FirmV_0_7_0.c,341 :: 		Sipher[12]=Crypto[1][12]-0x3C;
	MOVLW       60
	SUBWF       _crypto+28, 0 
	MOVWF       _Sipher+12 
;FirmV_0_7_0.c,342 :: 		Sipher[13]=Crypto[1][13]+0x0D;
	MOVLW       13
	ADDWF       _crypto+29, 0 
	MOVWF       _Sipher+13 
;FirmV_0_7_0.c,343 :: 		Sipher[14]=Crypto[1][14]+0x0D;
	MOVLW       13
	ADDWF       _crypto+30, 0 
	MOVWF       _Sipher+14 
;FirmV_0_7_0.c,344 :: 		Sipher[15]=Crypto[1][15]+0x0D;
	MOVLW       13
	ADDWF       _crypto+31, 0 
	MOVWF       _Sipher+15 
;FirmV_0_7_0.c,345 :: 		}
L_end_Decrypt:
	RETURN      0
; end of _Decrypt

_Logger:

;FirmV_0_7_0.c,357 :: 		void Logger(char* text, char TimeStampFlag)
;FirmV_0_7_0.c,360 :: 		if(TimeStampFlag)
	MOVF        FARG_Logger_TimeStampFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Logger34
;FirmV_0_7_0.c,362 :: 		longwordtostrwithzeros(ms500,time);
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
;FirmV_0_7_0.c,363 :: 		uart_write_text(time);
	MOVLW       Logger_time_L0+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(Logger_time_L0+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;FirmV_0_7_0.c,364 :: 		uart1_write_text(": ");
	MOVLW       ?lstr1_FirmV_0_7_0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_FirmV_0_7_0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;FirmV_0_7_0.c,365 :: 		}
L_Logger34:
;FirmV_0_7_0.c,366 :: 		uart1_write_text(text);
	MOVF        FARG_Logger_text+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_Logger_text+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;FirmV_0_7_0.c,367 :: 		uart1_write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,368 :: 		uart1_write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,369 :: 		}
L_end_Logger:
	RETURN      0
; end of _Logger

_main:

;FirmV_0_7_0.c,386 :: 		void main() {
;FirmV_0_7_0.c,389 :: 		PhotocellRel=1;
	BSF         PORTC+0, 5 
;FirmV_0_7_0.c,391 :: 		Init();
	CALL        _Init+0, 0
;FirmV_0_7_0.c,393 :: 		Decrypt();
	CALL        _Decrypt+0, 0
;FirmV_0_7_0.c,395 :: 		Buzzer=1;
	BSF         PORTB+0, 7 
;FirmV_0_7_0.c,396 :: 		Logger("Start ...",1);
	MOVLW       ?lstr2_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr2_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,397 :: 		memcpy(LCDLine1,Sipher,16);
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
;FirmV_0_7_0.c,398 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,399 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,400 :: 		Buzzer=0;
	BCF         PORTB+0, 7 
;FirmV_0_7_0.c,402 :: 		while(1)
L_main35:
;FirmV_0_7_0.c,404 :: 		asm CLRWDT;
	CLRWDT
;FirmV_0_7_0.c,406 :: 		if(Flag20ms==1)
	MOVF        _Flag20ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main37
;FirmV_0_7_0.c,408 :: 		if((Buzzer==1)&&(BuzzCounter<100))
	BTFSS       PORTB+0, 7 
	GOTO        L_main40
	MOVLW       100
	SUBWF       _BuzzCounter+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main40
L__main827:
;FirmV_0_7_0.c,409 :: 		{BuzzCounter=BuzzCounter+1;}
	INCF        _BuzzCounter+0, 1 
L_main40:
;FirmV_0_7_0.c,411 :: 		if((Buzzer==1)&&(LongBuzzFlag))
	BTFSS       PORTB+0, 7 
	GOTO        L_main43
	MOVF        _LongBuzzFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main43
L__main826:
;FirmV_0_7_0.c,412 :: 		if(BuzzCounter>=25){BuzzFlag=0;LongBuzzFlag=0;Buzzer=0;}
	MOVLW       25
	SUBWF       _BuzzCounter+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main44
	CLRF        _BuzzFlag+0 
	CLRF        _LongBuzzFlag+0 
	BCF         PORTB+0, 7 
L_main44:
L_main43:
;FirmV_0_7_0.c,414 :: 		if((Buzzer==1)&&(BuzzFlag)&&(!LongBuzzFlag))
	BTFSS       PORTB+0, 7 
	GOTO        L_main47
	MOVF        _BuzzFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main47
	MOVF        _LongBuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main47
L__main825:
;FirmV_0_7_0.c,415 :: 		{BuzzFlag=0;LongBuzzFlag=0;Buzzer=0;}
	CLRF        _BuzzFlag+0 
	CLRF        _LongBuzzFlag+0 
	BCF         PORTB+0, 7 
L_main47:
;FirmV_0_7_0.c,417 :: 		if(((BuzzFlag)||(LongBuzzFlag))&&(!Buzzer))
	MOVF        _BuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main824
	MOVF        _LongBuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main824
	GOTO        L_main52
L__main824:
	BTFSC       PORTB+0, 7 
	GOTO        L_main52
L__main823:
;FirmV_0_7_0.c,418 :: 		{Buzzer=1;BuzzCounter=0;}
	BSF         PORTB+0, 7 
	CLRF        _BuzzCounter+0 
L_main52:
;FirmV_0_7_0.c,421 :: 		if(DebouncingDelayPress<DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelayPress+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main53
;FirmV_0_7_0.c,422 :: 		DebouncingDelayPress=DebouncingDelayPress+1;
	INCF        _DebouncingDelayPress+0, 1 
L_main53:
;FirmV_0_7_0.c,423 :: 		if(DebouncingDelayUnpress<DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelayUnpress+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main54
;FirmV_0_7_0.c,424 :: 		DebouncingDelayUnpress=DebouncingDelayUnpress+1;
	INCF        _DebouncingDelayUnpress+0, 1 
L_main54:
;FirmV_0_7_0.c,426 :: 		LCDUpdater();
	CALL        _LCDUpdater+0, 0
;FirmV_0_7_0.c,427 :: 		if(KeyFlag<200)
	MOVLW       200
	SUBWF       _KeyFlag+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main55
;FirmV_0_7_0.c,428 :: 		KeyFlag=KeyFlag+1;
	INCF        _KeyFlag+0, 1 
L_main55:
;FirmV_0_7_0.c,429 :: 		Flag20ms=0;
	CLRF        _Flag20ms+0 
;FirmV_0_7_0.c,430 :: 		}
L_main37:
;FirmV_0_7_0.c,432 :: 		if(Flag500ms==1)
	MOVF        _Flag500ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main56
;FirmV_0_7_0.c,434 :: 		if(KeyNoiseEliminator<NoiseEliminatorTreshold)
	MOVLW       3
	SUBWF       _KeyNoiseEliminator+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main57
;FirmV_0_7_0.c,435 :: 		KeyNoiseEliminator=KeyNoiseEliminator+1;
	INCF        _KeyNoiseEliminator+0, 1 
L_main57:
;FirmV_0_7_0.c,437 :: 		if(FlashFlag)
	MOVF        _FlashFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main58
;FirmV_0_7_0.c,438 :: 		FlasherLamp=!FlasherLamp;// Buzzer=!Buzzer;
	BTG         PORTB+0, 5 
	GOTO        L_main59
L_main58:
;FirmV_0_7_0.c,440 :: 		if((!BuzzFlag)&&(!LongBuzzFlag))FlasherLamp=0; // Buzzer=0;
	MOVF        _BuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main62
	MOVF        _LongBuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main62
L__main822:
	BCF         PORTB+0, 5 
L_main62:
L_main59:
;FirmV_0_7_0.c,441 :: 		ResetTaskEvents();
	CALL        _ResetTaskEvents+0, 0
;FirmV_0_7_0.c,442 :: 		TaskManager();
	CALL        _TaskManager+0, 0
;FirmV_0_7_0.c,443 :: 		TorqueLogger();
	CALL        _TorqueLogger+0, 0
;FirmV_0_7_0.c,444 :: 		Flag500ms=0;
	CLRF        _Flag500ms+0 
;FirmV_0_7_0.c,445 :: 		}
L_main56:
;FirmV_0_7_0.c,446 :: 		EventHandler();
	CALL        _EventHandler+0, 0
;FirmV_0_7_0.c,447 :: 		StateManager();
	CALL        _StateManager+0, 0
;FirmV_0_7_0.c,448 :: 		}
	GOTO        L_main35
;FirmV_0_7_0.c,450 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_StateManager:

;FirmV_0_7_0.c,475 :: 		void StateManager()
;FirmV_0_7_0.c,478 :: 		switch(State)
	GOTO        L_StateManager63
;FirmV_0_7_0.c,481 :: 		case 0: State1(); break;
L_StateManager65:
	CALL        _State1+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,483 :: 		case 1: State1(); break;
L_StateManager66:
	CALL        _State1+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,485 :: 		case 2: State2(); break;
L_StateManager67:
	CALL        _State2+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,487 :: 		case 3: State3(); break;
L_StateManager68:
	CALL        _State3+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,489 :: 		case 4: State4(); break;
L_StateManager69:
	CALL        _State4+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,491 :: 		case 5: State5(); break;
L_StateManager70:
	CALL        _State5+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,493 :: 		case 6: State6(); break;
L_StateManager71:
	CALL        _State6+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,495 :: 		case 7: State7(); break;
L_StateManager72:
	CALL        _State7+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,497 :: 		case 8: State8(); break;
L_StateManager73:
	CALL        _State8+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,499 :: 		case 10:State00(); break;
L_StateManager74:
	CALL        _State00+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,501 :: 		case 100:Menu0(); break;
L_StateManager75:
	CALL        _Menu0+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,503 :: 		case 101:Menu1(); break;
L_StateManager76:
	CALL        _Menu1+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,505 :: 		case 102:Menu2(); break;
L_StateManager77:
	CALL        _Menu2+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,507 :: 		case 103:Menu3(); break;
L_StateManager78:
	CALL        _Menu3+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,509 :: 		case 200:LearnAuto(); break;
L_StateManager79:
	CALL        _LearnAuto+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,511 :: 		case 201:LearnManual(); break;
L_StateManager80:
	CALL        _LearnManual+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,513 :: 		case 250:About(); break;
L_StateManager81:
	CALL        _About+0, 0
	GOTO        L_StateManager64
;FirmV_0_7_0.c,515 :: 		}
L_StateManager63:
	MOVF        _State+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager65
	MOVF        _State+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager66
	MOVF        _State+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager67
	MOVF        _State+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager68
	MOVF        _State+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager69
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager70
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager71
	MOVF        _State+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager72
	MOVF        _State+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager73
	MOVF        _State+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager74
	MOVF        _State+0, 0 
	XORLW       100
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager75
	MOVF        _State+0, 0 
	XORLW       101
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager76
	MOVF        _State+0, 0 
	XORLW       102
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager77
	MOVF        _State+0, 0 
	XORLW       103
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager78
	MOVF        _State+0, 0 
	XORLW       200
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager79
	MOVF        _State+0, 0 
	XORLW       201
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager80
	MOVF        _State+0, 0 
	XORLW       250
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager81
L_StateManager64:
;FirmV_0_7_0.c,516 :: 		}
L_end_StateManager:
	RETURN      0
; end of _StateManager

_StateTest:

;FirmV_0_7_0.c,520 :: 		void StateTest()
;FirmV_0_7_0.c,522 :: 		if (Events.Photocell==1)
	MOVF        _Events+6, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StateTest82
;FirmV_0_7_0.c,523 :: 		LCDLine1[0]='1';
	MOVLW       49
	MOVWF       _LCDLine1+0 
	GOTO        L_StateTest83
L_StateTest82:
;FirmV_0_7_0.c,525 :: 		LCDLine1[0]='0';
	MOVLW       48
	MOVWF       _LCDLine1+0 
L_StateTest83:
;FirmV_0_7_0.c,527 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,529 :: 		}
L_end_StateTest:
	RETURN      0
; end of _StateTest

_State00:

;FirmV_0_7_0.c,533 :: 		void State00()
;FirmV_0_7_0.c,538 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,539 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,540 :: 		StartMotor(1,_Close);
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,541 :: 		StartMotor(2,_Close);
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,543 :: 		if(Events.Remote.b0==1)
	BTFSS       _Events+4, 0 
	GOTO        L_State0084
;FirmV_0_7_0.c,544 :: 		{Flasher=0;FlashFlag=0;StopMotor(1);StopMotor(2);
	BCF         PORTD+0, 7 
	CLRF        _FlashFlag+0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,545 :: 		State=1;                }
	MOVLW       1
	MOVWF       _State+0 
L_State0084:
;FirmV_0_7_0.c,546 :: 		}
L_end_State00:
	RETURN      0
; end of _State00

_State1:

;FirmV_0_7_0.c,555 :: 		void State1()
;FirmV_0_7_0.c,557 :: 		char delay=3;
	MOVLW       3
	MOVWF       State1_delay_L0+0 
	CLRF        State1_AutoCloseTemp_L0+0 
	CLRF        State1_AutoCloseTemp_L0+1 
	CLRF        State1_AutoCloseTemp_L0+2 
	CLRF        State1_AutoCloseTemp_L0+3 
;FirmV_0_7_0.c,559 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,560 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,562 :: 		if(Events.Keys==2)
	MOVF        _Events+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State185
;FirmV_0_7_0.c,563 :: 		{State=100;MenuPointer=0;}
	MOVLW       100
	MOVWF       _State+0 
	CLRF        _MenuPointer+0 
L_State185:
;FirmV_0_7_0.c,565 :: 		ActiveDoors=3-Events.Remote;
	MOVF        _Events+4, 0 
	SUBLW       3
	MOVWF       _ActiveDoors+0 
;FirmV_0_7_0.c,569 :: 		if(Events.Remote!=0)
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State186
;FirmV_0_7_0.c,572 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,573 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,574 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,575 :: 		if(Lockenable)
	MOVF        _LockEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State187
;FirmV_0_7_0.c,576 :: 		AddTask(ms500+1,12);
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
L_State187:
;FirmV_0_7_0.c,577 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,578 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,579 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State188
;FirmV_0_7_0.c,580 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
	GOTO        L_State189
L_State188:
;FirmV_0_7_0.c,582 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
L_State189:
;FirmV_0_7_0.c,583 :: 		temp=ms500+OpenSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,584 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,585 :: 		temp=ms500+OpenSoftStartTime+delay;
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
;FirmV_0_7_0.c,586 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,587 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State190
;FirmV_0_7_0.c,588 :: 		{temp=ms500+Door1OpenTime-OpenSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
L_State190:
;FirmV_0_7_0.c,589 :: 		temp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,590 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,591 :: 		AutoCloseTemp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,593 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State193
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State193
L__State1828:
;FirmV_0_7_0.c,595 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,596 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,597 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State194
;FirmV_0_7_0.c,598 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,8); M2isSlow=1;}//speed down
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
	GOTO        L_State195
L_State194:
;FirmV_0_7_0.c,600 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,6); M2isSlow=0;}//speed up
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
L_State195:
;FirmV_0_7_0.c,601 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,602 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,603 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+delay;
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
;FirmV_0_7_0.c,604 :: 		AddTask(temp,6);//Speed up after soft start
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
;FirmV_0_7_0.c,605 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State196
;FirmV_0_7_0.c,606 :: 		{temp=ms500+ActionTimeDiff+Door2OpenTime-OpenSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
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
L_State196:
;FirmV_0_7_0.c,607 :: 		temp=ms500+Door2OpenTime+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,608 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,609 :: 		AutoCloseTemp=ms500+Door2OpenTime+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,610 :: 		}
L_State193:
;FirmV_0_7_0.c,612 :: 		if(AutoCloseTime!=0)
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State1951
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State1951:
	BTFSC       STATUS+0, 2 
	GOTO        L_State197
;FirmV_0_7_0.c,613 :: 		{temp=AutoCloseTemp+AutoCloseTime;AddTask(temp,9);}
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
L_State197:
;FirmV_0_7_0.c,615 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,616 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,617 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,618 :: 		KeyNoiseEliminator=0;
	CLRF        _KeyNoiseEliminator+0 
;FirmV_0_7_0.c,619 :: 		State=3;
	MOVLW       3
	MOVWF       _State+0 
;FirmV_0_7_0.c,620 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,621 :: 		}
L_State186:
;FirmV_0_7_0.c,622 :: 		}
L_end_State1:
	RETURN      0
; end of _State1

_State2:

;FirmV_0_7_0.c,636 :: 		void State2()
;FirmV_0_7_0.c,638 :: 		char delay=2;
	MOVLW       2
	MOVWF       State2_delay_L0+0 
;FirmV_0_7_0.c,640 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,641 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,644 :: 		if(ReturnAutoclose()!=PrevAC)
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	XORWF       _PrevAC+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_State298
;FirmV_0_7_0.c,646 :: 		LCDFlashFlag=0;
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,647 :: 		PrevAC=ReturnAutoclose();
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	MOVWF       _PrevAC+0 
;FirmV_0_7_0.c,648 :: 		charValueToStr_AC(PrevAC,LCDLine2+11);
	MOVF        R0, 0 
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       _LCDLine2+11
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       hi_addr(_LCDLine2+11)
	MOVWF       FARG_charValueToStr_AC+1 
	CALL        _charValueToStr_AC+0, 0
;FirmV_0_7_0.c,649 :: 		memcpy(LCDLine2,"Close after",11);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr3_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr3_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       11
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,650 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,651 :: 		}
L_State298:
;FirmV_0_7_0.c,654 :: 		if((Events.Remote!=0)||(CheckTask(9)))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State2833
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2833
	GOTO        L_State2101
L__State2833:
;FirmV_0_7_0.c,657 :: 		ClearTasks(0);
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,658 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State2832
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State2832
	GOTO        L_State2104
L__State2832:
;FirmV_0_7_0.c,660 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,661 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,662 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2105
;FirmV_0_7_0.c,663 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
	GOTO        L_State2106
L_State2105:
;FirmV_0_7_0.c,665 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
L_State2106:
;FirmV_0_7_0.c,666 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,667 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,668 :: 		temp=ms500+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,669 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,670 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2107
;FirmV_0_7_0.c,671 :: 		{temp=ms500+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
L_State2107:
;FirmV_0_7_0.c,672 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2108
;FirmV_0_7_0.c,673 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
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
	GOTO        L_State2109
L_State2108:
;FirmV_0_7_0.c,675 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,3);}
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
L_State2109:
;FirmV_0_7_0.c,677 :: 		}
L_State2104:
;FirmV_0_7_0.c,679 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2112
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State2112
L__State2831:
;FirmV_0_7_0.c,681 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,682 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,683 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2113
;FirmV_0_7_0.c,684 :: 		{AddTask(temp,8); M2isSlow=1;}//speed down
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
	GOTO        L_State2114
L_State2113:
;FirmV_0_7_0.c,686 :: 		{AddTask(temp,6); M2isSlow=0;}//speed up
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
L_State2114:
;FirmV_0_7_0.c,687 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,688 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,689 :: 		temp=ms500+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,690 :: 		AddTask(temp,6);//Speed up after soft start
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
;FirmV_0_7_0.c,691 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2115
;FirmV_0_7_0.c,692 :: 		{temp=ms500+Door2CloseTime-CloseSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
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
L_State2115:
;FirmV_0_7_0.c,694 :: 		temp=ms500+Door2CloseTime+delay;
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
;FirmV_0_7_0.c,695 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,699 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,700 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,701 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2116
;FirmV_0_7_0.c,702 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
	GOTO        L_State2117
L_State2116:
;FirmV_0_7_0.c,704 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
L_State2117:
;FirmV_0_7_0.c,705 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,706 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,707 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,708 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,709 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2118
;FirmV_0_7_0.c,710 :: 		{temp=ms500+ActionTimeDiff+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
L_State2118:
;FirmV_0_7_0.c,711 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2119
;FirmV_0_7_0.c,712 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
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
	GOTO        L_State2120
L_State2119:
;FirmV_0_7_0.c,714 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,3);}
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
L_State2120:
;FirmV_0_7_0.c,716 :: 		}
L_State2112:
;FirmV_0_7_0.c,719 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,720 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,721 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,722 :: 		KeyNoiseEliminator=0;
	CLRF        _KeyNoiseEliminator+0 
;FirmV_0_7_0.c,723 :: 		State=4;
	MOVLW       4
	MOVWF       _State+0 
;FirmV_0_7_0.c,724 :: 		}
L_State2101:
;FirmV_0_7_0.c,726 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State2123
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2953
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State2953:
	BTFSC       STATUS+0, 2 
	GOTO        L_State2123
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State2123
L__State2830:
;FirmV_0_7_0.c,727 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S2 Auto Close Deleted",1);}
	MOVLW       1
	MOVWF       _PassFlag+0 
	CALL        _GetAutocloseTime+0, 0
	MOVF        R0, 0 
	MOVWF       __AC+0 
	MOVLW       ?lstr4_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr4_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State2123:
;FirmV_0_7_0.c,729 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State2126
	BTFSC       _Events+6, 0 
	GOTO        L_State2126
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2954
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State2954:
	BTFSC       STATUS+0, 2 
	GOTO        L_State2126
L__State2829:
;FirmV_0_7_0.c,730 :: 		if(CloseAfterPass==0)
	MOVF        _CloseAfterPass+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State2127
;FirmV_0_7_0.c,731 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:",1);Logger(t,1);}
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
	GOTO        L_State2128
L_State2127:
;FirmV_0_7_0.c,733 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:",1);Logger(t,1);}
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
L_State2128:
L_State2126:
;FirmV_0_7_0.c,735 :: 		}
L_end_State2:
	RETURN      0
; end of _State2

_State3:

;FirmV_0_7_0.c,750 :: 		void State3()
;FirmV_0_7_0.c,752 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,753 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,755 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3129
;FirmV_0_7_0.c,756 :: 		{StartMotor(1,_Open);Logger("S3 Motor1Start",1); Lock=0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
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
L_State3129:
;FirmV_0_7_0.c,758 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3130
;FirmV_0_7_0.c,759 :: 		{StartMotor(2,_Open);Logger("S3 Motor2Start",1); Lock=0;}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       ?lstr8_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr8_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	BCF         PORTD+0, 6 
L_State3130:
;FirmV_0_7_0.c,761 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3131
;FirmV_0_7_0.c,762 :: 		{SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;Logger("S3 Motor1 Fast",1);}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _M1isSlow+0 
	MOVLW       ?lstr9_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr9_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3131:
;FirmV_0_7_0.c,764 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3132
;FirmV_0_7_0.c,765 :: 		{SetMotorSpeed(0,Motor2FullSpeed); M1isSlow=1;Logger("S3 Motor1 Slow",1);}
	CLRF        FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
	MOVLW       ?lstr10_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr10_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3132:
;FirmV_0_7_0.c,767 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3133
;FirmV_0_7_0.c,768 :: 		{SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;Logger("S3 Motor2 Fast",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag2+0 
	CLRF        _M2isSlow+0 
	MOVLW       ?lstr11_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr11_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3133:
;FirmV_0_7_0.c,770 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3134
;FirmV_0_7_0.c,771 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S3 Motor2 Slow",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CLRF        FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	MOVLW       ?lstr12_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr12_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3134:
;FirmV_0_7_0.c,773 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3135
;FirmV_0_7_0.c,774 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S3 Overflow Flag1 Set",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr13_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr13_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3135:
;FirmV_0_7_0.c,776 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3136
;FirmV_0_7_0.c,777 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S3 Overflow Flag2 Set",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr14_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr14_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3136:
;FirmV_0_7_0.c,779 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3137
;FirmV_0_7_0.c,780 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S3 Motor1 Stop",1);}
	BCF         _OpenDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr15_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr15_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3137:
;FirmV_0_7_0.c,782 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3138
;FirmV_0_7_0.c,783 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S3 Motor2 Stop",1);}
	BCF         _OpenDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr16_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr16_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3138:
;FirmV_0_7_0.c,785 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3139
;FirmV_0_7_0.c,786 :: 		{Lock=1;}
	BSF         PORTD+0, 6 
L_State3139:
;FirmV_0_7_0.c,788 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3142
	BTFSS       _Events+5, 0 
	GOTO        L_State3142
	MOVF        _M1isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3142
L__State3839:
;FirmV_0_7_0.c,789 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor1 Collision",1);ClearTasks(9);
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
;FirmV_0_7_0.c,790 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State3142:
;FirmV_0_7_0.c,792 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3145
	BTFSS       _Events+5, 1 
	GOTO        L_State3145
	MOVF        _M2isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3145
L__State3838:
;FirmV_0_7_0.c,793 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor2 Collision",1);ClearTasks(9);
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
;FirmV_0_7_0.c,794 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State3145:
;FirmV_0_7_0.c,796 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State3837
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State3837
	GOTO        L_State3148
L__State3837:
;FirmV_0_7_0.c,797 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State3148:
;FirmV_0_7_0.c,799 :: 		if(KeyNoiseEliminator>=NoiseEliminatorTreshold)
	MOVLW       3
	SUBWF       _KeyNoiseEliminator+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_State3149
;FirmV_0_7_0.c,802 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State3152
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3152
L__State3836:
;FirmV_0_7_0.c,803 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Photocell Int",1);ClearTasks(9);
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
;FirmV_0_7_0.c,804 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State3152:
;FirmV_0_7_0.c,806 :: 		if(Events.Remote!=0)
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State3153
;FirmV_0_7_0.c,807 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Remote Stoped",1);ClearTasks(9);
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
;FirmV_0_7_0.c,808 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State3153:
;FirmV_0_7_0.c,810 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3156
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3156
L__State3835:
;FirmV_0_7_0.c,811 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Limit Switch Stoped",1);ClearTasks(9);
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
;FirmV_0_7_0.c,812 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State3156:
;FirmV_0_7_0.c,813 :: 		}
L_State3149:
;FirmV_0_7_0.c,815 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3157
;FirmV_0_7_0.c,816 :: 		if(LockEnable)
	MOVF        _LockEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3158
;FirmV_0_7_0.c,817 :: 		{StartMotor(1,_Close);StartMotor(2,_Close);SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _M1isSlow+0 
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag2+0 
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,818 :: 		AddTask(ms500+RelaseTime,3);AddTask(ms500+RelaseTime,4);AddTask(ms500+1+RelaseTime,13);OpenDone.b2=1;}
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
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
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
	MOVLW       4
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
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
	MOVLW       1
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       13
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	BSF         _OpenDone+0, 2 
	GOTO        L_State3159
L_State3158:
;FirmV_0_7_0.c,820 :: 		{AddTask(ms500+1,13);OpenDone.b2=1;}
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
	MOVLW       13
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	BSF         _OpenDone+0, 2 
L_State3159:
L_State3157:
;FirmV_0_7_0.c,822 :: 		if(CheckTask(13))
	MOVLW       13
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3160
;FirmV_0_7_0.c,823 :: 		{State=2; PrevAC=0;PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_blank,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       2
	MOVWF       _State+0 
	CLRF        _PrevAC+0 
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
L_State3160:
;FirmV_0_7_0.c,825 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State3834
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State3834
	GOTO        L_State3163
L__State3834:
;FirmV_0_7_0.c,826 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);PrevAC=0;Logger("S3 Autoclose Renewed",1);memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;LCDLines=2;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State3956
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State3956:
	BTFSC       STATUS+0, 2 
	GOTO        L_State3164
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
	CLRF        _PrevAC+0 
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
L_State3164:
L_State3163:
;FirmV_0_7_0.c,828 :: 		}
L_end_State3:
	RETURN      0
; end of _State3

_State4:

;FirmV_0_7_0.c,842 :: 		void State4()
;FirmV_0_7_0.c,844 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,845 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,848 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4165
;FirmV_0_7_0.c,849 :: 		{StartMotor(1,_Close);Logger("S4 Motor1Start",1);}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       ?lstr23_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr23_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4165:
;FirmV_0_7_0.c,851 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4166
;FirmV_0_7_0.c,852 :: 		{StartMotor(2,_Close);Logger("S4 Motor2Start",1);memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
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
L_State4166:
;FirmV_0_7_0.c,854 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4167
;FirmV_0_7_0.c,855 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S4 M1 Overload Check",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr25_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr25_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4167:
;FirmV_0_7_0.c,857 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4168
;FirmV_0_7_0.c,858 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S4 M2 Overload Check",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr26_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr26_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4168:
;FirmV_0_7_0.c,860 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4169
;FirmV_0_7_0.c,861 :: 		{SetMotorSpeed(1,Motor2FullSpeed); OverloadCheckFlag1=0; M1isSlow=0;Logger("S4 M1 Speed UP",1);}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _M1isSlow+0 
	MOVLW       ?lstr27_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr27_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4169:
;FirmV_0_7_0.c,863 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4170
;FirmV_0_7_0.c,864 :: 		{SetMotorSpeed(0,Motor2FullSpeed); OverloadCheckFlag1=0; M1isSlow=1;Logger("S4 M1 Speed Down",1);}
	CLRF        FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       _M1isSlow+0 
	MOVLW       ?lstr28_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr28_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4170:
;FirmV_0_7_0.c,866 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4171
;FirmV_0_7_0.c,867 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S4 M2 Speed UP",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       ?lstr29_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr29_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4171:
;FirmV_0_7_0.c,869 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4172
;FirmV_0_7_0.c,870 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S4 M2 Speed Down",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CLRF        FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	MOVLW       ?lstr30_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr30_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4172:
;FirmV_0_7_0.c,872 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4173
;FirmV_0_7_0.c,873 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S4 M1 Stoped",1);}
	BCF         _CloseDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr31_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr31_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4173:
;FirmV_0_7_0.c,875 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4174
;FirmV_0_7_0.c,876 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S4 M2 Stoped",1);}
	BCF         _CloseDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr32_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr32_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4174:
;FirmV_0_7_0.c,878 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4177
	BTFSS       _Events+5, 0 
	GOTO        L_State4177
	MOVF        _M1isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4177
L__State4844:
;FirmV_0_7_0.c,879 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M1 Overloaded",1);ClearTasks(9);
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
;FirmV_0_7_0.c,880 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State4177:
;FirmV_0_7_0.c,882 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4180
	BTFSS       _Events+5, 1 
	GOTO        L_State4180
	MOVF        _M2isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4180
L__State4843:
;FirmV_0_7_0.c,883 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M2 Overloaded",1);ClearTasks(9);
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
;FirmV_0_7_0.c,884 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State4180:
;FirmV_0_7_0.c,886 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State4842
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State4842
	GOTO        L_State4183
L__State4842:
;FirmV_0_7_0.c,887 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State4183:
;FirmV_0_7_0.c,889 :: 		if(KeyNoiseEliminator>=NoiseEliminatorTreshold)
	MOVLW       3
	SUBWF       _KeyNoiseEliminator+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_State4184
;FirmV_0_7_0.c,892 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State4185
;FirmV_0_7_0.c,893 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S4 Photocell Int",1);ClearTasks(9);
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
;FirmV_0_7_0.c,894 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State4185:
;FirmV_0_7_0.c,896 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4188
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4188
L__State4841:
;FirmV_0_7_0.c,897 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Limit Switch Stop",1);ClearTasks(9);
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
;FirmV_0_7_0.c,898 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State4188:
;FirmV_0_7_0.c,900 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State4189
;FirmV_0_7_0.c,901 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Remote Pressed",1);ClearTasks(9);
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
;FirmV_0_7_0.c,902 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State4189:
;FirmV_0_7_0.c,903 :: 		}
L_State4184:
;FirmV_0_7_0.c,906 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4190
;FirmV_0_7_0.c,907 :: 		if(LockEnable)
	MOVF        _LockEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4191
;FirmV_0_7_0.c,908 :: 		{StartMotor(1,_Open);AddTask(ms500+1,14);SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0;M1isSlow=0;SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0;M2isSlow=0;
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
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
	MOVLW       14
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _M1isSlow+0 
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag2+0 
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,909 :: 		AddTask(ms500+RelaseTime,3);AddTask(ms500+1+RelaseTime,4);AddTask(ms500+1+RelaseTime,13);CloseDone.b2=1;}
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
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
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
	MOVLW       1
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       4
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
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
	MOVLW       1
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       13
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	BSF         _CloseDone+0, 2 
	GOTO        L_State4192
L_State4191:
;FirmV_0_7_0.c,911 :: 		{AddTask(ms500+1,13);CloseDone.b2=1;}
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
	MOVLW       13
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	BSF         _CloseDone+0, 2 
L_State4192:
L_State4190:
;FirmV_0_7_0.c,913 :: 		if(CheckTask(14))
	MOVLW       14
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4193
;FirmV_0_7_0.c,914 :: 		StartMotor(2,_Open);
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
L_State4193:
;FirmV_0_7_0.c,916 :: 		if(CheckTask(13))
	MOVLW       13
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4194
;FirmV_0_7_0.c,917 :: 		{State=1; PassFlag=0;PrevAC=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       1
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	CLRF        _PrevAC+0 
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
L_State4194:
;FirmV_0_7_0.c,919 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State4840
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State4840
	GOTO        L_State4197
L__State4840:
;FirmV_0_7_0.c,920 :: 		{ClearTasks(0);if(AutoCloseTime!=0){PrevAC=0;AddTask(ms500+AutoCloseTime,9);Logger("S4 Autoclose Renewed",1);memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;LCDLines=2;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State4958
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State4958:
	BTFSC       STATUS+0, 2 
	GOTO        L_State4198
	CLRF        _PrevAC+0 
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
L_State4198:
L_State4197:
;FirmV_0_7_0.c,922 :: 		}
L_end_State4:
	RETURN      0
; end of _State4

_State5:

;FirmV_0_7_0.c,937 :: 		void State5()
;FirmV_0_7_0.c,939 :: 		char delay=2;
	MOVLW       2
	MOVWF       State5_delay_L0+0 
;FirmV_0_7_0.c,940 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,941 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,943 :: 		if(ReturnAutoclose()!=PrevAC)
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	XORWF       _PrevAC+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_State5199
;FirmV_0_7_0.c,945 :: 		LCDFlashFlag=0;
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,946 :: 		PrevAC=ReturnAutoclose();
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	MOVWF       _PrevAC+0 
;FirmV_0_7_0.c,947 :: 		charValueToStr_AC(PrevAC,LCDLine2+11);
	MOVF        R0, 0 
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       _LCDLine2+11
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       hi_addr(_LCDLine2+11)
	MOVWF       FARG_charValueToStr_AC+1 
	CALL        _charValueToStr_AC+0, 0
;FirmV_0_7_0.c,948 :: 		memcpy(LCDLine2,"Close after",11);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr39_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr39_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       11
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,949 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,950 :: 		}
L_State5199:
;FirmV_0_7_0.c,952 :: 		if((Events.Remote!=0)||(CheckTask(9)==1))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State5849
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5849
	GOTO        L_State5202
L__State5849:
;FirmV_0_7_0.c,954 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State5848
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5848
	GOTO        L_State5205
L__State5848:
;FirmV_0_7_0.c,956 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,957 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,958 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,959 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,960 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,961 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,962 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,963 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,964 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,965 :: 		}
L_State5205:
;FirmV_0_7_0.c,966 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State5208
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State5208
L__State5847:
;FirmV_0_7_0.c,968 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,969 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,970 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,971 :: 		AddTask(temp,6);
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
;FirmV_0_7_0.c,972 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,973 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,974 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,975 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,976 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,981 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,982 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,983 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,984 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,985 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,986 :: 		temp=ms500+ActionTimeDiff+OverloadDelay+delay;
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
;FirmV_0_7_0.c,987 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,988 :: 		temp=ms500+Door2CloseTime+delay+ActionTimeDiff;
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
;FirmV_0_7_0.c,989 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,990 :: 		}
L_State5208:
;FirmV_0_7_0.c,991 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,992 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,993 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,994 :: 		KeyNoiseEliminator=0;
	CLRF        _KeyNoiseEliminator+0 
;FirmV_0_7_0.c,995 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,996 :: 		}
L_State5202:
;FirmV_0_7_0.c,998 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State5211
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State5960
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State5960:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5211
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State5211
L__State5846:
;FirmV_0_7_0.c,999 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S5 Auto Close Deleted",1);}
	MOVLW       1
	MOVWF       _PassFlag+0 
	CALL        _GetAutocloseTime+0, 0
	MOVF        R0, 0 
	MOVWF       __AC+0 
	MOVLW       ?lstr40_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr40_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State5211:
;FirmV_0_7_0.c,1001 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State5214
	BTFSC       _Events+6, 0 
	GOTO        L_State5214
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State5961
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State5961:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5214
L__State5845:
;FirmV_0_7_0.c,1004 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:",1);Logger(t,1);}
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
	MOVLW       ?lstr41_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr41_FirmV_0_7_0+0)
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
;FirmV_0_7_0.c,1006 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:",1);Logger(t,1);}
L_State5216:
;FirmV_0_7_0.c,1007 :: 		}
L_State5214:
;FirmV_0_7_0.c,1009 :: 		}
L_end_State5:
	RETURN      0
; end of _State5

_State6:

;FirmV_0_7_0.c,1029 :: 		void State6()
;FirmV_0_7_0.c,1033 :: 		char delay=3;
	MOVLW       3
	MOVWF       State6_delay_L0+0 
;FirmV_0_7_0.c,1034 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,1035 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,1037 :: 		if(ReturnAutoclose()!=PrevAC)
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	XORWF       _PrevAC+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_State6217
;FirmV_0_7_0.c,1039 :: 		LCDFlashFlag=0;
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,1040 :: 		PrevAC=ReturnAutoclose();
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	MOVWF       _PrevAC+0 
;FirmV_0_7_0.c,1041 :: 		charValueToStr_AC(PrevAC,LCDLine2+11);
	MOVF        R0, 0 
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       _LCDLine2+11
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       hi_addr(_LCDLine2+11)
	MOVWF       FARG_charValueToStr_AC+1 
	CALL        _charValueToStr_AC+0, 0
;FirmV_0_7_0.c,1042 :: 		memcpy(LCDLine2,"Close after",11);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr43_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr43_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       11
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,1043 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1044 :: 		}
L_State6217:
;FirmV_0_7_0.c,1047 :: 		if((Events.Remote!=0)||(PhotocellOpenFlag))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State6855
	MOVF        _PhotocellOpenFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6855
	GOTO        L_State6220
L__State6855:
;FirmV_0_7_0.c,1049 :: 		PhotocellOpenFlag=0;
	CLRF        _PhotocellOpenFlag+0 
;FirmV_0_7_0.c,1050 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,1051 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,1052 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1053 :: 		if(Lockenable)
	MOVF        _LockEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State6221
;FirmV_0_7_0.c,1054 :: 		AddTask(ms500+1,12);
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
L_State6221:
;FirmV_0_7_0.c,1055 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,1056 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,1057 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,1058 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,1059 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,1060 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,1061 :: 		temp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,1062 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,1063 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6224
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6224
L__State6854:
;FirmV_0_7_0.c,1065 :: 		AddTask(ms500+ActionTimeDiff+delay,2);
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
;FirmV_0_7_0.c,1066 :: 		AddTask(ms500+ActionTimeDiff+delay,6);
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
;FirmV_0_7_0.c,1067 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,1068 :: 		AddTask(ms500+ActionTimeDiff+OverloadDelay+delay,11); //overload check
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
;FirmV_0_7_0.c,1069 :: 		AddTask(ms500+Door2OpenTime+ActionTimeDiff+delay,4);//Stop motor
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
;FirmV_0_7_0.c,1070 :: 		}
L_State6224:
;FirmV_0_7_0.c,1073 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,1074 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,1075 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,1076 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,1077 :: 		KeyNoiseEliminator=0;
	CLRF        _KeyNoiseEliminator+0 
;FirmV_0_7_0.c,1078 :: 		State=8;
	MOVLW       8
	MOVWF       _State+0 
;FirmV_0_7_0.c,1079 :: 		}
L_State6220:
;FirmV_0_7_0.c,1082 :: 		if(CheckTask(9)==1)
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6225
;FirmV_0_7_0.c,1084 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State6853
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State6853
	GOTO        L_State6228
L__State6853:
;FirmV_0_7_0.c,1086 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1087 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,1088 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,1089 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,1090 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,1091 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,1092 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,1093 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,1094 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,1095 :: 		}
L_State6228:
;FirmV_0_7_0.c,1096 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6231
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6231
L__State6852:
;FirmV_0_7_0.c,1098 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1099 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,1100 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,1101 :: 		AddTask(temp,6);
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
;FirmV_0_7_0.c,1102 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,1103 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,1104 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,1105 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,1106 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,1111 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,1112 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,1113 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,1114 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,1115 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,1116 :: 		temp=ms500+ActionTimeDiff+OverloadDelay+delay;
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
;FirmV_0_7_0.c,1117 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,1118 :: 		temp=ms500+Door2CloseTime+delay+ActionTimeDiff;
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
	MOVF        State6_delay_L0+0, 0 
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
;FirmV_0_7_0.c,1119 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,1120 :: 		}
L_State6231:
;FirmV_0_7_0.c,1121 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,1122 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,1123 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,1124 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,1125 :: 		KeyNoiseEliminator=0;
	CLRF        _KeyNoiseEliminator+0 
;FirmV_0_7_0.c,1126 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,1127 :: 		}
L_State6225:
;FirmV_0_7_0.c,1129 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State6234
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6963
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State6963:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6234
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State6234
L__State6851:
;FirmV_0_7_0.c,1130 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S6 Auto Close Deleted",1);}
	MOVLW       1
	MOVWF       _PassFlag+0 
	CALL        _GetAutocloseTime+0, 0
	MOVF        R0, 0 
	MOVWF       __AC+0 
	MOVLW       ?lstr44_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr44_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State6234:
;FirmV_0_7_0.c,1132 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6237
	BTFSC       _Events+6, 0 
	GOTO        L_State6237
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6964
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State6964:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6237
L__State6850:
;FirmV_0_7_0.c,1134 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:",1);Logger(t,1);}
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
	MOVLW       ?lstr45_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr45_FirmV_0_7_0+0)
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
;FirmV_0_7_0.c,1136 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:",1);Logger(t,1);}
L_State6239:
;FirmV_0_7_0.c,1137 :: 		}
L_State6237:
;FirmV_0_7_0.c,1139 :: 		}
L_end_State6:
	RETURN      0
; end of _State6

_State7:

;FirmV_0_7_0.c,1161 :: 		void State7()
;FirmV_0_7_0.c,1163 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,1164 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,1166 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7240
;FirmV_0_7_0.c,1167 :: 		{StartMotor(1,_Close);Logger("S7 Motor1Start",1);}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       ?lstr47_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr47_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7240:
;FirmV_0_7_0.c,1169 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7241
;FirmV_0_7_0.c,1170 :: 		{StartMotor(2,_Close);Logger("S7 Motor2Start",1);memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       ?lstr48_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr48_FirmV_0_7_0+0)
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
L_State7241:
;FirmV_0_7_0.c,1172 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7242
;FirmV_0_7_0.c,1173 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S7 M1 Overload Check",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr49_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr49_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7242:
;FirmV_0_7_0.c,1175 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7243
;FirmV_0_7_0.c,1176 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S7 M2 Overload Check",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr50_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr50_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7243:
;FirmV_0_7_0.c,1178 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7244
;FirmV_0_7_0.c,1179 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S7 M1 Speed UP",1);}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
	MOVLW       ?lstr51_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr51_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7244:
;FirmV_0_7_0.c,1181 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7245
;FirmV_0_7_0.c,1182 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S7 M2 Speed UP",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       ?lstr52_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr52_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7245:
;FirmV_0_7_0.c,1184 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(CloseDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7863
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7864
	BTFSS       _Events+5, 0 
	GOTO        L__State7864
	GOTO        L__State7863
L__State7864:
	GOTO        L_State7252
L__State7863:
	BTFSS       _CloseDone+0, 0 
	GOTO        L_State7252
L__State7862:
;FirmV_0_7_0.c,1185 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S7 M1 Stoped",1);}
	BCF         _CloseDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr53_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr53_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7252:
;FirmV_0_7_0.c,1187 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(CloseDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7860
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7861
	BTFSS       _Events+5, 1 
	GOTO        L__State7861
	GOTO        L__State7860
L__State7861:
	GOTO        L_State7259
L__State7860:
	BTFSS       _CloseDone+0, 1 
	GOTO        L_State7259
L__State7859:
;FirmV_0_7_0.c,1188 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S7 M2 Stoped",1);}
	BCF         _CloseDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr54_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr54_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7259:
;FirmV_0_7_0.c,1190 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State7858
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State7858
	GOTO        L_State7262
L__State7858:
;FirmV_0_7_0.c,1191 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State7262:
;FirmV_0_7_0.c,1194 :: 		if(KeyNoiseEliminator>=NoiseEliminatorTreshold)
	MOVLW       3
	SUBWF       _KeyNoiseEliminator+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_State7263
;FirmV_0_7_0.c,1196 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State7264
;FirmV_0_7_0.c,1197 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S7 Photocell Int",1);ClearTasks(9);
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
;FirmV_0_7_0.c,1198 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State7264:
;FirmV_0_7_0.c,1200 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State7265
;FirmV_0_7_0.c,1201 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Remote Pressed",1);ClearTasks(9);
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
	MOVLW       ?lstr56_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr56_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1202 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State7265:
;FirmV_0_7_0.c,1204 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State7268
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7268
L__State7857:
;FirmV_0_7_0.c,1205 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Limit Switch Stop",1);ClearTasks(9);
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
	MOVLW       ?lstr57_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr57_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1206 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State7268:
;FirmV_0_7_0.c,1207 :: 		}
L_State7263:
;FirmV_0_7_0.c,1210 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State7269
;FirmV_0_7_0.c,1211 :: 		if(LockEnable)
	MOVF        _LockEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7270
;FirmV_0_7_0.c,1212 :: 		{StartMotor(1,_Open);AddTask(ms500+1,14);SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
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
	MOVLW       14
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _M1isSlow+0 
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag2+0 
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,1213 :: 		AddTask(ms500+RelaseTime,3);AddTask(ms500+1+RelaseTime,4);AddTask(ms500+1+RelaseTime,13);CloseDone.b2=1;}
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
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
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
	MOVLW       1
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       4
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
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
	MOVLW       1
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       13
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	BSF         _CloseDone+0, 2 
	GOTO        L_State7271
L_State7270:
;FirmV_0_7_0.c,1215 :: 		{AddTask(ms500+1,13);CloseDone.b2=1;}
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
	MOVLW       13
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	BSF         _CloseDone+0, 2 
L_State7271:
L_State7269:
;FirmV_0_7_0.c,1217 :: 		if(CheckTask(14))
	MOVLW       14
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7272
;FirmV_0_7_0.c,1218 :: 		StartMotor(2,_Open);
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
L_State7272:
;FirmV_0_7_0.c,1220 :: 		if(CheckTask(13))
	MOVLW       13
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7273
;FirmV_0_7_0.c,1221 :: 		{State=1; PassFlag=0;PrevAC=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       1
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	CLRF        _PrevAC+0 
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
L_State7273:
;FirmV_0_7_0.c,1223 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State7856
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State7856
	GOTO        L_State7276
L__State7856:
;FirmV_0_7_0.c,1224 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);PrevAC=0;Logger("S7 Autoclose Renewed",1);memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;LCDLines=2;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7966
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State7966:
	BTFSC       STATUS+0, 2 
	GOTO        L_State7277
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
	CLRF        _PrevAC+0 
	MOVLW       ?lstr58_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr58_FirmV_0_7_0+0)
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
L_State7277:
L_State7276:
;FirmV_0_7_0.c,1227 :: 		}
L_end_State7:
	RETURN      0
; end of _State7

_State8:

;FirmV_0_7_0.c,1244 :: 		void State8()
;FirmV_0_7_0.c,1246 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,1247 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,1249 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8278
;FirmV_0_7_0.c,1250 :: 		{StartMotor(1,_Open);Logger("S8 Motor1Start",1); Lock=0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       ?lstr59_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr59_FirmV_0_7_0+0)
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
L_State8278:
;FirmV_0_7_0.c,1252 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8279
;FirmV_0_7_0.c,1253 :: 		{StartMotor(2,_Open);Logger("S8 Motor2Start",1); Lock=0;}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       ?lstr60_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr60_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	BCF         PORTD+0, 6 
L_State8279:
;FirmV_0_7_0.c,1255 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8280
;FirmV_0_7_0.c,1256 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S8 Overflow Flag1 Set",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr61_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr61_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8280:
;FirmV_0_7_0.c,1258 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8281
;FirmV_0_7_0.c,1259 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S8 Overflow Flag2 Set",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr62_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr62_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8281:
;FirmV_0_7_0.c,1261 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8282
;FirmV_0_7_0.c,1262 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S8 Motor1 Fast",1);}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
	MOVLW       ?lstr63_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr63_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8282:
;FirmV_0_7_0.c,1264 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8283
;FirmV_0_7_0.c,1265 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S8 Motor2 Fast",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       ?lstr64_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr64_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8283:
;FirmV_0_7_0.c,1267 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(OpenDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8873
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8874
	BTFSS       _Events+5, 0 
	GOTO        L__State8874
	GOTO        L__State8873
L__State8874:
	GOTO        L_State8290
L__State8873:
	BTFSS       _OpenDone+0, 0 
	GOTO        L_State8290
L__State8872:
;FirmV_0_7_0.c,1268 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S8 Motor1 Stop",1);}
	BCF         _OpenDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr65_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr65_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8290:
;FirmV_0_7_0.c,1270 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(OpenDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8870
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8871
	BTFSS       _Events+5, 1 
	GOTO        L__State8871
	GOTO        L__State8870
L__State8871:
	GOTO        L_State8297
L__State8870:
	BTFSS       _OpenDone+0, 1 
	GOTO        L_State8297
L__State8869:
;FirmV_0_7_0.c,1271 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S8 Motor2 Stop",1);}
	BCF         _OpenDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr66_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr66_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8297:
;FirmV_0_7_0.c,1273 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8298
;FirmV_0_7_0.c,1274 :: 		{Lock=1;}
	BSF         PORTD+0, 6 
L_State8298:
;FirmV_0_7_0.c,1276 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State8868
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State8868
	GOTO        L_State8301
L__State8868:
;FirmV_0_7_0.c,1277 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State8301:
;FirmV_0_7_0.c,1280 :: 		if(KeyNoiseEliminator>=NoiseEliminatorTreshold)
	MOVLW       3
	SUBWF       _KeyNoiseEliminator+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_State8302
;FirmV_0_7_0.c,1282 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State8305
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8305
L__State8867:
;FirmV_0_7_0.c,1283 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S8 Photocell Int",1);ClearTasks(9);
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
;FirmV_0_7_0.c,1284 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State8305:
;FirmV_0_7_0.c,1286 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State8306
;FirmV_0_7_0.c,1287 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Motors Stoped (Remote)",1);ClearTasks(9);
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
	MOVLW       ?lstr68_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr68_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1288 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State8306:
;FirmV_0_7_0.c,1290 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State8309
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8309
L__State8866:
;FirmV_0_7_0.c,1291 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Limit Switch Stop",1);ClearTasks(9);
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
	MOVLW       ?lstr69_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr69_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1292 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State8309:
;FirmV_0_7_0.c,1293 :: 		}
L_State8302:
;FirmV_0_7_0.c,1295 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State8310
;FirmV_0_7_0.c,1297 :: 		if(AutoCloseTime!=0)
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8968
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State8968:
	BTFSC       STATUS+0, 2 
	GOTO        L_State8311
;FirmV_0_7_0.c,1298 :: 		{AddTask(ms500+AutoCloseTime,9);}
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
L_State8311:
;FirmV_0_7_0.c,1299 :: 		if(LockEnable)
	MOVF        _LockEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8312
;FirmV_0_7_0.c,1300 :: 		{StartMotor(1,_Close);StartMotor(2,_Close);SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _M1isSlow+0 
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag2+0 
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,1301 :: 		AddTask(ms500+RelaseTime,3);AddTask(ms500+RelaseTime,4);AddTask(ms500+1+RelaseTime,13);OpenDone.b2=1;}
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
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
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
	MOVLW       4
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
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
	MOVLW       1
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       13
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	BSF         _OpenDone+0, 2 
	GOTO        L_State8313
L_State8312:
;FirmV_0_7_0.c,1303 :: 		{AddTask(ms500+1,13);OpenDone.b2=1;}
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
	MOVLW       13
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	BSF         _OpenDone+0, 2 
L_State8313:
;FirmV_0_7_0.c,1304 :: 		}
L_State8310:
;FirmV_0_7_0.c,1307 :: 		if(CheckTask(13))
	MOVLW       13
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8314
;FirmV_0_7_0.c,1308 :: 		{State=2; PassFlag=0;PrevAC=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=2;}
	MOVLW       2
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	CLRF        _PrevAC+0 
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
L_State8314:
;FirmV_0_7_0.c,1310 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State8865
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State8865
	GOTO        L_State8317
L__State8865:
;FirmV_0_7_0.c,1311 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);PrevAC=0;Logger("S8 Autoclose Renewed",1);memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;LCDLines=2;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8969
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State8969:
	BTFSC       STATUS+0, 2 
	GOTO        L_State8318
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
	CLRF        _PrevAC+0 
	MOVLW       ?lstr70_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr70_FirmV_0_7_0+0)
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
L_State8318:
L_State8317:
;FirmV_0_7_0.c,1314 :: 		}
L_end_State8:
	RETURN      0
; end of _State8

_LCDUpdater:

;FirmV_0_7_0.c,1323 :: 		void LCDUpdater()
;FirmV_0_7_0.c,1328 :: 		if(LCDUpdateFlag==1)
	MOVF        _LCDUpdateFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDUpdater319
;FirmV_0_7_0.c,1330 :: 		if(LCDLines!=line)
	MOVF        _LCDLines+0, 0 
	XORWF       LCDUpdater_line_L0+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater320
;FirmV_0_7_0.c,1332 :: 		line=LCDLines;
	MOVF        _LCDLines+0, 0 
	MOVWF       LCDUpdater_line_L0+0 
;FirmV_0_7_0.c,1333 :: 		LCD_init(LCDLines);
	MOVF        _LCDLines+0, 0 
	MOVWF       FARG_LCD_Init+0 
	CALL        _LCD_Init+0, 0
;FirmV_0_7_0.c,1334 :: 		delay_ms(50);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_LCDUpdater321:
	DECFSZ      R13, 1, 1
	BRA         L_LCDUpdater321
	DECFSZ      R12, 1, 1
	BRA         L_LCDUpdater321
	DECFSZ      R11, 1, 1
	BRA         L_LCDUpdater321
	NOP
	NOP
;FirmV_0_7_0.c,1335 :: 		}
L_LCDUpdater320:
;FirmV_0_7_0.c,1336 :: 		lcd_out(1,0,LCDLine1);
	MOVLW       1
	MOVWF       FARG_LCD_out+0 
	CLRF        FARG_LCD_out+0 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_LCD_out+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_LCD_out+1 
	CALL        _LCD_out+0, 0
;FirmV_0_7_0.c,1337 :: 		if(!LCDFlash)
	MOVF        _LCDFlash+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDUpdater322
;FirmV_0_7_0.c,1338 :: 		lcd_out(2,0,LCDLine2);
	MOVLW       2
	MOVWF       FARG_LCD_out+0 
	CLRF        FARG_LCD_out+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_LCD_out+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_LCD_out+1 
	CALL        _LCD_out+0, 0
	GOTO        L_LCDUpdater323
L_LCDUpdater322:
;FirmV_0_7_0.c,1340 :: 		UpdateWhenFlashing=1;
	MOVLW       1
	MOVWF       LCDUpdater_UpdateWhenFlashing_L0+0 
L_LCDUpdater323:
;FirmV_0_7_0.c,1341 :: 		LCDUpdateFlag=0;
	CLRF        _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1342 :: 		}
L_LCDUpdater319:
;FirmV_0_7_0.c,1344 :: 		if(LCDFlash)
	MOVF        _LCDFlash+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater324
;FirmV_0_7_0.c,1346 :: 		if(((LCDFlashFlag)&&(LastLCDFlashState==0))||((LastLCDFlashState)&&(UpdatewhenFlashing)))
	MOVF        _LCDFlashFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater880
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__LCDUpdater880
	GOTO        L__LCDUpdater878
L__LCDUpdater880:
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater879
	MOVF        LCDUpdater_UpdateWhenFlashing_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater879
	GOTO        L__LCDUpdater878
L__LCDUpdater879:
	GOTO        L_LCDUpdater331
L__LCDUpdater878:
;FirmV_0_7_0.c,1347 :: 		{memcpy(LCDLineTemp,LCDLine2,16);LCDLineTemp[0]='>';LCDLineTemp[1]='>';LCDLineTemp[2]='>';LCDLineTemp[13]='<';LCDLineTemp[14]='<';LCDLineTemp[15]='<';lcd_out(2,0,LCDLineTemp);LastLCDFlashState=1;UpdatewhenFlashing=0;}
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
L_LCDUpdater331:
;FirmV_0_7_0.c,1348 :: 		if(((!LCDFlashFlag)&&(LastLCDFlashState!=0))||((!LastLCDFlashState)&&(UpdatewhenFlashing)))
	MOVF        _LCDFlashFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCDUpdater877
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater877
	GOTO        L__LCDUpdater875
L__LCDUpdater877:
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCDUpdater876
	MOVF        LCDUpdater_UpdateWhenFlashing_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater876
	GOTO        L__LCDUpdater875
L__LCDUpdater876:
	GOTO        L_LCDUpdater338
L__LCDUpdater875:
;FirmV_0_7_0.c,1349 :: 		{lcd_out(2,0,LCDLine2);LastLCDFlashState=0;UpdatewhenFlashing=0;}
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
L_LCDUpdater338:
;FirmV_0_7_0.c,1350 :: 		}
L_LCDUpdater324:
;FirmV_0_7_0.c,1353 :: 		}
L_end_LCDUpdater:
	RETURN      0
; end of _LCDUpdater

_Init:

;FirmV_0_7_0.c,1373 :: 		void Init()
;FirmV_0_7_0.c,1375 :: 		char i=0;
	CLRF        Init_i_L0+0 
;FirmV_0_7_0.c,1377 :: 		porta=0;
	CLRF        PORTA+0 
;FirmV_0_7_0.c,1378 :: 		portb=0;
	CLRF        PORTB+0 
;FirmV_0_7_0.c,1379 :: 		portc=0;
	CLRF        PORTC+0 
;FirmV_0_7_0.c,1380 :: 		portd=0;
	CLRF        PORTD+0 
;FirmV_0_7_0.c,1381 :: 		porte=0;
	CLRF        PORTE+0 
;FirmV_0_7_0.c,1382 :: 		trisa=0b101111;
	MOVLW       47
	MOVWF       TRISA+0 
;FirmV_0_7_0.c,1383 :: 		trisb=0b00000111;
	MOVLW       7
	MOVWF       TRISB+0 
;FirmV_0_7_0.c,1384 :: 		trisc=0b10000100;
	MOVLW       132
	MOVWF       TRISC+0 
;FirmV_0_7_0.c,1385 :: 		trisd=0b00111111;
	MOVLW       63
	MOVWF       TRISD+0 
;FirmV_0_7_0.c,1386 :: 		trise=0b001;
	MOVLW       1
	MOVWF       TRISE+0 
;FirmV_0_7_0.c,1387 :: 		adcon1=0b1100;  // an6, an5 and an7 is digital
	MOVLW       12
	MOVWF       ADCON1+0 
;FirmV_0_7_0.c,1393 :: 		LCDBackLight=1;
	BSF         PORTA+0, 4 
;FirmV_0_7_0.c,1394 :: 		I2C1_init(100000);
	MOVLW       100
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;FirmV_0_7_0.c,1396 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Init339:
	DECFSZ      R13, 1, 1
	BRA         L_Init339
	DECFSZ      R12, 1, 1
	BRA         L_Init339
	DECFSZ      R11, 1, 1
	BRA         L_Init339
	NOP
	NOP
;FirmV_0_7_0.c,1398 :: 		LCD_init(1);
	MOVLW       1
	MOVWF       FARG_LCD_Init+0 
	CALL        _LCD_Init+0, 0
;FirmV_0_7_0.c,1399 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,1400 :: 		delay_ms(300);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_Init340:
	DECFSZ      R13, 1, 1
	BRA         L_Init340
	DECFSZ      R12, 1, 1
	BRA         L_Init340
	DECFSZ      R11, 1, 1
	BRA         L_Init340
	NOP
	NOP
;FirmV_0_7_0.c,1401 :: 		SetContrast(20);
	MOVLW       20
	MOVWF       FARG_SetContrast+0 
	CALL        _SetContrast+0, 0
;FirmV_0_7_0.c,1404 :: 		ms500=0;
	CLRF        _ms500+0 
	CLRF        _ms500+1 
	CLRF        _ms500+2 
	CLRF        _ms500+3 
;FirmV_0_7_0.c,1405 :: 		t0con=0b10000101; //enable tmr0 and prescalar
	MOVLW       133
	MOVWF       T0CON+0 
;FirmV_0_7_0.c,1406 :: 		intcon.b7=1;   //global int enable
	BSF         INTCON+0, 7 
;FirmV_0_7_0.c,1407 :: 		intcon.b5=1;  //tmr0 int enable
	BSF         INTCON+0, 5 
;FirmV_0_7_0.c,1408 :: 		intcon.b2=0; //tmr0 flag
	BCF         INTCON+0, 2 
;FirmV_0_7_0.c,1409 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,1410 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,1413 :: 		INT1IP_bit=1;
	BSF         INT1IP_bit+0, BitPos(INT1IP_bit+0) 
;FirmV_0_7_0.c,1414 :: 		INT1E_bit=1;
	BSF         INT1E_bit+0, BitPos(INT1E_bit+0) 
;FirmV_0_7_0.c,1415 :: 		INT1F_bit=0;
	BCF         INT1F_bit+0, BitPos(INT1F_bit+0) 
;FirmV_0_7_0.c,1416 :: 		INT2IP_bit=1;
	BSF         INT2IP_bit+0, BitPos(INT2IP_bit+0) 
;FirmV_0_7_0.c,1417 :: 		INT2E_bit=1;
	BSF         INT2E_bit+0, BitPos(INT2E_bit+0) 
;FirmV_0_7_0.c,1418 :: 		INT2F_bit=0;
	BCF         INT2F_bit+0, BitPos(INT2F_bit+0) 
;FirmV_0_7_0.c,1419 :: 		INTEDG1_bit=1;
	BSF         INTEDG1_bit+0, BitPos(INTEDG1_bit+0) 
;FirmV_0_7_0.c,1420 :: 		INTEDG2_bit=1;
	BSF         INTEDG2_bit+0, BitPos(INTEDG2_bit+0) 
;FirmV_0_7_0.c,1423 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, BitPos(INT0F_bit+0) 
;FirmV_0_7_0.c,1424 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, BitPos(INT0E_bit+0) 
;FirmV_0_7_0.c,1427 :: 		for(i=0;i<20;i++)
	CLRF        Init_i_L0+0 
L_Init341:
	MOVLW       20
	SUBWF       Init_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Init342
;FirmV_0_7_0.c,1428 :: 		Tasks[i].Expired=1;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Init_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,1427 :: 		for(i=0;i<20;i++)
	INCF        Init_i_L0+0, 1 
;FirmV_0_7_0.c,1428 :: 		Tasks[i].Expired=1;
	GOTO        L_Init341
L_Init342:
;FirmV_0_7_0.c,1431 :: 		Events.Keys=0;
	CLRF        _Events+0 
;FirmV_0_7_0.c,1432 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,1433 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,1434 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,1435 :: 		Events.Remote=0;
	CLRF        _Events+4 
;FirmV_0_7_0.c,1436 :: 		Events.Overload=0;
	CLRF        _Events+5 
;FirmV_0_7_0.c,1437 :: 		Events.Photocell=0;
	CLRF        _Events+6 
;FirmV_0_7_0.c,1440 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,1443 :: 		UART1_init(115200);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       86
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;FirmV_0_7_0.c,1446 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,1450 :: 		}
L_end_Init:
	RETURN      0
; end of _Init

_TaskManager:

;FirmV_0_7_0.c,1464 :: 		void TaskManager()
;FirmV_0_7_0.c,1466 :: 		char i=0;
	CLRF        TaskManager_i_L0+0 
;FirmV_0_7_0.c,1467 :: 		for(i=0;i<20;i++)
	CLRF        TaskManager_i_L0+0 
L_TaskManager344:
	MOVLW       20
	SUBWF       TaskManager_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TaskManager345
;FirmV_0_7_0.c,1468 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Time==ms500)&&(Tasks[i].Fired==0))
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        TaskManager_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_TaskManager349
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        TaskManager_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
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
	GOTO        L__TaskManager973
	MOVF        R3, 0 
	XORWF       _ms500+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager973
	MOVF        R2, 0 
	XORWF       _ms500+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager973
	MOVF        R1, 0 
	XORWF       _ms500+0, 0 
L__TaskManager973:
	BTFSS       STATUS+0, 2 
	GOTO        L_TaskManager349
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        TaskManager_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_TaskManager349
L__TaskManager881:
;FirmV_0_7_0.c,1469 :: 		Tasks[i].Fired=1;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        TaskManager_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_TaskManager349:
;FirmV_0_7_0.c,1467 :: 		for(i=0;i<20;i++)
	INCF        TaskManager_i_L0+0, 1 
;FirmV_0_7_0.c,1469 :: 		Tasks[i].Fired=1;
	GOTO        L_TaskManager344
L_TaskManager345:
;FirmV_0_7_0.c,1470 :: 		}
L_end_TaskManager:
	RETURN      0
; end of _TaskManager

_AddTask:

;FirmV_0_7_0.c,1482 :: 		void AddTask(unsigned long OccTime,char tcode)
;FirmV_0_7_0.c,1485 :: 		for(i=0;i<20;i++)
	CLRF        AddTask_i_L0+0 
L_AddTask350:
	MOVLW       20
	SUBWF       AddTask_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AddTask351
;FirmV_0_7_0.c,1486 :: 		if(Tasks[i].Expired==1)
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_AddTask353
;FirmV_0_7_0.c,1488 :: 		Tasks[i].TaskCode=tcode;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_AddTask_tcode+0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,1489 :: 		Tasks[i].Time=OccTime;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
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
;FirmV_0_7_0.c,1490 :: 		Tasks[i].Expired=0;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;FirmV_0_7_0.c,1491 :: 		Tasks[i].Fired=0;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;FirmV_0_7_0.c,1492 :: 		break;
	GOTO        L_AddTask351
;FirmV_0_7_0.c,1493 :: 		}
L_AddTask353:
;FirmV_0_7_0.c,1485 :: 		for(i=0;i<20;i++)
	INCF        AddTask_i_L0+0, 1 
;FirmV_0_7_0.c,1493 :: 		}
	GOTO        L_AddTask350
L_AddTask351:
;FirmV_0_7_0.c,1494 :: 		}
L_end_AddTask:
	RETURN      0
; end of _AddTask

_EventHandler:

;FirmV_0_7_0.c,1504 :: 		void EventHandler()
;FirmV_0_7_0.c,1507 :: 		Events.ExternalKeys=GetExternalKeysState();
	CALL        _GetExternalKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+8 
;FirmV_0_7_0.c,1508 :: 		Events.Limiter=GetLimitSwitchState();
	CALL        _GetLimitSwitchState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+7 
;FirmV_0_7_0.c,1509 :: 		Events.Keys=GetKeysState();
	CALL        _GetKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+0 
;FirmV_0_7_0.c,1510 :: 		Events.Remote=GetRemoteState();
	CALL        _GetRemoteState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+4 
;FirmV_0_7_0.c,1511 :: 		Events.Overload=GetOverloadState();
	CALL        _GetOverloadState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+5 
;FirmV_0_7_0.c,1512 :: 		Events.Photocell=GetPhotocellState();
	CALL        _GetPhotocellState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+6 
;FirmV_0_7_0.c,1514 :: 		for(i=0;i<20;i++)
	CLRF        EventHandler_i_L0+0 
L_EventHandler354:
	MOVLW       20
	SUBWF       EventHandler_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_EventHandler355
;FirmV_0_7_0.c,1515 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Fired==1))
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler359
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler359
L__EventHandler882:
;FirmV_0_7_0.c,1517 :: 		if(Events.Task1==0)
	MOVF        _Events+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler360
;FirmV_0_7_0.c,1518 :: 		{Events.Task1=Tasks[i].TaskCode; Tasks[i].Expired=1;Tasks[i].Fired=0;}
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Events+1 
	MOVLW       5
	ADDWF       R2, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	GOTO        L_EventHandler361
L_EventHandler360:
;FirmV_0_7_0.c,1519 :: 		else if(Events.Task2==0)
	MOVF        _Events+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler362
;FirmV_0_7_0.c,1520 :: 		{Events.Task2=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Events+2 
	MOVLW       5
	ADDWF       R2, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	GOTO        L_EventHandler363
L_EventHandler362:
;FirmV_0_7_0.c,1521 :: 		else if(Events.Task3==0)
	MOVF        _Events+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler364
;FirmV_0_7_0.c,1522 :: 		{Events.Task3=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Events+3 
	MOVLW       5
	ADDWF       R2, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
L_EventHandler364:
L_EventHandler363:
L_EventHandler361:
;FirmV_0_7_0.c,1523 :: 		}
L_EventHandler359:
;FirmV_0_7_0.c,1514 :: 		for(i=0;i<20;i++)
	INCF        EventHandler_i_L0+0, 1 
;FirmV_0_7_0.c,1523 :: 		}
	GOTO        L_EventHandler354
L_EventHandler355:
;FirmV_0_7_0.c,1524 :: 		}
L_end_EventHandler:
	RETURN      0
; end of _EventHandler

_GetKeysState:

;FirmV_0_7_0.c,1534 :: 		char GetKeysState()
;FirmV_0_7_0.c,1536 :: 		unsigned res=0;
;FirmV_0_7_0.c,1540 :: 		char resch=0,fin;
	CLRF        GetKeysState_resch_L0+0 
;FirmV_0_7_0.c,1541 :: 		resch.b0=~KeyDown;
	BTFSC       PORTD+0, 5 
	GOTO        L__GetKeysState977
	BSF         GetKeysState_resch_L0+0, 0 
	GOTO        L__GetKeysState978
L__GetKeysState977:
	BCF         GetKeysState_resch_L0+0, 0 
L__GetKeysState978:
;FirmV_0_7_0.c,1542 :: 		resch.b1=~KeyMenu;
	BTFSC       PORTE+0, 0 
	GOTO        L__GetKeysState979
	BSF         GetKeysState_resch_L0+0, 1 
	GOTO        L__GetKeysState980
L__GetKeysState979:
	BCF         GetKeysState_resch_L0+0, 1 
L__GetKeysState980:
;FirmV_0_7_0.c,1543 :: 		resch.b2=~KeyUp;
	BTFSC       PORTD+0, 4 
	GOTO        L__GetKeysState981
	BSF         GetKeysState_resch_L0+0, 2 
	GOTO        L__GetKeysState982
L__GetKeysState981:
	BCF         GetKeysState_resch_L0+0, 2 
L__GetKeysState982:
;FirmV_0_7_0.c,1545 :: 		if(DebouncingDelayUnpress<DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelayUnpress+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState365
;FirmV_0_7_0.c,1546 :: 		resch=0;
	CLRF        GetKeysState_resch_L0+0 
L_GetKeysState365:
;FirmV_0_7_0.c,1548 :: 		if((resch==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState366
;FirmV_0_7_0.c,1550 :: 		if(Pressed==0)
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState367
;FirmV_0_7_0.c,1551 :: 		{Repeat=0;RepeatCount=0;Pressed=0;fin=0;RepeatRate=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        GetKeysState_RepeatCount_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState367:
;FirmV_0_7_0.c,1552 :: 		if(Pressed==1)
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState368
;FirmV_0_7_0.c,1553 :: 		if(DebouncingDelayPress>=DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelayPress+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetKeysState369
;FirmV_0_7_0.c,1554 :: 		{Repeat=0;RepeatCount=0;Pressed=0;fin=0;RepeatRate=0;DebouncingDelayUnpress=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        GetKeysState_RepeatCount_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
	CLRF        _DebouncingDelayUnpress+0 
L_GetKeysState369:
L_GetKeysState368:
;FirmV_0_7_0.c,1555 :: 		}
L_GetKeysState366:
;FirmV_0_7_0.c,1560 :: 		if((Repeat==1)&&(KeyFlag>=RepeatSpeed))
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState372
	MOVF        GetKeysState_RepeatSpeed_L0+0, 0 
	SUBWF       _KeyFlag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetKeysState372
L__GetKeysState887:
;FirmV_0_7_0.c,1561 :: 		{RepeatRate=1;KeyFlag=0;if(RepeatCount<25)RepeatCount=RepeatCount+1;}
	MOVLW       1
	MOVWF       GetKeysState_RepeatRate_L0+0 
	CLRF        _KeyFlag+0 
	MOVLW       25
	SUBWF       GetKeysState_RepeatCount_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState373
	INCF        GetKeysState_RepeatCount_L0+0, 1 
L_GetKeysState373:
L_GetKeysState372:
;FirmV_0_7_0.c,1565 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0)&&(ms500==PressTime+KeyRepeatDelay))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState376
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState376
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState376
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
	GOTO        L__GetKeysState983
	MOVF        _ms500+2, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState983
	MOVF        _ms500+1, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState983
	MOVF        _ms500+0, 0 
	XORWF       R1, 0 
L__GetKeysState983:
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState376
L__GetKeysState886:
;FirmV_0_7_0.c,1566 :: 		{Repeat=1;KeyFlag=0;}
	MOVLW       1
	MOVWF       GetKeysState_Repeat_L0+0 
	CLRF        _KeyFlag+0 
L_GetKeysState376:
;FirmV_0_7_0.c,1568 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState379
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState379
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState379
L__GetKeysState885:
;FirmV_0_7_0.c,1569 :: 		fin=0;
	CLRF        GetKeysState_fin_L0+0 
L_GetKeysState379:
;FirmV_0_7_0.c,1571 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==1))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState382
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState382
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState382
L__GetKeysState884:
;FirmV_0_7_0.c,1572 :: 		{fin=resch*RepeatRate;RepeatRate=0;}
	MOVF        GetKeysState_resch_L0+0, 0 
	MULWF       GetKeysState_RepeatRate_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState382:
;FirmV_0_7_0.c,1575 :: 		if((resch!=0)&&(Pressed==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState385
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState385
L__GetKeysState883:
;FirmV_0_7_0.c,1576 :: 		{fin=resch; Pressed=1;PressTime=ms500;DebouncingDelayPress=0;}
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
	CLRF        _DebouncingDelayPress+0 
L_GetKeysState385:
;FirmV_0_7_0.c,1579 :: 		if(fin != 0)
	MOVF        GetKeysState_fin_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState386
;FirmV_0_7_0.c,1580 :: 		BuzzFlag=1;
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_GetKeysState386:
;FirmV_0_7_0.c,1582 :: 		return fin;
	MOVF        GetKeysState_fin_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1583 :: 		}
L_end_GetKeysState:
	RETURN      0
; end of _GetKeysState

_GetExternalKeysState:

;FirmV_0_7_0.c,1593 :: 		char GetExternalKeysState()
;FirmV_0_7_0.c,1595 :: 		char out=0;
	CLRF        GetExternalKeysState_out_L0+0 
;FirmV_0_7_0.c,1596 :: 		if(KeyUp==0)
	BTFSC       PORTD+0, 4 
	GOTO        L_GetExternalKeysState387
;FirmV_0_7_0.c,1597 :: 		out.b0=1;
	BSF         GetExternalKeysState_out_L0+0, 0 
L_GetExternalKeysState387:
;FirmV_0_7_0.c,1598 :: 		if(KeyDown==0)
	BTFSC       PORTD+0, 5 
	GOTO        L_GetExternalKeysState388
;FirmV_0_7_0.c,1599 :: 		out.b1=1;
	BSF         GetExternalKeysState_out_L0+0, 1 
L_GetExternalKeysState388:
;FirmV_0_7_0.c,1600 :: 		return out;
	MOVF        GetExternalKeysState_out_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1601 :: 		}
L_end_GetExternalKeysState:
	RETURN      0
; end of _GetExternalKeysState

_GetLimitSwitchState:

;FirmV_0_7_0.c,1614 :: 		char GetLimitSwitchState()
;FirmV_0_7_0.c,1616 :: 		if((Limit1==0)||(Limit2==0))
	BTFSS       PORTD+0, 0 
	GOTO        L__GetLimitSwitchState888
	BTFSS       PORTD+0, 1 
	GOTO        L__GetLimitSwitchState888
	GOTO        L_GetLimitSwitchState391
L__GetLimitSwitchState888:
;FirmV_0_7_0.c,1617 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_GetLimitSwitchState
L_GetLimitSwitchState391:
;FirmV_0_7_0.c,1619 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1620 :: 		}
L_end_GetLimitSwitchState:
	RETURN      0
; end of _GetLimitSwitchState

_GetRemoteState:

;FirmV_0_7_0.c,1629 :: 		char GetRemoteState()
;FirmV_0_7_0.c,1631 :: 		char res=0;
	CLRF        GetRemoteState_res_L0+0 
;FirmV_0_7_0.c,1632 :: 		res.b0=RemoteAFlag.b0;
	BTFSC       _RemoteAFlag+0, 0 
	GOTO        L__GetRemoteState987
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState988
L__GetRemoteState987:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState988:
;FirmV_0_7_0.c,1633 :: 		res.b1=RemoteBFlag.b0;
	BTFSC       _RemoteBFlag+0, 0 
	GOTO        L__GetRemoteState989
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState990
L__GetRemoteState989:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState990:
;FirmV_0_7_0.c,1634 :: 		RemoteAFlag=0;
	CLRF        _RemoteAFlag+0 
;FirmV_0_7_0.c,1635 :: 		RemoteBFlag=0;
	CLRF        _RemoteBFlag+0 
;FirmV_0_7_0.c,1638 :: 		if(State<20)
	MOVLW       20
	SUBWF       _State+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetRemoteState393
;FirmV_0_7_0.c,1640 :: 		res.b0=res.b0|Events.Keys.b2;//up key
	BTFSC       GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState991
	BTFSC       _Events+0, 2 
	GOTO        L__GetRemoteState991
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState992
L__GetRemoteState991:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState992:
;FirmV_0_7_0.c,1641 :: 		res.b1=res.b1|Events.Keys.b0;//down key
	BTFSC       GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState993
	BTFSC       _Events+0, 0 
	GOTO        L__GetRemoteState993
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState994
L__GetRemoteState993:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState994:
;FirmV_0_7_0.c,1642 :: 		}
L_GetRemoteState393:
;FirmV_0_7_0.c,1644 :: 		return res;
	MOVF        GetRemoteState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1645 :: 		}
L_end_GetRemoteState:
	RETURN      0
; end of _GetRemoteState

_GetOverloadState:

;FirmV_0_7_0.c,1655 :: 		char GetOverloadState()
;FirmV_0_7_0.c,1657 :: 		char res=0;
	CLRF        GetOverloadState_res_L0+0 
;FirmV_0_7_0.c,1659 :: 		VCapM1=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _VCapM1+0 
	MOVF        R1, 0 
	MOVWF       _VCapM1+1 
;FirmV_0_7_0.c,1660 :: 		VCapM2=ADC_Read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _VCapM2+0 
	MOVF        R1, 0 
	MOVWF       _VCapM2+1 
;FirmV_0_7_0.c,1663 :: 		if(OverloadCheckFlag1==0)
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetOverloadState394
;FirmV_0_7_0.c,1664 :: 		OverloadCounter1=0;
	CLRF        _OverloadCounter1+0 
	CLRF        _OverloadCounter1+1 
L_GetOverloadState394:
;FirmV_0_7_0.c,1666 :: 		if(OverloadCheckFlag2==0)
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetOverloadState395
;FirmV_0_7_0.c,1667 :: 		OverloadCounter2=0;
	CLRF        _OverloadCounter2+0 
	CLRF        _OverloadCounter2+1 
L_GetOverloadState395:
;FirmV_0_7_0.c,1670 :: 		if(Motor1FullSpeed!=0)
	MOVF        _Motor1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState396
;FirmV_0_7_0.c,1674 :: 		if(VCapM1<OverloadTreshold1)
	MOVF        _OverloadTreshold1+1, 0 
	SUBWF       _VCapM1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState996
	MOVF        _OverloadTreshold1+0, 0 
	SUBWF       _VCapM1+0, 0 
L__GetOverloadState996:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState397
;FirmV_0_7_0.c,1676 :: 		if(OverloadCounter1<65530)
	MOVLW       255
	SUBWF       _OverloadCounter1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState997
	MOVLW       250
	SUBWF       _OverloadCounter1+0, 0 
L__GetOverloadState997:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState398
;FirmV_0_7_0.c,1677 :: 		OverloadCounter1=OverloadCounter1+1;
	INFSNZ      _OverloadCounter1+0, 1 
	INCF        _OverloadCounter1+1, 1 
L_GetOverloadState398:
;FirmV_0_7_0.c,1678 :: 		}
	GOTO        L_GetOverloadState399
L_GetOverloadState397:
;FirmV_0_7_0.c,1681 :: 		if(OverloadCounter1>0)
	MOVLW       0
	MOVWF       R0 
	MOVF        _OverloadCounter1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState998
	MOVF        _OverloadCounter1+0, 0 
	SUBLW       0
L__GetOverloadState998:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState400
;FirmV_0_7_0.c,1682 :: 		OverloadCounter1=OverloadCounter1-1;
	MOVLW       1
	SUBWF       _OverloadCounter1+0, 1 
	MOVLW       0
	SUBWFB      _OverloadCounter1+1, 1 
L_GetOverloadState400:
;FirmV_0_7_0.c,1683 :: 		}
L_GetOverloadState399:
;FirmV_0_7_0.c,1684 :: 		}
	GOTO        L_GetOverloadState401
L_GetOverloadState396:
;FirmV_0_7_0.c,1686 :: 		{OverloadCounter1=0;}
	CLRF        _OverloadCounter1+0 
	CLRF        _OverloadCounter1+1 
L_GetOverloadState401:
;FirmV_0_7_0.c,1688 :: 		if (OverloadCounter1>OverloadDuration1)
	MOVF        _OverloadCounter1+1, 0 
	SUBWF       _OverloadDuration1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState999
	MOVF        _OverloadCounter1+0, 0 
	SUBWF       _OverloadDuration1+0, 0 
L__GetOverloadState999:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState402
;FirmV_0_7_0.c,1689 :: 		res.b0=1;
	BSF         GetOverloadState_res_L0+0, 0 
L_GetOverloadState402:
;FirmV_0_7_0.c,1694 :: 		if(Motor2FullSpeed!=0)
	MOVF        _Motor2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState403
;FirmV_0_7_0.c,1696 :: 		if(VCapM2<OverloadTreshold2)
	MOVF        _OverloadTreshold2+1, 0 
	SUBWF       _VCapM2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState1000
	MOVF        _OverloadTreshold2+0, 0 
	SUBWF       _VCapM2+0, 0 
L__GetOverloadState1000:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState404
;FirmV_0_7_0.c,1698 :: 		if(OverloadCounter2<65530)
	MOVLW       255
	SUBWF       _OverloadCounter2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState1001
	MOVLW       250
	SUBWF       _OverloadCounter2+0, 0 
L__GetOverloadState1001:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState405
;FirmV_0_7_0.c,1699 :: 		OverloadCounter2=OverloadCounter2+1;
	INFSNZ      _OverloadCounter2+0, 1 
	INCF        _OverloadCounter2+1, 1 
L_GetOverloadState405:
;FirmV_0_7_0.c,1700 :: 		}
	GOTO        L_GetOverloadState406
L_GetOverloadState404:
;FirmV_0_7_0.c,1703 :: 		if(OverloadCounter2>0)
	MOVLW       0
	MOVWF       R0 
	MOVF        _OverloadCounter2+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState1002
	MOVF        _OverloadCounter2+0, 0 
	SUBLW       0
L__GetOverloadState1002:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState407
;FirmV_0_7_0.c,1704 :: 		OverloadCounter2=OverloadCounter2-1;
	MOVLW       1
	SUBWF       _OverloadCounter2+0, 1 
	MOVLW       0
	SUBWFB      _OverloadCounter2+1, 1 
L_GetOverloadState407:
;FirmV_0_7_0.c,1705 :: 		}
L_GetOverloadState406:
;FirmV_0_7_0.c,1706 :: 		}
	GOTO        L_GetOverloadState408
L_GetOverloadState403:
;FirmV_0_7_0.c,1708 :: 		{OverloadCounter2=0;}
	CLRF        _OverloadCounter2+0 
	CLRF        _OverloadCounter2+1 
L_GetOverloadState408:
;FirmV_0_7_0.c,1711 :: 		if (OverloadCounter2>OverloadDuration2)
	MOVF        _OverloadCounter2+1, 0 
	SUBWF       _OverloadDuration2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState1003
	MOVF        _OverloadCounter2+0, 0 
	SUBWF       _OverloadDuration2+0, 0 
L__GetOverloadState1003:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState409
;FirmV_0_7_0.c,1712 :: 		res.b1=1;
	BSF         GetOverloadState_res_L0+0, 1 
L_GetOverloadState409:
;FirmV_0_7_0.c,1714 :: 		return res;
	MOVF        GetOverloadState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1715 :: 		}
L_end_GetOverloadState:
	RETURN      0
; end of _GetOverloadState

_GetPhotocellState:

;FirmV_0_7_0.c,1728 :: 		char GetPhotocellState()
;FirmV_0_7_0.c,1730 :: 		if(Phcell2==0)
	BTFSC       PORTD+0, 2 
	GOTO        L_GetPhotocellState410
;FirmV_0_7_0.c,1731 :: 		{if(PhotocellCount<=20)PhotocellCount=PhotocellCount+1;}
	MOVF        _PhotocellCount+0, 0 
	SUBLW       20
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState411
	INCF        _PhotocellCount+0, 1 
L_GetPhotocellState411:
	GOTO        L_GetPhotocellState412
L_GetPhotocellState410:
;FirmV_0_7_0.c,1733 :: 		{PhotocellCount=0;}
	CLRF        _PhotocellCount+0 
L_GetPhotocellState412:
;FirmV_0_7_0.c,1734 :: 		if(PhotocellCount>=20)
	MOVLW       20
	SUBWF       _PhotocellCount+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState413
;FirmV_0_7_0.c,1735 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_GetPhotocellState
L_GetPhotocellState413:
;FirmV_0_7_0.c,1737 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1738 :: 		}
L_end_GetPhotocellState:
	RETURN      0
; end of _GetPhotocellState

_SetMotorSpeed:

;FirmV_0_7_0.c,1750 :: 		void SetMotorSpeed(char M1FullSpeed,char M2FullSpeed)
;FirmV_0_7_0.c,1752 :: 		if((M1FullSpeed==0)||(M2FullSpeed==0))
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed889
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed889
	GOTO        L_SetMotorSpeed417
L__SetMotorSpeed889:
;FirmV_0_7_0.c,1753 :: 		INT0E_bit=1;
	BSF         INT0E_bit+0, BitPos(INT0E_bit+0) 
	GOTO        L_SetMotorSpeed418
L_SetMotorSpeed417:
;FirmV_0_7_0.c,1755 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, BitPos(INT0E_bit+0) 
L_SetMotorSpeed418:
;FirmV_0_7_0.c,1757 :: 		Motor1FullSpeed=M1FullSpeed;
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	MOVWF       _Motor1FullSpeed+0 
;FirmV_0_7_0.c,1758 :: 		Motor2FullSpeed=M2FullSpeed;
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	MOVWF       _Motor2FullSpeed+0 
;FirmV_0_7_0.c,1759 :: 		}
L_end_SetMotorSpeed:
	RETURN      0
; end of _SetMotorSpeed

_OverloadInit:

;FirmV_0_7_0.c,1770 :: 		void OverloadInit(char ch)
;FirmV_0_7_0.c,1772 :: 		if(ch==1)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit419
;FirmV_0_7_0.c,1774 :: 		OverloadCounter1=0;
	CLRF        _OverloadCounter1+0 
	CLRF        _OverloadCounter1+1 
;FirmV_0_7_0.c,1775 :: 		Events.Overload.b0=0;
	BCF         _Events+5, 0 
;FirmV_0_7_0.c,1776 :: 		}
L_OverloadInit419:
;FirmV_0_7_0.c,1778 :: 		if(ch==2)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit420
;FirmV_0_7_0.c,1780 :: 		OverloadCounter2=0;
	CLRF        _OverloadCounter2+0 
	CLRF        _OverloadCounter2+1 
;FirmV_0_7_0.c,1781 :: 		Events.Overload.b1=0;
	BCF         _Events+5, 1 
;FirmV_0_7_0.c,1782 :: 		}
L_OverloadInit420:
;FirmV_0_7_0.c,1783 :: 		}
L_end_OverloadInit:
	RETURN      0
; end of _OverloadInit

_SaveConfigs:

;FirmV_0_7_0.c,1794 :: 		void SaveConfigs()
;FirmV_0_7_0.c,1797 :: 		EEPROM_Write(1,Door1OpenTime);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1798 :: 		EEPROM_Write(2,Door2OpenTime);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1799 :: 		EEPROM_Write(3,Door1CloseTime);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1800 :: 		EEPROM_Write(4,Door2CloseTime);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1801 :: 		EEPROM_Write(5,ActionTimeDiff);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1802 :: 		EEPROM_Write(6,OpenSoftStartTime);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1803 :: 		EEPROM_Write(7,OpenSoftStopTime);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1804 :: 		EEPROM_Write(8,CloseSoftStartTime);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1805 :: 		EEPROM_Write(9,CloseSoftStopTime);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1806 :: 		EEPROM_Write(10,Hi(AutoCloseTime));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1807 :: 		EEPROM_Write(11,Lo(AutoCloseTime));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1808 :: 		EEPROM_Write(12,OverloadSens1);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OverloadSens1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1809 :: 		EEPROM_Write(13,CloseAfterPass);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1810 :: 		EEPROM_Write(14,LockForce);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _LockForce+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1811 :: 		EEPROM_Write(15,OpenPhEnable);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenPhEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1812 :: 		EEPROM_Write(16,LimiterEnable);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _LimiterEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1813 :: 		EEPROM_Write(17,LockEnable);
	MOVLW       17
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _LockEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1814 :: 		EEPROM_Write(18,OverloadTime1);
	MOVLW       18
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OverloadTime1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1815 :: 		EEPROM_Write(19,OverloadSens2);
	MOVLW       19
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OverloadSens2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1816 :: 		EEPROM_Write(20,OverloadTime2);
	MOVLW       20
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OverloadTime2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1817 :: 		SetOverloadParams(OverloadSens1,OverloadTime1,OverloadSens2,OverloadTime2);
	MOVF        _OverloadSens1+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadTime1+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadSens2+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadTime2+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1819 :: 		}
L_end_SaveConfigs:
	RETURN      0
; end of _SaveConfigs

_LoadConfigs:

;FirmV_0_7_0.c,1832 :: 		void LoadConfigs()
;FirmV_0_7_0.c,1834 :: 		Door1OpenTime=EEPROM_Read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1835 :: 		Door2OpenTime=EEPROM_Read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1836 :: 		Door1CloseTime=EEPROM_Read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1837 :: 		Door2CloseTime=EEPROM_Read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1838 :: 		ActionTimeDiff=EEPROM_Read(5);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1839 :: 		OpenSoftStartTime=EEPROM_Read(6);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1840 :: 		OpenSoftStopTime=EEPROM_Read(7);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1841 :: 		CloseSoftStartTime=EEPROM_Read(8);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1842 :: 		CloseSoftStopTime=EEPROM_Read(9);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1843 :: 		AutoCloseTime=EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _AutoCloseTime+0 
	MOVLW       0
	MOVWF       _AutoCloseTime+1 
;FirmV_0_7_0.c,1844 :: 		AutoCloseTime=AutoCloseTime<<8;
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       _AutoCloseTime+1 
	CLRF        _AutoCloseTime+0 
;FirmV_0_7_0.c,1845 :: 		AutoCloseTime=AutocloseTime|EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	IORWF       _AutoCloseTime+0, 1 
	MOVLW       0
	IORWF       _AutoCloseTime+1, 1 
;FirmV_0_7_0.c,1846 :: 		OverloadSens1=EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadSens1+0 
;FirmV_0_7_0.c,1847 :: 		CloseAfterPass=EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseAfterPass+0 
;FirmV_0_7_0.c,1848 :: 		LockForce=EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockForce+0 
;FirmV_0_7_0.c,1849 :: 		OpenPhEnable=EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenPhEnable+0 
;FirmV_0_7_0.c,1850 :: 		LimiterEnable=EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LimiterEnable+0 
;FirmV_0_7_0.c,1851 :: 		LockEnable=EEPROM_Read(17);
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockEnable+0 
;FirmV_0_7_0.c,1852 :: 		OverloadTime1=EEPROM_Read(18);
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadTime1+0 
;FirmV_0_7_0.c,1853 :: 		OverloadSens2=EEPROM_Read(19);
	MOVLW       19
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadSens2+0 
;FirmV_0_7_0.c,1854 :: 		OverloadTime2=EEPROM_Read(20);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadTime2+0 
;FirmV_0_7_0.c,1855 :: 		SetOverloadParams(OverloadSens1,OverloadTime1,OverloadSens2,OverloadTime2);
	MOVF        _OverloadSens1+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadTime1+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadSens2+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        R0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1857 :: 		}
L_end_LoadConfigs:
	RETURN      0
; end of _LoadConfigs

_FactorySettings:

;FirmV_0_7_0.c,1870 :: 		void FactorySettings()
;FirmV_0_7_0.c,1872 :: 		Door1OpenTime=20;
	MOVLW       20
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1873 :: 		Door1CloseTime=20;
	MOVLW       20
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1874 :: 		Door2OpenTime=20;
	MOVLW       20
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1875 :: 		Door2CloseTime=20;
	MOVLW       20
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1876 :: 		OverloadSens1=7;
	MOVLW       7
	MOVWF       _OverloadSens1+0 
;FirmV_0_7_0.c,1877 :: 		OverloadTime1=2;
	MOVLW       2
	MOVWF       _OverloadTime1+0 
;FirmV_0_7_0.c,1878 :: 		OverloadSens2=7;
	MOVLW       7
	MOVWF       _OverloadSens2+0 
;FirmV_0_7_0.c,1879 :: 		OverloadTime2=2;
	MOVLW       2
	MOVWF       _OverloadTime2+0 
;FirmV_0_7_0.c,1880 :: 		SetOverloadParams(7,2,7,2);
	MOVLW       7
	MOVWF       FARG_SetOverloadParams+0 
	MOVLW       2
	MOVWF       FARG_SetOverloadParams+0 
	MOVLW       7
	MOVWF       FARG_SetOverloadParams+0 
	MOVLW       2
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1881 :: 		OpenSoftStopTime=10;
	MOVLW       10
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1882 :: 		OpenSoftStartTime=4;
	MOVLW       4
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1883 :: 		CloseSoftStopTime=10;
	MOVLW       10
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1884 :: 		CloseSoftStartTime=4;
	MOVLW       4
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1885 :: 		ActionTimeDiff=12;
	MOVLW       12
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1886 :: 		AutoCloseTime=0;
	CLRF        _AutoCloseTime+0 
	CLRF        _AutoCloseTime+1 
;FirmV_0_7_0.c,1887 :: 		LockForce=0;
	CLRF        _LockForce+0 
;FirmV_0_7_0.c,1888 :: 		OpenPhEnable=0;
	CLRF        _OpenPhEnable+0 
;FirmV_0_7_0.c,1889 :: 		LimiterEnable=0;
	CLRF        _LimiterEnable+0 
;FirmV_0_7_0.c,1890 :: 		CloseAfterPass=0;
	CLRF        _CloseAfterPass+0 
;FirmV_0_7_0.c,1891 :: 		LockEnable=1;
	MOVLW       1
	MOVWF       _LockEnable+0 
;FirmV_0_7_0.c,1893 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,1894 :: 		}
L_end_FactorySettings:
	RETURN      0
; end of _FactorySettings

_StartMotor:

;FirmV_0_7_0.c,1900 :: 		void StartMotor(char Mx,char Dir)
;FirmV_0_7_0.c,1902 :: 		if(Mx==1)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor421
;FirmV_0_7_0.c,1904 :: 		Motor1Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor1011
	BCF         PORTC+0, 1 
	GOTO        L__StartMotor1012
L__StartMotor1011:
	BSF         PORTC+0, 1 
L__StartMotor1012:
;FirmV_0_7_0.c,1905 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_StartMotor422:
	DECFSZ      R13, 1, 1
	BRA         L_StartMotor422
	DECFSZ      R12, 1, 1
	BRA         L_StartMotor422
	DECFSZ      R11, 1, 1
	BRA         L_StartMotor422
	NOP
	NOP
;FirmV_0_7_0.c,1906 :: 		Motor1Start=1;
	MOVLW       1
	MOVWF       _Motor1Start+0 
;FirmV_0_7_0.c,1907 :: 		Motor1=1;
	BSF         PORTB+0, 3 
;FirmV_0_7_0.c,1908 :: 		}
L_StartMotor421:
;FirmV_0_7_0.c,1910 :: 		if(Mx==2)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor423
;FirmV_0_7_0.c,1912 :: 		Motor2Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor1013
	BCF         PORTC+0, 0 
	GOTO        L__StartMotor1014
L__StartMotor1013:
	BSF         PORTC+0, 0 
L__StartMotor1014:
;FirmV_0_7_0.c,1913 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_StartMotor424:
	DECFSZ      R13, 1, 1
	BRA         L_StartMotor424
	DECFSZ      R12, 1, 1
	BRA         L_StartMotor424
	DECFSZ      R11, 1, 1
	BRA         L_StartMotor424
	NOP
	NOP
;FirmV_0_7_0.c,1914 :: 		Motor2Start=1;
	MOVLW       1
	MOVWF       _Motor2Start+0 
;FirmV_0_7_0.c,1915 :: 		Motor2=1;
	BSF         PORTB+0, 4 
;FirmV_0_7_0.c,1916 :: 		}
L_StartMotor423:
;FirmV_0_7_0.c,1917 :: 		}
L_end_StartMotor:
	RETURN      0
; end of _StartMotor

_StopMotor:

;FirmV_0_7_0.c,1920 :: 		void StopMotor(char Mx)
;FirmV_0_7_0.c,1922 :: 		if(Mx==1)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor425
;FirmV_0_7_0.c,1924 :: 		Motor1Start=0;
	CLRF        _Motor1Start+0 
;FirmV_0_7_0.c,1925 :: 		Motor1=0;
	BCF         PORTB+0, 3 
;FirmV_0_7_0.c,1926 :: 		}
L_StopMotor425:
;FirmV_0_7_0.c,1928 :: 		if(Mx==2)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor426
;FirmV_0_7_0.c,1930 :: 		Motor2Start=0;
	CLRF        _Motor2Start+0 
;FirmV_0_7_0.c,1931 :: 		Motor2=0;
	BCF         PORTB+0, 4 
;FirmV_0_7_0.c,1932 :: 		}
L_StopMotor426:
;FirmV_0_7_0.c,1933 :: 		}
L_end_StopMotor:
	RETURN      0
; end of _StopMotor

_CheckTask:

;FirmV_0_7_0.c,1945 :: 		char CheckTask(char TaskCode)
;FirmV_0_7_0.c,1947 :: 		if(Events.Task1==TaskCode)
	MOVF        _Events+1, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask427
;FirmV_0_7_0.c,1948 :: 		{Events.Task1=0; return 1;}
	CLRF        _Events+1 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckTask
L_CheckTask427:
;FirmV_0_7_0.c,1950 :: 		if(Events.Task2==TaskCode)
	MOVF        _Events+2, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask428
;FirmV_0_7_0.c,1951 :: 		{Events.Task2=0; return 1;}
	CLRF        _Events+2 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckTask
L_CheckTask428:
;FirmV_0_7_0.c,1953 :: 		if(Events.Task3==TaskCode)
	MOVF        _Events+3, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask429
;FirmV_0_7_0.c,1954 :: 		{Events.Task3=0; return 1;}
	CLRF        _Events+3 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckTask
L_CheckTask429:
;FirmV_0_7_0.c,1956 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1958 :: 		}
L_end_CheckTask:
	RETURN      0
; end of _CheckTask

_ReturnAutoclose:

;FirmV_0_7_0.c,1966 :: 		char ReturnAutoclose()
;FirmV_0_7_0.c,1970 :: 		for(i=0;i<20;i++)
	CLRF        ReturnAutoclose_i_L0+0 
L_ReturnAutoclose430:
	MOVLW       20
	SUBWF       ReturnAutoclose_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ReturnAutoclose431
;FirmV_0_7_0.c,1972 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode==9))
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ReturnAutoclose_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ReturnAutoclose435
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ReturnAutoclose_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_ReturnAutoclose435
L__ReturnAutoclose890:
;FirmV_0_7_0.c,1973 :: 		{t=Tasks[i].Time;break;}
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ReturnAutoclose_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
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
	GOTO        L_ReturnAutoclose431
L_ReturnAutoclose435:
;FirmV_0_7_0.c,1970 :: 		for(i=0;i<20;i++)
	INCF        ReturnAutoclose_i_L0+0, 1 
;FirmV_0_7_0.c,1974 :: 		}
	GOTO        L_ReturnAutoclose430
L_ReturnAutoclose431:
;FirmV_0_7_0.c,1976 :: 		if(i>=20) i=0;
	MOVLW       20
	SUBWF       ReturnAutoclose_i_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ReturnAutoclose436
	CLRF        ReturnAutoclose_i_L0+0 
	GOTO        L_ReturnAutoclose437
L_ReturnAutoclose436:
;FirmV_0_7_0.c,1977 :: 		else i=t-ms500;
	MOVF        _ms500+0, 0 
	SUBWF       ReturnAutoclose_t_L0+0, 0 
	MOVWF       ReturnAutoclose_i_L0+0 
L_ReturnAutoclose437:
;FirmV_0_7_0.c,1978 :: 		return i;
	MOVF        ReturnAutoclose_i_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1979 :: 		}
L_end_ReturnAutoclose:
	RETURN      0
; end of _ReturnAutoclose

_GetAutocloseTime:

;FirmV_0_7_0.c,1989 :: 		char GetAutocloseTime()
;FirmV_0_7_0.c,1993 :: 		for(i=0;i<20;i++)
	CLRF        GetAutocloseTime_i_L0+0 
L_GetAutocloseTime438:
	MOVLW       20
	SUBWF       GetAutocloseTime_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetAutocloseTime439
;FirmV_0_7_0.c,1995 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode==9))
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        GetAutocloseTime_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetAutocloseTime443
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        GetAutocloseTime_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_GetAutocloseTime443
L__GetAutocloseTime891:
;FirmV_0_7_0.c,1996 :: 		{t=Tasks[i].Time;Tasks[i].Expired=1;break;}
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        GetAutocloseTime_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
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
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	GOTO        L_GetAutocloseTime439
L_GetAutocloseTime443:
;FirmV_0_7_0.c,1993 :: 		for(i=0;i<20;i++)
	INCF        GetAutocloseTime_i_L0+0, 1 
;FirmV_0_7_0.c,1997 :: 		}
	GOTO        L_GetAutocloseTime438
L_GetAutocloseTime439:
;FirmV_0_7_0.c,1998 :: 		i=t-ms500;
	MOVF        _ms500+0, 0 
	SUBWF       GetAutocloseTime_t_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       GetAutocloseTime_i_L0+0 
;FirmV_0_7_0.c,1999 :: 		if(i>=20) i=0;
	MOVLW       20
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetAutocloseTime444
	CLRF        GetAutocloseTime_i_L0+0 
L_GetAutocloseTime444:
;FirmV_0_7_0.c,2000 :: 		return i;
	MOVF        GetAutocloseTime_i_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,2001 :: 		}
L_end_GetAutocloseTime:
	RETURN      0
; end of _GetAutocloseTime

_ClearTasks:

;FirmV_0_7_0.c,2018 :: 		void ClearTasks(char except)
;FirmV_0_7_0.c,2021 :: 		for(i=0;i<20;i++)
	CLRF        ClearTasks_i_L0+0 
L_ClearTasks445:
	MOVLW       20
	SUBWF       ClearTasks_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ClearTasks446
;FirmV_0_7_0.c,2022 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode!=except))
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ClearTasks_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ClearTasks450
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ClearTasks_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORWF       FARG_ClearTasks_except+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ClearTasks450
L__ClearTasks892:
;FirmV_0_7_0.c,2023 :: 		Tasks[i].Expired=1;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ClearTasks_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_ClearTasks450:
;FirmV_0_7_0.c,2021 :: 		for(i=0;i<20;i++)
	INCF        ClearTasks_i_L0+0, 1 
;FirmV_0_7_0.c,2023 :: 		Tasks[i].Expired=1;
	GOTO        L_ClearTasks445
L_ClearTasks446:
;FirmV_0_7_0.c,2024 :: 		}
L_end_ClearTasks:
	RETURN      0
; end of _ClearTasks

_Menu0:

;FirmV_0_7_0.c,2039 :: 		void Menu0()
;FirmV_0_7_0.c,2041 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2042 :: 		memcpy(LCDLine2,"                ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr71_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr71_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2044 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0451
;FirmV_0_7_0.c,2045 :: 		{memcpy(LCDLine1,"00 Learning Mode",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr72_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr72_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2046 :: 		if(LearningMode==0)memcpy(LCDLine2,"      Auto      ",16);
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0452
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr73_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr73_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0452:
;FirmV_0_7_0.c,2047 :: 		if(LearningMode==1)memcpy(LCDLine2,"     Manual     ",16);}
	MOVF        _LearningMode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0453
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr74_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr74_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0453:
L_Menu0451:
;FirmV_0_7_0.c,2049 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0454
;FirmV_0_7_0.c,2050 :: 		{memcpy(LCDLine1,"01 D1 Open Time ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2051 :: 		charValueToStr(Door1OpenTime,LCDLine2+6);}
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0454:
;FirmV_0_7_0.c,2053 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0455
;FirmV_0_7_0.c,2054 :: 		{memcpy(LCDLine1,"02 D2 Open Time ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2055 :: 		charValueToStr(Door2OpenTime,LCDLine2+6);}
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0455:
;FirmV_0_7_0.c,2057 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0456
;FirmV_0_7_0.c,2058 :: 		{memcpy(LCDLine1,"03 D1 Close Time",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2059 :: 		charValueToStr(Door1CloseTime,LCDLine2+6);}
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0456:
;FirmV_0_7_0.c,2061 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0457
;FirmV_0_7_0.c,2062 :: 		{memcpy(LCDLine1,"04 D2 Close Time",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2063 :: 		charValueToStr(Door2CloseTime,LCDLine2+6);}
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0457:
;FirmV_0_7_0.c,2065 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0458
;FirmV_0_7_0.c,2066 :: 		{memcpy(LCDLine1,"05 Op Soft Start",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2067 :: 		charValueToStr(OpenSoftStartTime,LCDLine2+6);}
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0458:
;FirmV_0_7_0.c,2069 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0459
;FirmV_0_7_0.c,2070 :: 		{memcpy(LCDLine1,"06 Op Soft Stop ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2071 :: 		charValueToStr(OpenSoftStopTime,LCDLine2+6);}
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0459:
;FirmV_0_7_0.c,2073 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0460
;FirmV_0_7_0.c,2074 :: 		{memcpy(LCDLine1,"07 Cl Soft Start",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2075 :: 		charValueToStr(CloseSoftStartTime,LCDLine2+6);}
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0460:
;FirmV_0_7_0.c,2077 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0461
;FirmV_0_7_0.c,2078 :: 		{memcpy(LCDLine1,"08 Cl Soft Stop ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr82_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr82_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2079 :: 		charValueToStr(CloseSoftStopTime,LCDLine2+6);}
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0461:
;FirmV_0_7_0.c,2081 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0462
;FirmV_0_7_0.c,2082 :: 		{memcpy(LCDLine1,"09 M1 Overl Sens",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr83_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr83_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2083 :: 		bytetostr(OverloadSens1,LCDLine2+3);if(OverloadSens1>7)memcpy(LCDLine2+7,"250Kg-",6);else memcpy(LCDLine2+7,"250Kg+",6);}
	MOVF        _OverloadSens1+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine2+3
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine2+3)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
	MOVF        _OverloadSens1+0, 0 
	SUBLW       7
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu0463
	MOVLW       _LCDLine2+7
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+7)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr84_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr84_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       6
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0464
L_Menu0463:
	MOVLW       _LCDLine2+7
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+7)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr85_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr85_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       6
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0464:
L_Menu0462:
;FirmV_0_7_0.c,2085 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0465
;FirmV_0_7_0.c,2086 :: 		{memcpy(LCDLine1,"10 M2 Overl Sens",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2087 :: 		bytetostr(OverloadSens2,LCDLine2+3);if(OverloadSens2>7)memcpy(LCDLine2+7,"250Kg-",6);else memcpy(LCDLine2+7,"250Kg+",6);}
	MOVF        _OverloadSens2+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine2+3
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine2+3)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
	MOVF        _OverloadSens2+0, 0 
	SUBLW       7
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu0466
	MOVLW       _LCDLine2+7
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+7)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr87_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr87_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       6
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0467
L_Menu0466:
	MOVLW       _LCDLine2+7
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+7)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr88_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr88_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       6
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0467:
L_Menu0465:
;FirmV_0_7_0.c,2089 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0468
;FirmV_0_7_0.c,2090 :: 		{memcpy(LCDLine1,"11 M1 Overl Time",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr89_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr89_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2091 :: 		charValueToStr(OverloadTime1,LCDLine2+6);}
	MOVF        _OverloadTime1+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0468:
;FirmV_0_7_0.c,2093 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0469
;FirmV_0_7_0.c,2094 :: 		{memcpy(LCDLine1,"12 M2 Overl Time",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr90_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr90_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2095 :: 		charValueToStr(OverloadTime2,LCDLine2+6);}
	MOVF        _OverloadTime2+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0469:
;FirmV_0_7_0.c,2097 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0470
;FirmV_0_7_0.c,2098 :: 		{memcpy(LCDLine1,"13 Interval Time",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2099 :: 		charValueToStr(ActionTimeDiff,LCDLine2+6);}
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0470:
;FirmV_0_7_0.c,2101 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0471
;FirmV_0_7_0.c,2102 :: 		{memcpy(LCDLine1,"14 Auto-close T ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr92_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr92_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2103 :: 		intValueToStr(AutoCloseTime,LCDLine2+4);}
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_intValueToStr+0 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_intValueToStr+1 
	MOVLW       _LCDLine2+4
	MOVWF       FARG_intValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+4)
	MOVWF       FARG_intValueToStr+1 
	CALL        _intValueToStr+0, 0
L_Menu0471:
;FirmV_0_7_0.c,2105 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0472
;FirmV_0_7_0.c,2106 :: 		{memcpy(LCDLine1,"15 Factory Reset",16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr93_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr93_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_Menu0472:
;FirmV_0_7_0.c,2108 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0473
;FirmV_0_7_0.c,2109 :: 		{memcpy(LCDLine1,"16 Open Photo En",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2110 :: 		if(OpenPhEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _OpenPhEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0474
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr95_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr95_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0475
L_Menu0474:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr96_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr96_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0475:
L_Menu0473:
;FirmV_0_7_0.c,2112 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0476
;FirmV_0_7_0.c,2113 :: 		{memcpy(LCDLine1,"17 Limit Enable ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2114 :: 		if(LimiterEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LimiterEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0477
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr98_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr98_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0478
L_Menu0477:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr99_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr99_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0478:
L_Menu0476:
;FirmV_0_7_0.c,2116 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0479
;FirmV_0_7_0.c,2117 :: 		{memcpy(LCDLine1,"18 Lock Enable  ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2118 :: 		if(LockEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LockEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0480
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr101_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr101_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0481
L_Menu0480:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr102_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr102_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0481:
L_Menu0479:
;FirmV_0_7_0.c,2120 :: 		if(MenuPointer==19)
	MOVF        _MenuPointer+0, 0 
	XORLW       19
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0482
;FirmV_0_7_0.c,2121 :: 		{memcpy(LCDLine1,"19 Lock Force   ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr103_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr103_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2122 :: 		if(LockForce==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0483
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr104_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr104_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0484
L_Menu0483:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr105_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr105_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0484:
L_Menu0482:
;FirmV_0_7_0.c,2124 :: 		if(MenuPointer==20)
	MOVF        _MenuPointer+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0485
;FirmV_0_7_0.c,2125 :: 		{memcpy(LCDLine1,"20 Au-Cl Pass   ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr106_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr106_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2126 :: 		charValueToStr(CloseAfterPass,LCDLine2+6);}
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0485:
;FirmV_0_7_0.c,2128 :: 		if(MenuPointer==21)
	MOVF        _MenuPointer+0, 0 
	XORLW       21
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0486
;FirmV_0_7_0.c,2129 :: 		{memcpy(LCDLine1,"21 Save Changes ",16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr107_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr107_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_Menu0486:
;FirmV_0_7_0.c,2131 :: 		if(MenuPointer==22)
	MOVF        _MenuPointer+0, 0 
	XORLW       22
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0487
;FirmV_0_7_0.c,2132 :: 		{memcpy(LCDLine1,"22 Discard Exit ",16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr108_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr108_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_Menu0487:
;FirmV_0_7_0.c,2135 :: 		State=101;
	MOVLW       101
	MOVWF       _State+0 
;FirmV_0_7_0.c,2136 :: 		}
L_end_Menu0:
	RETURN      0
; end of _Menu0

_About:

;FirmV_0_7_0.c,2144 :: 		void About()
;FirmV_0_7_0.c,2146 :: 		if((Events.Keys.b1==1))
	BTFSS       _Events+0, 1 
	GOTO        L_About488
;FirmV_0_7_0.c,2147 :: 		AboutCounter=AboutCounter+1;
	INCF        _AboutCounter+0, 1 
L_About488:
;FirmV_0_7_0.c,2149 :: 		if(AboutCounter==1)
	MOVF        _AboutCounter+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_About489
;FirmV_0_7_0.c,2150 :: 		{memcpy(LCDLine1,Crypto[2],16);
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
;FirmV_0_7_0.c,2151 :: 		memcpy(LCDLine2,Crypto[3],16);
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
;FirmV_0_7_0.c,2152 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2153 :: 		}
L_About489:
;FirmV_0_7_0.c,2155 :: 		if(AboutCounter==2)
	MOVF        _AboutCounter+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_About490
;FirmV_0_7_0.c,2156 :: 		{memcpy(LCDLine1,Crypto[4],16);
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
;FirmV_0_7_0.c,2157 :: 		memcpy(LCDLine2,Crypto[5],16);
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
;FirmV_0_7_0.c,2158 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2159 :: 		}
L_About490:
;FirmV_0_7_0.c,2161 :: 		if(AboutCounter==3)
	MOVF        _AboutCounter+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_About491
;FirmV_0_7_0.c,2162 :: 		{State=100;}
	MOVLW       100
	MOVWF       _State+0 
L_About491:
;FirmV_0_7_0.c,2163 :: 		}
L_end_About:
	RETURN      0
; end of _About

_Menu1:

;FirmV_0_7_0.c,2172 :: 		void Menu1()
;FirmV_0_7_0.c,2175 :: 		if((Events.Keys.b0==1))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu1492
;FirmV_0_7_0.c,2176 :: 		{if(MenuPointer==0){MenuPointer=22;}else{MenuPointer=MenuPointer-1;}State=100;}
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1493
	MOVLW       22
	MOVWF       _MenuPointer+0 
	GOTO        L_Menu1494
L_Menu1493:
	DECF        _MenuPointer+0, 1 
L_Menu1494:
	MOVLW       100
	MOVWF       _State+0 
L_Menu1492:
;FirmV_0_7_0.c,2178 :: 		if((Events.Keys.b2==1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu1495
;FirmV_0_7_0.c,2179 :: 		{if(MenuPointer==22){MenuPointer=0;}else{MenuPointer=MenuPointer+1;}State=100;}
	MOVF        _MenuPointer+0, 0 
	XORLW       22
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1496
	CLRF        _MenuPointer+0 
	GOTO        L_Menu1497
L_Menu1496:
	INCF        _MenuPointer+0, 1 
L_Menu1497:
	MOVLW       100
	MOVWF       _State+0 
L_Menu1495:
;FirmV_0_7_0.c,2181 :: 		if((Events.Keys.b1==1))
	BTFSS       _Events+0, 1 
	GOTO        L_Menu1498
;FirmV_0_7_0.c,2182 :: 		{State=102;}
	MOVLW       102
	MOVWF       _State+0 
L_Menu1498:
;FirmV_0_7_0.c,2184 :: 		if(Events.Keys==0b101)
	MOVF        _Events+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1499
;FirmV_0_7_0.c,2185 :: 		{memcpy(LCDLine1,Crypto[0],16);AboutCounter=0;memcpy(LCDLine2,Crypto[1],16);LCDLines=2;LCDUpdateFlag=1;State=250;}
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
L_Menu1499:
;FirmV_0_7_0.c,2188 :: 		}
L_end_Menu1:
	RETURN      0
; end of _Menu1

_Menu2:

;FirmV_0_7_0.c,2196 :: 		void Menu2()
;FirmV_0_7_0.c,2199 :: 		LCDFlash=1;
	MOVLW       1
	MOVWF       _LCDFlash+0 
;FirmV_0_7_0.c,2201 :: 		if(Events.Keys.b1==1)
	BTFSS       _Events+0, 1 
	GOTO        L_Menu2500
;FirmV_0_7_0.c,2203 :: 		LCDFlash=0;LCDFlashFlag=0;State=101;;Menu0();
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
	MOVLW       101
	MOVWF       _State+0 
	CALL        _Menu0+0, 0
;FirmV_0_7_0.c,2204 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2501
;FirmV_0_7_0.c,2206 :: 		LearnPhase=0;
	CLRF        _LearnPhase+0 
;FirmV_0_7_0.c,2207 :: 		if(LearningMode==0)
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2502
;FirmV_0_7_0.c,2208 :: 		{State=200;LongBuzzFlag=1;}
	MOVLW       200
	MOVWF       _State+0 
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
L_Menu2502:
;FirmV_0_7_0.c,2209 :: 		if(LearningMode==1)
	MOVF        _LearningMode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2503
;FirmV_0_7_0.c,2210 :: 		{State=201;LongBuzzFlag=1;}
	MOVLW       201
	MOVWF       _State+0 
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
L_Menu2503:
;FirmV_0_7_0.c,2211 :: 		}
L_Menu2501:
;FirmV_0_7_0.c,2212 :: 		}
L_Menu2500:
;FirmV_0_7_0.c,2215 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2504
;FirmV_0_7_0.c,2216 :: 		{ if((Events.Keys.b0==1)&&(LearningMode>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2507
	MOVF        _LearningMode+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2507
L__Menu2932:
;FirmV_0_7_0.c,2217 :: 		{LearningMode=LearningMode-1;Menu0();State=102;}
	DECF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2507:
;FirmV_0_7_0.c,2218 :: 		if((Events.Keys.b2==1)&&(LearningMode<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2510
	MOVLW       1
	SUBWF       _LearningMode+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2510
L__Menu2931:
;FirmV_0_7_0.c,2219 :: 		{LearningMode=LearningMode+1;Menu0();State=102;}
	INCF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2510:
;FirmV_0_7_0.c,2220 :: 		}
L_Menu2504:
;FirmV_0_7_0.c,2224 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2511
;FirmV_0_7_0.c,2225 :: 		{ if((Events.Keys.b0==1)&&(Door1OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2514
	MOVF        _Door1OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2514
L__Menu2930:
;FirmV_0_7_0.c,2226 :: 		{Door1OpenTime=Door1OpenTime-1;Menu0();State=102;}
	DECF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2514:
;FirmV_0_7_0.c,2227 :: 		if((Events.Keys.b2==1)&&(Door1OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2517
	MOVLW       255
	SUBWF       _Door1OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2517
L__Menu2929:
;FirmV_0_7_0.c,2228 :: 		{Door1OpenTime=Door1OpenTime+1;Menu0();State=102;}
	INCF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2517:
;FirmV_0_7_0.c,2229 :: 		}
L_Menu2511:
;FirmV_0_7_0.c,2233 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2518
;FirmV_0_7_0.c,2234 :: 		{ if((Events.Keys.b0==1)&&(Door2OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2521
	MOVF        _Door2OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2521
L__Menu2928:
;FirmV_0_7_0.c,2235 :: 		{Door2OpenTime=Door2OpenTime-1;Menu0();State=102;}
	DECF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2521:
;FirmV_0_7_0.c,2236 :: 		if((Events.Keys.b2==1)&&(Door2OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2524
	MOVLW       255
	SUBWF       _Door2OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2524
L__Menu2927:
;FirmV_0_7_0.c,2237 :: 		{Door2OpenTime=Door2OpenTime+1;Menu0();State=102;}
	INCF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2524:
;FirmV_0_7_0.c,2238 :: 		}
L_Menu2518:
;FirmV_0_7_0.c,2241 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2525
;FirmV_0_7_0.c,2242 :: 		{ if((Events.Keys.b0==1)&&(Door1CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2528
	MOVF        _Door1CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2528
L__Menu2926:
;FirmV_0_7_0.c,2243 :: 		{Door1CloseTime=Door1CloseTime-1;Menu0();State=102;}
	DECF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2528:
;FirmV_0_7_0.c,2244 :: 		if((Events.Keys.b2==1)&&(Door1CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2531
	MOVLW       255
	SUBWF       _Door1CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2531
L__Menu2925:
;FirmV_0_7_0.c,2245 :: 		{Door1CloseTime=Door1CloseTime+1;Menu0();State=102;}
	INCF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2531:
;FirmV_0_7_0.c,2246 :: 		}
L_Menu2525:
;FirmV_0_7_0.c,2249 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2532
;FirmV_0_7_0.c,2250 :: 		{ if((Events.Keys.b0==1)&&(Door2CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2535
	MOVF        _Door2CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2535
L__Menu2924:
;FirmV_0_7_0.c,2251 :: 		{Door2CloseTime=Door2CloseTime-1;Menu0();State=102;}
	DECF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2535:
;FirmV_0_7_0.c,2252 :: 		if((Events.Keys.b2==1)&&(Door2CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2538
	MOVLW       255
	SUBWF       _Door2CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2538
L__Menu2923:
;FirmV_0_7_0.c,2253 :: 		{Door2CloseTime=Door2CloseTime+1;Menu0();State=102;}
	INCF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2538:
;FirmV_0_7_0.c,2254 :: 		}
L_Menu2532:
;FirmV_0_7_0.c,2258 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2539
;FirmV_0_7_0.c,2259 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2542
	MOVF        _OpenSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2542
L__Menu2922:
;FirmV_0_7_0.c,2260 :: 		{OpenSoftStartTime=OpenSoftStartTime-1;Menu0();State=102;}
	DECF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2542:
;FirmV_0_7_0.c,2261 :: 		if((Events.Keys.b2==1)&&(OpenSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2545
	MOVLW       255
	SUBWF       _OpenSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2545
L__Menu2921:
;FirmV_0_7_0.c,2262 :: 		{OpenSoftStartTime=OpenSoftStartTime+1;Menu0();State=102;}
	INCF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2545:
;FirmV_0_7_0.c,2263 :: 		}
L_Menu2539:
;FirmV_0_7_0.c,2266 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2546
;FirmV_0_7_0.c,2267 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2549
	MOVF        _OpenSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2549
L__Menu2920:
;FirmV_0_7_0.c,2268 :: 		{OpenSoftStopTime=OpenSoftStopTime-1;Menu0();State=102;}
	DECF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2549:
;FirmV_0_7_0.c,2269 :: 		if((Events.Keys.b2==1)&&(OpenSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2552
	MOVLW       255
	SUBWF       _OpenSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2552
L__Menu2919:
;FirmV_0_7_0.c,2270 :: 		{OpenSoftStopTime=OpenSoftStopTime+1;Menu0();State=102;}
	INCF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2552:
;FirmV_0_7_0.c,2271 :: 		}
L_Menu2546:
;FirmV_0_7_0.c,2274 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2553
;FirmV_0_7_0.c,2275 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2556
	MOVF        _CloseSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2556
L__Menu2918:
;FirmV_0_7_0.c,2276 :: 		{CloseSoftStartTime=CloseSoftStartTime-1;Menu0();State=102;}
	DECF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2556:
;FirmV_0_7_0.c,2277 :: 		if((Events.Keys.b2==1)&&(CloseSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2559
	MOVLW       255
	SUBWF       _CloseSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2559
L__Menu2917:
;FirmV_0_7_0.c,2278 :: 		{CloseSoftStartTime=CloseSoftStartTime+1;Menu0();State=102;}
	INCF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2559:
;FirmV_0_7_0.c,2279 :: 		}
L_Menu2553:
;FirmV_0_7_0.c,2282 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2560
;FirmV_0_7_0.c,2283 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2563
	MOVF        _CloseSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2563
L__Menu2916:
;FirmV_0_7_0.c,2284 :: 		{CloseSoftStopTime=CloseSoftStopTime-1;Menu0();State=102;}
	DECF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2563:
;FirmV_0_7_0.c,2285 :: 		if((Events.Keys.b2==1)&&(CloseSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2566
	MOVLW       255
	SUBWF       _CloseSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2566
L__Menu2915:
;FirmV_0_7_0.c,2286 :: 		{CloseSoftStopTime=CloseSoftStopTime+1;Menu0();State=102;}
	INCF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2566:
;FirmV_0_7_0.c,2287 :: 		}
L_Menu2560:
;FirmV_0_7_0.c,2291 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2567
;FirmV_0_7_0.c,2292 :: 		{ if((Events.Keys.b0==1)&&(OverloadSens1>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2570
	MOVF        _OverloadSens1+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2570
L__Menu2914:
;FirmV_0_7_0.c,2293 :: 		{OverloadSens1=OverloadSens1-1;Menu0();State=102;}
	DECF        _OverloadSens1+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2570:
;FirmV_0_7_0.c,2294 :: 		if((Events.Keys.b2==1)&&(OverloadSens1<15))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2573
	MOVLW       15
	SUBWF       _OverloadSens1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2573
L__Menu2913:
;FirmV_0_7_0.c,2295 :: 		{OverloadSens1=OverloadSens1+1;Menu0();State=102;}
	INCF        _OverloadSens1+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2573:
;FirmV_0_7_0.c,2296 :: 		}
L_Menu2567:
;FirmV_0_7_0.c,2300 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2574
;FirmV_0_7_0.c,2301 :: 		{ if((Events.Keys.b0==1)&&(OverloadSens2>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2577
	MOVF        _OverloadSens2+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2577
L__Menu2912:
;FirmV_0_7_0.c,2302 :: 		{OverloadSens2=OverloadSens2-1;Menu0();State=102;}
	DECF        _OverloadSens2+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2577:
;FirmV_0_7_0.c,2303 :: 		if((Events.Keys.b2==1)&&(OverloadSens2<15))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2580
	MOVLW       15
	SUBWF       _OverloadSens2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2580
L__Menu2911:
;FirmV_0_7_0.c,2304 :: 		{OverloadSens2=OverloadSens2+1;Menu0();State=102;}
	INCF        _OverloadSens2+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2580:
;FirmV_0_7_0.c,2305 :: 		}
L_Menu2574:
;FirmV_0_7_0.c,2308 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2581
;FirmV_0_7_0.c,2309 :: 		{ if((Events.Keys.b0==1)&&(OverloadTime1>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2584
	MOVF        _OverloadTime1+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2584
L__Menu2910:
;FirmV_0_7_0.c,2310 :: 		{OverloadTime1=OverloadTime1-1;Menu0();State=102;}
	DECF        _OverloadTime1+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2584:
;FirmV_0_7_0.c,2311 :: 		if((Events.Keys.b2==1)&&(OverloadTime1<10))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2587
	MOVLW       10
	SUBWF       _OverloadTime1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2587
L__Menu2909:
;FirmV_0_7_0.c,2312 :: 		{OverloadTime1=OverloadTime1+1;Menu0();State=102;}
	INCF        _OverloadTime1+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2587:
;FirmV_0_7_0.c,2313 :: 		}
L_Menu2581:
;FirmV_0_7_0.c,2317 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2588
;FirmV_0_7_0.c,2318 :: 		{ if((Events.Keys.b0==1)&&(OverloadTime2>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2591
	MOVF        _OverloadTime2+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2591
L__Menu2908:
;FirmV_0_7_0.c,2319 :: 		{OverloadTime2=OverloadTime2-1;Menu0();State=102;}
	DECF        _OverloadTime2+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2591:
;FirmV_0_7_0.c,2320 :: 		if((Events.Keys.b2==1)&&(OverloadTime2<10))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2594
	MOVLW       10
	SUBWF       _OverloadTime2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2594
L__Menu2907:
;FirmV_0_7_0.c,2321 :: 		{OverloadTime2=OverloadTime2+1;Menu0();State=102;}
	INCF        _OverloadTime2+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2594:
;FirmV_0_7_0.c,2322 :: 		}
L_Menu2588:
;FirmV_0_7_0.c,2325 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2595
;FirmV_0_7_0.c,2326 :: 		{ if((Events.Keys.b0==1)&&(ActionTimeDiff>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2598
	MOVF        _ActionTimeDiff+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2598
L__Menu2906:
;FirmV_0_7_0.c,2327 :: 		{ActionTimeDiff=ActionTimeDiff-1;Menu0();State=102;}
	DECF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2598:
;FirmV_0_7_0.c,2328 :: 		if((Events.Keys.b2==1)&&(ActionTimeDiff<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2601
	MOVLW       255
	SUBWF       _ActionTimeDiff+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2601
L__Menu2905:
;FirmV_0_7_0.c,2329 :: 		{ActionTimeDiff=ActionTimeDiff+1;Menu0();State=102;}
	INCF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2601:
;FirmV_0_7_0.c,2330 :: 		}
L_Menu2595:
;FirmV_0_7_0.c,2333 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2602
;FirmV_0_7_0.c,2334 :: 		{ if((Events.Keys.b0==1)&&(AutoCloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2605
	MOVLW       0
	MOVWF       R0 
	MOVF        _AutoCloseTime+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu21024
	MOVF        _AutoCloseTime+0, 0 
	SUBLW       0
L__Menu21024:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2605
L__Menu2904:
;FirmV_0_7_0.c,2335 :: 		{AutoCloseTime=AutoCloseTime-1;Menu0();State=102;}
	MOVLW       1
	SUBWF       _AutoCloseTime+0, 1 
	MOVLW       0
	SUBWFB      _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2605:
;FirmV_0_7_0.c,2336 :: 		if((Events.Keys.b2==1)&&(AutoCloseTime<65000))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2608
	MOVLW       253
	SUBWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu21025
	MOVLW       232
	SUBWF       _AutoCloseTime+0, 0 
L__Menu21025:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2608
L__Menu2903:
;FirmV_0_7_0.c,2337 :: 		{AutoCloseTime=AutoCloseTime+1;Menu0();State=102;}
	INFSNZ      _AutoCloseTime+0, 1 
	INCF        _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2608:
;FirmV_0_7_0.c,2338 :: 		}
L_Menu2602:
;FirmV_0_7_0.c,2341 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2609
;FirmV_0_7_0.c,2343 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2344 :: 		memcpy(LCDLine1,Sipher,16);
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
;FirmV_0_7_0.c,2345 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2346 :: 		LCDFlash=0; LCDFlashFlag=0;
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,2347 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2348 :: 		LongBuzzFlag=1;
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
;FirmV_0_7_0.c,2349 :: 		FactorySettings();
	CALL        _FactorySettings+0, 0
;FirmV_0_7_0.c,2350 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2351 :: 		}
L_Menu2609:
;FirmV_0_7_0.c,2354 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2610
;FirmV_0_7_0.c,2355 :: 		{ if((Events.Keys.b0==1)&&(OpenPhEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2613
	MOVF        _OpenPhEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2613
L__Menu2902:
;FirmV_0_7_0.c,2356 :: 		{OpenPhEnable=OpenPhEnable-1;Menu0();State=102;}
	DECF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2613:
;FirmV_0_7_0.c,2357 :: 		if((Events.Keys.b2==1)&&(OpenPhEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2616
	MOVLW       1
	SUBWF       _OpenPhEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2616
L__Menu2901:
;FirmV_0_7_0.c,2358 :: 		{OpenPhEnable=OpenPhEnable+1;Menu0();State=102;}
	INCF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2616:
;FirmV_0_7_0.c,2359 :: 		}
L_Menu2610:
;FirmV_0_7_0.c,2363 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2617
;FirmV_0_7_0.c,2364 :: 		{ if((Events.Keys.b0==1)&&(LimiterEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2620
	MOVF        _LimiterEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2620
L__Menu2900:
;FirmV_0_7_0.c,2365 :: 		{LimiterEnable=LimiterEnable-1;Menu0();State=102;}
	DECF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2620:
;FirmV_0_7_0.c,2366 :: 		if((Events.Keys.b2==1)&&(LimiterEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2623
	MOVLW       1
	SUBWF       _LimiterEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2623
L__Menu2899:
;FirmV_0_7_0.c,2367 :: 		{LimiterEnable=LimiterEnable+1;Menu0();State=102;}
	INCF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2623:
;FirmV_0_7_0.c,2368 :: 		}
L_Menu2617:
;FirmV_0_7_0.c,2371 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2624
;FirmV_0_7_0.c,2372 :: 		{ if((Events.Keys.b0==1)&&(LockEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2627
	MOVF        _LockEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2627
L__Menu2898:
;FirmV_0_7_0.c,2373 :: 		{LockEnable=LockEnable-1;Menu0();State=102;}
	DECF        _LockEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2627:
;FirmV_0_7_0.c,2374 :: 		if((Events.Keys.b2==1)&&(LockEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2630
	MOVLW       1
	SUBWF       _LockEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2630
L__Menu2897:
;FirmV_0_7_0.c,2375 :: 		{LockEnable=LockEnable+1;Menu0();State=102;}
	INCF        _LockEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2630:
;FirmV_0_7_0.c,2376 :: 		}
L_Menu2624:
;FirmV_0_7_0.c,2379 :: 		if(MenuPointer==19)
	MOVF        _MenuPointer+0, 0 
	XORLW       19
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2631
;FirmV_0_7_0.c,2380 :: 		{ if((Events.Keys.b0==1)&&(LockForce>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2634
	MOVF        _LockForce+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2634
L__Menu2896:
;FirmV_0_7_0.c,2381 :: 		{LockForce=LockForce-1;Menu0();State=102;}
	DECF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2634:
;FirmV_0_7_0.c,2382 :: 		if((Events.Keys.b2==1)&&(LockForce<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2637
	MOVLW       1
	SUBWF       _LockForce+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2637
L__Menu2895:
;FirmV_0_7_0.c,2383 :: 		{LockForce=LockForce+1;Menu0();State=102;}
	INCF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2637:
;FirmV_0_7_0.c,2384 :: 		}
L_Menu2631:
;FirmV_0_7_0.c,2387 :: 		if(MenuPointer==20)
	MOVF        _MenuPointer+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2638
;FirmV_0_7_0.c,2388 :: 		{ if((Events.Keys.b0==1)&&(CloseAfterPass>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2641
	MOVF        _CloseAfterPass+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2641
L__Menu2894:
;FirmV_0_7_0.c,2389 :: 		{CloseAfterPass=CloseAfterPass-1;if(CloseAfterPass==9) CloseAfterPass=0;Menu0();State=102;}
	DECF        _CloseAfterPass+0, 1 
	MOVF        _CloseAfterPass+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2642
	CLRF        _CloseAfterPass+0 
L_Menu2642:
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2641:
;FirmV_0_7_0.c,2390 :: 		if((Events.Keys.b2==1)&&(CloseAfterPass<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2645
	MOVLW       255
	SUBWF       _CloseAfterPass+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2645
L__Menu2893:
;FirmV_0_7_0.c,2391 :: 		{CloseAfterPass=CloseAfterPass+1;if(CloseAfterPass==1) CloseAfterPass=10;Menu0();State=102;}
	INCF        _CloseAfterPass+0, 1 
	MOVF        _CloseAfterPass+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2646
	MOVLW       10
	MOVWF       _CloseAfterPass+0 
L_Menu2646:
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2645:
;FirmV_0_7_0.c,2392 :: 		}
L_Menu2638:
;FirmV_0_7_0.c,2395 :: 		if(MenuPointer==21)
	MOVF        _MenuPointer+0, 0 
	XORLW       21
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2647
;FirmV_0_7_0.c,2397 :: 		State=103;
	MOVLW       103
	MOVWF       _State+0 
;FirmV_0_7_0.c,2398 :: 		memcpy(LCDLine1,Sipher,16);
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
;FirmV_0_7_0.c,2399 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2400 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2401 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2402 :: 		LongBuzzFlag=1;
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
;FirmV_0_7_0.c,2403 :: 		}
L_Menu2647:
;FirmV_0_7_0.c,2406 :: 		if(MenuPointer==22)
	MOVF        _MenuPointer+0, 0 
	XORLW       22
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2648
;FirmV_0_7_0.c,2408 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2409 :: 		memcpy(LCDLine1,Sipher,16);
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
;FirmV_0_7_0.c,2410 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2411 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2412 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2413 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,2414 :: 		LongBuzzFlag=1;
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
;FirmV_0_7_0.c,2415 :: 		}
L_Menu2648:
;FirmV_0_7_0.c,2416 :: 		}
L_end_Menu2:
	RETURN      0
; end of _Menu2

_Menu3:

;FirmV_0_7_0.c,2428 :: 		void Menu3()
;FirmV_0_7_0.c,2430 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2431 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2432 :: 		}
L_end_Menu3:
	RETURN      0
; end of _Menu3

_LearnAuto:

;FirmV_0_7_0.c,2446 :: 		void LearnAuto()
;FirmV_0_7_0.c,2452 :: 		switch(LearnPhase)
	GOTO        L_LearnAuto649
;FirmV_0_7_0.c,2454 :: 		case 0:
L_LearnAuto651:
;FirmV_0_7_0.c,2455 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,2457 :: 		if(Events.Remote.b0==1) {DoorNo=2; LearnPhase=LearnPhase+1;BuzzFlag=1;} if(Events.Remote.b1==1) {DoorNo=1;LearnPhase=3;BuzzFlag=1;}
	BTFSS       _Events+4, 0 
	GOTO        L_LearnAuto652
	MOVLW       2
	MOVWF       LearnAuto_DoorNo_L0+0 
	INCF        _LearnPhase+0, 1 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnAuto652:
	BTFSS       _Events+4, 1 
	GOTO        L_LearnAuto653
	MOVLW       1
	MOVWF       LearnAuto_DoorNo_L0+0 
	MOVLW       3
	MOVWF       _LearnPhase+0 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnAuto653:
;FirmV_0_7_0.c,2458 :: 		OverloadCheckFlag1=0;OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,2459 :: 		break;
	GOTO        L_LearnAuto650
;FirmV_0_7_0.c,2461 :: 		case 1: //Start D2 and enable overload sensing after 3s
L_LearnAuto654:
;FirmV_0_7_0.c,2462 :: 		StartMotor(2,_Close);AddTask(ms500+6,21);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2463 :: 		break;
	GOTO        L_LearnAuto650
;FirmV_0_7_0.c,2465 :: 		case 2: //Check if D2 reaches end of its course
L_LearnAuto655:
;FirmV_0_7_0.c,2466 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto658
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto658
L__LearnAuto938:
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnAuto658:
;FirmV_0_7_0.c,2467 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto659
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnAuto659:
;FirmV_0_7_0.c,2468 :: 		break;
	GOTO        L_LearnAuto650
;FirmV_0_7_0.c,2470 :: 		case 3: //Start D1 and enable overload sensin after 3 s
L_LearnAuto660:
;FirmV_0_7_0.c,2471 :: 		StartMotor(1,_Close);AddTask(ms500+6,20);LearnPhase=LearnPhase+1;;
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
;FirmV_0_7_0.c,2473 :: 		case 4: //Check if D1 reaches end of its course
L_LearnAuto661:
;FirmV_0_7_0.c,2474 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto664
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto664
L__LearnAuto937:
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnAuto664:
;FirmV_0_7_0.c,2475 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto665
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto665:
;FirmV_0_7_0.c,2476 :: 		break;
	GOTO        L_LearnAuto650
;FirmV_0_7_0.c,2478 :: 		case 5: //Start D1 for opening and save start time and enable overload sensing after 3s
L_LearnAuto666:
;FirmV_0_7_0.c,2479 :: 		startT=ms500;StartMotor(1,_Open);AddTask(ms500+6,20);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2480 :: 		break;
	GOTO        L_LearnAuto650
;FirmV_0_7_0.c,2482 :: 		case 6: //Check if D1 reaches end of its course and save the stop time
L_LearnAuto667:
;FirmV_0_7_0.c,2483 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);if(DoorNo==1)LearnPhase=11;else LearnPhase=LearnPhase+1;stopT=ms500;RawData.D1OpenTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto670
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto670
L__LearnAuto936:
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	MOVF        LearnAuto_DoorNo_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto671
	MOVLW       11
	MOVWF       _LearnPhase+0 
	GOTO        L_LearnAuto672
L_LearnAuto671:
	INCF        _LearnPhase+0, 1 
L_LearnAuto672:
	MOVF        LearnAuto_startT_L0+0, 0 
	SUBWF       _ms500+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnAuto_RawData_L0+1 
L_LearnAuto670:
;FirmV_0_7_0.c,2484 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto673
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto673:
;FirmV_0_7_0.c,2485 :: 		break;
	GOTO        L_LearnAuto650
;FirmV_0_7_0.c,2487 :: 		case 7: //Start D2 for opening and save start time and enable overload sensing after 3s
L_LearnAuto674:
;FirmV_0_7_0.c,2488 :: 		startT=ms500;StartMotor(2,_Open);AddTask(ms500+6,21);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2489 :: 		break;
	GOTO        L_LearnAuto650
;FirmV_0_7_0.c,2491 :: 		case 8: //Check if D2 reaches end of its course and save the stop time
L_LearnAuto675:
;FirmV_0_7_0.c,2492 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D2OpenTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto678
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto678
L__LearnAuto935:
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
L_LearnAuto678:
;FirmV_0_7_0.c,2493 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto679
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnAuto679:
;FirmV_0_7_0.c,2494 :: 		break;
	GOTO        L_LearnAuto650
;FirmV_0_7_0.c,2496 :: 		case 9: //Start D2 for closing and save start time and enable overload sensing after 6s
L_LearnAuto680:
;FirmV_0_7_0.c,2497 :: 		startT=ms500;StartMotor(2,_Close);AddTask(ms500+6,21);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2498 :: 		break;
	GOTO        L_LearnAuto650
;FirmV_0_7_0.c,2500 :: 		case 10: //Check if D2 reaches end of its course and save the stop time
L_LearnAuto681:
;FirmV_0_7_0.c,2501 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D2CloseTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto684
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto684
L__LearnAuto934:
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
L_LearnAuto684:
;FirmV_0_7_0.c,2502 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto685
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnAuto685:
;FirmV_0_7_0.c,2503 :: 		break;
	GOTO        L_LearnAuto650
;FirmV_0_7_0.c,2505 :: 		case 11: //Start D1 for closing and save start time and enable overload sensing after 3s
L_LearnAuto686:
;FirmV_0_7_0.c,2506 :: 		startT=ms500;StartMotor(1,_Close);AddTask(ms500+6,20);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2507 :: 		break;
	GOTO        L_LearnAuto650
;FirmV_0_7_0.c,2509 :: 		case 12: //Check if D1 reaches end of its course and save the stop time
L_LearnAuto687:
;FirmV_0_7_0.c,2510 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D1CloseTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto690
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto690
L__LearnAuto933:
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
L_LearnAuto690:
;FirmV_0_7_0.c,2511 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto691
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto691:
;FirmV_0_7_0.c,2512 :: 		break;
	GOTO        L_LearnAuto650
;FirmV_0_7_0.c,2514 :: 		case 13:
L_LearnAuto692:
;FirmV_0_7_0.c,2515 :: 		AutoLearnCalculator(&RawData);
	MOVLW       LearnAuto_RawData_L0+0
	MOVWF       FARG_AutoLearnCalculator+0 
	MOVLW       hi_addr(LearnAuto_RawData_L0+0)
	MOVWF       FARG_AutoLearnCalculator+1 
	CALL        _AutoLearnCalculator+0, 0
;FirmV_0_7_0.c,2516 :: 		SaveLearnData(&RawData,DoorNo);
	MOVLW       LearnAuto_RawData_L0+0
	MOVWF       FARG_SaveLearnData+0 
	MOVLW       hi_addr(LearnAuto_RawData_L0+0)
	MOVWF       FARG_SaveLearnData+1 
	MOVF        LearnAuto_DoorNo_L0+0, 0 
	MOVWF       FARG_SaveLearnData+0 
	CALL        _SaveLearnData+0, 0
;FirmV_0_7_0.c,2517 :: 		memcpy(LCDLine1," Learn Complete ",16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr109_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr109_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2518 :: 		memcpy(LCDLine2,"     Ready      ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr110_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr110_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2519 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2520 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2521 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,2523 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2524 :: 		break;
	GOTO        L_LearnAuto650
;FirmV_0_7_0.c,2527 :: 		}
L_LearnAuto649:
	MOVF        _LearnPhase+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto651
	MOVF        _LearnPhase+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto654
	MOVF        _LearnPhase+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto655
	MOVF        _LearnPhase+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto660
	MOVF        _LearnPhase+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto661
	MOVF        _LearnPhase+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto666
	MOVF        _LearnPhase+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto667
	MOVF        _LearnPhase+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto674
	MOVF        _LearnPhase+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto675
	MOVF        _LearnPhase+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto680
	MOVF        _LearnPhase+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto681
	MOVF        _LearnPhase+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto686
	MOVF        _LearnPhase+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto687
	MOVF        _LearnPhase+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto692
L_LearnAuto650:
;FirmV_0_7_0.c,2531 :: 		}
L_end_LearnAuto:
	RETURN      0
; end of _LearnAuto

_AutoLearnCalculator:

;FirmV_0_7_0.c,2551 :: 		void AutoLearnCalculator(Learn *raw)
;FirmV_0_7_0.c,2554 :: 		(*raw).D1OpenTime=(*raw).D1OpenTime+10;
	MOVLW       1
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       R2 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       10
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2555 :: 		(*raw).D2OpenTime=(*raw).D2OpenTime+10;
	MOVLW       3
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       R2 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       10
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2556 :: 		(*raw).D1CloseTime=(*raw).D1CloseTime+10;
	MOVFF       FARG_AutoLearnCalculator_raw+0, FSR0
	MOVFF       FARG_AutoLearnCalculator_raw+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       FARG_AutoLearnCalculator_raw+0, FSR1
	MOVFF       FARG_AutoLearnCalculator_raw+1, FSR1H
	MOVLW       10
	ADDWF       R0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2557 :: 		(*raw).D2CloseTime=(*raw).D2CloseTime+10;
	MOVLW       2
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       R2 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVLW       10
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2559 :: 		(*raw).D1OpenSoftStart=4;
	MOVLW       4
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2560 :: 		(*raw).D1CloseSoftStart=4;
	MOVLW       6
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2561 :: 		(*raw).D2OpenSoftStart=4;
	MOVLW       8
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2562 :: 		(*raw).D2CloseSoftStart=4;
	MOVLW       10
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2564 :: 		(*raw).D1OpenSoftStop=10;
	MOVLW       5
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2565 :: 		(*raw).D2OpenSoftStop=10;
	MOVLW       9
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2566 :: 		(*raw).D1CloseSoftStop=10;
	MOVLW       7
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2567 :: 		(*raw).D2CloseSoftStop=10;
	MOVLW       11
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2569 :: 		}
L_end_AutoLearnCalculator:
	RETURN      0
; end of _AutoLearnCalculator

_SaveLearnData:

;FirmV_0_7_0.c,2581 :: 		void SaveLearnData(Learn *d,char DCount)
;FirmV_0_7_0.c,2583 :: 		Door1OpenTime=(*d).D1OpenTime;
	MOVLW       1
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,2584 :: 		Door1CloseTime=(*d).D1CloseTime;
	MOVFF       FARG_SaveLearnData_d+0, FSR0
	MOVFF       FARG_SaveLearnData_d+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,2585 :: 		if(DCount==2)
	MOVF        FARG_SaveLearnData_DCount+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SaveLearnData693
;FirmV_0_7_0.c,2587 :: 		Door2OpenTime=(*d).D2OpenTime;
	MOVLW       3
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,2588 :: 		Door2CloseTime=(*d).D2CloseTime;
	MOVLW       2
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,2589 :: 		OpenSoftStartTime=((*d).D1OpenSoftStart+(*d).D2OpenSoftStart)/2;
	MOVLW       4
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVLW       8
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR2 
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
;FirmV_0_7_0.c,2590 :: 		OpenSoftStopTime=((*d).D1OpenSoftStop+(*d).D2OpenSoftStop)/2;
	MOVLW       5
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVLW       9
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR2 
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
;FirmV_0_7_0.c,2591 :: 		CloseSoftStartTime=((*d).D1CloseSoftStart+(*d).D2CloseSoftStart)/2;
	MOVLW       6
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVLW       10
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR2 
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
;FirmV_0_7_0.c,2592 :: 		CloseSoftStopTime=((*d).D1CloseSoftStop+(*d).D2CloseSoftStop)/2;
	MOVLW       7
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVLW       11
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR2 
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
;FirmV_0_7_0.c,2593 :: 		}
	GOTO        L_SaveLearnData694
L_SaveLearnData693:
;FirmV_0_7_0.c,2596 :: 		Door2OpenTime=0;
	CLRF        _Door2OpenTime+0 
;FirmV_0_7_0.c,2597 :: 		Door2CloseTime=0;
	CLRF        _Door2CloseTime+0 
;FirmV_0_7_0.c,2598 :: 		OpenSoftStartTime=(*d).D1OpenSoftStart;
	MOVLW       4
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,2599 :: 		OpenSoftStopTime=(*d).D1OpenSoftStop;
	MOVLW       5
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,2600 :: 		CloseSoftStartTime=(*d).D1CloseSoftStart;
	MOVLW       6
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,2601 :: 		CloseSoftStopTime=(*d).D1CloseSoftStop;
	MOVLW       7
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,2602 :: 		}
L_SaveLearnData694:
;FirmV_0_7_0.c,2604 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2605 :: 		}
L_end_SaveLearnData:
	RETURN      0
; end of _SaveLearnData

_LearnManual:

;FirmV_0_7_0.c,2620 :: 		void LearnManual()
;FirmV_0_7_0.c,2628 :: 		switch(LearnPhase)
	GOTO        L_LearnManual695
;FirmV_0_7_0.c,2630 :: 		case 0:
L_LearnManual697:
;FirmV_0_7_0.c,2631 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,2633 :: 		if(Events.Remote.b0==1){LearnPhase=LearnPhase+1; DoorNo=2;BuzzFlag=1;}if(Events.Remote.b1==1){LearnPhase=3; DoorNo=1;BuzzFlag=1;}
	BTFSS       _Events+4, 0 
	GOTO        L_LearnManual698
	INCF        _LearnPhase+0, 1 
	MOVLW       2
	MOVWF       LearnManual_DoorNo_L0+0 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnManual698:
	BTFSS       _Events+4, 1 
	GOTO        L_LearnManual699
	MOVLW       3
	MOVWF       _LearnPhase+0 
	MOVLW       1
	MOVWF       LearnManual_DoorNo_L0+0 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnManual699:
;FirmV_0_7_0.c,2634 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2636 :: 		case 1: //Start D2 and enable overload sensing after 1s
L_LearnManual700:
;FirmV_0_7_0.c,2637 :: 		StartMotor(2,_Close);AddTask(ms500+4,21);LearnPhase=LearnPhase+1;OverloadCheckFlag2=0;
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
;FirmV_0_7_0.c,2638 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2640 :: 		case 2: //Check if D2 reaches end of its course
L_LearnManual701:
;FirmV_0_7_0.c,2641 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnManual704
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnManual704
L__LearnManual940:
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnManual704:
;FirmV_0_7_0.c,2642 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual705
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnManual705:
;FirmV_0_7_0.c,2643 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2645 :: 		case 3: //Start D1 and enable overload sensin after 1 s
L_LearnManual706:
;FirmV_0_7_0.c,2646 :: 		StartMotor(1,_Close);AddTask(ms500+4,20);LearnPhase=LearnPhase+1;;OverloadCheckFlag1=0;
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
;FirmV_0_7_0.c,2648 :: 		case 4: //Check if D1 reaches end of its course
L_LearnManual707:
;FirmV_0_7_0.c,2649 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnManual710
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnManual710
L__LearnManual939:
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnManual710:
;FirmV_0_7_0.c,2650 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual711
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnManual711:
;FirmV_0_7_0.c,2651 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2653 :: 		case 5: //Wait for remote to start D1 and slow down
L_LearnManual712:
;FirmV_0_7_0.c,2654 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(1,_Open);SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual713
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
L_LearnManual713:
;FirmV_0_7_0.c,2655 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2657 :: 		case 6: //check for Remote press and fast up
L_LearnManual714:
;FirmV_0_7_0.c,2658 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(1,Motor2FullSpeed);M1isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual715
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
L_LearnManual715:
;FirmV_0_7_0.c,2659 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2661 :: 		case 7: //check for Remote press and slow down
L_LearnManual716:
;FirmV_0_7_0.c,2662 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual717
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
L_LearnManual717:
;FirmV_0_7_0.c,2663 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2665 :: 		case 8: //check for Remote press and stop
L_LearnManual718:
;FirmV_0_7_0.c,2666 :: 		if(Events.Remote!=0){if(DoorNo==2)LearnPhase=LearnPhase+1;else LearnPhase=17;t4=ms500;StopMotor(1);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual719
	MOVF        LearnManual_DoorNo_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnManual720
	INCF        _LearnPhase+0, 1 
	GOTO        L_LearnManual721
L_LearnManual720:
	MOVLW       17
	MOVWF       _LearnPhase+0 
L_LearnManual721:
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
;FirmV_0_7_0.c,2667 :: 		RawData.D1OpenTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+1 
;FirmV_0_7_0.c,2668 :: 		RawData.D1OpenSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+4 
;FirmV_0_7_0.c,2669 :: 		RawData.D1OpenSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+5 
;FirmV_0_7_0.c,2670 :: 		}
L_LearnManual719:
;FirmV_0_7_0.c,2671 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2673 :: 		case 9: //Wait for remote to start D2 and slow down
L_LearnManual722:
;FirmV_0_7_0.c,2674 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(2,_Open);SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual723
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
L_LearnManual723:
;FirmV_0_7_0.c,2675 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2677 :: 		case 10: //check for Remote press and fast up
L_LearnManual724:
;FirmV_0_7_0.c,2678 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(Motor1FullSpeed,1);M2isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual725
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
L_LearnManual725:
;FirmV_0_7_0.c,2679 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2681 :: 		case 11: //check for Remote press and slow down
L_LearnManual726:
;FirmV_0_7_0.c,2682 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual727
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
L_LearnManual727:
;FirmV_0_7_0.c,2683 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2685 :: 		case 12: //check for Remote press and stop
L_LearnManual728:
;FirmV_0_7_0.c,2686 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(2);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual729
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
;FirmV_0_7_0.c,2687 :: 		RawData.D2OpenTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+3 
;FirmV_0_7_0.c,2688 :: 		RawData.D2OpenSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+8 
;FirmV_0_7_0.c,2689 :: 		RawData.D2OpenSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+9 
;FirmV_0_7_0.c,2690 :: 		}
L_LearnManual729:
;FirmV_0_7_0.c,2691 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2693 :: 		case 13: //Wait for remote to start D2 and slow down
L_LearnManual730:
;FirmV_0_7_0.c,2694 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(2,_Close);SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual731
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
L_LearnManual731:
;FirmV_0_7_0.c,2695 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2697 :: 		case 14: //check for Remote press and fast up
L_LearnManual732:
;FirmV_0_7_0.c,2698 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(Motor1FullSpeed,1);M2isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual733
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
L_LearnManual733:
;FirmV_0_7_0.c,2699 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2701 :: 		case 15: //check for Remote press and slow down
L_LearnManual734:
;FirmV_0_7_0.c,2702 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual735
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
L_LearnManual735:
;FirmV_0_7_0.c,2703 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2705 :: 		case 16: //check for Remote press and stop
L_LearnManual736:
;FirmV_0_7_0.c,2706 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(2);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual737
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
;FirmV_0_7_0.c,2707 :: 		RawData.D2CloseTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+2 
;FirmV_0_7_0.c,2708 :: 		RawData.D2CloseSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+10 
;FirmV_0_7_0.c,2709 :: 		RawData.D2CloseSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+11 
;FirmV_0_7_0.c,2710 :: 		}
L_LearnManual737:
;FirmV_0_7_0.c,2711 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2713 :: 		case 17: //Wait for remote to start D1 and slow down
L_LearnManual738:
;FirmV_0_7_0.c,2714 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(1,_Close);SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual739
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
L_LearnManual739:
;FirmV_0_7_0.c,2715 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2717 :: 		case 18: //check for Remote press and fast up
L_LearnManual740:
;FirmV_0_7_0.c,2718 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(1,Motor2FullSpeed);M1isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual741
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
L_LearnManual741:
;FirmV_0_7_0.c,2719 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2721 :: 		case 19: //check for Remote press and slow down
L_LearnManual742:
;FirmV_0_7_0.c,2722 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual743
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
L_LearnManual743:
;FirmV_0_7_0.c,2723 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2725 :: 		case 20: //check for Remote press and stop
L_LearnManual744:
;FirmV_0_7_0.c,2726 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(1);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual745
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
;FirmV_0_7_0.c,2727 :: 		RawData.D1CloseTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+0 
;FirmV_0_7_0.c,2728 :: 		RawData.D1CloseSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+6 
;FirmV_0_7_0.c,2729 :: 		RawData.D1CloseSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+7 
;FirmV_0_7_0.c,2730 :: 		}
L_LearnManual745:
;FirmV_0_7_0.c,2731 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2733 :: 		case 21:
L_LearnManual746:
;FirmV_0_7_0.c,2734 :: 		SaveLearnData(&RawData,DoorNo);
	MOVLW       LearnManual_RawData_L0+0
	MOVWF       FARG_SaveLearnData_d+0 
	MOVLW       hi_addr(LearnManual_RawData_L0+0)
	MOVWF       FARG_SaveLearnData_d+1 
	MOVF        LearnManual_DoorNo_L0+0, 0 
	MOVWF       FARG_SaveLearnData_DCount+0 
	CALL        _SaveLearnData+0, 0
;FirmV_0_7_0.c,2735 :: 		memcpy(LCDLine1," Learn Complete ",16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr111_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr111_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2736 :: 		memcpy(LCDLine2,"     Ready      ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr112_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr112_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2737 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2738 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2739 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,2741 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2742 :: 		break;
	GOTO        L_LearnManual696
;FirmV_0_7_0.c,2743 :: 		}
L_LearnManual695:
	MOVF        _LearnPhase+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual697
	MOVF        _LearnPhase+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual700
	MOVF        _LearnPhase+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual701
	MOVF        _LearnPhase+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual706
	MOVF        _LearnPhase+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual707
	MOVF        _LearnPhase+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual712
	MOVF        _LearnPhase+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual714
	MOVF        _LearnPhase+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual716
	MOVF        _LearnPhase+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual718
	MOVF        _LearnPhase+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual722
	MOVF        _LearnPhase+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual724
	MOVF        _LearnPhase+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual726
	MOVF        _LearnPhase+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual728
	MOVF        _LearnPhase+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual730
	MOVF        _LearnPhase+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual732
	MOVF        _LearnPhase+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual734
	MOVF        _LearnPhase+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual736
	MOVF        _LearnPhase+0, 0 
	XORLW       17
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual738
	MOVF        _LearnPhase+0, 0 
	XORLW       18
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual740
	MOVF        _LearnPhase+0, 0 
	XORLW       19
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual742
	MOVF        _LearnPhase+0, 0 
	XORLW       20
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual744
	MOVF        _LearnPhase+0, 0 
	XORLW       21
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual746
L_LearnManual696:
;FirmV_0_7_0.c,2744 :: 		}
L_end_LearnManual:
	RETURN      0
; end of _LearnManual

_charValueToStr:

;FirmV_0_7_0.c,2765 :: 		void charValueToStr(char val, char * string)
;FirmV_0_7_0.c,2767 :: 		bytetostr(val>>1,string);
	MOVF        FARG_charValueToStr_val+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVF        FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_ByteToStr_output+0 
	MOVF        FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,2768 :: 		if((val%2)==1)
	MOVLW       1
	ANDWF       FARG_charValueToStr_val+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_charValueToStr747
;FirmV_0_7_0.c,2769 :: 		memcpy(string+3,".5s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr113_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr113_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_charValueToStr748
L_charValueToStr747:
;FirmV_0_7_0.c,2771 :: 		memcpy(string+3,".0s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr114_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr114_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_charValueToStr748:
;FirmV_0_7_0.c,2772 :: 		}
L_end_charValueToStr:
	RETURN      0
; end of _charValueToStr

_charValueToStr_AC:

;FirmV_0_7_0.c,2781 :: 		void charValueToStr_AC(char val, char * string)
;FirmV_0_7_0.c,2783 :: 		bytetostr(val>>1,string);
	MOVF        FARG_charValueToStr_AC_val+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVF        FARG_charValueToStr_AC_string+0, 0 
	MOVWF       FARG_ByteToStr_output+0 
	MOVF        FARG_charValueToStr_AC_string+1, 0 
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,2784 :: 		memcpy(string+3,"s  ",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_AC_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_AC_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr115_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr115_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2785 :: 		}
L_end_charValueToStr_AC:
	RETURN      0
; end of _charValueToStr_AC

_intValueToStr:

;FirmV_0_7_0.c,2798 :: 		void intValueToStr(unsigned val, char * string)
;FirmV_0_7_0.c,2800 :: 		wordtostr(val>>1,string);
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
;FirmV_0_7_0.c,2801 :: 		if((val%2)==1)
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
	GOTO        L__intValueToStr1034
	MOVLW       1
	XORWF       R1, 0 
L__intValueToStr1034:
	BTFSS       STATUS+0, 2 
	GOTO        L_intValueToStr749
;FirmV_0_7_0.c,2802 :: 		memcpy(string+5,".5s",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr116_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr116_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_intValueToStr750
L_intValueToStr749:
;FirmV_0_7_0.c,2804 :: 		memcpy(string+5,".0s",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr117_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr117_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_intValueToStr750:
;FirmV_0_7_0.c,2805 :: 		}
L_end_intValueToStr:
	RETURN      0
; end of _intValueToStr

_SetOverloadParams:

;FirmV_0_7_0.c,2817 :: 		void SetOverloadParams(char p1, char d1,char p2, char d2)
;FirmV_0_7_0.c,2820 :: 		switch(p1)
	GOTO        L_SetOverloadParams751
;FirmV_0_7_0.c,2822 :: 		case 0: OverloadTreshold1=0; break;
L_SetOverloadParams753:
	CLRF        _OverloadTreshold1+0 
	CLRF        _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2824 :: 		case 1: OverloadTreshold1=480; break;
L_SetOverloadParams754:
	MOVLW       224
	MOVWF       _OverloadTreshold1+0 
	MOVLW       1
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2826 :: 		case 2: OverloadTreshold1=490; break;
L_SetOverloadParams755:
	MOVLW       234
	MOVWF       _OverloadTreshold1+0 
	MOVLW       1
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2828 :: 		case 3: OverloadTreshold1=500; break;
L_SetOverloadParams756:
	MOVLW       244
	MOVWF       _OverloadTreshold1+0 
	MOVLW       1
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2830 :: 		case 4: OverloadTreshold1=530; break;
L_SetOverloadParams757:
	MOVLW       18
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2832 :: 		case 5: OverloadTreshold1=550; break;
L_SetOverloadParams758:
	MOVLW       38
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2834 :: 		case 6: OverloadTreshold1=570; break;
L_SetOverloadParams759:
	MOVLW       58
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2836 :: 		case 7: OverloadTreshold1=600; break;
L_SetOverloadParams760:
	MOVLW       88
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2838 :: 		case 8: OverloadTreshold1=630; break;
L_SetOverloadParams761:
	MOVLW       118
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2840 :: 		case 9: OverloadTreshold1=650; break;
L_SetOverloadParams762:
	MOVLW       138
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2842 :: 		case 10: OverloadTreshold1=670; break;
L_SetOverloadParams763:
	MOVLW       158
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2844 :: 		case 11: OverloadTreshold1=700; break;
L_SetOverloadParams764:
	MOVLW       188
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2846 :: 		case 12: OverloadTreshold1=750; break;
L_SetOverloadParams765:
	MOVLW       238
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2848 :: 		case 13: OverloadTreshold1=800; break;
L_SetOverloadParams766:
	MOVLW       32
	MOVWF       _OverloadTreshold1+0 
	MOVLW       3
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2850 :: 		case 14: OverloadTreshold1=850; break;
L_SetOverloadParams767:
	MOVLW       82
	MOVWF       _OverloadTreshold1+0 
	MOVLW       3
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2852 :: 		case 15: OverloadTreshold1=900; break;
L_SetOverloadParams768:
	MOVLW       132
	MOVWF       _OverloadTreshold1+0 
	MOVLW       3
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams752
;FirmV_0_7_0.c,2854 :: 		}
L_SetOverloadParams751:
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams753
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams754
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams755
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams756
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams757
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams758
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams759
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams760
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams761
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams762
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams763
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams764
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams765
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams766
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams767
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams768
L_SetOverloadParams752:
;FirmV_0_7_0.c,2857 :: 		switch(d1)
	GOTO        L_SetOverloadParams769
;FirmV_0_7_0.c,2859 :: 		case 0: OverloadDuration1=100; break;
L_SetOverloadParams771:
	MOVLW       100
	MOVWF       _OverloadDuration1+0 
	MOVLW       0
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2861 :: 		case 1: OverloadDuration1=500; break;
L_SetOverloadParams772:
	MOVLW       244
	MOVWF       _OverloadDuration1+0 
	MOVLW       1
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2863 :: 		case 2: OverloadDuration1=1000; break;
L_SetOverloadParams773:
	MOVLW       232
	MOVWF       _OverloadDuration1+0 
	MOVLW       3
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2865 :: 		case 3: OverloadDuration1=1500; break;
L_SetOverloadParams774:
	MOVLW       220
	MOVWF       _OverloadDuration1+0 
	MOVLW       5
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2867 :: 		case 4: OverloadDuration1=2000; break;
L_SetOverloadParams775:
	MOVLW       208
	MOVWF       _OverloadDuration1+0 
	MOVLW       7
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2869 :: 		case 5: OverloadDuration1=2500; break;
L_SetOverloadParams776:
	MOVLW       196
	MOVWF       _OverloadDuration1+0 
	MOVLW       9
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2871 :: 		case 6: OverloadDuration1=3000; break;
L_SetOverloadParams777:
	MOVLW       184
	MOVWF       _OverloadDuration1+0 
	MOVLW       11
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2873 :: 		case 7: OverloadDuration1=3500; break;
L_SetOverloadParams778:
	MOVLW       172
	MOVWF       _OverloadDuration1+0 
	MOVLW       13
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2875 :: 		case 8: OverloadDuration1=4000; break;
L_SetOverloadParams779:
	MOVLW       160
	MOVWF       _OverloadDuration1+0 
	MOVLW       15
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2877 :: 		case 9: OverloadDuration1=4500; break;
L_SetOverloadParams780:
	MOVLW       148
	MOVWF       _OverloadDuration1+0 
	MOVLW       17
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2879 :: 		case 10: OverloadDuration1=5000; break;
L_SetOverloadParams781:
	MOVLW       136
	MOVWF       _OverloadDuration1+0 
	MOVLW       19
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2880 :: 		}
L_SetOverloadParams769:
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams771
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams772
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams773
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams774
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams775
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams776
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams777
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams778
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams779
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams780
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams781
L_SetOverloadParams770:
;FirmV_0_7_0.c,2886 :: 		switch(p2)
	GOTO        L_SetOverloadParams782
;FirmV_0_7_0.c,2888 :: 		case 0: OverloadTreshold2=0; break;
L_SetOverloadParams784:
	CLRF        _OverloadTreshold2+0 
	CLRF        _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2890 :: 		case 1: OverloadTreshold2=480; break;
L_SetOverloadParams785:
	MOVLW       224
	MOVWF       _OverloadTreshold2+0 
	MOVLW       1
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2892 :: 		case 2: OverloadTreshold2=490; break;
L_SetOverloadParams786:
	MOVLW       234
	MOVWF       _OverloadTreshold2+0 
	MOVLW       1
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2894 :: 		case 3: OverloadTreshold2=500; break;
L_SetOverloadParams787:
	MOVLW       244
	MOVWF       _OverloadTreshold2+0 
	MOVLW       1
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2896 :: 		case 4: OverloadTreshold2=530; break;
L_SetOverloadParams788:
	MOVLW       18
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2898 :: 		case 5: OverloadTreshold2=550; break;
L_SetOverloadParams789:
	MOVLW       38
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2900 :: 		case 6: OverloadTreshold2=570; break;
L_SetOverloadParams790:
	MOVLW       58
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2902 :: 		case 7: OverloadTreshold2=600; break;
L_SetOverloadParams791:
	MOVLW       88
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2904 :: 		case 8: OverloadTreshold2=630; break;
L_SetOverloadParams792:
	MOVLW       118
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2906 :: 		case 9: OverloadTreshold2=650; break;
L_SetOverloadParams793:
	MOVLW       138
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2908 :: 		case 10: OverloadTreshold2=670; break;
L_SetOverloadParams794:
	MOVLW       158
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2910 :: 		case 11: OverloadTreshold2=700; break;
L_SetOverloadParams795:
	MOVLW       188
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2912 :: 		case 12: OverloadTreshold2=750; break;
L_SetOverloadParams796:
	MOVLW       238
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2914 :: 		case 13: OverloadTreshold2=800; break;
L_SetOverloadParams797:
	MOVLW       32
	MOVWF       _OverloadTreshold2+0 
	MOVLW       3
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2916 :: 		case 14: OverloadTreshold2=850; break;
L_SetOverloadParams798:
	MOVLW       82
	MOVWF       _OverloadTreshold2+0 
	MOVLW       3
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2918 :: 		case 15: OverloadTreshold2=900; break;
L_SetOverloadParams799:
	MOVLW       132
	MOVWF       _OverloadTreshold2+0 
	MOVLW       3
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams783
;FirmV_0_7_0.c,2920 :: 		}
L_SetOverloadParams782:
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams784
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams785
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams786
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams787
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams788
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams789
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams790
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams791
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams792
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams793
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams794
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams795
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams796
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams797
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams798
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams799
L_SetOverloadParams783:
;FirmV_0_7_0.c,2923 :: 		switch(d2)
	GOTO        L_SetOverloadParams800
;FirmV_0_7_0.c,2925 :: 		case 0: OverloadDuration2=100; break;
L_SetOverloadParams802:
	MOVLW       100
	MOVWF       _OverloadDuration2+0 
	MOVLW       0
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams801
;FirmV_0_7_0.c,2927 :: 		case 1: OverloadDuration2=500; break;
L_SetOverloadParams803:
	MOVLW       244
	MOVWF       _OverloadDuration2+0 
	MOVLW       1
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams801
;FirmV_0_7_0.c,2929 :: 		case 2: OverloadDuration2=1000; break;
L_SetOverloadParams804:
	MOVLW       232
	MOVWF       _OverloadDuration2+0 
	MOVLW       3
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams801
;FirmV_0_7_0.c,2931 :: 		case 3: OverloadDuration2=1500; break;
L_SetOverloadParams805:
	MOVLW       220
	MOVWF       _OverloadDuration2+0 
	MOVLW       5
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams801
;FirmV_0_7_0.c,2933 :: 		case 4: OverloadDuration2=2000; break;
L_SetOverloadParams806:
	MOVLW       208
	MOVWF       _OverloadDuration2+0 
	MOVLW       7
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams801
;FirmV_0_7_0.c,2935 :: 		case 5: OverloadDuration2=2500; break;
L_SetOverloadParams807:
	MOVLW       196
	MOVWF       _OverloadDuration2+0 
	MOVLW       9
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams801
;FirmV_0_7_0.c,2937 :: 		case 6: OverloadDuration2=3000; break;
L_SetOverloadParams808:
	MOVLW       184
	MOVWF       _OverloadDuration2+0 
	MOVLW       11
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams801
;FirmV_0_7_0.c,2939 :: 		case 7: OverloadDuration2=3500; break;
L_SetOverloadParams809:
	MOVLW       172
	MOVWF       _OverloadDuration2+0 
	MOVLW       13
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams801
;FirmV_0_7_0.c,2941 :: 		case 8: OverloadDuration2=4000; break;
L_SetOverloadParams810:
	MOVLW       160
	MOVWF       _OverloadDuration2+0 
	MOVLW       15
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams801
;FirmV_0_7_0.c,2943 :: 		case 9: OverloadDuration2=4500; break;
L_SetOverloadParams811:
	MOVLW       148
	MOVWF       _OverloadDuration2+0 
	MOVLW       17
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams801
;FirmV_0_7_0.c,2945 :: 		case 10: OverloadDuration2=5000; break;
L_SetOverloadParams812:
	MOVLW       136
	MOVWF       _OverloadDuration2+0 
	MOVLW       19
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams801
;FirmV_0_7_0.c,2946 :: 		}
L_SetOverloadParams800:
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams802
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams803
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams804
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams805
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams806
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams807
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams808
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams809
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams810
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams811
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams812
L_SetOverloadParams801:
;FirmV_0_7_0.c,2947 :: 		}
L_end_SetOverloadParams:
	RETURN      0
; end of _SetOverloadParams

_TorqueLogger:

;FirmV_0_7_0.c,2968 :: 		void TorqueLogger()
;FirmV_0_7_0.c,2971 :: 		switch(State)
	GOTO        L_TorqueLogger813
;FirmV_0_7_0.c,2973 :: 		case 3:
L_TorqueLogger815:
;FirmV_0_7_0.c,2974 :: 		txt[0]='D';txt[1]='3';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       51
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2975 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2976 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2977 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2979 :: 		txt[0]='D';txt[1]='3';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       51
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2980 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2981 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2982 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2984 :: 		break;
	GOTO        L_TorqueLogger814
;FirmV_0_7_0.c,2986 :: 		case 4:
L_TorqueLogger816:
;FirmV_0_7_0.c,2987 :: 		txt[0]='D';txt[1]='4';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       52
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2988 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2989 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2990 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2992 :: 		txt[0]='D';txt[1]='4';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       52
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2993 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2994 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2995 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2997 :: 		break;
	GOTO        L_TorqueLogger814
;FirmV_0_7_0.c,2999 :: 		case 7:
L_TorqueLogger817:
;FirmV_0_7_0.c,3000 :: 		txt[0]='D';txt[1]='7';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       55
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3001 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3002 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3003 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3005 :: 		txt[0]='D';txt[1]='7';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       55
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3006 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3007 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3008 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3010 :: 		break;
	GOTO        L_TorqueLogger814
;FirmV_0_7_0.c,3012 :: 		case 8:
L_TorqueLogger818:
;FirmV_0_7_0.c,3013 :: 		txt[0]='D';txt[1]='8';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       56
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3014 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3015 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3016 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3018 :: 		txt[0]='D';txt[1]='8';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       56
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3019 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3020 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3021 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3023 :: 		break;
	GOTO        L_TorqueLogger814
;FirmV_0_7_0.c,3025 :: 		case 200:
L_TorqueLogger819:
;FirmV_0_7_0.c,3026 :: 		txt[0]='D';txt[1]='L';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       76
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3027 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3028 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3029 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3031 :: 		txt[0]='D';txt[1]='L';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       76
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3032 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3033 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3034 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3036 :: 		break;
	GOTO        L_TorqueLogger814
;FirmV_0_7_0.c,3038 :: 		}
L_TorqueLogger813:
	MOVF        _State+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger815
	MOVF        _State+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger816
	MOVF        _State+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger817
	MOVF        _State+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger818
	MOVF        _State+0, 0 
	XORLW       200
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger819
L_TorqueLogger814:
;FirmV_0_7_0.c,3039 :: 		}
L_end_TorqueLogger:
	RETURN      0
; end of _TorqueLogger
