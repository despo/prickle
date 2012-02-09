require 'sinatra'

get '/' do
  File.read(File.join(File.dirname(__FILE__), 'index.html'))
end
