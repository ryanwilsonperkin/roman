IDENTIFICATION DIVISION.
PROGRAM-ID. conv.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT STANDARD-OUTPUT ASSIGN TO DISPLAY.

DATA DIVISION.
FILE SECTION.
FD STANDARD-OUTPUT.
    01 STDOUT-RECORD  PICTURE X(80).

WORKING-STORAGE SECTION.
77  I    PICTURE S99 USAGE IS COMPUTATIONAL.
77  PREV PICTURE S9(8) USAGE IS COMPUTATIONAL.
77  D    PICTURE S9(4) USAGE IS COMPUTATIONAL.
01 ERROR-MESS.
    02 FILLER PICTURE X(22) VALUE ' ILLEGAL ROMAN NUMERAL'.

LINKAGE SECTION.
77  M    PICTURE S99 USAGE IS COMPUTATIONAL.
77  ERR  PICTURE S9 USAGE IS COMPUTATIONAL-3.
77  SUM1 PICTURE S9(8) USAGE IS COMPUTATIONAL.
01  ARRAY-AREA.
    02 S PICTURE X(1) OCCURS 30 TIMES.

PROCEDURE DIVISION USING ARRAY-AREA, M, ERR, SUM1.
    MOVE ZERO TO SUM1. MOVE 1001 TO PREV.
    PERFORM LOOP THRU END-LOOP VARYING I FROM 1 BY 1
       UNTIL I IS GREATER THAN M.
    MOVE 1 TO ERR. GO TO B8.
LOOP.
    EVALUATE S(I)
       WHEN 'I' MOVE 1 TO D
       WHEN 'V' MOVE 5 TO D
       WHEN 'X' MOVE 10 TO D
       WHEN 'L' MOVE 50 TO D
       WHEN 'C' MOVE 100 TO D
       WHEN 'D' MOVE 500 TO D
       WHEN 'M' MOVE 1000 TO D
       WHEN OTHER GO TO B7.

    ADD D TO SUM1.
    IF D IS GREATER THAN PREV
       COMPUTE SUM1 = SUM1 - 2 * PREV.
END-LOOP. MOVE D TO PREV.
B7. OPEN OUTPUT STANDARD-OUTPUT.
    WRITE STDOUT-RECORD FROM ERROR-MESS AFTER ADVANCING 1 LINE.
    MOVE 2 TO ERR. CLOSE STANDARD-OUTPUT.
B8. GOBACK. 
