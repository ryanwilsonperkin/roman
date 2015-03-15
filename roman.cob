identification division.
program-id. romannumerals.

environment division.
input-output section.
file-control.
    select standard-input assign to keyboard.
    select standard-output assign to display.

data division.
file section.
fd standard-input.
    01 stdin-record picture x(80).
fd standard-output.
    01 stdout-record picture x(80).

working-storage section.
77  eof picture 9 value 0.

77  roman-len picture s99 usage is computational.
77  err picture s9 usage is computational-3.
77  result picture s9(5) usage is computational.
01  roman.
    02 s picture x(1) occurs 30 times.

01 error-msg.
    02 filler picture x(22) value 'Invalid Roman Numeral:'.
    02 filler picture x(1) value space.
    02 error-val picture x(30).

01  title-line.
    02 filler picture x(34) value 'Roman Number To Decimal Translator'.

01  title-underline.
    02 filler picture x(34) value 
       '----------------------------------'.

01  prompt-line.
    02 filler picture x(23) value 'Enter a roman numeral:'.

01  print-line.
    02 filler picture x(9) value 'Entered: '.
    02 out-r  picture x(30).
    02 filler picture x(13) value ' Translated: '.
    02 out-eq picture z(5).

procedure division.
        open input standard-input, output standard-output.
*       Print title initially
        perform print-title.

*       Loop translation section until end of file is reached
        perform translate
            until eof is equal 1.
        close standard-input, standard-output. 
        stop run.

* Print title to stdout
print-title.
        write stdout-record from title-line.
        write stdout-record from title-underline.

* Run translation program once
* Get input, translate, and print output
translate.
        perform write-prompt.
        perform get-roman.
        perform compute-roman-len.

*       External call to conv module
        call "conv" using roman, roman-len, err, result.

*       Check return value of external call
        if err is equal 1

*           Print error message if external call failed (code: 1)
            move roman to error-val
            write stdout-record from error-msg
        else
*           Print regular line if external call succeeded
            move result to out-eq
            move roman to out-r
            write stdout-record from print-line
        end-if.

* Write an input prompt to stdout
write-prompt.
       write stdout-record from prompt-line.
       write stdout-record from '> ' after advancing 0 lines.

* Get roman numeral from stdin into roman data structure
* Maximum size read from stdin is 30 characters
* Set eof to 1 if end of file is reached
get-roman.
        move spaces to roman.
        read standard-input into roman
            at end move 1 to eof
        end-read.

* Compute length of string in roman data structure
* Count the number of trailing spaces and subtract from total size
compute-roman-len.
        move 0 to roman-len.
        inspect function reverse(roman) tallying roman-len for leading spaces.
        compute roman-len = length of roman - roman-len.
