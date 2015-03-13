default: infix2pharmml_statement.pm infix2pharmml_model.pm index.html


infix2pharmml_statement.pm: infix2pharmml_base.eyp
	eyapp -s -S statement -m infix2pharmml_statement -o $@ $<

infix2pharmml_model.pm: infix2pharmml_base.eyp
	eyapp -S model -m infix2pharmml_model -o $@ $<


index.html: index.md
	pandoc -f markdown -t html -H index.head $< > $@


.PHONY:
test:
	for i in t/*.t; do perl $$i; done

.PHONY:
clean:
	-rm infix2pharmml_model.pm infix2pharmml_statement.pm index.html
