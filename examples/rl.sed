#!/bin/sed -rf

N
/\n$/ b
h
s/\n.*//
t begin_loop
:begin_loop
	/.{40}/ b end_loop
	s/([^ ]) ([^ ])/\1  \2/
	t begin_loop
	s/([^ ])  ([^ ])/\1   \2/
	t begin_loop
	s/([^ ])   ([^ ])/\1    \2/
	t begin_loop

g
P
D

:end_loop
G
s/\n.*\n/\n/
P
D
