
booklet: joined-booklet.ps
	psnup -2 -Pa5 -pa4 -s1 joined-booklet.ps arrays-booklet.ps
joined-booklet.ps: arrays.ps
	psjoin arrays.ps arrays.ps > joined-booklet.ps

arrays.ps: arrays.dvi
	dvips arrays.dvi
arrays.dvi: arrays.tex
	latex arrays.tex

clean:
	rm -rf arrays.dvi arrays.ps arrays.out arrays.log arrays.aux joined-booklet.ps
