				.include "address_map_arm.s"
				.extern	LEDR_DIRECTION
				.extern	LEDR_PATTERN
				.global PRIV_TIMER_ISR
PRIV_TIMER_ISR:	LDR		R0, =MPCORE_PRIV_TIMER	// base address of timer
				MOV		R1, #1
				STR		R1, [R0, #0xC]			// write 1 to F bit to reset it
												// and clear the interrupt

SWEEP:			LDR		R0, =LEDR_DIRECTION		// put shifting address into R2
				LDR		R2, [R0]
				LDR		R1, =LEDR_PATTERN		// put LEDR pattern into R3
				LDR		R3, [R1]
				CMP		R2, #0
				BNE		SHIFTR
				BEQ		SHIFTL
				
SHIFTL:			ROR 	R3, #31	
				ADD		R9, #1	
				CMP 	R9, #9
				BEQ 	L_R
				BNE		DONE_SWEEP

L_R:			MOV		R2, #1					// change direction to right
				B 		DONE_SWEEP
				
SHIFTR:			
				ROR 	R3, #1
				SUBS	R9, #1	
				CMP 	R9, #0
				BEQ 	R_L	
				BNE		DONE_SWEEP

R_L:			MOV		R2, #0					// change direction to left
				B		DONE_SWEEP

DONE_SWEEP:		STR		R2, [R0]				// put shifting direction back into memory
				STR		R3, [R1]				// put LEDR pattern back onto stack
	
END_TIMER_ISR:	MOV		PC, LR
