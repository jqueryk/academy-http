require 'socket'

server = TCPServer.open('0.0.0.0', 3000)

while connection = server.accept
  request = connection.gets

  connection.print "HTTP/1.1 200\r\n"
  connection.print "Content-Type: text/html\r\n"
  connection.print "\r\n"
  connection.write "Hello World!"

  connection.close
end