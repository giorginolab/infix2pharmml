default: infix2pharmml_statement.pm infix2pharmml_model.pm


%.pm: %.eyp
	eyapp -s $<


infix2pharmml_statement.eyp: infix2pharmml_base.eyp
	sed s/STARTRULE/statement/ $< > $@

infix2pharmml_model.eyp: infix2pharmml_base.eyp
	sed s/STARTRULE/model/ $< > $@


.PHONY:
test:
	perl t/01base.t
	perl t/02functions.t

