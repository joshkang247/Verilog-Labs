			.include "address_map_arm.s"
			.text
			.global	_start
_start:		MOV R0, #0b10010			//initialize the IRQ stack pointer 
			MSR CPSR, R0			
			LDR SP, =0x3FFFFFFC
			MOV R0, #0b10011			//initialize the SVC stack pointer 
			MSR CPSR, R0
			LDR SP, =0xFFFFFFFC
			MOV R9, #0
			
			BL	CONFIG_GIC				// configure the ARM generic interrupt controller
			BL	CONFIG_PRIV_TIMER		// configure the MPCore private timer
			BL	CONFIG_KEYS				// configure the pushbutton KEYs
			
			MSR CPSR, #0b00010011		//enable SVC mode
			LDR	R6, =0xFF200000 		// red LED base address

MAIN:		LDR	R4, LEDR_PATTERN		// LEDR pattern, modified by timer ISR
			STR R4, [R6] 				// write to red LEDs
			B 	MAIN

  
CONFIG_PRIV_TIMER:
			LDR	R0, =0xFFFEC600 		// Timer base address
			LDR R1, =20000000
			STR R1, [R0]
			LDR R2, =0b111
			STR R2, [R0, #8]
			MOV PC, LR 					// return

CONFIG_KEYS:
			LDR R0, =0xFF200050 		// KEYs base address
			LDR	R3, =0b1000
			STR	R3, [R0, #8]
			MOV PC, LR 					// return
			
			.global	LEDR_DIRECTION
LEDR_DIRECTION:
			.word 	0					// 0 means left, 1 means right

			.global	LEDR_PATTERN
LEDR_PATTERN:
			.word 	0x1
