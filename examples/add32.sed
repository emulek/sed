#!/bin/sed -rnf

# Этот скрипт добавляет файлы в архив по 32 штуки
# в первой строке содержится имя архива, а дальше - список файлов

1 {
	h
	N
	s/(.*)\n(.*)/tar -cpvf "\1" "\2"/ep
	b
}

2~32 b add
$ b add

H
b

:add
H
g
s/\n/" "/g
s/.*/tar -rpvf "&" || echo "ERROR"/ep
/ERROR/ q 77
x
s/\n.*//
x
b
