PC=fpc

SRC=$(wildcard *.pas)
EXE=$(patsubst %.pas, %, $(SRC))
OBJ=$(patsubst %.pas, %.o, $(SRC))
DOS=$(patsubst %.pas, %.PAS, $(SRC))
vpath %.pas ./

all: $(EXE)
archive: meas.zip

meas.zip: $(DOS)
	zip MEAS.ZIP *.PAS

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
