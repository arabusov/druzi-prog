DOCNAME=quiz
PC=fpc

SRC=$(wildcard *.pas)
EXE=$(patsubst %.pas, %, $(SRC))
OBJ=$(patsubst %.pas, %.o, $(SRC))
vpath %.pas ./

all: $(EXE) $(DOCNAME).ps
test: $(EXE) test.sh
	@bash test.sh
%: %.pas
	echo $(EXE)
	fpc $^
$(DOCNAME).ps: $(DOCNAME).dvi
	dvips $(DOCNAME).dvi
$(DOCNAME).dvi: $(DOCNAME).tex
	latex $(DOCNAME).tex
	latex $(DOCNAME).tex

clean:
	rm -f $(DOCNAME).dvi $(DOCNAME).ps $(DOCNAME).out $(DOCNAME).log $(DOCNAME).aux
	rm -f $(OBJ)
	rm -f $(EXE)
