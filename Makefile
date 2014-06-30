#!/bin/sh
NAME=document

default:clean pdf

dvi:
	@echo ""
	@echo "<----------------------------------- Compile bibiography database and tex file ----------------------------------->"
	latex $(NAME).tex
	@if grep -q "Warning: Citation" $(NAME).log ; then \
		echo "*** MAKE BIB ***" ; \
		bibtex $(NAME) ;			\
		latex $(NAME).tex ;			\
		latex $(NAME).tex ; 			\
	fi
	@if grep -q "Rerun" $(NAME).log ; then \
		echo "*** MAKE REFS ***" ; \
		latex $(NAME).tex ;			\
	fi

ps:	dvi
	@echo ""
	@echo "<----------------------------------------------- Generate ps from dvi -------------------------------------------->"
	dvips -Ppdf $(NAME).dvi -o $(NAME).ps

pdf:	ps
	@echo ""
	@echo "<----------------------------------------------- Generate pdf from ps -------------------------------------------->"
	ps2pdf $(NAME).ps 
	acroread $(NAME).pdf &
	@echo ""
	@echo "<--------------------------------------------- Sucessfully generated PDF ----------------------------------------->"

clean:
	@echo ""
	@echo "<----------------------------------------------- Clean compiled files -------------------------------------------->"
	rm -f $(NAME).aux
	rm -f $(NAME).bbl
	rm -f $(NAME).blg
	rm -f $(NAME).log
	rm -f $(NAME).out
	rm -f $(NAME).dvi
	rm -f $(NAME).ps
	rm -f *~

mrproper:
	@echo ""
	@echo "<-------------------------------------------------- Full cleaning  ----------------------------------------------->"
	rm -f $(NAME).aux
	rm -f $(NAME).bbl
	rm -f $(NAME).blg
	rm -f $(NAME).log
	rm -f $(NAME).out
	rm -f $(NAME).dvi
	rm -f $(NAME).ps
	rm -f ${NAME}.pdf
	rm -f *~

