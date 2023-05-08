#!/bin/bash

sudo cat << _EOF_ > /var/www/html/index.nginx-debian.html;
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<p>`date -d "+4 hours"`</p>
<h1>lowest rate for usd sale</h1>
<p>1 USD = `curl https://rate.am/ | grep 'colspan="5"' | tr -dc '[0-9]' | head -c 7 | tail -c 3` AMD</p>
</body>
</html>
_EOF_
