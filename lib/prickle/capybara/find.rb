module Prickle
  module Actions
    module Find

      def find_by_name name
        find(:xpath, "//*[@name='#{name}']")
      end

      def method_missing method, *args
        if method =~ /^find_(.*)_by_name$/
          element = Prickle::TAGS[$1.to_sym] || $1
          find(:xpath, "//#{element}[@name='#{args.first}']")
        else
          super
        end
      end

    end
  end
end
