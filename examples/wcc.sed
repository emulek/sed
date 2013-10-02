#!/bin/sed -rnf

/^$/ b ctrl_end

G
:begin_loop
	s/^([^\n])([^\n]*)(.*)\n\1~([a-g]+)/\2\n\1~\4a\3/
	t continue_loop
	# символа нет в базе или этот символ последний
	/^\n/	b last_sym

	# новый символ
	s/^(.)([^\n]*)\n$/\2\n\1~a/
	t begin_loop
	s/^(.)(.*)$/\2\n\1~a/
	t begin_loop

:continue_loop
	s/(\n.*)a{10}/\1b/;	T begin_loop
	s/(\n.*)b{10}/\1c/;	T begin_loop
	s/(\n.*)c{10}/\1d/;	T begin_loop
	s/(\n.*)d{10}/\1e/;	T begin_loop
	s/(\n.*)f{10}/\1g/;	T begin_loop
	s/(\n.*)g{10}/\1i/;	T begin_loop
	q 77

:last_sym
# последний символ
s///
x

:ctrl_end
$ {
	# последняя строка
	s/.*/&/
	t convert_start
:convert_loop
		s/a{9}/9/;		t convert_end_loop
		s/a{8}/8/;		t convert_end_loop
		s/a{7}/7/;		t convert_end_loop
		s/a{6}/6/;		t convert_end_loop
		s/a{5}/5/;		t convert_end_loop
		s/a{4}/4/;		t convert_end_loop
		s/a{3}/3/;		t convert_end_loop
		s/a{2}/2/;		t convert_end_loop
		s/a/1/;			t convert_end_loop
		s/^[a-g]*/&0/;	t convert_end_loop
:convert_end_loop
		y/bcdefg/abcdef/
		s/[a-g]/&/
		t convert_loop
	G
	s/^([0-9]+)\n(.*)([^\n])~[a-g]+(.*)/\2'\3' \1\4/
	x
	t convert_start
:convert_start
	g
	s/.*[^\n]~([a-g]+).*/\1/
	t convert_loop
	s/\n([^\n]+)\n([^\n]+)\n/\t\1\t\2\n/g
	p
}
