; Switch between different flags on player input
	processor 6502
	include "vcs.h"
	include "macro.h"

	SEG
	ORG $F000	; Start address of ROM

ClearRAM_pre
    ldx #0
    lda #0
ClearRAM  
	sta $80,x
    inx
    cpx #$80
    bne ClearRAM
   
ClearTIA_pre
    ldx #0
    lda #0
ClearTIA
	sta $00,x
    inx
    cpx #$80
    bne ClearTIA
	


Reset
SOF	; Start of frame
	lda #0
	sta VBLANK

VSync	
	lda #2
	sta VSYNC	; Start sync

	; 3 lines of VSYNCH signal
	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	
	lda #0
	sta VSYNC	; Stop sync

	; 37 lines of blank
	ldx #37
ABlank	
	sta WSYNC 
	dex
	cpx 0
	bne ABlank
	

Blue	= $94
White 	= $0E
Red		= $36

	; 192 lines of images
	sta WSYNC


	ldy #60
BLoop
	ldx #Blue
	stx COLUBK
	sta WSYNC
	dey
	cpy 0
	bne BLoop
	
	ldy #60
WLoop
	ldx #White
	stx COLUBK
	sta WSYNC
	dey
	cpy 0
	bne WLoop
	
	ldy #60
RLoop
	ldx #Red
	stx COLUBK
	sta WSYNC
	dey
	cpy 0
	bne RLoop
	
	
	ldx #0
	stx COLUBK
	sta WSYNC

	; End of screen, start blanking
	lda #%01000010 ; 
	sta VBLANK
	
	; 30 lines of blank
	ldx #30
BBlank
	dex
	sta WSYNC
	cpx 0
	bne BBlank

	jmp SOF
	
	ORG $FFFA
	.word Reset ; NMI
	.word Reset ; RESET
	.word Reset ; IRQ

	END



