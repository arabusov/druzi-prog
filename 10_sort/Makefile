PC=fpc

SRC=$(wildcard *.pas)
EXE=$(patsubst %.pas, %, $(SRC))
OBJ=$(patsubst %.pas, %.o, $(SRC))
DOS=$(patsubst %.pas, %.PAS, $(SRC))
vpath %.pas ./

all: $(EXE)
archive: sort.zip

sort.zip: $(DOS)
	zip SORT.ZIP *.PAS

%.PAS: %.pas
	bash conv.sh $^
	
%: %.pas
	echo $(EXE)
	fpc $^
clean:
	rm -f $(OBJ)
	rm -f $(EXE)
	rm -f *.PAS
	rm -f *.ZIP
