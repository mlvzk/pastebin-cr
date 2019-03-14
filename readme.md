# 21 LOC pastebin in Crystal

To try it out send a POST request with a form containing a `file`, the response body is the pastebin ID.

Sample `curl`:
```sh
$ curl -i -X POST -F file=@x.txt localhost:3000
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 8

slaa7MN5
```

To read it, send a `GET` request to localhost:3000/slaa7MN5
