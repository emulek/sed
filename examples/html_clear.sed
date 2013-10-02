#!/bin/sed -rf

:comment_loop
/<!--/ {
	s/-->/&\n/g
	s/<!--[^\n]+-->\n/ /g
:comment_load
	/<!--.*/ {
		# есть незакрытые комментарии, необходимо подгрузить
		# ещё строчку
		$ {
			s///p
			b style
		}
		N
		s/\n/ /g
		/-->/ b comment_loop
		b comment_load
	}
}

:style
\|<style type="text/css">| {
	s|</style>|&\n|g
	s|<style type="text/css">[^\n]+</style>\n| |g
	\|<style type="text/css">.*| {
		$ {
			s///p
			b script
		}
		N
		s/\n/ /g
		b comment_loop
	}
}

:script
\|<script type="text/javascript">| {
	s|</script>|&\n|g
	s|<script type="text/javascript">[^\n]+</script>\n| |g
	\|<script type="text/javascript">.*| {
		$ {
			s///p
			b table
		}
		N
		s/\n/ /g
		b comment_loop
	}
}

:table
s~<t(r|d)( [^>]+)?>~<T\U\1>~i
