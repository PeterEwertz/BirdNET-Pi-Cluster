sox  $1 -n stat 2>&1  |\
	awk -v anzahl=15 -F':' '
	BEGIN {
		print "{"
	}
	function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }
	function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s }
	function trim(s)  { return rtrim(ltrim(s)); }


	{
		if ( NR != anzahl ) {
			printf ("\"%s\": \"%s\",\n",  trim($1), trim($2))
		} else {
			printf ("\"%s\": \"%s\"\n",  trim($1), trim($2))
		}
	}
	END {
		print "}"
	}
	'  |jq '.'
