
			.text
			.global _start
_start:		
			LDR		R1, TEST_NUM //load data word into R1
			
			MOV		R0, #0
LOOP:		CMP		R1, #0
			BEQ		END
			LSR		R2, R1, #1
			AND		R1, R1, R2
			ADD		R0, #1
			B 		LOOP

END:		B 		END
TEST_NUM: 	.word	0x103fe00f

			.end