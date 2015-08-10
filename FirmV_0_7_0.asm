
_interrupt:

;FirmV_0_7_0.c,206 :: 		void interrupt()
;FirmV_0_7_0.c,208 :: 		if(TMR0IF_bit)
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt0
;FirmV_0_7_0.c,210 :: 		msCounter=msCounter+1;
	INCF        _msCounter+0, 1 
;FirmV_0_7_0.c,211 :: 		LCDBackLight=1;
	BSF         PORTA+0, 4 
;FirmV_0_7_0.c,212 :: 		Flag20ms=1;
	MOVLW       1
	MOVWF       _Flag20ms+0 
;FirmV_0_7_0.c,213 :: 		if(ms20A==255)
	MOVF        _ms20A+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;FirmV_0_7_0.c,214 :: 		{ms20A=0;RemotePulse1=0;}
	CLRF        _ms20A+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt2
L_interrupt1:
;FirmV_0_7_0.c,216 :: 		ms20A=ms20A+1;
	INCF        _ms20A+0, 1 
L_interrupt2:
;FirmV_0_7_0.c,218 :: 		if(ms20B==255)
	MOVF        _ms20B+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;FirmV_0_7_0.c,219 :: 		{ms20B=0;RemotePulse2=0;}
	CLRF        _ms20B+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt4
L_interrupt3:
;FirmV_0_7_0.c,221 :: 		ms20B=ms20B+1;
	INCF        _ms20B+0, 1 
L_interrupt4:
;FirmV_0_7_0.c,223 :: 		if(msCounter>=25)
	MOVLW       25
	SUBWF       _msCounter+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt5
;FirmV_0_7_0.c,225 :: 		msCounter=0;
	CLRF        _msCounter+0 
;FirmV_0_7_0.c,226 :: 		ms500=ms500+1;
	MOVLW       1
	ADDWF       _ms500+0, 1 
	MOVLW       0
	ADDWFC      _ms500+1, 1 
	ADDWFC      _ms500+2, 1 
	ADDWFC      _ms500+3, 1 
;FirmV_0_7_0.c,227 :: 		LCDFlashFlag=!LCDFlashFlag;
	MOVF        _LCDFlashFlag+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _LCDFlashFlag+0 
;FirmV_0_7_0.c,228 :: 		LCDBackLight=0;
	BCF         PORTA+0, 4 
;FirmV_0_7_0.c,229 :: 		Flag500ms=1;
	MOVLW       1
	MOVWF       _Flag500ms+0 
;FirmV_0_7_0.c,230 :: 		}
L_interrupt5:
;FirmV_0_7_0.c,231 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,232 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,233 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;FirmV_0_7_0.c,234 :: 		}
L_interrupt0:
;FirmV_0_7_0.c,237 :: 		if(INT1F_bit)
	BTFSS       INT1F_bit+0, BitPos(INT1F_bit+0) 
	GOTO        L_interrupt6
;FirmV_0_7_0.c,239 :: 		if(RemotePulse1==0)
	MOVF        _RemotePulse1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;FirmV_0_7_0.c,240 :: 		{ RemotePulse1=RemotePulse1+1;ms20A=0;}
	INCF        _RemotePulse1+0, 1 
	CLRF        _ms20A+0 
	GOTO        L_interrupt8
L_interrupt7:
;FirmV_0_7_0.c,242 :: 		{ RemotePulse1=RemotePulse1+1;}
	INCF        _RemotePulse1+0, 1 
L_interrupt8:
;FirmV_0_7_0.c,243 :: 		if(RemotePulse1>=5)
	MOVLW       5
	SUBWF       _RemotePulse1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt9
;FirmV_0_7_0.c,244 :: 		if((ms20A>=19)&&(ms20A<=21))
	MOVLW       19
	SUBWF       _ms20A+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
	MOVF        _ms20A+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
L__interrupt808:
;FirmV_0_7_0.c,245 :: 		{RemoteAFlag=1;RemotePulse1=0;}
	MOVLW       1
	MOVWF       _RemoteAFlag+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt13
L_interrupt12:
;FirmV_0_7_0.c,247 :: 		RemotePulse1=0;
	CLRF        _RemotePulse1+0 
L_interrupt13:
L_interrupt9:
;FirmV_0_7_0.c,248 :: 		INT1IF_bit=0;
	BCF         INT1IF_bit+0, BitPos(INT1IF_bit+0) 
;FirmV_0_7_0.c,249 :: 		}
L_interrupt6:
;FirmV_0_7_0.c,253 :: 		if(INT2IF_bit)
	BTFSS       INT2IF_bit+0, BitPos(INT2IF_bit+0) 
	GOTO        L_interrupt14
;FirmV_0_7_0.c,255 :: 		if(RemotePulse2==0)
	MOVF        _RemotePulse2+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt15
;FirmV_0_7_0.c,256 :: 		{ RemotePulse2=RemotePulse2+1;ms20B=0;}
	INCF        _RemotePulse2+0, 1 
	CLRF        _ms20B+0 
	GOTO        L_interrupt16
L_interrupt15:
;FirmV_0_7_0.c,258 :: 		{ RemotePulse2=RemotePulse2+1;}
	INCF        _RemotePulse2+0, 1 
L_interrupt16:
;FirmV_0_7_0.c,259 :: 		if(RemotePulse2>=5)
	MOVLW       5
	SUBWF       _RemotePulse2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt17
;FirmV_0_7_0.c,260 :: 		if((ms20B>=19)&&(ms20B<=21))
	MOVLW       19
	SUBWF       _ms20B+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
	MOVF        _ms20B+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
L__interrupt807:
;FirmV_0_7_0.c,261 :: 		{RemoteBFlag=1;RemotePulse2=0;}
	MOVLW       1
	MOVWF       _RemoteBFlag+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt21
L_interrupt20:
;FirmV_0_7_0.c,263 :: 		RemotePulse2=0;
	CLRF        _RemotePulse2+0 
L_interrupt21:
L_interrupt17:
;FirmV_0_7_0.c,264 :: 		INT2IF_bit=0;
	BCF         INT2IF_bit+0, BitPos(INT2IF_bit+0) 
;FirmV_0_7_0.c,265 :: 		}
L_interrupt14:
;FirmV_0_7_0.c,270 :: 		if(INT0F_bit==1)
	BTFSS       INT0F_bit+0, BitPos(INT0F_bit+0) 
	GOTO        L_interrupt22
;FirmV_0_7_0.c,272 :: 		ZCCounter=ZCCounter+1;
	INCF        _ZCCounter+0, 1 
;FirmV_0_7_0.c,273 :: 		if(ZCCounter==255)
	MOVF        _ZCCounter+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt23
;FirmV_0_7_0.c,274 :: 		ZCCounter=2;
	MOVLW       2
	MOVWF       _ZCCounter+0 
L_interrupt23:
;FirmV_0_7_0.c,275 :: 		if(ZCCounter%3==1)
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
;FirmV_0_7_0.c,277 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt25
;FirmV_0_7_0.c,278 :: 		if(Motor1FullSpeed)
	MOVF        _Motor1FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt26
;FirmV_0_7_0.c,279 :: 		Motor1=1;
	BSF         PORTB+0, 3 
	GOTO        L_interrupt27
L_interrupt26:
;FirmV_0_7_0.c,281 :: 		Motor1=0;
	BCF         PORTB+0, 3 
L_interrupt27:
L_interrupt25:
;FirmV_0_7_0.c,283 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt28
;FirmV_0_7_0.c,284 :: 		if(Motor2FullSpeed)
	MOVF        _Motor2FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt29
;FirmV_0_7_0.c,285 :: 		Motor2=1;
	BSF         PORTB+0, 4 
	GOTO        L_interrupt30
L_interrupt29:
;FirmV_0_7_0.c,287 :: 		Motor2=0;
	BCF         PORTB+0, 4 
L_interrupt30:
L_interrupt28:
;FirmV_0_7_0.c,288 :: 		}
L_interrupt24:
;FirmV_0_7_0.c,289 :: 		if(ZCCounter%3==0)
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
;FirmV_0_7_0.c,291 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt32
;FirmV_0_7_0.c,292 :: 		Motor1=1;
	BSF         PORTB+0, 3 
L_interrupt32:
;FirmV_0_7_0.c,294 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt33
;FirmV_0_7_0.c,295 :: 		Motor2=1;
	BSF         PORTB+0, 4 
L_interrupt33:
;FirmV_0_7_0.c,296 :: 		}
L_interrupt31:
;FirmV_0_7_0.c,297 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, BitPos(INT0F_bit+0) 
;FirmV_0_7_0.c,298 :: 		}
L_interrupt22:
;FirmV_0_7_0.c,299 :: 		}
L_end_interrupt:
L__interrupt928:
	RETFIE      1
; end of _interrupt

_ResetTaskEvents:

;FirmV_0_7_0.c,312 :: 		void ResetTaskEvents()
;FirmV_0_7_0.c,314 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,315 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,316 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,317 :: 		}
L_end_ResetTaskEvents:
	RETURN      0
; end of _ResetTaskEvents

_Decrypt:

;FirmV_0_7_0.c,326 :: 		void Decrypt()
;FirmV_0_7_0.c,328 :: 		Sipher[0]=Crypto[1][0]+0x0D;
	MOVLW       13
	ADDWF       _crypto+16, 0 
	MOVWF       _Sipher+0 
;FirmV_0_7_0.c,329 :: 		Sipher[1]=Crypto[1][1]+0x0D;
	MOVLW       13
	ADDWF       _crypto+17, 0 
	MOVWF       _Sipher+1 
;FirmV_0_7_0.c,330 :: 		Sipher[2]=Crypto[1][2]+0x0D;
	MOVLW       13
	ADDWF       _crypto+18, 0 
	MOVWF       _Sipher+2 
;FirmV_0_7_0.c,331 :: 		Sipher[3]=Crypto[1][3]-0x26;
	MOVLW       38
	SUBWF       _crypto+19, 0 
	MOVWF       _Sipher+3 
;FirmV_0_7_0.c,332 :: 		Sipher[4]=Crypto[1][4]-0x3C;
	MOVLW       60
	SUBWF       _crypto+20, 0 
	MOVWF       _Sipher+4 
;FirmV_0_7_0.c,333 :: 		Sipher[5]=Crypto[1][5]-0x41;
	MOVLW       65
	SUBWF       _crypto+21, 0 
	MOVWF       _Sipher+5 
;FirmV_0_7_0.c,334 :: 		Sipher[6]=Crypto[1][6]-0x0C;
	MOVLW       12
	SUBWF       _crypto+22, 0 
	MOVWF       _Sipher+6 
;FirmV_0_7_0.c,335 :: 		Sipher[7]=Crypto[1][7]+0x34;
	MOVLW       52
	ADDWF       _crypto+23, 0 
	MOVWF       _Sipher+7 
;FirmV_0_7_0.c,336 :: 		Sipher[8]=Crypto[1][8]-0x01;
	DECF        _crypto+24, 0 
	MOVWF       _Sipher+8 
;FirmV_0_7_0.c,337 :: 		Sipher[9]=Crypto[1][9]-0x1F;
	MOVLW       31
	SUBWF       _crypto+25, 0 
	MOVWF       _Sipher+9 
;FirmV_0_7_0.c,338 :: 		Sipher[10]=Crypto[1][10]-0x3A;
	MOVLW       58
	SUBWF       _crypto+26, 0 
	MOVWF       _Sipher+10 
;FirmV_0_7_0.c,339 :: 		Sipher[11]=Crypto[1][11]-0x3B;
	MOVLW       59
	SUBWF       _crypto+27, 0 
	MOVWF       _Sipher+11 
;FirmV_0_7_0.c,340 :: 		Sipher[12]=Crypto[1][12]-0x3C;
	MOVLW       60
	SUBWF       _crypto+28, 0 
	MOVWF       _Sipher+12 
;FirmV_0_7_0.c,341 :: 		Sipher[13]=Crypto[1][13]+0x0D;
	MOVLW       13
	ADDWF       _crypto+29, 0 
	MOVWF       _Sipher+13 
;FirmV_0_7_0.c,342 :: 		Sipher[14]=Crypto[1][14]+0x0D;
	MOVLW       13
	ADDWF       _crypto+30, 0 
	MOVWF       _Sipher+14 
;FirmV_0_7_0.c,343 :: 		Sipher[15]=Crypto[1][15]+0x0D;
	MOVLW       13
	ADDWF       _crypto+31, 0 
	MOVWF       _Sipher+15 
;FirmV_0_7_0.c,344 :: 		}
L_end_Decrypt:
	RETURN      0
; end of _Decrypt

_Logger:

;FirmV_0_7_0.c,356 :: 		void Logger(char* text, char TimeStampFlag)
;FirmV_0_7_0.c,359 :: 		if(TimeStampFlag)
	MOVF        FARG_Logger_TimeStampFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Logger34
;FirmV_0_7_0.c,361 :: 		longwordtostrwithzeros(ms500,time);
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
;FirmV_0_7_0.c,362 :: 		uart_write_text(time);
	MOVLW       Logger_time_L0+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(Logger_time_L0+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;FirmV_0_7_0.c,363 :: 		uart1_write_text(": ");
	MOVLW       ?lstr1_FirmV_0_7_0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_FirmV_0_7_0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;FirmV_0_7_0.c,364 :: 		}
L_Logger34:
;FirmV_0_7_0.c,365 :: 		uart1_write_text(text);
	MOVF        FARG_Logger_text+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_Logger_text+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;FirmV_0_7_0.c,366 :: 		uart1_write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,367 :: 		uart1_write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,368 :: 		}
L_end_Logger:
	RETURN      0
; end of _Logger

_main:

;FirmV_0_7_0.c,385 :: 		void main() {
;FirmV_0_7_0.c,388 :: 		PhotocellRel=1;
	BSF         PORTC+0, 5 
;FirmV_0_7_0.c,390 :: 		Init();
	CALL        _Init+0, 0
;FirmV_0_7_0.c,392 :: 		Decrypt();
	CALL        _Decrypt+0, 0
;FirmV_0_7_0.c,394 :: 		Buzzer=1;
	BSF         PORTB+0, 7 
;FirmV_0_7_0.c,395 :: 		Logger("Start ...",1);
	MOVLW       ?lstr2_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr2_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,396 :: 		memcpy(LCDLine1,Sipher,16);
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
;FirmV_0_7_0.c,397 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,398 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,399 :: 		Buzzer=0;
	BCF         PORTB+0, 7 
;FirmV_0_7_0.c,401 :: 		while(1)
L_main35:
;FirmV_0_7_0.c,403 :: 		asm CLRWDT;
	CLRWDT
;FirmV_0_7_0.c,405 :: 		if(Flag20ms==1)
	MOVF        _Flag20ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main37
;FirmV_0_7_0.c,407 :: 		if((Buzzer==1)&&(BuzzCounter<100))
	BTFSS       PORTB+0, 7 
	GOTO        L_main40
	MOVLW       100
	SUBWF       _BuzzCounter+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main40
L__main814:
;FirmV_0_7_0.c,408 :: 		{BuzzCounter=BuzzCounter+1;}
	INCF        _BuzzCounter+0, 1 
L_main40:
;FirmV_0_7_0.c,410 :: 		if((Buzzer==1)&&(LongBuzzFlag))
	BTFSS       PORTB+0, 7 
	GOTO        L_main43
	MOVF        _LongBuzzFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main43
L__main813:
;FirmV_0_7_0.c,411 :: 		if(BuzzCounter>=25){BuzzFlag=0;LongBuzzFlag=0;Buzzer=0;}
	MOVLW       25
	SUBWF       _BuzzCounter+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main44
	CLRF        _BuzzFlag+0 
	CLRF        _LongBuzzFlag+0 
	BCF         PORTB+0, 7 
L_main44:
L_main43:
;FirmV_0_7_0.c,413 :: 		if((Buzzer==1)&&(BuzzFlag)&&(!LongBuzzFlag))
	BTFSS       PORTB+0, 7 
	GOTO        L_main47
	MOVF        _BuzzFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main47
	MOVF        _LongBuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main47
L__main812:
;FirmV_0_7_0.c,414 :: 		{BuzzFlag=0;LongBuzzFlag=0;Buzzer=0;}
	CLRF        _BuzzFlag+0 
	CLRF        _LongBuzzFlag+0 
	BCF         PORTB+0, 7 
L_main47:
;FirmV_0_7_0.c,416 :: 		if(((BuzzFlag)||(LongBuzzFlag))&&(!Buzzer))
	MOVF        _BuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main811
	MOVF        _LongBuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main811
	GOTO        L_main52
L__main811:
	BTFSC       PORTB+0, 7 
	GOTO        L_main52
L__main810:
;FirmV_0_7_0.c,417 :: 		{Buzzer=1;BuzzCounter=0;}
	BSF         PORTB+0, 7 
	CLRF        _BuzzCounter+0 
L_main52:
;FirmV_0_7_0.c,420 :: 		if(DebouncingDelay<DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelay+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main53
;FirmV_0_7_0.c,421 :: 		DebouncingDelay=DebouncingDelay+1;
	INCF        _DebouncingDelay+0, 1 
L_main53:
;FirmV_0_7_0.c,422 :: 		LCDUpdater();
	CALL        _LCDUpdater+0, 0
;FirmV_0_7_0.c,423 :: 		if(KeyFlag<200)
	MOVLW       200
	SUBWF       _KeyFlag+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main54
;FirmV_0_7_0.c,424 :: 		KeyFlag=KeyFlag+1;
	INCF        _KeyFlag+0, 1 
L_main54:
;FirmV_0_7_0.c,425 :: 		Flag20ms=0;
	CLRF        _Flag20ms+0 
;FirmV_0_7_0.c,426 :: 		}
L_main37:
;FirmV_0_7_0.c,428 :: 		if(Flag500ms==1)
	MOVF        _Flag500ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main55
;FirmV_0_7_0.c,430 :: 		if(FlashFlag)
	MOVF        _FlashFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main56
;FirmV_0_7_0.c,431 :: 		FlasherLamp=!FlasherLamp;// Buzzer=!Buzzer;
	BTG         PORTB+0, 5 
	GOTO        L_main57
L_main56:
;FirmV_0_7_0.c,433 :: 		if((!BuzzFlag)&&(!LongBuzzFlag))FlasherLamp=0; // Buzzer=0;
	MOVF        _BuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main60
	MOVF        _LongBuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main60
L__main809:
	BCF         PORTB+0, 5 
L_main60:
L_main57:
;FirmV_0_7_0.c,434 :: 		ResetTaskEvents();
	CALL        _ResetTaskEvents+0, 0
;FirmV_0_7_0.c,435 :: 		TaskManager();
	CALL        _TaskManager+0, 0
;FirmV_0_7_0.c,436 :: 		TorqueLogger();
	CALL        _TorqueLogger+0, 0
;FirmV_0_7_0.c,437 :: 		Flag500ms=0;
	CLRF        _Flag500ms+0 
;FirmV_0_7_0.c,438 :: 		}
L_main55:
;FirmV_0_7_0.c,439 :: 		EventHandler();
	CALL        _EventHandler+0, 0
;FirmV_0_7_0.c,440 :: 		StateManager();
	CALL        _StateManager+0, 0
;FirmV_0_7_0.c,441 :: 		}
	GOTO        L_main35
;FirmV_0_7_0.c,443 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_StateManager:

;FirmV_0_7_0.c,468 :: 		void StateManager()
;FirmV_0_7_0.c,471 :: 		switch(State)
	GOTO        L_StateManager61
;FirmV_0_7_0.c,474 :: 		case 0: State1(); break;
L_StateManager63:
	CALL        _State1+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,476 :: 		case 1: State1(); break;
L_StateManager64:
	CALL        _State1+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,478 :: 		case 2: State2(); break;
L_StateManager65:
	CALL        _State2+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,480 :: 		case 3: State3(); break;
L_StateManager66:
	CALL        _State3+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,482 :: 		case 4: State4(); break;
L_StateManager67:
	CALL        _State4+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,484 :: 		case 5: State5(); break;
L_StateManager68:
	CALL        _State5+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,486 :: 		case 6: State6(); break;
L_StateManager69:
	CALL        _State6+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,488 :: 		case 7: State7(); break;
L_StateManager70:
	CALL        _State7+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,490 :: 		case 8: State8(); break;
L_StateManager71:
	CALL        _State8+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,492 :: 		case 10:State00(); break;
L_StateManager72:
	CALL        _State00+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,494 :: 		case 100:Menu0(); break;
L_StateManager73:
	CALL        _Menu0+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,496 :: 		case 101:Menu1(); break;
L_StateManager74:
	CALL        _Menu1+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,498 :: 		case 102:Menu2(); break;
L_StateManager75:
	CALL        _Menu2+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,500 :: 		case 103:Menu3(); break;
L_StateManager76:
	CALL        _Menu3+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,502 :: 		case 200:LearnAuto(); break;
L_StateManager77:
	CALL        _LearnAuto+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,504 :: 		case 201:LearnManual(); break;
L_StateManager78:
	CALL        _LearnManual+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,506 :: 		case 250:About(); break;
L_StateManager79:
	CALL        _About+0, 0
	GOTO        L_StateManager62
;FirmV_0_7_0.c,508 :: 		}
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
;FirmV_0_7_0.c,509 :: 		}
L_end_StateManager:
	RETURN      0
; end of _StateManager

_StateTest:

;FirmV_0_7_0.c,513 :: 		void StateTest()
;FirmV_0_7_0.c,515 :: 		if (Events.Photocell==1)
	MOVF        _Events+6, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StateTest80
;FirmV_0_7_0.c,516 :: 		LCDLine1[0]='1';
	MOVLW       49
	MOVWF       _LCDLine1+0 
	GOTO        L_StateTest81
L_StateTest80:
;FirmV_0_7_0.c,518 :: 		LCDLine1[0]='0';
	MOVLW       48
	MOVWF       _LCDLine1+0 
L_StateTest81:
;FirmV_0_7_0.c,520 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,522 :: 		}
L_end_StateTest:
	RETURN      0
; end of _StateTest

_State00:

;FirmV_0_7_0.c,526 :: 		void State00()
;FirmV_0_7_0.c,531 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,532 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,533 :: 		StartMotor(1,_Close);
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,534 :: 		StartMotor(2,_Close);
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,536 :: 		if(Events.Remote.b0==1)
	BTFSS       _Events+4, 0 
	GOTO        L_State0082
;FirmV_0_7_0.c,537 :: 		{Flasher=0;FlashFlag=0;StopMotor(1);StopMotor(2);
	BCF         PORTD+0, 7 
	CLRF        _FlashFlag+0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,538 :: 		State=1;                }
	MOVLW       1
	MOVWF       _State+0 
