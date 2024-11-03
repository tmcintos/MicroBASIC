# MicroBASIC
Robert Uiterwyk's [Micro-Basic Version 1.3](https://deramp.com/swtpc.com/NewsLetter1/MicroBasic.htm)

See the [a1mon68 branch](../../tree/a1mon68) for a port to the M6800-based Apple-1 running [a1mon68](../../../a1mon68).

The source code has been modified to build using the [motorola-6800-assembler](../../../motorola-6800-assembler) (tested on macOS 15).

## Building

*Note: These instructions assume that you have built and installed my forks of the [motorola-6800-assembler](../../../motorola-6800-assembler) and [Hex2bin-2.5](../../../Hex2bin-2.5).*

*Note: Building the MICROBASIC.mon file for wozmon requires the POSIX `tr` and `sed` utilities, as well as the BSD `hexdump` utility (found in the util-linux package on Linux).

The project may be built by running `make` (tested on macOS 15).

All built products and intermediate files may be removed by running `make clean`.
