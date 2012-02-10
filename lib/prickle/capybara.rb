require_relative 'capybara/find'
require_relative 'capybara/click'
require_relative 'capybara/match'

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

    def matcher identifier
      matcher = []
      identifier.each_pair do |key, value|
        matcher << " and " unless matcher.empty?
        matcher << "@#{key}='#{value}'"
      end
      matcher.join ''
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

  end
end
