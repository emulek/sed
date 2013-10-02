#!/bin/sed -rf

/^[A-Z0-9]{3}/b
/^~Ослолинк:$/d

\%<a href="ed2k://%I {
	s/<img src=[^>]+>//ig
	t lx
	:lx
	s%^~[^<]*(<a href="ed2k://)%\1%i
	T error
	:begin_loop
		s%^(.*"\n)?<a\shref="ed2k://\|file\|([^"|]+)\|([0-9]{1,17})\|([[:xdigit:]]{32})(\|h=([0-9A-Z]{32}))?\|/"[^>]*>\s*([^<]*)</a>[^<]*%\1ED2 "\2" \3 \4 \6 "\7"\n%i
		t begin_loop
	s/"\n$/"/
	t
	b error
}

# ссылки, но не ed2k - убиваем
/^~Ссылки:/d
b

:error
s/.*/ERROR '&'/
q 75
