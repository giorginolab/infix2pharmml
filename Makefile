infix2pharmml_eyapp.pm: infix2pharmml_eyapp.eyp
	eyapp -s $<

.PHONY:
test:
	perl t/infix2pharmml.t

