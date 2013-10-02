#!/bin/sed -rnf

1 {
	x
	s|.*|cat ~/.add_ext.conf|e
	s/\#.*$//mg
	s/^\s*\n//
	s/^\s+//mg
	s/\s+$//mg
	s/\n+/\n/g
	s/"\s+/" /g
	p
	x
}

/^[0-9]+$/ {
	s//file &/e
	G
	s/^([0-9]+): (.*).*"\2" ([^\n]+)(\n.*)?$/mv -v \1 \1\3/ep
}
