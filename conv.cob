identification division.
program-id. conv.

data division.
working-storage section.
77  i picture s99 usage is computational.
77  prev-decimal picture s9(4) usage is computational.
77  curr-decimal picture s9(4) usage is computational.

linkage section.
77  roman-len picture s99 usage is computational.
77  err picture s9 usage is computational-3.
77  result picture s9(5) usage is computational.
01  roman.
    02 s picture x(1) occurs 30 times.

procedure division using roman, roman-len, err, result.
*       Initialize result value to 0, will be added to
        move zero to result.

*       Initialize prev-decimal larger than any other possible value
        move 1001 to prev-decimal.

*       Initialize error result to 0 (no error)
        move 0 to err.

*       Run decimal computation on each character
        perform compute-decimal
            varying i from 1 by 1
            until i is greater than roman-len or err = 1.
        goback.

* Translate the current roman numeral character into a decimal value
compute-decimal.
        evaluate s(i)
            when 'I' move 1 to curr-decimal
            when 'i' move 1 to curr-decimal
            when 'V' move 5 to curr-decimal
            when 'v' move 5 to curr-decimal
            when 'X' move 10 to curr-decimal
            when 'x' move 10 to curr-decimal
            when 'L' move 50 to curr-decimal
            when 'l' move 50 to curr-decimal
            when 'C' move 100 to curr-decimal
            when 'c' move 100 to curr-decimal
            when 'D' move 500 to curr-decimal
            when 'd' move 500 to curr-decimal
            when 'M' move 1000 to curr-decimal
            when 'm' move 1000 to curr-decimal
            when other move 1 to err
        end-evaluate.

        add curr-decimal to result.
 
*       If we previously saw smaller value, it should have been subtracted
*       Make up for it by subtracting previous value twice
        if curr-decimal is greater than prev-decimal
            compute result = result - 2 * prev-decimal
        end-if.
        move curr-decimal to prev-decimal.
