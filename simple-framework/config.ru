# config.ru
require_relative 'lib/core'
require_relative 'app/routes'

run Framework::HTTPServer.new
