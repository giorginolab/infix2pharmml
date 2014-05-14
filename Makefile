infix2pharmml_eyapp.pm: infix2pharmml_eyapp.eyp
	eyapp -s $<

.PHONY:
test:
	perl t/01base.t
	perl t/02functions.t