L_State0082:
;FirmV_0_7_0.c,539 :: 		}
L_end_State00:
	RETURN      0
; end of _State00

_State1:

;FirmV_0_7_0.c,548 :: 		void State1()
;FirmV_0_7_0.c,550 :: 		char delay=3;
	MOVLW       3
	MOVWF       State1_delay_L0+0 
	CLRF        State1_AutoCloseTemp_L0+0 
	CLRF        State1_AutoCloseTemp_L0+1 
	CLRF        State1_AutoCloseTemp_L0+2 
	CLRF        State1_AutoCloseTemp_L0+3 
;FirmV_0_7_0.c,552 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,553 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,555 :: 		if(Events.Keys==2)
	MOVF        _Events+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State183
;FirmV_0_7_0.c,556 :: 		{State=100;MenuPointer=0;}
	MOVLW       100
	MOVWF       _State+0 
	CLRF        _MenuPointer+0 
L_State183:
;FirmV_0_7_0.c,558 :: 		ActiveDoors=3-Events.Remote;
	MOVF        _Events+4, 0 
	SUBLW       3
	MOVWF       _ActiveDoors+0 
;FirmV_0_7_0.c,562 :: 		if(Events.Remote!=0)
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State184
;FirmV_0_7_0.c,565 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,566 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,567 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,568 :: 		if(Lockenable)
	MOVF        _LockEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State185
;FirmV_0_7_0.c,569 :: 		AddTask(ms500+1,12);
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
;FirmV_0_7_0.c,570 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,571 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,572 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State186
;FirmV_0_7_0.c,573 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
;FirmV_0_7_0.c,575 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
;FirmV_0_7_0.c,576 :: 		temp=ms500+OpenSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,577 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,578 :: 		temp=ms500+OpenSoftStartTime+delay;
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
;FirmV_0_7_0.c,579 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,580 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State188
;FirmV_0_7_0.c,581 :: 		{temp=ms500+Door1OpenTime-OpenSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
;FirmV_0_7_0.c,582 :: 		temp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,583 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,584 :: 		AutoCloseTemp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,586 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State191
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State191
L__State1815:
;FirmV_0_7_0.c,588 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,589 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,590 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State192
;FirmV_0_7_0.c,591 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,8); M2isSlow=1;}//speed down
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
;FirmV_0_7_0.c,593 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,6); M2isSlow=0;}//speed up
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
;FirmV_0_7_0.c,594 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,595 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,596 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+delay;
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
;FirmV_0_7_0.c,597 :: 		AddTask(temp,6);//Speed up after soft start
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
;FirmV_0_7_0.c,598 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State194
;FirmV_0_7_0.c,599 :: 		{temp=ms500+ActionTimeDiff+Door2OpenTime-OpenSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
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
;FirmV_0_7_0.c,600 :: 		temp=ms500+Door2OpenTime+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,601 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,602 :: 		AutoCloseTemp=ms500+Door2OpenTime+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,603 :: 		}
L_State191:
;FirmV_0_7_0.c,605 :: 		if(AutoCloseTime!=0)
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State1937
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State1937:
	BTFSC       STATUS+0, 2 
	GOTO        L_State195
;FirmV_0_7_0.c,606 :: 		{temp=AutoCloseTemp+AutoCloseTime;AddTask(temp,9);}
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
;FirmV_0_7_0.c,608 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,609 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,610 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,611 :: 		State=3;
	MOVLW       3
	MOVWF       _State+0 
;FirmV_0_7_0.c,612 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,613 :: 		}
L_State184:
;FirmV_0_7_0.c,614 :: 		}
L_end_State1:
	RETURN      0
; end of _State1

_State2:

;FirmV_0_7_0.c,628 :: 		void State2()
;FirmV_0_7_0.c,630 :: 		char delay=2,PrevAC=0;
	MOVLW       2
	MOVWF       State2_delay_L0+0 
	CLRF        State2_PrevAC_L0+0 
;FirmV_0_7_0.c,632 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,633 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,636 :: 		if(ReturnAutoclose()!=PrevAC)
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	XORWF       State2_PrevAC_L0+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_State296
;FirmV_0_7_0.c,638 :: 		LCDFlashFlag=0;
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,639 :: 		PrevAC=ReturnAutoclose();
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	MOVWF       State2_PrevAC_L0+0 
;FirmV_0_7_0.c,640 :: 		charValueToStr_AC(PrevAC,LCDLine2+11);
	MOVF        R0, 0 
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       _LCDLine2+11
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       hi_addr(_LCDLine2+11)
	MOVWF       FARG_charValueToStr_AC+1 
	CALL        _charValueToStr_AC+0, 0
;FirmV_0_7_0.c,641 :: 		memcpy(LCDLine2,"Close after",11);
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
;FirmV_0_7_0.c,642 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,643 :: 		}
L_State296:
;FirmV_0_7_0.c,646 :: 		if((Events.Remote!=0)||(CheckTask(9)))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State2820
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2820
	GOTO        L_State299
L__State2820:
;FirmV_0_7_0.c,649 :: 		ClearTasks(0);
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,650 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State2819
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State2819
	GOTO        L_State2102
L__State2819:
;FirmV_0_7_0.c,652 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,653 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,654 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2103
;FirmV_0_7_0.c,655 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
;FirmV_0_7_0.c,657 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
;FirmV_0_7_0.c,658 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,659 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,660 :: 		temp=ms500+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,661 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,662 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2105
;FirmV_0_7_0.c,663 :: 		{temp=ms500+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
;FirmV_0_7_0.c,664 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2106
;FirmV_0_7_0.c,665 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
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
;FirmV_0_7_0.c,667 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,3);}
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
;FirmV_0_7_0.c,669 :: 		}
L_State2102:
;FirmV_0_7_0.c,671 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2110
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State2110
L__State2818:
;FirmV_0_7_0.c,673 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,674 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,675 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2111
;FirmV_0_7_0.c,676 :: 		{AddTask(temp,8); M2isSlow=1;}//speed down
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
;FirmV_0_7_0.c,678 :: 		{AddTask(temp,6); M2isSlow=0;}//speed up
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
;FirmV_0_7_0.c,679 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,680 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,681 :: 		temp=ms500+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,682 :: 		AddTask(temp,6);//Speed up after soft start
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
;FirmV_0_7_0.c,683 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2113
;FirmV_0_7_0.c,684 :: 		{temp=ms500+Door2CloseTime-CloseSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
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
;FirmV_0_7_0.c,686 :: 		temp=ms500+Door2CloseTime+delay;
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
;FirmV_0_7_0.c,687 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,691 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,692 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,693 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2114
;FirmV_0_7_0.c,694 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
;FirmV_0_7_0.c,696 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
;FirmV_0_7_0.c,697 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,698 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,699 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,700 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,701 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2116
;FirmV_0_7_0.c,702 :: 		{temp=ms500+ActionTimeDiff+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
;FirmV_0_7_0.c,703 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2117
;FirmV_0_7_0.c,704 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
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
;FirmV_0_7_0.c,706 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,3);}
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
;FirmV_0_7_0.c,708 :: 		}
L_State2110:
;FirmV_0_7_0.c,711 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,712 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,713 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,714 :: 		State=4;
	MOVLW       4
	MOVWF       _State+0 
;FirmV_0_7_0.c,715 :: 		}
L_State299:
;FirmV_0_7_0.c,717 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State2121
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2939
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State2939:
	BTFSC       STATUS+0, 2 
	GOTO        L_State2121
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State2121
L__State2817:
;FirmV_0_7_0.c,718 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S2 Auto Close Deleted",1);}
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
L_State2121:
;FirmV_0_7_0.c,720 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State2124
	BTFSC       _Events+6, 0 
	GOTO        L_State2124
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2940
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State2940:
	BTFSC       STATUS+0, 2 
	GOTO        L_State2124
L__State2816:
;FirmV_0_7_0.c,721 :: 		if(CloseAfterPass==0)
	MOVF        _CloseAfterPass+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State2125
;FirmV_0_7_0.c,722 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:",1);Logger(t,1);}
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
	GOTO        L_State2126
L_State2125:
;FirmV_0_7_0.c,724 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:",1);Logger(t,1);}
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
L_State2126:
L_State2124:
;FirmV_0_7_0.c,726 :: 		}
L_end_State2:
	RETURN      0
; end of _State2

_State3:

;FirmV_0_7_0.c,741 :: 		void State3()
;FirmV_0_7_0.c,743 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,744 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,746 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3127
;FirmV_0_7_0.c,747 :: 		{StartMotor(1,_Open);Logger("S3 Motor1Start",1); Lock=0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
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
L_State3127:
;FirmV_0_7_0.c,749 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3128
;FirmV_0_7_0.c,750 :: 		{StartMotor(2,_Open);Logger("S3 Motor2Start",1); Lock=0;}
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
L_State3128:
;FirmV_0_7_0.c,752 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3129
;FirmV_0_7_0.c,753 :: 		{SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;Logger("S3 Motor1 Fast",1);}
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
L_State3129:
;FirmV_0_7_0.c,755 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3130
;FirmV_0_7_0.c,756 :: 		{SetMotorSpeed(0,Motor2FullSpeed); M1isSlow=1;Logger("S3 Motor1 Slow",1);}
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
L_State3130:
;FirmV_0_7_0.c,758 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3131
;FirmV_0_7_0.c,759 :: 		{SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;Logger("S3 Motor2 Fast",1);}
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
L_State3131:
;FirmV_0_7_0.c,761 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3132
;FirmV_0_7_0.c,762 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S3 Motor2 Slow",1);}
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
L_State3132:
;FirmV_0_7_0.c,764 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3133
;FirmV_0_7_0.c,765 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S3 Overflow Flag1 Set",1);}
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
L_State3133:
;FirmV_0_7_0.c,767 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3134
;FirmV_0_7_0.c,768 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S3 Overflow Flag2 Set",1);}
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
L_State3134:
;FirmV_0_7_0.c,770 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3135
;FirmV_0_7_0.c,771 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S3 Motor1 Stop",1);}
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
L_State3135:
;FirmV_0_7_0.c,773 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3136
;FirmV_0_7_0.c,774 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S3 Motor2 Stop",1);}
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
L_State3136:
;FirmV_0_7_0.c,776 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3137
;FirmV_0_7_0.c,777 :: 		{Lock=1;}
	BSF         PORTD+0, 6 
L_State3137:
;FirmV_0_7_0.c,779 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
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
L__State3826:
;FirmV_0_7_0.c,780 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor1 Collision",1);ClearTasks(9);
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
L_State3140:
;FirmV_0_7_0.c,783 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
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
L__State3825:
;FirmV_0_7_0.c,784 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor2 Collision",1);ClearTasks(9);
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
;FirmV_0_7_0.c,785 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=2;}
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
;FirmV_0_7_0.c,787 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State3824
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State3824
	GOTO        L_State3146
L__State3824:
;FirmV_0_7_0.c,788 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State3146:
;FirmV_0_7_0.c,790 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State3149
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3149
L__State3823:
;FirmV_0_7_0.c,791 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Photocell Int",1);ClearTasks(9);
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
;FirmV_0_7_0.c,792 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=2;}
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
;FirmV_0_7_0.c,794 :: 		if(Events.Remote!=0)
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State3150
;FirmV_0_7_0.c,795 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Remote Stoped",1);ClearTasks(9);
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
;FirmV_0_7_0.c,796 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=2;}
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
;FirmV_0_7_0.c,798 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3153
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3153
L__State3822:
;FirmV_0_7_0.c,799 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Limit Switch Stoped",1);ClearTasks(9);
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
;FirmV_0_7_0.c,800 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=2;}
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
;FirmV_0_7_0.c,802 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3154
;FirmV_0_7_0.c,803 :: 		if(LockEnable)
	MOVF        _LockEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3155
;FirmV_0_7_0.c,804 :: 		{StartMotor(1,_Close);StartMotor(2,_Close);SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;
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
;FirmV_0_7_0.c,805 :: 		AddTask(ms500+RelaseTime,3);AddTask(ms500+RelaseTime,4);AddTask(ms500+1+RelaseTime,13);OpenDone.b2=1;}
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
	GOTO        L_State3156
L_State3155:
;FirmV_0_7_0.c,807 :: 		{AddTask(ms500+1,13);OpenDone.b2=1;}
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
L_State3156:
L_State3154:
;FirmV_0_7_0.c,809 :: 		if(CheckTask(13))
	MOVLW       13
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3157
;FirmV_0_7_0.c,810 :: 		{State=2; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_blank,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State3157:
;FirmV_0_7_0.c,812 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State3821
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State3821
	GOTO        L_State3160
L__State3821:
;FirmV_0_7_0.c,813 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S3 Autoclose Renewed",1);memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;LCDLines=2;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State3942
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State3942:
	BTFSC       STATUS+0, 2 
	GOTO        L_State3161
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
L_State3161:
L_State3160:
;FirmV_0_7_0.c,815 :: 		}
L_end_State3:
	RETURN      0
; end of _State3

_State4:

;FirmV_0_7_0.c,829 :: 		void State4()
;FirmV_0_7_0.c,831 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,832 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,835 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4162
;FirmV_0_7_0.c,836 :: 		{StartMotor(1,_Close);Logger("S4 Motor1Start",1);}
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
L_State4162:
;FirmV_0_7_0.c,838 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4163
;FirmV_0_7_0.c,839 :: 		{StartMotor(2,_Close);Logger("S4 Motor2Start",1);memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
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
L_State4163:
;FirmV_0_7_0.c,841 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4164
;FirmV_0_7_0.c,842 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S4 M1 Overload Check",1);}
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
L_State4164:
;FirmV_0_7_0.c,844 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4165
;FirmV_0_7_0.c,845 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S4 M2 Overload Check",1);}
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
L_State4165:
;FirmV_0_7_0.c,847 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4166
;FirmV_0_7_0.c,848 :: 		{SetMotorSpeed(1,Motor2FullSpeed); OverloadCheckFlag1=0; M1isSlow=0;Logger("S4 M1 Speed UP",1);}
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
L_State4166:
;FirmV_0_7_0.c,850 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4167
;FirmV_0_7_0.c,851 :: 		{SetMotorSpeed(0,Motor2FullSpeed); OverloadCheckFlag1=0; M1isSlow=1;Logger("S4 M1 Speed Down",1);}
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
L_State4167:
;FirmV_0_7_0.c,853 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4168
;FirmV_0_7_0.c,854 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S4 M2 Speed UP",1);}
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
L_State4168:
;FirmV_0_7_0.c,856 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4169
;FirmV_0_7_0.c,857 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S4 M2 Speed Down",1);}
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
L_State4169:
;FirmV_0_7_0.c,859 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4170
;FirmV_0_7_0.c,860 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S4 M1 Stoped",1);}
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
L_State4170:
;FirmV_0_7_0.c,862 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4171
;FirmV_0_7_0.c,863 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S4 M2 Stoped",1);}
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
L_State4171:
;FirmV_0_7_0.c,865 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4174
	BTFSS       _Events+5, 0 
	GOTO        L_State4174
	MOVF        _M1isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4174
L__State4831:
;FirmV_0_7_0.c,866 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M1 Overloaded",1);ClearTasks(9);
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
;FirmV_0_7_0.c,867 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=2;}
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
;FirmV_0_7_0.c,869 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4177
	BTFSS       _Events+5, 1 
	GOTO        L_State4177
	MOVF        _M2isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4177
L__State4830:
;FirmV_0_7_0.c,870 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M2 Overloaded",1);ClearTasks(9);
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
;FirmV_0_7_0.c,871 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=2;}
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
;FirmV_0_7_0.c,873 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State4829
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State4829
	GOTO        L_State4180
L__State4829:
;FirmV_0_7_0.c,874 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State4180:
;FirmV_0_7_0.c,876 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State4181
;FirmV_0_7_0.c,877 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S4 Photocell Int",1);ClearTasks(9);
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
;FirmV_0_7_0.c,878 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State4181:
;FirmV_0_7_0.c,880 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4184
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4184
L__State4828:
;FirmV_0_7_0.c,881 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Limit Switch Stop",1);ClearTasks(9);
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
;FirmV_0_7_0.c,882 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State4184:
;FirmV_0_7_0.c,884 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State4185
;FirmV_0_7_0.c,885 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Remote Pressed",1);ClearTasks(9);
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
;FirmV_0_7_0.c,886 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State4185:
;FirmV_0_7_0.c,888 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4186
;FirmV_0_7_0.c,889 :: 		if(LockEnable)
	MOVF        _LockEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4187
;FirmV_0_7_0.c,890 :: 		{StartMotor(1,_Open);AddTask(ms500+1,14);SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0;M1isSlow=0;SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0;M2isSlow=0;
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
;FirmV_0_7_0.c,891 :: 		AddTask(ms500+RelaseTime,3);AddTask(ms500+1+RelaseTime,4);AddTask(ms500+1+RelaseTime,13);CloseDone.b2=1;}
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
	GOTO        L_State4188
L_State4187:
;FirmV_0_7_0.c,893 :: 		{AddTask(ms500+1,13);CloseDone.b2=1;}
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
L_State4188:
L_State4186:
;FirmV_0_7_0.c,895 :: 		if(CheckTask(14))
	MOVLW       14
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4189
;FirmV_0_7_0.c,896 :: 		StartMotor(2,_Open);
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
L_State4189:
;FirmV_0_7_0.c,898 :: 		if(CheckTask(13))
	MOVLW       13
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4190
;FirmV_0_7_0.c,899 :: 		{State=1; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
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
L_State4190:
;FirmV_0_7_0.c,901 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State4827
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State4827
	GOTO        L_State4193
L__State4827:
;FirmV_0_7_0.c,902 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S4 Autoclose Renewed",1);memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;LCDLines=2;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State4944
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State4944:
	BTFSC       STATUS+0, 2 
	GOTO        L_State4194
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
L_State4194:
L_State4193:
;FirmV_0_7_0.c,904 :: 		}
L_end_State4:
	RETURN      0
; end of _State4

_State5:

;FirmV_0_7_0.c,919 :: 		void State5()
;FirmV_0_7_0.c,921 :: 		char delay=2;
	MOVLW       2
	MOVWF       State5_delay_L0+0 
;FirmV_0_7_0.c,922 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,923 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,924 :: 		if((Events.Remote!=0)||(CheckTask(9)==1))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State5836
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5836
	GOTO        L_State5197
L__State5836:
;FirmV_0_7_0.c,926 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State5835
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5835
	GOTO        L_State5200
L__State5835:
;FirmV_0_7_0.c,928 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,929 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,930 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,931 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,932 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,933 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,934 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,935 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,936 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,937 :: 		}
L_State5200:
;FirmV_0_7_0.c,938 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State5203
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State5203
L__State5834:
;FirmV_0_7_0.c,940 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,941 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,942 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,943 :: 		AddTask(temp,6);
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
;FirmV_0_7_0.c,944 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,945 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,946 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,947 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,948 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,953 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,954 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,955 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,956 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,957 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,958 :: 		temp=ms500+ActionTimeDiff+OverloadDelay+delay;
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
;FirmV_0_7_0.c,959 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,960 :: 		temp=ms500+Door2CloseTime+delay+ActionTimeDiff;
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
;FirmV_0_7_0.c,961 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,962 :: 		}
L_State5203:
;FirmV_0_7_0.c,963 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,964 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,965 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,966 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,967 :: 		}
L_State5197:
;FirmV_0_7_0.c,969 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State5206
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State5946
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State5946:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5206
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State5206
L__State5833:
;FirmV_0_7_0.c,970 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S5 Auto Close Deleted",1);}
	MOVLW       1
	MOVWF       _PassFlag+0 
	CALL        _GetAutocloseTime+0, 0
	MOVF        R0, 0 
	MOVWF       __AC+0 
	MOVLW       ?lstr39_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr39_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State5206:
;FirmV_0_7_0.c,972 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State5209
	BTFSC       _Events+6, 0 
	GOTO        L_State5209
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State5947
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State5947:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5209
L__State5832:
;FirmV_0_7_0.c,975 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:",1);Logger(t,1);}
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
;FirmV_0_7_0.c,977 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:",1);Logger(t,1);}
L_State5211:
;FirmV_0_7_0.c,978 :: 		}
L_State5209:
;FirmV_0_7_0.c,980 :: 		}
L_end_State5:
	RETURN      0
; end of _State5

_State6:

;FirmV_0_7_0.c,1000 :: 		void State6()
;FirmV_0_7_0.c,1004 :: 		char delay=3;
	MOVLW       3
	MOVWF       State6_delay_L0+0 
;FirmV_0_7_0.c,1005 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,1006 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,1007 :: 		if((Events.Remote!=0)||(PhotocellOpenFlag))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State6841
	MOVF        _PhotocellOpenFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6841
	GOTO        L_State6214
L__State6841:
;FirmV_0_7_0.c,1009 :: 		PhotocellOpenFlag=0;
	CLRF        _PhotocellOpenFlag+0 
;FirmV_0_7_0.c,1010 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,1011 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,1012 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1013 :: 		if(Lockenable)
	MOVF        _LockEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State6215
;FirmV_0_7_0.c,1014 :: 		AddTask(ms500+1,12);
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
L_State6215:
;FirmV_0_7_0.c,1015 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,1016 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,1017 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,1018 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,1019 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,1020 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,1021 :: 		temp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,1022 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,1023 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6218
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6218
L__State6840:
;FirmV_0_7_0.c,1025 :: 		AddTask(ms500+ActionTimeDiff+delay,2);
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
;FirmV_0_7_0.c,1026 :: 		AddTask(ms500+ActionTimeDiff+delay,6);
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
;FirmV_0_7_0.c,1027 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,1028 :: 		AddTask(ms500+ActionTimeDiff+OverloadDelay+delay,11); //overload check
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
;FirmV_0_7_0.c,1029 :: 		AddTask(ms500+Door2OpenTime+ActionTimeDiff+delay,4);//Stop motor
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
;FirmV_0_7_0.c,1030 :: 		}
L_State6218:
;FirmV_0_7_0.c,1031 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,1032 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,1033 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,1034 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,1035 :: 		State=8;
	MOVLW       8
	MOVWF       _State+0 
