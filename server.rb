require 'socket'
require './calculator'

server = TCPServer.open('0.0.0.0', 3000)

while connection = server.accept
  request = connection.gets
  method, full_path = request.split(' ')
  path = full_path.split('?')[0]

  query_string = full_path.split('?')[1] || ""
  params = query_string.split('&').map { |param| param.split('=') }.to_h
  puts params

  response = case path
             when "/"
               "Hello World"
             when "/calculator"
               calculator = Calculator.new(params['left'].to_i, params['right'].to_i)

               # bad practice, потому что в случае отсутвия параметра action вылетит ошибка
               # calculator.method(params['action']).call

               # best practice, потому что если не найлется один подходящий случай для when,
               # то на калькуляторе ничего и не вызовется
               case params['action']
               when 'sum'
                 calculator.sum
               when 'subtraction'
                 calculator.subtraction
               when 'divide'
                 calculator.divide
               when 'multiply'
                 calculator.multiply
               when 'exponentiation'
                 calculator.exponentiation
               end

               "Result: #{calculator.result}"
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
