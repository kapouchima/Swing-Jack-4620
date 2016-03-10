
_interrupt:

;FirmV_0_7_0.c,212 :: 		void interrupt()
;FirmV_0_7_0.c,214 :: 		if(TMR0IF_bit)
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt0
;FirmV_0_7_0.c,216 :: 		msCounter=msCounter+1;
	INCF        _msCounter+0, 1 
;FirmV_0_7_0.c,217 :: 		LCDBackLight=1;
	BSF         PORTA+0, 4 
;FirmV_0_7_0.c,218 :: 		Flag20ms=1;
	MOVLW       1
	MOVWF       _Flag20ms+0 
;FirmV_0_7_0.c,219 :: 		if(ms20A>=25)
	MOVLW       25
	SUBWF       _ms20A+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
;FirmV_0_7_0.c,220 :: 		{ms20A=0;RemotePulse1=0;}
	CLRF        _ms20A+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt2
L_interrupt1:
;FirmV_0_7_0.c,222 :: 		ms20A=ms20A+1;
	INCF        _ms20A+0, 1 
L_interrupt2:
;FirmV_0_7_0.c,224 :: 		if(ms20B>=25)
	MOVLW       25
	SUBWF       _ms20B+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt3
;FirmV_0_7_0.c,225 :: 		{ms20B=0;RemotePulse2=0;}
	CLRF        _ms20B+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt4
L_interrupt3:
;FirmV_0_7_0.c,227 :: 		ms20B=ms20B+1;
	INCF        _ms20B+0, 1 
L_interrupt4:
;FirmV_0_7_0.c,229 :: 		if(msCounter>=25)
	MOVLW       25
	SUBWF       _msCounter+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt5
;FirmV_0_7_0.c,231 :: 		msCounter=0;
	CLRF        _msCounter+0 
;FirmV_0_7_0.c,232 :: 		ms500=ms500+1;
	MOVLW       1
	ADDWF       _ms500+0, 1 
	MOVLW       0
	ADDWFC      _ms500+1, 1 
	ADDWFC      _ms500+2, 1 
	ADDWFC      _ms500+3, 1 
;FirmV_0_7_0.c,233 :: 		LCDFlashFlag=!LCDFlashFlag;
	MOVF        _LCDFlashFlag+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _LCDFlashFlag+0 
;FirmV_0_7_0.c,234 :: 		LCDBackLight=0;
	BCF         PORTA+0, 4 
;FirmV_0_7_0.c,235 :: 		Flag500ms=1;
	MOVLW       1
	MOVWF       _Flag500ms+0 
;FirmV_0_7_0.c,236 :: 		}
L_interrupt5:
;FirmV_0_7_0.c,237 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,238 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,239 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;FirmV_0_7_0.c,240 :: 		}
L_interrupt0:
;FirmV_0_7_0.c,243 :: 		if(INT1F_bit)
	BTFSS       INT1F_bit+0, BitPos(INT1F_bit+0) 
	GOTO        L_interrupt6
;FirmV_0_7_0.c,245 :: 		if(RemotePulse1==0)
	MOVF        _RemotePulse1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;FirmV_0_7_0.c,246 :: 		{ RemotePulse1=RemotePulse1+1;ms20A=0;}
	INCF        _RemotePulse1+0, 1 
	CLRF        _ms20A+0 
	GOTO        L_interrupt8
L_interrupt7:
;FirmV_0_7_0.c,248 :: 		{ RemotePulse1=RemotePulse1+1;}
	INCF        _RemotePulse1+0, 1 
L_interrupt8:
;FirmV_0_7_0.c,249 :: 		if(RemotePulse1>=5)
	MOVLW       5
	SUBWF       _RemotePulse1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt9
;FirmV_0_7_0.c,250 :: 		if((ms20A>=19)&&(ms20A<=21))
	MOVLW       19
	SUBWF       _ms20A+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
	MOVF        _ms20A+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
L__interrupt869:
;FirmV_0_7_0.c,251 :: 		{RemoteAFlag=1;RemotePulse1=0;}
	MOVLW       1
	MOVWF       _RemoteAFlag+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt13
L_interrupt12:
;FirmV_0_7_0.c,253 :: 		RemotePulse1=0;
	CLRF        _RemotePulse1+0 
L_interrupt13:
L_interrupt9:
;FirmV_0_7_0.c,254 :: 		INT1IF_bit=0;
	BCF         INT1IF_bit+0, BitPos(INT1IF_bit+0) 
;FirmV_0_7_0.c,255 :: 		}
L_interrupt6:
;FirmV_0_7_0.c,259 :: 		if(INT2IF_bit)
	BTFSS       INT2IF_bit+0, BitPos(INT2IF_bit+0) 
	GOTO        L_interrupt14
;FirmV_0_7_0.c,261 :: 		if(RemotePulse2==0)
	MOVF        _RemotePulse2+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt15
;FirmV_0_7_0.c,262 :: 		{ RemotePulse2=RemotePulse2+1;ms20B=0;}
	INCF        _RemotePulse2+0, 1 
	CLRF        _ms20B+0 
	GOTO        L_interrupt16
L_interrupt15:
;FirmV_0_7_0.c,264 :: 		{ RemotePulse2=RemotePulse2+1;}
	INCF        _RemotePulse2+0, 1 
L_interrupt16:
;FirmV_0_7_0.c,265 :: 		if(RemotePulse2>=5)
	MOVLW       5
	SUBWF       _RemotePulse2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt17
;FirmV_0_7_0.c,266 :: 		if((ms20B>=19)&&(ms20B<=21))
	MOVLW       19
	SUBWF       _ms20B+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
	MOVF        _ms20B+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
L__interrupt868:
;FirmV_0_7_0.c,267 :: 		{RemoteBFlag=1;RemotePulse2=0;}
	MOVLW       1
	MOVWF       _RemoteBFlag+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt21
L_interrupt20:
;FirmV_0_7_0.c,269 :: 		RemotePulse2=0;
	CLRF        _RemotePulse2+0 
L_interrupt21:
L_interrupt17:
;FirmV_0_7_0.c,270 :: 		INT2IF_bit=0;
	BCF         INT2IF_bit+0, BitPos(INT2IF_bit+0) 
;FirmV_0_7_0.c,271 :: 		}
L_interrupt14:
;FirmV_0_7_0.c,274 :: 		if(INT0F_bit)
	BTFSS       INT0F_bit+0, BitPos(INT0F_bit+0) 
	GOTO        L_interrupt22
;FirmV_0_7_0.c,276 :: 		TMR2=0;
	CLRF        TMR2+0 
;FirmV_0_7_0.c,277 :: 		TMR2ON_bit=1;
	BSF         TMR2ON_bit+0, BitPos(TMR2ON_bit+0) 
;FirmV_0_7_0.c,278 :: 		TMR2IE_bit=1;
	BSF         TMR2IE_bit+0, BitPos(TMR2IE_bit+0) 
;FirmV_0_7_0.c,279 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, BitPos(INT0F_bit+0) 
;FirmV_0_7_0.c,280 :: 		}
L_interrupt22:
;FirmV_0_7_0.c,283 :: 		if(TMR2IF_bit)
	BTFSS       TMR2IF_bit+0, BitPos(TMR2IF_bit+0) 
	GOTO        L_interrupt23
;FirmV_0_7_0.c,285 :: 		ZCCounter=ZCCounter+1;
	INCF        _ZCCounter+0, 1 
;FirmV_0_7_0.c,287 :: 		if(ZCCounter==255)
	MOVF        _ZCCounter+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt24
;FirmV_0_7_0.c,288 :: 		ZCCounter=2;
	MOVLW       2
	MOVWF       _ZCCounter+0 
L_interrupt24:
;FirmV_0_7_0.c,289 :: 		if(ZCCounter%3==1)
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
	GOTO        L_interrupt25
;FirmV_0_7_0.c,291 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt26
;FirmV_0_7_0.c,292 :: 		if(Motor1FullSpeed)
	MOVF        _Motor1FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt27
;FirmV_0_7_0.c,293 :: 		Motor1=1;
	BSF         PORTB+0, 3 
	GOTO        L_interrupt28
L_interrupt27:
;FirmV_0_7_0.c,295 :: 		{if(PowerCounter >= (M1SoftPower))Motor1=0;}
	MOVLW       0
	MOVWF       R0 
	MOVF        _M1SoftPower+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt1001
	MOVF        _M1SoftPower+0, 0 
	SUBWF       _PowerCounter+0, 0 
L__interrupt1001:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt29
	BCF         PORTB+0, 3 
L_interrupt29:
L_interrupt28:
L_interrupt26:
;FirmV_0_7_0.c,297 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt30
;FirmV_0_7_0.c,298 :: 		if(Motor2FullSpeed)
	MOVF        _Motor2FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt31
;FirmV_0_7_0.c,299 :: 		Motor2=1;
	BSF         PORTB+0, 4 
	GOTO        L_interrupt32
L_interrupt31:
;FirmV_0_7_0.c,301 :: 		{if(PowerCounter >= (M2SoftPower))Motor2=0;}
	MOVLW       0
	MOVWF       R0 
	MOVF        _M2SoftPower+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt1002
	MOVF        _M2SoftPower+0, 0 
	SUBWF       _PowerCounter+0, 0 
L__interrupt1002:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt33
	BCF         PORTB+0, 4 
L_interrupt33:
L_interrupt32:
L_interrupt30:
;FirmV_0_7_0.c,302 :: 		}
L_interrupt25:
;FirmV_0_7_0.c,303 :: 		if(ZCCounter%3==0)
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
	GOTO        L_interrupt34
;FirmV_0_7_0.c,305 :: 		PowerCounter ++;
	INCF        _PowerCounter+0, 1 
;FirmV_0_7_0.c,306 :: 		if(PowerCounter >= 10)
	MOVLW       10
	SUBWF       _PowerCounter+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt35
;FirmV_0_7_0.c,307 :: 		PowerCounter=1;
	MOVLW       1
	MOVWF       _PowerCounter+0 
L_interrupt35:
;FirmV_0_7_0.c,309 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt36
;FirmV_0_7_0.c,310 :: 		Motor1=1;
	BSF         PORTB+0, 3 
L_interrupt36:
;FirmV_0_7_0.c,312 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt37
;FirmV_0_7_0.c,313 :: 		Motor2=1;
	BSF         PORTB+0, 4 
L_interrupt37:
;FirmV_0_7_0.c,314 :: 		}
L_interrupt34:
;FirmV_0_7_0.c,316 :: 		TMR2ON_bit=0;
	BCF         TMR2ON_bit+0, BitPos(TMR2ON_bit+0) 
;FirmV_0_7_0.c,317 :: 		TMR2IE_bit=0;
	BCF         TMR2IE_bit+0, BitPos(TMR2IE_bit+0) 
;FirmV_0_7_0.c,318 :: 		TMR2IF_bit=0;
	BCF         TMR2IF_bit+0, BitPos(TMR2IF_bit+0) 
;FirmV_0_7_0.c,320 :: 		}
L_interrupt23:
;FirmV_0_7_0.c,321 :: 		}
L_end_interrupt:
L__interrupt1000:
	RETFIE      1
; end of _interrupt

_ResetTaskEvents:

;FirmV_0_7_0.c,334 :: 		void ResetTaskEvents()
;FirmV_0_7_0.c,336 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,337 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,338 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,339 :: 		}
L_end_ResetTaskEvents:
	RETURN      0
; end of _ResetTaskEvents

_Decrypt:

;FirmV_0_7_0.c,348 :: 		void Decrypt()
;FirmV_0_7_0.c,350 :: 		Sipher[0]=Crypto[1][0]+0x0D;
	MOVLW       13
	ADDWF       _crypto+16, 0 
	MOVWF       _Sipher+0 
;FirmV_0_7_0.c,351 :: 		Sipher[1]=Crypto[1][1]+0x0D;
	MOVLW       13
	ADDWF       _crypto+17, 0 
	MOVWF       _Sipher+1 
;FirmV_0_7_0.c,352 :: 		Sipher[2]=Crypto[1][2]+0x0D;
	MOVLW       13
	ADDWF       _crypto+18, 0 
	MOVWF       _Sipher+2 
;FirmV_0_7_0.c,353 :: 		Sipher[3]=Crypto[1][3]-0x26;
	MOVLW       38
	SUBWF       _crypto+19, 0 
	MOVWF       _Sipher+3 
;FirmV_0_7_0.c,354 :: 		Sipher[4]=Crypto[1][4]-0x3C;
	MOVLW       60
	SUBWF       _crypto+20, 0 
	MOVWF       _Sipher+4 
;FirmV_0_7_0.c,355 :: 		Sipher[5]=Crypto[1][5]-0x41;
	MOVLW       65
	SUBWF       _crypto+21, 0 
	MOVWF       _Sipher+5 
;FirmV_0_7_0.c,356 :: 		Sipher[6]=Crypto[1][6]-0x0C;
	MOVLW       12
	SUBWF       _crypto+22, 0 
	MOVWF       _Sipher+6 
;FirmV_0_7_0.c,357 :: 		Sipher[7]=Crypto[1][7]+0x34;
	MOVLW       52
	ADDWF       _crypto+23, 0 
	MOVWF       _Sipher+7 
;FirmV_0_7_0.c,358 :: 		Sipher[8]=Crypto[1][8]-0x01;
	DECF        _crypto+24, 0 
	MOVWF       _Sipher+8 
;FirmV_0_7_0.c,359 :: 		Sipher[9]=Crypto[1][9]-0x1F;
	MOVLW       31
	SUBWF       _crypto+25, 0 
	MOVWF       _Sipher+9 
;FirmV_0_7_0.c,360 :: 		Sipher[10]=Crypto[1][10]-0x3A;
	MOVLW       58
	SUBWF       _crypto+26, 0 
	MOVWF       _Sipher+10 
;FirmV_0_7_0.c,361 :: 		Sipher[11]=Crypto[1][11]-0x3B;
	MOVLW       59
	SUBWF       _crypto+27, 0 
	MOVWF       _Sipher+11 
;FirmV_0_7_0.c,362 :: 		Sipher[12]=Crypto[1][12]-0x3C;
	MOVLW       60
	SUBWF       _crypto+28, 0 
	MOVWF       _Sipher+12 
;FirmV_0_7_0.c,363 :: 		Sipher[13]=Crypto[1][13]+0x0D;
	MOVLW       13
	ADDWF       _crypto+29, 0 
	MOVWF       _Sipher+13 
;FirmV_0_7_0.c,364 :: 		Sipher[14]=Crypto[1][14]+0x0D;
	MOVLW       13
	ADDWF       _crypto+30, 0 
	MOVWF       _Sipher+14 
;FirmV_0_7_0.c,365 :: 		Sipher[15]=Crypto[1][15]+0x0D;
	MOVLW       13
	ADDWF       _crypto+31, 0 
	MOVWF       _Sipher+15 
;FirmV_0_7_0.c,366 :: 		}
L_end_Decrypt:
	RETURN      0
; end of _Decrypt

_Logger:

;FirmV_0_7_0.c,378 :: 		void Logger(char* text, char TimeStampFlag)
;FirmV_0_7_0.c,381 :: 		if(TimeStampFlag)
	MOVF        FARG_Logger_TimeStampFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Logger38
;FirmV_0_7_0.c,383 :: 		longwordtostrwithzeros(ms500,time);
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
;FirmV_0_7_0.c,384 :: 		uart_write_text(time);
	MOVLW       Logger_time_L0+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(Logger_time_L0+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;FirmV_0_7_0.c,385 :: 		uart1_write_text(": ");
	MOVLW       ?lstr1_FirmV_0_7_0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_FirmV_0_7_0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;FirmV_0_7_0.c,386 :: 		}
L_Logger38:
;FirmV_0_7_0.c,387 :: 		uart1_write_text(text);
	MOVF        FARG_Logger_text+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_Logger_text+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;FirmV_0_7_0.c,388 :: 		uart1_write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,389 :: 		uart1_write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,390 :: 		}
L_end_Logger:
	RETURN      0
; end of _Logger

_main:

;FirmV_0_7_0.c,407 :: 		void main() {
;FirmV_0_7_0.c,410 :: 		PhotocellRel=1;
	BSF         PORTC+0, 5 
;FirmV_0_7_0.c,412 :: 		Init();
	CALL        _Init+0, 0
;FirmV_0_7_0.c,414 :: 		Decrypt();
	CALL        _Decrypt+0, 0
;FirmV_0_7_0.c,416 :: 		memcpy(LCDLine1,FirmwareVersion,16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr2_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr2_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,417 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,418 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,419 :: 		LCDUpdater();
	CALL        _LCDUpdater+0, 0
;FirmV_0_7_0.c,420 :: 		delay_ms(1000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_main39:
	DECFSZ      R13, 1, 1
	BRA         L_main39
	DECFSZ      R12, 1, 1
	BRA         L_main39
	DECFSZ      R11, 1, 1
	BRA         L_main39
	NOP
	NOP
;FirmV_0_7_0.c,423 :: 		Buzzer=1;
	BSF         PORTB+0, 7 
;FirmV_0_7_0.c,424 :: 		Logger("Start ...",1);
	MOVLW       ?lstr3_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr3_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,425 :: 		memcpy(LCDLine1,Sipher,16);
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
;FirmV_0_7_0.c,426 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,427 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,428 :: 		Buzzer=0;
	BCF         PORTB+0, 7 
;FirmV_0_7_0.c,430 :: 		while(1)
L_main40:
;FirmV_0_7_0.c,432 :: 		asm CLRWDT;
	CLRWDT
;FirmV_0_7_0.c,434 :: 		if(Flag20ms==1)
	MOVF        _Flag20ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main42
;FirmV_0_7_0.c,436 :: 		if((Buzzer==1)&&(BuzzCounter<100))
	BTFSS       PORTB+0, 7 
	GOTO        L_main45
	MOVLW       100
	SUBWF       _BuzzCounter+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main45
L__main875:
;FirmV_0_7_0.c,437 :: 		{BuzzCounter=BuzzCounter+1;}
	INCF        _BuzzCounter+0, 1 
L_main45:
;FirmV_0_7_0.c,439 :: 		if((Buzzer==1)&&(LongBuzzFlag))
	BTFSS       PORTB+0, 7 
	GOTO        L_main48
	MOVF        _LongBuzzFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main48
L__main874:
;FirmV_0_7_0.c,440 :: 		if(BuzzCounter>=25){BuzzFlag=0;LongBuzzFlag=0;Buzzer=0;}
	MOVLW       25
	SUBWF       _BuzzCounter+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main49
	CLRF        _BuzzFlag+0 
	CLRF        _LongBuzzFlag+0 
	BCF         PORTB+0, 7 
L_main49:
L_main48:
;FirmV_0_7_0.c,442 :: 		if((Buzzer==1)&&(BuzzFlag)&&(!LongBuzzFlag))
	BTFSS       PORTB+0, 7 
	GOTO        L_main52
	MOVF        _BuzzFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main52
	MOVF        _LongBuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main52
L__main873:
;FirmV_0_7_0.c,443 :: 		{BuzzFlag=0;LongBuzzFlag=0;Buzzer=0;}
	CLRF        _BuzzFlag+0 
	CLRF        _LongBuzzFlag+0 
	BCF         PORTB+0, 7 
L_main52:
;FirmV_0_7_0.c,445 :: 		if(((BuzzFlag)||(LongBuzzFlag))&&(!Buzzer))
	MOVF        _BuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main872
	MOVF        _LongBuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main872
	GOTO        L_main57
L__main872:
	BTFSC       PORTB+0, 7 
	GOTO        L_main57
L__main871:
;FirmV_0_7_0.c,446 :: 		{Buzzer=1;BuzzCounter=0;}
	BSF         PORTB+0, 7 
	CLRF        _BuzzCounter+0 
L_main57:
;FirmV_0_7_0.c,449 :: 		if(DebouncingDelayPress<DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelayPress+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main58
;FirmV_0_7_0.c,450 :: 		DebouncingDelayPress=DebouncingDelayPress+1;
	INCF        _DebouncingDelayPress+0, 1 
L_main58:
;FirmV_0_7_0.c,451 :: 		if(DebouncingDelayUnpress<DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelayUnpress+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main59
;FirmV_0_7_0.c,452 :: 		DebouncingDelayUnpress=DebouncingDelayUnpress+1;
	INCF        _DebouncingDelayUnpress+0, 1 
L_main59:
;FirmV_0_7_0.c,454 :: 		LCDUpdater();
	CALL        _LCDUpdater+0, 0
;FirmV_0_7_0.c,455 :: 		if(KeyFlag<200)
	MOVLW       200
	SUBWF       _KeyFlag+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main60
;FirmV_0_7_0.c,456 :: 		KeyFlag=KeyFlag+1;
	INCF        _KeyFlag+0, 1 
L_main60:
;FirmV_0_7_0.c,457 :: 		Flag20ms=0;
	CLRF        _Flag20ms+0 
;FirmV_0_7_0.c,458 :: 		}
L_main42:
;FirmV_0_7_0.c,460 :: 		if(Flag500ms==1)
	MOVF        _Flag500ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main61
;FirmV_0_7_0.c,462 :: 		AutoClosePause();
	CALL        _AutoClosePause+0, 0
;FirmV_0_7_0.c,464 :: 		if(KeyNoiseEliminator<NoiseEliminatorTreshold)
	MOVLW       3
	SUBWF       _KeyNoiseEliminator+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main62
;FirmV_0_7_0.c,465 :: 		KeyNoiseEliminator=KeyNoiseEliminator+1;
	INCF        _KeyNoiseEliminator+0, 1 
L_main62:
;FirmV_0_7_0.c,467 :: 		if(LCDTimeout>0)
	MOVF        _LCDTimeout+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main63
;FirmV_0_7_0.c,468 :: 		{LCDTimeout=LCDTimeout-1;LCDTimeoutFlag=0;}
	DECF        _LCDTimeout+0, 1 
	CLRF        _LCDTimeoutFlag+0 
	GOTO        L_main64
L_main63:
;FirmV_0_7_0.c,470 :: 		if(!LCDTimeoutFlag){memcpy(LCDLine1,Sipher,16);LCDLines=1;LCDUpdateFlag=1;LCDTimeoutFlag=1;}
	MOVF        _LCDTimeoutFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main65
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
	MOVLW       1
	MOVWF       _LCDLines+0 
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
	MOVLW       1
	MOVWF       _LCDTimeoutFlag+0 
L_main65:
L_main64:
;FirmV_0_7_0.c,472 :: 		if(FlashFlag)
	MOVF        _FlashFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main66
;FirmV_0_7_0.c,473 :: 		FlasherLamp=!FlasherLamp;// Buzzer=!Buzzer;
	BTG         PORTB+0, 5 
	GOTO        L_main67
L_main66:
;FirmV_0_7_0.c,475 :: 		if((!BuzzFlag)&&(!LongBuzzFlag))FlasherLamp=0; // Buzzer=0;
	MOVF        _BuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main70
	MOVF        _LongBuzzFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main70
L__main870:
	BCF         PORTB+0, 5 
L_main70:
L_main67:
;FirmV_0_7_0.c,476 :: 		ResetTaskEvents();
	CALL        _ResetTaskEvents+0, 0
;FirmV_0_7_0.c,477 :: 		TaskManager();
	CALL        _TaskManager+0, 0
;FirmV_0_7_0.c,478 :: 		TorqueLogger();
	CALL        _TorqueLogger+0, 0
;FirmV_0_7_0.c,479 :: 		Flag500ms=0;
	CLRF        _Flag500ms+0 
;FirmV_0_7_0.c,480 :: 		}
L_main61:
;FirmV_0_7_0.c,481 :: 		EventHandler();
	CALL        _EventHandler+0, 0
;FirmV_0_7_0.c,482 :: 		StateManager();
	CALL        _StateManager+0, 0
;FirmV_0_7_0.c,483 :: 		}
	GOTO        L_main40
;FirmV_0_7_0.c,485 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_StateManager:

;FirmV_0_7_0.c,510 :: 		void StateManager()
;FirmV_0_7_0.c,513 :: 		switch(State)
	GOTO        L_StateManager71
;FirmV_0_7_0.c,516 :: 		case 0: State1(); break;
L_StateManager73:
	CALL        _State1+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,518 :: 		case 1: State1(); break;
L_StateManager74:
	CALL        _State1+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,520 :: 		case 2: State2(); break;
L_StateManager75:
	CALL        _State2+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,522 :: 		case 3: State3(); break;
L_StateManager76:
	CALL        _State3+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,524 :: 		case 4: State4(); break;
L_StateManager77:
	CALL        _State4+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,526 :: 		case 5: State5(); break;
L_StateManager78:
	CALL        _State5+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,528 :: 		case 6: State6(); break;
L_StateManager79:
	CALL        _State6+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,530 :: 		case 7: State7(); break;
L_StateManager80:
	CALL        _State7+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,532 :: 		case 8: State8(); break;
L_StateManager81:
	CALL        _State8+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,534 :: 		case 10:State00(); break;
L_StateManager82:
	CALL        _State00+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,536 :: 		case 100:Menu0(); break;
L_StateManager83:
	CALL        _Menu0+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,538 :: 		case 101:Menu1(); break;
L_StateManager84:
	CALL        _Menu1+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,540 :: 		case 102:Menu2(); break;
L_StateManager85:
	CALL        _Menu2+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,542 :: 		case 103:Menu3(); break;
L_StateManager86:
	CALL        _Menu3+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,544 :: 		case 200:LearnAuto(); break;
L_StateManager87:
	CALL        _LearnAuto+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,546 :: 		case 201:LearnManual(); break;
L_StateManager88:
	CALL        _LearnManual+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,548 :: 		case 250:About(); break;
L_StateManager89:
	CALL        _About+0, 0
	GOTO        L_StateManager72
;FirmV_0_7_0.c,550 :: 		}
L_StateManager71:
	MOVF        _State+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager73
	MOVF        _State+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager74
	MOVF        _State+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager75
	MOVF        _State+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager76
	MOVF        _State+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager77
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager78
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager79
	MOVF        _State+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager80
	MOVF        _State+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager81
	MOVF        _State+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager82
	MOVF        _State+0, 0 
	XORLW       100
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager83
	MOVF        _State+0, 0 
	XORLW       101
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager84
	MOVF        _State+0, 0 
	XORLW       102
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager85
	MOVF        _State+0, 0 
	XORLW       103
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager86
	MOVF        _State+0, 0 
	XORLW       200
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager87
	MOVF        _State+0, 0 
	XORLW       201
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager88
	MOVF        _State+0, 0 
	XORLW       250
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager89
L_StateManager72:
;FirmV_0_7_0.c,551 :: 		}
L_end_StateManager:
	RETURN      0
