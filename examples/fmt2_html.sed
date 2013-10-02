#!/bin/sed -rnf

# форматирование HTML, все теги собираются
# каждый в свою строку

# загрузка первой строки...
# удаление ведущих пробелов
s/^\s+//
/^</{
	# данная строка начинается с тега
	# сначала проверяем, не является-ли тег комментарием
	/^<!--/{
		:comment
		# эта строка начинается с коментария
		# наскольоко я понимаю, в комментах можно всё, кроме -->
			/-->/{
				# строка так-же содержит завершение коменнта
				# убираем его
				:remove_substring
					s//&\n/
					P
					D
			}
			# строка не содержит конца коммента, грузим след.
			# проверяем особый случай: незавершённый коммент
			$ b error
			N
			s/\r?\n/<\\n>/
			b comment
	}
	t javascript_start
	:javascript_start
	s/^<script\s+language=(["']?)JavaScript\1>/\L&/i
	t javascript
	s~^<script\s+type=(["']?)text/javascript\1>~\L&~i
	T css_start
		# это начала жабаскрипта
		:javascript
			\~</script>~I b remove_substring
			$ b error
			n
			s/^/<script language="JavaScript">/
			b javascript
	:css_start
	s~^<style\s+type=(["']?)text/css\1>~\L&~i
	T tag
		:css
			\~</style>~I b remove_substring
			$ b error
			n
			s~^~<style type="text/css">~
			b css
	:tag
		/>/{
			s/^[^>]*>/\L&\n/
			P
			D
		}
		# строка содержит не целый тег
		$ b error
		N
		s/\r?\n/ /
		b tag
}

/</{
	# строка не начинается с тега, но, однако, его содержит
	s/\s*</\n</
	P
	D
}

# проверяем наличие символа > вне тегов
/>/ b error

s/\s+$//
# проверяем, не является-ли строка пустой, и печатаем её
/^$/! p
b

:error
	s/.*/\x1b[31;1mErorr in line '&'\x1b[0m/p
	q 77			
