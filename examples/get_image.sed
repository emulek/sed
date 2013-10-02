#!/bin/sed -rf

# обработка описаний
/^DIS$/{
	$ b error
	s///
	t dis_loop
	:dis_loop
		${
			# если загруженна посл. строка описания
			s/^\n//
			b
		}
		N
		s/\n~/\nDIS /
		t dis_loop
		s/\nDIS$//
		t dis_loop
	h
	s/^\n(.*)\n.*/\1/p
	T error
	x
	s/.*\n//
	t continue
}

:continue
/^~/!b
/^~Скриншоты:$/d
/<img src=/!b error

s/^~//
t begin_loop

:begin_loop
	s%^(([^\n]+\n)*)<a href="([^"]+)"[^>]*><img src="([^"]+)"[^>]*></a>[^<]*%\1IMG "\3" "\4"\n%i
	t begin_loop
	s%^(([^\n]+\n)*)<img src="([^"]+)"[^>]*>[^<]*%\1IMG "\3"\n%i
	t begin_loop
:end_loop
s/"\n$/"/
t

:error
s/.*/Error '\x1b[31;1m&\x1b[0m'/
q 78
