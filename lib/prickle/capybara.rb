require_relative 'capybara/find'
require_relative 'capybara/click'
require_relative 'capybara/match'

module Prickle
  TAGS = { :link => 'a',
           :paragraph => 'p'
         }

  module Capybara
    include Prickle::Actions::Find
    include Prickle::Actions::Click
    include Prickle::Actions::Match

    class << self
      attr_accessor :wait_time

    end

    def type_for element
      Prickle::TAGS[element.to_sym] || element
    end

    private
    def find_element_by xpath
      wait_until(Prickle::Capybara.wait_time) do
        find(:xpath, xpath).visible?
      end unless Prickle::Capybara.wait_time.nil?

      find(:xpath, xpath)
    end
  end
end
