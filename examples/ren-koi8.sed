#!/bin/sed -rnf

# export LC_ALL=C

# сохранение оригинального имени файла
h

# конвертирование в UTF-8
s/'/'"'"'/g
s/.*/echo -e '&' | iconv -f koi8-r -t utf-8/ep
H

# проверка. являетс-ли файл каталогом?
g
s/\n.*//
s/'/'"'"'/g
s/.*/test -d '&'; echo $?/e
/^0$/{
	# это каталог
	g
	s/.*\n//
	s/'/'"'"'/g
	s~.*~mkdir -vp 't/&' >/dev/stderr; echo $?~e
	/^0$/! b error
	b
}

# это файл

g
s/'/'"'"'/g
s~(.*)\n(.*)~cp -v '\1' 't/\2' >/dev/stderr; echo $?~e
/^0$/! {
	:error
	s/.*/Erorr code &/p
	q 77
}