; end of _StateManager

_StateTest:

;FirmV_0_7_0.c,555 :: 		void StateTest()
;FirmV_0_7_0.c,557 :: 		if (Events.Photocell==1)
	MOVF        _Events+6, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StateTest90
;FirmV_0_7_0.c,558 :: 		LCDLine1[0]='1';
	MOVLW       49
	MOVWF       _LCDLine1+0 
	GOTO        L_StateTest91
L_StateTest90:
;FirmV_0_7_0.c,560 :: 		LCDLine1[0]='0';
	MOVLW       48
	MOVWF       _LCDLine1+0 
L_StateTest91:
;FirmV_0_7_0.c,562 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,564 :: 		}
L_end_StateTest:
	RETURN      0
; end of _StateTest

_State00:

;FirmV_0_7_0.c,568 :: 		void State00()
;FirmV_0_7_0.c,573 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,574 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,575 :: 		StartMotor(1,_Close);
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,576 :: 		StartMotor(2,_Close);
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,578 :: 		if(Events.Remote.b0==1)
	BTFSS       _Events+4, 0 
	GOTO        L_State0092
;FirmV_0_7_0.c,579 :: 		{Flasher=0;FlashFlag=0;StopMotor(1);StopMotor(2);
	BCF         PORTD+0, 7 
	CLRF        _FlashFlag+0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,580 :: 		State=1;                }
	MOVLW       1
	MOVWF       _State+0 
L_State0092:
;FirmV_0_7_0.c,581 :: 		}
L_end_State00:
	RETURN      0
; end of _State00

_State1:

;FirmV_0_7_0.c,590 :: 		void State1()
;FirmV_0_7_0.c,592 :: 		char delay=3;
	MOVLW       3
	MOVWF       State1_delay_L0+0 
	CLRF        State1_AutoCloseTemp_L0+0 
	CLRF        State1_AutoCloseTemp_L0+1 
	CLRF        State1_AutoCloseTemp_L0+2 
	CLRF        State1_AutoCloseTemp_L0+3 
;FirmV_0_7_0.c,594 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,595 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,597 :: 		if(Events.Keys==2)
	MOVF        _Events+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State193
;FirmV_0_7_0.c,598 :: 		{State=100;MenuPointer=0;}
	MOVLW       100
	MOVWF       _State+0 
	CLRF        _MenuPointer+0 
L_State193:
;FirmV_0_7_0.c,600 :: 		ActiveDoors=3-Events.Remote;
	MOVF        _Events+4, 0 
	SUBLW       3
	MOVWF       _ActiveDoors+0 
;FirmV_0_7_0.c,604 :: 		if(Events.Remote!=0)
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State194
;FirmV_0_7_0.c,607 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,608 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,609 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,610 :: 		AddTask(ms500+1,12); // Unlock
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
;FirmV_0_7_0.c,611 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,612 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,613 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State195
;FirmV_0_7_0.c,614 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
	GOTO        L_State196
L_State195:
;FirmV_0_7_0.c,616 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
L_State196:
;FirmV_0_7_0.c,617 :: 		temp=ms500+OpenSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,618 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,619 :: 		temp=ms500+OpenSoftStartTime+delay;
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
;FirmV_0_7_0.c,620 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,621 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State197
;FirmV_0_7_0.c,622 :: 		{temp=ms500+Door1OpenTime-OpenSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
L_State197:
;FirmV_0_7_0.c,623 :: 		temp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,624 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,625 :: 		AutoCloseTemp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,627 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State1100
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State1100
L__State1876:
;FirmV_0_7_0.c,629 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,630 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,631 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State1101
;FirmV_0_7_0.c,632 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,8); M2isSlow=1;}//speed down
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
	GOTO        L_State1102
L_State1101:
;FirmV_0_7_0.c,634 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,6); M2isSlow=0;}//speed up
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
L_State1102:
;FirmV_0_7_0.c,635 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,636 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,637 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+delay;
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
;FirmV_0_7_0.c,638 :: 		AddTask(temp,6);//Speed up after soft start
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
;FirmV_0_7_0.c,639 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State1103
;FirmV_0_7_0.c,640 :: 		{temp=ms500+ActionTimeDiff+Door2OpenTime-OpenSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
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
L_State1103:
;FirmV_0_7_0.c,641 :: 		temp=ms500+Door2OpenTime+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,642 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,643 :: 		AutoCloseTemp=ms500+Door2OpenTime+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,644 :: 		}
L_State1100:
;FirmV_0_7_0.c,646 :: 		if(AutoCloseTime!=0)
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State11011
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State11011:
	BTFSC       STATUS+0, 2 
	GOTO        L_State1104
;FirmV_0_7_0.c,647 :: 		{AutoClosePauseFlag=0; temp=AutoCloseTemp+AutoCloseTime;AddTask(temp,9);}
	CLRF        _AutoClosePauseFlag+0 
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
L_State1104:
;FirmV_0_7_0.c,649 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,650 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,651 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,652 :: 		KeyNoiseEliminator=0;
	CLRF        _KeyNoiseEliminator+0 
;FirmV_0_7_0.c,653 :: 		State=3;
	MOVLW       3
	MOVWF       _State+0 
;FirmV_0_7_0.c,654 :: 		AutoClosePauseFlag=0;
	CLRF        _AutoClosePauseFlag+0 
;FirmV_0_7_0.c,655 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,656 :: 		}
L_State194:
;FirmV_0_7_0.c,657 :: 		}
L_end_State1:
	RETURN      0
; end of _State1

_State2:

;FirmV_0_7_0.c,671 :: 		void State2()
;FirmV_0_7_0.c,673 :: 		char delay=2;
	MOVLW       2
	MOVWF       State2_delay_L0+0 
;FirmV_0_7_0.c,675 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,676 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,679 :: 		if(ReturnAutoclose()!=PrevAC)
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	XORWF       _PrevAC+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_State2105
;FirmV_0_7_0.c,681 :: 		LCDFlashFlag=0;
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,682 :: 		PrevAC=ReturnAutoclose();
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	MOVWF       _PrevAC+0 
;FirmV_0_7_0.c,683 :: 		charValueToStr_AC(PrevAC,LCDLine2+11);
	MOVF        R0, 0 
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       _LCDLine2+11
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       hi_addr(_LCDLine2+11)
	MOVWF       FARG_charValueToStr_AC+1 
	CALL        _charValueToStr_AC+0, 0
;FirmV_0_7_0.c,684 :: 		memcpy(LCDLine2,"Close after",11);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr4_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr4_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       11
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,685 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,686 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,687 :: 		}
L_State2105:
;FirmV_0_7_0.c,690 :: 		if((Events.Remote!=0)||(CheckTask(9)))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State2881
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2881
	GOTO        L_State2108
L__State2881:
;FirmV_0_7_0.c,693 :: 		ClearTasks(0);
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,694 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State2880
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State2880
	GOTO        L_State2111
L__State2880:
;FirmV_0_7_0.c,696 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,697 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,698 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2112
;FirmV_0_7_0.c,699 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
	GOTO        L_State2113
L_State2112:
;FirmV_0_7_0.c,701 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
L_State2113:
;FirmV_0_7_0.c,702 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,703 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,704 :: 		temp=ms500+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,705 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,706 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2114
;FirmV_0_7_0.c,707 :: 		{temp=ms500+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
L_State2114:
;FirmV_0_7_0.c,708 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2115
;FirmV_0_7_0.c,709 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
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
	GOTO        L_State2116
L_State2115:
;FirmV_0_7_0.c,711 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,3);}
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
L_State2116:
;FirmV_0_7_0.c,713 :: 		}
L_State2111:
;FirmV_0_7_0.c,715 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2119
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State2119
L__State2879:
;FirmV_0_7_0.c,717 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,718 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,719 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2120
;FirmV_0_7_0.c,720 :: 		{AddTask(temp,8); M2isSlow=1;}//speed down
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
	GOTO        L_State2121
L_State2120:
;FirmV_0_7_0.c,722 :: 		{AddTask(temp,6); M2isSlow=0;}//speed up
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
L_State2121:
;FirmV_0_7_0.c,723 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,724 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,725 :: 		temp=ms500+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,726 :: 		AddTask(temp,6);//Speed up after soft start
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
;FirmV_0_7_0.c,727 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2122
;FirmV_0_7_0.c,728 :: 		{temp=ms500+Door2CloseTime-CloseSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
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
L_State2122:
;FirmV_0_7_0.c,730 :: 		temp=ms500+Door2CloseTime+delay;
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
;FirmV_0_7_0.c,731 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,735 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,736 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,737 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2123
;FirmV_0_7_0.c,738 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
	GOTO        L_State2124
L_State2123:
;FirmV_0_7_0.c,740 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
L_State2124:
;FirmV_0_7_0.c,741 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,742 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,743 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,744 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,745 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2125
;FirmV_0_7_0.c,746 :: 		{temp=ms500+ActionTimeDiff+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
L_State2125:
;FirmV_0_7_0.c,747 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State2126
;FirmV_0_7_0.c,748 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
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
	GOTO        L_State2127
L_State2126:
;FirmV_0_7_0.c,750 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,3);}
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
L_State2127:
;FirmV_0_7_0.c,752 :: 		}
L_State2119:
;FirmV_0_7_0.c,755 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,756 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,757 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,758 :: 		KeyNoiseEliminator=0;
	CLRF        _KeyNoiseEliminator+0 
;FirmV_0_7_0.c,759 :: 		AutoClosePauseFlag=0;
	CLRF        _AutoClosePauseFlag+0 
;FirmV_0_7_0.c,760 :: 		State=4;
	MOVLW       4
	MOVWF       _State+0 
;FirmV_0_7_0.c,761 :: 		}
L_State2108:
;FirmV_0_7_0.c,763 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State2130
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State21013
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State21013:
	BTFSC       STATUS+0, 2 
	GOTO        L_State2130
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State2130
L__State2878:
;FirmV_0_7_0.c,764 :: 		{PassFlag=1;AutoClosePauseFlag=1;Logger("S2 Auto Close Paused",1);}
	MOVLW       1
	MOVWF       _PassFlag+0 
	MOVLW       1
	MOVWF       _AutoClosePauseFlag+0 
	MOVLW       ?lstr5_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr5_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State2130:
;FirmV_0_7_0.c,767 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State2133
	BTFSC       _Events+6, 0 
	GOTO        L_State2133
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State21014
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State21014:
	BTFSC       STATUS+0, 2 
	GOTO        L_State2133
L__State2877:
;FirmV_0_7_0.c,768 :: 		if(CloseAfterPass==0)
	MOVF        _CloseAfterPass+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State2134
;FirmV_0_7_0.c,769 :: 		{PassFlag=0;AutoClosePauseFlag=0;Logger("S2 Auto Close Resumed",1);}
	CLRF        _PassFlag+0 
	CLRF        _AutoClosePauseFlag+0 
	MOVLW       ?lstr6_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr6_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	GOTO        L_State2135
L_State2134:
;FirmV_0_7_0.c,771 :: 		{_AC=GetAutocloseTime();AutoClosePauseFlag=0;temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:",1);Logger(t,1);}
	CALL        _GetAutocloseTime+0, 0
	MOVF        R0, 0 
	MOVWF       __AC+0 
	CLRF        _AutoClosePauseFlag+0 
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
	MOVLW       ?lstr7_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr7_FirmV_0_7_0+0)
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
L_State2135:
L_State2133:
;FirmV_0_7_0.c,773 :: 		}
L_end_State2:
	RETURN      0
; end of _State2

_State3:

;FirmV_0_7_0.c,788 :: 		void State3()
;FirmV_0_7_0.c,790 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,791 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,793 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3136
;FirmV_0_7_0.c,794 :: 		{StartMotor(1,_Open);Logger("S3 Motor1Start",1); Lock=0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       1
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
L_State3136:
;FirmV_0_7_0.c,796 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3137
;FirmV_0_7_0.c,797 :: 		{StartMotor(2,_Open);Logger("S3 Motor2Start",1); Lock=0;}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       ?lstr9_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr9_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	BCF         PORTD+0, 6 
L_State3137:
;FirmV_0_7_0.c,799 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3138
;FirmV_0_7_0.c,800 :: 		{SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;Logger("S3 Motor1 Fast",1);}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _M1isSlow+0 
	MOVLW       ?lstr10_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr10_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3138:
;FirmV_0_7_0.c,802 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3139
;FirmV_0_7_0.c,803 :: 		{SetMotorSpeed(0,Motor2FullSpeed); M1isSlow=1;Logger("S3 Motor1 Slow",1);}
	CLRF        FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
	MOVLW       ?lstr11_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr11_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3139:
;FirmV_0_7_0.c,805 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3140
;FirmV_0_7_0.c,806 :: 		{SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;Logger("S3 Motor2 Fast",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag2+0 
	CLRF        _M2isSlow+0 
	MOVLW       ?lstr12_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr12_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3140:
;FirmV_0_7_0.c,808 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3141
;FirmV_0_7_0.c,809 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S3 Motor2 Slow",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CLRF        FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	MOVLW       ?lstr13_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr13_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3141:
;FirmV_0_7_0.c,811 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3142
;FirmV_0_7_0.c,812 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S3 Overflow Flag1 Set",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr14_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr14_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3142:
;FirmV_0_7_0.c,814 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3143
;FirmV_0_7_0.c,815 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S3 Overflow Flag2 Set",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr15_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr15_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3143:
;FirmV_0_7_0.c,817 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3144
;FirmV_0_7_0.c,818 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S3 Motor1 Stop",1);}
	BCF         _OpenDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr16_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr16_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3144:
;FirmV_0_7_0.c,820 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3145
;FirmV_0_7_0.c,821 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S3 Motor2 Stop",1);}
	BCF         _OpenDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr17_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr17_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3145:
;FirmV_0_7_0.c,823 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3146
;FirmV_0_7_0.c,824 :: 		{Lock=1;}
	BSF         PORTD+0, 6 
L_State3146:
;FirmV_0_7_0.c,826 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3149
	BTFSS       _Events+5, 0 
	GOTO        L_State3149
	MOVF        _M1isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3149
L__State3887:
;FirmV_0_7_0.c,827 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor1 Collision",1);ClearTasks(9);
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
;FirmV_0_7_0.c,828 :: 		memcpy(LCDLine1,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State3149:
;FirmV_0_7_0.c,830 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3152
	BTFSS       _Events+5, 1 
	GOTO        L_State3152
	MOVF        _M2isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3152
L__State3886:
;FirmV_0_7_0.c,831 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor2 Collision",1);ClearTasks(9);
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
;FirmV_0_7_0.c,832 :: 		memcpy(LCDLine1,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State3152:
;FirmV_0_7_0.c,834 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State3885
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State3885
	GOTO        L_State3155
L__State3885:
;FirmV_0_7_0.c,835 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State3155:
;FirmV_0_7_0.c,837 :: 		if(KeyNoiseEliminator>=NoiseEliminatorTreshold)
	MOVLW       3
	SUBWF       _KeyNoiseEliminator+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_State3156
;FirmV_0_7_0.c,840 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State3159
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3159
L__State3884:
;FirmV_0_7_0.c,841 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Photocell Int",1);ClearTasks(9);
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
;FirmV_0_7_0.c,842 :: 		memcpy(LCDLine1,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State3159:
;FirmV_0_7_0.c,844 :: 		if(Events.Remote!=0)
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State3160
;FirmV_0_7_0.c,845 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Remote Stoped",1);ClearTasks(9);
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
;FirmV_0_7_0.c,846 :: 		memcpy(LCDLine1,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State3160:
;FirmV_0_7_0.c,848 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3163
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3163
L__State3883:
;FirmV_0_7_0.c,849 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Limit Switch Stoped",1);ClearTasks(9);
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
	MOVLW       ?lstr22_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr22_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,850 :: 		memcpy(LCDLine1,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State3163:
;FirmV_0_7_0.c,851 :: 		}
L_State3156:
;FirmV_0_7_0.c,853 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3164
;FirmV_0_7_0.c,854 :: 		if(ReverseOnOpen)
	MOVF        _ReverseOnOpen+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3165
;FirmV_0_7_0.c,855 :: 		{StartMotor(1,_Close);StartMotor(2,_Close);SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;
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
;FirmV_0_7_0.c,856 :: 		AddTask(ms500+RelaseTime,3);AddTask(ms500+RelaseTime,4);AddTask(ms500+1+RelaseTime,13);OpenDone.b2=1;}
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
	GOTO        L_State3166
L_State3165:
;FirmV_0_7_0.c,858 :: 		{AddTask(ms500+1,13);OpenDone.b2=1;}
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
L_State3166:
L_State3164:
;FirmV_0_7_0.c,860 :: 		if(CheckTask(13))
	MOVLW       13
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3167
;FirmV_0_7_0.c,861 :: 		{State=2; PrevAC=0;PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_blank,16);LCDUpdateFlag=1;LCDLines=1;}
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State3167:
;FirmV_0_7_0.c,863 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State3882
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State3882
	GOTO        L_State3170
L__State3882:
;FirmV_0_7_0.c,864 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);AutoClosePauseFlag=0;PrevAC=0;Logger("S3 Autoclose Renewed",1);}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State31016
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State31016:
	BTFSC       STATUS+0, 2 
	GOTO        L_State3171
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
	CLRF        _AutoClosePauseFlag+0 
	CLRF        _PrevAC+0 
	MOVLW       ?lstr23_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr23_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State3171:
L_State3170:
;FirmV_0_7_0.c,866 :: 		}
L_end_State3:
	RETURN      0
; end of _State3

_State4:

;FirmV_0_7_0.c,880 :: 		void State4()
;FirmV_0_7_0.c,882 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,883 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,886 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4172
;FirmV_0_7_0.c,887 :: 		{StartMotor(1,_Close);Logger("S4 Motor1Start",1);}
	MOVLW       1
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
L_State4172:
;FirmV_0_7_0.c,889 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4173
;FirmV_0_7_0.c,890 :: 		{StartMotor(2,_Close);Logger("S4 Motor2Start",1);memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       ?lstr25_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr25_FirmV_0_7_0+0)
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
L_State4173:
;FirmV_0_7_0.c,892 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4174
;FirmV_0_7_0.c,893 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S4 M1 Overload Check",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr26_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr26_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4174:
;FirmV_0_7_0.c,895 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4175
;FirmV_0_7_0.c,896 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S4 M2 Overload Check",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr27_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr27_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4175:
;FirmV_0_7_0.c,898 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4176
;FirmV_0_7_0.c,899 :: 		{SetMotorSpeed(1,Motor2FullSpeed); OverloadCheckFlag1=0; M1isSlow=0;Logger("S4 M1 Speed UP",1);}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _M1isSlow+0 
	MOVLW       ?lstr28_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr28_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4176:
;FirmV_0_7_0.c,901 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4177
;FirmV_0_7_0.c,902 :: 		{SetMotorSpeed(0,Motor2FullSpeed); OverloadCheckFlag1=0; M1isSlow=1;Logger("S4 M1 Speed Down",1);}
	CLRF        FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       _M1isSlow+0 
	MOVLW       ?lstr29_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr29_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4177:
;FirmV_0_7_0.c,904 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4178
;FirmV_0_7_0.c,905 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S4 M2 Speed UP",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       ?lstr30_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr30_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4178:
;FirmV_0_7_0.c,907 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4179
;FirmV_0_7_0.c,908 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S4 M2 Speed Down",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CLRF        FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	MOVLW       ?lstr31_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr31_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4179:
;FirmV_0_7_0.c,910 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4180
;FirmV_0_7_0.c,911 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S4 M1 Stoped",1);}
	BCF         _CloseDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr32_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr32_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4180:
;FirmV_0_7_0.c,913 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4181
;FirmV_0_7_0.c,914 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S4 M2 Stoped",1);}
	BCF         _CloseDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr33_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr33_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4181:
;FirmV_0_7_0.c,916 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4184
	BTFSS       _Events+5, 0 
	GOTO        L_State4184
	MOVF        _M1isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4184
L__State4892:
;FirmV_0_7_0.c,917 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M1 Overloaded",1);ClearTasks(9);
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
;FirmV_0_7_0.c,918 :: 		memcpy(LCDLine1,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State4184:
;FirmV_0_7_0.c,920 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4187
	BTFSS       _Events+5, 1 
	GOTO        L_State4187
	MOVF        _M2isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4187
L__State4891:
;FirmV_0_7_0.c,921 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M2 Overloaded",1);ClearTasks(9);
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
;FirmV_0_7_0.c,922 :: 		memcpy(LCDLine1,_ErrOverload,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State4187:
;FirmV_0_7_0.c,924 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State4890
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State4890
	GOTO        L_State4190
L__State4890:
;FirmV_0_7_0.c,925 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State4190:
;FirmV_0_7_0.c,927 :: 		if(KeyNoiseEliminator>=NoiseEliminatorTreshold)
	MOVLW       3
	SUBWF       _KeyNoiseEliminator+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_State4191
;FirmV_0_7_0.c,930 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State4192
;FirmV_0_7_0.c,931 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S4 Photocell Int",1);ClearTasks(0);
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
	MOVLW       ?lstr36_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr36_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,932 :: 		memcpy(LCDLine1,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State4192:
;FirmV_0_7_0.c,934 :: 		if((Events.Limiter==2)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State4195
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4195
L__State4889:
;FirmV_0_7_0.c,935 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Limit Switch Stop",1);ClearTasks(9);
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
;FirmV_0_7_0.c,936 :: 		memcpy(LCDLine1,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State4195:
;FirmV_0_7_0.c,938 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State4196
;FirmV_0_7_0.c,939 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Remote Pressed",1);ClearTasks(9);
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
	MOVLW       ?lstr38_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr38_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,940 :: 		memcpy(LCDLine1,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State4196:
;FirmV_0_7_0.c,941 :: 		}
L_State4191:
;FirmV_0_7_0.c,944 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4197
;FirmV_0_7_0.c,945 :: 		if(ReverseOnClose)
	MOVF        _ReverseOnClose+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4198
;FirmV_0_7_0.c,946 :: 		{StartMotor(1,_Open);AddTask(ms500+1,14);SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0;M1isSlow=0;SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0;M2isSlow=0;
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
;FirmV_0_7_0.c,947 :: 		AddTask(ms500+RelaseTime,3);AddTask(ms500+1+RelaseTime,4);AddTask(ms500+1+RelaseTime,13);CloseDone.b2=1;}
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
	GOTO        L_State4199
L_State4198:
;FirmV_0_7_0.c,949 :: 		{AddTask(ms500+1,13);CloseDone.b2=1;}
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
L_State4199:
L_State4197:
;FirmV_0_7_0.c,951 :: 		if(CheckTask(14))
	MOVLW       14
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4200
;FirmV_0_7_0.c,952 :: 		StartMotor(2,_Open);
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
L_State4200:
;FirmV_0_7_0.c,954 :: 		if(CheckTask(13))
	MOVLW       13
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4201
;FirmV_0_7_0.c,955 :: 		{State=1; PassFlag=0;PrevAC=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
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
L_State4201:
;FirmV_0_7_0.c,957 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State4888
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State4888
	GOTO        L_State4204
L__State4888:
;FirmV_0_7_0.c,958 :: 		{ClearTasks(0);if(AutoCloseTime!=0){PrevAC=0;AddTask(ms500+AutoCloseTime,9);AutoClosePauseFlag=0;Logger("S4 Autoclose Renewed",1);}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State41018
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State41018:
	BTFSC       STATUS+0, 2 
	GOTO        L_State4205
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
	CLRF        _AutoClosePauseFlag+0 
	MOVLW       ?lstr39_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr39_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State4205:
L_State4204:
;FirmV_0_7_0.c,960 :: 		}
L_end_State4:
	RETURN      0
; end of _State4

_State5:

;FirmV_0_7_0.c,975 :: 		void State5()
;FirmV_0_7_0.c,977 :: 		char delay=2;
	MOVLW       2
	MOVWF       State5_delay_L0+0 
;FirmV_0_7_0.c,978 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,979 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,981 :: 		if(ReturnAutoclose()!=PrevAC)
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	XORWF       _PrevAC+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_State5206
;FirmV_0_7_0.c,983 :: 		LCDFlashFlag=0;
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,984 :: 		PrevAC=ReturnAutoclose();
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	MOVWF       _PrevAC+0 
;FirmV_0_7_0.c,985 :: 		charValueToStr_AC(PrevAC,LCDLine2+11);
	MOVF        R0, 0 
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       _LCDLine2+11
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       hi_addr(_LCDLine2+11)
	MOVWF       FARG_charValueToStr_AC+1 
	CALL        _charValueToStr_AC+0, 0
;FirmV_0_7_0.c,986 :: 		memcpy(LCDLine2,"Close after",11);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr40_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr40_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       11
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,987 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,988 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,989 :: 		}
L_State5206:
;FirmV_0_7_0.c,991 :: 		if((Events.Remote!=0)||(CheckTask(9)==1))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State5897
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5897
	GOTO        L_State5209
L__State5897:
;FirmV_0_7_0.c,993 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State5896
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5896
	GOTO        L_State5212
L__State5896:
;FirmV_0_7_0.c,995 :: 		ClearTasks(0);
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,996 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,997 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,998 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,999 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,1000 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,1001 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,1002 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,1003 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,1004 :: 		}
L_State5212:
;FirmV_0_7_0.c,1005 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State5215
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State5215
L__State5895:
;FirmV_0_7_0.c,1007 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1008 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,1009 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,1010 :: 		AddTask(temp,6);
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
;FirmV_0_7_0.c,1011 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,1012 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,1013 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,1014 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,1015 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,1020 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,1021 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,1022 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,1023 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,1024 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,1025 :: 		temp=ms500+ActionTimeDiff+OverloadDelay+delay;
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
;FirmV_0_7_0.c,1027 :: 		temp=ms500+Door2CloseTime+delay+ActionTimeDiff;
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
;FirmV_0_7_0.c,1029 :: 		}
L_State5215:
;FirmV_0_7_0.c,1030 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,1031 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,1032 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,1033 :: 		KeyNoiseEliminator=0;
	CLRF        _KeyNoiseEliminator+0 
;FirmV_0_7_0.c,1034 :: 		AutoClosePauseFlag=0;
	CLRF        _AutoClosePauseFlag+0 
;FirmV_0_7_0.c,1035 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,1036 :: 		}
L_State5209:
;FirmV_0_7_0.c,1038 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State5218
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State51020
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State51020:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5218
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State5218
L__State5894:
;FirmV_0_7_0.c,1039 :: 		{PassFlag=1; AutoClosePauseFlag=1;Logger("S5 Auto Close Paused",1);}
	MOVLW       1
	MOVWF       _PassFlag+0 
	MOVLW       1
	MOVWF       _AutoClosePauseFlag+0 
	MOVLW       ?lstr41_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr41_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State5218:
;FirmV_0_7_0.c,1041 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State5221
	BTFSC       _Events+6, 0 
	GOTO        L_State5221
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State51021
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State51021:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5221
L__State5893:
;FirmV_0_7_0.c,1044 :: 		{AutoClosePauseFlag=0;PassFlag=0;Logger("S5 Auto Close Resumed",1);}
	CLRF        _AutoClosePauseFlag+0 
	CLRF        _PassFlag+0 
	MOVLW       ?lstr42_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr42_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,1045 :: 		}
L_State5221:
;FirmV_0_7_0.c,1047 :: 		}
L_end_State5:
	RETURN      0
; end of _State5

_State6:

;FirmV_0_7_0.c,1067 :: 		void State6()
;FirmV_0_7_0.c,1071 :: 		char delay=3;
	MOVLW       3
	MOVWF       State6_delay_L0+0 
;FirmV_0_7_0.c,1072 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,1073 :: 		FlashFlag=0;
	CLRF        _FlashFlag+0 
;FirmV_0_7_0.c,1075 :: 		if(ReturnAutoclose()!=PrevAC)
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	XORWF       _PrevAC+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_State6223
;FirmV_0_7_0.c,1077 :: 		LCDFlashFlag=0;
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,1078 :: 		PrevAC=ReturnAutoclose();
	CALL        _ReturnAutoclose+0, 0
	MOVF        R0, 0 
	MOVWF       _PrevAC+0 
;FirmV_0_7_0.c,1079 :: 		charValueToStr_AC(PrevAC,LCDLine2+11);
	MOVF        R0, 0 
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       _LCDLine2+11
	MOVWF       FARG_charValueToStr_AC+0 
	MOVLW       hi_addr(_LCDLine2+11)
	MOVWF       FARG_charValueToStr_AC+1 
	CALL        _charValueToStr_AC+0, 0
;FirmV_0_7_0.c,1080 :: 		memcpy(LCDLine2,"Close after",11);
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
;FirmV_0_7_0.c,1081 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1082 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,1083 :: 		}
L_State6223:
;FirmV_0_7_0.c,1086 :: 		if((Events.Remote!=0)||(PhotocellOpenFlag))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State6903
	MOVF        _PhotocellOpenFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6903
	GOTO        L_State6226
L__State6903:
;FirmV_0_7_0.c,1088 :: 		PhotocellOpenFlag=0;
	CLRF        _PhotocellOpenFlag+0 
;FirmV_0_7_0.c,1089 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,1090 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,1091 :: 		ClearTasks(0);
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1092 :: 		AddTask(ms500+1,12);//Unlock
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
;FirmV_0_7_0.c,1093 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,1094 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,1095 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,1096 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,1097 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,1098 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,1099 :: 		temp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,1100 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,1101 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6229
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6229
L__State6902:
;FirmV_0_7_0.c,1103 :: 		AddTask(ms500+ActionTimeDiff+delay,2);
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
;FirmV_0_7_0.c,1104 :: 		AddTask(ms500+ActionTimeDiff+delay,6);
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
;FirmV_0_7_0.c,1105 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,1106 :: 		AddTask(ms500+ActionTimeDiff+OverloadDelay+delay,11); //overload check
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
;FirmV_0_7_0.c,1107 :: 		AddTask(ms500+Door2OpenTime+ActionTimeDiff+delay,4);//Stop motor
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
;FirmV_0_7_0.c,1108 :: 		}
L_State6229:
;FirmV_0_7_0.c,1111 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,1112 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,1113 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,1114 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,1115 :: 		KeyNoiseEliminator=0;
	CLRF        _KeyNoiseEliminator+0 
;FirmV_0_7_0.c,1116 :: 		AutoClosePauseFlag=0;
	CLRF        _AutoClosePauseFlag+0 
;FirmV_0_7_0.c,1117 :: 		State=8;
	MOVLW       8
	MOVWF       _State+0 
;FirmV_0_7_0.c,1118 :: 		}
L_State6226:
;FirmV_0_7_0.c,1121 :: 		if(CheckTask(9)==1)
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6230
;FirmV_0_7_0.c,1123 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State6901
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State6901
	GOTO        L_State6233
