			.text
			.global _start

_start:		LDR 	R1, =0xFF200000 //LEDR port
			LDR 	R2, =0xFF200050 //KEYS port
			LDR 	R3, =0x00000001 //LEDR[0]
			LDR 	R4, =0x00000200 //LEDR[9] 
			MOV		R8, R3 //start with LEDR[0] on R8 will represent current LEDR info
			
			
			
			LDR 	R10, =0xFFFEC600
			LDR 	R0, =10000000
			STR 	R0, [R10] //write to load register
			MOV		R0, #0b011 //A = 1, E=1
			STR		R0, [R10, #8] //write to control register
			
						
SHIFT_L:	
			STR		R8, [R1]
			CMP 	R8, R4 //reaches LEDR[9]
			BEQ		SHIFT_R
			
			LSL		R8, #1
			BL		CheckKey
			BL		DELAY
			B		SHIFT_L

SHIFT_R:	
			STR		R8, [R1]
			CMP		R8, R3 //reaches LEDR[0]
			BEQ		SHIFT_L
	
			
			LSR		R8, #1
			BL		CheckKey
			BL		DELAY
			B		SHIFT_R
			
CheckKey:	MOV    	R7, #0
CheckLoop:	LDR   	R11, [R2]
			CMP     R11, #0b1000
			BNE     NoKey
PauseLoop:	LDR   	R11, [R2]
			CMP     R11, #0b1000
			BEQ     PauseLoop
			MVN     R7, R7
NoKey:  	CMP     R7, #0
			MOVEQ   PC, LR
			B		CheckLoop
			

DELAY:		
			LDR		R0, [R10, #0xC] //reads from status register
			CMP		R0, #0
			BEQ		DELAY
			STR		R0, [R10, #0xC] //reset F bit
			
	
			MOV		PC, LR

			

			
			
			
			