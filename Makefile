all: roman

roman: conv.cob roman.cob
	cobc -Wall -x -free conv.cob roman.cob -o roman