;FirmV_0_7_0.c,1036 :: 		}
L_State6214:
;FirmV_0_7_0.c,1039 :: 		if(CheckTask(9)==1)
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6219
;FirmV_0_7_0.c,1041 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1042 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,1043 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,1044 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,1045 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,1046 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,1047 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,1048 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,1049 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,1051 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6222
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6222
L__State6839:
;FirmV_0_7_0.c,1053 :: 		AddTask(ms500+ActionTimeDiff+delay,2);
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
;FirmV_0_7_0.c,1054 :: 		AddTask(ms500+ActionTimeDiff+delay,6);
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
;FirmV_0_7_0.c,1055 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,1056 :: 		AddTask(ms500+ActionTimeDiff+OverloadDelay+delay,11); //overload check
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
;FirmV_0_7_0.c,1057 :: 		AddTask(ms500+Door1CloseTime+ActionTimeDiff+delay,4);//Stop motor
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
;FirmV_0_7_0.c,1058 :: 		}
L_State6222:
;FirmV_0_7_0.c,1059 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,1060 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,1061 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,1062 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,1063 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,1064 :: 		}
L_State6219:
;FirmV_0_7_0.c,1066 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State6225
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6949
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State6949:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6225
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State6225
L__State6838:
;FirmV_0_7_0.c,1067 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S6 Auto Close Deleted",1);}
	MOVLW       1
	MOVWF       _PassFlag+0 
	CALL        _GetAutocloseTime+0, 0
	MOVF        R0, 0 
	MOVWF       __AC+0 
	MOVLW       ?lstr42_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr42_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State6225:
;FirmV_0_7_0.c,1069 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6228
	BTFSC       _Events+6, 0 
	GOTO        L_State6228
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6950
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State6950:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6228
L__State6837:
;FirmV_0_7_0.c,1071 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:",1);Logger(t,1);}
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
;FirmV_0_7_0.c,1073 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:",1);Logger(t,1);}
L_State6230:
;FirmV_0_7_0.c,1074 :: 		}
L_State6228:
;FirmV_0_7_0.c,1076 :: 		}
L_end_State6:
	RETURN      0
; end of _State6

_State7:

;FirmV_0_7_0.c,1098 :: 		void State7()
;FirmV_0_7_0.c,1100 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,1101 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,1103 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7231
;FirmV_0_7_0.c,1104 :: 		{StartMotor(1,_Close);Logger("S7 Motor1Start",1);}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       ?lstr45_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr45_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7231:
;FirmV_0_7_0.c,1106 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7232
;FirmV_0_7_0.c,1107 :: 		{StartMotor(2,_Close);Logger("S7 Motor2Start",1);memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
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
L_State7232:
;FirmV_0_7_0.c,1109 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7233
;FirmV_0_7_0.c,1110 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S7 M1 Overload Check",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr47_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr47_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7233:
;FirmV_0_7_0.c,1112 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7234
;FirmV_0_7_0.c,1113 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S7 M2 Overload Check",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr48_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr48_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7234:
;FirmV_0_7_0.c,1115 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7235
;FirmV_0_7_0.c,1116 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S7 M1 Speed UP",1);}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
	MOVLW       ?lstr49_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr49_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7235:
;FirmV_0_7_0.c,1118 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7236
;FirmV_0_7_0.c,1119 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S7 M2 Speed UP",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       ?lstr50_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr50_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7236:
;FirmV_0_7_0.c,1121 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(CloseDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7849
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7850
	BTFSS       _Events+5, 0 
	GOTO        L__State7850
	GOTO        L__State7849
L__State7850:
	GOTO        L_State7243
L__State7849:
	BTFSS       _CloseDone+0, 0 
	GOTO        L_State7243
L__State7848:
;FirmV_0_7_0.c,1122 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S7 M1 Stoped",1);}
	BCF         _CloseDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr51_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr51_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7243:
;FirmV_0_7_0.c,1124 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(CloseDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7846
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7847
	BTFSS       _Events+5, 1 
	GOTO        L__State7847
	GOTO        L__State7846
L__State7847:
	GOTO        L_State7250
L__State7846:
	BTFSS       _CloseDone+0, 1 
	GOTO        L_State7250
L__State7845:
;FirmV_0_7_0.c,1125 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S7 M2 Stoped",1);}
	BCF         _CloseDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr52_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr52_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7250:
;FirmV_0_7_0.c,1127 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State7844
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State7844
	GOTO        L_State7253
L__State7844:
;FirmV_0_7_0.c,1128 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State7253:
;FirmV_0_7_0.c,1130 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State7254
;FirmV_0_7_0.c,1131 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S7 Photocell Int",1);ClearTasks(9);
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
;FirmV_0_7_0.c,1132 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State7254:
;FirmV_0_7_0.c,1134 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State7255
;FirmV_0_7_0.c,1135 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Remote Pressed",1);ClearTasks(9);
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
;FirmV_0_7_0.c,1136 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State7255:
;FirmV_0_7_0.c,1138 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State7258
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7258
L__State7843:
;FirmV_0_7_0.c,1139 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Limit Switch Stop",1);ClearTasks(9);
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
;FirmV_0_7_0.c,1140 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State7258:
;FirmV_0_7_0.c,1142 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State7259
;FirmV_0_7_0.c,1143 :: 		if(LockEnable)
	MOVF        _LockEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7260
;FirmV_0_7_0.c,1144 :: 		{StartMotor(1,_Open);AddTask(ms500+1,14);SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;
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
;FirmV_0_7_0.c,1145 :: 		AddTask(ms500+RelaseTime,3);AddTask(ms500+1+RelaseTime,4);AddTask(ms500+1+RelaseTime,13);CloseDone.b2=1;}
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
	GOTO        L_State7261
L_State7260:
;FirmV_0_7_0.c,1147 :: 		{AddTask(ms500+1,13);CloseDone.b2=1;}
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
L_State7261:
L_State7259:
;FirmV_0_7_0.c,1149 :: 		if(CheckTask(14))
	MOVLW       14
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7262
;FirmV_0_7_0.c,1150 :: 		StartMotor(2,_Open);
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
L_State7262:
;FirmV_0_7_0.c,1152 :: 		if(CheckTask(13))
	MOVLW       13
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7263
;FirmV_0_7_0.c,1153 :: 		{State=1; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
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
L_State7263:
;FirmV_0_7_0.c,1155 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State7842
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State7842
	GOTO        L_State7266
L__State7842:
;FirmV_0_7_0.c,1156 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S7 Autoclose Renewed",1);memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;LCDLines=2;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7952
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State7952:
	BTFSC       STATUS+0, 2 
	GOTO        L_State7267
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
L_State7267:
L_State7266:
;FirmV_0_7_0.c,1159 :: 		}
L_end_State7:
	RETURN      0
; end of _State7

_State8:

;FirmV_0_7_0.c,1176 :: 		void State8()
;FirmV_0_7_0.c,1178 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,1179 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,1181 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8268
;FirmV_0_7_0.c,1182 :: 		{StartMotor(1,_Open);Logger("S8 Motor1Start",1); Lock=0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
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
L_State8268:
;FirmV_0_7_0.c,1184 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8269
;FirmV_0_7_0.c,1185 :: 		{StartMotor(2,_Open);Logger("S8 Motor2Start",1); Lock=0;}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       ?lstr58_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr58_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	BCF         PORTD+0, 6 
L_State8269:
;FirmV_0_7_0.c,1187 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8270
;FirmV_0_7_0.c,1188 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S8 Overflow Flag1 Set",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr59_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr59_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8270:
;FirmV_0_7_0.c,1190 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8271
;FirmV_0_7_0.c,1191 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S8 Overflow Flag2 Set",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr60_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr60_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8271:
;FirmV_0_7_0.c,1193 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8272
;FirmV_0_7_0.c,1194 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S8 Motor1 Fast",1);}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
	MOVLW       ?lstr61_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr61_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8272:
;FirmV_0_7_0.c,1196 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8273
;FirmV_0_7_0.c,1197 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S8 Motor2 Fast",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       ?lstr62_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr62_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8273:
;FirmV_0_7_0.c,1199 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(OpenDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8859
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8860
	BTFSS       _Events+5, 0 
	GOTO        L__State8860
	GOTO        L__State8859
L__State8860:
	GOTO        L_State8280
L__State8859:
	BTFSS       _OpenDone+0, 0 
	GOTO        L_State8280
L__State8858:
;FirmV_0_7_0.c,1200 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S8 Motor1 Stop",1);}
	BCF         _OpenDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr63_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr63_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8280:
;FirmV_0_7_0.c,1202 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(OpenDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8856
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8857
	BTFSS       _Events+5, 1 
	GOTO        L__State8857
	GOTO        L__State8856
L__State8857:
	GOTO        L_State8287
L__State8856:
	BTFSS       _OpenDone+0, 1 
	GOTO        L_State8287
L__State8855:
;FirmV_0_7_0.c,1203 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S8 Motor2 Stop",1);}
	BCF         _OpenDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr64_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr64_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8287:
;FirmV_0_7_0.c,1205 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8288
;FirmV_0_7_0.c,1206 :: 		{Lock=1;}
	BSF         PORTD+0, 6 
L_State8288:
;FirmV_0_7_0.c,1208 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State8854
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State8854
	GOTO        L_State8291
L__State8854:
;FirmV_0_7_0.c,1209 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State8291:
;FirmV_0_7_0.c,1211 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State8294
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8294
L__State8853:
;FirmV_0_7_0.c,1212 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S8 Photocell Int",1);ClearTasks(9);
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
;FirmV_0_7_0.c,1213 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State8294:
;FirmV_0_7_0.c,1215 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State8295
;FirmV_0_7_0.c,1216 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Motors Stoped (Remote)",1);ClearTasks(9);
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
;FirmV_0_7_0.c,1217 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State8295:
;FirmV_0_7_0.c,1219 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State8298
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8298
L__State8852:
;FirmV_0_7_0.c,1220 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Limit Switch Stop",1);ClearTasks(9);
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
;FirmV_0_7_0.c,1221 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=2;}
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
L_State8298:
;FirmV_0_7_0.c,1223 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State8299
;FirmV_0_7_0.c,1224 :: 		if(LockEnable)
	MOVF        _LockEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8300
;FirmV_0_7_0.c,1225 :: 		{StartMotor(1,_Close);StartMotor(2,_Close);SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;
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
;FirmV_0_7_0.c,1226 :: 		AddTask(ms500+RelaseTime,3);AddTask(ms500+RelaseTime,4);AddTask(ms500+1+RelaseTime,13);OpenDone.b2=1;}
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
	GOTO        L_State8301
L_State8300:
;FirmV_0_7_0.c,1228 :: 		{AddTask(ms500+1,13);OpenDone.b2=1;}
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
L_State8301:
L_State8299:
;FirmV_0_7_0.c,1231 :: 		if(CheckTask(13))
	MOVLW       13
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8302
;FirmV_0_7_0.c,1232 :: 		{State=2; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
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
L_State8302:
;FirmV_0_7_0.c,1234 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State8851
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State8851
	GOTO        L_State8305
L__State8851:
;FirmV_0_7_0.c,1235 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S8 Autoclose Renewed",1);memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;LCDLines=2;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8954
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State8954:
	BTFSC       STATUS+0, 2 
	GOTO        L_State8306
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
L_State8306:
L_State8305:
;FirmV_0_7_0.c,1238 :: 		}
L_end_State8:
	RETURN      0
; end of _State8

_LCDUpdater:

;FirmV_0_7_0.c,1247 :: 		void LCDUpdater()
;FirmV_0_7_0.c,1252 :: 		if(LCDUpdateFlag==1)
	MOVF        _LCDUpdateFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDUpdater307
;FirmV_0_7_0.c,1254 :: 		if(LCDLines!=line)
	MOVF        _LCDLines+0, 0 
	XORWF       LCDUpdater_line_L0+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater308
;FirmV_0_7_0.c,1256 :: 		line=LCDLines;
	MOVF        _LCDLines+0, 0 
	MOVWF       LCDUpdater_line_L0+0 
;FirmV_0_7_0.c,1257 :: 		LCD_init(LCDLines);
	MOVF        _LCDLines+0, 0 
	MOVWF       FARG_LCD_Init+0 
	CALL        _LCD_Init+0, 0
;FirmV_0_7_0.c,1258 :: 		delay_ms(50);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_LCDUpdater309:
	DECFSZ      R13, 1, 1
	BRA         L_LCDUpdater309
	DECFSZ      R12, 1, 1
	BRA         L_LCDUpdater309
	DECFSZ      R11, 1, 1
	BRA         L_LCDUpdater309
	NOP
	NOP
;FirmV_0_7_0.c,1259 :: 		}
L_LCDUpdater308:
;FirmV_0_7_0.c,1260 :: 		lcd_out(1,0,LCDLine1);
	MOVLW       1
	MOVWF       FARG_LCD_out+0 
	CLRF        FARG_LCD_out+0 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_LCD_out+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_LCD_out+1 
	CALL        _LCD_out+0, 0
;FirmV_0_7_0.c,1261 :: 		if(!LCDFlash)
	MOVF        _LCDFlash+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDUpdater310
;FirmV_0_7_0.c,1262 :: 		lcd_out(2,0,LCDLine2);
	MOVLW       2
	MOVWF       FARG_LCD_out+0 
	CLRF        FARG_LCD_out+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_LCD_out+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_LCD_out+1 
	CALL        _LCD_out+0, 0
	GOTO        L_LCDUpdater311
L_LCDUpdater310:
;FirmV_0_7_0.c,1264 :: 		UpdateWhenFlashing=1;
	MOVLW       1
	MOVWF       LCDUpdater_UpdateWhenFlashing_L0+0 
L_LCDUpdater311:
;FirmV_0_7_0.c,1265 :: 		LCDUpdateFlag=0;
	CLRF        _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1266 :: 		}
L_LCDUpdater307:
;FirmV_0_7_0.c,1268 :: 		if(LCDFlash)
	MOVF        _LCDFlash+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater312
;FirmV_0_7_0.c,1270 :: 		if(((LCDFlashFlag)&&(LastLCDFlashState==0))||((LastLCDFlashState)&&(UpdatewhenFlashing)))
	MOVF        _LCDFlashFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater866
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__LCDUpdater866
	GOTO        L__LCDUpdater864
L__LCDUpdater866:
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater865
	MOVF        LCDUpdater_UpdateWhenFlashing_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater865
	GOTO        L__LCDUpdater864
L__LCDUpdater865:
	GOTO        L_LCDUpdater319
L__LCDUpdater864:
;FirmV_0_7_0.c,1271 :: 		{memcpy(LCDLineTemp,LCDLine2,16);LCDLineTemp[0]='>';LCDLineTemp[1]='>';LCDLineTemp[2]='>';LCDLineTemp[13]='<';LCDLineTemp[14]='<';LCDLineTemp[15]='<';lcd_out(2,0,LCDLineTemp);LastLCDFlashState=1;UpdatewhenFlashing=0;}
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
L_LCDUpdater319:
;FirmV_0_7_0.c,1272 :: 		if(((!LCDFlashFlag)&&(LastLCDFlashState!=0))||((!LastLCDFlashState)&&(UpdatewhenFlashing)))
	MOVF        _LCDFlashFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCDUpdater863
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater863
	GOTO        L__LCDUpdater861
L__LCDUpdater863:
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCDUpdater862
	MOVF        LCDUpdater_UpdateWhenFlashing_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater862
	GOTO        L__LCDUpdater861
L__LCDUpdater862:
	GOTO        L_LCDUpdater326
L__LCDUpdater861:
;FirmV_0_7_0.c,1273 :: 		{lcd_out(2,0,LCDLine2);LastLCDFlashState=0;UpdatewhenFlashing=0;}
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
L_LCDUpdater326:
;FirmV_0_7_0.c,1274 :: 		}
L_LCDUpdater312:
;FirmV_0_7_0.c,1277 :: 		}
L_end_LCDUpdater:
	RETURN      0
; end of _LCDUpdater

_Init:

;FirmV_0_7_0.c,1297 :: 		void Init()
;FirmV_0_7_0.c,1299 :: 		char i=0;
	CLRF        Init_i_L0+0 
;FirmV_0_7_0.c,1301 :: 		porta=0;
	CLRF        PORTA+0 
;FirmV_0_7_0.c,1302 :: 		portb=0;
	CLRF        PORTB+0 
;FirmV_0_7_0.c,1303 :: 		portc=0;
	CLRF        PORTC+0 
;FirmV_0_7_0.c,1304 :: 		portd=0;
	CLRF        PORTD+0 
;FirmV_0_7_0.c,1305 :: 		porte=0;
	CLRF        PORTE+0 
;FirmV_0_7_0.c,1306 :: 		trisa=0b101111;
	MOVLW       47
	MOVWF       TRISA+0 
;FirmV_0_7_0.c,1307 :: 		trisb=0b00000111;
	MOVLW       7
	MOVWF       TRISB+0 
;FirmV_0_7_0.c,1308 :: 		trisc=0b10000100;
	MOVLW       132
	MOVWF       TRISC+0 
;FirmV_0_7_0.c,1309 :: 		trisd=0b00111111;
	MOVLW       63
	MOVWF       TRISD+0 
;FirmV_0_7_0.c,1310 :: 		trise=0b001;
	MOVLW       1
	MOVWF       TRISE+0 
;FirmV_0_7_0.c,1311 :: 		adcon1=0b1100;  // an6, an5 and an7 is digital
	MOVLW       12
	MOVWF       ADCON1+0 
;FirmV_0_7_0.c,1317 :: 		LCDBackLight=1;
	BSF         PORTA+0, 4 
;FirmV_0_7_0.c,1318 :: 		I2C1_init(100000);
	MOVLW       100
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;FirmV_0_7_0.c,1320 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Init327:
	DECFSZ      R13, 1, 1
	BRA         L_Init327
	DECFSZ      R12, 1, 1
	BRA         L_Init327
	DECFSZ      R11, 1, 1
	BRA         L_Init327
	NOP
	NOP
;FirmV_0_7_0.c,1322 :: 		LCD_init(1);
	MOVLW       1
	MOVWF       FARG_LCD_Init+0 
	CALL        _LCD_Init+0, 0
;FirmV_0_7_0.c,1323 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,1324 :: 		delay_ms(300);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_Init328:
	DECFSZ      R13, 1, 1
	BRA         L_Init328
	DECFSZ      R12, 1, 1
	BRA         L_Init328
	DECFSZ      R11, 1, 1
	BRA         L_Init328
	NOP
	NOP
;FirmV_0_7_0.c,1325 :: 		SetContrast(20);
	MOVLW       20
	MOVWF       FARG_SetContrast+0 
	CALL        _SetContrast+0, 0
;FirmV_0_7_0.c,1328 :: 		ms500=0;
	CLRF        _ms500+0 
	CLRF        _ms500+1 
	CLRF        _ms500+2 
	CLRF        _ms500+3 
;FirmV_0_7_0.c,1329 :: 		t0con=0b10000101; //enable tmr0 and prescalar
	MOVLW       133
	MOVWF       T0CON+0 
;FirmV_0_7_0.c,1330 :: 		intcon.b7=1;   //global int enable
	BSF         INTCON+0, 7 
;FirmV_0_7_0.c,1331 :: 		intcon.b5=1;  //tmr0 int enable
	BSF         INTCON+0, 5 
;FirmV_0_7_0.c,1332 :: 		intcon.b2=0; //tmr0 flag
	BCF         INTCON+0, 2 
;FirmV_0_7_0.c,1333 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,1334 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,1337 :: 		INT1IP_bit=1;
	BSF         INT1IP_bit+0, BitPos(INT1IP_bit+0) 
;FirmV_0_7_0.c,1338 :: 		INT1E_bit=1;
	BSF         INT1E_bit+0, BitPos(INT1E_bit+0) 
;FirmV_0_7_0.c,1339 :: 		INT1F_bit=0;
	BCF         INT1F_bit+0, BitPos(INT1F_bit+0) 
;FirmV_0_7_0.c,1340 :: 		INT2IP_bit=1;
	BSF         INT2IP_bit+0, BitPos(INT2IP_bit+0) 
;FirmV_0_7_0.c,1341 :: 		INT2E_bit=1;
	BSF         INT2E_bit+0, BitPos(INT2E_bit+0) 
;FirmV_0_7_0.c,1342 :: 		INT2F_bit=0;
	BCF         INT2F_bit+0, BitPos(INT2F_bit+0) 
;FirmV_0_7_0.c,1343 :: 		INTEDG1_bit=1;
	BSF         INTEDG1_bit+0, BitPos(INTEDG1_bit+0) 
;FirmV_0_7_0.c,1344 :: 		INTEDG2_bit=1;
	BSF         INTEDG2_bit+0, BitPos(INTEDG2_bit+0) 
;FirmV_0_7_0.c,1347 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, BitPos(INT0F_bit+0) 
;FirmV_0_7_0.c,1348 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, BitPos(INT0E_bit+0) 
;FirmV_0_7_0.c,1351 :: 		for(i=0;i<20;i++)
	CLRF        Init_i_L0+0 
L_Init329:
	MOVLW       20
	SUBWF       Init_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Init330
;FirmV_0_7_0.c,1352 :: 		Tasks[i].Expired=1;
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
;FirmV_0_7_0.c,1351 :: 		for(i=0;i<20;i++)
	INCF        Init_i_L0+0, 1 
;FirmV_0_7_0.c,1352 :: 		Tasks[i].Expired=1;
	GOTO        L_Init329
L_Init330:
;FirmV_0_7_0.c,1355 :: 		Events.Keys=0;
	CLRF        _Events+0 
;FirmV_0_7_0.c,1356 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,1357 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,1358 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,1359 :: 		Events.Remote=0;
	CLRF        _Events+4 
;FirmV_0_7_0.c,1360 :: 		Events.Overload=0;
	CLRF        _Events+5 
;FirmV_0_7_0.c,1361 :: 		Events.Photocell=0;
	CLRF        _Events+6 
;FirmV_0_7_0.c,1364 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,1367 :: 		UART1_init(115200);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       86
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;FirmV_0_7_0.c,1370 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,1374 :: 		}
L_end_Init:
	RETURN      0
; end of _Init

_TaskManager:

;FirmV_0_7_0.c,1388 :: 		void TaskManager()
;FirmV_0_7_0.c,1390 :: 		char i=0;
	CLRF        TaskManager_i_L0+0 
;FirmV_0_7_0.c,1391 :: 		for(i=0;i<20;i++)
	CLRF        TaskManager_i_L0+0 
L_TaskManager332:
	MOVLW       20
	SUBWF       TaskManager_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TaskManager333
;FirmV_0_7_0.c,1392 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Time==ms500)&&(Tasks[i].Fired==0))
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
	GOTO        L_TaskManager337
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
	GOTO        L__TaskManager958
	MOVF        R3, 0 
	XORWF       _ms500+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager958
	MOVF        R2, 0 
	XORWF       _ms500+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager958
	MOVF        R1, 0 
	XORWF       _ms500+0, 0 
