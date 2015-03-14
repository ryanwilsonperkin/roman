all: roman

roman: conv.cob roman.cob
	cobc --std=cobol85 -Wall -x -free roman.cob conv.cob -o roman
