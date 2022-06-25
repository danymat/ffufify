# Ffufify

Converts a burp request to a ffuf command.

```
lua ffufify.lua <file>
```

- `<file>` being the filename that contains the burp request

## Example

```
GET /web-security/ HTTP/1.1
Host: portswigger.net
Cookie: Authenticated_UserVerificationId=8CC88CF5...
Sec-Ch-Ua: "Chromium";v="103", ".Not/A)Brand";v="99"
Sec-Ch-Ua-Mobile: ?0
Sec-Ch-Ua-Platform: "macOS"
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) ...
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
Sec-Fetch-Site: none
Sec-Fetch-Mode: navigate
Sec-Fetch-User: ?1
Sec-Fetch-Dest: document
Accept-Encoding: gzip, deflate
Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7
Connection: close
```

Becomes:

```
FFUFIFIED:

ffuf -u portswigger.net/web-security/ -X "GET" \
-H 'Cookie:Authenticated_UserVerificationId=8CC88CF5...' \
-H 'Sec-Ch-Ua:"Chromium";v="103", ".Not/A)Brand";v="99"' \
-H 'Sec-Ch-Ua-Mobile:?0' \
-H 'Sec-Ch-Ua-Platform:"macOS"' \
-H 'Upgrade-Insecure-Requests:1' \
-H 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) ...' \
-H 'Accept:text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
-H 'Sec-Fetch-Site:none' \
-H 'Sec-Fetch-Mode:navigate' \
-H 'Sec-Fetch-User:?1' \
-H 'Sec-Fetch-Dest:document' \
-H 'Accept-Encoding:gzip, deflate' \
-H 'Accept-Language:fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7' \
-H 'Connection:close'
```
