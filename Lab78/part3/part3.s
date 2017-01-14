
			.text
			.global _start
_start:		
			LDR		R4, =TEST_NUM //load data word into R1
			MOV		R5, #0 //R5 gets 0

MAIN:		LDR 	R1, [R4], #4
			CMP		R1, #0
			BEQ 	END
			BL		ONES
RET:		CMP 	R5, R0
			MOVLT	R5, R0
			B 		MAIN

END:		B 		END

ONES:		MOV 	R0, #0

LOOP:		CMP		R1, #0
			BEQ		RET
			LSR		R2, R1, #1
			AND		R1, R1, R2
			ADD		R0, #1
			B 		LOOP
END_ONES:	MOV 	PC, LR

TEST_NUM: 	.word	0x0000000f
			.word 	0x0000000e
			.word 	0xfff2390e
			.word 	0x132fe00f
			.word 	0x103feeef
			.word 	0x1283320f
			.word 	0x1f34eb2f
			.word 	0x1fba927b
			.word 	0x19273bce
			.word 	0x10283bdc
			.word 	0x02836bde

			.end

