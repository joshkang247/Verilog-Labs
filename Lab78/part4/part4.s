
			.text
			.global _start
_start:		
			LDR		SP, =0x3ffffffc
			LDR		R4, =TEST_NUM //load data word into R1
			MOV		R5, #0 //R5 gets 0
			MOV 	R6, #0 //R6 gets 0
			MOV 	R7, #0 //R7 gets 0

MAIN:		LDR 	R8, [R4], #4
			CMP		R8, #0
			BEQ 	END

			BL		ONES
			CMP 	R5, R0
			MOVLT	R5, R0

			BL		ZEROS
			CMP		R6, R0
			MOVLT	R6, R0

			BL		ALT
			CMP		R7, R0
			MOVLT	R7, R0

			B 		MAIN

END:		B 		END

ONES:		PUSH	{LR}
			MOV 	R0, #0
			MOV 	R1, R8

LOOP1:		CMP		R1, #0
			BEQ		END_ONES
			LSR		R2, R1, #1
			AND		R1, R1, R2
			ADD		R0, #1
			B 		LOOP1

END_ONES:	POP		{LR}
			MOV 	PC, LR

ZEROS:		PUSH	{LR}
			MOV 	R0, #0
			MOV 	R1, R8
			MOV     R3, #0xFFFFFFFF
			EOR		R1, R1, R3 //invert the word and find the longest 1st

LOOP2:		CMP		R1, #0
			BEQ		END_ZEROS
			LSR		R2, R1, #1
			AND		R1, R1, R2
			ADD		R0, #1
			B 		LOOP2
			

END_ZEROS:	POP		{LR}
			MOV 	PC, LR

ALT:		PUSH	{R8, R9, LR}
			MOV 	R0, #0
			MOVW 	R9, #0xaaaa
			MOVT	R9, #0xaaaa
			EOR		R8, R8, R9

			BL 		ONES
			MOV		R7, R0

			BL		ZEROS
			CMP		R7, R0
			MOVLT	R7, R0


END_ALT:	POP		{R8, R9, LR}
			MOV 	PC, LR




TEST_NUM: 	.word	0x0000000f
			.word 	0x0000000e
			.word 	0xaaa00a00
			.word	0
			.end

