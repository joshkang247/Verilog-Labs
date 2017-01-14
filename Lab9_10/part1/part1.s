
/*
for (int i=0; i++; i<LIST){
	for (int j=0; j++; j<(LIST-i-1)){
		if (array[j] > array[j+1]){
			temp = array[j];
			array[j] = array[j+1];
			array[j+1] = temp;
		}
	}
}*/
			
			
			.text
			.global _start

_start:
			LDR 	R8, =	LIST //stores pointer to the first word
			LDR		R7, [R8] //stores size of list
			SUB		R6, R7, #1 //only needs to iterate outside #words - 1 times
			LDR		R0, =0 //flag for finishing loop
			ADD		R9, R8, #4 //holds pointer to current value R9 will change to the largest value
		
		

	
			
MAIN:		CMP 	R0, #0
			BEQ		OUTER //performs bubblesort
			B 		END
			
			
			
			
OUTER:		CMP		R6, #0 //reaches end
			MOVEQ	R0, #1 //sets finishing flag
			BEQ		MAIN
			
			MOV		R5, R6 //stores number of interations inner loop needs
			ADD		R9, R8, #4 //reset R9 to original value
			B	 	INNER //calls inner loop to run
			SUB		R6, #1
			B 		OUTER //repeat outer loop

INNER:		CMP		R5, #0 //reaches end
			BEQ		OUTER //returns to outer loop
			
			//LDR		R11, [R9] //temp to hold content of R9
			ADD		R10, R9, #4 //holds pointer to next number
			LDR		R2, [R9] //holds value of current pointer
			LDR		R3, [R10] //holds value of next pointer
			CMP		R2, R3 //compares current value with next value
			STRLT	R3, [R9] //stores the larger number inside R9
			STRLT	R2, [R10] //stores smaller number inside R10
			MOV		R9, R10 //updates current pointer
			SUB 	R5, #1
			B 		INNER //repeat inner loop
			
			
END:		B 		END

LIST:		.word 	10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33
			.end
			
			