L__TaskManager958:
	BTFSS       STATUS+0, 2 
	GOTO        L_TaskManager337
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
	GOTO        L_TaskManager337
L__TaskManager867:
;FirmV_0_7_0.c,1393 :: 		Tasks[i].Fired=1;
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
L_TaskManager337:
;FirmV_0_7_0.c,1391 :: 		for(i=0;i<20;i++)
	INCF        TaskManager_i_L0+0, 1 
;FirmV_0_7_0.c,1393 :: 		Tasks[i].Fired=1;
	GOTO        L_TaskManager332
L_TaskManager333:
;FirmV_0_7_0.c,1394 :: 		}
L_end_TaskManager:
	RETURN      0
; end of _TaskManager

_AddTask:

;FirmV_0_7_0.c,1406 :: 		void AddTask(unsigned long OccTime,char tcode)
;FirmV_0_7_0.c,1409 :: 		for(i=0;i<20;i++)
	CLRF        AddTask_i_L0+0 
L_AddTask338:
	MOVLW       20
	SUBWF       AddTask_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AddTask339
;FirmV_0_7_0.c,1410 :: 		if(Tasks[i].Expired==1)
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
	GOTO        L_AddTask341
;FirmV_0_7_0.c,1412 :: 		Tasks[i].TaskCode=tcode;
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
;FirmV_0_7_0.c,1413 :: 		Tasks[i].Time=OccTime;
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
;FirmV_0_7_0.c,1414 :: 		Tasks[i].Expired=0;
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
;FirmV_0_7_0.c,1415 :: 		Tasks[i].Fired=0;
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
;FirmV_0_7_0.c,1416 :: 		break;
	GOTO        L_AddTask339
;FirmV_0_7_0.c,1417 :: 		}
L_AddTask341:
;FirmV_0_7_0.c,1409 :: 		for(i=0;i<20;i++)
	INCF        AddTask_i_L0+0, 1 
;FirmV_0_7_0.c,1417 :: 		}
	GOTO        L_AddTask338
L_AddTask339:
;FirmV_0_7_0.c,1418 :: 		}
L_end_AddTask:
	RETURN      0
; end of _AddTask

_EventHandler:

;FirmV_0_7_0.c,1428 :: 		void EventHandler()
;FirmV_0_7_0.c,1431 :: 		Events.ExternalKeys=GetExternalKeysState();
	CALL        _GetExternalKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+8 
;FirmV_0_7_0.c,1432 :: 		Events.Limiter=GetLimitSwitchState();
	CALL        _GetLimitSwitchState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+7 
;FirmV_0_7_0.c,1433 :: 		Events.Keys=GetKeysState();
	CALL        _GetKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+0 
;FirmV_0_7_0.c,1434 :: 		Events.Remote=GetRemoteState();
	CALL        _GetRemoteState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+4 
;FirmV_0_7_0.c,1435 :: 		Events.Overload=GetOverloadState();
	CALL        _GetOverloadState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+5 
;FirmV_0_7_0.c,1436 :: 		Events.Photocell=GetPhotocellState();
	CALL        _GetPhotocellState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+6 
;FirmV_0_7_0.c,1438 :: 		for(i=0;i<20;i++)
	CLRF        EventHandler_i_L0+0 
L_EventHandler342:
	MOVLW       20
	SUBWF       EventHandler_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_EventHandler343
;FirmV_0_7_0.c,1439 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Fired==1))
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
	GOTO        L_EventHandler347
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
	GOTO        L_EventHandler347
L__EventHandler868:
;FirmV_0_7_0.c,1441 :: 		if(Events.Task1==0)
	MOVF        _Events+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler348
;FirmV_0_7_0.c,1442 :: 		{Events.Task1=Tasks[i].TaskCode; Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
	GOTO        L_EventHandler349
L_EventHandler348:
;FirmV_0_7_0.c,1443 :: 		else if(Events.Task2==0)
	MOVF        _Events+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler350
;FirmV_0_7_0.c,1444 :: 		{Events.Task2=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
	GOTO        L_EventHandler351
L_EventHandler350:
;FirmV_0_7_0.c,1445 :: 		else if(Events.Task3==0)
	MOVF        _Events+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler352
;FirmV_0_7_0.c,1446 :: 		{Events.Task3=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
L_EventHandler352:
L_EventHandler351:
L_EventHandler349:
;FirmV_0_7_0.c,1447 :: 		}
L_EventHandler347:
;FirmV_0_7_0.c,1438 :: 		for(i=0;i<20;i++)
	INCF        EventHandler_i_L0+0, 1 
;FirmV_0_7_0.c,1447 :: 		}
	GOTO        L_EventHandler342
L_EventHandler343:
;FirmV_0_7_0.c,1448 :: 		}
L_end_EventHandler:
	RETURN      0
; end of _EventHandler

_GetKeysState:

;FirmV_0_7_0.c,1458 :: 		char GetKeysState()
;FirmV_0_7_0.c,1460 :: 		unsigned res=0;
;FirmV_0_7_0.c,1464 :: 		char resch=0,fin;
	CLRF        GetKeysState_resch_L0+0 
;FirmV_0_7_0.c,1465 :: 		resch.b0=~KeyDown;
	BTFSC       PORTD+0, 5 
	GOTO        L__GetKeysState962
	BSF         GetKeysState_resch_L0+0, 0 
	GOTO        L__GetKeysState963
L__GetKeysState962:
	BCF         GetKeysState_resch_L0+0, 0 
L__GetKeysState963:
;FirmV_0_7_0.c,1466 :: 		resch.b1=~KeyMenu;
	BTFSC       PORTE+0, 0 
	GOTO        L__GetKeysState964
	BSF         GetKeysState_resch_L0+0, 1 
	GOTO        L__GetKeysState965
L__GetKeysState964:
	BCF         GetKeysState_resch_L0+0, 1 
L__GetKeysState965:
;FirmV_0_7_0.c,1467 :: 		resch.b2=~KeyUp;
	BTFSC       PORTD+0, 4 
	GOTO        L__GetKeysState966
	BSF         GetKeysState_resch_L0+0, 2 
	GOTO        L__GetKeysState967
L__GetKeysState966:
	BCF         GetKeysState_resch_L0+0, 2 
L__GetKeysState967:
;FirmV_0_7_0.c,1469 :: 		if((resch==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState353
;FirmV_0_7_0.c,1471 :: 		if(Pressed==0)
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState354
;FirmV_0_7_0.c,1472 :: 		{Repeat=0;RepeatCount=0;Pressed=0;fin=0;RepeatRate=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        GetKeysState_RepeatCount_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState354:
;FirmV_0_7_0.c,1473 :: 		if(Pressed==1)
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState355
;FirmV_0_7_0.c,1474 :: 		if(DebouncingDelay>=DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelay+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetKeysState356
;FirmV_0_7_0.c,1475 :: 		{Repeat=0;RepeatCount=0;Pressed=0;fin=0;RepeatRate=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        GetKeysState_RepeatCount_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState356:
L_GetKeysState355:
;FirmV_0_7_0.c,1476 :: 		}
L_GetKeysState353:
;FirmV_0_7_0.c,1487 :: 		if((Repeat==1)&&(KeyFlag>=RepeatSpeed))
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState359
	MOVF        GetKeysState_RepeatSpeed_L0+0, 0 
	SUBWF       _KeyFlag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetKeysState359
L__GetKeysState873:
;FirmV_0_7_0.c,1488 :: 		{RepeatRate=1;KeyFlag=0;if(RepeatCount<25)RepeatCount=RepeatCount+1;}
	MOVLW       1
	MOVWF       GetKeysState_RepeatRate_L0+0 
	CLRF        _KeyFlag+0 
	MOVLW       25
	SUBWF       GetKeysState_RepeatCount_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState360
	INCF        GetKeysState_RepeatCount_L0+0, 1 
L_GetKeysState360:
L_GetKeysState359:
;FirmV_0_7_0.c,1492 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0)&&(ms500==PressTime+KeyRepeatDelay))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState363
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState363
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState363
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
	GOTO        L__GetKeysState968
	MOVF        _ms500+2, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState968
	MOVF        _ms500+1, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState968
	MOVF        _ms500+0, 0 
	XORWF       R1, 0 
L__GetKeysState968:
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState363
L__GetKeysState872:
;FirmV_0_7_0.c,1493 :: 		{Repeat=1;KeyFlag=0;}
	MOVLW       1
	MOVWF       GetKeysState_Repeat_L0+0 
	CLRF        _KeyFlag+0 
L_GetKeysState363:
;FirmV_0_7_0.c,1495 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState366
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState366
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState366
L__GetKeysState871:
;FirmV_0_7_0.c,1496 :: 		fin=0;
	CLRF        GetKeysState_fin_L0+0 
L_GetKeysState366:
;FirmV_0_7_0.c,1498 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==1))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState369
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState369
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState369
L__GetKeysState870:
;FirmV_0_7_0.c,1499 :: 		{fin=resch*RepeatRate;RepeatRate=0;}
	MOVF        GetKeysState_resch_L0+0, 0 
	MULWF       GetKeysState_RepeatRate_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState369:
;FirmV_0_7_0.c,1502 :: 		if((resch!=0)&&(Pressed==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState372
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState372
L__GetKeysState869:
;FirmV_0_7_0.c,1503 :: 		{fin=resch; Pressed=1;PressTime=ms500;DebouncingDelay=0;}
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
L_GetKeysState372:
;FirmV_0_7_0.c,1507 :: 		if(fin != 0)
	MOVF        GetKeysState_fin_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState373
;FirmV_0_7_0.c,1508 :: 		BuzzFlag=1;
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_GetKeysState373:
;FirmV_0_7_0.c,1510 :: 		return fin;
	MOVF        GetKeysState_fin_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1511 :: 		}
L_end_GetKeysState:
	RETURN      0
; end of _GetKeysState

_GetExternalKeysState:

;FirmV_0_7_0.c,1521 :: 		char GetExternalKeysState()
;FirmV_0_7_0.c,1523 :: 		char out=0;
	CLRF        GetExternalKeysState_out_L0+0 
;FirmV_0_7_0.c,1524 :: 		if(KeyUp==0)
	BTFSC       PORTD+0, 4 
	GOTO        L_GetExternalKeysState374
;FirmV_0_7_0.c,1525 :: 		out.b0=1;
	BSF         GetExternalKeysState_out_L0+0, 0 
L_GetExternalKeysState374:
;FirmV_0_7_0.c,1526 :: 		if(KeyDown==0)
	BTFSC       PORTD+0, 5 
	GOTO        L_GetExternalKeysState375
;FirmV_0_7_0.c,1527 :: 		out.b1=1;
	BSF         GetExternalKeysState_out_L0+0, 1 
L_GetExternalKeysState375:
;FirmV_0_7_0.c,1528 :: 		return out;
	MOVF        GetExternalKeysState_out_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1529 :: 		}
L_end_GetExternalKeysState:
	RETURN      0
; end of _GetExternalKeysState

_GetLimitSwitchState:

;FirmV_0_7_0.c,1542 :: 		char GetLimitSwitchState()
;FirmV_0_7_0.c,1544 :: 		if((Limit1==0)||(Limit2==0))
	BTFSS       PORTD+0, 0 
	GOTO        L__GetLimitSwitchState874
	BTFSS       PORTD+0, 1 
	GOTO        L__GetLimitSwitchState874
	GOTO        L_GetLimitSwitchState378
L__GetLimitSwitchState874:
;FirmV_0_7_0.c,1545 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_GetLimitSwitchState
L_GetLimitSwitchState378:
;FirmV_0_7_0.c,1547 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1548 :: 		}
L_end_GetLimitSwitchState:
	RETURN      0
; end of _GetLimitSwitchState

_GetRemoteState:

;FirmV_0_7_0.c,1557 :: 		char GetRemoteState()
;FirmV_0_7_0.c,1559 :: 		char res=0;
	CLRF        GetRemoteState_res_L0+0 
;FirmV_0_7_0.c,1560 :: 		res.b0=RemoteAFlag.b0;
	BTFSC       _RemoteAFlag+0, 0 
	GOTO        L__GetRemoteState972
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState973
L__GetRemoteState972:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState973:
;FirmV_0_7_0.c,1561 :: 		res.b1=RemoteBFlag.b0;
	BTFSC       _RemoteBFlag+0, 0 
	GOTO        L__GetRemoteState974
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState975
L__GetRemoteState974:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState975:
;FirmV_0_7_0.c,1562 :: 		RemoteAFlag=0;
	CLRF        _RemoteAFlag+0 
;FirmV_0_7_0.c,1563 :: 		RemoteBFlag=0;
	CLRF        _RemoteBFlag+0 
;FirmV_0_7_0.c,1564 :: 		res.b0=res.b0;
;FirmV_0_7_0.c,1565 :: 		res.b1=res.b1;
;FirmV_0_7_0.c,1567 :: 		if(State<20)
	MOVLW       20
	SUBWF       _State+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetRemoteState380
;FirmV_0_7_0.c,1569 :: 		res.b0=res.b0|Events.Keys.b2;//up key
	BTFSC       GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState976
	BTFSC       _Events+0, 2 
	GOTO        L__GetRemoteState976
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState977
L__GetRemoteState976:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState977:
;FirmV_0_7_0.c,1570 :: 		res.b1=res.b1|Events.Keys.b0;//down key
	BTFSC       GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState978
	BTFSC       _Events+0, 0 
	GOTO        L__GetRemoteState978
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState979
L__GetRemoteState978:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState979:
;FirmV_0_7_0.c,1571 :: 		}
L_GetRemoteState380:
;FirmV_0_7_0.c,1573 :: 		return res;
	MOVF        GetRemoteState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1574 :: 		}
L_end_GetRemoteState:
	RETURN      0
; end of _GetRemoteState

_GetOverloadState:

;FirmV_0_7_0.c,1584 :: 		char GetOverloadState()
;FirmV_0_7_0.c,1586 :: 		char res=0;
	CLRF        GetOverloadState_res_L0+0 
;FirmV_0_7_0.c,1588 :: 		VCapM1=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _VCapM1+0 
	MOVF        R1, 0 
	MOVWF       _VCapM1+1 
;FirmV_0_7_0.c,1589 :: 		VCapM2=ADC_Read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _VCapM2+0 
	MOVF        R1, 0 
	MOVWF       _VCapM2+1 
;FirmV_0_7_0.c,1592 :: 		if(OverloadCheckFlag1==0)
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetOverloadState381
;FirmV_0_7_0.c,1593 :: 		OverloadCounter1=0;
	CLRF        _OverloadCounter1+0 
	CLRF        _OverloadCounter1+1 
L_GetOverloadState381:
;FirmV_0_7_0.c,1595 :: 		if(OverloadCheckFlag2==0)
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetOverloadState382
;FirmV_0_7_0.c,1596 :: 		OverloadCounter2=0;
	CLRF        _OverloadCounter2+0 
	CLRF        _OverloadCounter2+1 
L_GetOverloadState382:
;FirmV_0_7_0.c,1599 :: 		if(Motor1FullSpeed!=0)
	MOVF        _Motor1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState383
;FirmV_0_7_0.c,1603 :: 		if(VCapM1<OverloadTreshold1)
	MOVF        _OverloadTreshold1+1, 0 
	SUBWF       _VCapM1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState981
	MOVF        _OverloadTreshold1+0, 0 
	SUBWF       _VCapM1+0, 0 
L__GetOverloadState981:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState384
;FirmV_0_7_0.c,1605 :: 		if(OverloadCounter1<65530)
	MOVLW       255
	SUBWF       _OverloadCounter1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState982
	MOVLW       250
	SUBWF       _OverloadCounter1+0, 0 
L__GetOverloadState982:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState385
;FirmV_0_7_0.c,1606 :: 		OverloadCounter1=OverloadCounter1+1;
	INFSNZ      _OverloadCounter1+0, 1 
	INCF        _OverloadCounter1+1, 1 
L_GetOverloadState385:
;FirmV_0_7_0.c,1607 :: 		}
	GOTO        L_GetOverloadState386
L_GetOverloadState384:
;FirmV_0_7_0.c,1610 :: 		if(OverloadCounter1>0)
	MOVLW       0
	MOVWF       R0 
	MOVF        _OverloadCounter1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState983
	MOVF        _OverloadCounter1+0, 0 
	SUBLW       0
L__GetOverloadState983:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState387
;FirmV_0_7_0.c,1611 :: 		OverloadCounter1=OverloadCounter1-1;
	MOVLW       1
	SUBWF       _OverloadCounter1+0, 1 
	MOVLW       0
	SUBWFB      _OverloadCounter1+1, 1 
L_GetOverloadState387:
;FirmV_0_7_0.c,1612 :: 		}
L_GetOverloadState386:
;FirmV_0_7_0.c,1613 :: 		}
	GOTO        L_GetOverloadState388
L_GetOverloadState383:
;FirmV_0_7_0.c,1615 :: 		{OverloadCounter1=0;}
	CLRF        _OverloadCounter1+0 
	CLRF        _OverloadCounter1+1 
L_GetOverloadState388:
;FirmV_0_7_0.c,1617 :: 		if (OverloadCounter1>OverloadDuration1)
	MOVF        _OverloadCounter1+1, 0 
	SUBWF       _OverloadDuration1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState984
	MOVF        _OverloadCounter1+0, 0 
	SUBWF       _OverloadDuration1+0, 0 
L__GetOverloadState984:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState389
;FirmV_0_7_0.c,1618 :: 		res.b0=1;
	BSF         GetOverloadState_res_L0+0, 0 
L_GetOverloadState389:
;FirmV_0_7_0.c,1623 :: 		if(Motor2FullSpeed!=0)
	MOVF        _Motor2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState390
;FirmV_0_7_0.c,1625 :: 		if(VCapM2<OverloadTreshold2)
	MOVF        _OverloadTreshold2+1, 0 
	SUBWF       _VCapM2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState985
	MOVF        _OverloadTreshold2+0, 0 
	SUBWF       _VCapM2+0, 0 
L__GetOverloadState985:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState391
;FirmV_0_7_0.c,1627 :: 		if(OverloadCounter2<65530)
	MOVLW       255
	SUBWF       _OverloadCounter2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState986
	MOVLW       250
	SUBWF       _OverloadCounter2+0, 0 
L__GetOverloadState986:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState392
;FirmV_0_7_0.c,1628 :: 		OverloadCounter2=OverloadCounter2+1;
	INFSNZ      _OverloadCounter2+0, 1 
	INCF        _OverloadCounter2+1, 1 
L_GetOverloadState392:
;FirmV_0_7_0.c,1629 :: 		}
	GOTO        L_GetOverloadState393
L_GetOverloadState391:
;FirmV_0_7_0.c,1632 :: 		if(OverloadCounter2>0)
	MOVLW       0
	MOVWF       R0 
	MOVF        _OverloadCounter2+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState987
	MOVF        _OverloadCounter2+0, 0 
	SUBLW       0
L__GetOverloadState987:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState394
;FirmV_0_7_0.c,1633 :: 		OverloadCounter2=OverloadCounter2-1;
	MOVLW       1
	SUBWF       _OverloadCounter2+0, 1 
	MOVLW       0
	SUBWFB      _OverloadCounter2+1, 1 
L_GetOverloadState394:
;FirmV_0_7_0.c,1634 :: 		}
L_GetOverloadState393:
;FirmV_0_7_0.c,1635 :: 		}
	GOTO        L_GetOverloadState395
L_GetOverloadState390:
;FirmV_0_7_0.c,1637 :: 		{OverloadCounter2=0;}
	CLRF        _OverloadCounter2+0 
	CLRF        _OverloadCounter2+1 
L_GetOverloadState395:
;FirmV_0_7_0.c,1640 :: 		if (OverloadCounter2>OverloadDuration2)
	MOVF        _OverloadCounter2+1, 0 
	SUBWF       _OverloadDuration2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState988
	MOVF        _OverloadCounter2+0, 0 
	SUBWF       _OverloadDuration2+0, 0 
L__GetOverloadState988:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState396
;FirmV_0_7_0.c,1641 :: 		res.b1=1;
	BSF         GetOverloadState_res_L0+0, 1 
L_GetOverloadState396:
;FirmV_0_7_0.c,1643 :: 		return res;
	MOVF        GetOverloadState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1644 :: 		}
L_end_GetOverloadState:
	RETURN      0
; end of _GetOverloadState

_GetPhotocellState:

;FirmV_0_7_0.c,1657 :: 		char GetPhotocellState()
;FirmV_0_7_0.c,1659 :: 		if(Phcell2==0)
	BTFSC       PORTD+0, 2 
	GOTO        L_GetPhotocellState397
;FirmV_0_7_0.c,1660 :: 		{if(PhotocellCount<=20)PhotocellCount=PhotocellCount+1;}
	MOVF        _PhotocellCount+0, 0 
	SUBLW       20
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState398
	INCF        _PhotocellCount+0, 1 
L_GetPhotocellState398:
	GOTO        L_GetPhotocellState399
L_GetPhotocellState397:
;FirmV_0_7_0.c,1662 :: 		{PhotocellCount=0;}
	CLRF        _PhotocellCount+0 
L_GetPhotocellState399:
;FirmV_0_7_0.c,1663 :: 		if(PhotocellCount>=20)
	MOVLW       20
	SUBWF       _PhotocellCount+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState400
;FirmV_0_7_0.c,1664 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_GetPhotocellState
L_GetPhotocellState400:
;FirmV_0_7_0.c,1666 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1667 :: 		}
L_end_GetPhotocellState:
	RETURN      0
; end of _GetPhotocellState

_SetMotorSpeed:

;FirmV_0_7_0.c,1679 :: 		void SetMotorSpeed(char M1FullSpeed,char M2FullSpeed)
;FirmV_0_7_0.c,1681 :: 		if((M1FullSpeed==0)||(M2FullSpeed==0))
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed875
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed875
	GOTO        L_SetMotorSpeed404
L__SetMotorSpeed875:
;FirmV_0_7_0.c,1682 :: 		INT0E_bit=1;
	BSF         INT0E_bit+0, BitPos(INT0E_bit+0) 
	GOTO        L_SetMotorSpeed405
L_SetMotorSpeed404:
;FirmV_0_7_0.c,1684 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, BitPos(INT0E_bit+0) 
L_SetMotorSpeed405:
;FirmV_0_7_0.c,1686 :: 		Motor1FullSpeed=M1FullSpeed;
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	MOVWF       _Motor1FullSpeed+0 
;FirmV_0_7_0.c,1687 :: 		Motor2FullSpeed=M2FullSpeed;
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	MOVWF       _Motor2FullSpeed+0 
;FirmV_0_7_0.c,1688 :: 		}
L_end_SetMotorSpeed:
	RETURN      0
