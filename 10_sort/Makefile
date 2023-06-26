PC=fpc

SRC=$(wildcard *.pas)
EXE=$(patsubst %.pas, %, $(SRC))
OBJ=$(patsubst %.pas, %.o, $(SRC))
vpath %.pas ./

all: $(EXE)
%: %.pas
	echo $(EXE)
	fpc $^
clean:
	rm -f $(OBJ)
	rm -f $(EXE)
