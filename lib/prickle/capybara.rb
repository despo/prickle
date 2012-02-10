require_relative 'capybara/find'
require_relative 'capybara/click'
require_relative 'capybara/match'
require_relative 'capybara/exceptions'

module Prickle
  TAGS = { :link => 'a',
           :paragraph => 'p'
  }

  module Capybara

    class << self
      attr_accessor :wait_time

    end

    include Prickle::Actions::Find
    include Prickle::Actions::Click
    include Prickle::Actions::Match

    def element type='*', identifier
      @identifier = identifier
      @type = type
      self
    end

    private

    def xpath_for identifier
      return identifier.each_pair.to_a.map do |key, value|
        "@#{key}='#{value}'"
      end.join ' and '
    end

    def find_element_by xpath
      wait_until(Prickle::Capybara.wait_time) do
        find(:xpath, xpath).visible?
      end unless Prickle::Capybara.wait_time.nil?

      find(:xpath, xpath)
    end

    def type_of element
      Prickle::TAGS[element.to_sym] || element
    end

    def handle_exception &block
      begin
        block.call
      rescue Exception => e
        raise Capybara::ElementNotFound.new(@type, @identifier, @text, e) if e.class.to_s == "Capybara::ElementNotFound"
        raise
      end
    end
  end
end
