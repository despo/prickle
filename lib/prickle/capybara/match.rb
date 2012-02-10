module Prickle
  module Actions
    module Match

      def contains_text? text
        find_element_by_name_and_text(@type, @identifier, text)
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
    end

  end
end
