module Prickle
  module Actions
    module Find

      def find_by_name name
        find(:xpath, "//*[@name='#{name}']")
      end

      def element_contains_text? name, text
        find(:xpath, "//*[@name='#{name}' and contains(text(), '#{text}')]")
      end

      def method_missing method, *args
        if method =~ /^find_(.*)_by_name$/
          element = Prickle::TAGS[$1.to_sym] || $1
          find(:xpath, "//#{element}[@name='#{args.first}']")
        elsif method =~ /(^.*)_contains_text\?$/
          element = Prickle::TAGS[$1.to_sym] || $1
          find(:xpath, "//#{element}[@name='#{args.first}' and contains(text(),'#{text}')]")
        else
          super
        end
      end

    end
  end
end
