module Prickle
  module Actions
    module Match

      def element type=:*, name
        @name = name
        @type = Prickle::TAGS[type] || type.to_s
        self
      end

      def contains_text? text
        find(:xpath, "//#{@type}[@name='#{@name}' and contains(text(), '#{text}')]")
      end

      def element_contains_text? name, text
        @name = name; @type= '*'
        contains_text? text
      end

      def method_missing method, *args
        if method =~ /(^.*)_contains_text\?$/
          element = Prickle::TAGS[$1.to_sym] || $1
          find(:xpath, "//#{element}[@name='#{args.first}' and contains(text(),'#{args[1]}')]")
        else
          super
        end
      end
    end
  end
end
