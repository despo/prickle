require File.join(File.dirname(__FILE__), "..", "lib", "prickle", "capybara")

require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'prickle/capybara'

class Prickly
  include Capybara::DSL

end

Capybara.app_host = "file:///#{File.dirname(__FILE__)}/stub.html"
Capybara.default_driver = :selenium
