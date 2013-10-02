#!/bin/sed -rnf

s/&nbsp;/ /g
\|<span [^>]+>[0-9]+\s+страниц\s*<img [^>]+></span>\s*| {
	N
	s/&nbsp;/ /g
	s/\s+/ /g
	s/&amp;/\&/g
	s|.*<a href="([^"]+)" title="(Следующая страница)">&gt;</a>.*|\1|
	h
}

\|<td class="darkrow1" colspan="8"><b>Темы форума</b></td>|, $ {
	s|.*<a id="[^"]+" href="([^"]+)" title="([^"]+)">([^<]*)</a></span>$|\n\1 \3|
	/^\n/ {
		s///
		H
		s/\\/\\\\/g
		s/'/\\x27/g
		s/^[^ ]+ (.*)/echo -e '\1' | cksum/e
		s/^([0-9]+) [0-9]+$/\1/
		H
		g
		s/\n.*//
		x
		s/^[^\n]*\n(\S+)\s([^\n]*)\n([0-9]+)$/\3 \1 \2/
		p
	}
}

:ctrl_end
$ {
	x
	w next_page.url
}
