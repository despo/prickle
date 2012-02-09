module Prickle
  module Actions
    module Match

      def element type='*', name
        @name = name
        @type = type
        self
      end

      def contains_text? text
        wait_until(Prickle::Capybara.wait_time) do
          find_element_by_name_and_text(@type, @name,text).visible?
        end unless Prickle::Capybara.wait_time.nil?

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
      def find_element_by_name_and_text element_type, name, text
        element = Prickle::TAGS[element_type.to_sym] || element_type.to_s
        find(:xpath, "//#{element}[@name='#{name}' and contains(text(), '#{text}')]")
      end
    end
  end
end