L__State6901:
;FirmV_0_7_0.c,1125 :: 		ClearTasks(0);
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1126 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,1127 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,1128 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,1129 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,1130 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,1131 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,1132 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,1133 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,1134 :: 		}
L_State6233:
;FirmV_0_7_0.c,1135 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6236
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6236
L__State6900:
;FirmV_0_7_0.c,1137 :: 		ClearTasks(0);
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1138 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,1139 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,1140 :: 		AddTask(temp,6);
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
;FirmV_0_7_0.c,1141 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,1142 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,1143 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,1144 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,1145 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,1150 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,1151 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,1152 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,1153 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,1154 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,1155 :: 		temp=ms500+ActionTimeDiff+OverloadDelay+delay;
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
;FirmV_0_7_0.c,1156 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,1157 :: 		temp=ms500+Door2CloseTime+delay+ActionTimeDiff;
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
;FirmV_0_7_0.c,1158 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,1159 :: 		}
L_State6236:
;FirmV_0_7_0.c,1160 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,1161 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,1162 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,1163 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,1164 :: 		KeyNoiseEliminator=0;
	CLRF        _KeyNoiseEliminator+0 
;FirmV_0_7_0.c,1165 :: 		AutoClosePauseFlag=0;
	CLRF        _AutoClosePauseFlag+0 
;FirmV_0_7_0.c,1166 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,1167 :: 		}
L_State6230:
;FirmV_0_7_0.c,1169 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State6239
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State61023
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State61023:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6239
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State6239
L__State6899:
;FirmV_0_7_0.c,1170 :: 		{PassFlag=1; AutoClosePauseFlag=1;Logger("S6 Auto Close Paused",1);}
	MOVLW       1
	MOVWF       _PassFlag+0 
	MOVLW       1
	MOVWF       _AutoClosePauseFlag+0 
	MOVLW       ?lstr44_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr44_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State6239:
;FirmV_0_7_0.c,1172 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6242
	BTFSC       _Events+6, 0 
	GOTO        L_State6242
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State61024
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State61024:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6242
L__State6898:
;FirmV_0_7_0.c,1174 :: 		{AutoClosePauseFlag=0;PassFlag=0;Logger("S6 Auto Close Resumed",1);}
	CLRF        _AutoClosePauseFlag+0 
	CLRF        _PassFlag+0 
	MOVLW       ?lstr45_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr45_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,1175 :: 		}
L_State6242:
;FirmV_0_7_0.c,1177 :: 		}
L_end_State6:
	RETURN      0
; end of _State6

_State7:

;FirmV_0_7_0.c,1199 :: 		void State7()
;FirmV_0_7_0.c,1201 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,1202 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,1204 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7244
;FirmV_0_7_0.c,1205 :: 		{StartMotor(1,_Close);Logger("S7 Motor1Start",1);}
	MOVLW       1
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
L_State7244:
;FirmV_0_7_0.c,1207 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7245
;FirmV_0_7_0.c,1208 :: 		{StartMotor(2,_Close);Logger("S7 Motor2Start",1);memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       2
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
L_State7245:
;FirmV_0_7_0.c,1210 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7246
;FirmV_0_7_0.c,1211 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S7 M1 Overload Check",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr48_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr48_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7246:
;FirmV_0_7_0.c,1213 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7247
;FirmV_0_7_0.c,1214 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S7 M2 Overload Check",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr49_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr49_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7247:
;FirmV_0_7_0.c,1216 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7248
;FirmV_0_7_0.c,1217 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S7 M1 Speed UP",1);}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
	MOVLW       ?lstr50_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr50_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7248:
;FirmV_0_7_0.c,1219 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7249
;FirmV_0_7_0.c,1220 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S7 M2 Speed UP",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       ?lstr51_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr51_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7249:
;FirmV_0_7_0.c,1222 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(CloseDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7911
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7912
	BTFSS       _Events+5, 0 
	GOTO        L__State7912
	GOTO        L__State7911
L__State7912:
	GOTO        L_State7256
L__State7911:
	BTFSS       _CloseDone+0, 0 
	GOTO        L_State7256
L__State7910:
;FirmV_0_7_0.c,1223 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S7 M1 Stoped",1);}
	BCF         _CloseDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr52_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr52_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7256:
;FirmV_0_7_0.c,1225 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(CloseDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7908
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7909
	BTFSS       _Events+5, 1 
	GOTO        L__State7909
	GOTO        L__State7908
L__State7909:
	GOTO        L_State7263
L__State7908:
	BTFSS       _CloseDone+0, 1 
	GOTO        L_State7263
L__State7907:
;FirmV_0_7_0.c,1226 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S7 M2 Stoped",1);}
	BCF         _CloseDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr53_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr53_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7263:
;FirmV_0_7_0.c,1228 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State7906
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State7906
	GOTO        L_State7266
L__State7906:
;FirmV_0_7_0.c,1229 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State7266:
;FirmV_0_7_0.c,1232 :: 		if(KeyNoiseEliminator>=NoiseEliminatorTreshold)
	MOVLW       3
	SUBWF       _KeyNoiseEliminator+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_State7267
;FirmV_0_7_0.c,1234 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State7268
;FirmV_0_7_0.c,1235 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S7 Photocell Int",1);ClearTasks(9);
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
;FirmV_0_7_0.c,1236 :: 		memcpy(LCDLine1,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State7268:
;FirmV_0_7_0.c,1238 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State7269
;FirmV_0_7_0.c,1239 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Remote Pressed",1);ClearTasks(9);
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
;FirmV_0_7_0.c,1240 :: 		memcpy(LCDLine1,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State7269:
;FirmV_0_7_0.c,1242 :: 		if((Events.Limiter==2)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State7272
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7272
L__State7905:
;FirmV_0_7_0.c,1243 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Limit Switch Stop",1);ClearTasks(9);
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
;FirmV_0_7_0.c,1244 :: 		memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=1;}
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State7272:
;FirmV_0_7_0.c,1245 :: 		}
L_State7267:
;FirmV_0_7_0.c,1248 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State7273
;FirmV_0_7_0.c,1249 :: 		if(ReverseOnClose)
	MOVF        _ReverseOnClose+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7274
;FirmV_0_7_0.c,1250 :: 		{StartMotor(1,_Open);AddTask(ms500+1,14);SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;
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
;FirmV_0_7_0.c,1251 :: 		AddTask(ms500+RelaseTime,3);AddTask(ms500+1+RelaseTime,4);AddTask(ms500+1+RelaseTime,13);CloseDone.b2=1;}
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
	GOTO        L_State7275
L_State7274:
;FirmV_0_7_0.c,1253 :: 		{AddTask(ms500+1,13);CloseDone.b2=1;}
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
L_State7275:
L_State7273:
;FirmV_0_7_0.c,1255 :: 		if(CheckTask(14))
	MOVLW       14
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7276
;FirmV_0_7_0.c,1256 :: 		StartMotor(2,_Open);
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
L_State7276:
;FirmV_0_7_0.c,1258 :: 		if(CheckTask(13))
	MOVLW       13
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7277
;FirmV_0_7_0.c,1259 :: 		{State=1; PassFlag=0;PrevAC=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
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
L_State7277:
;FirmV_0_7_0.c,1261 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State7904
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State7904
	GOTO        L_State7280
L__State7904:
;FirmV_0_7_0.c,1262 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);AutoClosePauseFlag=0;PrevAC=0;Logger("S7 Autoclose Renewed",1);}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State71026
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State71026:
	BTFSC       STATUS+0, 2 
	GOTO        L_State7281
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
	CLRF        _AutoClosePauseFlag+0 
	CLRF        _PrevAC+0 
	MOVLW       ?lstr57_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr57_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State7281:
L_State7280:
;FirmV_0_7_0.c,1265 :: 		}
L_end_State7:
	RETURN      0
; end of _State7

_State8:

;FirmV_0_7_0.c,1282 :: 		void State8()
;FirmV_0_7_0.c,1284 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,1285 :: 		FlashFlag=1;
	MOVLW       1
	MOVWF       _FlashFlag+0 
;FirmV_0_7_0.c,1287 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8282
;FirmV_0_7_0.c,1288 :: 		{StartMotor(1,_Open);Logger("S8 Motor1Start",1); Lock=0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       1
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
L_State8282:
;FirmV_0_7_0.c,1290 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8283
;FirmV_0_7_0.c,1291 :: 		{StartMotor(2,_Open);Logger("S8 Motor2Start",1); Lock=0;}
	MOVLW       2
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
L_State8283:
;FirmV_0_7_0.c,1293 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8284
;FirmV_0_7_0.c,1294 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S8 Overflow Flag1 Set",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr60_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr60_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8284:
;FirmV_0_7_0.c,1296 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8285
;FirmV_0_7_0.c,1297 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S8 Overflow Flag2 Set",1);}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?lstr61_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr61_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8285:
;FirmV_0_7_0.c,1299 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8286
;FirmV_0_7_0.c,1300 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S8 Motor1 Fast",1);}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
	MOVLW       ?lstr62_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr62_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8286:
;FirmV_0_7_0.c,1302 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8287
;FirmV_0_7_0.c,1303 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S8 Motor2 Fast",1);}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       ?lstr63_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr63_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8287:
;FirmV_0_7_0.c,1305 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(OpenDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8921
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8922
	BTFSS       _Events+5, 0 
	GOTO        L__State8922
	GOTO        L__State8921
L__State8922:
	GOTO        L_State8294
L__State8921:
	BTFSS       _OpenDone+0, 0 
	GOTO        L_State8294
L__State8920:
;FirmV_0_7_0.c,1306 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S8 Motor1 Stop",1);}
	BCF         _OpenDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr64_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr64_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8294:
;FirmV_0_7_0.c,1308 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(OpenDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8918
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8919
	BTFSS       _Events+5, 1 
	GOTO        L__State8919
	GOTO        L__State8918
L__State8919:
	GOTO        L_State8301
L__State8918:
	BTFSS       _OpenDone+0, 1 
	GOTO        L_State8301
L__State8917:
;FirmV_0_7_0.c,1309 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S8 Motor2 Stop",1);}
	BCF         _OpenDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       ?lstr65_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr65_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8301:
;FirmV_0_7_0.c,1311 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8302
;FirmV_0_7_0.c,1312 :: 		{Lock=1;}
	BSF         PORTD+0, 6 
L_State8302:
;FirmV_0_7_0.c,1314 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State8916
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State8916
	GOTO        L_State8305
L__State8916:
;FirmV_0_7_0.c,1315 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State8305:
;FirmV_0_7_0.c,1318 :: 		if(KeyNoiseEliminator>=NoiseEliminatorTreshold)
	MOVLW       3
	SUBWF       _KeyNoiseEliminator+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_State8306
;FirmV_0_7_0.c,1320 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State8309
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8309
L__State8915:
;FirmV_0_7_0.c,1321 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S8 Photocell Int",1);ClearTasks(9);
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
;FirmV_0_7_0.c,1322 :: 		memcpy(LCDLine1,_ErrPhoto,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State8309:
;FirmV_0_7_0.c,1324 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State8310
;FirmV_0_7_0.c,1325 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Motors Stoped (Remote)",1);ClearTasks(9);
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
;FirmV_0_7_0.c,1326 :: 		memcpy(LCDLine1,_ErrRemote,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State8310:
;FirmV_0_7_0.c,1328 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State8313
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8313
L__State8914:
;FirmV_0_7_0.c,1329 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Limit Switch Stop",1);ClearTasks(9);
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
;FirmV_0_7_0.c,1330 :: 		memcpy(LCDLine1,_ErrLimit,16);LCDUpdateFlag=1;LCDLines=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State8313:
;FirmV_0_7_0.c,1331 :: 		}
L_State8306:
;FirmV_0_7_0.c,1333 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State8314
;FirmV_0_7_0.c,1335 :: 		if(AutoCloseTime!=0)
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State81028
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State81028:
	BTFSC       STATUS+0, 2 
	GOTO        L_State8315
;FirmV_0_7_0.c,1336 :: 		{AddTask(ms500+AutoCloseTime,9);}
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
L_State8315:
;FirmV_0_7_0.c,1337 :: 		if(ReverseOnOpen)
	MOVF        _ReverseOnOpen+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8316
;FirmV_0_7_0.c,1338 :: 		{StartMotor(1,_Close);StartMotor(2,_Close);SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;
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
;FirmV_0_7_0.c,1339 :: 		AddTask(ms500+RelaseTime,3);AddTask(ms500+RelaseTime,4);AddTask(ms500+1+RelaseTime,13);OpenDone.b2=1;}
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
	GOTO        L_State8317
L_State8316:
;FirmV_0_7_0.c,1341 :: 		{AddTask(ms500+1,13);OpenDone.b2=1;}
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
L_State8317:
;FirmV_0_7_0.c,1342 :: 		}
L_State8314:
;FirmV_0_7_0.c,1345 :: 		if(CheckTask(13))
	MOVLW       13
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8318
;FirmV_0_7_0.c,1346 :: 		{State=2; PassFlag=0;PrevAC=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;LCDLines=1;}
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
	MOVLW       1
	MOVWF       _LCDLines+0 
L_State8318:
;FirmV_0_7_0.c,1348 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State8913
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State8913
	GOTO        L_State8321
L__State8913:
;FirmV_0_7_0.c,1349 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);AutoClosePauseFlag=0;PrevAC=0;Logger("S8 Autoclose Renewed",1);}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State81029
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State81029:
	BTFSC       STATUS+0, 2 
	GOTO        L_State8322
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
	CLRF        _AutoClosePauseFlag+0 
	CLRF        _PrevAC+0 
	MOVLW       ?lstr69_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr69_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	MOVLW       1
	MOVWF       FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
L_State8322:
L_State8321:
;FirmV_0_7_0.c,1352 :: 		}
L_end_State8:
	RETURN      0
; end of _State8

_LCDUpdater:

;FirmV_0_7_0.c,1361 :: 		void LCDUpdater()
;FirmV_0_7_0.c,1366 :: 		if(LCDUpdateFlag==1)
	MOVF        _LCDUpdateFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDUpdater323
;FirmV_0_7_0.c,1368 :: 		if(LCDLines!=line)
	MOVF        _LCDLines+0, 0 
	XORWF       LCDUpdater_line_L0+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater324
;FirmV_0_7_0.c,1370 :: 		line=LCDLines;
	MOVF        _LCDLines+0, 0 
	MOVWF       LCDUpdater_line_L0+0 
;FirmV_0_7_0.c,1371 :: 		LCD_init(LCDLines);
	MOVF        _LCDLines+0, 0 
	MOVWF       FARG_LCD_Init+0 
	CALL        _LCD_Init+0, 0
;FirmV_0_7_0.c,1372 :: 		delay_ms(50);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_LCDUpdater325:
	DECFSZ      R13, 1, 1
	BRA         L_LCDUpdater325
	DECFSZ      R12, 1, 1
	BRA         L_LCDUpdater325
	DECFSZ      R11, 1, 1
	BRA         L_LCDUpdater325
	NOP
	NOP
;FirmV_0_7_0.c,1373 :: 		}
L_LCDUpdater324:
;FirmV_0_7_0.c,1374 :: 		lcd_out(1,0,LCDLine1);
	MOVLW       1
	MOVWF       FARG_LCD_out+0 
	CLRF        FARG_LCD_out+0 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_LCD_out+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_LCD_out+1 
	CALL        _LCD_out+0, 0
;FirmV_0_7_0.c,1375 :: 		if(!LCDFlash)
	MOVF        _LCDFlash+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDUpdater326
;FirmV_0_7_0.c,1376 :: 		lcd_out(2,0,LCDLine2);
	MOVLW       2
	MOVWF       FARG_LCD_out+0 
	CLRF        FARG_LCD_out+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_LCD_out+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_LCD_out+1 
	CALL        _LCD_out+0, 0
	GOTO        L_LCDUpdater327
L_LCDUpdater326:
;FirmV_0_7_0.c,1378 :: 		UpdateWhenFlashing=1;
	MOVLW       1
	MOVWF       LCDUpdater_UpdateWhenFlashing_L0+0 
L_LCDUpdater327:
;FirmV_0_7_0.c,1379 :: 		LCDUpdateFlag=0;
	CLRF        _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1380 :: 		LCDTimeout=120;
	MOVLW       120
	MOVWF       _LCDTimeout+0 
;FirmV_0_7_0.c,1381 :: 		}
L_LCDUpdater323:
;FirmV_0_7_0.c,1383 :: 		if(LCDFlash)
	MOVF        _LCDFlash+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater328
;FirmV_0_7_0.c,1385 :: 		if(((LCDFlashFlag)&&(LastLCDFlashState==0))||((LastLCDFlashState)&&(UpdatewhenFlashing)))
	MOVF        _LCDFlashFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater928
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__LCDUpdater928
	GOTO        L__LCDUpdater926
L__LCDUpdater928:
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater927
	MOVF        LCDUpdater_UpdateWhenFlashing_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater927
	GOTO        L__LCDUpdater926
L__LCDUpdater927:
	GOTO        L_LCDUpdater335
L__LCDUpdater926:
;FirmV_0_7_0.c,1386 :: 		{memcpy(LCDLineTemp,LCDLine2,16);LCDLineTemp[0]='>';LCDLineTemp[1]='>';LCDLineTemp[2]='>';LCDLineTemp[13]='<';LCDLineTemp[14]='<';LCDLineTemp[15]='<';lcd_out(2,0,LCDLineTemp);LastLCDFlashState=1;UpdatewhenFlashing=0;}
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
L_LCDUpdater335:
;FirmV_0_7_0.c,1387 :: 		if(((!LCDFlashFlag)&&(LastLCDFlashState!=0))||((!LastLCDFlashState)&&(UpdatewhenFlashing)))
	MOVF        _LCDFlashFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCDUpdater925
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater925
	GOTO        L__LCDUpdater923
L__LCDUpdater925:
	MOVF        LCDUpdater_LastLCDFlashState_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCDUpdater924
	MOVF        LCDUpdater_UpdateWhenFlashing_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__LCDUpdater924
	GOTO        L__LCDUpdater923
L__LCDUpdater924:
	GOTO        L_LCDUpdater342
L__LCDUpdater923:
;FirmV_0_7_0.c,1388 :: 		{lcd_out(2,0,LCDLine2);LastLCDFlashState=0;UpdatewhenFlashing=0;}
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
L_LCDUpdater342:
;FirmV_0_7_0.c,1389 :: 		}
L_LCDUpdater328:
;FirmV_0_7_0.c,1392 :: 		}
L_end_LCDUpdater:
	RETURN      0
; end of _LCDUpdater

_Init:

;FirmV_0_7_0.c,1412 :: 		void Init()
;FirmV_0_7_0.c,1414 :: 		char i=0;
	CLRF        Init_i_L0+0 
;FirmV_0_7_0.c,1416 :: 		porta=0;
	CLRF        PORTA+0 
;FirmV_0_7_0.c,1417 :: 		portb=0;
	CLRF        PORTB+0 
;FirmV_0_7_0.c,1418 :: 		portc=0;
	CLRF        PORTC+0 
;FirmV_0_7_0.c,1419 :: 		portd=0;
	CLRF        PORTD+0 
;FirmV_0_7_0.c,1420 :: 		porte=0;
	CLRF        PORTE+0 
;FirmV_0_7_0.c,1421 :: 		trisa=0b101111;
	MOVLW       47
	MOVWF       TRISA+0 
;FirmV_0_7_0.c,1422 :: 		trisb=0b00000111;
	MOVLW       7
	MOVWF       TRISB+0 
;FirmV_0_7_0.c,1423 :: 		trisc=0b10000100;
	MOVLW       132
	MOVWF       TRISC+0 
;FirmV_0_7_0.c,1424 :: 		trisd=0b00111111;
	MOVLW       63
	MOVWF       TRISD+0 
;FirmV_0_7_0.c,1425 :: 		trise=0b001;
	MOVLW       1
	MOVWF       TRISE+0 
;FirmV_0_7_0.c,1426 :: 		adcon1=0b1100;  // an6, an5 and an7 is digital
	MOVLW       12
	MOVWF       ADCON1+0 
;FirmV_0_7_0.c,1432 :: 		LCDBackLight=1;
	BSF         PORTA+0, 4 
;FirmV_0_7_0.c,1433 :: 		I2C1_init(100000);
	MOVLW       100
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;FirmV_0_7_0.c,1435 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Init343:
	DECFSZ      R13, 1, 1
	BRA         L_Init343
	DECFSZ      R12, 1, 1
	BRA         L_Init343
	DECFSZ      R11, 1, 1
	BRA         L_Init343
	NOP
	NOP
;FirmV_0_7_0.c,1437 :: 		LCD_init(1);
	MOVLW       1
	MOVWF       FARG_LCD_Init+0 
	CALL        _LCD_Init+0, 0
;FirmV_0_7_0.c,1438 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,1439 :: 		delay_ms(300);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_Init344:
	DECFSZ      R13, 1, 1
	BRA         L_Init344
	DECFSZ      R12, 1, 1
	BRA         L_Init344
	DECFSZ      R11, 1, 1
	BRA         L_Init344
	NOP
	NOP
;FirmV_0_7_0.c,1440 :: 		SetContrast(20);
	MOVLW       20
	MOVWF       FARG_SetContrast+0 
	CALL        _SetContrast+0, 0
