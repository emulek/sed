#!/bin/sed -rf

/i/{
	h
	s/.*/Old string: '&'/w sub.tpl
	g
	s/i/Z/g
	s/.*/New string: '&'/w sub.tpl
	s/.*/Substitute?/w sub.tpl
	s~.*~gmessage --file sub.tpl --title sub.sed --buttons Yes:0,No:67,Cancel:68; echo $?~e
	/^0$/{
		g
		s/i/Z/g
		b
	}
	/^67$/{
		g
		b
	}
	Q
}