; end of _SetMotorSpeed

_OverloadInit:

;FirmV_0_7_0.c,1699 :: 		void OverloadInit(char ch)
;FirmV_0_7_0.c,1701 :: 		if(ch==1)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit406
;FirmV_0_7_0.c,1703 :: 		OverloadCounter1=0;
	CLRF        _OverloadCounter1+0 
	CLRF        _OverloadCounter1+1 
;FirmV_0_7_0.c,1704 :: 		Events.Overload.b0=0;
	BCF         _Events+5, 0 
;FirmV_0_7_0.c,1705 :: 		}
L_OverloadInit406:
;FirmV_0_7_0.c,1707 :: 		if(ch==2)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit407
;FirmV_0_7_0.c,1709 :: 		OverloadCounter2=0;
	CLRF        _OverloadCounter2+0 
	CLRF        _OverloadCounter2+1 
;FirmV_0_7_0.c,1710 :: 		Events.Overload.b1=0;
	BCF         _Events+5, 1 
;FirmV_0_7_0.c,1711 :: 		}
L_OverloadInit407:
;FirmV_0_7_0.c,1712 :: 		}
L_end_OverloadInit:
	RETURN      0
; end of _OverloadInit

_SaveConfigs:

;FirmV_0_7_0.c,1723 :: 		void SaveConfigs()
;FirmV_0_7_0.c,1726 :: 		EEPROM_Write(1,Door1OpenTime);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1727 :: 		EEPROM_Write(2,Door2OpenTime);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1728 :: 		EEPROM_Write(3,Door1CloseTime);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1729 :: 		EEPROM_Write(4,Door2CloseTime);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1730 :: 		EEPROM_Write(5,ActionTimeDiff);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1731 :: 		EEPROM_Write(6,OpenSoftStartTime);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1732 :: 		EEPROM_Write(7,OpenSoftStopTime);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1733 :: 		EEPROM_Write(8,CloseSoftStartTime);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1734 :: 		EEPROM_Write(9,CloseSoftStopTime);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1735 :: 		EEPROM_Write(10,Hi(AutoCloseTime));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1736 :: 		EEPROM_Write(11,Lo(AutoCloseTime));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1737 :: 		EEPROM_Write(12,OverloadSens1);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OverloadSens1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1738 :: 		EEPROM_Write(13,CloseAfterPass);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1739 :: 		EEPROM_Write(14,LockForce);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _LockForce+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1740 :: 		EEPROM_Write(15,OpenPhEnable);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenPhEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1741 :: 		EEPROM_Write(16,LimiterEnable);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _LimiterEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1742 :: 		EEPROM_Write(17,LockEnable);
	MOVLW       17
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _LockEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1743 :: 		EEPROM_Write(18,OverloadTime1);
	MOVLW       18
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OverloadTime1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1744 :: 		EEPROM_Write(19,OverloadSens2);
	MOVLW       19
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OverloadSens2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1745 :: 		EEPROM_Write(20,OverloadTime2);
	MOVLW       20
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OverloadTime2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1746 :: 		SetOverloadParams(OverloadSens1,OverloadTime1,OverloadSens2,OverloadTime2);
	MOVF        _OverloadSens1+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadTime1+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadSens2+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadTime2+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1748 :: 		}
L_end_SaveConfigs:
	RETURN      0
; end of _SaveConfigs

_LoadConfigs:

;FirmV_0_7_0.c,1761 :: 		void LoadConfigs()
;FirmV_0_7_0.c,1763 :: 		Door1OpenTime=EEPROM_Read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1764 :: 		Door2OpenTime=EEPROM_Read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1765 :: 		Door1CloseTime=EEPROM_Read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1766 :: 		Door2CloseTime=EEPROM_Read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1767 :: 		ActionTimeDiff=EEPROM_Read(5);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1768 :: 		OpenSoftStartTime=EEPROM_Read(6);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1769 :: 		OpenSoftStopTime=EEPROM_Read(7);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1770 :: 		CloseSoftStartTime=EEPROM_Read(8);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1771 :: 		CloseSoftStopTime=EEPROM_Read(9);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1772 :: 		AutoCloseTime=EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _AutoCloseTime+0 
	MOVLW       0
	MOVWF       _AutoCloseTime+1 
;FirmV_0_7_0.c,1773 :: 		AutoCloseTime=AutoCloseTime<<8;
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       _AutoCloseTime+1 
	CLRF        _AutoCloseTime+0 
;FirmV_0_7_0.c,1774 :: 		AutoCloseTime=AutocloseTime|EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	IORWF       _AutoCloseTime+0, 1 
	MOVLW       0
	IORWF       _AutoCloseTime+1, 1 
;FirmV_0_7_0.c,1775 :: 		OverloadSens1=EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadSens1+0 
;FirmV_0_7_0.c,1776 :: 		CloseAfterPass=EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseAfterPass+0 
;FirmV_0_7_0.c,1777 :: 		LockForce=EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockForce+0 
;FirmV_0_7_0.c,1778 :: 		OpenPhEnable=EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenPhEnable+0 
;FirmV_0_7_0.c,1779 :: 		LimiterEnable=EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LimiterEnable+0 
;FirmV_0_7_0.c,1780 :: 		LockEnable=EEPROM_Read(17);
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockEnable+0 
;FirmV_0_7_0.c,1781 :: 		OverloadTime1=EEPROM_Read(18);
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadTime1+0 
;FirmV_0_7_0.c,1782 :: 		OverloadSens2=EEPROM_Read(19);
	MOVLW       19
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadSens2+0 
;FirmV_0_7_0.c,1783 :: 		OverloadTime2=EEPROM_Read(20);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadTime2+0 
;FirmV_0_7_0.c,1784 :: 		SetOverloadParams(OverloadSens1,OverloadTime1,OverloadSens2,OverloadTime2);
	MOVF        _OverloadSens1+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadTime1+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadSens2+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        R0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1786 :: 		}
L_end_LoadConfigs:
	RETURN      0
; end of _LoadConfigs

_FactorySettings:

;FirmV_0_7_0.c,1799 :: 		void FactorySettings()
;FirmV_0_7_0.c,1801 :: 		Door1OpenTime=20;
	MOVLW       20
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1802 :: 		Door1CloseTime=20;
	MOVLW       20
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1803 :: 		Door2OpenTime=20;
	MOVLW       20
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1804 :: 		Door2CloseTime=20;
	MOVLW       20
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1805 :: 		OverloadSens1=7;
	MOVLW       7
	MOVWF       _OverloadSens1+0 
;FirmV_0_7_0.c,1806 :: 		OverloadTime1=2;
	MOVLW       2
	MOVWF       _OverloadTime1+0 
;FirmV_0_7_0.c,1807 :: 		OverloadSens2=7;
	MOVLW       7
	MOVWF       _OverloadSens2+0 
;FirmV_0_7_0.c,1808 :: 		OverloadTime2=2;
	MOVLW       2
	MOVWF       _OverloadTime2+0 
;FirmV_0_7_0.c,1809 :: 		SetOverloadParams(7,2,7,2);
	MOVLW       7
	MOVWF       FARG_SetOverloadParams+0 
	MOVLW       2
	MOVWF       FARG_SetOverloadParams+0 
	MOVLW       7
	MOVWF       FARG_SetOverloadParams+0 
	MOVLW       2
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1810 :: 		OpenSoftStopTime=10;
	MOVLW       10
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1811 :: 		OpenSoftStartTime=4;
	MOVLW       4
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1812 :: 		CloseSoftStopTime=10;
	MOVLW       10
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1813 :: 		CloseSoftStartTime=4;
	MOVLW       4
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1814 :: 		ActionTimeDiff=12;
	MOVLW       12
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1815 :: 		AutoCloseTime=0;
	CLRF        _AutoCloseTime+0 
	CLRF        _AutoCloseTime+1 
;FirmV_0_7_0.c,1816 :: 		LockForce=0;
	CLRF        _LockForce+0 
;FirmV_0_7_0.c,1817 :: 		OpenPhEnable=0;
	CLRF        _OpenPhEnable+0 
;FirmV_0_7_0.c,1818 :: 		LimiterEnable=0;
	CLRF        _LimiterEnable+0 
;FirmV_0_7_0.c,1819 :: 		CloseAfterPass=0;
	CLRF        _CloseAfterPass+0 
;FirmV_0_7_0.c,1820 :: 		LockEnable=1;
	MOVLW       1
	MOVWF       _LockEnable+0 
;FirmV_0_7_0.c,1822 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,1823 :: 		}
L_end_FactorySettings:
	RETURN      0
; end of _FactorySettings

_StartMotor:

;FirmV_0_7_0.c,1829 :: 		void StartMotor(char Mx,char Dir)
;FirmV_0_7_0.c,1831 :: 		if(Mx==1)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor408
;FirmV_0_7_0.c,1833 :: 		Motor1Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor996
	BCF         PORTC+0, 1 
	GOTO        L__StartMotor997
L__StartMotor996:
	BSF         PORTC+0, 1 
L__StartMotor997:
;FirmV_0_7_0.c,1834 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_StartMotor409:
	DECFSZ      R13, 1, 1
	BRA         L_StartMotor409
	DECFSZ      R12, 1, 1
	BRA         L_StartMotor409
	DECFSZ      R11, 1, 1
	BRA         L_StartMotor409
	NOP
	NOP
;FirmV_0_7_0.c,1835 :: 		Motor1Start=1;
	MOVLW       1
	MOVWF       _Motor1Start+0 
;FirmV_0_7_0.c,1836 :: 		Motor1=1;
	BSF         PORTB+0, 3 
;FirmV_0_7_0.c,1837 :: 		}
L_StartMotor408:
;FirmV_0_7_0.c,1839 :: 		if(Mx==2)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor410
;FirmV_0_7_0.c,1841 :: 		Motor2Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor998
	BCF         PORTC+0, 0 
	GOTO        L__StartMotor999
L__StartMotor998:
	BSF         PORTC+0, 0 
L__StartMotor999:
;FirmV_0_7_0.c,1842 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_StartMotor411:
	DECFSZ      R13, 1, 1
	BRA         L_StartMotor411
	DECFSZ      R12, 1, 1
	BRA         L_StartMotor411
	DECFSZ      R11, 1, 1
	BRA         L_StartMotor411
	NOP
	NOP
;FirmV_0_7_0.c,1843 :: 		Motor2Start=1;
	MOVLW       1
	MOVWF       _Motor2Start+0 
;FirmV_0_7_0.c,1844 :: 		Motor2=1;
	BSF         PORTB+0, 4 
;FirmV_0_7_0.c,1845 :: 		}
L_StartMotor410:
;FirmV_0_7_0.c,1846 :: 		}
L_end_StartMotor:
	RETURN      0
; end of _StartMotor

_StopMotor:

;FirmV_0_7_0.c,1849 :: 		void StopMotor(char Mx)
;FirmV_0_7_0.c,1851 :: 		if(Mx==1)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor412
;FirmV_0_7_0.c,1853 :: 		Motor1Start=0;
	CLRF        _Motor1Start+0 
;FirmV_0_7_0.c,1854 :: 		Motor1=0;
	BCF         PORTB+0, 3 
;FirmV_0_7_0.c,1855 :: 		}
L_StopMotor412:
;FirmV_0_7_0.c,1857 :: 		if(Mx==2)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor413
;FirmV_0_7_0.c,1859 :: 		Motor2Start=0;
	CLRF        _Motor2Start+0 
;FirmV_0_7_0.c,1860 :: 		Motor2=0;
	BCF         PORTB+0, 4 
;FirmV_0_7_0.c,1861 :: 		}
L_StopMotor413:
;FirmV_0_7_0.c,1862 :: 		}
L_end_StopMotor:
	RETURN      0
; end of _StopMotor

_CheckTask:

;FirmV_0_7_0.c,1874 :: 		char CheckTask(char TaskCode)
;FirmV_0_7_0.c,1876 :: 		if(Events.Task1==TaskCode)
	MOVF        _Events+1, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask414
;FirmV_0_7_0.c,1877 :: 		{Events.Task1=0; return 1;}
	CLRF        _Events+1 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckTask
L_CheckTask414:
;FirmV_0_7_0.c,1879 :: 		if(Events.Task2==TaskCode)
	MOVF        _Events+2, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask415
;FirmV_0_7_0.c,1880 :: 		{Events.Task2=0; return 1;}
	CLRF        _Events+2 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckTask
L_CheckTask415:
;FirmV_0_7_0.c,1882 :: 		if(Events.Task3==TaskCode)
	MOVF        _Events+3, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask416
;FirmV_0_7_0.c,1883 :: 		{Events.Task3=0; return 1;}
	CLRF        _Events+3 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckTask
L_CheckTask416:
;FirmV_0_7_0.c,1885 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1887 :: 		}
L_end_CheckTask:
	RETURN      0
; end of _CheckTask

_ReturnAutoclose:

;FirmV_0_7_0.c,1895 :: 		char ReturnAutoclose()
;FirmV_0_7_0.c,1899 :: 		for(i=0;i<20;i++)
	CLRF        ReturnAutoclose_i_L0+0 
L_ReturnAutoclose417:
	MOVLW       20
	SUBWF       ReturnAutoclose_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ReturnAutoclose418
;FirmV_0_7_0.c,1901 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode==9))
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
	GOTO        L_ReturnAutoclose422
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
	GOTO        L_ReturnAutoclose422
L__ReturnAutoclose876:
;FirmV_0_7_0.c,1902 :: 		{t=Tasks[i].Time;break;}
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
	GOTO        L_ReturnAutoclose418
L_ReturnAutoclose422:
;FirmV_0_7_0.c,1899 :: 		for(i=0;i<20;i++)
	INCF        ReturnAutoclose_i_L0+0, 1 
;FirmV_0_7_0.c,1903 :: 		}
	GOTO        L_ReturnAutoclose417
L_ReturnAutoclose418:
;FirmV_0_7_0.c,1905 :: 		if(i>=20) i=0;
	MOVLW       20
	SUBWF       ReturnAutoclose_i_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ReturnAutoclose423
	CLRF        ReturnAutoclose_i_L0+0 
	GOTO        L_ReturnAutoclose424
L_ReturnAutoclose423:
;FirmV_0_7_0.c,1906 :: 		else i=t-ms500;
	MOVF        _ms500+0, 0 
	SUBWF       ReturnAutoclose_t_L0+0, 0 
	MOVWF       ReturnAutoclose_i_L0+0 
L_ReturnAutoclose424:
;FirmV_0_7_0.c,1907 :: 		return i;
	MOVF        ReturnAutoclose_i_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1908 :: 		}
L_end_ReturnAutoclose:
	RETURN      0
; end of _ReturnAutoclose

_GetAutocloseTime:

;FirmV_0_7_0.c,1918 :: 		char GetAutocloseTime()
;FirmV_0_7_0.c,1922 :: 		for(i=0;i<20;i++)
	CLRF        GetAutocloseTime_i_L0+0 
L_GetAutocloseTime425:
	MOVLW       20
	SUBWF       GetAutocloseTime_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetAutocloseTime426
;FirmV_0_7_0.c,1924 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode==9))
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
	GOTO        L_GetAutocloseTime430
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
	GOTO        L_GetAutocloseTime430
L__GetAutocloseTime877:
;FirmV_0_7_0.c,1925 :: 		{t=Tasks[i].Time;Tasks[i].Expired=1;break;}
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
	GOTO        L_GetAutocloseTime426
L_GetAutocloseTime430:
;FirmV_0_7_0.c,1922 :: 		for(i=0;i<20;i++)
	INCF        GetAutocloseTime_i_L0+0, 1 
;FirmV_0_7_0.c,1926 :: 		}
	GOTO        L_GetAutocloseTime425
L_GetAutocloseTime426:
;FirmV_0_7_0.c,1927 :: 		i=t-ms500;
	MOVF        _ms500+0, 0 
	SUBWF       GetAutocloseTime_t_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       GetAutocloseTime_i_L0+0 
;FirmV_0_7_0.c,1928 :: 		if(i>=20) i=0;
	MOVLW       20
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetAutocloseTime431
	CLRF        GetAutocloseTime_i_L0+0 
L_GetAutocloseTime431:
;FirmV_0_7_0.c,1929 :: 		return i;
	MOVF        GetAutocloseTime_i_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1930 :: 		}
L_end_GetAutocloseTime:
	RETURN      0
; end of _GetAutocloseTime

_ClearTasks:

;FirmV_0_7_0.c,1947 :: 		void ClearTasks(char except)
;FirmV_0_7_0.c,1950 :: 		for(i=0;i<20;i++)
	CLRF        ClearTasks_i_L0+0 
L_ClearTasks432:
	MOVLW       20
	SUBWF       ClearTasks_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ClearTasks433
;FirmV_0_7_0.c,1951 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode!=except))
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
	GOTO        L_ClearTasks437
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
	GOTO        L_ClearTasks437
L__ClearTasks878:
;FirmV_0_7_0.c,1952 :: 		Tasks[i].Expired=1;
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
L_ClearTasks437:
;FirmV_0_7_0.c,1950 :: 		for(i=0;i<20;i++)
	INCF        ClearTasks_i_L0+0, 1 
;FirmV_0_7_0.c,1952 :: 		Tasks[i].Expired=1;
	GOTO        L_ClearTasks432
L_ClearTasks433:
;FirmV_0_7_0.c,1953 :: 		}
L_end_ClearTasks:
	RETURN      0
; end of _ClearTasks

_Menu0:

