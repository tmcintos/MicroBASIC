all: MICROBASIC.s19 MICROBASIC.bin MICROBASIC.mon

%.mon: %.bin
	hexdump -e '"%04_ax:" 16/1 " %02x" "\n"' $< | tr a-z A-Z | sed -e 's;^0;E;' > $*.mon

%.bin: %.s19
	mot2bin -s E000 $< > $*.log

%.s19: %.ASM
	as0 $< -l > $*.lst

clean:
	$(RM) *.bin *.s19 *.lst *.log
