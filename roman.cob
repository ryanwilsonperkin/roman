IDENTIFICATION DIVISION.
PROGRAM-ID. ROMANNUMERALS.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT STANDARD-INPUT ASSIGN TO KEYBOARD.
    SELECT STANDARD-OUTPUT ASSIGN TO DISPLAY.

DATA DIVISION.
FILE SECTION.
FD STANDARD-INPUT.
    01 STDIN-RECORD   PICTURE X(80).
FD STANDARD-OUTPUT.
    01 STDOUT-RECORD  PICTURE X(80).

WORKING-STORAGE SECTION.
77  EOF-SWITCH PICTURE 9.

77  ARRAY-SIZE PICTURE S99 USAGE IS COMPUTATIONAL.
77  ERR PICTURE S9 USAGE IS COMPUTATIONAL-3.
77  RESULT PICTURE S9(8) USAGE IS COMPUTATIONAL.
01  ARRAY-AREA.
    02 S PICTURE X(1) OCCURS 30 TIMES.

01 ERROR-MSG.
    02 FILLER PICTURE X(1)  VALUE SPACE.
    02 FILLER PICTURE X(22) VALUE 'ILLEGAL ROMAN NUMERAL'.

01  TITLE-LINE.
    02 FILLER PICTURE X(11) VALUE SPACES.
    02 FILLER PICTURE X(24) VALUE 'ROMAN NUMBER EQUIVALENTS'.

01  UNDERLINE-1.
    02 FILLER PICTURE X(45) VALUE 
       ' --------------------------------------------'.

01  COL-HEADS.
    02 FILLER PICTURE X(9) VALUE SPACES.
    02 FILLER PICTURE X(12) VALUE 'ROMAN NUMBER'.
    02 FILLER PICTURE X(13) VALUE SPACES.
    02 FILLER PICTURE X(11) VALUE 'DEC. EQUIV.'.

01  UNDERLINE-2.
    02 FILLER PICTURE X(45) VALUE
       ' ------------------------------   -----------'.

01  PRINT-LINE.
    02 FILLER PICTURE X VALUE SPACE.
    02 OUT-R  PICTURE X(30).
    02 FILLER PICTURE X(3) VALUE SPACES.
    02 OUT-EQ PICTURE Z(9).

PROCEDURE DIVISION.
    OPEN INPUT STANDARD-INPUT, OUTPUT STANDARD-OUTPUT.
    WRITE STDOUT-RECORD FROM TITLE-LINE.
    WRITE STDOUT-RECORD FROM UNDERLINE-1.
    WRITE STDOUT-RECORD FROM COL-HEADS.
    WRITE STDOUT-RECORD FROM UNDERLINE-2.
    MOVE 0 TO EOF-SWITCH.
    PERFORM TRANSLATE-LOOP
        UNTIL EOF-SWITCH IS EQUAL 1.
    CLOSE STANDARD-INPUT, STANDARD-OUTPUT. 
    STOP RUN.

TRANSLATE-LOOP.
    PERFORM GET-LINE.
    CALL "conv" USING ARRAY-AREA, ARRAY-SIZE, ERR, RESULT.
    IF ERR IS EQUAL 2
        WRITE STDOUT-RECORD FROM ERROR-MSG
        MOVE 0 TO OUT-EQ
    ELSE
        MOVE RESULT TO OUT-EQ. MOVE ARRAY-AREA TO OUT-R
        WRITE STDOUT-RECORD FROM PRINT-LINE.

GET-LINE.
    MOVE SPACES TO ARRAY-AREA.
    READ STANDARD-INPUT INTO ARRAY-AREA
        AT END MOVE 1 TO EOF-SWITCH.
    MOVE 0 TO ARRAY-SIZE.
    INSPECT FUNCTION REVERSE(ARRAY-AREA) TALLYING ARRAY-SIZE FOR LEADING SPACES.
    COMPUTE ARRAY-SIZE = LENGTH OF ARRAY-AREA - ARRAY-SIZE.