;FirmV_0_7_0.c,1443 :: 		ms500=0;
	CLRF        _ms500+0 
	CLRF        _ms500+1 
	CLRF        _ms500+2 
	CLRF        _ms500+3 
;FirmV_0_7_0.c,1444 :: 		t0con=0b10000101; //enable tmr0 and prescalar
	MOVLW       133
	MOVWF       T0CON+0 
;FirmV_0_7_0.c,1445 :: 		intcon.b7=1;   //global int enable
	BSF         INTCON+0, 7 
;FirmV_0_7_0.c,1446 :: 		intcon.b5=1;  //tmr0 int enable
	BSF         INTCON+0, 5 
;FirmV_0_7_0.c,1447 :: 		intcon.b2=0; //tmr0 flag
	BCF         INTCON+0, 2 
;FirmV_0_7_0.c,1448 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,1449 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,1461 :: 		t2con=0b00011011;
	MOVLW       27
	MOVWF       T2CON+0 
;FirmV_0_7_0.c,1462 :: 		PEIE_GIEL_bit=1;
	BSF         PEIE_GIEL_bit+0, BitPos(PEIE_GIEL_bit+0) 
;FirmV_0_7_0.c,1463 :: 		TMR2IP_bit=1;
	BSF         TMR2IP_bit+0, BitPos(TMR2IP_bit+0) 
;FirmV_0_7_0.c,1464 :: 		TMR2IF_bit=0;
	BCF         TMR2IF_bit+0, BitPos(TMR2IF_bit+0) 
;FirmV_0_7_0.c,1465 :: 		TMR2IE_bit=0;
	BCF         TMR2IE_bit+0, BitPos(TMR2IE_bit+0) 
;FirmV_0_7_0.c,1466 :: 		PR2=117;
	MOVLW       117
	MOVWF       PR2+0 
;FirmV_0_7_0.c,1478 :: 		INT1IP_bit=1;
	BSF         INT1IP_bit+0, BitPos(INT1IP_bit+0) 
;FirmV_0_7_0.c,1479 :: 		INT1E_bit=1;
	BSF         INT1E_bit+0, BitPos(INT1E_bit+0) 
;FirmV_0_7_0.c,1480 :: 		INT1F_bit=0;
	BCF         INT1F_bit+0, BitPos(INT1F_bit+0) 
;FirmV_0_7_0.c,1481 :: 		INT2IP_bit=1;
	BSF         INT2IP_bit+0, BitPos(INT2IP_bit+0) 
;FirmV_0_7_0.c,1482 :: 		INT2E_bit=1;
	BSF         INT2E_bit+0, BitPos(INT2E_bit+0) 
;FirmV_0_7_0.c,1483 :: 		INT2F_bit=0;
	BCF         INT2F_bit+0, BitPos(INT2F_bit+0) 
;FirmV_0_7_0.c,1484 :: 		INTEDG1_bit=1;
	BSF         INTEDG1_bit+0, BitPos(INTEDG1_bit+0) 
;FirmV_0_7_0.c,1485 :: 		INTEDG2_bit=1;
	BSF         INTEDG2_bit+0, BitPos(INTEDG2_bit+0) 
;FirmV_0_7_0.c,1488 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, BitPos(INT0F_bit+0) 
;FirmV_0_7_0.c,1489 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, BitPos(INT0E_bit+0) 
;FirmV_0_7_0.c,1492 :: 		for(i=0;i<20;i++)
	CLRF        Init_i_L0+0 
L_Init345:
	MOVLW       20
	SUBWF       Init_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Init346
;FirmV_0_7_0.c,1493 :: 		Tasks[i].Expired=1;
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
;FirmV_0_7_0.c,1492 :: 		for(i=0;i<20;i++)
	INCF        Init_i_L0+0, 1 
;FirmV_0_7_0.c,1493 :: 		Tasks[i].Expired=1;
	GOTO        L_Init345
L_Init346:
;FirmV_0_7_0.c,1496 :: 		Events.Keys=0;
	CLRF        _Events+0 
;FirmV_0_7_0.c,1497 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,1498 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,1499 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,1500 :: 		Events.Remote=0;
	CLRF        _Events+4 
;FirmV_0_7_0.c,1501 :: 		Events.Overload=0;
	CLRF        _Events+5 
;FirmV_0_7_0.c,1502 :: 		Events.Photocell=0;
	CLRF        _Events+6 
;FirmV_0_7_0.c,1505 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,1508 :: 		UART1_init(115200);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       86
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;FirmV_0_7_0.c,1511 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,1515 :: 		}
L_end_Init:
	RETURN      0
; end of _Init

_TaskManager:

;FirmV_0_7_0.c,1529 :: 		void TaskManager()
;FirmV_0_7_0.c,1531 :: 		char i=0;
	CLRF        TaskManager_i_L0+0 
;FirmV_0_7_0.c,1532 :: 		for(i=0;i<20;i++)
	CLRF        TaskManager_i_L0+0 
L_TaskManager348:
	MOVLW       20
	SUBWF       TaskManager_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TaskManager349
;FirmV_0_7_0.c,1533 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Time==ms500)&&(Tasks[i].Fired==0))
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
	GOTO        L_TaskManager353
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
	GOTO        L__TaskManager1033
	MOVF        R3, 0 
	XORWF       _ms500+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager1033
	MOVF        R2, 0 
	XORWF       _ms500+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager1033
	MOVF        R1, 0 
	XORWF       _ms500+0, 0 
L__TaskManager1033:
	BTFSS       STATUS+0, 2 
	GOTO        L_TaskManager353
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
	GOTO        L_TaskManager353
L__TaskManager929:
;FirmV_0_7_0.c,1534 :: 		Tasks[i].Fired=1;
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
L_TaskManager353:
;FirmV_0_7_0.c,1532 :: 		for(i=0;i<20;i++)
	INCF        TaskManager_i_L0+0, 1 
;FirmV_0_7_0.c,1534 :: 		Tasks[i].Fired=1;
	GOTO        L_TaskManager348
L_TaskManager349:
;FirmV_0_7_0.c,1535 :: 		}
L_end_TaskManager:
	RETURN      0
; end of _TaskManager

_AddTask:

;FirmV_0_7_0.c,1547 :: 		void AddTask(unsigned long OccTime,char tcode)
;FirmV_0_7_0.c,1550 :: 		for(i=0;i<20;i++)
	CLRF        AddTask_i_L0+0 
L_AddTask354:
	MOVLW       20
	SUBWF       AddTask_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AddTask355
;FirmV_0_7_0.c,1551 :: 		if(Tasks[i].Expired==1)
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
	GOTO        L_AddTask357
;FirmV_0_7_0.c,1553 :: 		Tasks[i].TaskCode=tcode;
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
;FirmV_0_7_0.c,1554 :: 		Tasks[i].Time=OccTime;
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
;FirmV_0_7_0.c,1555 :: 		Tasks[i].Expired=0;
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
;FirmV_0_7_0.c,1556 :: 		Tasks[i].Fired=0;
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
;FirmV_0_7_0.c,1557 :: 		break;
	GOTO        L_AddTask355
;FirmV_0_7_0.c,1558 :: 		}
L_AddTask357:
;FirmV_0_7_0.c,1550 :: 		for(i=0;i<20;i++)
	INCF        AddTask_i_L0+0, 1 
;FirmV_0_7_0.c,1558 :: 		}
	GOTO        L_AddTask354
L_AddTask355:
;FirmV_0_7_0.c,1559 :: 		}
L_end_AddTask:
	RETURN      0
; end of _AddTask

_EventHandler:

;FirmV_0_7_0.c,1569 :: 		void EventHandler()
;FirmV_0_7_0.c,1572 :: 		Events.ExternalKeys=GetExternalKeysState();
	CALL        _GetExternalKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+8 
;FirmV_0_7_0.c,1573 :: 		Events.Limiter=GetLimitSwitchState();
	CALL        _GetLimitSwitchState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+7 
;FirmV_0_7_0.c,1574 :: 		Events.Keys=GetKeysState();
	CALL        _GetKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+0 
;FirmV_0_7_0.c,1575 :: 		Events.Remote=GetRemoteState();
	CALL        _GetRemoteState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+4 
;FirmV_0_7_0.c,1576 :: 		Events.Overload=GetOverloadState();
	CALL        _GetOverloadState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+5 
;FirmV_0_7_0.c,1577 :: 		Events.Photocell=GetPhotocellState();
	CALL        _GetPhotocellState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+6 
;FirmV_0_7_0.c,1579 :: 		for(i=0;i<20;i++)
	CLRF        EventHandler_i_L0+0 
L_EventHandler358:
	MOVLW       20
	SUBWF       EventHandler_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_EventHandler359
;FirmV_0_7_0.c,1580 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Fired==1))
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
	GOTO        L_EventHandler363
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
	GOTO        L_EventHandler363
L__EventHandler930:
;FirmV_0_7_0.c,1582 :: 		if(Events.Task1==0)
	MOVF        _Events+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler364
;FirmV_0_7_0.c,1583 :: 		{Events.Task1=Tasks[i].TaskCode; Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
	GOTO        L_EventHandler365
L_EventHandler364:
;FirmV_0_7_0.c,1584 :: 		else if(Events.Task2==0)
	MOVF        _Events+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler366
;FirmV_0_7_0.c,1585 :: 		{Events.Task2=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
	GOTO        L_EventHandler367
L_EventHandler366:
;FirmV_0_7_0.c,1586 :: 		else if(Events.Task3==0)
	MOVF        _Events+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler368
;FirmV_0_7_0.c,1587 :: 		{Events.Task3=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
L_EventHandler368:
L_EventHandler367:
L_EventHandler365:
;FirmV_0_7_0.c,1588 :: 		}
L_EventHandler363:
;FirmV_0_7_0.c,1579 :: 		for(i=0;i<20;i++)
	INCF        EventHandler_i_L0+0, 1 
;FirmV_0_7_0.c,1588 :: 		}
	GOTO        L_EventHandler358
L_EventHandler359:
;FirmV_0_7_0.c,1589 :: 		}
L_end_EventHandler:
	RETURN      0
; end of _EventHandler

_GetKeysState:

;FirmV_0_7_0.c,1599 :: 		char GetKeysState()
;FirmV_0_7_0.c,1601 :: 		unsigned res=0;
;FirmV_0_7_0.c,1605 :: 		char resch=0,fin;
	CLRF        GetKeysState_resch_L0+0 
;FirmV_0_7_0.c,1606 :: 		resch.b0=~KeyDown;
	BTFSC       PORTD+0, 5 
	GOTO        L__GetKeysState1037
	BSF         GetKeysState_resch_L0+0, 0 
	GOTO        L__GetKeysState1038
L__GetKeysState1037:
	BCF         GetKeysState_resch_L0+0, 0 
L__GetKeysState1038:
;FirmV_0_7_0.c,1607 :: 		resch.b1=~KeyMenu;
	BTFSC       PORTE+0, 0 
	GOTO        L__GetKeysState1039
	BSF         GetKeysState_resch_L0+0, 1 
	GOTO        L__GetKeysState1040
L__GetKeysState1039:
	BCF         GetKeysState_resch_L0+0, 1 
L__GetKeysState1040:
;FirmV_0_7_0.c,1608 :: 		resch.b2=~KeyUp;
	BTFSC       PORTD+0, 4 
	GOTO        L__GetKeysState1041
	BSF         GetKeysState_resch_L0+0, 2 
	GOTO        L__GetKeysState1042
L__GetKeysState1041:
	BCF         GetKeysState_resch_L0+0, 2 
L__GetKeysState1042:
;FirmV_0_7_0.c,1610 :: 		if(DebouncingDelayUnpress<DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelayUnpress+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState369
;FirmV_0_7_0.c,1611 :: 		resch=0;
	CLRF        GetKeysState_resch_L0+0 
L_GetKeysState369:
;FirmV_0_7_0.c,1613 :: 		if((resch==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState370
;FirmV_0_7_0.c,1615 :: 		if(Pressed==0)
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState371
;FirmV_0_7_0.c,1616 :: 		{Repeat=0;RepeatCount=0;Pressed=0;fin=0;RepeatRate=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        GetKeysState_RepeatCount_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState371:
;FirmV_0_7_0.c,1617 :: 		if(Pressed==1)
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState372
;FirmV_0_7_0.c,1618 :: 		if(DebouncingDelayPress>=DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelayPress+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetKeysState373
;FirmV_0_7_0.c,1619 :: 		{Repeat=0;RepeatCount=0;Pressed=0;fin=0;RepeatRate=0;DebouncingDelayUnpress=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        GetKeysState_RepeatCount_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
	CLRF        _DebouncingDelayUnpress+0 
L_GetKeysState373:
L_GetKeysState372:
;FirmV_0_7_0.c,1620 :: 		}
L_GetKeysState370:
;FirmV_0_7_0.c,1625 :: 		if((Repeat==1)&&(KeyFlag>=RepeatSpeed))
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState376
	MOVF        GetKeysState_RepeatSpeed_L0+0, 0 
	SUBWF       _KeyFlag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetKeysState376
L__GetKeysState935:
;FirmV_0_7_0.c,1626 :: 		{RepeatRate=1;KeyFlag=0;if(RepeatCount<25)RepeatCount=RepeatCount+1;}
	MOVLW       1
	MOVWF       GetKeysState_RepeatRate_L0+0 
	CLRF        _KeyFlag+0 
	MOVLW       25
	SUBWF       GetKeysState_RepeatCount_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState377
	INCF        GetKeysState_RepeatCount_L0+0, 1 
L_GetKeysState377:
L_GetKeysState376:
;FirmV_0_7_0.c,1630 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0)&&(ms500==PressTime+KeyRepeatDelay))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState380
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState380
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState380
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
	GOTO        L__GetKeysState1043
	MOVF        _ms500+2, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState1043
	MOVF        _ms500+1, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState1043
	MOVF        _ms500+0, 0 
	XORWF       R1, 0 
L__GetKeysState1043:
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState380
L__GetKeysState934:
;FirmV_0_7_0.c,1631 :: 		{Repeat=1;KeyFlag=0;}
	MOVLW       1
	MOVWF       GetKeysState_Repeat_L0+0 
	CLRF        _KeyFlag+0 
L_GetKeysState380:
;FirmV_0_7_0.c,1633 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState383
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState383
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState383
L__GetKeysState933:
;FirmV_0_7_0.c,1634 :: 		fin=0;
	CLRF        GetKeysState_fin_L0+0 
L_GetKeysState383:
;FirmV_0_7_0.c,1636 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==1))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState386
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState386
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState386
L__GetKeysState932:
;FirmV_0_7_0.c,1637 :: 		{fin=resch*RepeatRate;RepeatRate=0;}
	MOVF        GetKeysState_resch_L0+0, 0 
	MULWF       GetKeysState_RepeatRate_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState386:
;FirmV_0_7_0.c,1640 :: 		if((resch!=0)&&(Pressed==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState389
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState389
L__GetKeysState931:
;FirmV_0_7_0.c,1641 :: 		{fin=resch; Pressed=1;PressTime=ms500;DebouncingDelayPress=0;}
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
L_GetKeysState389:
;FirmV_0_7_0.c,1644 :: 		if(fin != 0)
	MOVF        GetKeysState_fin_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState390
;FirmV_0_7_0.c,1645 :: 		BuzzFlag=1;
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_GetKeysState390:
;FirmV_0_7_0.c,1647 :: 		return fin;
	MOVF        GetKeysState_fin_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1648 :: 		}
L_end_GetKeysState:
	RETURN      0
; end of _GetKeysState

_GetExternalKeysState:

;FirmV_0_7_0.c,1658 :: 		char GetExternalKeysState()
;FirmV_0_7_0.c,1660 :: 		char out=0;
	CLRF        GetExternalKeysState_out_L0+0 
;FirmV_0_7_0.c,1661 :: 		if(KeyUp==0)
	BTFSC       PORTD+0, 4 
	GOTO        L_GetExternalKeysState391
;FirmV_0_7_0.c,1662 :: 		out.b0=1;
	BSF         GetExternalKeysState_out_L0+0, 0 
L_GetExternalKeysState391:
;FirmV_0_7_0.c,1663 :: 		if(KeyDown==0)
	BTFSC       PORTD+0, 5 
	GOTO        L_GetExternalKeysState392
;FirmV_0_7_0.c,1664 :: 		out.b1=1;
	BSF         GetExternalKeysState_out_L0+0, 1 
L_GetExternalKeysState392:
;FirmV_0_7_0.c,1665 :: 		return out;
	MOVF        GetExternalKeysState_out_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1666 :: 		}
L_end_GetExternalKeysState:
	RETURN      0
; end of _GetExternalKeysState

_GetLimitSwitchState:

;FirmV_0_7_0.c,1679 :: 		char GetLimitSwitchState()
;FirmV_0_7_0.c,1681 :: 		if((Limit1==0)||(Limit2==0))
	BTFSS       PORTD+0, 0 
	GOTO        L__GetLimitSwitchState938
	BTFSS       PORTD+0, 1 
	GOTO        L__GetLimitSwitchState938
	GOTO        L_GetLimitSwitchState395
L__GetLimitSwitchState938:
;FirmV_0_7_0.c,1683 :: 		if(LimitCounter <= 100)
	MOVF        _LimitCounter+0, 0 
	SUBLW       100
	BTFSS       STATUS+0, 0 
	GOTO        L_GetLimitSwitchState396
;FirmV_0_7_0.c,1684 :: 		LimitCounter=LimitCounter+1;
	INCF        _LimitCounter+0, 1 
L_GetLimitSwitchState396:
;FirmV_0_7_0.c,1685 :: 		}
	GOTO        L_GetLimitSwitchState397
L_GetLimitSwitchState395:
;FirmV_0_7_0.c,1687 :: 		LimitCounter=0;
	CLRF        _LimitCounter+0 
L_GetLimitSwitchState397:
;FirmV_0_7_0.c,1689 :: 		if((LimitCounter >100) && (Limit1 == 0))
	MOVF        _LimitCounter+0, 0 
	SUBLW       100
	BTFSC       STATUS+0, 0 
	GOTO        L_GetLimitSwitchState400
	BTFSC       PORTD+0, 0 
	GOTO        L_GetLimitSwitchState400
L__GetLimitSwitchState937:
;FirmV_0_7_0.c,1690 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_GetLimitSwitchState
L_GetLimitSwitchState400:
;FirmV_0_7_0.c,1691 :: 		if((LimitCounter >100) && (Limit2 == 0))
	MOVF        _LimitCounter+0, 0 
	SUBLW       100
	BTFSC       STATUS+0, 0 
	GOTO        L_GetLimitSwitchState403
	BTFSC       PORTD+0, 1 
	GOTO        L_GetLimitSwitchState403
L__GetLimitSwitchState936:
;FirmV_0_7_0.c,1692 :: 		return 2;
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_GetLimitSwitchState
L_GetLimitSwitchState403:
;FirmV_0_7_0.c,1693 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1694 :: 		}
L_end_GetLimitSwitchState:
	RETURN      0
; end of _GetLimitSwitchState

_GetRemoteState:

;FirmV_0_7_0.c,1703 :: 		char GetRemoteState()
;FirmV_0_7_0.c,1705 :: 		char res=0;
	CLRF        GetRemoteState_res_L0+0 
;FirmV_0_7_0.c,1706 :: 		res.b0=RemoteAFlag.b0;
	BTFSC       _RemoteAFlag+0, 0 
	GOTO        L__GetRemoteState1047
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState1048
L__GetRemoteState1047:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState1048:
;FirmV_0_7_0.c,1707 :: 		res.b1=RemoteBFlag.b0;
	BTFSC       _RemoteBFlag+0, 0 
	GOTO        L__GetRemoteState1049
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState1050
L__GetRemoteState1049:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState1050:
;FirmV_0_7_0.c,1708 :: 		RemoteAFlag=0;
	CLRF        _RemoteAFlag+0 
;FirmV_0_7_0.c,1709 :: 		RemoteBFlag=0;
	CLRF        _RemoteBFlag+0 
;FirmV_0_7_0.c,1712 :: 		if(State<20)
	MOVLW       20
	SUBWF       _State+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetRemoteState404
;FirmV_0_7_0.c,1714 :: 		res.b0=res.b0|Events.Keys.b2;//up key
	BTFSC       GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState1051
	BTFSC       _Events+0, 2 
	GOTO        L__GetRemoteState1051
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState1052
L__GetRemoteState1051:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState1052:
;FirmV_0_7_0.c,1715 :: 		res.b1=res.b1|Events.Keys.b0;//down key
	BTFSC       GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState1053
	BTFSC       _Events+0, 0 
	GOTO        L__GetRemoteState1053
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState1054
L__GetRemoteState1053:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState1054:
;FirmV_0_7_0.c,1716 :: 		}
L_GetRemoteState404:
;FirmV_0_7_0.c,1718 :: 		return res;
	MOVF        GetRemoteState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1719 :: 		}
L_end_GetRemoteState:
	RETURN      0
; end of _GetRemoteState

_GetOverloadState:

;FirmV_0_7_0.c,1729 :: 		char GetOverloadState()
;FirmV_0_7_0.c,1731 :: 		char res=0;
	CLRF        GetOverloadState_res_L0+0 
;FirmV_0_7_0.c,1733 :: 		VCapM1=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _VCapM1+0 
	MOVF        R1, 0 
	MOVWF       _VCapM1+1 
;FirmV_0_7_0.c,1734 :: 		VCapM2=ADC_Read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _VCapM2+0 
	MOVF        R1, 0 
	MOVWF       _VCapM2+1 
;FirmV_0_7_0.c,1737 :: 		if(OverloadCheckFlag1==0)
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetOverloadState405
;FirmV_0_7_0.c,1738 :: 		OverloadCounter1=0;
	CLRF        _OverloadCounter1+0 
	CLRF        _OverloadCounter1+1 
L_GetOverloadState405:
;FirmV_0_7_0.c,1740 :: 		if(OverloadCheckFlag2==0)
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetOverloadState406
;FirmV_0_7_0.c,1741 :: 		OverloadCounter2=0;
	CLRF        _OverloadCounter2+0 
	CLRF        _OverloadCounter2+1 
L_GetOverloadState406:
;FirmV_0_7_0.c,1744 :: 		if(Motor1FullSpeed!=0)
	MOVF        _Motor1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState407
;FirmV_0_7_0.c,1748 :: 		if(VCapM1<OverloadTreshold1)
	MOVF        _OverloadTreshold1+1, 0 
	SUBWF       _VCapM1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState1056
	MOVF        _OverloadTreshold1+0, 0 
	SUBWF       _VCapM1+0, 0 
L__GetOverloadState1056:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState408
;FirmV_0_7_0.c,1750 :: 		if(OverloadCounter1<65530)
	MOVLW       255
	SUBWF       _OverloadCounter1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState1057
	MOVLW       250
	SUBWF       _OverloadCounter1+0, 0 
L__GetOverloadState1057:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState409
;FirmV_0_7_0.c,1751 :: 		OverloadCounter1=OverloadCounter1+1;
	INFSNZ      _OverloadCounter1+0, 1 
	INCF        _OverloadCounter1+1, 1 
L_GetOverloadState409:
;FirmV_0_7_0.c,1752 :: 		}
	GOTO        L_GetOverloadState410
L_GetOverloadState408:
;FirmV_0_7_0.c,1755 :: 		if(OverloadCounter1>0)
	MOVLW       0
	MOVWF       R0 
	MOVF        _OverloadCounter1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState1058
	MOVF        _OverloadCounter1+0, 0 
	SUBLW       0
L__GetOverloadState1058:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState411
;FirmV_0_7_0.c,1756 :: 		OverloadCounter1=OverloadCounter1-1;
	MOVLW       1
	SUBWF       _OverloadCounter1+0, 1 
	MOVLW       0
	SUBWFB      _OverloadCounter1+1, 1 
L_GetOverloadState411:
;FirmV_0_7_0.c,1757 :: 		}
L_GetOverloadState410:
;FirmV_0_7_0.c,1758 :: 		}
	GOTO        L_GetOverloadState412
L_GetOverloadState407:
;FirmV_0_7_0.c,1760 :: 		{OverloadCounter1=0;}
	CLRF        _OverloadCounter1+0 
	CLRF        _OverloadCounter1+1 
L_GetOverloadState412:
;FirmV_0_7_0.c,1762 :: 		if (OverloadCounter1>OverloadDuration1)
	MOVF        _OverloadCounter1+1, 0 
	SUBWF       _OverloadDuration1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState1059
	MOVF        _OverloadCounter1+0, 0 
	SUBWF       _OverloadDuration1+0, 0 
L__GetOverloadState1059:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState413
;FirmV_0_7_0.c,1763 :: 		res.b0=1;
	BSF         GetOverloadState_res_L0+0, 0 
L_GetOverloadState413:
;FirmV_0_7_0.c,1768 :: 		if(Motor2FullSpeed!=0)
	MOVF        _Motor2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState414
;FirmV_0_7_0.c,1770 :: 		if(VCapM2<OverloadTreshold2)
	MOVF        _OverloadTreshold2+1, 0 
	SUBWF       _VCapM2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState1060
	MOVF        _OverloadTreshold2+0, 0 
	SUBWF       _VCapM2+0, 0 
L__GetOverloadState1060:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState415
;FirmV_0_7_0.c,1772 :: 		if(OverloadCounter2<65530)
	MOVLW       255
	SUBWF       _OverloadCounter2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState1061
	MOVLW       250
	SUBWF       _OverloadCounter2+0, 0 
L__GetOverloadState1061:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState416
;FirmV_0_7_0.c,1773 :: 		OverloadCounter2=OverloadCounter2+1;
	INFSNZ      _OverloadCounter2+0, 1 
	INCF        _OverloadCounter2+1, 1 
L_GetOverloadState416:
;FirmV_0_7_0.c,1774 :: 		}
	GOTO        L_GetOverloadState417
L_GetOverloadState415:
;FirmV_0_7_0.c,1777 :: 		if(OverloadCounter2>0)
	MOVLW       0
	MOVWF       R0 
	MOVF        _OverloadCounter2+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState1062
	MOVF        _OverloadCounter2+0, 0 
	SUBLW       0
