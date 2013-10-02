#!/bin/sed -rnf

/^\s*<a title="Ссылка на это сообщение" href="http:[^?]+\?showtopic=/{
	s///
	s/^([0-9]+)&amp;.*/TOP \1/p
}

/^\s*<!-- THE POST [0-9]+ -->\s*$/ {
	:ll
		N
		/\n\s*<!-- THE POST -->/ {
			s/\n.*//p
			q
		}
		s/\n/ /
		\~<br( /)?>~I! b ll
		s~<br( /)?>~\n~g
		h
		s/\n[^\n]+$//
		p
		x
		s/.*\n//
		b ll
}
#<div class="postcolor" id="post-148520">

