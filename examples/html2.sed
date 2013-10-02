#!/bin/sed -rnf

/<td class="post2" id="[^"]+" valign="top" width="100%">/I, $ {
	s/<td[^>]*>/ /ig
:emr_loop
	$ b emr_end_loop
	/<\/td>/I ! {
		H
		n
		b emr_loop
	}
	s|</td>.*| |i
	H
:emr_end_loop
	g
	s/\{/\(/g
	s/\}/\)/g
	s/\s+/ /g
	s/^ //
	s/ $//
	s/<br[^>]*>/\n/gi
	s/<(b|i|u|s)>(\s+)/\2<\1>/ig
	s/(\s+)<\/(b|i|u|s)>/<\2>\1/ig
	s/%7C/|/g
	s/<img src="([^"]+)" class="linked-image" border="0">/{IMG \1}/i
	s/<b>(Название:)<\/b> ([^\n]+)\n/{NAME \2}/i
	s/<b>(Оригинальное название:)<\/b> ([^\n]+)\n/{NAME_ORIG \2}/i
	s/<b>(Год выхода:)<\/b> ([^\n]+)\n/{YEAR \2}/i
	s/<b>(Жанр:)<\/b> ([^\n]+)\n/{GANRE \2}/i
	s/<b>(Режиссер:)<\/b> ([^\n]+)\n/{DIRECTOR \2}/i
	s/<b>(В ролях:)<\/b> ([^\n]+)\n/{ARTS \2}/i
	s%<a href="([^"]+)" target="_blank"><b>Imbd</b></a>%{IMDB \1}%i
	s/<b>(Выпущено:)<\/b> ([^\n]+)\n/{LABLE \2}/i
	s/<b>(Продолжительность:)<\/b> ([^\n]+)\n/{TIME \2}/i
	s/<b>(Озвучивание:)<\/b> ([^\n]+)\n/{TRANS \2}/i
	s/<b>(Формат:)<\/b> ([^\n]+)\n/{FORMAT \2}/i
	s/<b>(Качество:)<\/b> ([^\n]+)\n/{QUAL \2}/i
	s/<b>(Видео:)<\/b> ([^\n]+)\n/{VIDEO \2}/i
	s/<b>(Аудио:)<\/b> ([^\n]+)\n/{AUDIO \2}/i
	s/<b>(Размер:)<\/b> ([^\n]+)\n/{SIZE \2}/i
	s%<b>(Скачать:)</b> <a href="([^"]+)" target="_blank">(<b>)?Сэмпл(</b>)?</a>\n%{SAMPL \2}%i
	s/<b>(Релиз группы:)<\/b> <img src="([^"]+)"( [^>]+)?>/{RELASER \2}/i
	s/<b>(Формат:)<\/b> ([^\n]+)\n/{FORMAT \2}/i
	s%<a href="ed2k://\|file\|([^|]+)\|([0-9]+)\|([0-9a-f]{32})\|/" [^>]*>([^<]*)</a>%{ED2K \2, \3, "\1", "\4"}%gi
	s/<b>(О фильме:)<\/b>([^{]+)/{DESC \2}/i
	s%<img id="[^"]+" src="([^"]+)" class="linked-image" width="[0-9]+" border="0">%{SCR \1}%g
	s/\}[^{]+\{/}{/g
	s/^[^{]+\{/{/
	s/\}[^{]+$/}/
	s/\}/}\n/g
	p
	q
}