;FirmV_0_7_0.c,1968 :: 		void Menu0()
;FirmV_0_7_0.c,1970 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,1971 :: 		memcpy(LCDLine2,"                ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr69_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr69_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,1973 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0438
;FirmV_0_7_0.c,1974 :: 		{memcpy(LCDLine1,"00 Learning Mode",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,1975 :: 		if(LearningMode==0)memcpy(LCDLine2,"      Auto      ",16);
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0439
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
L_Menu0439:
;FirmV_0_7_0.c,1976 :: 		if(LearningMode==1)memcpy(LCDLine2,"     Manual     ",16);}
	MOVF        _LearningMode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0440
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
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
L_Menu0440:
L_Menu0438:
;FirmV_0_7_0.c,1978 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0441
;FirmV_0_7_0.c,1979 :: 		{memcpy(LCDLine1,"01 D1 Open Time ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1980 :: 		charValueToStr(Door1OpenTime,LCDLine2+6);}
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0441:
;FirmV_0_7_0.c,1982 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0442
;FirmV_0_7_0.c,1983 :: 		{memcpy(LCDLine1,"02 D2 Open Time ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1984 :: 		charValueToStr(Door2OpenTime,LCDLine2+6);}
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0442:
;FirmV_0_7_0.c,1986 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0443
;FirmV_0_7_0.c,1987 :: 		{memcpy(LCDLine1,"03 D1 Close Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1988 :: 		charValueToStr(Door1CloseTime,LCDLine2+6);}
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0443:
;FirmV_0_7_0.c,1990 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0444
;FirmV_0_7_0.c,1991 :: 		{memcpy(LCDLine1,"04 D2 Close Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1992 :: 		charValueToStr(Door2CloseTime,LCDLine2+6);}
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0444:
;FirmV_0_7_0.c,1994 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0445
;FirmV_0_7_0.c,1995 :: 		{memcpy(LCDLine1,"05 Op Soft Start",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1996 :: 		charValueToStr(OpenSoftStartTime,LCDLine2+6);}
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0445:
;FirmV_0_7_0.c,1998 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0446
;FirmV_0_7_0.c,1999 :: 		{memcpy(LCDLine1,"06 Op Soft Stop ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2000 :: 		charValueToStr(OpenSoftStopTime,LCDLine2+6);}
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0446:
;FirmV_0_7_0.c,2002 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0447
;FirmV_0_7_0.c,2003 :: 		{memcpy(LCDLine1,"07 Cl Soft Start",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2004 :: 		charValueToStr(CloseSoftStartTime,LCDLine2+6);}
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0447:
;FirmV_0_7_0.c,2006 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0448
;FirmV_0_7_0.c,2007 :: 		{memcpy(LCDLine1,"08 Cl Soft Stop ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2008 :: 		charValueToStr(CloseSoftStopTime,LCDLine2+6);}
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0448:
;FirmV_0_7_0.c,2010 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0449
;FirmV_0_7_0.c,2011 :: 		{memcpy(LCDLine1,"09 M1 Overl Sens",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2012 :: 		bytetostr(OverloadSens1,LCDLine2+3);if(OverloadSens1>7)memcpy(LCDLine2+7,"250Kg-",6);else memcpy(LCDLine2+7,"250Kg+",6);}
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
	GOTO        L_Menu0450
	MOVLW       _LCDLine2+7
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+7)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr82_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr82_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       6
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0451
L_Menu0450:
	MOVLW       _LCDLine2+7
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+7)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr83_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr83_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       6
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0451:
L_Menu0449:
;FirmV_0_7_0.c,2014 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0452
;FirmV_0_7_0.c,2015 :: 		{memcpy(LCDLine1,"10 M2 Overl Sens",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2016 :: 		bytetostr(OverloadSens2,LCDLine2+3);if(OverloadSens2>7)memcpy(LCDLine2+7,"250Kg-",6);else memcpy(LCDLine2+7,"250Kg+",6);}
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
	GOTO        L_Menu0453
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
	GOTO        L_Menu0454
L_Menu0453:
	MOVLW       _LCDLine2+7
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+7)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr86_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr86_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       6
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0454:
L_Menu0452:
;FirmV_0_7_0.c,2018 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0455
;FirmV_0_7_0.c,2019 :: 		{memcpy(LCDLine1,"11 M1 Overl Time",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2020 :: 		charValueToStr(OverloadTime1,LCDLine2+6);}
	MOVF        _OverloadTime1+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0455:
;FirmV_0_7_0.c,2022 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0456
;FirmV_0_7_0.c,2023 :: 		{memcpy(LCDLine1,"12 M2 Overl Time",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2024 :: 		charValueToStr(OverloadTime2,LCDLine2+6);}
	MOVF        _OverloadTime2+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0456:
;FirmV_0_7_0.c,2026 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0457
;FirmV_0_7_0.c,2027 :: 		{memcpy(LCDLine1,"13 Interval Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2028 :: 		charValueToStr(ActionTimeDiff,LCDLine2+6);}
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0457:
;FirmV_0_7_0.c,2030 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0458
;FirmV_0_7_0.c,2031 :: 		{memcpy(LCDLine1,"14 Auto-close T ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2032 :: 		intValueToStr(AutoCloseTime,LCDLine2+4);}
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_intValueToStr+0 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_intValueToStr+1 
	MOVLW       _LCDLine2+4
	MOVWF       FARG_intValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+4)
	MOVWF       FARG_intValueToStr+1 
	CALL        _intValueToStr+0, 0
L_Menu0458:
;FirmV_0_7_0.c,2034 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0459
;FirmV_0_7_0.c,2035 :: 		{memcpy(LCDLine1,"15 Factory Reset",16);LCDUpdateFlag=1;}
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
L_Menu0459:
;FirmV_0_7_0.c,2037 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0460
;FirmV_0_7_0.c,2038 :: 		{memcpy(LCDLine1,"16 Open Photo En",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2039 :: 		if(OpenPhEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _OpenPhEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0461
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr93_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr93_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0462
L_Menu0461:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr94_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr94_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0462:
L_Menu0460:
;FirmV_0_7_0.c,2041 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0463
;FirmV_0_7_0.c,2042 :: 		{memcpy(LCDLine1,"17 Limit Enable ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr95_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr95_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2043 :: 		if(LimiterEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LimiterEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0464
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr96_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr96_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0465
L_Menu0464:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr97_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr97_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0465:
L_Menu0463:
;FirmV_0_7_0.c,2045 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0466
;FirmV_0_7_0.c,2046 :: 		{memcpy(LCDLine1,"18 Lock Enable  ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr98_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr98_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2047 :: 		if(LockEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LockEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0467
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr99_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr99_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0468
L_Menu0467:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr100_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr100_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0468:
L_Menu0466:
;FirmV_0_7_0.c,2049 :: 		if(MenuPointer==19)
	MOVF        _MenuPointer+0, 0 
	XORLW       19
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0469
;FirmV_0_7_0.c,2050 :: 		{memcpy(LCDLine1,"19 Lock Force   ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
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
;FirmV_0_7_0.c,2051 :: 		if(LockForce==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0470
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr102_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr102_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0471
L_Menu0470:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr103_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr103_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0471:
L_Menu0469:
;FirmV_0_7_0.c,2053 :: 		if(MenuPointer==20)
	MOVF        _MenuPointer+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0472
;FirmV_0_7_0.c,2054 :: 		{memcpy(LCDLine1,"20 Au-Cl Pass   ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr104_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr104_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2055 :: 		charValueToStr(CloseAfterPass,LCDLine2+6);}
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0472:
;FirmV_0_7_0.c,2057 :: 		if(MenuPointer==21)
	MOVF        _MenuPointer+0, 0 
	XORLW       21
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0473
;FirmV_0_7_0.c,2058 :: 		{memcpy(LCDLine1,"21 Save Changes ",16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr105_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr105_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_Menu0473:
;FirmV_0_7_0.c,2060 :: 		if(MenuPointer==22)
	MOVF        _MenuPointer+0, 0 
	XORLW       22
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0474
;FirmV_0_7_0.c,2061 :: 		{memcpy(LCDLine1,"22 Discard Exit ",16);LCDUpdateFlag=1;}
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
L_Menu0474:
;FirmV_0_7_0.c,2064 :: 		State=101;
	MOVLW       101
	MOVWF       _State+0 
;FirmV_0_7_0.c,2065 :: 		}
L_end_Menu0:
	RETURN      0
; end of _Menu0

_About:

;FirmV_0_7_0.c,2073 :: 		void About()
;FirmV_0_7_0.c,2075 :: 		if((Events.Keys.b1==1))
	BTFSS       _Events+0, 1 
	GOTO        L_About475
;FirmV_0_7_0.c,2076 :: 		AboutCounter=AboutCounter+1;
	INCF        _AboutCounter+0, 1 
L_About475:
;FirmV_0_7_0.c,2078 :: 		if(AboutCounter==1)
	MOVF        _AboutCounter+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_About476
;FirmV_0_7_0.c,2079 :: 		{memcpy(LCDLine1,Crypto[2],16);
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
;FirmV_0_7_0.c,2080 :: 		memcpy(LCDLine2,Crypto[3],16);
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
;FirmV_0_7_0.c,2081 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2082 :: 		}
L_About476:
;FirmV_0_7_0.c,2084 :: 		if(AboutCounter==2)
	MOVF        _AboutCounter+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_About477
;FirmV_0_7_0.c,2085 :: 		{memcpy(LCDLine1,Crypto[4],16);
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
;FirmV_0_7_0.c,2086 :: 		memcpy(LCDLine2,Crypto[5],16);
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
;FirmV_0_7_0.c,2087 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2088 :: 		}
L_About477:
;FirmV_0_7_0.c,2090 :: 		if(AboutCounter==3)
	MOVF        _AboutCounter+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_About478
;FirmV_0_7_0.c,2091 :: 		{State=100;}
	MOVLW       100
	MOVWF       _State+0 
L_About478:
;FirmV_0_7_0.c,2092 :: 		}
L_end_About:
	RETURN      0
; end of _About

_Menu1:

;FirmV_0_7_0.c,2101 :: 		void Menu1()
;FirmV_0_7_0.c,2104 :: 		if((Events.Keys.b0==1))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu1479
;FirmV_0_7_0.c,2105 :: 		{if(MenuPointer==0){MenuPointer=22;}else{MenuPointer=MenuPointer-1;}State=100;}
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1480
	MOVLW       22
	MOVWF       _MenuPointer+0 
	GOTO        L_Menu1481
L_Menu1480:
	DECF        _MenuPointer+0, 1 
L_Menu1481:
	MOVLW       100
	MOVWF       _State+0 
L_Menu1479:
;FirmV_0_7_0.c,2107 :: 		if((Events.Keys.b2==1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu1482
;FirmV_0_7_0.c,2108 :: 		{if(MenuPointer==22){MenuPointer=0;}else{MenuPointer=MenuPointer+1;}State=100;}
	MOVF        _MenuPointer+0, 0 
	XORLW       22
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1483
	CLRF        _MenuPointer+0 
	GOTO        L_Menu1484
L_Menu1483:
	INCF        _MenuPointer+0, 1 
L_Menu1484:
	MOVLW       100
	MOVWF       _State+0 
L_Menu1482:
;FirmV_0_7_0.c,2110 :: 		if((Events.Keys.b1==1))
	BTFSS       _Events+0, 1 
	GOTO        L_Menu1485
;FirmV_0_7_0.c,2111 :: 		{State=102;}
	MOVLW       102
	MOVWF       _State+0 
L_Menu1485:
;FirmV_0_7_0.c,2113 :: 		if(Events.Keys==0b101)
	MOVF        _Events+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1486
;FirmV_0_7_0.c,2114 :: 		{memcpy(LCDLine1,Crypto[0],16);AboutCounter=0;memcpy(LCDLine2,Crypto[1],16);LCDLines=2;LCDUpdateFlag=1;State=250;}
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
L_Menu1486:
;FirmV_0_7_0.c,2117 :: 		}
L_end_Menu1:
	RETURN      0
; end of _Menu1

_Menu2:

;FirmV_0_7_0.c,2125 :: 		void Menu2()
;FirmV_0_7_0.c,2128 :: 		LCDFlash=1;
	MOVLW       1
	MOVWF       _LCDFlash+0 
;FirmV_0_7_0.c,2130 :: 		if(Events.Keys.b1==1)
	BTFSS       _Events+0, 1 
	GOTO        L_Menu2487
;FirmV_0_7_0.c,2132 :: 		LCDFlash=0;LCDFlashFlag=0;State=101;;Menu0();
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
	MOVLW       101
	MOVWF       _State+0 
	CALL        _Menu0+0, 0
;FirmV_0_7_0.c,2133 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2488
;FirmV_0_7_0.c,2135 :: 		LearnPhase=0;
	CLRF        _LearnPhase+0 
;FirmV_0_7_0.c,2136 :: 		if(LearningMode==0)
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2489
;FirmV_0_7_0.c,2137 :: 		{State=200;LongBuzzFlag=1;}
	MOVLW       200
	MOVWF       _State+0 
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
L_Menu2489:
;FirmV_0_7_0.c,2138 :: 		if(LearningMode==1)
	MOVF        _LearningMode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2490
;FirmV_0_7_0.c,2139 :: 		{State=201;LongBuzzFlag=1;}
	MOVLW       201
	MOVWF       _State+0 
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
L_Menu2490:
;FirmV_0_7_0.c,2140 :: 		}
L_Menu2488:
;FirmV_0_7_0.c,2141 :: 		}
L_Menu2487:
;FirmV_0_7_0.c,2144 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2491
;FirmV_0_7_0.c,2145 :: 		{ if((Events.Keys.b0==1)&&(LearningMode>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2494
	MOVF        _LearningMode+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2494
L__Menu2918:
;FirmV_0_7_0.c,2146 :: 		{LearningMode=LearningMode-1;Menu0();State=102;}
	DECF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2494:
;FirmV_0_7_0.c,2147 :: 		if((Events.Keys.b2==1)&&(LearningMode<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2497
	MOVLW       1
	SUBWF       _LearningMode+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2497
L__Menu2917:
;FirmV_0_7_0.c,2148 :: 		{LearningMode=LearningMode+1;Menu0();State=102;}
	INCF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2497:
;FirmV_0_7_0.c,2149 :: 		}
L_Menu2491:
;FirmV_0_7_0.c,2153 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2498
;FirmV_0_7_0.c,2154 :: 		{ if((Events.Keys.b0==1)&&(Door1OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2501
	MOVF        _Door1OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2501
L__Menu2916:
;FirmV_0_7_0.c,2155 :: 		{Door1OpenTime=Door1OpenTime-1;Menu0();State=102;}
	DECF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2501:
;FirmV_0_7_0.c,2156 :: 		if((Events.Keys.b2==1)&&(Door1OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2504
	MOVLW       255
	SUBWF       _Door1OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2504
L__Menu2915:
;FirmV_0_7_0.c,2157 :: 		{Door1OpenTime=Door1OpenTime+1;Menu0();State=102;}
	INCF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2504:
;FirmV_0_7_0.c,2158 :: 		}
L_Menu2498:
;FirmV_0_7_0.c,2162 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2505
;FirmV_0_7_0.c,2163 :: 		{ if((Events.Keys.b0==1)&&(Door2OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2508
	MOVF        _Door2OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2508
L__Menu2914:
;FirmV_0_7_0.c,2164 :: 		{Door2OpenTime=Door2OpenTime-1;Menu0();State=102;}
	DECF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2508:
;FirmV_0_7_0.c,2165 :: 		if((Events.Keys.b2==1)&&(Door2OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2511
	MOVLW       255
	SUBWF       _Door2OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2511
L__Menu2913:
;FirmV_0_7_0.c,2166 :: 		{Door2OpenTime=Door2OpenTime+1;Menu0();State=102;}
	INCF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2511:
;FirmV_0_7_0.c,2167 :: 		}
L_Menu2505:
;FirmV_0_7_0.c,2170 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2512
;FirmV_0_7_0.c,2171 :: 		{ if((Events.Keys.b0==1)&&(Door1CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2515
	MOVF        _Door1CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2515
L__Menu2912:
;FirmV_0_7_0.c,2172 :: 		{Door1CloseTime=Door1CloseTime-1;Menu0();State=102;}
	DECF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2515:
;FirmV_0_7_0.c,2173 :: 		if((Events.Keys.b2==1)&&(Door1CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2518
	MOVLW       255
	SUBWF       _Door1CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2518
L__Menu2911:
;FirmV_0_7_0.c,2174 :: 		{Door1CloseTime=Door1CloseTime+1;Menu0();State=102;}
	INCF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2518:
;FirmV_0_7_0.c,2175 :: 		}
L_Menu2512:
;FirmV_0_7_0.c,2178 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2519
;FirmV_0_7_0.c,2179 :: 		{ if((Events.Keys.b0==1)&&(Door2CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2522
	MOVF        _Door2CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2522
L__Menu2910:
;FirmV_0_7_0.c,2180 :: 		{Door2CloseTime=Door2CloseTime-1;Menu0();State=102;}
	DECF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2522:
;FirmV_0_7_0.c,2181 :: 		if((Events.Keys.b2==1)&&(Door2CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2525
	MOVLW       255
	SUBWF       _Door2CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2525
L__Menu2909:
;FirmV_0_7_0.c,2182 :: 		{Door2CloseTime=Door2CloseTime+1;Menu0();State=102;}
	INCF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2525:
;FirmV_0_7_0.c,2183 :: 		}
L_Menu2519:
;FirmV_0_7_0.c,2187 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2526
;FirmV_0_7_0.c,2188 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2529
	MOVF        _OpenSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2529
L__Menu2908:
;FirmV_0_7_0.c,2189 :: 		{OpenSoftStartTime=OpenSoftStartTime-1;Menu0();State=102;}
	DECF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2529:
;FirmV_0_7_0.c,2190 :: 		if((Events.Keys.b2==1)&&(OpenSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2532
	MOVLW       255
	SUBWF       _OpenSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2532
L__Menu2907:
;FirmV_0_7_0.c,2191 :: 		{OpenSoftStartTime=OpenSoftStartTime+1;Menu0();State=102;}
	INCF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2532:
;FirmV_0_7_0.c,2192 :: 		}
L_Menu2526:
;FirmV_0_7_0.c,2195 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2533
;FirmV_0_7_0.c,2196 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2536
	MOVF        _OpenSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2536
L__Menu2906:
;FirmV_0_7_0.c,2197 :: 		{OpenSoftStopTime=OpenSoftStopTime-1;Menu0();State=102;}
	DECF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2536:
;FirmV_0_7_0.c,2198 :: 		if((Events.Keys.b2==1)&&(OpenSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2539
	MOVLW       255
	SUBWF       _OpenSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2539
L__Menu2905:
;FirmV_0_7_0.c,2199 :: 		{OpenSoftStopTime=OpenSoftStopTime+1;Menu0();State=102;}
	INCF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2539:
;FirmV_0_7_0.c,2200 :: 		}
L_Menu2533:
;FirmV_0_7_0.c,2203 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2540
;FirmV_0_7_0.c,2204 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2543
	MOVF        _CloseSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2543
L__Menu2904:
;FirmV_0_7_0.c,2205 :: 		{CloseSoftStartTime=CloseSoftStartTime-1;Menu0();State=102;}
	DECF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2543:
;FirmV_0_7_0.c,2206 :: 		if((Events.Keys.b2==1)&&(CloseSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2546
	MOVLW       255
	SUBWF       _CloseSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2546
L__Menu2903:
;FirmV_0_7_0.c,2207 :: 		{CloseSoftStartTime=CloseSoftStartTime+1;Menu0();State=102;}
	INCF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2546:
;FirmV_0_7_0.c,2208 :: 		}
L_Menu2540:
;FirmV_0_7_0.c,2211 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2547
;FirmV_0_7_0.c,2212 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2550
	MOVF        _CloseSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2550
L__Menu2902:
;FirmV_0_7_0.c,2213 :: 		{CloseSoftStopTime=CloseSoftStopTime-1;Menu0();State=102;}
	DECF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2550:
;FirmV_0_7_0.c,2214 :: 		if((Events.Keys.b2==1)&&(CloseSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2553
	MOVLW       255
	SUBWF       _CloseSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2553
L__Menu2901:
;FirmV_0_7_0.c,2215 :: 		{CloseSoftStopTime=CloseSoftStopTime+1;Menu0();State=102;}
	INCF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2553:
;FirmV_0_7_0.c,2216 :: 		}
L_Menu2547:
;FirmV_0_7_0.c,2220 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2554
;FirmV_0_7_0.c,2221 :: 		{ if((Events.Keys.b0==1)&&(OverloadSens1>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2557
	MOVF        _OverloadSens1+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2557
L__Menu2900:
;FirmV_0_7_0.c,2222 :: 		{OverloadSens1=OverloadSens1-1;Menu0();State=102;}
	DECF        _OverloadSens1+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2557:
;FirmV_0_7_0.c,2223 :: 		if((Events.Keys.b2==1)&&(OverloadSens1<15))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2560
	MOVLW       15
	SUBWF       _OverloadSens1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2560
L__Menu2899:
;FirmV_0_7_0.c,2224 :: 		{OverloadSens1=OverloadSens1+1;Menu0();State=102;}
	INCF        _OverloadSens1+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2560:
;FirmV_0_7_0.c,2225 :: 		}
L_Menu2554:
;FirmV_0_7_0.c,2229 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2561
;FirmV_0_7_0.c,2230 :: 		{ if((Events.Keys.b0==1)&&(OverloadSens2>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2564
	MOVF        _OverloadSens2+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2564
L__Menu2898:
;FirmV_0_7_0.c,2231 :: 		{OverloadSens2=OverloadSens2-1;Menu0();State=102;}
	DECF        _OverloadSens2+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2564:
;FirmV_0_7_0.c,2232 :: 		if((Events.Keys.b2==1)&&(OverloadSens2<15))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2567
	MOVLW       15
	SUBWF       _OverloadSens2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2567
L__Menu2897:
;FirmV_0_7_0.c,2233 :: 		{OverloadSens2=OverloadSens2+1;Menu0();State=102;}
	INCF        _OverloadSens2+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2567:
;FirmV_0_7_0.c,2234 :: 		}
L_Menu2561:
;FirmV_0_7_0.c,2237 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2568
;FirmV_0_7_0.c,2238 :: 		{ if((Events.Keys.b0==1)&&(OverloadTime1>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2571
	MOVF        _OverloadTime1+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2571
L__Menu2896:
;FirmV_0_7_0.c,2239 :: 		{OverloadTime1=OverloadTime1-1;Menu0();State=102;}
	DECF        _OverloadTime1+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2571:
;FirmV_0_7_0.c,2240 :: 		if((Events.Keys.b2==1)&&(OverloadTime1<10))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2574
	MOVLW       10
	SUBWF       _OverloadTime1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2574
L__Menu2895:
;FirmV_0_7_0.c,2241 :: 		{OverloadTime1=OverloadTime1+1;Menu0();State=102;}
	INCF        _OverloadTime1+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2574:
;FirmV_0_7_0.c,2242 :: 		}
L_Menu2568:
;FirmV_0_7_0.c,2246 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2575
;FirmV_0_7_0.c,2247 :: 		{ if((Events.Keys.b0==1)&&(OverloadTime2>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2578
	MOVF        _OverloadTime2+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2578
L__Menu2894:
;FirmV_0_7_0.c,2248 :: 		{OverloadTime2=OverloadTime2-1;Menu0();State=102;}
	DECF        _OverloadTime2+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2578:
;FirmV_0_7_0.c,2249 :: 		if((Events.Keys.b2==1)&&(OverloadTime2<10))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2581
	MOVLW       10
	SUBWF       _OverloadTime2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2581
L__Menu2893:
;FirmV_0_7_0.c,2250 :: 		{OverloadTime2=OverloadTime2+1;Menu0();State=102;}
	INCF        _OverloadTime2+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2581:
;FirmV_0_7_0.c,2251 :: 		}
L_Menu2575:
;FirmV_0_7_0.c,2254 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2582
;FirmV_0_7_0.c,2255 :: 		{ if((Events.Keys.b0==1)&&(ActionTimeDiff>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2585
	MOVF        _ActionTimeDiff+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2585
L__Menu2892:
;FirmV_0_7_0.c,2256 :: 		{ActionTimeDiff=ActionTimeDiff-1;Menu0();State=102;}
	DECF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2585:
;FirmV_0_7_0.c,2257 :: 		if((Events.Keys.b2==1)&&(ActionTimeDiff<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2588
	MOVLW       255
	SUBWF       _ActionTimeDiff+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2588
L__Menu2891:
;FirmV_0_7_0.c,2258 :: 		{ActionTimeDiff=ActionTimeDiff+1;Menu0();State=102;}
	INCF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2588:
;FirmV_0_7_0.c,2259 :: 		}
L_Menu2582:
;FirmV_0_7_0.c,2262 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2589
;FirmV_0_7_0.c,2263 :: 		{ if((Events.Keys.b0==1)&&(AutoCloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2592
	MOVLW       0
	MOVWF       R0 
	MOVF        _AutoCloseTime+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu21009
	MOVF        _AutoCloseTime+0, 0 
	SUBLW       0
L__Menu21009:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2592
L__Menu2890:
;FirmV_0_7_0.c,2264 :: 		{AutoCloseTime=AutoCloseTime-1;Menu0();State=102;}
	MOVLW       1
	SUBWF       _AutoCloseTime+0, 1 
	MOVLW       0
	SUBWFB      _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2592:
;FirmV_0_7_0.c,2265 :: 		if((Events.Keys.b2==1)&&(AutoCloseTime<65000))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2595
	MOVLW       253
	SUBWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu21010
	MOVLW       232
	SUBWF       _AutoCloseTime+0, 0 
L__Menu21010:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2595
L__Menu2889:
;FirmV_0_7_0.c,2266 :: 		{AutoCloseTime=AutoCloseTime+1;Menu0();State=102;}
	INFSNZ      _AutoCloseTime+0, 1 
	INCF        _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2595:
;FirmV_0_7_0.c,2267 :: 		}
L_Menu2589:
;FirmV_0_7_0.c,2270 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2596
;FirmV_0_7_0.c,2272 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2273 :: 		memcpy(LCDLine1,Sipher,16);
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
;FirmV_0_7_0.c,2274 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2275 :: 		LCDFlash=0; LCDFlashFlag=0;
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,2276 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2277 :: 		LongBuzzFlag=1;
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
;FirmV_0_7_0.c,2278 :: 		FactorySettings();
	CALL        _FactorySettings+0, 0
;FirmV_0_7_0.c,2279 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2280 :: 		}
L_Menu2596:
;FirmV_0_7_0.c,2283 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2597
;FirmV_0_7_0.c,2284 :: 		{ if((Events.Keys.b0==1)&&(OpenPhEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2600
	MOVF        _OpenPhEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2600
L__Menu2888:
;FirmV_0_7_0.c,2285 :: 		{OpenPhEnable=OpenPhEnable-1;Menu0();State=102;}
	DECF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2600:
;FirmV_0_7_0.c,2286 :: 		if((Events.Keys.b2==1)&&(OpenPhEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2603
	MOVLW       1
	SUBWF       _OpenPhEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2603
L__Menu2887:
;FirmV_0_7_0.c,2287 :: 		{OpenPhEnable=OpenPhEnable+1;Menu0();State=102;}
	INCF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2603:
;FirmV_0_7_0.c,2288 :: 		}
L_Menu2597:
;FirmV_0_7_0.c,2292 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2604
;FirmV_0_7_0.c,2293 :: 		{ if((Events.Keys.b0==1)&&(LimiterEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2607
	MOVF        _LimiterEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2607
L__Menu2886:
;FirmV_0_7_0.c,2294 :: 		{LimiterEnable=LimiterEnable-1;Menu0();State=102;}
	DECF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2607:
;FirmV_0_7_0.c,2295 :: 		if((Events.Keys.b2==1)&&(LimiterEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2610
	MOVLW       1
	SUBWF       _LimiterEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2610
L__Menu2885:
;FirmV_0_7_0.c,2296 :: 		{LimiterEnable=LimiterEnable+1;Menu0();State=102;}
	INCF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2610:
;FirmV_0_7_0.c,2297 :: 		}
L_Menu2604:
;FirmV_0_7_0.c,2300 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2611
;FirmV_0_7_0.c,2301 :: 		{ if((Events.Keys.b0==1)&&(LockEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2614
	MOVF        _LockEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2614
L__Menu2884:
;FirmV_0_7_0.c,2302 :: 		{LockEnable=LockEnable-1;Menu0();State=102;}
	DECF        _LockEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2614:
;FirmV_0_7_0.c,2303 :: 		if((Events.Keys.b2==1)&&(LockEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2617
	MOVLW       1
	SUBWF       _LockEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2617
L__Menu2883:
;FirmV_0_7_0.c,2304 :: 		{LockEnable=LockEnable+1;Menu0();State=102;}
	INCF        _LockEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2617:
;FirmV_0_7_0.c,2305 :: 		}
L_Menu2611:
;FirmV_0_7_0.c,2308 :: 		if(MenuPointer==19)
	MOVF        _MenuPointer+0, 0 
	XORLW       19
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2618
;FirmV_0_7_0.c,2309 :: 		{ if((Events.Keys.b0==1)&&(LockForce>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2621
	MOVF        _LockForce+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2621
L__Menu2882:
;FirmV_0_7_0.c,2310 :: 		{LockForce=LockForce-1;Menu0();State=102;}
	DECF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2621:
;FirmV_0_7_0.c,2311 :: 		if((Events.Keys.b2==1)&&(LockForce<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2624
	MOVLW       1
	SUBWF       _LockForce+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2624
L__Menu2881:
;FirmV_0_7_0.c,2312 :: 		{LockForce=LockForce+1;Menu0();State=102;}
	INCF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2624:
;FirmV_0_7_0.c,2313 :: 		}
L_Menu2618:
;FirmV_0_7_0.c,2316 :: 		if(MenuPointer==20)
	MOVF        _MenuPointer+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2625
;FirmV_0_7_0.c,2317 :: 		{ if((Events.Keys.b0==1)&&(CloseAfterPass>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2628
	MOVF        _CloseAfterPass+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2628
L__Menu2880:
;FirmV_0_7_0.c,2318 :: 		{CloseAfterPass=CloseAfterPass-1;if(CloseAfterPass==9) CloseAfterPass=0;Menu0();State=102;}
	DECF        _CloseAfterPass+0, 1 
	MOVF        _CloseAfterPass+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2629
	CLRF        _CloseAfterPass+0 
L_Menu2629:
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2628:
;FirmV_0_7_0.c,2319 :: 		if((Events.Keys.b2==1)&&(CloseAfterPass<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2632
	MOVLW       255
	SUBWF       _CloseAfterPass+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2632
L__Menu2879:
;FirmV_0_7_0.c,2320 :: 		{CloseAfterPass=CloseAfterPass+1;if(CloseAfterPass==1) CloseAfterPass=10;Menu0();State=102;}
	INCF        _CloseAfterPass+0, 1 
	MOVF        _CloseAfterPass+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2633
	MOVLW       10
	MOVWF       _CloseAfterPass+0 
L_Menu2633:
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2632:
;FirmV_0_7_0.c,2321 :: 		}
L_Menu2625:
;FirmV_0_7_0.c,2324 :: 		if(MenuPointer==21)
	MOVF        _MenuPointer+0, 0 
	XORLW       21
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2634
;FirmV_0_7_0.c,2326 :: 		State=103;
	MOVLW       103
	MOVWF       _State+0 
;FirmV_0_7_0.c,2327 :: 		memcpy(LCDLine1,Sipher,16);
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
;FirmV_0_7_0.c,2328 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2329 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2330 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2331 :: 		LongBuzzFlag=1;
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
;FirmV_0_7_0.c,2332 :: 		}
L_Menu2634:
;FirmV_0_7_0.c,2335 :: 		if(MenuPointer==22)
	MOVF        _MenuPointer+0, 0 
	XORLW       22
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2635
;FirmV_0_7_0.c,2337 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2338 :: 		memcpy(LCDLine1,Sipher,16);
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
;FirmV_0_7_0.c,2339 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2340 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2341 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2342 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,2343 :: 		LongBuzzFlag=1;
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
;FirmV_0_7_0.c,2344 :: 		}
L_Menu2635:
;FirmV_0_7_0.c,2345 :: 		}
L_end_Menu2:
	RETURN      0
; end of _Menu2

_Menu3:

;FirmV_0_7_0.c,2357 :: 		void Menu3()
;FirmV_0_7_0.c,2359 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2360 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2361 :: 		}
L_end_Menu3:
	RETURN      0
; end of _Menu3

_LearnAuto:

;FirmV_0_7_0.c,2375 :: 		void LearnAuto()
;FirmV_0_7_0.c,2381 :: 		switch(LearnPhase)
	GOTO        L_LearnAuto636
;FirmV_0_7_0.c,2383 :: 		case 0:
L_LearnAuto638:
;FirmV_0_7_0.c,2384 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,2386 :: 		if(Events.Remote.b0==1) {DoorNo=2; LearnPhase=LearnPhase+1;BuzzFlag=1;} if(Events.Remote.b1==1) {DoorNo=1;LearnPhase=3;BuzzFlag=1;}
	BTFSS       _Events+4, 0 
	GOTO        L_LearnAuto639
	MOVLW       2
	MOVWF       LearnAuto_DoorNo_L0+0 
	INCF        _LearnPhase+0, 1 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnAuto639:
	BTFSS       _Events+4, 1 
	GOTO        L_LearnAuto640
	MOVLW       1
	MOVWF       LearnAuto_DoorNo_L0+0 
	MOVLW       3
	MOVWF       _LearnPhase+0 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnAuto640:
;FirmV_0_7_0.c,2387 :: 		OverloadCheckFlag1=0;OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,2388 :: 		break;
	GOTO        L_LearnAuto637
;FirmV_0_7_0.c,2390 :: 		case 1: //Start D2 and enable overload sensing after 3s
L_LearnAuto641:
;FirmV_0_7_0.c,2391 :: 		StartMotor(2,_Close);AddTask(ms500+6,21);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2392 :: 		break;
	GOTO        L_LearnAuto637
;FirmV_0_7_0.c,2394 :: 		case 2: //Check if D2 reaches end of its course
L_LearnAuto642:
;FirmV_0_7_0.c,2395 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto645
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto645
L__LearnAuto924:
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnAuto645:
;FirmV_0_7_0.c,2396 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto646
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnAuto646:
;FirmV_0_7_0.c,2397 :: 		break;
	GOTO        L_LearnAuto637
;FirmV_0_7_0.c,2399 :: 		case 3: //Start D1 and enable overload sensin after 3 s
L_LearnAuto647:
;FirmV_0_7_0.c,2400 :: 		StartMotor(1,_Close);AddTask(ms500+6,20);LearnPhase=LearnPhase+1;;
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
;FirmV_0_7_0.c,2402 :: 		case 4: //Check if D1 reaches end of its course
L_LearnAuto648:
;FirmV_0_7_0.c,2403 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto651
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto651
L__LearnAuto923:
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnAuto651:
;FirmV_0_7_0.c,2404 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto652
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto652:
;FirmV_0_7_0.c,2405 :: 		break;
	GOTO        L_LearnAuto637
;FirmV_0_7_0.c,2407 :: 		case 5: //Start D1 for opening and save start time and enable overload sensing after 3s
L_LearnAuto653:
;FirmV_0_7_0.c,2408 :: 		startT=ms500;StartMotor(1,_Open);AddTask(ms500+6,20);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2409 :: 		break;
	GOTO        L_LearnAuto637
;FirmV_0_7_0.c,2411 :: 		case 6: //Check if D1 reaches end of its course and save the stop time
L_LearnAuto654:
;FirmV_0_7_0.c,2412 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);if(DoorNo==1)LearnPhase=11;else LearnPhase=LearnPhase+1;stopT=ms500;RawData.D1OpenTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto657
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto657
L__LearnAuto922:
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	MOVF        LearnAuto_DoorNo_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto658
	MOVLW       11
	MOVWF       _LearnPhase+0 
	GOTO        L_LearnAuto659
L_LearnAuto658:
	INCF        _LearnPhase+0, 1 
L_LearnAuto659:
	MOVF        LearnAuto_startT_L0+0, 0 
	SUBWF       _ms500+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnAuto_RawData_L0+1 
L_LearnAuto657:
;FirmV_0_7_0.c,2413 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto660
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto660:
;FirmV_0_7_0.c,2414 :: 		break;
	GOTO        L_LearnAuto637
;FirmV_0_7_0.c,2416 :: 		case 7: //Start D2 for opening and save start time and enable overload sensing after 3s
L_LearnAuto661:
;FirmV_0_7_0.c,2417 :: 		startT=ms500;StartMotor(2,_Open);AddTask(ms500+6,21);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2418 :: 		break;
	GOTO        L_LearnAuto637
;FirmV_0_7_0.c,2420 :: 		case 8: //Check if D2 reaches end of its course and save the stop time
L_LearnAuto662:
;FirmV_0_7_0.c,2421 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D2OpenTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto665
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto665
L__LearnAuto921:
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
L_LearnAuto665:
;FirmV_0_7_0.c,2422 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto666
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnAuto666:
;FirmV_0_7_0.c,2423 :: 		break;
	GOTO        L_LearnAuto637
;FirmV_0_7_0.c,2425 :: 		case 9: //Start D2 for closing and save start time and enable overload sensing after 6s
L_LearnAuto667:
;FirmV_0_7_0.c,2426 :: 		startT=ms500;StartMotor(2,_Close);AddTask(ms500+6,21);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2427 :: 		break;
	GOTO        L_LearnAuto637
;FirmV_0_7_0.c,2429 :: 		case 10: //Check if D2 reaches end of its course and save the stop time
L_LearnAuto668:
;FirmV_0_7_0.c,2430 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D2CloseTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto671
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto671
L__LearnAuto920:
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
L_LearnAuto671:
;FirmV_0_7_0.c,2431 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto672
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnAuto672:
;FirmV_0_7_0.c,2432 :: 		break;
	GOTO        L_LearnAuto637
;FirmV_0_7_0.c,2434 :: 		case 11: //Start D1 for closing and save start time and enable overload sensing after 3s
L_LearnAuto673:
;FirmV_0_7_0.c,2435 :: 		startT=ms500;StartMotor(1,_Close);AddTask(ms500+6,20);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2436 :: 		break;
	GOTO        L_LearnAuto637
;FirmV_0_7_0.c,2438 :: 		case 12: //Check if D1 reaches end of its course and save the stop time
L_LearnAuto674:
;FirmV_0_7_0.c,2439 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D1CloseTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto677
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto677
L__LearnAuto919:
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
L_LearnAuto677:
;FirmV_0_7_0.c,2440 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto678
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto678:
;FirmV_0_7_0.c,2441 :: 		break;
	GOTO        L_LearnAuto637
;FirmV_0_7_0.c,2443 :: 		case 13:
L_LearnAuto679:
;FirmV_0_7_0.c,2444 :: 		AutoLearnCalculator(&RawData);
	MOVLW       LearnAuto_RawData_L0+0
	MOVWF       FARG_AutoLearnCalculator+0 
	MOVLW       hi_addr(LearnAuto_RawData_L0+0)
	MOVWF       FARG_AutoLearnCalculator+1 
	CALL        _AutoLearnCalculator+0, 0
;FirmV_0_7_0.c,2445 :: 		SaveLearnData(&RawData,DoorNo);
	MOVLW       LearnAuto_RawData_L0+0
	MOVWF       FARG_SaveLearnData+0 
	MOVLW       hi_addr(LearnAuto_RawData_L0+0)
	MOVWF       FARG_SaveLearnData+1 
	MOVF        LearnAuto_DoorNo_L0+0, 0 
	MOVWF       FARG_SaveLearnData+0 
	CALL        _SaveLearnData+0, 0
;FirmV_0_7_0.c,2446 :: 		memcpy(LCDLine1," Learn Complete ",16);
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
;FirmV_0_7_0.c,2447 :: 		memcpy(LCDLine2,"     Ready      ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
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
;FirmV_0_7_0.c,2448 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2449 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2450 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,2452 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2453 :: 		break;
	GOTO        L_LearnAuto637
;FirmV_0_7_0.c,2456 :: 		}
L_LearnAuto636:
	MOVF        _LearnPhase+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto638
	MOVF        _LearnPhase+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto641
	MOVF        _LearnPhase+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto642
	MOVF        _LearnPhase+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto647
	MOVF        _LearnPhase+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto648
	MOVF        _LearnPhase+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto653
	MOVF        _LearnPhase+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto654
	MOVF        _LearnPhase+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto661
	MOVF        _LearnPhase+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto662
	MOVF        _LearnPhase+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto667
	MOVF        _LearnPhase+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto668
	MOVF        _LearnPhase+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto673
	MOVF        _LearnPhase+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto674
	MOVF        _LearnPhase+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto679
L_LearnAuto637:
;FirmV_0_7_0.c,2460 :: 		}
L_end_LearnAuto:
	RETURN      0
; end of _LearnAuto

_AutoLearnCalculator:

;FirmV_0_7_0.c,2480 :: 		void AutoLearnCalculator(Learn *raw)
;FirmV_0_7_0.c,2483 :: 		(*raw).D1OpenTime=(*raw).D1OpenTime+10;
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
;FirmV_0_7_0.c,2484 :: 		(*raw).D2OpenTime=(*raw).D2OpenTime+10;
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
;FirmV_0_7_0.c,2485 :: 		(*raw).D1CloseTime=(*raw).D1CloseTime+10;
	MOVFF       FARG_AutoLearnCalculator_raw+0, FSR0
	MOVFF       FARG_AutoLearnCalculator_raw+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       FARG_AutoLearnCalculator_raw+0, FSR1
	MOVFF       FARG_AutoLearnCalculator_raw+1, FSR1H
	MOVLW       10
	ADDWF       R0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2486 :: 		(*raw).D2CloseTime=(*raw).D2CloseTime+10;
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
;FirmV_0_7_0.c,2488 :: 		(*raw).D1OpenSoftStart=4;
	MOVLW       4
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2489 :: 		(*raw).D1CloseSoftStart=4;
	MOVLW       6
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2490 :: 		(*raw).D2OpenSoftStart=4;
	MOVLW       8
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2491 :: 		(*raw).D2CloseSoftStart=4;
	MOVLW       10
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2493 :: 		(*raw).D1OpenSoftStop=10;
	MOVLW       5
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2494 :: 		(*raw).D2OpenSoftStop=10;
	MOVLW       9
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2495 :: 		(*raw).D1CloseSoftStop=10;
	MOVLW       7
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2496 :: 		(*raw).D2CloseSoftStop=10;
	MOVLW       11
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2498 :: 		}
L_end_AutoLearnCalculator:
	RETURN      0
; end of _AutoLearnCalculator

_SaveLearnData:

;FirmV_0_7_0.c,2510 :: 		void SaveLearnData(Learn *d,char DCount)
;FirmV_0_7_0.c,2512 :: 		Door1OpenTime=(*d).D1OpenTime;
	MOVLW       1
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,2513 :: 		Door1CloseTime=(*d).D1CloseTime;
	MOVFF       FARG_SaveLearnData_d+0, FSR0
	MOVFF       FARG_SaveLearnData_d+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,2514 :: 		if(DCount==2)
	MOVF        FARG_SaveLearnData_DCount+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SaveLearnData680
;FirmV_0_7_0.c,2516 :: 		Door2OpenTime=(*d).D2OpenTime;
	MOVLW       3
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,2517 :: 		Door2CloseTime=(*d).D2CloseTime;
	MOVLW       2
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,2518 :: 		OpenSoftStartTime=((*d).D1OpenSoftStart+(*d).D2OpenSoftStart)/2;
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
;FirmV_0_7_0.c,2519 :: 		OpenSoftStopTime=((*d).D1OpenSoftStop+(*d).D2OpenSoftStop)/2;
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
;FirmV_0_7_0.c,2520 :: 		CloseSoftStartTime=((*d).D1CloseSoftStart+(*d).D2CloseSoftStart)/2;
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
;FirmV_0_7_0.c,2521 :: 		CloseSoftStopTime=((*d).D1CloseSoftStop+(*d).D2CloseSoftStop)/2;
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
;FirmV_0_7_0.c,2522 :: 		}
	GOTO        L_SaveLearnData681
L_SaveLearnData680:
;FirmV_0_7_0.c,2525 :: 		Door2OpenTime=0;
	CLRF        _Door2OpenTime+0 
;FirmV_0_7_0.c,2526 :: 		Door2CloseTime=0;
	CLRF        _Door2CloseTime+0 
;FirmV_0_7_0.c,2527 :: 		OpenSoftStartTime=(*d).D1OpenSoftStart;
	MOVLW       4
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,2528 :: 		OpenSoftStopTime=(*d).D1OpenSoftStop;
	MOVLW       5
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,2529 :: 		CloseSoftStartTime=(*d).D1CloseSoftStart;
	MOVLW       6
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,2530 :: 		CloseSoftStopTime=(*d).D1CloseSoftStop;
	MOVLW       7
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,2531 :: 		}
L_SaveLearnData681:
;FirmV_0_7_0.c,2533 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2534 :: 		}
L_end_SaveLearnData:
	RETURN      0
; end of _SaveLearnData

_LearnManual:

;FirmV_0_7_0.c,2549 :: 		void LearnManual()
;FirmV_0_7_0.c,2557 :: 		switch(LearnPhase)
	GOTO        L_LearnManual682
;FirmV_0_7_0.c,2559 :: 		case 0:
L_LearnManual684:
;FirmV_0_7_0.c,2560 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,2562 :: 		if(Events.Remote.b0==1){LearnPhase=LearnPhase+1; DoorNo=2;BuzzFlag=1;}if(Events.Remote.b1==1){LearnPhase=3; DoorNo=1;BuzzFlag=1;}
	BTFSS       _Events+4, 0 
	GOTO        L_LearnManual685
	INCF        _LearnPhase+0, 1 
	MOVLW       2
	MOVWF       LearnManual_DoorNo_L0+0 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnManual685:
	BTFSS       _Events+4, 1 
	GOTO        L_LearnManual686
	MOVLW       3
	MOVWF       _LearnPhase+0 
	MOVLW       1
	MOVWF       LearnManual_DoorNo_L0+0 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnManual686:
;FirmV_0_7_0.c,2563 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2565 :: 		case 1: //Start D2 and enable overload sensing after 1s
L_LearnManual687:
;FirmV_0_7_0.c,2566 :: 		StartMotor(2,_Close);AddTask(ms500+4,21);LearnPhase=LearnPhase+1;OverloadCheckFlag2=0;
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
;FirmV_0_7_0.c,2567 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2569 :: 		case 2: //Check if D2 reaches end of its course
L_LearnManual688:
;FirmV_0_7_0.c,2570 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnManual691
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnManual691
L__LearnManual926:
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnManual691:
;FirmV_0_7_0.c,2571 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual692
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnManual692:
;FirmV_0_7_0.c,2572 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2574 :: 		case 3: //Start D1 and enable overload sensin after 1 s
L_LearnManual693:
;FirmV_0_7_0.c,2575 :: 		StartMotor(1,_Close);AddTask(ms500+4,20);LearnPhase=LearnPhase+1;;OverloadCheckFlag1=0;
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
;FirmV_0_7_0.c,2577 :: 		case 4: //Check if D1 reaches end of its course
L_LearnManual694:
;FirmV_0_7_0.c,2578 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnManual697
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnManual697
L__LearnManual925:
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnManual697:
;FirmV_0_7_0.c,2579 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual698
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnManual698:
;FirmV_0_7_0.c,2580 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2582 :: 		case 5: //Wait for remote to start D1 and slow down
L_LearnManual699:
;FirmV_0_7_0.c,2583 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(1,_Open);SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual700
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
L_LearnManual700:
;FirmV_0_7_0.c,2584 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2586 :: 		case 6: //check for Remote press and fast up
L_LearnManual701:
;FirmV_0_7_0.c,2587 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(1,Motor2FullSpeed);M1isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual702
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
L_LearnManual702:
;FirmV_0_7_0.c,2588 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2590 :: 		case 7: //check for Remote press and slow down
L_LearnManual703:
;FirmV_0_7_0.c,2591 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual704
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
L_LearnManual704:
;FirmV_0_7_0.c,2592 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2594 :: 		case 8: //check for Remote press and stop
L_LearnManual705:
;FirmV_0_7_0.c,2595 :: 		if(Events.Remote!=0){if(DoorNo==2)LearnPhase=LearnPhase+1;else LearnPhase=17;t4=ms500;StopMotor(1);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual706
	MOVF        LearnManual_DoorNo_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnManual707
	INCF        _LearnPhase+0, 1 
	GOTO        L_LearnManual708
L_LearnManual707:
	MOVLW       17
	MOVWF       _LearnPhase+0 
L_LearnManual708:
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
;FirmV_0_7_0.c,2596 :: 		RawData.D1OpenTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+1 
;FirmV_0_7_0.c,2597 :: 		RawData.D1OpenSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+4 
;FirmV_0_7_0.c,2598 :: 		RawData.D1OpenSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+5 
;FirmV_0_7_0.c,2599 :: 		}
L_LearnManual706:
;FirmV_0_7_0.c,2600 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2602 :: 		case 9: //Wait for remote to start D2 and slow down
L_LearnManual709:
;FirmV_0_7_0.c,2603 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(2,_Open);SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual710
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
L_LearnManual710:
;FirmV_0_7_0.c,2604 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2606 :: 		case 10: //check for Remote press and fast up
L_LearnManual711:
;FirmV_0_7_0.c,2607 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(Motor1FullSpeed,1);M2isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual712
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
L_LearnManual712:
;FirmV_0_7_0.c,2608 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2610 :: 		case 11: //check for Remote press and slow down
L_LearnManual713:
;FirmV_0_7_0.c,2611 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual714
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
L_LearnManual714:
;FirmV_0_7_0.c,2612 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2614 :: 		case 12: //check for Remote press and stop
L_LearnManual715:
;FirmV_0_7_0.c,2615 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(2);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual716
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
;FirmV_0_7_0.c,2616 :: 		RawData.D2OpenTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+3 
;FirmV_0_7_0.c,2617 :: 		RawData.D2OpenSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+8 
;FirmV_0_7_0.c,2618 :: 		RawData.D2OpenSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+9 
;FirmV_0_7_0.c,2619 :: 		}
L_LearnManual716:
;FirmV_0_7_0.c,2620 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2622 :: 		case 13: //Wait for remote to start D2 and slow down
L_LearnManual717:
;FirmV_0_7_0.c,2623 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(2,_Close);SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual718
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
L_LearnManual718:
;FirmV_0_7_0.c,2624 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2626 :: 		case 14: //check for Remote press and fast up
L_LearnManual719:
;FirmV_0_7_0.c,2627 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(Motor1FullSpeed,1);M2isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual720
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
L_LearnManual720:
;FirmV_0_7_0.c,2628 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2630 :: 		case 15: //check for Remote press and slow down
L_LearnManual721:
;FirmV_0_7_0.c,2631 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual722
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
L_LearnManual722:
;FirmV_0_7_0.c,2632 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2634 :: 		case 16: //check for Remote press and stop
L_LearnManual723:
;FirmV_0_7_0.c,2635 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(2);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual724
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
;FirmV_0_7_0.c,2636 :: 		RawData.D2CloseTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+2 
;FirmV_0_7_0.c,2637 :: 		RawData.D2CloseSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+10 
;FirmV_0_7_0.c,2638 :: 		RawData.D2CloseSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+11 
;FirmV_0_7_0.c,2639 :: 		}
L_LearnManual724:
;FirmV_0_7_0.c,2640 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2642 :: 		case 17: //Wait for remote to start D1 and slow down
L_LearnManual725:
;FirmV_0_7_0.c,2643 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(1,_Close);SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual726
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
L_LearnManual726:
;FirmV_0_7_0.c,2644 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2646 :: 		case 18: //check for Remote press and fast up
L_LearnManual727:
;FirmV_0_7_0.c,2647 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(1,Motor2FullSpeed);M1isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual728
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
L_LearnManual728:
;FirmV_0_7_0.c,2648 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2650 :: 		case 19: //check for Remote press and slow down
L_LearnManual729:
;FirmV_0_7_0.c,2651 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual730
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
L_LearnManual730:
;FirmV_0_7_0.c,2652 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2654 :: 		case 20: //check for Remote press and stop
L_LearnManual731:
;FirmV_0_7_0.c,2655 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(1);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual732
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
;FirmV_0_7_0.c,2656 :: 		RawData.D1CloseTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+0 
;FirmV_0_7_0.c,2657 :: 		RawData.D1CloseSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+6 
;FirmV_0_7_0.c,2658 :: 		RawData.D1CloseSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+7 
;FirmV_0_7_0.c,2659 :: 		}
L_LearnManual732:
;FirmV_0_7_0.c,2660 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2662 :: 		case 21:
L_LearnManual733:
;FirmV_0_7_0.c,2663 :: 		SaveLearnData(&RawData,DoorNo);
	MOVLW       LearnManual_RawData_L0+0
	MOVWF       FARG_SaveLearnData_d+0 
	MOVLW       hi_addr(LearnManual_RawData_L0+0)
	MOVWF       FARG_SaveLearnData_d+1 
	MOVF        LearnManual_DoorNo_L0+0, 0 
	MOVWF       FARG_SaveLearnData_DCount+0 
	CALL        _SaveLearnData+0, 0
;FirmV_0_7_0.c,2664 :: 		memcpy(LCDLine1," Learn Complete ",16);
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
;FirmV_0_7_0.c,2665 :: 		memcpy(LCDLine2,"     Ready      ",16);
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
;FirmV_0_7_0.c,2666 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2667 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2668 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,2670 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2671 :: 		break;
	GOTO        L_LearnManual683
;FirmV_0_7_0.c,2672 :: 		}
L_LearnManual682:
	MOVF        _LearnPhase+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual684
	MOVF        _LearnPhase+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual687
	MOVF        _LearnPhase+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual688
	MOVF        _LearnPhase+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual693
	MOVF        _LearnPhase+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual694
	MOVF        _LearnPhase+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual699
	MOVF        _LearnPhase+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual701
	MOVF        _LearnPhase+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual703
	MOVF        _LearnPhase+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual705
	MOVF        _LearnPhase+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual709
	MOVF        _LearnPhase+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual711
	MOVF        _LearnPhase+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual713
	MOVF        _LearnPhase+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual715
	MOVF        _LearnPhase+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual717
	MOVF        _LearnPhase+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual719
	MOVF        _LearnPhase+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual721
	MOVF        _LearnPhase+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual723
	MOVF        _LearnPhase+0, 0 
	XORLW       17
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual725
	MOVF        _LearnPhase+0, 0 
	XORLW       18
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual727
	MOVF        _LearnPhase+0, 0 
	XORLW       19
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual729
	MOVF        _LearnPhase+0, 0 
	XORLW       20
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual731
	MOVF        _LearnPhase+0, 0 
	XORLW       21
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual733
L_LearnManual683:
;FirmV_0_7_0.c,2673 :: 		}
L_end_LearnManual:
	RETURN      0
; end of _LearnManual

_charValueToStr:

;FirmV_0_7_0.c,2694 :: 		void charValueToStr(char val, char * string)
;FirmV_0_7_0.c,2696 :: 		bytetostr(val>>1,string);
	MOVF        FARG_charValueToStr_val+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVF        FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_ByteToStr_output+0 
	MOVF        FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,2697 :: 		if((val%2)==1)
	MOVLW       1
	ANDWF       FARG_charValueToStr_val+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_charValueToStr734
;FirmV_0_7_0.c,2698 :: 		memcpy(string+3,".5s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr111_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr111_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_charValueToStr735
L_charValueToStr734:
;FirmV_0_7_0.c,2700 :: 		memcpy(string+3,".0s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr112_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr112_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_charValueToStr735:
;FirmV_0_7_0.c,2701 :: 		}
L_end_charValueToStr:
	RETURN      0
; end of _charValueToStr

_charValueToStr_AC:

;FirmV_0_7_0.c,2710 :: 		void charValueToStr_AC(char val, char * string)
;FirmV_0_7_0.c,2712 :: 		bytetostr(val>>1,string);
	MOVF        FARG_charValueToStr_AC_val+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVF        FARG_charValueToStr_AC_string+0, 0 
	MOVWF       FARG_ByteToStr_output+0 
	MOVF        FARG_charValueToStr_AC_string+1, 0 
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,2713 :: 		memcpy(string+3,"s  ",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_AC_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_AC_string+1, 0 
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
;FirmV_0_7_0.c,2714 :: 		}
L_end_charValueToStr_AC:
	RETURN      0
; end of _charValueToStr_AC

_intValueToStr:

;FirmV_0_7_0.c,2727 :: 		void intValueToStr(unsigned val, char * string)
;FirmV_0_7_0.c,2729 :: 		wordtostr(val>>1,string);
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
;FirmV_0_7_0.c,2730 :: 		if((val%2)==1)
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
	GOTO        L__intValueToStr1019
	MOVLW       1
	XORWF       R1, 0 
L__intValueToStr1019:
	BTFSS       STATUS+0, 2 
	GOTO        L_intValueToStr736
;FirmV_0_7_0.c,2731 :: 		memcpy(string+5,".5s",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
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
	GOTO        L_intValueToStr737
L_intValueToStr736:
;FirmV_0_7_0.c,2733 :: 		memcpy(string+5,".0s",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
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
L_intValueToStr737:
;FirmV_0_7_0.c,2734 :: 		}
L_end_intValueToStr:
	RETURN      0
; end of _intValueToStr

_SetOverloadParams:

;FirmV_0_7_0.c,2746 :: 		void SetOverloadParams(char p1, char d1,char p2, char d2)
;FirmV_0_7_0.c,2749 :: 		switch(p1)
	GOTO        L_SetOverloadParams738
;FirmV_0_7_0.c,2751 :: 		case 0: OverloadTreshold1=0; break;
L_SetOverloadParams740:
	CLRF        _OverloadTreshold1+0 
	CLRF        _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2753 :: 		case 1: OverloadTreshold1=480; break;
L_SetOverloadParams741:
	MOVLW       224
	MOVWF       _OverloadTreshold1+0 
	MOVLW       1
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2755 :: 		case 2: OverloadTreshold1=490; break;
L_SetOverloadParams742:
	MOVLW       234
	MOVWF       _OverloadTreshold1+0 
	MOVLW       1
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2757 :: 		case 3: OverloadTreshold1=500; break;
L_SetOverloadParams743:
	MOVLW       244
	MOVWF       _OverloadTreshold1+0 
	MOVLW       1
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2759 :: 		case 4: OverloadTreshold1=530; break;
L_SetOverloadParams744:
	MOVLW       18
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2761 :: 		case 5: OverloadTreshold1=550; break;
L_SetOverloadParams745:
	MOVLW       38
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2763 :: 		case 6: OverloadTreshold1=570; break;
L_SetOverloadParams746:
	MOVLW       58
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2765 :: 		case 7: OverloadTreshold1=600; break;
L_SetOverloadParams747:
	MOVLW       88
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2767 :: 		case 8: OverloadTreshold1=630; break;
L_SetOverloadParams748:
	MOVLW       118
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2769 :: 		case 9: OverloadTreshold1=650; break;
L_SetOverloadParams749:
	MOVLW       138
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2771 :: 		case 10: OverloadTreshold1=670; break;
L_SetOverloadParams750:
	MOVLW       158
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2773 :: 		case 11: OverloadTreshold1=700; break;
L_SetOverloadParams751:
	MOVLW       188
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2775 :: 		case 12: OverloadTreshold1=750; break;
L_SetOverloadParams752:
	MOVLW       238
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2777 :: 		case 13: OverloadTreshold1=800; break;
L_SetOverloadParams753:
	MOVLW       32
	MOVWF       _OverloadTreshold1+0 
	MOVLW       3
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2779 :: 		case 14: OverloadTreshold1=850; break;
L_SetOverloadParams754:
	MOVLW       82
	MOVWF       _OverloadTreshold1+0 
	MOVLW       3
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2781 :: 		case 15: OverloadTreshold1=900; break;
L_SetOverloadParams755:
	MOVLW       132
	MOVWF       _OverloadTreshold1+0 
	MOVLW       3
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams739
;FirmV_0_7_0.c,2783 :: 		}
L_SetOverloadParams738:
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams740
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams741
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams742
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams743
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams744
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams745
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams746
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams747
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams748
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams749
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams750
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams751
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams752
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams753
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams754
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams755
L_SetOverloadParams739:
;FirmV_0_7_0.c,2786 :: 		switch(d1)
	GOTO        L_SetOverloadParams756
;FirmV_0_7_0.c,2788 :: 		case 0: OverloadDuration1=100; break;
L_SetOverloadParams758:
	MOVLW       100
	MOVWF       _OverloadDuration1+0 
	MOVLW       0
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams757
;FirmV_0_7_0.c,2790 :: 		case 1: OverloadDuration1=500; break;
L_SetOverloadParams759:
	MOVLW       244
	MOVWF       _OverloadDuration1+0 
	MOVLW       1
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams757
;FirmV_0_7_0.c,2792 :: 		case 2: OverloadDuration1=1000; break;
L_SetOverloadParams760:
	MOVLW       232
	MOVWF       _OverloadDuration1+0 
	MOVLW       3
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams757
;FirmV_0_7_0.c,2794 :: 		case 3: OverloadDuration1=1500; break;
L_SetOverloadParams761:
	MOVLW       220
	MOVWF       _OverloadDuration1+0 
	MOVLW       5
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams757
;FirmV_0_7_0.c,2796 :: 		case 4: OverloadDuration1=2000; break;
L_SetOverloadParams762:
	MOVLW       208
	MOVWF       _OverloadDuration1+0 
	MOVLW       7
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams757
;FirmV_0_7_0.c,2798 :: 		case 5: OverloadDuration1=2500; break;
L_SetOverloadParams763:
	MOVLW       196
	MOVWF       _OverloadDuration1+0 
	MOVLW       9
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams757
;FirmV_0_7_0.c,2800 :: 		case 6: OverloadDuration1=3000; break;
L_SetOverloadParams764:
	MOVLW       184
	MOVWF       _OverloadDuration1+0 
	MOVLW       11
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams757
;FirmV_0_7_0.c,2802 :: 		case 7: OverloadDuration1=3500; break;
L_SetOverloadParams765:
	MOVLW       172
	MOVWF       _OverloadDuration1+0 
	MOVLW       13
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams757
;FirmV_0_7_0.c,2804 :: 		case 8: OverloadDuration1=4000; break;
L_SetOverloadParams766:
	MOVLW       160
	MOVWF       _OverloadDuration1+0 
	MOVLW       15
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams757
;FirmV_0_7_0.c,2806 :: 		case 9: OverloadDuration1=4500; break;
L_SetOverloadParams767:
	MOVLW       148
	MOVWF       _OverloadDuration1+0 
	MOVLW       17
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams757
;FirmV_0_7_0.c,2808 :: 		case 10: OverloadDuration1=5000; break;
L_SetOverloadParams768:
	MOVLW       136
	MOVWF       _OverloadDuration1+0 
	MOVLW       19
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams757
;FirmV_0_7_0.c,2809 :: 		}
L_SetOverloadParams756:
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams758
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams759
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams760
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams761
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams762
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams763
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams764
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams765
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams766
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams767
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams768
L_SetOverloadParams757:
;FirmV_0_7_0.c,2815 :: 		switch(p2)
	GOTO        L_SetOverloadParams769
;FirmV_0_7_0.c,2817 :: 		case 0: OverloadTreshold2=0; break;
L_SetOverloadParams771:
	CLRF        _OverloadTreshold2+0 
	CLRF        _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2819 :: 		case 1: OverloadTreshold2=480; break;
L_SetOverloadParams772:
	MOVLW       224
	MOVWF       _OverloadTreshold2+0 
	MOVLW       1
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2821 :: 		case 2: OverloadTreshold2=490; break;
L_SetOverloadParams773:
	MOVLW       234
	MOVWF       _OverloadTreshold2+0 
	MOVLW       1
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2823 :: 		case 3: OverloadTreshold2=500; break;
L_SetOverloadParams774:
	MOVLW       244
	MOVWF       _OverloadTreshold2+0 
	MOVLW       1
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2825 :: 		case 4: OverloadTreshold2=530; break;
L_SetOverloadParams775:
	MOVLW       18
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2827 :: 		case 5: OverloadTreshold2=550; break;
L_SetOverloadParams776:
	MOVLW       38
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2829 :: 		case 6: OverloadTreshold2=570; break;
L_SetOverloadParams777:
	MOVLW       58
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2831 :: 		case 7: OverloadTreshold2=600; break;
L_SetOverloadParams778:
	MOVLW       88
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2833 :: 		case 8: OverloadTreshold2=630; break;
L_SetOverloadParams779:
	MOVLW       118
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2835 :: 		case 9: OverloadTreshold2=650; break;
L_SetOverloadParams780:
	MOVLW       138
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2837 :: 		case 10: OverloadTreshold2=670; break;
L_SetOverloadParams781:
	MOVLW       158
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2839 :: 		case 11: OverloadTreshold2=700; break;
L_SetOverloadParams782:
	MOVLW       188
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2841 :: 		case 12: OverloadTreshold2=750; break;
L_SetOverloadParams783:
	MOVLW       238
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2843 :: 		case 13: OverloadTreshold2=800; break;
L_SetOverloadParams784:
	MOVLW       32
	MOVWF       _OverloadTreshold2+0 
	MOVLW       3
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2845 :: 		case 14: OverloadTreshold2=850; break;
L_SetOverloadParams785:
	MOVLW       82
	MOVWF       _OverloadTreshold2+0 
	MOVLW       3
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2847 :: 		case 15: OverloadTreshold2=900; break;
L_SetOverloadParams786:
	MOVLW       132
	MOVWF       _OverloadTreshold2+0 
	MOVLW       3
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams770
;FirmV_0_7_0.c,2849 :: 		}
L_SetOverloadParams769:
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams771
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams772
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams773
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams774
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams775
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams776
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams777
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams778
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams779
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams780
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams781
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams782
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams783
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams784
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams785
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams786
L_SetOverloadParams770:
;FirmV_0_7_0.c,2852 :: 		switch(d2)
	GOTO        L_SetOverloadParams787
;FirmV_0_7_0.c,2854 :: 		case 0: OverloadDuration2=100; break;
L_SetOverloadParams789:
	MOVLW       100
	MOVWF       _OverloadDuration2+0 
	MOVLW       0
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams788
;FirmV_0_7_0.c,2856 :: 		case 1: OverloadDuration2=500; break;
L_SetOverloadParams790:
	MOVLW       244
	MOVWF       _OverloadDuration2+0 
	MOVLW       1
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams788
;FirmV_0_7_0.c,2858 :: 		case 2: OverloadDuration2=1000; break;
L_SetOverloadParams791:
	MOVLW       232
	MOVWF       _OverloadDuration2+0 
	MOVLW       3
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams788
;FirmV_0_7_0.c,2860 :: 		case 3: OverloadDuration2=1500; break;
L_SetOverloadParams792:
	MOVLW       220
	MOVWF       _OverloadDuration2+0 
	MOVLW       5
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams788
;FirmV_0_7_0.c,2862 :: 		case 4: OverloadDuration2=2000; break;
L_SetOverloadParams793:
	MOVLW       208
	MOVWF       _OverloadDuration2+0 
	MOVLW       7
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams788
;FirmV_0_7_0.c,2864 :: 		case 5: OverloadDuration2=2500; break;
L_SetOverloadParams794:
	MOVLW       196
	MOVWF       _OverloadDuration2+0 
	MOVLW       9
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams788
;FirmV_0_7_0.c,2866 :: 		case 6: OverloadDuration2=3000; break;
L_SetOverloadParams795:
	MOVLW       184
	MOVWF       _OverloadDuration2+0 
	MOVLW       11
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams788
;FirmV_0_7_0.c,2868 :: 		case 7: OverloadDuration2=3500; break;
L_SetOverloadParams796:
	MOVLW       172
	MOVWF       _OverloadDuration2+0 
	MOVLW       13
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams788
;FirmV_0_7_0.c,2870 :: 		case 8: OverloadDuration2=4000; break;
L_SetOverloadParams797:
	MOVLW       160
	MOVWF       _OverloadDuration2+0 
	MOVLW       15
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams788
;FirmV_0_7_0.c,2872 :: 		case 9: OverloadDuration2=4500; break;
L_SetOverloadParams798:
	MOVLW       148
	MOVWF       _OverloadDuration2+0 
	MOVLW       17
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams788
;FirmV_0_7_0.c,2874 :: 		case 10: OverloadDuration2=5000; break;
L_SetOverloadParams799:
	MOVLW       136
	MOVWF       _OverloadDuration2+0 
	MOVLW       19
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams788
;FirmV_0_7_0.c,2875 :: 		}
L_SetOverloadParams787:
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams789
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams790
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams791
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams792
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams793
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams794
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams795
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams796
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams797
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams798
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams799
L_SetOverloadParams788:
;FirmV_0_7_0.c,2876 :: 		}
L_end_SetOverloadParams:
	RETURN      0
; end of _SetOverloadParams

_TorqueLogger:

;FirmV_0_7_0.c,2897 :: 		void TorqueLogger()
;FirmV_0_7_0.c,2900 :: 		switch(State)
	GOTO        L_TorqueLogger800
;FirmV_0_7_0.c,2902 :: 		case 3:
L_TorqueLogger802:
;FirmV_0_7_0.c,2903 :: 		txt[0]='D';txt[1]='3';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       51
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2904 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2905 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2906 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2908 :: 		txt[0]='D';txt[1]='3';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       51
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2909 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2910 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2911 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2913 :: 		break;
	GOTO        L_TorqueLogger801
;FirmV_0_7_0.c,2915 :: 		case 4:
L_TorqueLogger803:
;FirmV_0_7_0.c,2916 :: 		txt[0]='D';txt[1]='4';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       52
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2917 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2918 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2919 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2921 :: 		txt[0]='D';txt[1]='4';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       52
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2922 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2923 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2924 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2926 :: 		break;
	GOTO        L_TorqueLogger801
;FirmV_0_7_0.c,2928 :: 		case 7:
L_TorqueLogger804:
;FirmV_0_7_0.c,2929 :: 		txt[0]='D';txt[1]='7';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       55
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2930 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2931 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2932 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2934 :: 		txt[0]='D';txt[1]='7';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       55
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2935 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2936 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2937 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2939 :: 		break;
	GOTO        L_TorqueLogger801
;FirmV_0_7_0.c,2941 :: 		case 8:
L_TorqueLogger805:
;FirmV_0_7_0.c,2942 :: 		txt[0]='D';txt[1]='8';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       56
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2943 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2944 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2945 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2947 :: 		txt[0]='D';txt[1]='8';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       56
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2948 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2949 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2950 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2952 :: 		break;
	GOTO        L_TorqueLogger801
;FirmV_0_7_0.c,2954 :: 		case 200:
L_TorqueLogger806:
;FirmV_0_7_0.c,2955 :: 		txt[0]='D';txt[1]='L';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       76
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2956 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2957 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2958 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2960 :: 		txt[0]='D';txt[1]='L';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       76
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,2961 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,2962 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,2963 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,2965 :: 		break;
	GOTO        L_TorqueLogger801
;FirmV_0_7_0.c,2967 :: 		}
L_TorqueLogger800:
	MOVF        _State+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger802
	MOVF        _State+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger803
	MOVF        _State+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger804
	MOVF        _State+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger805
	MOVF        _State+0, 0 
	XORLW       200
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger806
L_TorqueLogger801:
;FirmV_0_7_0.c,2968 :: 		}
L_end_TorqueLogger:
	RETURN      0
; end of _TorqueLogger
