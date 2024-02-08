require 'rack'
require './calculator'


# Создали отдельно работующее приложение
class App

  # Оно умеет обрабатывать запросы от сервера и возвращать данные с помощью этого метода-роутера
  def call(env)
    req = Rack::Request.new(env)
    params = req.query_string.split('&').map { |param| param.split('=') }.to_h

    case req.path
    when "/"
      [200, {"Content-Type" => "text/html"}, ["<h1>Hello world</h1>"]]
    when "/calculator"
      result = calculator_controller(params)
      [200, {"Content-Type" => "text/html"}, ["<h1>#{result}</h1>"]]
    else
      [404, {"Content-Type" => "text/html"}, ["<h1>404</h1>"]]
    end
  end

  # Наш контроллер в который поступают данные из роутера
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
end
