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
77  result picture s9(8) usage is computational.
01  roman.
    02 s picture x(1) occurs 30 times.

procedure division using roman, roman-len, err, result.
        move zero to result.
        move 1001 to prev-decimal.
        move 1 to err.
        perform compute-decimal
            varying i from 1 by 1
            until i is greater than roman-len or err = 2.
        goback.

compute-decimal.
        evaluate s(i)
            when 'I' move 1 to curr-decimal
            when 'V' move 5 to curr-decimal
            when 'X' move 10 to curr-decimal
            when 'L' move 50 to curr-decimal
            when 'C' move 100 to curr-decimal
            when 'D' move 500 to curr-decimal
            when 'M' move 1000 to curr-decimal
            when other move 2 to err
        end-evaluate.

        add curr-decimal to result.
        if curr-decimal is greater than prev-decimal
            compute result = result - 2 * prev-decimal
        end-if.
        move curr-decimal to prev-decimal.