L__GetOverloadState1062:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState418
;FirmV_0_7_0.c,1778 :: 		OverloadCounter2=OverloadCounter2-1;
	MOVLW       1
	SUBWF       _OverloadCounter2+0, 1 
	MOVLW       0
	SUBWFB      _OverloadCounter2+1, 1 
L_GetOverloadState418:
;FirmV_0_7_0.c,1779 :: 		}
L_GetOverloadState417:
;FirmV_0_7_0.c,1780 :: 		}
	GOTO        L_GetOverloadState419
L_GetOverloadState414:
;FirmV_0_7_0.c,1782 :: 		{OverloadCounter2=0;}
	CLRF        _OverloadCounter2+0 
	CLRF        _OverloadCounter2+1 
L_GetOverloadState419:
;FirmV_0_7_0.c,1785 :: 		if (OverloadCounter2>OverloadDuration2)
	MOVF        _OverloadCounter2+1, 0 
	SUBWF       _OverloadDuration2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState1063
	MOVF        _OverloadCounter2+0, 0 
	SUBWF       _OverloadDuration2+0, 0 
L__GetOverloadState1063:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState420
;FirmV_0_7_0.c,1786 :: 		res.b1=1;
	BSF         GetOverloadState_res_L0+0, 1 
L_GetOverloadState420:
;FirmV_0_7_0.c,1788 :: 		return res;
	MOVF        GetOverloadState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1789 :: 		}
L_end_GetOverloadState:
	RETURN      0
; end of _GetOverloadState

_GetPhotocellState:

;FirmV_0_7_0.c,1802 :: 		char GetPhotocellState()
;FirmV_0_7_0.c,1804 :: 		if(Phcell2==0)
	BTFSC       PORTD+0, 2 
	GOTO        L_GetPhotocellState421
;FirmV_0_7_0.c,1805 :: 		{if(PhotocellCount<=20)PhotocellCount=PhotocellCount+1;}
	MOVF        _PhotocellCount+0, 0 
	SUBLW       20
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState422
	INCF        _PhotocellCount+0, 1 
L_GetPhotocellState422:
	GOTO        L_GetPhotocellState423
L_GetPhotocellState421:
;FirmV_0_7_0.c,1807 :: 		{PhotocellCount=0;}
	CLRF        _PhotocellCount+0 
L_GetPhotocellState423:
;FirmV_0_7_0.c,1808 :: 		if(PhotocellCount>=20)
	MOVLW       20
	SUBWF       _PhotocellCount+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState424
;FirmV_0_7_0.c,1809 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_GetPhotocellState
L_GetPhotocellState424:
;FirmV_0_7_0.c,1811 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1812 :: 		}
L_end_GetPhotocellState:
	RETURN      0
; end of _GetPhotocellState

_SetMotorSpeed:

;FirmV_0_7_0.c,1824 :: 		void SetMotorSpeed(char M1FullSpeed,char M2FullSpeed)
;FirmV_0_7_0.c,1826 :: 		if((M1FullSpeed==0)||(M2FullSpeed==0))
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed939
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed939
	GOTO        L_SetMotorSpeed428
L__SetMotorSpeed939:
;FirmV_0_7_0.c,1827 :: 		INT0E_bit=1;
	BSF         INT0E_bit+0, BitPos(INT0E_bit+0) 
	GOTO        L_SetMotorSpeed429
L_SetMotorSpeed428:
;FirmV_0_7_0.c,1829 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, BitPos(INT0E_bit+0) 
L_SetMotorSpeed429:
;FirmV_0_7_0.c,1831 :: 		Motor1FullSpeed=M1FullSpeed;
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	MOVWF       _Motor1FullSpeed+0 
;FirmV_0_7_0.c,1832 :: 		Motor2FullSpeed=M2FullSpeed;
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	MOVWF       _Motor2FullSpeed+0 
;FirmV_0_7_0.c,1833 :: 		}
L_end_SetMotorSpeed:
	RETURN      0
; end of _SetMotorSpeed

_OverloadInit:

;FirmV_0_7_0.c,1844 :: 		void OverloadInit(char ch)
;FirmV_0_7_0.c,1846 :: 		if(ch==1)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit430
;FirmV_0_7_0.c,1848 :: 		OverloadCounter1=0;
	CLRF        _OverloadCounter1+0 
	CLRF        _OverloadCounter1+1 
;FirmV_0_7_0.c,1849 :: 		Events.Overload.b0=0;
	BCF         _Events+5, 0 
;FirmV_0_7_0.c,1850 :: 		}
L_OverloadInit430:
;FirmV_0_7_0.c,1852 :: 		if(ch==2)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit431
;FirmV_0_7_0.c,1854 :: 		OverloadCounter2=0;
	CLRF        _OverloadCounter2+0 
	CLRF        _OverloadCounter2+1 
;FirmV_0_7_0.c,1855 :: 		Events.Overload.b1=0;
	BCF         _Events+5, 1 
;FirmV_0_7_0.c,1856 :: 		}
L_OverloadInit431:
;FirmV_0_7_0.c,1857 :: 		}
L_end_OverloadInit:
	RETURN      0
; end of _OverloadInit

_SaveConfigs:

;FirmV_0_7_0.c,1868 :: 		void SaveConfigs()
;FirmV_0_7_0.c,1871 :: 		EEPROM_Write(1,Door1OpenTime);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1872 :: 		EEPROM_Write(2,Door2OpenTime);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1873 :: 		EEPROM_Write(3,Door1CloseTime);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1874 :: 		EEPROM_Write(4,Door2CloseTime);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1875 :: 		EEPROM_Write(5,ActionTimeDiff);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1876 :: 		EEPROM_Write(6,OpenSoftStartTime);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1877 :: 		EEPROM_Write(7,OpenSoftStopTime);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1878 :: 		EEPROM_Write(8,CloseSoftStartTime);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1879 :: 		EEPROM_Write(9,CloseSoftStopTime);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1880 :: 		EEPROM_Write(10,Hi(AutoCloseTime));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1881 :: 		EEPROM_Write(11,Lo(AutoCloseTime));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1882 :: 		EEPROM_Write(12,OverloadSens1);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OverloadSens1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1883 :: 		EEPROM_Write(13,CloseAfterPass);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1884 :: 		EEPROM_Write(14,LockForce);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _LockForce+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1885 :: 		EEPROM_Write(15,OpenPhEnable);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenPhEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1886 :: 		EEPROM_Write(16,LimiterEnable);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _LimiterEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1887 :: 		EEPROM_Write(17,ReverseOnOpen);
	MOVLW       17
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ReverseOnOpen+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1888 :: 		EEPROM_Write(18,OverloadTime1);
	MOVLW       18
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OverloadTime1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1889 :: 		EEPROM_Write(19,OverloadSens2);
	MOVLW       19
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OverloadSens2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1890 :: 		EEPROM_Write(20,OverloadTime2);
	MOVLW       20
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OverloadTime2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1891 :: 		EEPROM_Write(21,M1SoftPower);
	MOVLW       21
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _M1SoftPower+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1892 :: 		EEPROM_Write(22,M2SoftPower);
	MOVLW       22
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _M2SoftPower+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1893 :: 		EEPROM_Write(23,ReverseOnClose);
	MOVLW       23
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ReverseOnClose+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1894 :: 		SetOverloadParams(OverloadSens1,OverloadTime1,OverloadSens2,OverloadTime2);
	MOVF        _OverloadSens1+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadTime1+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadSens2+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadTime2+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1896 :: 		}
L_end_SaveConfigs:
	RETURN      0
; end of _SaveConfigs

_LoadConfigs:

;FirmV_0_7_0.c,1909 :: 		void LoadConfigs()
;FirmV_0_7_0.c,1911 :: 		Door1OpenTime=EEPROM_Read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1912 :: 		Door2OpenTime=EEPROM_Read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1913 :: 		Door1CloseTime=EEPROM_Read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1914 :: 		Door2CloseTime=EEPROM_Read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1915 :: 		ActionTimeDiff=EEPROM_Read(5);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1916 :: 		OpenSoftStartTime=EEPROM_Read(6);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1917 :: 		OpenSoftStopTime=EEPROM_Read(7);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1918 :: 		CloseSoftStartTime=EEPROM_Read(8);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1919 :: 		CloseSoftStopTime=EEPROM_Read(9);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1920 :: 		AutoCloseTime=EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _AutoCloseTime+0 
	MOVLW       0
	MOVWF       _AutoCloseTime+1 
;FirmV_0_7_0.c,1921 :: 		AutoCloseTime=AutoCloseTime<<8;
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       _AutoCloseTime+1 
	CLRF        _AutoCloseTime+0 
;FirmV_0_7_0.c,1922 :: 		AutoCloseTime=AutocloseTime|EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	IORWF       _AutoCloseTime+0, 1 
	MOVLW       0
	IORWF       _AutoCloseTime+1, 1 
;FirmV_0_7_0.c,1923 :: 		OverloadSens1=EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadSens1+0 
;FirmV_0_7_0.c,1924 :: 		CloseAfterPass=EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseAfterPass+0 
;FirmV_0_7_0.c,1925 :: 		LockForce=EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockForce+0 
;FirmV_0_7_0.c,1926 :: 		OpenPhEnable=EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenPhEnable+0 
;FirmV_0_7_0.c,1927 :: 		LimiterEnable=EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LimiterEnable+0 
;FirmV_0_7_0.c,1928 :: 		ReverseOnOpen=EEPROM_Read(17);
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ReverseOnOpen+0 
;FirmV_0_7_0.c,1929 :: 		OverloadTime1=EEPROM_Read(18);
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadTime1+0 
;FirmV_0_7_0.c,1930 :: 		OverloadSens2=EEPROM_Read(19);
	MOVLW       19
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadSens2+0 
;FirmV_0_7_0.c,1931 :: 		OverloadTime2=EEPROM_Read(20);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadTime2+0 
;FirmV_0_7_0.c,1932 :: 		M1SoftPower=EEPROM_Read(21);
	MOVLW       21
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _M1SoftPower+0 
	MOVLW       0
	MOVWF       _M1SoftPower+1 
;FirmV_0_7_0.c,1933 :: 		M2SoftPower=EEPROM_Read(22);
	MOVLW       22
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _M2SoftPower+0 
	MOVLW       0
	MOVWF       _M2SoftPower+1 
;FirmV_0_7_0.c,1934 :: 		ReverseOnClose=EEPROM_Read(23);
	MOVLW       23
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ReverseOnClose+0 
;FirmV_0_7_0.c,1935 :: 		SetOverloadParams(OverloadSens1,OverloadTime1,OverloadSens2,OverloadTime2);
	MOVF        _OverloadSens1+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadTime1+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadSens2+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	MOVF        _OverloadTime2+0, 0 
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1937 :: 		}
L_end_LoadConfigs:
	RETURN      0
; end of _LoadConfigs

_FactorySettings:

;FirmV_0_7_0.c,1950 :: 		void FactorySettings()
;FirmV_0_7_0.c,1952 :: 		Door1OpenTime=20;
	MOVLW       20
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1953 :: 		Door1CloseTime=20;
	MOVLW       20
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1954 :: 		Door2OpenTime=20;
	MOVLW       20
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1955 :: 		Door2CloseTime=20;
	MOVLW       20
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1956 :: 		OverloadSens1=7;
	MOVLW       7
	MOVWF       _OverloadSens1+0 
;FirmV_0_7_0.c,1957 :: 		OverloadTime1=2;
	MOVLW       2
	MOVWF       _OverloadTime1+0 
;FirmV_0_7_0.c,1958 :: 		OverloadSens2=7;
	MOVLW       7
	MOVWF       _OverloadSens2+0 
;FirmV_0_7_0.c,1959 :: 		OverloadTime2=2;
	MOVLW       2
	MOVWF       _OverloadTime2+0 
;FirmV_0_7_0.c,1960 :: 		SetOverloadParams(7,2,7,2);
	MOVLW       7
	MOVWF       FARG_SetOverloadParams+0 
	MOVLW       2
	MOVWF       FARG_SetOverloadParams+0 
	MOVLW       7
	MOVWF       FARG_SetOverloadParams+0 
	MOVLW       2
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1961 :: 		OpenSoftStopTime=10;
	MOVLW       10
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1962 :: 		OpenSoftStartTime=4;
	MOVLW       4
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1963 :: 		CloseSoftStopTime=10;
	MOVLW       10
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1964 :: 		CloseSoftStartTime=4;
	MOVLW       4
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1965 :: 		ActionTimeDiff=12;
	MOVLW       12
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1966 :: 		AutoCloseTime=0;
	CLRF        _AutoCloseTime+0 
	CLRF        _AutoCloseTime+1 
;FirmV_0_7_0.c,1967 :: 		LockForce=0;
	CLRF        _LockForce+0 
;FirmV_0_7_0.c,1968 :: 		OpenPhEnable=0;
	CLRF        _OpenPhEnable+0 
;FirmV_0_7_0.c,1969 :: 		LimiterEnable=0;
	CLRF        _LimiterEnable+0 
;FirmV_0_7_0.c,1970 :: 		CloseAfterPass=0;
	CLRF        _CloseAfterPass+0 
;FirmV_0_7_0.c,1971 :: 		ReverseOnOpen=0;
	CLRF        _ReverseOnOpen+0 
;FirmV_0_7_0.c,1972 :: 		ReverseOnClose=0;
	CLRF        _ReverseOnClose+0 
;FirmV_0_7_0.c,1974 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,1975 :: 		}
L_end_FactorySettings:
	RETURN      0
; end of _FactorySettings

_StartMotor:

;FirmV_0_7_0.c,1981 :: 		void StartMotor(char Mx,char Dir)
;FirmV_0_7_0.c,1983 :: 		if(Mx==1)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor432
;FirmV_0_7_0.c,1985 :: 		Motor1Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor1071
	BCF         PORTC+0, 1 
	GOTO        L__StartMotor1072
L__StartMotor1071:
	BSF         PORTC+0, 1 
L__StartMotor1072:
;FirmV_0_7_0.c,1986 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_StartMotor433:
	DECFSZ      R13, 1, 1
	BRA         L_StartMotor433
	DECFSZ      R12, 1, 1
	BRA         L_StartMotor433
	DECFSZ      R11, 1, 1
	BRA         L_StartMotor433
	NOP
	NOP
;FirmV_0_7_0.c,1987 :: 		Motor1Start=1;
	MOVLW       1
	MOVWF       _Motor1Start+0 
;FirmV_0_7_0.c,1988 :: 		Motor1=1;
	BSF         PORTB+0, 3 
;FirmV_0_7_0.c,1989 :: 		}
L_StartMotor432:
;FirmV_0_7_0.c,1991 :: 		if(Mx==2)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor434
;FirmV_0_7_0.c,1993 :: 		Motor2Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor1073
	BCF         PORTC+0, 0 
	GOTO        L__StartMotor1074
L__StartMotor1073:
	BSF         PORTC+0, 0 
L__StartMotor1074:
;FirmV_0_7_0.c,1994 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_StartMotor435:
	DECFSZ      R13, 1, 1
	BRA         L_StartMotor435
	DECFSZ      R12, 1, 1
	BRA         L_StartMotor435
	DECFSZ      R11, 1, 1
	BRA         L_StartMotor435
	NOP
	NOP
;FirmV_0_7_0.c,1995 :: 		Motor2Start=1;
	MOVLW       1
	MOVWF       _Motor2Start+0 
;FirmV_0_7_0.c,1996 :: 		Motor2=1;
	BSF         PORTB+0, 4 
;FirmV_0_7_0.c,1997 :: 		}
L_StartMotor434:
;FirmV_0_7_0.c,1998 :: 		}
L_end_StartMotor:
	RETURN      0
; end of _StartMotor

_StopMotor:

;FirmV_0_7_0.c,2001 :: 		void StopMotor(char Mx)
;FirmV_0_7_0.c,2003 :: 		if(Mx==1)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor436
;FirmV_0_7_0.c,2005 :: 		Motor1Start=0;
	CLRF        _Motor1Start+0 
;FirmV_0_7_0.c,2006 :: 		Motor1=0;
	BCF         PORTB+0, 3 
;FirmV_0_7_0.c,2007 :: 		}
L_StopMotor436:
;FirmV_0_7_0.c,2009 :: 		if(Mx==2)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor437
;FirmV_0_7_0.c,2011 :: 		Motor2Start=0;
	CLRF        _Motor2Start+0 
;FirmV_0_7_0.c,2012 :: 		Motor2=0;
	BCF         PORTB+0, 4 
;FirmV_0_7_0.c,2013 :: 		}
L_StopMotor437:
;FirmV_0_7_0.c,2014 :: 		}
L_end_StopMotor:
	RETURN      0
; end of _StopMotor

_CheckTask:

;FirmV_0_7_0.c,2026 :: 		char CheckTask(char TaskCode)
;FirmV_0_7_0.c,2028 :: 		if(Events.Task1==TaskCode)
	MOVF        _Events+1, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask438
;FirmV_0_7_0.c,2029 :: 		{Events.Task1=0; return 1;}
	CLRF        _Events+1 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckTask
L_CheckTask438:
;FirmV_0_7_0.c,2031 :: 		if(Events.Task2==TaskCode)
	MOVF        _Events+2, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask439
;FirmV_0_7_0.c,2032 :: 		{Events.Task2=0; return 1;}
	CLRF        _Events+2 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckTask
L_CheckTask439:
;FirmV_0_7_0.c,2034 :: 		if(Events.Task3==TaskCode)
	MOVF        _Events+3, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask440
;FirmV_0_7_0.c,2035 :: 		{Events.Task3=0; return 1;}
	CLRF        _Events+3 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckTask
L_CheckTask440:
;FirmV_0_7_0.c,2037 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,2039 :: 		}
L_end_CheckTask:
	RETURN      0
; end of _CheckTask

_ReturnAutoclose:

;FirmV_0_7_0.c,2047 :: 		char ReturnAutoclose()
;FirmV_0_7_0.c,2051 :: 		for(i=0;i<20;i++)
	CLRF        ReturnAutoclose_i_L0+0 
L_ReturnAutoclose441:
	MOVLW       20
	SUBWF       ReturnAutoclose_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ReturnAutoclose442
;FirmV_0_7_0.c,2053 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode==9))
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
	GOTO        L_ReturnAutoclose446
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
	GOTO        L_ReturnAutoclose446
L__ReturnAutoclose940:
;FirmV_0_7_0.c,2054 :: 		{t=Tasks[i].Time;break;}
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
	GOTO        L_ReturnAutoclose442
L_ReturnAutoclose446:
;FirmV_0_7_0.c,2051 :: 		for(i=0;i<20;i++)
	INCF        ReturnAutoclose_i_L0+0, 1 
;FirmV_0_7_0.c,2055 :: 		}
	GOTO        L_ReturnAutoclose441
L_ReturnAutoclose442:
;FirmV_0_7_0.c,2057 :: 		if(i>=20) i=0;
	MOVLW       20
	SUBWF       ReturnAutoclose_i_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ReturnAutoclose447
	CLRF        ReturnAutoclose_i_L0+0 
	GOTO        L_ReturnAutoclose448
L_ReturnAutoclose447:
;FirmV_0_7_0.c,2058 :: 		else i=t-ms500;
	MOVF        _ms500+0, 0 
	SUBWF       ReturnAutoclose_t_L0+0, 0 
	MOVWF       ReturnAutoclose_i_L0+0 
L_ReturnAutoclose448:
;FirmV_0_7_0.c,2059 :: 		return i;
	MOVF        ReturnAutoclose_i_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,2060 :: 		}
L_end_ReturnAutoclose:
	RETURN      0
; end of _ReturnAutoclose

_GetAutocloseTime:

;FirmV_0_7_0.c,2070 :: 		char GetAutocloseTime()
;FirmV_0_7_0.c,2074 :: 		for(i=0;i<20;i++)
	CLRF        GetAutocloseTime_i_L0+0 
L_GetAutocloseTime449:
	MOVLW       20
	SUBWF       GetAutocloseTime_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetAutocloseTime450
;FirmV_0_7_0.c,2076 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode==9))
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
	GOTO        L_GetAutocloseTime454
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
	GOTO        L_GetAutocloseTime454
L__GetAutocloseTime941:
;FirmV_0_7_0.c,2077 :: 		{t=Tasks[i].Time;Tasks[i].Expired=1;break;}
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
	GOTO        L_GetAutocloseTime450
L_GetAutocloseTime454:
;FirmV_0_7_0.c,2074 :: 		for(i=0;i<20;i++)
	INCF        GetAutocloseTime_i_L0+0, 1 
;FirmV_0_7_0.c,2078 :: 		}
	GOTO        L_GetAutocloseTime449
L_GetAutocloseTime450:
;FirmV_0_7_0.c,2079 :: 		i=t-ms500;
	MOVF        _ms500+0, 0 
	SUBWF       GetAutocloseTime_t_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       GetAutocloseTime_i_L0+0 
;FirmV_0_7_0.c,2080 :: 		if(i>=20) i=0;
	MOVLW       20
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetAutocloseTime455
	CLRF        GetAutocloseTime_i_L0+0 
L_GetAutocloseTime455:
;FirmV_0_7_0.c,2081 :: 		return i;
	MOVF        GetAutocloseTime_i_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,2082 :: 		}
L_end_GetAutocloseTime:
	RETURN      0
; end of _GetAutocloseTime

_ClearTasks:

;FirmV_0_7_0.c,2099 :: 		void ClearTasks(char except)
;FirmV_0_7_0.c,2102 :: 		for(i=0;i<20;i++)
	CLRF        ClearTasks_i_L0+0 
L_ClearTasks456:
	MOVLW       20
	SUBWF       ClearTasks_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ClearTasks457
;FirmV_0_7_0.c,2103 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode!=except))
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
	GOTO        L_ClearTasks461
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
	GOTO        L_ClearTasks461
L__ClearTasks942:
;FirmV_0_7_0.c,2104 :: 		Tasks[i].Expired=1;
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
L_ClearTasks461:
;FirmV_0_7_0.c,2102 :: 		for(i=0;i<20;i++)
	INCF        ClearTasks_i_L0+0, 1 
;FirmV_0_7_0.c,2104 :: 		Tasks[i].Expired=1;
	GOTO        L_ClearTasks456
L_ClearTasks457:
;FirmV_0_7_0.c,2105 :: 		}
L_end_ClearTasks:
	RETURN      0
; end of _ClearTasks

_Menu0:

