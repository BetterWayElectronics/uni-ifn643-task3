# IFN643-CrackMe
This is in response to the assignment for IFN643, Computer Security, a masters degree subject offered at Queensland University of Technology. Its a great example of how simple the process of patching and generating a password can be.

This example in particular the program is packed with UPX to give students the shock that opening it in IDA will result in madness. So it has to be unpacked first. From here the process of getting the password is simple enough. Searching for relevant strings yeilds the location of a decision point, good/bad password. From here you can watch in memory using a breakpoint that when the wrong password is entered it is passed through a caesar cipher, and in memory this is seen as your failed password is converted. Now that you have the password, bypassing it and cracking the program is easy. The jump between good/bad can simply make all bad passwords correct. This is a single byte change in hex. 74 representing jump if equal and 75 representing jump if not equal.

So my program, written in Perl simply patches a single byte to the program after unpacking it and generates the proper cipher required to generate a password.

Fun! Easy!

Thought people would like to see what a masters degree subject offers and how simple patching a program can be.
