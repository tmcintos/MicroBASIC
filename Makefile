all: MICROBASIC.s19 MICROBASIC.bin

%.bin: %.s19
	mot2bin -p 0 $< > $*.log

%.s19: %.ASM
	as0 $< -l > $*.lst

clean:
	$(RM) *.bin *.s19 *.lst *.log
