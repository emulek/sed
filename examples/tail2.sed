#!/usr/bin/sed -f
1h

2,10{
	H
	g
}

$q

1,9d

N
D
