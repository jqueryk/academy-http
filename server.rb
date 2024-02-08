require 'socket'
require './calculator'

server = TCPServer.open('0.0.0.0', 3000)

# Выводим отдельно контроллер
def calculator_controller(params)
  calculator = Calculator.new(params['left'].to_i, params['right'].to_i)
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
end

# Выводим отдельно роутер
def router(path, params)
  case path
  when "/"
    "Hello World"
  when "/calculator"
    calculator_controller(params)
  else
    "404"
  end
end

while connection = server.accept
  request = connection.gets
  method, full_path = request.split(' ')
  path = full_path.split('?')[0]

  query_string = full_path.split('?')[1] || ""
  params = query_string.split('&').map { |param| param.split('=') }.to_h
  puts params

  response = router(path, params)

  status = response != "404" ? 200 : 404

  connection.print "HTTP/1.1 #{status}\r\n"
  connection.print "Content-Type: text/html\r\n"
  connection.print "\r\n"
  connection.print "<h1>#{response}</h1>"

  connection.close
end
