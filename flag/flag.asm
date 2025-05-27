; Switch between different flags on player input
	processor 6502
	include "../vcs.h"
	include "../macro.h"

	SEG
	ORG $F000	; Start address of ROM

Blue	= $94
White 	= $0E
Red		= $36

vCount	= $80
vMode	= $81

; Clear RAM and all TIA registers
    ldx #0
    lda #0

Clear	
	sta 0,x 	
	inx 
	bne Clear

Reset
	
; Start of frame
SOF	
	ldx #0
	stx VBLANK
; 3 lines of VSYNCH signal
VSync	
	ldx #2
	stx VSYNC	; Start sync

	sta WSYNC 
	sta WSYNC 
	sta WSYNC 
	
	ldx #0
	stx VSYNC	; Stop sync

; 37 lines of blank
ABlank	
	sta WSYNC 
	inx
	cpx #37
	bne ABlank

; FR Flag ===== ===== ===== =====
FR
	; 192 lines of images
	ldx #Blue
	stx COLUBK
	ldy #0
BLoop
	sta WSYNC
	iny
	cpy #64
	bne BLoop
	
	ldx #White
	stx COLUBK
	ldy #0
WLoop
	sta WSYNC
	iny
	cpy #64
	bne WLoop
	
	ldx #Red
	stx COLUBK
	ldy #0
RLoop
	sta WSYNC
	iny
	cpy #64
	bne RLoop


; 30 lines of blank
	ldx #0
	stx COLUBK
	lda #%01000010 ; 
	sta VBLANK
	ldx #0
BBlank
	inx
	sta WSYNC
	cpx #30
	bne BBlank
	
	
	jmp SOF

	
	
	echo "------", [$FFFA - *]d, "bytes free before End of Cartridge"
	ORG $FFFA
	.word Reset ; NMI
	.word Reset ; RESET
	.word Reset ; IRQ


	END



