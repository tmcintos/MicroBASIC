# MicroBASIC
Robert Uiterwyk's [Micro-Basic Version 1.3](https://deramp.com/swtpc.com/NewsLetter1/MicroBasic.htm)

See the [a1mon68 branch](../../tree/a1mon68) for a port to the M6800-based Apple-1 running [a1mon68](../../../a1mon68).

The source code has been modified to build using the [motorola-6800-assembler](../../../motorola-6800-assembler) (tested on macOS 15).

## Building

*Note: These instructions assume that you have built and installed my forks of the [motorola-6800-assembler](../../../motorola-6800-assembler) and [Hex2bin-2.5](../../../Hex2bin-2.5).*

*Note: Building the MICROBASIC.mon file for wozmon requires the POSIX `tr` and `sed` utilities, as well as the BSD `hexdump` utility (found in the util-linux package on Linux).

The project may be built by running `make` (tested on macOS 15).

All built products and intermediate files may be removed by running `make clean`.

## Differences in Apple-1 port

* Reworked I/O functions for Apple-1.
* Relocated code to $E000.
* Added warm start entry point at $E003.
* Relocated variable storage and arithmetic expression stack to page 3.
* Reorganized zero page usage to avoid conflicts with Apple-1 monitor.
* PATCH command enters Apple-1 monitor (no MIKBUG).
* Control-C (ASCII $03) may be used to abort INPUT.
* Moved location of BREAK calls to avoid unwanted breaks when pasting in text.
* Disabled automatic line wrapping support.
* INPUT, PAUSE: Added optional prompt string.
* Added CALL command as in Apple-1 BASIC.
* Added POKE command as in Apple-1 BASIC.

## Internal Development Notes:

### Memory map:

    PAGE:
    $00: Interpreter internal variables
    $03: BASIC variable storage + arithmetic expression stack.
    $04: BASIC program tokenized source lines (SOURCE)

### Strings

Strings are termined with ASCII RS ($1E).

### Program storage

Program lines are stored as RS-delimited records
starting from SOURCE. Record format is:

    <line#> <token#> <ascii-string> RS

where:
 - line# is an unsigned 16-bit integer
 - token# is an unsigned 8-bit integer
 - RS is $1E

token# refers to the LSB of the address of the
command in the command table (COMMAN), which is
assumed to reside within a single page.

### Variables

- SOURCE points to the start of the BASIC program.
- BASLIN points to the start of the current line.
- BASPNT points to the current position within BASLIN

- BASLIN/BASPNT HI byte (PAGE number) interpretation:
    - =0: $0000 or in BUFFER (immediate command)
    - ≠0: SOURCE..MEMEND (program statement)

### I/O Functions

- INCH:   Input ASCII character from keyboard and
          return it in ACC A.
- INCHNE: Same as above, but with no echo.
- OUTCH:  Output ASCII character in ACC A.
- OUTNCR: Output RS-delimited ASCII string in X,
          without newline sequence.
- OUTPUT: Output RS-delimited ASCII string in X,
          followed by newline sequence

### Interpreter Functions

- PULLAE: Pop arithmetic expression from stack and
          return in ACC A (MSB) & ACC B (LSB)
- EXPR:   Parse an arithmetic expression from the
          program source at X and push it on the
          stack; returns next source char in ACC A.
