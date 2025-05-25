# atari
Atari VCS programming

## Notes

wsync - sleep 6502 until TIA wakes it up at the beginning of the scanline.
vsync - frame reset


Atari 2600
* CPU: 6507 (same as 6502 but can only address 8K memory).
* TIA: Television Interface Adaptor

Frame
* 262 scanlines (NTSC interlaced is 524)
    * 3 scanlines for vsync
    * 37 scanlines of blank
    * 192 scanlines of image
    * 30 scanlines of overscan  
* One scanline is 228 TIA clock - first 68 to return, next 160 to draw.
* 3 TIA clock per 6502 clock. Therefore 76 cycles of 6502 per scanline (4560 cycles pr frame)

Memory and registers
* Can access $0000 to $1FFF
* TIA: $00 - $7F
* RAM: $80 - $FF (128 bytes)
* RIOT:$280 - $2FF
* CODE:$1000 - $1FFF (4kB)