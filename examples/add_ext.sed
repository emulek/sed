#!/bin/sed -rnf
/^[0-9]+$/ {
	s//file &/e
	s/^([0-9]+): (.*)/\2\n\1/
	/^MP3 file/			s/$/.mp3/
	/^ASCII text/		s/$/.txt/
	/^JPEG image data/	s/$/.jpg/
	/\n.*\./			s/^[^\n]+\n([0-9]+)(.*)/mv -v \1 \1\2/ep
}
