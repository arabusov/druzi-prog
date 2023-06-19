#!/usr/bin/python3

import http.server, ssl

server_address = ('localhost', 4443)
http.server.CGIHTTPRequestHandler.cgi_directories=['/']
httpd = http.server.HTTPServer(server_address,
                               http.server.CGIHTTPRequestHandler)
httpd.socket = ssl.wrap_socket(httpd.socket,
                               server_side=True,
                               certfile='localhost.pem',
                               ssl_version=ssl.PROTOCOL_TLS)
httpd.serve_forever()

