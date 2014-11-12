default: infix2pharmml_statement.pm infix2pharmml_model.pm index.html




infix2pharmml_statement.eyp: infix2pharmml_base.eyp
	sed s/STARTRULE/statement/ $< > $@

infix2pharmml_statement.pm: infix2pharmml_statement.eyp
	eyapp -s $<


infix2pharmml_model.eyp: infix2pharmml_base.eyp
	sed s/STARTRULE/model/ $< > $@

infix2pharmml_model.pm: infix2pharmml_model.eyp
	eyapp  $<

index.html: index.md
	pandoc -f markdown -t html -H index.head $< > $@


.PHONY:
test:
	perl t/01base.t
	perl t/02functions.t

.PHONY:
clean:
	-rm infix2pharmml_model.eyp infix2pharmml_statement.eyp

.PHONY:
veryclean: clean
	-rm infix2pharmml_model.pm infix2pharmml_statement.pm
