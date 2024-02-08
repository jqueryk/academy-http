require 'socket'
require 'rack'
require './calculator'
require './app'

# Запускается сервер
server = TCPServer.open('0.0.0.0', 3000)

# Запускается приложение
app = App.new

while connection = server.accept
  request = connection.gets # принимается запрос
  method, full_path = request.split(' ')
  path = full_path.split('?')[0]


  # Получает данные из запроса от приложения
  status, headers, body = app.call({
                                     'REQUEST_METHOD' => method,
                                     'PATH_INFO' => path,
                                     'QUERY_STRING' => full_path.split('?')[1]
                                   })

  # Возвращает ответ
  connection.print("HTTP/1.1 #{status}\r\n")
  headers.each do |key, value|
    connection.print("#{key}: #{value}\r\n")
  end
  connection.print "\r\n"
  body.each do |part|
    connection.print("#{part}\r\n")
  end

  connection.close
end
