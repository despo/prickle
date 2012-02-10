module Prickle
  module Actions
    module Match

      def contains_text? text
        begin
          find_element_by_name_and_text(@type, @identifier, text)
        rescue Exception => e
          raise Capybara::ElementNotFound.new(not_found_message(@type, @identifier, text)) if e.message.include? find_by_name_and_text_xpath(@type, @identifier, text)
          raise
        end
      end

      def method_missing method, *args
        if method =~ /(^.*)_contains_text\?$/
          find_element_by_name_and_text($1,  { :name => args.first } , args[1])
        else
          super
        end
      end

      private

      def find_by_name_and_text_xpath element, identifier, text
        "//#{type_of(element)}[#{matcher(identifier)} and contains(text(), '#{text}')]"
      end

      def find_element_by_name_and_text element, name, text
        find_element_by(find_by_name_and_text_xpath(element, name, text))
      end

      def not_found_message type, identifier, text
        "Element #{type unless type == "*"}with properties \e[1m#{identifier.to_a}\e[0m\e[31m and text \e[1m#{text}\e[0m\e[31m was not be found."
      end
    end
  end
end
