#!/usr/bin/sed -nf
1!{
	H
	g
}

1,10! s/[^\n]*\n//

$p
h