;FirmV_0_7_0.c,2120 :: 		void Menu0()
;FirmV_0_7_0.c,2122 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2123 :: 		memcpy(LCDLine2,"                ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
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
;FirmV_0_7_0.c,2125 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0462
;FirmV_0_7_0.c,2126 :: 		{memcpy(LCDLine1,"00 Learning Mode",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2127 :: 		if(LearningMode==0)memcpy(LCDLine2,"      Auto      ",16);
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0463
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
L_Menu0463:
;FirmV_0_7_0.c,2128 :: 		if(LearningMode==1)memcpy(LCDLine2,"     Manual     ",16);}
	MOVF        _LearningMode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0464
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
L_Menu0464:
L_Menu0462:
;FirmV_0_7_0.c,2130 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0465
;FirmV_0_7_0.c,2131 :: 		{memcpy(LCDLine1,"01 D1 Open Time ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2132 :: 		charValueToStr(Door1OpenTime,LCDLine2+6);}
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0465:
;FirmV_0_7_0.c,2134 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0466
;FirmV_0_7_0.c,2135 :: 		{memcpy(LCDLine1,"02 D2 Open Time ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2136 :: 		charValueToStr(Door2OpenTime,LCDLine2+6);}
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0466:
;FirmV_0_7_0.c,2138 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0467
;FirmV_0_7_0.c,2139 :: 		{memcpy(LCDLine1,"03 D1 Close Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2140 :: 		charValueToStr(Door1CloseTime,LCDLine2+6);}
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0467:
;FirmV_0_7_0.c,2142 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0468
;FirmV_0_7_0.c,2143 :: 		{memcpy(LCDLine1,"04 D2 Close Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2144 :: 		charValueToStr(Door2CloseTime,LCDLine2+6);}
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0468:
;FirmV_0_7_0.c,2146 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0469
;FirmV_0_7_0.c,2147 :: 		{memcpy(LCDLine1,"05 Op Soft Start",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2148 :: 		charValueToStr(OpenSoftStartTime,LCDLine2+6);}
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0469:
;FirmV_0_7_0.c,2150 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0470
;FirmV_0_7_0.c,2151 :: 		{memcpy(LCDLine1,"06 Op Soft Stop ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2152 :: 		charValueToStr(OpenSoftStopTime,LCDLine2+6);}
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0470:
;FirmV_0_7_0.c,2154 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0471
;FirmV_0_7_0.c,2155 :: 		{memcpy(LCDLine1,"07 Cl Soft Start",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2156 :: 		charValueToStr(CloseSoftStartTime,LCDLine2+6);}
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0471:
;FirmV_0_7_0.c,2158 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0472
;FirmV_0_7_0.c,2159 :: 		{memcpy(LCDLine1,"08 Cl Soft Stop ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2160 :: 		charValueToStr(CloseSoftStopTime,LCDLine2+6);}
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0472:
;FirmV_0_7_0.c,2162 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0473
;FirmV_0_7_0.c,2163 :: 		{memcpy(LCDLine1,"09 M1 Soft Power",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2164 :: 		bytetostr(M1SoftPower,LCDLine2+6);}
	MOVF        _M1SoftPower+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
L_Menu0473:
;FirmV_0_7_0.c,2166 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0474
;FirmV_0_7_0.c,2167 :: 		{memcpy(LCDLine1,"10 M2 Soft Power",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2168 :: 		bytetostr(M2SoftPower,LCDLine2+6);}
	MOVF        _M2SoftPower+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
L_Menu0474:
;FirmV_0_7_0.c,2170 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0475
;FirmV_0_7_0.c,2171 :: 		{memcpy(LCDLine1,"11 M1 Overl Sens",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2172 :: 		bytetostr(OverloadSens1,LCDLine2+3);if(OverloadSens1>7)memcpy(LCDLine2+7,"250Kg-",6);else memcpy(LCDLine2+7,"250Kg+",6);}
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
	GOTO        L_Menu0476
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
	GOTO        L_Menu0477
L_Menu0476:
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
L_Menu0477:
L_Menu0475:
;FirmV_0_7_0.c,2174 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0478
;FirmV_0_7_0.c,2175 :: 		{memcpy(LCDLine1,"12 M2 Overl Sens",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2176 :: 		bytetostr(OverloadSens2,LCDLine2+3);if(OverloadSens2>7)memcpy(LCDLine2+7,"250Kg-",6);else memcpy(LCDLine2+7,"250Kg+",6);}
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
	GOTO        L_Menu0479
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
	GOTO        L_Menu0480
L_Menu0479:
	MOVLW       _LCDLine2+7
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+7)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr89_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr89_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       6
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0480:
L_Menu0478:
;FirmV_0_7_0.c,2178 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0481
;FirmV_0_7_0.c,2179 :: 		{memcpy(LCDLine1,"13 M1 Overl Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2180 :: 		charValueToStr(OverloadTime1,LCDLine2+6);}
	MOVF        _OverloadTime1+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0481:
;FirmV_0_7_0.c,2182 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0482
;FirmV_0_7_0.c,2183 :: 		{memcpy(LCDLine1,"14 M2 Overl Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2184 :: 		charValueToStr(OverloadTime2,LCDLine2+6);}
	MOVF        _OverloadTime2+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0482:
;FirmV_0_7_0.c,2186 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0483
;FirmV_0_7_0.c,2187 :: 		{memcpy(LCDLine1,"15 Interval Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2188 :: 		charValueToStr(ActionTimeDiff,LCDLine2+6);}
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0483:
;FirmV_0_7_0.c,2190 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0484
;FirmV_0_7_0.c,2191 :: 		{memcpy(LCDLine1,"16 Auto-close T ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2192 :: 		intValueToStr(AutoCloseTime,LCDLine2+4);}
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_intValueToStr+0 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_intValueToStr+1 
	MOVLW       _LCDLine2+4
	MOVWF       FARG_intValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+4)
	MOVWF       FARG_intValueToStr+1 
	CALL        _intValueToStr+0, 0
L_Menu0484:
;FirmV_0_7_0.c,2194 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0485
;FirmV_0_7_0.c,2195 :: 		{memcpy(LCDLine1,"17 Factory Reset",16);LCDUpdateFlag=1;}
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
L_Menu0485:
;FirmV_0_7_0.c,2197 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0486
;FirmV_0_7_0.c,2198 :: 		{memcpy(LCDLine1,"18 Open Photo En",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2199 :: 		if(OpenPhEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _OpenPhEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0487
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
	GOTO        L_Menu0488
L_Menu0487:
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
L_Menu0488:
L_Menu0486:
;FirmV_0_7_0.c,2201 :: 		if(MenuPointer==19)
	MOVF        _MenuPointer+0, 0 
	XORLW       19
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0489
;FirmV_0_7_0.c,2202 :: 		{memcpy(LCDLine1,"19 Limit Enable ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2203 :: 		if(LimiterEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LimiterEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0490
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
	GOTO        L_Menu0491
L_Menu0490:
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
L_Menu0491:
L_Menu0489:
;FirmV_0_7_0.c,2205 :: 		if(MenuPointer==20)
	MOVF        _MenuPointer+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0492
;FirmV_0_7_0.c,2206 :: 		{memcpy(LCDLine1,"20 Reverse Open ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2207 :: 		if(ReverseOnOpen==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _ReverseOnOpen+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0493
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
	GOTO        L_Menu0494
L_Menu0493:
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
L_Menu0494:
L_Menu0492:
;FirmV_0_7_0.c,2209 :: 		if(MenuPointer==21)
	MOVF        _MenuPointer+0, 0 
	XORLW       21
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0495
;FirmV_0_7_0.c,2210 :: 		{memcpy(LCDLine1,"21 Reverse Close ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2211 :: 		if(ReverseOnClose==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _ReverseOnClose+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0496
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr105_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr105_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0497
L_Menu0496:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr106_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr106_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0497:
L_Menu0495:
;FirmV_0_7_0.c,2213 :: 		if(MenuPointer==22)
	MOVF        _MenuPointer+0, 0 
	XORLW       22
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0498
;FirmV_0_7_0.c,2214 :: 		{memcpy(LCDLine1,"22 Lock Force   ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,2215 :: 		if(LockForce==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0499
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr108_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr108_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0500
L_Menu0499:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr109_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr109_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0500:
L_Menu0498:
;FirmV_0_7_0.c,2217 :: 		if(MenuPointer==23)
	MOVF        _MenuPointer+0, 0 
	XORLW       23
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0501
;FirmV_0_7_0.c,2218 :: 		{memcpy(LCDLine1,"23 Au-Cl Pass   ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2219 :: 		charValueToStr(CloseAfterPass,LCDLine2+6);}
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0501:
;FirmV_0_7_0.c,2221 :: 		if(MenuPointer==24)
	MOVF        _MenuPointer+0, 0 
	XORLW       24
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0502
;FirmV_0_7_0.c,2222 :: 		{memcpy(LCDLine1,"24 Save Changes ",16);LCDUpdateFlag=1;}
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
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_Menu0502:
;FirmV_0_7_0.c,2224 :: 		if(MenuPointer==25)
	MOVF        _MenuPointer+0, 0 
	XORLW       25
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0503
;FirmV_0_7_0.c,2225 :: 		{memcpy(LCDLine1,"25 Discard Exit ",16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_Menu0503:
;FirmV_0_7_0.c,2228 :: 		State=101;
	MOVLW       101
	MOVWF       _State+0 
;FirmV_0_7_0.c,2229 :: 		}
L_end_Menu0:
	RETURN      0
; end of _Menu0

_About:

;FirmV_0_7_0.c,2237 :: 		void About()
;FirmV_0_7_0.c,2239 :: 		if((Events.Keys.b1==1))
	BTFSS       _Events+0, 1 
	GOTO        L_About504
;FirmV_0_7_0.c,2240 :: 		AboutCounter=AboutCounter+1;
	INCF        _AboutCounter+0, 1 
L_About504:
;FirmV_0_7_0.c,2242 :: 		if(AboutCounter==1)
	MOVF        _AboutCounter+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_About505
;FirmV_0_7_0.c,2243 :: 		{memcpy(LCDLine1,Crypto[2],16);
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
;FirmV_0_7_0.c,2244 :: 		memcpy(LCDLine2,Crypto[3],16);
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
;FirmV_0_7_0.c,2245 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2246 :: 		}
L_About505:
;FirmV_0_7_0.c,2248 :: 		if(AboutCounter==2)
	MOVF        _AboutCounter+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_About506
;FirmV_0_7_0.c,2249 :: 		{memcpy(LCDLine1,Crypto[4],16);
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
;FirmV_0_7_0.c,2250 :: 		memcpy(LCDLine2,Crypto[5],16);
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
;FirmV_0_7_0.c,2251 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2252 :: 		}
L_About506:
;FirmV_0_7_0.c,2254 :: 		if(AboutCounter==3)
	MOVF        _AboutCounter+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_About507
;FirmV_0_7_0.c,2255 :: 		{State=100;}
	MOVLW       100
	MOVWF       _State+0 
L_About507:
;FirmV_0_7_0.c,2256 :: 		}
L_end_About:
	RETURN      0
; end of _About

_Menu1:

;FirmV_0_7_0.c,2265 :: 		void Menu1()
;FirmV_0_7_0.c,2268 :: 		if((Events.Keys.b0==1))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu1508
;FirmV_0_7_0.c,2269 :: 		{if(MenuPointer==0){MenuPointer=25;}else{MenuPointer=MenuPointer-1;}State=100;}
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1509
	MOVLW       25
	MOVWF       _MenuPointer+0 
	GOTO        L_Menu1510
L_Menu1509:
	DECF        _MenuPointer+0, 1 
L_Menu1510:
	MOVLW       100
	MOVWF       _State+0 
L_Menu1508:
;FirmV_0_7_0.c,2271 :: 		if((Events.Keys.b2==1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu1511
;FirmV_0_7_0.c,2272 :: 		{if(MenuPointer==25){MenuPointer=0;}else{MenuPointer=MenuPointer+1;}State=100;}
	MOVF        _MenuPointer+0, 0 
	XORLW       25
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1512
	CLRF        _MenuPointer+0 
	GOTO        L_Menu1513
L_Menu1512:
	INCF        _MenuPointer+0, 1 
L_Menu1513:
	MOVLW       100
	MOVWF       _State+0 
L_Menu1511:
;FirmV_0_7_0.c,2274 :: 		if((Events.Keys.b1==1))
	BTFSS       _Events+0, 1 
	GOTO        L_Menu1514
;FirmV_0_7_0.c,2275 :: 		{State=102;}
	MOVLW       102
	MOVWF       _State+0 
L_Menu1514:
;FirmV_0_7_0.c,2277 :: 		if(Events.Keys==0b101)
	MOVF        _Events+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1515
;FirmV_0_7_0.c,2278 :: 		{memcpy(LCDLine1,Crypto[0],16);AboutCounter=0;memcpy(LCDLine2,Crypto[1],16);LCDLines=2;LCDUpdateFlag=1;State=250;}
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
L_Menu1515:
;FirmV_0_7_0.c,2281 :: 		}
L_end_Menu1:
	RETURN      0
; end of _Menu1

_Menu2:

;FirmV_0_7_0.c,2289 :: 		void Menu2()
;FirmV_0_7_0.c,2292 :: 		LCDFlash=1;
	MOVLW       1
	MOVWF       _LCDFlash+0 
;FirmV_0_7_0.c,2294 :: 		if(Events.Keys.b1==1)
	BTFSS       _Events+0, 1 
	GOTO        L_Menu2516
;FirmV_0_7_0.c,2296 :: 		LCDFlash=0;LCDFlashFlag=0;State=101;;Menu0();
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
	MOVLW       101
	MOVWF       _State+0 
	CALL        _Menu0+0, 0
;FirmV_0_7_0.c,2297 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2517
;FirmV_0_7_0.c,2299 :: 		LearnPhase=0;
	CLRF        _LearnPhase+0 
;FirmV_0_7_0.c,2300 :: 		if(LearningMode==0)
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2518
;FirmV_0_7_0.c,2301 :: 		{State=200;LongBuzzFlag=1;}
	MOVLW       200
	MOVWF       _State+0 
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
L_Menu2518:
;FirmV_0_7_0.c,2302 :: 		if(LearningMode==1)
	MOVF        _LearningMode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2519
;FirmV_0_7_0.c,2303 :: 		{State=201;LongBuzzFlag=1;}
	MOVLW       201
	MOVWF       _State+0 
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
L_Menu2519:
;FirmV_0_7_0.c,2304 :: 		}
L_Menu2517:
;FirmV_0_7_0.c,2305 :: 		}
L_Menu2516:
;FirmV_0_7_0.c,2308 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2520
;FirmV_0_7_0.c,2309 :: 		{ if((Events.Keys.b0==1)&&(LearningMode>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2523
	MOVF        _LearningMode+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2523
L__Menu2988:
;FirmV_0_7_0.c,2310 :: 		{LearningMode=LearningMode-1;Menu0();State=102;}
	DECF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2523:
;FirmV_0_7_0.c,2311 :: 		if((Events.Keys.b2==1)&&(LearningMode<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2526
	MOVLW       1
	SUBWF       _LearningMode+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2526
L__Menu2987:
;FirmV_0_7_0.c,2312 :: 		{LearningMode=LearningMode+1;Menu0();State=102;}
	INCF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2526:
;FirmV_0_7_0.c,2313 :: 		}
L_Menu2520:
;FirmV_0_7_0.c,2317 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2527
;FirmV_0_7_0.c,2318 :: 		{ if((Events.Keys.b0==1)&&(Door1OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2530
	MOVF        _Door1OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2530
L__Menu2986:
;FirmV_0_7_0.c,2319 :: 		{Door1OpenTime=Door1OpenTime-1;Menu0();State=102;}
	DECF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2530:
;FirmV_0_7_0.c,2320 :: 		if((Events.Keys.b2==1)&&(Door1OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2533
	MOVLW       255
	SUBWF       _Door1OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2533
L__Menu2985:
;FirmV_0_7_0.c,2321 :: 		{Door1OpenTime=Door1OpenTime+1;Menu0();State=102;}
	INCF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2533:
;FirmV_0_7_0.c,2322 :: 		}
L_Menu2527:
;FirmV_0_7_0.c,2326 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2534
;FirmV_0_7_0.c,2327 :: 		{ if((Events.Keys.b0==1)&&(Door2OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2537
	MOVF        _Door2OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2537
L__Menu2984:
;FirmV_0_7_0.c,2328 :: 		{Door2OpenTime=Door2OpenTime-1;Menu0();State=102;}
	DECF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2537:
;FirmV_0_7_0.c,2329 :: 		if((Events.Keys.b2==1)&&(Door2OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2540
	MOVLW       255
	SUBWF       _Door2OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2540
L__Menu2983:
;FirmV_0_7_0.c,2330 :: 		{Door2OpenTime=Door2OpenTime+1;Menu0();State=102;}
	INCF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2540:
;FirmV_0_7_0.c,2331 :: 		}
L_Menu2534:
;FirmV_0_7_0.c,2334 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2541
;FirmV_0_7_0.c,2335 :: 		{ if((Events.Keys.b0==1)&&(Door1CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2544
	MOVF        _Door1CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2544
L__Menu2982:
;FirmV_0_7_0.c,2336 :: 		{Door1CloseTime=Door1CloseTime-1;Menu0();State=102;}
	DECF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2544:
;FirmV_0_7_0.c,2337 :: 		if((Events.Keys.b2==1)&&(Door1CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2547
	MOVLW       255
	SUBWF       _Door1CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2547
L__Menu2981:
;FirmV_0_7_0.c,2338 :: 		{Door1CloseTime=Door1CloseTime+1;Menu0();State=102;}
	INCF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2547:
;FirmV_0_7_0.c,2339 :: 		}
L_Menu2541:
;FirmV_0_7_0.c,2342 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2548
;FirmV_0_7_0.c,2343 :: 		{ if((Events.Keys.b0==1)&&(Door2CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2551
	MOVF        _Door2CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2551
L__Menu2980:
;FirmV_0_7_0.c,2344 :: 		{Door2CloseTime=Door2CloseTime-1;Menu0();State=102;}
	DECF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2551:
;FirmV_0_7_0.c,2345 :: 		if((Events.Keys.b2==1)&&(Door2CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2554
	MOVLW       255
	SUBWF       _Door2CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2554
L__Menu2979:
;FirmV_0_7_0.c,2346 :: 		{Door2CloseTime=Door2CloseTime+1;Menu0();State=102;}
	INCF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2554:
;FirmV_0_7_0.c,2347 :: 		}
L_Menu2548:
;FirmV_0_7_0.c,2351 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2555
;FirmV_0_7_0.c,2352 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2558
	MOVF        _OpenSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2558
L__Menu2978:
;FirmV_0_7_0.c,2353 :: 		{OpenSoftStartTime=OpenSoftStartTime-1;Menu0();State=102;}
	DECF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2558:
;FirmV_0_7_0.c,2354 :: 		if((Events.Keys.b2==1)&&(OpenSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2561
	MOVLW       255
	SUBWF       _OpenSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2561
L__Menu2977:
;FirmV_0_7_0.c,2355 :: 		{OpenSoftStartTime=OpenSoftStartTime+1;Menu0();State=102;}
	INCF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2561:
;FirmV_0_7_0.c,2356 :: 		}
L_Menu2555:
;FirmV_0_7_0.c,2359 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2562
;FirmV_0_7_0.c,2360 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2565
	MOVF        _OpenSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2565
L__Menu2976:
;FirmV_0_7_0.c,2361 :: 		{OpenSoftStopTime=OpenSoftStopTime-1;Menu0();State=102;}
	DECF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2565:
;FirmV_0_7_0.c,2362 :: 		if((Events.Keys.b2==1)&&(OpenSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2568
	MOVLW       255
	SUBWF       _OpenSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2568
L__Menu2975:
;FirmV_0_7_0.c,2363 :: 		{OpenSoftStopTime=OpenSoftStopTime+1;Menu0();State=102;}
	INCF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2568:
;FirmV_0_7_0.c,2364 :: 		}
L_Menu2562:
;FirmV_0_7_0.c,2367 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2569
;FirmV_0_7_0.c,2368 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2572
	MOVF        _CloseSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2572
L__Menu2974:
;FirmV_0_7_0.c,2369 :: 		{CloseSoftStartTime=CloseSoftStartTime-1;Menu0();State=102;}
	DECF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2572:
;FirmV_0_7_0.c,2370 :: 		if((Events.Keys.b2==1)&&(CloseSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2575
	MOVLW       255
	SUBWF       _CloseSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2575
L__Menu2973:
;FirmV_0_7_0.c,2371 :: 		{CloseSoftStartTime=CloseSoftStartTime+1;Menu0();State=102;}
	INCF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2575:
;FirmV_0_7_0.c,2372 :: 		}
L_Menu2569:
;FirmV_0_7_0.c,2375 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2576
;FirmV_0_7_0.c,2376 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2579
	MOVF        _CloseSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2579
L__Menu2972:
;FirmV_0_7_0.c,2377 :: 		{CloseSoftStopTime=CloseSoftStopTime-1;Menu0();State=102;}
	DECF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2579:
;FirmV_0_7_0.c,2378 :: 		if((Events.Keys.b2==1)&&(CloseSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2582
	MOVLW       255
	SUBWF       _CloseSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2582
L__Menu2971:
;FirmV_0_7_0.c,2379 :: 		{CloseSoftStopTime=CloseSoftStopTime+1;Menu0();State=102;}
	INCF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2582:
;FirmV_0_7_0.c,2380 :: 		}
L_Menu2576:
;FirmV_0_7_0.c,2384 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2583
;FirmV_0_7_0.c,2385 :: 		{ if((Events.Keys.b0==1)&&(M1SoftPower>1))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2586
	MOVLW       0
	MOVWF       R0 
	MOVF        _M1SoftPower+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu21084
	MOVF        _M1SoftPower+0, 0 
	SUBLW       1
L__Menu21084:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2586
L__Menu2970:
;FirmV_0_7_0.c,2386 :: 		{M1SoftPower=M1SoftPower-1;Menu0();State=102;}
	MOVLW       1
	SUBWF       _M1SoftPower+0, 1 
	MOVLW       0
	SUBWFB      _M1SoftPower+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2586:
;FirmV_0_7_0.c,2387 :: 		if((Events.Keys.b2==1)&&(M1SoftPower<10))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2589
	MOVLW       0
	SUBWF       _M1SoftPower+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu21085
	MOVLW       10
	SUBWF       _M1SoftPower+0, 0 
L__Menu21085:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2589
L__Menu2969:
;FirmV_0_7_0.c,2388 :: 		{M1SoftPower=M1SoftPower+1;Menu0();State=102;}
	INFSNZ      _M1SoftPower+0, 1 
	INCF        _M1SoftPower+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2589:
;FirmV_0_7_0.c,2389 :: 		}
L_Menu2583:
;FirmV_0_7_0.c,2392 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2590
;FirmV_0_7_0.c,2393 :: 		{ if((Events.Keys.b0==1)&&(M2SoftPower>1))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2593
	MOVLW       0
	MOVWF       R0 
	MOVF        _M2SoftPower+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu21086
	MOVF        _M2SoftPower+0, 0 
	SUBLW       1
L__Menu21086:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2593
L__Menu2968:
;FirmV_0_7_0.c,2394 :: 		{M2SoftPower=M2SoftPower-1;Menu0();State=102;}
	MOVLW       1
	SUBWF       _M2SoftPower+0, 1 
	MOVLW       0
	SUBWFB      _M2SoftPower+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2593:
;FirmV_0_7_0.c,2395 :: 		if((Events.Keys.b2==1)&&(M2SoftPower<10))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2596
	MOVLW       0
	SUBWF       _M2SoftPower+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu21087
	MOVLW       10
	SUBWF       _M2SoftPower+0, 0 
L__Menu21087:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2596
L__Menu2967:
;FirmV_0_7_0.c,2396 :: 		{M2SoftPower=M2SoftPower+1;Menu0();State=102;}
	INFSNZ      _M2SoftPower+0, 1 
	INCF        _M2SoftPower+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2596:
;FirmV_0_7_0.c,2397 :: 		}
L_Menu2590:
;FirmV_0_7_0.c,2401 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2597
;FirmV_0_7_0.c,2402 :: 		{ if((Events.Keys.b0==1)&&(OverloadSens1>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2600
	MOVF        _OverloadSens1+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2600
L__Menu2966:
;FirmV_0_7_0.c,2403 :: 		{OverloadSens1=OverloadSens1-1;Menu0();State=102;}
	DECF        _OverloadSens1+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2600:
;FirmV_0_7_0.c,2404 :: 		if((Events.Keys.b2==1)&&(OverloadSens1<15))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2603
	MOVLW       15
	SUBWF       _OverloadSens1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2603
L__Menu2965:
;FirmV_0_7_0.c,2405 :: 		{OverloadSens1=OverloadSens1+1;Menu0();State=102;}
	INCF        _OverloadSens1+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2603:
;FirmV_0_7_0.c,2406 :: 		}
L_Menu2597:
;FirmV_0_7_0.c,2410 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2604
;FirmV_0_7_0.c,2411 :: 		{ if((Events.Keys.b0==1)&&(OverloadSens2>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2607
	MOVF        _OverloadSens2+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2607
L__Menu2964:
;FirmV_0_7_0.c,2412 :: 		{OverloadSens2=OverloadSens2-1;Menu0();State=102;}
	DECF        _OverloadSens2+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2607:
;FirmV_0_7_0.c,2413 :: 		if((Events.Keys.b2==1)&&(OverloadSens2<15))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2610
	MOVLW       15
	SUBWF       _OverloadSens2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2610
L__Menu2963:
;FirmV_0_7_0.c,2414 :: 		{OverloadSens2=OverloadSens2+1;Menu0();State=102;}
	INCF        _OverloadSens2+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2610:
;FirmV_0_7_0.c,2415 :: 		}
L_Menu2604:
;FirmV_0_7_0.c,2418 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2611
;FirmV_0_7_0.c,2419 :: 		{ if((Events.Keys.b0==1)&&(OverloadTime1>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2614
	MOVF        _OverloadTime1+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2614
L__Menu2962:
;FirmV_0_7_0.c,2420 :: 		{OverloadTime1=OverloadTime1-1;Menu0();State=102;}
	DECF        _OverloadTime1+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2614:
;FirmV_0_7_0.c,2421 :: 		if((Events.Keys.b2==1)&&(OverloadTime1<10))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2617
	MOVLW       10
	SUBWF       _OverloadTime1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2617
L__Menu2961:
;FirmV_0_7_0.c,2422 :: 		{OverloadTime1=OverloadTime1+1;Menu0();State=102;}
	INCF        _OverloadTime1+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2617:
;FirmV_0_7_0.c,2423 :: 		}
L_Menu2611:
;FirmV_0_7_0.c,2427 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2618
;FirmV_0_7_0.c,2428 :: 		{ if((Events.Keys.b0==1)&&(OverloadTime2>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2621
	MOVF        _OverloadTime2+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2621
L__Menu2960:
;FirmV_0_7_0.c,2429 :: 		{OverloadTime2=OverloadTime2-1;Menu0();State=102;}
	DECF        _OverloadTime2+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2621:
;FirmV_0_7_0.c,2430 :: 		if((Events.Keys.b2==1)&&(OverloadTime2<10))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2624
	MOVLW       10
	SUBWF       _OverloadTime2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2624
L__Menu2959:
;FirmV_0_7_0.c,2431 :: 		{OverloadTime2=OverloadTime2+1;Menu0();State=102;}
	INCF        _OverloadTime2+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2624:
;FirmV_0_7_0.c,2432 :: 		}
L_Menu2618:
;FirmV_0_7_0.c,2435 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2625
;FirmV_0_7_0.c,2436 :: 		{ if((Events.Keys.b0==1)&&(ActionTimeDiff>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2628
	MOVF        _ActionTimeDiff+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2628
L__Menu2958:
;FirmV_0_7_0.c,2437 :: 		{ActionTimeDiff=ActionTimeDiff-1;Menu0();State=102;}
	DECF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2628:
;FirmV_0_7_0.c,2438 :: 		if((Events.Keys.b2==1)&&(ActionTimeDiff<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2631
	MOVLW       255
	SUBWF       _ActionTimeDiff+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2631
L__Menu2957:
;FirmV_0_7_0.c,2439 :: 		{ActionTimeDiff=ActionTimeDiff+1;Menu0();State=102;}
	INCF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2631:
;FirmV_0_7_0.c,2440 :: 		}
L_Menu2625:
;FirmV_0_7_0.c,2443 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2632
;FirmV_0_7_0.c,2444 :: 		{ if((Events.Keys.b0==1)&&(AutoCloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2635
	MOVLW       0
	MOVWF       R0 
	MOVF        _AutoCloseTime+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu21088
	MOVF        _AutoCloseTime+0, 0 
	SUBLW       0
L__Menu21088:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2635
L__Menu2956:
;FirmV_0_7_0.c,2445 :: 		{AutoCloseTime=AutoCloseTime-1;Menu0();State=102;}
	MOVLW       1
	SUBWF       _AutoCloseTime+0, 1 
	MOVLW       0
	SUBWFB      _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2635:
;FirmV_0_7_0.c,2446 :: 		if((Events.Keys.b2==1)&&(AutoCloseTime<65000))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2638
	MOVLW       253
	SUBWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu21089
	MOVLW       232
	SUBWF       _AutoCloseTime+0, 0 
L__Menu21089:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2638
L__Menu2955:
;FirmV_0_7_0.c,2447 :: 		{AutoCloseTime=AutoCloseTime+1;Menu0();State=102;}
	INFSNZ      _AutoCloseTime+0, 1 
	INCF        _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2638:
;FirmV_0_7_0.c,2448 :: 		}
L_Menu2632:
;FirmV_0_7_0.c,2451 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2639
;FirmV_0_7_0.c,2453 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2454 :: 		memcpy(LCDLine1,Sipher,16);
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
;FirmV_0_7_0.c,2455 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2456 :: 		LCDFlash=0; LCDFlashFlag=0;
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,2457 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2458 :: 		LongBuzzFlag=1;
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
;FirmV_0_7_0.c,2459 :: 		FactorySettings();
	CALL        _FactorySettings+0, 0
;FirmV_0_7_0.c,2460 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2461 :: 		}
L_Menu2639:
;FirmV_0_7_0.c,2464 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2640
;FirmV_0_7_0.c,2465 :: 		{ if((Events.Keys.b0==1)&&(OpenPhEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2643
	MOVF        _OpenPhEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2643
L__Menu2954:
;FirmV_0_7_0.c,2466 :: 		{OpenPhEnable=OpenPhEnable-1;Menu0();State=102;}
	DECF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2643:
;FirmV_0_7_0.c,2467 :: 		if((Events.Keys.b2==1)&&(OpenPhEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2646
	MOVLW       1
	SUBWF       _OpenPhEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2646
L__Menu2953:
;FirmV_0_7_0.c,2468 :: 		{OpenPhEnable=OpenPhEnable+1;Menu0();State=102;}
	INCF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2646:
;FirmV_0_7_0.c,2469 :: 		}
L_Menu2640:
;FirmV_0_7_0.c,2473 :: 		if(MenuPointer==19)
	MOVF        _MenuPointer+0, 0 
	XORLW       19
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2647
;FirmV_0_7_0.c,2474 :: 		{ if((Events.Keys.b0==1)&&(LimiterEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2650
	MOVF        _LimiterEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2650
L__Menu2952:
;FirmV_0_7_0.c,2475 :: 		{LimiterEnable=LimiterEnable-1;Menu0();State=102;}
	DECF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2650:
;FirmV_0_7_0.c,2476 :: 		if((Events.Keys.b2==1)&&(LimiterEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2653
	MOVLW       1
	SUBWF       _LimiterEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2653
L__Menu2951:
;FirmV_0_7_0.c,2477 :: 		{LimiterEnable=LimiterEnable+1;Menu0();State=102;}
	INCF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2653:
;FirmV_0_7_0.c,2478 :: 		}
L_Menu2647:
;FirmV_0_7_0.c,2481 :: 		if(MenuPointer==20)
	MOVF        _MenuPointer+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2654
;FirmV_0_7_0.c,2482 :: 		{ if((Events.Keys.b0==1)&&(ReverseOnOpen>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2657
	MOVF        _ReverseOnOpen+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2657
L__Menu2950:
;FirmV_0_7_0.c,2483 :: 		{ReverseOnOpen=ReverseOnOpen-1;Menu0();State=102;}
	DECF        _ReverseOnOpen+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2657:
;FirmV_0_7_0.c,2484 :: 		if((Events.Keys.b2==1)&&(ReverseOnOpen<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2660
	MOVLW       1
	SUBWF       _ReverseOnOpen+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2660
L__Menu2949:
;FirmV_0_7_0.c,2485 :: 		{ReverseOnOpen=ReverseOnOpen+1;Menu0();State=102;}
	INCF        _ReverseOnOpen+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2660:
;FirmV_0_7_0.c,2486 :: 		}
L_Menu2654:
;FirmV_0_7_0.c,2490 :: 		if(MenuPointer==21)
	MOVF        _MenuPointer+0, 0 
	XORLW       21
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2661
;FirmV_0_7_0.c,2491 :: 		{ if((Events.Keys.b0==1)&&(ReverseOnClose>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2664
	MOVF        _ReverseOnClose+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2664
L__Menu2948:
;FirmV_0_7_0.c,2492 :: 		{ReverseOnClose=ReverseOnClose-1;Menu0();State=102;}
	DECF        _ReverseOnClose+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2664:
;FirmV_0_7_0.c,2493 :: 		if((Events.Keys.b2==1)&&(ReverseOnClose<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2667
	MOVLW       1
	SUBWF       _ReverseOnClose+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2667
L__Menu2947:
;FirmV_0_7_0.c,2494 :: 		{ReverseOnClose=ReverseOnClose+1;Menu0();State=102;}
	INCF        _ReverseOnClose+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2667:
;FirmV_0_7_0.c,2495 :: 		}
L_Menu2661:
;FirmV_0_7_0.c,2498 :: 		if(MenuPointer==22)
	MOVF        _MenuPointer+0, 0 
	XORLW       22
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2668
;FirmV_0_7_0.c,2499 :: 		{ if((Events.Keys.b0==1)&&(LockForce>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2671
	MOVF        _LockForce+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2671
L__Menu2946:
;FirmV_0_7_0.c,2500 :: 		{LockForce=LockForce-1;Menu0();State=102;}
	DECF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2671:
;FirmV_0_7_0.c,2501 :: 		if((Events.Keys.b2==1)&&(LockForce<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2674
	MOVLW       1
	SUBWF       _LockForce+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2674
L__Menu2945:
;FirmV_0_7_0.c,2502 :: 		{LockForce=LockForce+1;Menu0();State=102;}
	INCF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2674:
;FirmV_0_7_0.c,2503 :: 		}
L_Menu2668:
;FirmV_0_7_0.c,2506 :: 		if(MenuPointer==23)
	MOVF        _MenuPointer+0, 0 
	XORLW       23
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2675
;FirmV_0_7_0.c,2507 :: 		{ if((Events.Keys.b0==1)&&(CloseAfterPass>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2678
	MOVF        _CloseAfterPass+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2678
L__Menu2944:
;FirmV_0_7_0.c,2508 :: 		{CloseAfterPass=CloseAfterPass-1;if(CloseAfterPass==9) CloseAfterPass=0;Menu0();State=102;}
	DECF        _CloseAfterPass+0, 1 
	MOVF        _CloseAfterPass+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2679
	CLRF        _CloseAfterPass+0 
L_Menu2679:
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2678:
;FirmV_0_7_0.c,2509 :: 		if((Events.Keys.b2==1)&&(CloseAfterPass<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2682
	MOVLW       255
	SUBWF       _CloseAfterPass+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2682
L__Menu2943:
;FirmV_0_7_0.c,2510 :: 		{CloseAfterPass=CloseAfterPass+1;if(CloseAfterPass==1) CloseAfterPass=10;Menu0();State=102;}
	INCF        _CloseAfterPass+0, 1 
	MOVF        _CloseAfterPass+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2683
	MOVLW       10
	MOVWF       _CloseAfterPass+0 
L_Menu2683:
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2682:
;FirmV_0_7_0.c,2511 :: 		}
L_Menu2675:
;FirmV_0_7_0.c,2514 :: 		if(MenuPointer==24)
	MOVF        _MenuPointer+0, 0 
	XORLW       24
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2684
;FirmV_0_7_0.c,2516 :: 		State=103;
	MOVLW       103
	MOVWF       _State+0 
;FirmV_0_7_0.c,2517 :: 		memcpy(LCDLine1,Sipher,16);
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
;FirmV_0_7_0.c,2518 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2519 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2520 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2521 :: 		LongBuzzFlag=1;
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
;FirmV_0_7_0.c,2522 :: 		}
L_Menu2684:
;FirmV_0_7_0.c,2525 :: 		if(MenuPointer==25)
	MOVF        _MenuPointer+0, 0 
	XORLW       25
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2685
;FirmV_0_7_0.c,2527 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2528 :: 		memcpy(LCDLine1,Sipher,16);
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
;FirmV_0_7_0.c,2529 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2530 :: 		LCDLines=1;
	MOVLW       1
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2531 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2532 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,2533 :: 		LongBuzzFlag=1;
	MOVLW       1
	MOVWF       _LongBuzzFlag+0 
;FirmV_0_7_0.c,2534 :: 		}
L_Menu2685:
;FirmV_0_7_0.c,2535 :: 		}
L_end_Menu2:
	RETURN      0
; end of _Menu2

_Menu3:

;FirmV_0_7_0.c,2547 :: 		void Menu3()
;FirmV_0_7_0.c,2549 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2550 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2551 :: 		}
L_end_Menu3:
	RETURN      0
; end of _Menu3

_LearnAuto:

;FirmV_0_7_0.c,2565 :: 		void LearnAuto()
;FirmV_0_7_0.c,2571 :: 		if(Events.Keys.b1)
	BTFSS       _Events+0, 1 
	GOTO        L_LearnAuto686
;FirmV_0_7_0.c,2573 :: 		State=1;
	MOVLW       1
	MOVWF       _State+0 
;FirmV_0_7_0.c,2574 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,2575 :: 		memcpy(LCDLine1,_open,16);
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
;FirmV_0_7_0.c,2576 :: 		memcpy(LCDLine2," Learn Canceled ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr113_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr113_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2577 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2578 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2579 :: 		}
L_LearnAuto686:
;FirmV_0_7_0.c,2581 :: 		switch(LearnPhase)
	GOTO        L_LearnAuto687
;FirmV_0_7_0.c,2583 :: 		case 0:
L_LearnAuto689:
;FirmV_0_7_0.c,2584 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,2586 :: 		if(Events.Remote.b0==1) {DoorNo=2; LearnPhase=LearnPhase+1;BuzzFlag=1;} if(Events.Remote.b1==1) {DoorNo=1;LearnPhase=3;BuzzFlag=1;}
	BTFSS       _Events+4, 0 
	GOTO        L_LearnAuto690
	MOVLW       2
	MOVWF       LearnAuto_DoorNo_L0+0 
	INCF        _LearnPhase+0, 1 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnAuto690:
	BTFSS       _Events+4, 1 
	GOTO        L_LearnAuto691
	MOVLW       1
	MOVWF       LearnAuto_DoorNo_L0+0 
	MOVLW       3
	MOVWF       _LearnPhase+0 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnAuto691:
;FirmV_0_7_0.c,2587 :: 		OverloadCheckFlag1=0;OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,2588 :: 		break;
	GOTO        L_LearnAuto688
;FirmV_0_7_0.c,2590 :: 		case 1: //Start D2 and enable overload sensing after 3s
L_LearnAuto692:
;FirmV_0_7_0.c,2591 :: 		StartMotor(2,_Close);AddTask(ms500+6,21);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2592 :: 		break;
	GOTO        L_LearnAuto688
;FirmV_0_7_0.c,2594 :: 		case 2: //Check if D2 reaches end of its course
L_LearnAuto693:
;FirmV_0_7_0.c,2595 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto696
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto696
L__LearnAuto994:
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnAuto696:
;FirmV_0_7_0.c,2596 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto697
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnAuto697:
;FirmV_0_7_0.c,2597 :: 		break;
	GOTO        L_LearnAuto688
;FirmV_0_7_0.c,2599 :: 		case 3: //Start D1 and enable overload sensin after 3 s
L_LearnAuto698:
;FirmV_0_7_0.c,2600 :: 		StartMotor(1,_Close);AddTask(ms500+6,20);LearnPhase=LearnPhase+1;;
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
;FirmV_0_7_0.c,2602 :: 		case 4: //Check if D1 reaches end of its course
L_LearnAuto699:
;FirmV_0_7_0.c,2603 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto702
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto702
L__LearnAuto993:
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnAuto702:
;FirmV_0_7_0.c,2604 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto703
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto703:
;FirmV_0_7_0.c,2605 :: 		break;
	GOTO        L_LearnAuto688
;FirmV_0_7_0.c,2607 :: 		case 5: //Start D1 for opening and save start time and enable overload sensing after 3s
L_LearnAuto704:
;FirmV_0_7_0.c,2608 :: 		startT=ms500;StartMotor(1,_Open);AddTask(ms500+6,20);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2609 :: 		break;
	GOTO        L_LearnAuto688
;FirmV_0_7_0.c,2611 :: 		case 6: //Check if D1 reaches end of its course and save the stop time
L_LearnAuto705:
;FirmV_0_7_0.c,2612 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);if(DoorNo==1)LearnPhase=11;else LearnPhase=LearnPhase+1;stopT=ms500;RawData.D1OpenTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto708
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto708
L__LearnAuto992:
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	MOVF        LearnAuto_DoorNo_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto709
	MOVLW       11
	MOVWF       _LearnPhase+0 
	GOTO        L_LearnAuto710
L_LearnAuto709:
	INCF        _LearnPhase+0, 1 
L_LearnAuto710:
	MOVF        LearnAuto_startT_L0+0, 0 
	SUBWF       _ms500+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnAuto_RawData_L0+1 
L_LearnAuto708:
;FirmV_0_7_0.c,2613 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto711
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto711:
;FirmV_0_7_0.c,2614 :: 		break;
	GOTO        L_LearnAuto688
;FirmV_0_7_0.c,2616 :: 		case 7: //Start D2 for opening and save start time and enable overload sensing after 3s
L_LearnAuto712:
;FirmV_0_7_0.c,2617 :: 		startT=ms500;StartMotor(2,_Open);AddTask(ms500+6,21);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2618 :: 		break;
	GOTO        L_LearnAuto688
;FirmV_0_7_0.c,2620 :: 		case 8: //Check if D2 reaches end of its course and save the stop time
L_LearnAuto713:
;FirmV_0_7_0.c,2621 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D2OpenTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto716
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto716
L__LearnAuto991:
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
L_LearnAuto716:
;FirmV_0_7_0.c,2622 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto717
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnAuto717:
;FirmV_0_7_0.c,2623 :: 		break;
	GOTO        L_LearnAuto688
;FirmV_0_7_0.c,2625 :: 		case 9: //Start D2 for closing and save start time and enable overload sensing after 6s
L_LearnAuto718:
;FirmV_0_7_0.c,2626 :: 		startT=ms500;StartMotor(2,_Close);AddTask(ms500+6,21);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2627 :: 		break;
	GOTO        L_LearnAuto688
;FirmV_0_7_0.c,2629 :: 		case 10: //Check if D2 reaches end of its course and save the stop time
L_LearnAuto719:
;FirmV_0_7_0.c,2630 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D2CloseTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto722
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto722
L__LearnAuto990:
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
L_LearnAuto722:
;FirmV_0_7_0.c,2631 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto723
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnAuto723:
;FirmV_0_7_0.c,2632 :: 		break;
	GOTO        L_LearnAuto688
;FirmV_0_7_0.c,2634 :: 		case 11: //Start D1 for closing and save start time and enable overload sensing after 3s
L_LearnAuto724:
;FirmV_0_7_0.c,2635 :: 		startT=ms500;StartMotor(1,_Close);AddTask(ms500+6,20);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2636 :: 		break;
	GOTO        L_LearnAuto688
;FirmV_0_7_0.c,2638 :: 		case 12: //Check if D1 reaches end of its course and save the stop time
L_LearnAuto725:
;FirmV_0_7_0.c,2639 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D1CloseTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto728
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto728
L__LearnAuto989:
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
L_LearnAuto728:
;FirmV_0_7_0.c,2640 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto729
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto729:
;FirmV_0_7_0.c,2641 :: 		break;
	GOTO        L_LearnAuto688
;FirmV_0_7_0.c,2643 :: 		case 13:
L_LearnAuto730:
;FirmV_0_7_0.c,2644 :: 		AutoLearnCalculator(&RawData);
	MOVLW       LearnAuto_RawData_L0+0
	MOVWF       FARG_AutoLearnCalculator+0 
	MOVLW       hi_addr(LearnAuto_RawData_L0+0)
	MOVWF       FARG_AutoLearnCalculator+1 
	CALL        _AutoLearnCalculator+0, 0
;FirmV_0_7_0.c,2645 :: 		SaveLearnData(&RawData,DoorNo);
	MOVLW       LearnAuto_RawData_L0+0
	MOVWF       FARG_SaveLearnData+0 
	MOVLW       hi_addr(LearnAuto_RawData_L0+0)
	MOVWF       FARG_SaveLearnData+1 
	MOVF        LearnAuto_DoorNo_L0+0, 0 
	MOVWF       FARG_SaveLearnData+0 
	CALL        _SaveLearnData+0, 0
;FirmV_0_7_0.c,2646 :: 		memcpy(LCDLine1," Learn Complete ",16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr114_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr114_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2647 :: 		memcpy(LCDLine2,"     Ready      ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr115_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr115_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2648 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2649 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2650 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,2652 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2653 :: 		break;
	GOTO        L_LearnAuto688
;FirmV_0_7_0.c,2656 :: 		}
L_LearnAuto687:
	MOVF        _LearnPhase+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto689
	MOVF        _LearnPhase+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto692
	MOVF        _LearnPhase+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto693
	MOVF        _LearnPhase+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto698
	MOVF        _LearnPhase+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto699
	MOVF        _LearnPhase+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto704
	MOVF        _LearnPhase+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto705
	MOVF        _LearnPhase+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto712
	MOVF        _LearnPhase+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto713
	MOVF        _LearnPhase+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto718
	MOVF        _LearnPhase+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto719
	MOVF        _LearnPhase+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto724
	MOVF        _LearnPhase+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto725
	MOVF        _LearnPhase+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto730
L_LearnAuto688:
;FirmV_0_7_0.c,2660 :: 		}
L_end_LearnAuto:
	RETURN      0
; end of _LearnAuto

_AutoLearnCalculator:

;FirmV_0_7_0.c,2680 :: 		void AutoLearnCalculator(Learn *raw)
;FirmV_0_7_0.c,2683 :: 		(*raw).D1OpenTime=(*raw).D1OpenTime+10;
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
;FirmV_0_7_0.c,2684 :: 		(*raw).D2OpenTime=(*raw).D2OpenTime+10;
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
;FirmV_0_7_0.c,2685 :: 		(*raw).D1CloseTime=(*raw).D1CloseTime+10;
	MOVFF       FARG_AutoLearnCalculator_raw+0, FSR0
	MOVFF       FARG_AutoLearnCalculator_raw+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       FARG_AutoLearnCalculator_raw+0, FSR1
	MOVFF       FARG_AutoLearnCalculator_raw+1, FSR1H
	MOVLW       10
	ADDWF       R0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2686 :: 		(*raw).D2CloseTime=(*raw).D2CloseTime+10;
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
;FirmV_0_7_0.c,2688 :: 		(*raw).D1OpenSoftStart=4;
	MOVLW       4
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2689 :: 		(*raw).D1CloseSoftStart=4;
	MOVLW       6
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2690 :: 		(*raw).D2OpenSoftStart=4;
	MOVLW       8
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2691 :: 		(*raw).D2CloseSoftStart=4;
	MOVLW       10
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2693 :: 		(*raw).D1OpenSoftStop=10;
	MOVLW       5
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2694 :: 		(*raw).D2OpenSoftStop=10;
	MOVLW       9
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2695 :: 		(*raw).D1CloseSoftStop=10;
	MOVLW       7
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2696 :: 		(*raw).D2CloseSoftStop=10;
	MOVLW       11
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2698 :: 		}
L_end_AutoLearnCalculator:
	RETURN      0
; end of _AutoLearnCalculator

_SaveLearnData:

;FirmV_0_7_0.c,2710 :: 		void SaveLearnData(Learn *d,char DCount)
;FirmV_0_7_0.c,2712 :: 		Door1OpenTime=(*d).D1OpenTime;
	MOVLW       1
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,2713 :: 		Door1CloseTime=(*d).D1CloseTime;
	MOVFF       FARG_SaveLearnData_d+0, FSR0
	MOVFF       FARG_SaveLearnData_d+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,2714 :: 		if(DCount==2)
	MOVF        FARG_SaveLearnData_DCount+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SaveLearnData731
;FirmV_0_7_0.c,2716 :: 		Door2OpenTime=(*d).D2OpenTime;
	MOVLW       3
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,2717 :: 		Door2CloseTime=(*d).D2CloseTime;
	MOVLW       2
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,2718 :: 		OpenSoftStartTime=((*d).D1OpenSoftStart+(*d).D2OpenSoftStart)/2;
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
;FirmV_0_7_0.c,2719 :: 		OpenSoftStopTime=((*d).D1OpenSoftStop+(*d).D2OpenSoftStop)/2;
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
;FirmV_0_7_0.c,2720 :: 		CloseSoftStartTime=((*d).D1CloseSoftStart+(*d).D2CloseSoftStart)/2;
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
;FirmV_0_7_0.c,2721 :: 		CloseSoftStopTime=((*d).D1CloseSoftStop+(*d).D2CloseSoftStop)/2;
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
;FirmV_0_7_0.c,2722 :: 		}
	GOTO        L_SaveLearnData732
L_SaveLearnData731:
;FirmV_0_7_0.c,2725 :: 		Door2OpenTime=0;
	CLRF        _Door2OpenTime+0 
;FirmV_0_7_0.c,2726 :: 		Door2CloseTime=0;
	CLRF        _Door2CloseTime+0 
;FirmV_0_7_0.c,2727 :: 		OpenSoftStartTime=(*d).D1OpenSoftStart;
	MOVLW       4
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,2728 :: 		OpenSoftStopTime=(*d).D1OpenSoftStop;
	MOVLW       5
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,2729 :: 		CloseSoftStartTime=(*d).D1CloseSoftStart;
	MOVLW       6
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,2730 :: 		CloseSoftStopTime=(*d).D1CloseSoftStop;
	MOVLW       7
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,2731 :: 		}
L_SaveLearnData732:
;FirmV_0_7_0.c,2733 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2734 :: 		}
L_end_SaveLearnData:
	RETURN      0
; end of _SaveLearnData

_LearnManual:

;FirmV_0_7_0.c,2749 :: 		void LearnManual()
;FirmV_0_7_0.c,2756 :: 		if(Events.Keys.b1)
	BTFSS       _Events+0, 1 
	GOTO        L_LearnManual733
;FirmV_0_7_0.c,2758 :: 		State=1;
	MOVLW       1
	MOVWF       _State+0 
;FirmV_0_7_0.c,2759 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,2760 :: 		memcpy(LCDLine1,_open,16);
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
;FirmV_0_7_0.c,2761 :: 		memcpy(LCDLine2," Learn Canceled ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr116_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr116_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2762 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2763 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2764 :: 		}
L_LearnManual733:
;FirmV_0_7_0.c,2766 :: 		switch(LearnPhase)
	GOTO        L_LearnManual734
;FirmV_0_7_0.c,2768 :: 		case 0:
L_LearnManual736:
;FirmV_0_7_0.c,2769 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,2771 :: 		if(Events.Remote.b0==1){LearnPhase=LearnPhase+1; DoorNo=2;BuzzFlag=1;}if(Events.Remote.b1==1){LearnPhase=3; DoorNo=1;BuzzFlag=1;}
	BTFSS       _Events+4, 0 
	GOTO        L_LearnManual737
	INCF        _LearnPhase+0, 1 
	MOVLW       2
	MOVWF       LearnManual_DoorNo_L0+0 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnManual737:
	BTFSS       _Events+4, 1 
	GOTO        L_LearnManual738
	MOVLW       3
	MOVWF       _LearnPhase+0 
	MOVLW       1
	MOVWF       LearnManual_DoorNo_L0+0 
	MOVLW       1
	MOVWF       _BuzzFlag+0 
L_LearnManual738:
;FirmV_0_7_0.c,2772 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2774 :: 		case 1: //Start D2 and enable overload sensing after 1s
L_LearnManual739:
;FirmV_0_7_0.c,2775 :: 		StartMotor(2,_Close);AddTask(ms500+4,21);LearnPhase=LearnPhase+1;OverloadCheckFlag2=0;
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
;FirmV_0_7_0.c,2776 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2778 :: 		case 2: //Check if D2 reaches end of its course
L_LearnManual740:
;FirmV_0_7_0.c,2779 :: 		if((Events.Overload.b1==1)&&(OverloadCheckFlag2==1)){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnManual743
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnManual743
L__LearnManual996:
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnManual743:
;FirmV_0_7_0.c,2780 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual744
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnManual744:
;FirmV_0_7_0.c,2781 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2783 :: 		case 3: //Start D1 and enable overload sensin after 1 s
L_LearnManual745:
;FirmV_0_7_0.c,2784 :: 		StartMotor(1,_Close);AddTask(ms500+4,20);LearnPhase=LearnPhase+1;;OverloadCheckFlag1=0;
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
;FirmV_0_7_0.c,2786 :: 		case 4: //Check if D1 reaches end of its course
L_LearnManual746:
;FirmV_0_7_0.c,2787 :: 		if((Events.Overload.b0==1)&&(OverloadCheckFlag1==1)){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnManual749
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnManual749
L__LearnManual995:
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnManual749:
;FirmV_0_7_0.c,2788 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual750
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnManual750:
;FirmV_0_7_0.c,2789 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2791 :: 		case 5: //Wait for remote to start D1 and slow down
L_LearnManual751:
;FirmV_0_7_0.c,2792 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(1,_Open);SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual752
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
L_LearnManual752:
;FirmV_0_7_0.c,2793 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2795 :: 		case 6: //check for Remote press and fast up
L_LearnManual753:
;FirmV_0_7_0.c,2796 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(1,Motor2FullSpeed);M1isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual754
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
L_LearnManual754:
;FirmV_0_7_0.c,2797 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2799 :: 		case 7: //check for Remote press and slow down
L_LearnManual755:
;FirmV_0_7_0.c,2800 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual756
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
L_LearnManual756:
;FirmV_0_7_0.c,2801 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2803 :: 		case 8: //check for Remote press and stop
L_LearnManual757:
;FirmV_0_7_0.c,2804 :: 		if(Events.Remote!=0){if(DoorNo==2)LearnPhase=LearnPhase+1;else LearnPhase=17;t4=ms500;StopMotor(1);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual758
	MOVF        LearnManual_DoorNo_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnManual759
	INCF        _LearnPhase+0, 1 
	GOTO        L_LearnManual760
L_LearnManual759:
	MOVLW       17
	MOVWF       _LearnPhase+0 
L_LearnManual760:
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
;FirmV_0_7_0.c,2805 :: 		RawData.D1OpenTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+1 
;FirmV_0_7_0.c,2806 :: 		RawData.D1OpenSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+4 
;FirmV_0_7_0.c,2807 :: 		RawData.D1OpenSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+5 
;FirmV_0_7_0.c,2808 :: 		}
L_LearnManual758:
;FirmV_0_7_0.c,2809 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2811 :: 		case 9: //Wait for remote to start D2 and slow down
L_LearnManual761:
;FirmV_0_7_0.c,2812 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(2,_Open);SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual762
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
L_LearnManual762:
;FirmV_0_7_0.c,2813 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2815 :: 		case 10: //check for Remote press and fast up
L_LearnManual763:
;FirmV_0_7_0.c,2816 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(Motor1FullSpeed,1);M2isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual764
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
L_LearnManual764:
;FirmV_0_7_0.c,2817 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2819 :: 		case 11: //check for Remote press and slow down
L_LearnManual765:
;FirmV_0_7_0.c,2820 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual766
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
L_LearnManual766:
;FirmV_0_7_0.c,2821 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2823 :: 		case 12: //check for Remote press and stop
L_LearnManual767:
;FirmV_0_7_0.c,2824 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(2);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual768
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
;FirmV_0_7_0.c,2825 :: 		RawData.D2OpenTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+3 
;FirmV_0_7_0.c,2826 :: 		RawData.D2OpenSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+8 
;FirmV_0_7_0.c,2827 :: 		RawData.D2OpenSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+9 
;FirmV_0_7_0.c,2828 :: 		}
L_LearnManual768:
;FirmV_0_7_0.c,2829 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2831 :: 		case 13: //Wait for remote to start D2 and slow down
L_LearnManual769:
;FirmV_0_7_0.c,2832 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(2,_Close);SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual770
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
L_LearnManual770:
;FirmV_0_7_0.c,2833 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2835 :: 		case 14: //check for Remote press and fast up
L_LearnManual771:
;FirmV_0_7_0.c,2836 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(Motor1FullSpeed,1);M2isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual772
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
L_LearnManual772:
;FirmV_0_7_0.c,2837 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2839 :: 		case 15: //check for Remote press and slow down
L_LearnManual773:
;FirmV_0_7_0.c,2840 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual774
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
L_LearnManual774:
;FirmV_0_7_0.c,2841 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2843 :: 		case 16: //check for Remote press and stop
L_LearnManual775:
;FirmV_0_7_0.c,2844 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(2);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual776
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
;FirmV_0_7_0.c,2845 :: 		RawData.D2CloseTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+2 
;FirmV_0_7_0.c,2846 :: 		RawData.D2CloseSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+10 
;FirmV_0_7_0.c,2847 :: 		RawData.D2CloseSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+11 
;FirmV_0_7_0.c,2848 :: 		}
L_LearnManual776:
;FirmV_0_7_0.c,2849 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2851 :: 		case 17: //Wait for remote to start D1 and slow down
L_LearnManual777:
;FirmV_0_7_0.c,2852 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(1,_Close);SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual778
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
L_LearnManual778:
;FirmV_0_7_0.c,2853 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2855 :: 		case 18: //check for Remote press and fast up
L_LearnManual779:
;FirmV_0_7_0.c,2856 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(1,Motor2FullSpeed);M1isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual780
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
L_LearnManual780:
;FirmV_0_7_0.c,2857 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2859 :: 		case 19: //check for Remote press and slow down
L_LearnManual781:
;FirmV_0_7_0.c,2860 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual782
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
L_LearnManual782:
;FirmV_0_7_0.c,2861 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2863 :: 		case 20: //check for Remote press and stop
L_LearnManual783:
;FirmV_0_7_0.c,2864 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(1);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual784
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
;FirmV_0_7_0.c,2865 :: 		RawData.D1CloseTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+0 
;FirmV_0_7_0.c,2866 :: 		RawData.D1CloseSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+6 
;FirmV_0_7_0.c,2867 :: 		RawData.D1CloseSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+7 
;FirmV_0_7_0.c,2868 :: 		}
L_LearnManual784:
;FirmV_0_7_0.c,2869 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2871 :: 		case 21:
L_LearnManual785:
;FirmV_0_7_0.c,2872 :: 		SaveLearnData(&RawData,DoorNo);
	MOVLW       LearnManual_RawData_L0+0
	MOVWF       FARG_SaveLearnData_d+0 
	MOVLW       hi_addr(LearnManual_RawData_L0+0)
	MOVWF       FARG_SaveLearnData_d+1 
	MOVF        LearnManual_DoorNo_L0+0, 0 
	MOVWF       FARG_SaveLearnData_DCount+0 
	CALL        _SaveLearnData+0, 0
;FirmV_0_7_0.c,2873 :: 		memcpy(LCDLine1," Learn Complete ",16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr117_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr117_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2874 :: 		memcpy(LCDLine2,"     Ready      ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr118_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr118_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2875 :: 		LCDLines=2;
	MOVLW       2
	MOVWF       _LCDLines+0 
;FirmV_0_7_0.c,2876 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2877 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,2879 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2880 :: 		break;
	GOTO        L_LearnManual735
;FirmV_0_7_0.c,2881 :: 		}
L_LearnManual734:
	MOVF        _LearnPhase+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual736
	MOVF        _LearnPhase+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual739
	MOVF        _LearnPhase+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual740
	MOVF        _LearnPhase+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual745
	MOVF        _LearnPhase+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual746
	MOVF        _LearnPhase+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual751
	MOVF        _LearnPhase+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual753
	MOVF        _LearnPhase+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual755
	MOVF        _LearnPhase+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual757
	MOVF        _LearnPhase+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual761
	MOVF        _LearnPhase+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual763
	MOVF        _LearnPhase+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual765
	MOVF        _LearnPhase+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual767
	MOVF        _LearnPhase+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual769
	MOVF        _LearnPhase+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual771
	MOVF        _LearnPhase+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual773
	MOVF        _LearnPhase+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual775
	MOVF        _LearnPhase+0, 0 
	XORLW       17
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual777
	MOVF        _LearnPhase+0, 0 
	XORLW       18
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual779
	MOVF        _LearnPhase+0, 0 
	XORLW       19
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual781
	MOVF        _LearnPhase+0, 0 
	XORLW       20
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual783
	MOVF        _LearnPhase+0, 0 
	XORLW       21
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual785
L_LearnManual735:
;FirmV_0_7_0.c,2882 :: 		}
L_end_LearnManual:
	RETURN      0
; end of _LearnManual

_charValueToStr:

;FirmV_0_7_0.c,2903 :: 		void charValueToStr(char val, char * string)
;FirmV_0_7_0.c,2905 :: 		bytetostr(val>>1,string);
	MOVF        FARG_charValueToStr_val+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVF        FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_ByteToStr_output+0 
	MOVF        FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,2906 :: 		if((val%2)==1)
	MOVLW       1
	ANDWF       FARG_charValueToStr_val+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_charValueToStr786
;FirmV_0_7_0.c,2907 :: 		memcpy(string+3,".5s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr119_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr119_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_charValueToStr787
L_charValueToStr786:
;FirmV_0_7_0.c,2909 :: 		memcpy(string+3,".0s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr120_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr120_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_charValueToStr787:
;FirmV_0_7_0.c,2910 :: 		}
L_end_charValueToStr:
	RETURN      0
; end of _charValueToStr

_charValueToStr_AC:

;FirmV_0_7_0.c,2919 :: 		void charValueToStr_AC(char val, char * string)
;FirmV_0_7_0.c,2921 :: 		bytetostr(val>>1,string);
	MOVF        FARG_charValueToStr_AC_val+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVF        FARG_charValueToStr_AC_string+0, 0 
	MOVWF       FARG_ByteToStr_output+0 
	MOVF        FARG_charValueToStr_AC_string+1, 0 
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,2922 :: 		memcpy(string+3,"s  ",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_AC_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_AC_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr121_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr121_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2923 :: 		}
L_end_charValueToStr_AC:
	RETURN      0
; end of _charValueToStr_AC

_intValueToStr:

;FirmV_0_7_0.c,2936 :: 		void intValueToStr(unsigned val, char * string)
;FirmV_0_7_0.c,2938 :: 		wordtostr(val>>1,string);
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
;FirmV_0_7_0.c,2939 :: 		if((val%2)==1)
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
	GOTO        L__intValueToStr1098
	MOVLW       1
	XORWF       R1, 0 
L__intValueToStr1098:
	BTFSS       STATUS+0, 2 
	GOTO        L_intValueToStr788
;FirmV_0_7_0.c,2940 :: 		memcpy(string+5,".5s",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr122_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr122_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_intValueToStr789
L_intValueToStr788:
;FirmV_0_7_0.c,2942 :: 		memcpy(string+5,".0s",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr123_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr123_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_intValueToStr789:
;FirmV_0_7_0.c,2943 :: 		}
L_end_intValueToStr:
	RETURN      0
; end of _intValueToStr

_SetOverloadParams:

;FirmV_0_7_0.c,2955 :: 		void SetOverloadParams(char p1, char d1,char p2, char d2)
;FirmV_0_7_0.c,2958 :: 		switch(p1)
	GOTO        L_SetOverloadParams790
;FirmV_0_7_0.c,2960 :: 		case 0: OverloadTreshold1=0; break;
L_SetOverloadParams792:
	CLRF        _OverloadTreshold1+0 
	CLRF        _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2962 :: 		case 1: OverloadTreshold1=480; break;
L_SetOverloadParams793:
	MOVLW       224
	MOVWF       _OverloadTreshold1+0 
	MOVLW       1
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2964 :: 		case 2: OverloadTreshold1=490; break;
L_SetOverloadParams794:
	MOVLW       234
	MOVWF       _OverloadTreshold1+0 
	MOVLW       1
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2966 :: 		case 3: OverloadTreshold1=500; break;
L_SetOverloadParams795:
	MOVLW       244
	MOVWF       _OverloadTreshold1+0 
	MOVLW       1
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2968 :: 		case 4: OverloadTreshold1=530; break;
L_SetOverloadParams796:
	MOVLW       18
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2970 :: 		case 5: OverloadTreshold1=550; break;
L_SetOverloadParams797:
	MOVLW       38
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2972 :: 		case 6: OverloadTreshold1=570; break;
L_SetOverloadParams798:
	MOVLW       58
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2974 :: 		case 7: OverloadTreshold1=600; break;
L_SetOverloadParams799:
	MOVLW       88
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2976 :: 		case 8: OverloadTreshold1=630; break;
L_SetOverloadParams800:
	MOVLW       118
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2978 :: 		case 9: OverloadTreshold1=650; break;
L_SetOverloadParams801:
	MOVLW       138
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2980 :: 		case 10: OverloadTreshold1=670; break;
L_SetOverloadParams802:
	MOVLW       158
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2982 :: 		case 11: OverloadTreshold1=700; break;
L_SetOverloadParams803:
	MOVLW       188
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2984 :: 		case 12: OverloadTreshold1=750; break;
L_SetOverloadParams804:
	MOVLW       238
	MOVWF       _OverloadTreshold1+0 
	MOVLW       2
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2986 :: 		case 13: OverloadTreshold1=800; break;
L_SetOverloadParams805:
	MOVLW       32
	MOVWF       _OverloadTreshold1+0 
	MOVLW       3
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2988 :: 		case 14: OverloadTreshold1=850; break;
L_SetOverloadParams806:
	MOVLW       82
	MOVWF       _OverloadTreshold1+0 
	MOVLW       3
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2990 :: 		case 15: OverloadTreshold1=900; break;
L_SetOverloadParams807:
	MOVLW       132
	MOVWF       _OverloadTreshold1+0 
	MOVLW       3
	MOVWF       _OverloadTreshold1+1 
	GOTO        L_SetOverloadParams791
;FirmV_0_7_0.c,2992 :: 		}
L_SetOverloadParams790:
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams792
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams793
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams794
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams795
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams796
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams797
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams798
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams799
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams800
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams801
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams802
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams803
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams804
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams805
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams806
	MOVF        FARG_SetOverloadParams_p1+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams807
L_SetOverloadParams791:
;FirmV_0_7_0.c,2995 :: 		switch(d1)
	GOTO        L_SetOverloadParams808
;FirmV_0_7_0.c,2997 :: 		case 0: OverloadDuration1=100; break;
L_SetOverloadParams810:
	MOVLW       100
	MOVWF       _OverloadDuration1+0 
	MOVLW       0
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams809
;FirmV_0_7_0.c,2999 :: 		case 1: OverloadDuration1=500; break;
L_SetOverloadParams811:
	MOVLW       244
	MOVWF       _OverloadDuration1+0 
	MOVLW       1
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams809
;FirmV_0_7_0.c,3001 :: 		case 2: OverloadDuration1=1000; break;
L_SetOverloadParams812:
	MOVLW       232
	MOVWF       _OverloadDuration1+0 
	MOVLW       3
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams809
;FirmV_0_7_0.c,3003 :: 		case 3: OverloadDuration1=1500; break;
L_SetOverloadParams813:
	MOVLW       220
	MOVWF       _OverloadDuration1+0 
	MOVLW       5
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams809
;FirmV_0_7_0.c,3005 :: 		case 4: OverloadDuration1=2000; break;
L_SetOverloadParams814:
	MOVLW       208
	MOVWF       _OverloadDuration1+0 
	MOVLW       7
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams809
;FirmV_0_7_0.c,3007 :: 		case 5: OverloadDuration1=2500; break;
L_SetOverloadParams815:
	MOVLW       196
	MOVWF       _OverloadDuration1+0 
	MOVLW       9
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams809
;FirmV_0_7_0.c,3009 :: 		case 6: OverloadDuration1=3000; break;
L_SetOverloadParams816:
	MOVLW       184
	MOVWF       _OverloadDuration1+0 
	MOVLW       11
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams809
;FirmV_0_7_0.c,3011 :: 		case 7: OverloadDuration1=3500; break;
L_SetOverloadParams817:
	MOVLW       172
	MOVWF       _OverloadDuration1+0 
	MOVLW       13
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams809
;FirmV_0_7_0.c,3013 :: 		case 8: OverloadDuration1=4000; break;
L_SetOverloadParams818:
	MOVLW       160
	MOVWF       _OverloadDuration1+0 
	MOVLW       15
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams809
;FirmV_0_7_0.c,3015 :: 		case 9: OverloadDuration1=4500; break;
L_SetOverloadParams819:
	MOVLW       148
	MOVWF       _OverloadDuration1+0 
	MOVLW       17
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams809
;FirmV_0_7_0.c,3017 :: 		case 10: OverloadDuration1=5000; break;
L_SetOverloadParams820:
	MOVLW       136
	MOVWF       _OverloadDuration1+0 
	MOVLW       19
	MOVWF       _OverloadDuration1+1 
	GOTO        L_SetOverloadParams809
;FirmV_0_7_0.c,3018 :: 		}
L_SetOverloadParams808:
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams810
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams811
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams812
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams813
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams814
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams815
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams816
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams817
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams818
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams819
	MOVF        FARG_SetOverloadParams_d1+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams820
L_SetOverloadParams809:
;FirmV_0_7_0.c,3024 :: 		switch(p2)
	GOTO        L_SetOverloadParams821
;FirmV_0_7_0.c,3026 :: 		case 0: OverloadTreshold2=0; break;
L_SetOverloadParams823:
	CLRF        _OverloadTreshold2+0 
	CLRF        _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3028 :: 		case 1: OverloadTreshold2=480; break;
L_SetOverloadParams824:
	MOVLW       224
	MOVWF       _OverloadTreshold2+0 
	MOVLW       1
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3030 :: 		case 2: OverloadTreshold2=490; break;
L_SetOverloadParams825:
	MOVLW       234
	MOVWF       _OverloadTreshold2+0 
	MOVLW       1
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3032 :: 		case 3: OverloadTreshold2=500; break;
L_SetOverloadParams826:
	MOVLW       244
	MOVWF       _OverloadTreshold2+0 
	MOVLW       1
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3034 :: 		case 4: OverloadTreshold2=530; break;
L_SetOverloadParams827:
	MOVLW       18
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3036 :: 		case 5: OverloadTreshold2=550; break;
L_SetOverloadParams828:
	MOVLW       38
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3038 :: 		case 6: OverloadTreshold2=570; break;
L_SetOverloadParams829:
	MOVLW       58
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3040 :: 		case 7: OverloadTreshold2=600; break;
L_SetOverloadParams830:
	MOVLW       88
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3042 :: 		case 8: OverloadTreshold2=630; break;
L_SetOverloadParams831:
	MOVLW       118
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3044 :: 		case 9: OverloadTreshold2=650; break;
L_SetOverloadParams832:
	MOVLW       138
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3046 :: 		case 10: OverloadTreshold2=670; break;
L_SetOverloadParams833:
	MOVLW       158
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3048 :: 		case 11: OverloadTreshold2=700; break;
L_SetOverloadParams834:
	MOVLW       188
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3050 :: 		case 12: OverloadTreshold2=750; break;
L_SetOverloadParams835:
	MOVLW       238
	MOVWF       _OverloadTreshold2+0 
	MOVLW       2
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3052 :: 		case 13: OverloadTreshold2=800; break;
L_SetOverloadParams836:
	MOVLW       32
	MOVWF       _OverloadTreshold2+0 
	MOVLW       3
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3054 :: 		case 14: OverloadTreshold2=850; break;
L_SetOverloadParams837:
	MOVLW       82
	MOVWF       _OverloadTreshold2+0 
	MOVLW       3
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3056 :: 		case 15: OverloadTreshold2=900; break;
L_SetOverloadParams838:
	MOVLW       132
	MOVWF       _OverloadTreshold2+0 
	MOVLW       3
	MOVWF       _OverloadTreshold2+1 
	GOTO        L_SetOverloadParams822
;FirmV_0_7_0.c,3058 :: 		}
L_SetOverloadParams821:
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams823
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams824
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams825
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams826
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams827
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams828
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams829
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams830
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams831
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams832
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams833
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams834
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams835
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams836
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams837
	MOVF        FARG_SetOverloadParams_p2+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams838
L_SetOverloadParams822:
;FirmV_0_7_0.c,3061 :: 		switch(d2)
	GOTO        L_SetOverloadParams839
;FirmV_0_7_0.c,3063 :: 		case 0: OverloadDuration2=100; break;
L_SetOverloadParams841:
	MOVLW       100
	MOVWF       _OverloadDuration2+0 
	MOVLW       0
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams840
;FirmV_0_7_0.c,3065 :: 		case 1: OverloadDuration2=500; break;
L_SetOverloadParams842:
	MOVLW       244
	MOVWF       _OverloadDuration2+0 
	MOVLW       1
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams840
;FirmV_0_7_0.c,3067 :: 		case 2: OverloadDuration2=1000; break;
L_SetOverloadParams843:
	MOVLW       232
	MOVWF       _OverloadDuration2+0 
	MOVLW       3
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams840
;FirmV_0_7_0.c,3069 :: 		case 3: OverloadDuration2=1500; break;
L_SetOverloadParams844:
	MOVLW       220
	MOVWF       _OverloadDuration2+0 
	MOVLW       5
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams840
;FirmV_0_7_0.c,3071 :: 		case 4: OverloadDuration2=2000; break;
L_SetOverloadParams845:
	MOVLW       208
	MOVWF       _OverloadDuration2+0 
	MOVLW       7
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams840
;FirmV_0_7_0.c,3073 :: 		case 5: OverloadDuration2=2500; break;
L_SetOverloadParams846:
	MOVLW       196
	MOVWF       _OverloadDuration2+0 
	MOVLW       9
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams840
;FirmV_0_7_0.c,3075 :: 		case 6: OverloadDuration2=3000; break;
L_SetOverloadParams847:
	MOVLW       184
	MOVWF       _OverloadDuration2+0 
	MOVLW       11
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams840
;FirmV_0_7_0.c,3077 :: 		case 7: OverloadDuration2=3500; break;
L_SetOverloadParams848:
	MOVLW       172
	MOVWF       _OverloadDuration2+0 
	MOVLW       13
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams840
;FirmV_0_7_0.c,3079 :: 		case 8: OverloadDuration2=4000; break;
L_SetOverloadParams849:
	MOVLW       160
	MOVWF       _OverloadDuration2+0 
	MOVLW       15
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams840
;FirmV_0_7_0.c,3081 :: 		case 9: OverloadDuration2=4500; break;
L_SetOverloadParams850:
	MOVLW       148
	MOVWF       _OverloadDuration2+0 
	MOVLW       17
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams840
;FirmV_0_7_0.c,3083 :: 		case 10: OverloadDuration2=5000; break;
L_SetOverloadParams851:
	MOVLW       136
	MOVWF       _OverloadDuration2+0 
	MOVLW       19
	MOVWF       _OverloadDuration2+1 
	GOTO        L_SetOverloadParams840
;FirmV_0_7_0.c,3084 :: 		}
L_SetOverloadParams839:
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams841
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams842
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams843
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams844
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams845
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams846
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams847
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams848
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams849
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams850
	MOVF        FARG_SetOverloadParams_d2+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams851
L_SetOverloadParams840:
;FirmV_0_7_0.c,3085 :: 		}
L_end_SetOverloadParams:
	RETURN      0
; end of _SetOverloadParams

_TorqueLogger:

;FirmV_0_7_0.c,3106 :: 		void TorqueLogger()
;FirmV_0_7_0.c,3109 :: 		switch(State)
	GOTO        L_TorqueLogger852
;FirmV_0_7_0.c,3111 :: 		case 3:
L_TorqueLogger854:
;FirmV_0_7_0.c,3112 :: 		txt[0]='D';txt[1]='3';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       51
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3113 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3114 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3115 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3117 :: 		txt[0]='D';txt[1]='3';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       51
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3118 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3119 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3120 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3122 :: 		break;
	GOTO        L_TorqueLogger853
;FirmV_0_7_0.c,3124 :: 		case 4:
L_TorqueLogger855:
;FirmV_0_7_0.c,3125 :: 		txt[0]='D';txt[1]='4';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       52
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3126 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3127 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3128 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3130 :: 		txt[0]='D';txt[1]='4';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       52
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3131 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3132 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3133 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3135 :: 		break;
	GOTO        L_TorqueLogger853
;FirmV_0_7_0.c,3137 :: 		case 7:
L_TorqueLogger856:
;FirmV_0_7_0.c,3138 :: 		txt[0]='D';txt[1]='7';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       55
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3139 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3140 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3141 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3143 :: 		txt[0]='D';txt[1]='7';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       55
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3144 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3145 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3146 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3148 :: 		break;
	GOTO        L_TorqueLogger853
;FirmV_0_7_0.c,3150 :: 		case 8:
L_TorqueLogger857:
;FirmV_0_7_0.c,3151 :: 		txt[0]='D';txt[1]='8';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       56
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3152 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3153 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3154 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3156 :: 		txt[0]='D';txt[1]='8';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       56
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3157 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3158 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3159 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3161 :: 		break;
	GOTO        L_TorqueLogger853
;FirmV_0_7_0.c,3163 :: 		case 200:
L_TorqueLogger858:
;FirmV_0_7_0.c,3164 :: 		txt[0]='D';txt[1]='L';txt[2]='1';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       76
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       49
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3165 :: 		wordtostrwithzeros(VCapM1,txt+4);
	MOVF        _VCapM1+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM1+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3166 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3167 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3169 :: 		txt[0]='D';txt[1]='L';txt[2]='2';txt[3]='-';
	MOVLW       68
	MOVWF       TorqueLogger_txt_L0+0 
	MOVLW       76
	MOVWF       TorqueLogger_txt_L0+1 
	MOVLW       50
	MOVWF       TorqueLogger_txt_L0+2 
	MOVLW       45
	MOVWF       TorqueLogger_txt_L0+3 
;FirmV_0_7_0.c,3170 :: 		wordtostrwithzeros(VCapM2,txt+4);
	MOVF        _VCapM2+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVF        _VCapM2+1, 0 
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       TorqueLogger_txt_L0+4
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+4)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;FirmV_0_7_0.c,3171 :: 		txt[9]=0;
	CLRF        TorqueLogger_txt_L0+9 
;FirmV_0_7_0.c,3172 :: 		Logger(txt,0);
	MOVLW       TorqueLogger_txt_L0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(TorqueLogger_txt_L0+0)
	MOVWF       FARG_Logger_text+1 
	CLRF        FARG_Logger_TimeStampFlag+0 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,3174 :: 		break;
	GOTO        L_TorqueLogger853
;FirmV_0_7_0.c,3176 :: 		}
L_TorqueLogger852:
	MOVF        _State+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger854
	MOVF        _State+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger855
	MOVF        _State+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger856
	MOVF        _State+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger857
	MOVF        _State+0, 0 
	XORLW       200
	BTFSC       STATUS+0, 2 
	GOTO        L_TorqueLogger858
L_TorqueLogger853:
;FirmV_0_7_0.c,3177 :: 		}
L_end_TorqueLogger:
	RETURN      0
; end of _TorqueLogger

_AutoClosePause:

;FirmV_0_7_0.c,3197 :: 		void AutoClosePause()
;FirmV_0_7_0.c,3200 :: 		if((AutoClosePauseFlag) && (Events.Photocell.b0==1))
	MOVF        _AutoClosePauseFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_AutoClosePause861
	BTFSS       _Events+6, 0 
	GOTO        L_AutoClosePause861
L__AutoClosePause998:
;FirmV_0_7_0.c,3201 :: 		for(i=0;i<20;i++)
	CLRF        AutoClosePause_i_L0+0 
L_AutoClosePause862:
	MOVLW       20
	SUBWF       AutoClosePause_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AutoClosePause863
;FirmV_0_7_0.c,3202 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode==9))
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        AutoClosePause_i_L0+0, 0 
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
	GOTO        L_AutoClosePause867
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        AutoClosePause_i_L0+0, 0 
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
	GOTO        L_AutoClosePause867
L__AutoClosePause997:
;FirmV_0_7_0.c,3203 :: 		{Tasks[i].Time=Tasks[i].Time+1;}
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        AutoClosePause_i_L0+0, 0 
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
	MOVWF       R4 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVFF       R4, FSR0
	MOVFF       R5, FSR0H
	MOVLW       1
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R3 
	MOVFF       R4, FSR1
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
L_AutoClosePause867:
;FirmV_0_7_0.c,3201 :: 		for(i=0;i<20;i++)
	INCF        AutoClosePause_i_L0+0, 1 
;FirmV_0_7_0.c,3203 :: 		{Tasks[i].Time=Tasks[i].Time+1;}
	GOTO        L_AutoClosePause862
L_AutoClosePause863:
L_AutoClosePause861:
;FirmV_0_7_0.c,3204 :: 		}
L_end_AutoClosePause:
	RETURN      0
; end of _AutoClosePause
