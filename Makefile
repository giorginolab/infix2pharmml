default: infix2pharmml_eyapp.pm infix2pharmml_model.pm


%.pm: %.eyp
	eyapp -s $<


infix2pharmml_eyapp.pm: infix2pharmml_eyapp.eyp

infix2pharmml_model.pm: infix2pharmml_model.eyp


.PHONY:
test:
	perl t/01base.t
	perl t/02functions.t

