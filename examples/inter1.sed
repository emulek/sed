#!/bin/sed -rnf

/m/ {
	h
	s/([^m]*)m(.*)/found \x27\1\x1B[31mm\x1B[0m\2\x27, replace?/p
	s|.*|read < /dev/fd/1 |pe
	s/.*/--->&<---/p
	/^(y|yes)/ {
		s/.*/REPLACE/p
	}
}
