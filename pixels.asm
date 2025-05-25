
	processor 6502
	include "vcs.h"
	include "macro.h"

	SEG
	ORG $F000	; Start address of ROM

Reset
SOF	; Start of frame
	lda #0
	sta VBLANK
	
	lda #2
	sta VSYNC	; Start sync

	; 3 lines of VSYNCH signal
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	
	lda #0
	sta VSYNC	; Stop sync

	; 37 lines of blank
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 

	; 192 lines of images
	ldx #0
	REPEAT 192
		inx	; increase x
		stx COLUBK
		sta WSYNC
	REPEND

	; End of screen, start blanking
	lda #%01000010 ; 
	sta VBLANK
	
	; 30 lines of blank
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 

	jmp SOF
	
	ORG $FFFA
	.word Reset ; NMI
	.word Reset ; RESET
	.word Reset ; IRQ

	END



