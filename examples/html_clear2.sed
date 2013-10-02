#!/bin/sed -rf

\|^<TRASH>|, \|</TRASH>|	d

s/\s+/ /g
s/^ //
s/ $//
/^$/						d
