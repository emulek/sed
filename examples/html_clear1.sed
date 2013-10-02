#!/bin/sed -rf

s~<!--|<style type="text/css">|<script [^>]+>~\n<TRASH>~g
s~(-->|</style>|</script>)~</TRASH>\n~g

s~\n<TRASH>[^\n]*</TRASH>\n~ ~g
