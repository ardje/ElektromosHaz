ALL: essphase1.pdf

essphase1.dot: essphase1.lua
	./essphase1.lua > essphase1.dot

essphase1.pdf: essphase1.dot
	neato -Tpdf essphase1.dot > essphase1.pdf
	cp essphase1.pdf ~/Downloads
