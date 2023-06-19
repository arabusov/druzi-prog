#!/usr/bin/python3

import http.server

server_address = ('localhost', 8000)
http.server.CGIHTTPRequestHandler.cgi_directories=['']
httpd = http.server.HTTPServer(server_address,
                               http.server.CGIHTTPRequestHandler)
httpd.serve_forever()

