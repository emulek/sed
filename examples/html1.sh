#!/bin/sh

#./html_clear1.sed $1 | ./html_clear2.sed | ./html1.sed > lst.txt

#while read crc url subj
#do
#	echo "CRC='$crc' URL='$url' SUBJ='$subj'"
#done < lst.txt

./html_clear1.sed $1 | ./html_clear2.sed | ./html2.sed
