require_relative 'capybara/find'
require_relative 'capybara/click'

module Prickle
  TAGS = { :link => 'a',
           :paragraph => 'p'
         }

  module Capybara
    include Prickle::Actions::Find
    include Prickle::Actions::Click

  end
end
