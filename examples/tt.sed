#!/bin/sed -rf

:begin
$!{
	N
	b begin
}

s/[	]/табуляция/g
s/[\n]/перевод строки/g
