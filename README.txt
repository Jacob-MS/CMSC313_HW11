Author: Jacob Shamer
Course: CMSC 313
Time Slot: 10:00AM MON/WED

Purpose:
An assembly program that takes hex data and prints out the characters within, for example: 0x83  ->  83.
Essentially what the program does is it takes each byte of data and isolates the two nibbles, first and second.
Then it uses a table "0123456789ABCDEF" to find the correct character associated with the nibble, and adds it to the output buffer.
after both nibbles are added we add a space, we loop through until the entire input buffer has been translated and then we print.


Files:
translate2ASCII.s

Build Instructions:
IDE used: VS Code

translate2ASCII.s:

Compile & Link:

nasm -f elf32 -g -F dwarf -o translate2ASCII.o translate2ASCII.s

ld -m elf_i386 -o translate2ASCII translate2ASCII.o

Additional Information:
when I run and compile I get the correct output, but I can't tell if the newline is being printed, 
everything in the buffer is being printed out so I assume it is but I don't really understand why I'm not seeing the newline in the terminal output
it is in the output buffer as the 24th character and I am printing all 24 characters, all resources I'm looking at are telling me that should work so I don't know

"83 6A 88 DE 9A C3 54 9A\n"
 ^^^^^^^^^^^^^^^^^^^^^^^^
 123456789111111111122222
          012345678901234
                     
