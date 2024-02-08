require 'socket'

server = TCPServer.open('0.0.0.0', 3000)

while connection = server.accept
  request = connection.gets
  method, full_path = request.split(' ')
  path = full_path.split('?')[0]

  response = case path
             when "/"
               "Hello World"
             when "/calculator"
               "Calculator"
             else
               "404"
             end

  status = response != "404" ? 200 : 404

  connection.print "HTTP/1.1 #{status}\r\n"
  connection.print "Content-Type: text/html\r\n"
  connection.print "\r\n"
  connection.print "<h1>#{response}</h1>"

  connection.close
end