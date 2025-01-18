#!/bin/bash
i=0
TICKETS=utils/tickets.txt
echo -n "Строка с куками: "
read -r COOKIE
while read -r TICKET; do
	fname=$i
	if [ $i -lt 10 ]; then
		fname=0$i
	fi
	echo "== $TICKET" >tickets/$fname.typ
	curl 'https://github.com/_graphql' \
		-H 'accept: application/json' \
		-H 'accept-language: en,ru;q=0.9' \
		-H 'content-type: text/plain;charset=UTF-8' \
		-H "cookie: $COOKIE" \
		-H 'dnt: 1' \
		-H 'github-verified-fetch: true' \
		-H 'origin: https://github.com' \
		-H 'priority: u=1, i' \
		-H 'referer: https://github.com/SE-legacy/test/issues/new?template=Blank+issue' \
		-H 'sec-ch-ua: "Chromium";v="128", "Not;A=Brand";v="24", "YaBrowser";v="24.10", "Yowser";v="2.5"' \
		-H 'sec-ch-ua-mobile: ?0' \
		-H 'sec-ch-ua-platform: "Linux"' \
		-H 'sec-fetch-dest: empty' \
		-H 'sec-fetch-mode: cors' \
		-H 'sec-fetch-site: same-origin' \
		-H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 YaBrowser/24.10.0.0 Safari/537.36' \
		-H 'x-requested-with: XMLHttpRequest' \
		--data-raw '{"query":"ade91624c0c173721dc685806500c9eb","variables":{"fetchParent":false,"input":{"body":"Задача сгенерирована автоматически. Нужно написать билет '"$TICKET"'","parentIssueId":null,"repositoryId":"R_kgDONrnSXw","title":"Билет '$i': '"$TICKET"'"}}}'
	((i++))
	sleep 3
done <"$TICKETS"
