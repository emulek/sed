#!/bin/sh

cat $1 |\
iconv -c -f cp1251 > post.txt
mv post.txt post.tmp

./get_post.sed post.tmp > post.txt

mv post.txt post.tmp
./clear_post.sed post.tmp > post.txt
err=$?
if [ $err = 0 ]; then
	#./color_post.sed post.txt
	mv post.txt post.tmp
	./get_ed2k.sed post.tmp > post.txt
	err=$?
	if [ $err = 0 ]; then
		#./color_post.sed post.txt
		mv post.txt post.tmp
		./get_image.sed post.tmp > post.txt
		err=$?
		if [ $err = 0 ]; then
			#./color_post.sed post.txt
			mv post.txt post.tmp
			sed '=' post.tmp |\
			sed -r 's/^/00/;N;s/.*(...)\n(...)/\2 \1/' | sort > post.txt
			./color_post.sed post.txt
			exit 0
		fi
	fi
fi

./color_post.sed post.txt
#cat post2.txt
#cat post1.txt
echo -e "\x1b[33;1mError code $err\x1b[0m"
exit $err	
