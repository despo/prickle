module Prickle
  module Actions
    module Match

      def contains_text? text
        find_element_by_name_and_text(@type, @name,text)
      end

      def element_contains_text? name, text
        @name = name; @type= '*'
        contains_text? text
      end

      def method_missing method, *args
        if method =~ /(^.*)_contains_text\?$/
          find_element_by_name_and_text($1, args.first, args[1])
        else
          super
        end
      end

      private
      def find_by_name_and_text_xpath element, name, text
        "//#{type_for(element)}[@name='#{name}' and contains(text(), '#{text}')]"
      end

      def find_element_by_name_and_text element, name, text
        find_element_by(find_by_name_and_text_xpath(element, name, text))
      end
    end

  end
end
