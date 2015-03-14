all: roman

roman: conv.cob roman.cob
	cobc -Wall -x -free roman.cob conv.cob -o roman
